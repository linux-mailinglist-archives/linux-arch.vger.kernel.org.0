Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7659439CA2A
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFERSS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 13:18:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:59473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhFERSR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 13:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622913309;
        bh=n09vl0Qi955c0FFlwEbTMm5JhNR/MCo9V3zzQRkL+oI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TVdFfiFbg6tNuSDK1EnSO4mtTbjz/F9xIVSzvk/yY7yzGgvx9eMQz4wmWpjFfmlhK
         Jz9snPAupOyOiIthsnxojbscFpimdIQkMq5ByPxLBIAPcbbBYSpAcDGw7caObxAtNI
         XtbJtApZyAoc+AeO6HWOKZ8FPNW7NZkoS0b62l7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mw9QC-1lZ10S3Npc-00s4aG; Sat, 05 Jun 2021 19:15:09 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     John Wood <john.wood@gmx.com>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v8 6/8] selftests/brute: Add tests for the Brute LSM
Date:   Sat,  5 Jun 2021 17:04:03 +0200
Message-Id: <20210605150405.6936-7-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DtjoHAETHk4xGDZFpK9+7KXukSk5D6Su3506SD5xQyJNEHT/Msb
 C0+ipAxxT7EQtxPug3EGTNT471AZFtU/nhXAh+9Yukyj9xcB8SpKZltr4aP+gZPYcVLeLAN
 CJedZwSGUe2aDoI2xezzqGdkhrQFMo0ySy+FMobwT9nedex2ek0koSOQEV5XwNg1lstNQf9
 gQGj17Dc2mchjJPJ48grw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dUgzQiRyfpU=:LrUUAWdlWwsuT+lDThaKc4
 vc6YBl8vTgX5Q3t10Q/NQGh3aRFvOj2hKbGu/AZ7m4kn3vHwQvWpQypUcod08Fl1wu5w+TLgK
 ISzWAp9a18UcRrGV1kPKe/KIQVKf7Kg5OCh6jYRHnVRuM2R20pCoytlV2C/hUQTpa0frPoxSf
 QKlupC+srZIGTD799PhxEfDtQ49KgJhjpKYzwMHDykTOdQrcXJtPXA2wHTH8I3GUanF6cgvJQ
 eKot2StW8eQ2b4spdLn72BBcWwMrjO+frA5unN9PkNX3ld9jlLTkZnHvIhFHsm88Cza8Ul/QG
 xL4eSnRO6q6j5RGiZzgmiyGnSovx4lP4IR0BWQJNGV9+0SLHPQ67IkYYVZ1QEA1wxYrx+PYPO
 cqpluXnN8nVDOr+tyhr3hp5s5/YjuVoHLD6VtxwBBIDbuZXIx+wuLMC5Cpy/mwIJfTNEMCYwk
 DJwCGzHL756OgwgZRGRCvRZ65ShUs6GoNJ9JdUZPcIxm/Iv3BNvo6jkScEJCUEGHxEDMkKxOn
 qlIb0vZ4smzx5gbsKA2789AztAmUsIsw6NAZHqECtARFxbbXIVHTVL18HieJDWYLtUvgMt39Q
 XZ5smKfL8WR9Gi/8cF1usL/sEOItdmm/n490sjoG2i+QsWxdBD7dccqIKb5B2aqs9B60Yli+Q
 9SMG4x6EAVahGh3FGZwgfC3fVHt5xDralZMvnB1GU+7xyXRTnruFJJLGr7WrXD8PMNbSNsJj7
 b3C/NSRA+KYGDIZCJcBpXrGCm5mHe3z5wW4ZVti3kQe8PHJHsNNY7PcbTrcC+OieotJBJc/2s
 Be/GkgrJChFrd+ZD68tLsl0B3pX9Z1UogeVTzSKUlHaED1wuBY8dq4UZPGwieDMERgO1QhL96
 ggttYik8nqSbiYR/29Ih6qDIpyGlgbAQTExN/2n9TDk95l6SHnAGo98PkRDKWfoPrdYuteD2n
 WWZONe9XCsL+Bmsb9hunvr5B6z1MPAot0sYC2c0tSt68UFeQYbFxBj7Etcz7QwieZ6k7OsdJG
 NgT3M5cTamzxAUz7ELwYe0UDidYH0I+6lS4Rh+wqW8HhCtF7+vVuFSITzZACxzdkhFnf5nYlS
 fvtDDGhx+raVB0no97W8jNWnfQmPIXFG6iB
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add tests to check the Brute LSM functionality and cover fork/exec brute
force attacks crossing the following privilege boundaries:

1.- setuid process
2.- privilege changes
3.- network to local

Also, as a first step check that fork/exec brute force attacks without
crossing any privilege boundary already commented doesn't trigger the
detection and mitigation stage.

Moreover, test if the userspace notification, via "waitid" system call,
is sent when an attack is mitigated (to inform that all the offending
tasks involved in the attack have been killed by Brute LSM).

Once a brute force attack is detected, the "test" executable is marked
as "not allowed". To start again a new test, use the "rmxattr" app to
revert this state. This way, all the tests can be run using the same
binary.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/brute/.gitignore |   3 +
 tools/testing/selftests/brute/Makefile   |   5 +
 tools/testing/selftests/brute/config     |   1 +
 tools/testing/selftests/brute/exec.c     |  46 ++
 tools/testing/selftests/brute/rmxattr.c  |  34 ++
 tools/testing/selftests/brute/test.c     | 507 +++++++++++++++++++++++
 tools/testing/selftests/brute/test.sh    | 269 ++++++++++++
 8 files changed, 866 insertions(+)
 create mode 100644 tools/testing/selftests/brute/.gitignore
 create mode 100644 tools/testing/selftests/brute/Makefile
 create mode 100644 tools/testing/selftests/brute/config
 create mode 100644 tools/testing/selftests/brute/exec.c
 create mode 100644 tools/testing/selftests/brute/rmxattr.c
 create mode 100644 tools/testing/selftests/brute/test.c
 create mode 100755 tools/testing/selftests/brute/test.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Ma=
kefile
index bc3299a20338..5c413a010849 100644
=2D-- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -2,6 +2,7 @@
 TARGETS =3D arm64
 TARGETS +=3D bpf
 TARGETS +=3D breakpoints
+TARGETS +=3D brute
 TARGETS +=3D capabilities
 TARGETS +=3D cgroup
 TARGETS +=3D clone3
diff --git a/tools/testing/selftests/brute/.gitignore b/tools/testing/self=
tests/brute/.gitignore
new file mode 100644
index 000000000000..a02aa79249a1
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/.gitignore
@@ -0,0 +1,3 @@
+exec
+rmxattr
+test
diff --git a/tools/testing/selftests/brute/Makefile b/tools/testing/selfte=
sts/brute/Makefile
new file mode 100644
index 000000000000..3975338c1ecc
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS +=3D -Wall -O2
+TEST_PROGS :=3D test.sh
+TEST_GEN_FILES :=3D exec rmxattr test
+include ../lib.mk
diff --git a/tools/testing/selftests/brute/config b/tools/testing/selftest=
s/brute/config
new file mode 100644
index 000000000000..3587b7bf6c23
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/config
@@ -0,0 +1 @@
+CONFIG_SECURITY_FORK_BRUTE=3Dy
diff --git a/tools/testing/selftests/brute/exec.c b/tools/testing/selftest=
s/brute/exec.c
new file mode 100644
index 000000000000..a7fc5705f97c
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/exec.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static __attribute__((noreturn)) void error_failure(const char *message)
+{
+	perror(message);
+	exit(EXIT_FAILURE);
+}
+
+#define PROG_NAME basename(argv[0])
+#define CLD_BRUTE	7	/* child was killed by brute LSM */
+
+int main(int argc, char **argv)
+{
+	pid_t pid;
+	int rc;
+	siginfo_t siginfo;
+
+	if (argc < 2) {
+		printf("Usage: %s <EXECUTABLE>\n", PROG_NAME);
+		exit(EXIT_FAILURE);
+	}
+
+	pid =3D fork();
+	if (pid < 0)
+		error_failure("fork");
+
+	/* Child process */
+	if (!pid) {
+		execve(argv[1], &argv[1], NULL);
+		error_failure("execve");
+	}
+
+	/* Parent process */
+	rc =3D waitid(P_PID, pid, &siginfo, WEXITED);
+	if (rc)
+		error_failure("waitid");
+
+	return siginfo.si_code !=3D CLD_BRUTE;
+}
diff --git a/tools/testing/selftests/brute/rmxattr.c b/tools/testing/selft=
ests/brute/rmxattr.c
new file mode 100644
index 000000000000..9ed90409d337
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/rmxattr.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/xattr.h>
+
+static __attribute__((noreturn)) void error_failure(const char *message)
+{
+	perror(message);
+	exit(EXIT_FAILURE);
+}
+
+#define PROG_NAME basename(argv[0])
+
+#define XATTR_SECURITY_PREFIX "security."
+#define XATTR_BRUTE_SUFFIX "brute"
+#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX
+
+int main(int argc, char **argv)
+{
+	int rc;
+
+	if (argc < 2) {
+		printf("Usage: %s <FILE>\n", PROG_NAME);
+		exit(EXIT_FAILURE);
+	}
+
+	rc =3D removexattr(argv[1], XATTR_NAME_BRUTE);
+	if (rc)
+		error_failure("removexattr");
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/brute/test.c b/tools/testing/selftest=
s/brute/test.c
new file mode 100644
index 000000000000..44c32f446dca
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/test.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <libgen.h>
+#include <pwd.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static const char *message =3D "message";
+
+enum mode {
+	MODE_NONE,
+	MODE_CRASH,
+	MODE_SERVER_CRASH,
+	MODE_CLIENT,
+};
+
+enum crash_after {
+	CRASH_AFTER_NONE,
+	CRASH_AFTER_FORK,
+	CRASH_AFTER_EXEC,
+};
+
+enum signal_from {
+	SIGNAL_FROM_NONE,
+	SIGNAL_FROM_USER,
+	SIGNAL_FROM_KERNEL,
+};
+
+struct args {
+	uint32_t ip;
+	uint16_t port;
+	int counter;
+	long timeout;
+	enum mode mode;
+	enum crash_after crash_after;
+	enum signal_from signal_from;
+	unsigned char has_counter : 1;
+	unsigned char has_change_priv : 1;
+	unsigned char has_ip : 1;
+	unsigned char has_port : 1;
+	unsigned char has_timeout : 1;
+};
+
+#define OPT_STRING "hm:c:s:n:Ca:p:t:"
+
+static void usage(const char *prog)
+{
+	printf("Usage: %s <OPTIONS>\n", prog);
+	printf("OPTIONS:\n");
+	printf("  -h: Show this help and exit. Optional.\n");
+	printf("  -m (crash | server_crash | client): Mode. Required.\n");
+	printf("Options for crash mode:\n");
+	printf("  -c (fork | exec): Crash after. Optional.\n");
+	printf("  -s (user | kernel): Signal from. Required.\n");
+	printf("  -n counter: Number of crashes.\n");
+	printf("              Required if the option -c is used.\n");
+	printf("              Not used without the option -c.\n");
+	printf("              Range from 1 to INT_MAX.\n");
+	printf("  -C: Change privileges before crash. Optional.\n");
+	printf("Options for server_crash mode:\n");
+	printf("  -a ip: Ip v4 address to accept. Required.\n");
+	printf("  -p port: Port number. Required.\n");
+	printf("           Range from 1 to UINT16_MAX.\n");
+	printf("  -t secs: Accept timeout. Required.\n");
+	printf("           Range from 1 to LONG_MAX.\n");
+	printf("  -c (fork | exec): Crash after. Required.\n");
+	printf("  -s (user | kernel): Signal from. Required.\n");
+	printf("  -n counter: Number of crashes. Required.\n");
+	printf("              Range from 1 to INT_MAX.\n");
+	printf("Options for client mode:\n");
+	printf("  -a ip: Ip v4 address to connect. Required.\n");
+	printf("  -p port: Port number. Required.\n");
+	printf("           Range from 1 to UINT16_MAX.\n");
+	printf("  -t secs: Connect timeout. Required.\n");
+	printf("           Range from 1 to LONG_MAX.\n");
+}
+
+static __attribute__((noreturn)) void info_failure(const char *message,
+						   const char *prog)
+{
+	printf("%s\n", message);
+	usage(prog);
+	exit(EXIT_FAILURE);
+}
+
+static enum mode get_mode(const char *text, const char *prog)
+{
+	if (!strcmp(text, "crash"))
+		return MODE_CRASH;
+
+	if (!strcmp(text, "server_crash"))
+		return MODE_SERVER_CRASH;
+
+	if (!strcmp(text, "client"))
+		return MODE_CLIENT;
+
+	info_failure("Invalid mode option [-m].", prog);
+}
+
+static enum crash_after get_crash_after(const char *text, const char *pro=
g)
+{
+	if (!strcmp(text, "fork"))
+		return CRASH_AFTER_FORK;
+
+	if (!strcmp(text, "exec"))
+		return CRASH_AFTER_EXEC;
+
+	info_failure("Invalid crash after option [-c].", prog);
+}
+
+static enum signal_from get_signal_from(const char *text, const char *pro=
g)
+{
+	if (!strcmp(text, "user"))
+		return SIGNAL_FROM_USER;
+
+	if (!strcmp(text, "kernel"))
+		return SIGNAL_FROM_KERNEL;
+
+	info_failure("Invalid signal from option [-s]", prog);
+}
+
+static int get_counter(const char *text, const char *prog)
+{
+	int counter;
+
+	counter =3D atoi(text);
+	if (counter > 0)
+		return counter;
+
+	info_failure("Invalid counter option [-n].", prog);
+}
+
+static __attribute__((noreturn)) void error_failure(const char *message)
+{
+	perror(message);
+	exit(EXIT_FAILURE);
+}
+
+static uint32_t get_ip(const char *text, const char *prog)
+{
+	int ret;
+	uint32_t ip;
+
+	ret =3D inet_pton(AF_INET, text, &ip);
+	if (!ret)
+		info_failure("Invalid ip option [-a].", prog);
+	else if (ret < 0)
+		error_failure("inet_pton");
+
+	return ip;
+}
+
+static uint16_t get_port(const char *text, const char *prog)
+{
+	long port;
+
+	port =3D atol(text);
+	if ((port > 0) && (port <=3D UINT16_MAX))
+		return htons(port);
+
+	info_failure("Invalid port option [-p].", prog);
+}
+
+static long get_timeout(const char *text, const char *prog)
+{
+	long timeout;
+
+	timeout =3D atol(text);
+	if (timeout > 0)
+		return timeout;
+
+	info_failure("Invalid timeout option [-t].", prog);
+}
+
+static void check_args(const struct args *args, const char *prog)
+{
+	if (args->mode =3D=3D MODE_CRASH && args->crash_after !=3D CRASH_AFTER_N=
ONE &&
+	    args->signal_from !=3D SIGNAL_FROM_NONE && args->has_counter &&
+	    !args->has_ip && !args->has_port && !args->has_timeout)
+		return;
+
+	if (args->mode =3D=3D MODE_CRASH && args->signal_from !=3D SIGNAL_FROM_N=
ONE &&
+	    args->crash_after =3D=3D CRASH_AFTER_NONE && !args->has_counter &&
+	    !args->has_ip && !args->has_port && !args->has_timeout)
+		return;
+
+	if (args->mode =3D=3D MODE_SERVER_CRASH && args->has_ip && args->has_por=
t &&
+	    args->has_timeout && args->crash_after !=3D CRASH_AFTER_NONE &&
+	    args->signal_from !=3D SIGNAL_FROM_NONE && args->has_counter &&
+	    !args->has_change_priv)
+		return;
+
+	if (args->mode =3D=3D MODE_CLIENT && args->has_ip && args->has_port &&
+	    args->has_timeout && args->crash_after =3D=3D CRASH_AFTER_NONE &&
+	    args->signal_from =3D=3D SIGNAL_FROM_NONE && !args->has_counter &&
+	    !args->has_change_priv)
+		return;
+
+	info_failure("Invalid use of options.", prog);
+}
+
+static uid_t get_non_root_uid(void)
+{
+	struct passwd *pwent;
+	uid_t uid;
+
+	while (true) {
+		errno =3D 0;
+		pwent =3D getpwent();
+		if (!pwent) {
+			if (errno) {
+				perror("getpwent");
+				endpwent();
+				exit(EXIT_FAILURE);
+			}
+			break;
+		}
+
+		if (pwent->pw_uid) {
+			uid =3D pwent->pw_uid;
+			endpwent();
+			return uid;
+		}
+	}
+
+	endpwent();
+	printf("A user different of root is needed.\n");
+	exit(EXIT_FAILURE);
+}
+
+static inline void do_sigsegv(void)
+{
+	int *p =3D NULL;
+	*p =3D 0;
+}
+
+static void do_sigkill(void)
+{
+	int ret;
+
+	ret =3D kill(getpid(), SIGKILL);
+	if (ret)
+		error_failure("kill");
+}
+
+static void crash(enum signal_from signal_from, bool change_priv)
+{
+	int ret;
+
+	if (change_priv) {
+		ret =3D setuid(get_non_root_uid());
+		if (ret)
+			error_failure("setuid");
+	}
+
+	if (signal_from =3D=3D SIGNAL_FROM_KERNEL)
+		do_sigsegv();
+
+	do_sigkill();
+}
+
+static void execve_crash(char *const argv[])
+{
+	execve(argv[0], argv, NULL);
+	error_failure("execve");
+}
+
+static void exec_crash_user(void)
+{
+	char *const argv[] =3D {
+		"./test", "-m", "crash", "-s", "user", NULL,
+	};
+
+	execve_crash(argv);
+}
+
+static void exec_crash_user_change_priv(void)
+{
+	char *const argv[] =3D {
+		"./test", "-m", "crash", "-s", "user", "-C", NULL,
+	};
+
+	execve_crash(argv);
+}
+
+static void exec_crash_kernel(void)
+{
+	char *const argv[] =3D {
+		"./test", "-m", "crash", "-s", "kernel", NULL,
+	};
+
+	execve_crash(argv);
+}
+
+static void exec_crash_kernel_change_priv(void)
+{
+	char *const argv[] =3D {
+		"./test", "-m", "crash", "-s", "kernel", "-C", NULL,
+	};
+
+	execve_crash(argv);
+}
+
+static void exec_crash(enum signal_from signal_from, bool change_priv)
+{
+	if (signal_from =3D=3D SIGNAL_FROM_USER && !change_priv)
+		exec_crash_user();
+	if (signal_from =3D=3D SIGNAL_FROM_USER && change_priv)
+		exec_crash_user_change_priv();
+	if (signal_from =3D=3D SIGNAL_FROM_KERNEL && !change_priv)
+		exec_crash_kernel();
+	if (signal_from =3D=3D SIGNAL_FROM_KERNEL && change_priv)
+		exec_crash_kernel_change_priv();
+}
+
+static void do_crash(enum crash_after crash_after, enum signal_from signa=
l_from,
+		     int counter, bool change_priv)
+{
+	pid_t pid;
+	int status;
+
+	if (crash_after =3D=3D CRASH_AFTER_NONE)
+		crash(signal_from, change_priv);
+
+	while (counter > 0) {
+		pid =3D fork();
+		if (pid < 0)
+			error_failure("fork");
+
+		/* Child process */
+		if (!pid) {
+			if (crash_after =3D=3D CRASH_AFTER_FORK)
+				crash(signal_from, change_priv);
+
+			exec_crash(signal_from, change_priv);
+		}
+
+		/* Parent process */
+		counter -=3D 1;
+		pid =3D waitpid(pid, &status, 0);
+		if (pid < 0)
+			error_failure("waitpid");
+	}
+}
+
+static __attribute__((noreturn)) void error_close_failure(const char *mes=
sage,
+							  int fd)
+{
+	perror(message);
+	close(fd);
+	exit(EXIT_FAILURE);
+}
+
+static void do_server(uint32_t ip, uint16_t port, long accept_timeout)
+{
+	int sockfd;
+	int ret;
+	struct sockaddr_in address;
+	struct timeval timeout;
+	int newsockfd;
+
+	sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0)
+		error_failure("socket");
+
+	address.sin_family =3D AF_INET;
+	address.sin_addr.s_addr =3D ip;
+	address.sin_port =3D port;
+
+	ret =3D bind(sockfd, (const struct sockaddr *)&address, sizeof(address))=
;
+	if (ret)
+		error_close_failure("bind", sockfd);
+
+	ret =3D listen(sockfd, 1);
+	if (ret)
+		error_close_failure("listen", sockfd);
+
+	timeout.tv_sec =3D accept_timeout;
+	timeout.tv_usec =3D 0;
+	ret =3D setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO,
+			 (const struct timeval *)&timeout, sizeof(timeout));
+	if (ret)
+		error_close_failure("setsockopt", sockfd);
+
+	newsockfd =3D accept(sockfd, NULL, NULL);
+	if (newsockfd < 0)
+		error_close_failure("accept", sockfd);
+
+	close(sockfd);
+	close(newsockfd);
+}
+
+static void do_client(uint32_t ip, uint16_t port, long connect_timeout)
+{
+	int sockfd;
+	int ret;
+	struct timeval timeout;
+	struct sockaddr_in address;
+
+	sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0)
+		error_failure("socket");
+
+	timeout.tv_sec =3D connect_timeout;
+	timeout.tv_usec =3D 0;
+	ret =3D setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO,
+			 (const struct timeval *)&timeout, sizeof(timeout));
+	if (ret)
+		error_close_failure("setsockopt", sockfd);
+
+	address.sin_family =3D AF_INET;
+	address.sin_addr.s_addr =3D ip;
+	address.sin_port =3D port;
+
+	ret =3D connect(sockfd, (const struct sockaddr *)&address,
+		      sizeof(address));
+	if (ret)
+		error_close_failure("connect", sockfd);
+
+	ret =3D write(sockfd, message, strlen(message));
+	if (ret < 0)
+		error_close_failure("write", sockfd);
+
+	close(sockfd);
+}
+
+#define PROG_NAME basename(argv[0])
+
+int main(int argc, char **argv)
+{
+	int opt;
+	struct args args =3D {
+		.mode =3D MODE_NONE,
+		.crash_after =3D CRASH_AFTER_NONE,
+		.signal_from =3D SIGNAL_FROM_NONE,
+		.has_counter =3D false,
+		.has_change_priv =3D false,
+		.has_ip =3D false,
+		.has_port =3D false,
+		.has_timeout =3D false,
+	};
+
+	while ((opt =3D getopt(argc, argv, OPT_STRING)) !=3D -1) {
+		switch (opt) {
+		case 'h':
+			usage(PROG_NAME);
+			return EXIT_SUCCESS;
+		case 'm':
+			args.mode =3D get_mode(optarg, PROG_NAME);
+			break;
+		case 'c':
+			args.crash_after =3D get_crash_after(optarg, PROG_NAME);
+			break;
+		case 's':
+			args.signal_from =3D get_signal_from(optarg, PROG_NAME);
+			break;
+		case 'n':
+			args.counter =3D get_counter(optarg, PROG_NAME);
+			args.has_counter =3D true;
+			break;
+		case 'C':
+			args.has_change_priv =3D true;
+			break;
+		case 'a':
+			args.ip =3D get_ip(optarg, PROG_NAME);
+			args.has_ip =3D true;
+			break;
+		case 'p':
+			args.port =3D get_port(optarg, PROG_NAME);
+			args.has_port =3D true;
+			break;
+		case 't':
+			args.timeout =3D get_timeout(optarg, PROG_NAME);
+			args.has_timeout =3D true;
+			break;
+		default:
+			usage(PROG_NAME);
+			return EXIT_FAILURE;
+		}
+	}
+
+	check_args(&args, PROG_NAME);
+
+	if (args.mode =3D=3D MODE_CRASH) {
+		do_crash(args.crash_after, args.signal_from, args.counter,
+			 args.has_change_priv);
+	} else if (args.mode =3D=3D MODE_SERVER_CRASH) {
+		do_server(args.ip, args.port, args.timeout);
+		do_crash(args.crash_after, args.signal_from, args.counter,
+			 false);
+	} else if (args.mode =3D=3D MODE_CLIENT) {
+		do_client(args.ip, args.port, args.timeout);
+	}
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/brute/test.sh b/tools/testing/selftes=
ts/brute/test.sh
new file mode 100755
index 000000000000..393b651ab635
=2D-- /dev/null
+++ b/tools/testing/selftests/brute/test.sh
@@ -0,0 +1,269 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+TCID=3D"test.sh"
+
+KSFT_PASS=3D0
+KSFT_FAIL=3D1
+KSFT_SKIP=3D4
+
+errno=3D$KSFT_PASS
+
+check_root()
+{
+	local uid=3D$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo $TCID: must be run as root >&2
+		exit $KSFT_SKIP
+	fi
+}
+
+tmp_files_setup()
+{
+	DMESG=3D$(mktemp --tmpdir -t brute-dmesg-XXXXXX)
+}
+
+tmp_files_cleanup()
+{
+	rm -f "$DMESG"
+}
+
+save_dmesg()
+{
+	dmesg > "$DMESG"
+}
+
+count_attack_matches()
+{
+	dmesg | comm --nocheck-order -13 "$DMESG" - | \
+		grep "brute: fork brute force attack detected" | wc -l
+}
+
+assert_equal()
+{
+	local val1=3D$1
+	local val2=3D$2
+
+	if [ $val1 -eq $val2 ]; then
+		echo "$TCID: $message [PASS]"
+	else
+		echo "$TCID: $message [FAIL]"
+		errno=3D$KSFT_FAIL
+	fi
+}
+
+test_fork_user()
+{
+	COUNTER=3D20
+
+	save_dmesg
+	./test -m crash -c fork -s user -n $COUNTER
+	count=3D$(count_attack_matches)
+
+	message=3D"fork attack (user signals, no bounds crossed)"
+	assert_equal $count 0
+}
+
+test_fork_kernel()
+{
+	save_dmesg
+	./test -m crash -c fork -s kernel -n $COUNTER
+	count=3D$(count_attack_matches)
+
+	message=3D"fork attack (kernel signals, no bounds crossed)"
+	assert_equal $count 0
+}
+
+test_exec_user()
+{
+	save_dmesg
+	./test -m crash -c exec -s user -n $COUNTER
+	count=3D$(count_attack_matches)
+
+	message=3D"exec attack (user signals, no bounds crossed)"
+	assert_equal $count 0
+}
+
+test_exec_kernel()
+{
+	save_dmesg
+	./test -m crash -c exec -s kernel -n $COUNTER
+	count=3D$(count_attack_matches)
+
+	message=3D"exec attack (kernel signals, no bounds crossed)"
+	assert_equal $count 0
+}
+
+assert_not_equal()
+{
+	local val1=3D$1
+	local val2=3D$2
+
+	if [ $val1 -ne $val2 ]; then
+		echo $TCID: $message [PASS]
+	else
+		echo $TCID: $message [FAIL]
+		errno=3D$KSFT_FAIL
+	fi
+}
+
+remove_xattr()
+{
+	./rmxattr test >/dev/null 2>&1
+}
+
+test_fork_kernel_setuid()
+{
+	save_dmesg
+	chmod u+s test
+	./test -m crash -c fork -s kernel -n $COUNTER
+	chmod u-s test
+	count=3D$(count_attack_matches)
+
+	message=3D"fork attack (kernel signals, setuid binary)"
+	assert_not_equal $count 0
+	remove_xattr
+}
+
+test_exec_kernel_setuid()
+{
+	save_dmesg
+	chmod u+s test
+	./test -m crash -c exec -s kernel -n $COUNTER
+	chmod u-s test
+	count=3D$(count_attack_matches)
+
+	message=3D"exec attack (kernel signals, setuid binary)"
+	assert_not_equal $count 0
+	remove_xattr
+}
+
+test_fork_kernel_change_priv()
+{
+	save_dmesg
+	./test -m crash -c fork -s kernel -n $COUNTER -C
+	count=3D$(count_attack_matches)
+
+	message=3D"fork attack (kernel signals, change privileges)"
+	assert_not_equal $count 0
+	remove_xattr
+}
+
+test_exec_kernel_change_priv()
+{
+	save_dmesg
+	./test -m crash -c exec -s kernel -n $COUNTER -C
+	count=3D$(count_attack_matches)
+
+	message=3D"exec attack (kernel signals, change privileges)"
+	assert_not_equal $count 0
+	remove_xattr
+}
+
+network_ns_setup()
+{
+	local vnet_name=3D$1
+	local veth_name=3D$2
+	local ip_src=3D$3
+	local ip_dst=3D$4
+
+	ip netns add $vnet_name
+	ip link set $veth_name netns $vnet_name
+	ip -n $vnet_name addr add $ip_src/24 dev $veth_name
+	ip -n $vnet_name link set $veth_name up
+	ip -n $vnet_name route add $ip_dst/24 dev $veth_name
+}
+
+network_setup()
+{
+	VETH0_NAME=3Dveth0
+	VNET0_NAME=3Dvnet0
+	VNET0_IP=3D10.0.1.0
+	VETH1_NAME=3Dveth1
+	VNET1_NAME=3Dvnet1
+	VNET1_IP=3D10.0.2.0
+
+	ip link add $VETH0_NAME type veth peer name $VETH1_NAME
+	network_ns_setup $VNET0_NAME $VETH0_NAME $VNET0_IP $VNET1_IP
+	network_ns_setup $VNET1_NAME $VETH1_NAME $VNET1_IP $VNET0_IP
+}
+
+test_fork_kernel_network_to_local()
+{
+	INADDR_ANY=3D0.0.0.0
+	PORT=3D65535
+	TIMEOUT=3D5
+
+	save_dmesg
+	ip netns exec $VNET0_NAME ./test -m server_crash -a $INADDR_ANY \
+		-p $PORT -t $TIMEOUT -c fork -s kernel -n $COUNTER &
+	sleep 1
+	ip netns exec $VNET1_NAME ./test -m client -a $VNET0_IP -p $PORT \
+		-t $TIMEOUT
+	sleep 1
+	count=3D$(count_attack_matches)
+
+	message=3D"fork attack (kernel signals, network to local)"
+	assert_not_equal $count 0
+	remove_xattr
+}
+
+test_exec_kernel_network_to_local()
+{
+	save_dmesg
+	ip netns exec $VNET0_NAME ./test -m server_crash -a $INADDR_ANY \
+		-p $PORT -t $TIMEOUT -c exec -s kernel -n $COUNTER &
+	sleep 1
+	ip netns exec $VNET1_NAME ./test -m client -a $VNET0_IP -p $PORT \
+		-t $TIMEOUT
+	sleep 1
+	count=3D$(count_attack_matches)
+
+	message=3D"exec attack (kernel signals, network to local)"
+	assert_not_equal $count 0
+	remove_xattr
+}
+
+network_cleanup()
+{
+	ip netns del $VNET0_NAME >/dev/null 2>&1
+	ip netns del $VNET1_NAME >/dev/null 2>&1
+	ip link delete $VETH0_NAME >/dev/null 2>&1
+	ip link delete $VETH1_NAME >/dev/null 2>&1
+}
+
+test_waitid()
+{
+	./exec test -m crash -c fork -s kernel -n $COUNTER -C
+	local rc=3D$?
+
+	message=3D"notification to userspace via waitid system call"
+	assert_equal $rc 0
+	remove_xattr
+}
+
+cleanup()
+{
+        network_cleanup
+	tmp_files_cleanup
+	chmod u-s test
+	remove_xattr
+}
+trap cleanup EXIT
+
+check_root
+tmp_files_setup
+test_fork_user
+test_fork_kernel
+test_exec_user
+test_exec_kernel
+test_fork_kernel_setuid
+test_exec_kernel_setuid
+test_fork_kernel_change_priv
+test_exec_kernel_change_priv
+network_setup
+test_fork_kernel_network_to_local
+test_exec_kernel_network_to_local
+network_cleanup
+test_waitid
+exit $errno
=2D-
2.25.1

