Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4346D2FC8E2
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbhATD15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbhATCaX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:30:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5880BC0613C1;
        Tue, 19 Jan 2021 18:29:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t29so8447277pfg.11;
        Tue, 19 Jan 2021 18:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCpDSQe/XKc1ojPEmz/1by6hsv0ZTrDTgtpMzYyNNVw=;
        b=cplpZ5BMiQhkQnwLSaionz/37q3iOBDQTKhxXv65blq5f4iWfX2y8rBLg/WPVoKjk3
         SXCTEvRvuXOUmg03LQnf6FA4uflIfPbe3ZjHFmUZ7XHnW1DYc19C0cKj90mEcpMXVTIx
         5CiFeXqfwCA9CqgjJX0w0CIZTpxQFr4bZkukAJte6wvWDL9s2QqBJ6yAZ0uYwMU+cdG6
         8cDBvDeRKtjgNM20BoUpzI7Yjv2P9mT+Wf8JPNIMv6CHAbkToKBw6tH2EQecB3U80s7l
         +ssUKwh+8D7qkHrW9WgpHDi1EGIpnxf/1Rovwetmkr3ED95F87gCDDyozFyn6z6pl8Ig
         WEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCpDSQe/XKc1ojPEmz/1by6hsv0ZTrDTgtpMzYyNNVw=;
        b=EvR8VSPNWcPZyJ/1UhRD4MLcDRCtf3xOMZFkLuoqM7MAmkmpDwqmtu4ue1MrMk9Xi+
         S5So0SoXm1Nzcy4530zW5gJoTxe63YJWT55IXyWm6E9/ZZHpAHSx/8y1PAHp53wGlDtM
         t0rYk+zYRHTL/gKSFppTQ5MmaQZ6gw88ro3XYBkI64U5IIfcc7q8MhIQ3KrwRPFQ2QGo
         vWZ5km0F7Go75FhkyPdtAjb0gNPn3mA60RMWoieYdTiYhOCW4N3f1c+94WRQmIu0IxqN
         ynxcBemTVpsa9UVJO8AhwmkZNavi9owjW9TxQeTVDjgxx6WmFnPTPXuo1xywx2ZE+Hx5
         mUQQ==
X-Gm-Message-State: AOAM532rhR7RIpLDb85yE/pK+jr6l8uTsO2G+W0tCwHqhuaCdynygOyL
        lTyB6tGJ5XXAATIwtl4t9as=
X-Google-Smtp-Source: ABdhPJxkeysv1f2jrCclzQnuXzmTFg3EKohte2/skCog17TdbZ2HbMP+sJYRyIIjvDtc3i6eMEBgEw==
X-Received: by 2002:a62:8382:0:b029:1ba:eb55:aa2c with SMTP id h124-20020a6283820000b02901baeb55aa2cmr575971pfe.43.1611109782632;
        Tue, 19 Jan 2021 18:29:42 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id gt21sm257036pjb.56.2021.01.19.18.29.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:29:42 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 06F0420442D414; Wed, 20 Jan 2021 11:29:40 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC v8 18/20] selftests/um: lkl: add test programs for library mode of UML
Date:   Wed, 20 Jan 2021 11:27:23 +0900
Message-Id: <a88e2c9511dde1fcf701d3c426b696de8502495a.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple LKL test application (boot) that starts the kernel and
performs simple tests that minimally exercise the LKL API.  The tests
are implemented on kselftest framework, which can be invoked with

 make ARCH=um SUBARCH=lkl TARGETS="um" kselftest

Additionally, this commits add a skip for headers_install for ARCH=um
since UML (even with library mode) doesn't have headers install.

```
 cat /tmp/um-test.tap | sed "s/^# selftests/     \# Subtest: selftests/"
|  sed "s/^#/    /" | sed "s/version 13/version 14/" | sed "s/\(ok
[0-9]* \)/\1- /" | ./tools/testing/kunit/kunit.py parse
```

this makes tap14 converter for the kselftest results.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/testing/selftests/Makefile    |   3 +
 tools/testing/selftests/um/Makefile |  13 +
 tools/testing/selftests/um/boot.c   | 376 ++++++++++++++++++++++++++++
 tools/testing/selftests/um/test.c   | 128 ++++++++++
 tools/testing/selftests/um/test.h   |  72 ++++++
 tools/testing/selftests/um/test.sh  | 181 +++++++++++++
 6 files changed, 773 insertions(+)
 create mode 100644 tools/testing/selftests/um/Makefile
 create mode 100644 tools/testing/selftests/um/boot.c
 create mode 100644 tools/testing/selftests/um/test.c
 create mode 100644 tools/testing/selftests/um/test.h
 create mode 100644 tools/testing/selftests/um/test.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8a917cb4426a..26b6fc800778 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -65,6 +65,7 @@ TARGETS += timers
 endif
 TARGETS += tmpfs
 TARGETS += tpm2
+TARGETS += um
 TARGETS += user
 TARGETS += vDSO
 TARGETS += vm
@@ -154,12 +155,14 @@ endif
 # Local build cases: "make kselftest", "make -C" - headers are installed
 # in the default INSTALL_HDR_PATH usr/include.
 khdr:
+ifneq (um,$(ARCH))
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
 	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
 	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
+endif
 
 all: khdr
 	@ret=1;							\
diff --git a/tools/testing/selftests/um/Makefile b/tools/testing/selftests/um/Makefile
new file mode 100644
index 000000000000..1b915f4bb751
--- /dev/null
+++ b/tools/testing/selftests/um/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+top_srcdir = ../../../../
+top_objdir = $(OUTPUT)/../../
+
+CFLAGS := -fPIC -I$(top_objdir)/tools/um/include/ -I$(top_srcdir)/tools/um/include/ -g
+CFLAGS += test.c
+LDFLAGS := -pie
+LDLIBS := -L$(top_objdir)/tools/um -L$(top_srcdir)/tools/um -llinux -lpthread -lrt -lutil
+
+TEST_GEN_PROGS := boot
+
+include ../lib.mk
diff --git a/tools/testing/selftests/um/boot.c b/tools/testing/selftests/um/boot.c
new file mode 100644
index 000000000000..b1330a39a936
--- /dev/null
+++ b/tools/testing/selftests/um/boot.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <lkl.h>
+#include <lkl_host.h>
+
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+
+#include "test.h"
+
+#define sleep_ns 87654321
+static int lkl_test_nanosleep(void)
+{
+	struct lkl_timespec ts = {
+		.tv_sec = 0,
+		.tv_nsec = sleep_ns,
+	};
+	struct timespec start, stop;
+	long delta;
+	long ret;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	ret = lkl_sys_nanosleep((struct __lkl__kernel_timespec *)&ts, NULL);
+	clock_gettime(CLOCK_MONOTONIC, &stop);
+
+	delta = 1e9*(stop.tv_sec - start.tv_sec) +
+		(stop.tv_nsec - start.tv_nsec);
+
+	lkl_test_logf("sleep %ld, expected sleep %d\n", delta, sleep_ns);
+
+	if (ret == 0 && delta > sleep_ns * 0.9)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+LKL_TEST_CALL(getpid, lkl_sys_getpid, 1)
+
+void check_latency(long (*f)(void), long *min, long *max, long *avg)
+{
+	int i;
+	struct timespec start, stop;
+	unsigned long long sum = 0;
+	static const int count = 20;
+	long delta;
+
+	*min = 1000000000;
+	*max = -1;
+
+	for (i = 0; i < count; i++) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		f();
+		clock_gettime(CLOCK_MONOTONIC, &stop);
+
+		delta = 1e9*(stop.tv_sec - start.tv_sec) +
+			(stop.tv_nsec - start.tv_nsec);
+
+		if (*min > delta)
+			*min = delta;
+		if (*max < delta)
+			*max = delta;
+		sum += delta;
+	}
+	*avg = sum / count;
+}
+
+static long native_getpid(void)
+{
+	getpid();
+	return 0;
+}
+
+int lkl_test_syscall_latency(void)
+{
+	long min, max, avg;
+
+	lkl_test_logf("avg/min/max: ");
+
+	check_latency(lkl_sys_getpid, &min, &max, &avg);
+
+	lkl_test_logf("lkl:%ld/%ld/%ld ", avg, min, max);
+
+	check_latency(native_getpid, &min, &max, &avg);
+
+	lkl_test_logf("native:%ld/%ld/%ld\n", avg, min, max);
+
+	return TEST_SUCCESS;
+}
+
+#define access_rights 0721
+
+LKL_TEST_CALL(creat, lkl_sys_creat, 3, "/file", access_rights)
+LKL_TEST_CALL(close, lkl_sys_close, 0, 0);
+LKL_TEST_CALL(failopen, lkl_sys_open, -LKL_ENOENT, "/file2", 0, 0);
+LKL_TEST_CALL(umask, lkl_sys_umask, 022,  0777);
+LKL_TEST_CALL(umask2, lkl_sys_umask, 0777, 0);
+LKL_TEST_CALL(open, lkl_sys_open, 0, "/file", LKL_O_RDWR, 0);
+static const char wrbuf[] = "test";
+LKL_TEST_CALL(write, lkl_sys_write, sizeof(wrbuf), 0, wrbuf, sizeof(wrbuf));
+LKL_TEST_CALL(lseek_cur, lkl_sys_lseek, sizeof(wrbuf), 0, 0, LKL_SEEK_CUR);
+LKL_TEST_CALL(lseek_end, lkl_sys_lseek, sizeof(wrbuf), 0, 0, LKL_SEEK_END);
+LKL_TEST_CALL(lseek_set, lkl_sys_lseek, 0, 0, 0, LKL_SEEK_SET);
+
+int lkl_test_read(void)
+{
+	char buf[10] = { 0, };
+	long ret;
+
+	ret = lkl_sys_read(0, buf, sizeof(buf));
+
+	lkl_test_logf("lkl_sys_read=%ld buf=%s\n", ret, buf);
+
+	if (ret == sizeof(wrbuf) && !strcmp(wrbuf, buf))
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+int lkl_test_fstat(void)
+{
+	struct lkl_stat stat;
+	long ret;
+
+	ret = lkl_sys_fstat(0, (void *)&stat);
+
+	lkl_test_logf("lkl_sys_fstat=%ld mode=%o size=%ld\n", ret, stat.st_mode,
+		      stat.st_size);
+
+	if (ret == 0 && stat.st_size == sizeof(wrbuf) &&
+	    stat.st_mode == (access_rights | LKL_S_IFREG))
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+LKL_TEST_CALL(mkdir, lkl_sys_mkdir, 0, "/proc", access_rights)
+
+int lkl_test_stat(void)
+{
+	struct lkl_stat stat;
+	long ret;
+
+	ret = lkl_sys_stat("/proc", (void *)&stat);
+
+	lkl_test_logf("lkl_sys_stat(\"/proc\")=%ld mode=%o\n", ret,
+		      stat.st_mode);
+
+	if (ret == 0 && stat.st_mode == (access_rights | LKL_S_IFDIR))
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+static int lkl_test_pipe2(void)
+{
+	int pipe_fds[2];
+	int READ_IDX = 0, WRITE_IDX = 1;
+	static const char msg[] = "Hello world!";
+	char str[20];
+	int msg_len_bytes = strlen(msg) + 1;
+	int cmp_res;
+	long ret;
+
+	ret = lkl_sys_pipe2(pipe_fds, LKL_O_NONBLOCK);
+	if (ret) {
+		lkl_test_logf("pipe2: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_write(pipe_fds[WRITE_IDX], msg, msg_len_bytes);
+	if (ret != msg_len_bytes) {
+		if (ret < 0)
+			lkl_test_logf("write error: %s\n", lkl_strerror(ret));
+		else
+			lkl_test_logf("short write: %ld\n", ret);
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_read(pipe_fds[READ_IDX], str, msg_len_bytes);
+	if (ret != msg_len_bytes) {
+		if (ret < 0)
+			lkl_test_logf("read error: %s\n", lkl_strerror(ret));
+		else
+			lkl_test_logf("short read: %ld\n", ret);
+		return TEST_FAILURE;
+	}
+
+	cmp_res = memcmp(msg, str, msg_len_bytes);
+	if (cmp_res) {
+		lkl_test_logf("memcmp failed: %d\n", cmp_res);
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_close(pipe_fds[0]);
+	if (ret) {
+		lkl_test_logf("close error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_close(pipe_fds[1]);
+	if (ret) {
+		lkl_test_logf("close error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_epoll(void)
+{
+	int epoll_fd, pipe_fds[2];
+	int READ_IDX = 0, WRITE_IDX = 1;
+	struct lkl_epoll_event wait_on, read_result;
+	static const char msg[] = "Hello world!";
+	long ret;
+
+	memset(&wait_on, 0, sizeof(wait_on));
+	memset(&read_result, 0, sizeof(read_result));
+
+	ret = lkl_sys_pipe2(pipe_fds, LKL_O_NONBLOCK);
+	if (ret) {
+		lkl_test_logf("pipe2 error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	epoll_fd = lkl_sys_epoll_create(1);
+	if (epoll_fd < 0) {
+		lkl_test_logf("epoll_create error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	wait_on.events = LKL_POLLIN | LKL_POLLOUT;
+	wait_on.data = pipe_fds[READ_IDX];
+
+	ret = lkl_sys_epoll_ctl(epoll_fd, LKL_EPOLL_CTL_ADD, pipe_fds[READ_IDX],
+				&wait_on);
+	if (ret < 0) {
+		lkl_test_logf("epoll_ctl error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	/* Shouldn't be ready before we have written something */
+	ret = lkl_sys_epoll_wait(epoll_fd, &read_result, 1, 0);
+	if (ret != 0) {
+		if (ret < 0)
+			lkl_test_logf("epoll_wait error: %s\n",
+				      lkl_strerror(ret));
+		else
+			lkl_test_logf("epoll_wait: bad event: 0x%lx\n", ret);
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_write(pipe_fds[WRITE_IDX], msg, strlen(msg) + 1);
+	if (ret < 0) {
+		lkl_test_logf("write error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	/* We expect exactly 1 fd to be ready immediately */
+	ret = lkl_sys_epoll_wait(epoll_fd, &read_result, 1, 0);
+	if (ret != 1) {
+		if (ret < 0)
+			lkl_test_logf("epoll_wait error: %s\n",
+				      lkl_strerror(ret));
+		else
+			lkl_test_logf("epoll_wait: bad ev no %ld\n", ret);
+		return TEST_FAILURE;
+	}
+
+	/* Already tested reading from pipe2 so no need to do it
+	 * here
+	 */
+
+	return TEST_SUCCESS;
+}
+
+LKL_TEST_CALL(chdir_proc, lkl_sys_chdir, 0, "proc");
+
+static int dir_fd;
+
+static int lkl_test_open_cwd(void)
+{
+	dir_fd = lkl_sys_open(".", LKL_O_RDONLY | LKL_O_DIRECTORY, 0);
+	if (dir_fd < 0) {
+		lkl_test_logf("failed to open current directory: %s\n",
+			      lkl_strerror(dir_fd));
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+/* column where to insert a line break for the list file tests below. */
+#define COL_LINE_BREAK 70
+
+static int lkl_test_getdents64(void)
+{
+	long ret;
+	char buf[1024], *pos;
+	struct lkl_linux_dirent64 *de;
+	int wr;
+
+	de = (struct lkl_linux_dirent64 *)buf;
+	ret = lkl_sys_getdents64(dir_fd, de, sizeof(buf));
+
+	wr = lkl_test_logf("%d ", dir_fd);
+
+	if (ret < 0)
+		return TEST_FAILURE;
+
+	for (pos = buf; pos - buf < ret; pos += de->d_reclen) {
+		de = (struct lkl_linux_dirent64 *)pos;
+
+		wr += lkl_test_logf("%s ", de->d_name);
+		if (wr >= COL_LINE_BREAK) {
+			lkl_test_logf("\n");
+			wr = 0;
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+
+LKL_TEST_CALL(close_dir_fd, lkl_sys_close, 0, dir_fd);
+LKL_TEST_CALL(chdir_root, lkl_sys_chdir, 0, "/");
+LKL_TEST_CALL(mount_fs_proc, lkl_sys_mount, 0, "none", "/proc", "proc", 0,
+	      NULL);
+LKL_TEST_CALL(umount_fs_proc, lkl_sys_umount, 0, "/proc", 0);
+
+LKL_TEST_CALL(start_kernel, lkl_start_kernel, 0, &lkl_host_ops,
+	     "mem=16M loglevel=8");
+LKL_TEST_CALL(stop_kernel, lkl_sys_halt, 0);
+
+static struct lkl_test tests[] = {
+	LKL_TEST(start_kernel),
+	LKL_TEST(getpid),
+	LKL_TEST(syscall_latency),
+	LKL_TEST(umask),
+	LKL_TEST(umask2),
+	LKL_TEST(creat),
+	LKL_TEST(close),
+	LKL_TEST(failopen),
+	LKL_TEST(open),
+	LKL_TEST(write),
+	LKL_TEST(lseek_cur),
+	LKL_TEST(lseek_end),
+	LKL_TEST(lseek_set),
+	LKL_TEST(read),
+	LKL_TEST(fstat),
+	LKL_TEST(mkdir),
+	LKL_TEST(stat),
+	LKL_TEST(nanosleep),
+	LKL_TEST(pipe2),
+	LKL_TEST(epoll),
+	LKL_TEST(mount_fs_proc),
+	LKL_TEST(chdir_proc),
+	LKL_TEST(open_cwd),
+	LKL_TEST(getdents64),
+	LKL_TEST(close_dir_fd),
+	LKL_TEST(chdir_root),
+	LKL_TEST(umount_fs_proc),
+	LKL_TEST(stop_kernel),
+};
+
+int main(int argc, const char **argv)
+{
+	return lkl_test_run(tests, sizeof(tests)/sizeof(struct lkl_test),
+			    "boot");
+}
diff --git a/tools/testing/selftests/um/test.c b/tools/testing/selftests/um/test.c
new file mode 100644
index 000000000000..a3e46852d307
--- /dev/null
+++ b/tools/testing/selftests/um/test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdarg.h>
+#include <time.h>
+
+#include "test.h"
+#include "../kselftest.h"
+
+/* circular log buffer */
+
+static char log_buf[0x10000];
+static char *head = log_buf, *tail = log_buf;
+
+static inline void advance(char **ptr)
+{
+	if ((unsigned int)(*ptr - log_buf) >= sizeof(log_buf))
+		*ptr = log_buf;
+	else
+		*ptr = *ptr + 1;
+}
+
+static void log_char(char c)
+{
+	*tail = c;
+	advance(&tail);
+	if (tail == head)
+		advance(&head);
+}
+
+static void print_log(void)
+{
+	char last;
+
+	printf(" log: |\n");
+	last = '\n';
+	while (head != tail) {
+		if (last == '\n')
+			printf("  ");
+		last = *head;
+		putchar(last);
+		advance(&head);
+	}
+	if (last != '\n')
+		putchar('\n');
+}
+
+int lkl_test_run(const struct lkl_test *tests, int nr, const char *fmt, ...)
+{
+	int i, ret, status = TEST_SUCCESS;
+	clock_t start, stop;
+	char name[1024];
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(name, sizeof(name), fmt, args);
+	va_end(args);
+
+	ksft_set_plan(nr);
+
+	for (i = 1; i <= nr; i++) {
+		const struct lkl_test *t = &tests[i-1];
+		unsigned long delta_us;
+
+		printf("* %d %s\n", i, t->name);
+		fflush(stdout);
+
+		start = clock();
+
+		ret = t->fn(t->arg1, t->arg2, t->arg3);
+
+		stop = clock();
+
+		switch (ret) {
+		case TEST_SUCCESS:
+			ksft_test_result_pass("%s\n", t->name);
+			break;
+		case TEST_SKIP:
+			ksft_test_result_skip("%s\n", t->name);
+			break;
+		case TEST_BAILOUT:
+			status = TEST_BAILOUT;
+			/* fall through; */
+		case TEST_FAILURE:
+		default:
+			if (status != TEST_BAILOUT)
+				status = TEST_FAILURE;
+			ksft_test_result_fail("%s\n", t->name);
+		}
+
+		printf(" ---\n");
+		delta_us = (stop - start) * 1000000 / CLOCKS_PER_SEC;
+		printf(" time_us: %ld\n", delta_us);
+		print_log();
+		printf(" ...\n");
+
+		if (status == TEST_BAILOUT) {
+			printf("Bail out!\n");
+			return TEST_FAILURE;
+		}
+
+		fflush(stdout);
+	}
+
+	return status;
+}
+
+
+void lkl_print(const char *str, int len)
+{
+	while (len--)
+		log_char(*(str++));
+}
+
+int lkl_test_logf(const char *fmt, ...)
+{
+	char tmp[1024], *c;
+	va_list args;
+	unsigned int n;
+
+	va_start(args, fmt);
+	n = vsnprintf(tmp, sizeof(tmp), fmt, args);
+	va_end(args);
+
+	for (c = tmp; *c != 0; c++)
+		log_char(*c);
+
+	return n > sizeof(tmp) ? sizeof(tmp) : n;
+}
diff --git a/tools/testing/selftests/um/test.h b/tools/testing/selftests/um/test.h
new file mode 100644
index 000000000000..f19bbc487a98
--- /dev/null
+++ b/tools/testing/selftests/um/test.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_TEST_H
+#define _LKL_TEST_H
+
+#define TEST_SUCCESS	0
+#define TEST_FAILURE	1
+#define TEST_SKIP	2
+#define TEST_TODO	3
+#define TEST_BAILOUT	4
+
+struct lkl_test {
+	const char *name;
+	int (*fn)();
+	void *arg1, *arg2, *arg3;
+};
+
+/**
+ * Simple wrapper to initialize a test entry.
+ * @name - test name, it assume test function is named test_@name
+ * @vargs - arguments to be passed to the function
+ */
+#define LKL_TEST(name, ...) { #name, lkl_test_##name, __VA_ARGS__ }
+
+/**
+ * lkl_test_run - run a test suite
+ *
+ * @tests - the list of tests to run
+ * @nr - number of tests
+ * @fmt - format string to be used for suite name
+ */
+int lkl_test_run(const struct lkl_test *tests, int nr, const char *fmt, ...);
+
+/**
+ * lkl_test_log - store a string in the test log buffer
+ * @str - the string to log (can be non-NULL terminated)
+ * @len - the string length
+ */
+void lkl_test_log(const char *str, int len);
+
+/**
+ * lkl_test_logf - printf like function to store into the test log buffer
+ * @fmt - printf format string
+ * @vargs - arguments to the format string
+ */
+int lkl_test_logf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
+
+/**
+ * LKL_TEST_CALL - create a test function as for a LKL call
+ *
+ * The test function will be named lkl_test_@name and will return
+ * TEST_SUCCESS if the called functions returns @expect. Otherwise
+ * will return TEST_FAILUIRE.
+ *
+ * @name - test name; must be unique because it is part of the
+ * test function; the test function will be named
+ * @call - function to call
+ * @expect - expected return value for success
+ * @args - arguments to pass to the LKL call
+ */
+#define LKL_TEST_CALL(name, call, expect, ...)				\
+	static int lkl_test_##name(void)				\
+	{								\
+		long ret;						\
+									\
+		ret = call(__VA_ARGS__);				\
+		lkl_test_logf("%s(%s) = %ld %s\n", #call, #__VA_ARGS__, \
+			ret, ret < 0 ? lkl_strerror(ret) : "");		\
+		return (ret == expect) ? TEST_SUCCESS : TEST_FAILURE;	\
+	}
+
+
+#endif /* _LKL_TEST_H */
diff --git a/tools/testing/selftests/um/test.sh b/tools/testing/selftests/um/test.sh
new file mode 100644
index 000000000000..1c708f9ce261
--- /dev/null
+++ b/tools/testing/selftests/um/test.sh
@@ -0,0 +1,181 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+basedir=$(cd $script_dir/..; pwd)
+base_objdir=$(cd ${OUTPUT}/; pwd)
+
+TEST_SUCCESS=0
+TEST_FAILURE=1
+TEST_SKIP=113
+TEST_TODO=114
+TEST_BAILOUT=115
+
+print_log()
+{
+    echo " log: |"
+    while read line; do
+        echo "  $line"
+    done < $1
+}
+
+export_vars()
+{
+    if [ -z "$var_file" ]; then
+        return
+    fi
+
+    for i in $@; do
+        echo "$i=${!i}" >> $var_file
+    done
+}
+
+lkl_test_run()
+{
+    log_file=$(mktemp)
+    export var_file=$(mktemp)
+
+    tid=$1 && shift && tname=$@
+
+    echo "* $tid $tname"
+
+    start=$(date '+%s%9N')
+    # run in a separate shell to avoid -e terminating us
+    $@ 2>&1 | strings >$log_file
+    exit=${PIPESTATUS[0]}
+    stop=$(date '+%s%9N')
+
+    case $exit in
+    $TEST_SUCCESS)
+        echo "ok $tid $tname"
+        ;;
+    $TEST_SKIP)
+        echo "ok $tid $tname # SKIP"
+        ;;
+    $TEST_BAILOUT)
+        echo "not ok $tid $tname"
+        echo "Bail out!"
+        ;;
+    $TEST_FAILURE|*)
+        echo "not ok $tid $tname"
+        ;;
+    esac
+
+    delta=$(((stop-start)/1000))
+
+    echo " ---"
+    echo " time_us: $delta"
+    print_log $log_file
+    echo -e " ..."
+
+    rm $log_file
+    . $var_file
+    rm $var_file
+
+    return $exit
+}
+
+lkl_test_plan()
+{
+    echo "1..$1 # $2"
+    export suite_name="${2// /\-}"
+}
+
+lkl_test_exec()
+{
+    local SUDO=""
+    local WRAPPER=""
+
+    if [ "$1" = "sudo" ]; then
+        SUDO=sudo
+        shift
+    fi
+
+    local file=$1
+    shift
+
+    if [ -n "$LKL_HOST_CONFIG_NT" ]; then
+        file=$file.exe
+    fi
+
+    file=${OUTPUT}/$(basename $file)
+
+    if file $file | grep ARM; then
+        WRAPPER="qemu-arm-static"
+    elif file $file | grep "FreeBSD" ; then
+        ssh_copy "$file" $BSD_WDIR
+        if [ -n "$SUDO" ]; then
+            SUDO=""
+        fi
+        WRAPPER="$MYSSH $SU"
+        # ssh will mess up with pipes ('|') so, escape the pipe char.
+        args="${@//\|/\\\|}"
+        set - $BSD_WDIR/$(basename $file) $args
+        file=""
+    elif [ -n "$GDB" ]; then
+        WRAPPER="gdb"
+        args="$@"
+        set - -ex "run $args" -ex quit $file
+        file=""
+    elif [ -n "$VALGRIND" ]; then
+        WRAPPER="valgrind --suppressions=$script_dir/valgrind.supp \
+                  --leak-check=full --show-leak-kinds=all --xml=yes \
+                  --xml-file=valgrind-$suite_name.xml"
+    fi
+
+    $SUDO $WRAPPER $file "$@"
+}
+
+lkl_test_cmd()
+{
+    local WRAPPER=""
+
+    if [ -z "$QUIET" ]; then
+        SHOPTS="-x"
+    fi
+
+    if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+        WRAPPER="$MYSSH $SU"
+    fi
+
+    echo "$@" | $WRAPPER sh $SHOPTS
+}
+
+# XXX: $MYSSH and $MYSCP are defined in a circleci docker image.
+# see the definitions in lkl/lkl-docker:circleci/freebsd11/Dockerfile
+ssh_push()
+{
+    while [ -n "$1" ]; do
+        if [[ "$1" = *.sh ]]; then
+            type="script"
+        else
+            type="file"
+        fi
+
+        dir=$(dirname $1)
+        $MYSSH mkdir -p $BSD_WDIR/$dir
+
+        $MYSCP -P 7722 -r $basedir/$1 root@localhost:$BSD_WDIR/$dir
+        if [ "$type" = "script" ]; then
+            $MYSSH chmod a+x $BSD_WDIR/$1
+        fi
+
+        shift
+    done
+}
+
+ssh_copy()
+{
+    $MYSCP -P 7722 -r $1 root@localhost:$2
+}
+
+lkl_test_bsd_cleanup()
+{
+    $MYSSH rm -rf $BSD_WDIR
+}
+
+if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+    trap lkl_test_bsd_cleanup EXIT
+    export BSD_WDIR=/root/lkl
+    $MYSSH mkdir -p $BSD_WDIR
+fi
-- 
2.21.0 (Apple Git-122.2)

