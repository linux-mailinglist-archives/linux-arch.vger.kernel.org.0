Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719A32125B9
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgGBOKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgGBOKc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:10:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CEC08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:10:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5so3019248pjg.3
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiuoON0vA+8EvA5WeEv/es1B+giSpzDkr4atmJEqcWI=;
        b=IL2GQRHecAKsvLJRvJFtoWWQrizjvG6fVSRtQDeVDEbyeHL9Wy4fM4hI07JLBVZmXY
         gLfTrvIr6ys3zYL3Bg/Wc+IJ2hhrKitD/tid9yFsV+8sb6vja0JH3LqVgVihS9dscR0W
         ojxb5j3GyiUsKvVeYlyzA0uPMKHlcVEHXIwU9WViVZdtn/RcxuR3vO5btKEd5yJ47XPh
         jN1sJ0pIC609uhL/tLbtp7Iby7M6qJ6JaESnJy/1SkL6FfEqWjyyrECDMBFeIIsUpeBT
         /bnZEdsh7e9SsgqLWhjFhCvyLhPGS8U1fHo14SIQ42d5C6TkqG8FRffhTlyc4HuAlL10
         +O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiuoON0vA+8EvA5WeEv/es1B+giSpzDkr4atmJEqcWI=;
        b=nHkA85p5QxBPONghNTnvuJohR6Smymhmk/HWY5rgHIkM00vZ9pfmofkYYmh4fsKFu1
         0tyXdsGRN48Wo6oq4ko5RngDIj2c3qcbh+NyP0h1HZrcQghqkpQyf2cNkBldmhqItvFO
         EergnrNpuZjXmOXOMLhrKtZmBriaJhyZKG/z8Z7LMw1D7jag1SS33A40Ch1LgIpYqJJv
         /0pbUpcB0jqBHMTJbRI846xi1pJhQLjWJEkuEpRXyXqgmlMWBq/liUFc85udOf3lCpLv
         gxJ+knkj02TnHss2wqKgMqbw8K8Z2Qk2t1trb0nEw4KpLFjOXXAVyiS6i4d5ijAkFdJY
         EatQ==
X-Gm-Message-State: AOAM533FGxGp1OxyIzyy8eiEe0a2BczN5gKW82AKzFBVronD9ntK9XDk
        iaEaqLF/8LgPVMEhHVLRNas=
X-Google-Smtp-Source: ABdhPJyOgCC8nQL2lyw+kK4X7brPQrGyI2VTUnK3HVNbWQ/pgUgV46JqDEL+V7cig59C6JY9n3K6OQ==
X-Received: by 2002:a17:902:7483:: with SMTP id h3mr22318294pll.114.1593699031219;
        Thu, 02 Jul 2020 07:10:31 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id o19sm1131857pjp.9.2020.07.02.07.10.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:10:30 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0A879202D31D88; Thu,  2 Jul 2020 23:10:28 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 20/21] um: host: add test programs
Date:   Thu,  2 Jul 2020 23:07:14 +0900
Message-Id: <858ec896c4dbd9015c3497f751b1e1a7a2a2b57a.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple LKL test application (boot) that starts the kernel and
performs simple tests that minimally exercise the LKL API.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/um/Makefile       |   5 +-
 tools/um/Targets        |   6 +
 tools/um/tests/Build    |   1 +
 tools/um/tests/boot.c   | 393 ++++++++++++++++++++++++++++++++++++++++
 tools/um/tests/boot.sh  |   9 +
 tools/um/tests/run.py   | 172 ++++++++++++++++++
 tools/um/tests/tap13.py | 209 +++++++++++++++++++++
 tools/um/tests/test.c   | 126 +++++++++++++
 tools/um/tests/test.h   |  72 ++++++++
 tools/um/tests/test.sh  | 181 ++++++++++++++++++
 10 files changed, 1173 insertions(+), 1 deletion(-)
 create mode 100644 tools/um/tests/Build
 create mode 100644 tools/um/tests/boot.c
 create mode 100755 tools/um/tests/boot.sh
 create mode 100755 tools/um/tests/run.py
 create mode 100644 tools/um/tests/tap13.py
 create mode 100644 tools/um/tests/test.c
 create mode 100644 tools/um/tests/test.h
 create mode 100644 tools/um/tests/test.sh

diff --git a/tools/um/Makefile b/tools/um/Makefile
index a93e060b1f89..20de2e4c162f 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -73,7 +73,10 @@ clean:
 	$(call QUIET_CLEAN, liblinux.a)$(RM) $(OUTPUT)/liblinux.a
 	$(call QUIET_CLEAN, $(TARGETS))$(RM) $(TARGETS)
 
+run-tests:
+	./tests/run.py $(tests)
+
 FORCE: ;
-.PHONY: all clean FORCE
+.PHONY: all clean FORCE run-tests
 .IGNORE: clean
 .NOTPARALLEL : lib/linux.o
diff --git a/tools/um/Targets b/tools/um/Targets
index 4e1f0f4d81a3..2bb90381843c 100644
--- a/tools/um/Targets
+++ b/tools/um/Targets
@@ -1,4 +1,10 @@
+ifeq ($(UMMODE),library)
+progs-y += tests/boot
+else
 progs-y += uml/linux
+endif
+
+LDFLAGS_boot-y := -pie
 
 LDLIBS := -lrt -lpthread -lutil
 LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff --git a/tools/um/tests/Build b/tools/um/tests/Build
new file mode 100644
index 000000000000..26a607f90dc8
--- /dev/null
+++ b/tools/um/tests/Build
@@ -0,0 +1 @@
+boot-y += boot.o test.o
diff --git a/tools/um/tests/boot.c b/tools/um/tests/boot.c
new file mode 100644
index 000000000000..45b9a7276de7
--- /dev/null
+++ b/tools/um/tests/boot.c
@@ -0,0 +1,393 @@
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
+#if defined(__FreeBSD__)
+#include <net/if.h>
+#include <sys/ioctl.h>
+#elif __linux
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#elif __MINGW32__
+#include <windows.h>
+#endif
+
+#include "test.h"
+
+#ifndef __MINGW32__
+#define sleep_ns 87654321
+int lkl_test_nanosleep(void)
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
+#endif
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
+#ifdef __MINGW32__
+	GetCurrentProcessId();
+#else
+	getpid();
+#endif
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
+struct lkl_test tests[] = {
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
+#ifndef __MINGW32__
+	LKL_TEST(nanosleep),
+#endif
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
+	lkl_host_ops.print = lkl_test_log;
+
+	return lkl_test_run(tests, sizeof(tests)/sizeof(struct lkl_test),
+			    "boot");
+}
diff --git a/tools/um/tests/boot.sh b/tools/um/tests/boot.sh
new file mode 100755
index 000000000000..d985c04b0ac1
--- /dev/null
+++ b/tools/um/tests/boot.sh
@@ -0,0 +1,9 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+source $script_dir/test.sh
+
+lkl_test_plan 1 "boot"
+lkl_test_run 1
+lkl_test_exec $script_dir/boot
diff --git a/tools/um/tests/run.py b/tools/um/tests/run.py
new file mode 100755
index 000000000000..c96ede90b6ad
--- /dev/null
+++ b/tools/um/tests/run.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; version 2 of the License
+#
+# Author: Octavian Purdila <tavi@cs.pub.ro>
+#
+
+from __future__ import print_function
+
+import argparse
+import os
+import subprocess
+import sys
+import tap13
+import xml.etree.ElementTree as ET
+
+from junit_xml import TestSuite, TestCase
+
+
+class Reporter(tap13.Reporter):
+    def start(self, obj):
+        if type(obj) is tap13.Test:
+            if obj.result == "*":
+                end='\r'
+            else:
+                end='\n'
+            print("  TEST       %-8s %.50s" %
+                  (obj.result, obj.description + " " + obj.comment), end=end)
+
+        elif type(obj) is tap13.Suite:
+            if obj.tests_planned == 0:
+                status = "skip"
+            else:
+                status = ""
+            print("  SUITE      %-8s %s" % (status, obj.name))
+
+    def end(self, obj):
+        if type(obj) is tap13.Test:
+            if obj.result != "ok":
+                try:
+                    print(obj.yaml["log"], end='')
+                except:
+                    None
+
+
+mydir=os.path.dirname(os.path.realpath(__file__))
+
+tests = [
+    'boot.sh',
+]
+
+parser = argparse.ArgumentParser(description='LKL test runner')
+parser.add_argument('tests', nargs='?', action='append',
+                    help='tests to run %s' % tests)
+parser.add_argument('--junit-dir',
+                    help='directory where to store the juni suites')
+parser.add_argument('--gdb', action='store_true', default=False,
+                    help='run simple tests under gdb; implies --pass-through')
+parser.add_argument('--pass-through', action='store_true',  default=False,
+                    help='run the test without interpeting the test output')
+parser.add_argument('--valgrind', action='store_true', default=False,
+                    help='run simple tests under valgrind')
+
+args = parser.parse_args()
+if args.tests == [None]:
+    args.tests = tests
+
+if args.gdb:
+    args.pass_through=True
+    os.environ['GDB']="yes"
+
+if args.valgrind:
+    os.environ['VALGRIND']="yes"
+
+tap = tap13.Parser(Reporter())
+
+os.environ['PATH'] += ":" + mydir
+
+exit_code = 0
+
+for t in args.tests:
+    if not t:
+        continue
+    if args.pass_through:
+        print(t)
+        if subprocess.call(t, shell=True) != 0:
+            exit_code = 1
+    else:
+        p = subprocess.Popen(t, shell=True, stdout=subprocess.PIPE)
+        tap.parse(p.stdout)
+
+if args.pass_through:
+    sys.exit(exit_code)
+
+suites_count = 0
+tests_total = 0
+tests_not_ok = 0
+tests_ok = 0
+tests_skip = 0
+val_errs = 0
+val_fails = 0
+val_skips = 0
+
+for s in tap.run.suites:
+
+    junit_tests = []
+    suites_count += 1
+
+    for t in s.tests:
+        try:
+            secs = t.yaml["time_us"] / 1000000.0
+        except:
+            secs = 0
+        try:
+            log = t.yaml['log']
+        except:
+            log = ""
+
+        jt = TestCase(t.description, elapsed_sec=secs, stdout=log)
+        if t.result == 'skip':
+            jt.add_skipped_info(output=log)
+        elif t.result == 'not ok':
+            jt.add_error_info(output=log)
+
+        junit_tests.append(jt)
+
+        tests_total += 1
+        if t.result == "ok":
+            tests_ok += 1
+        elif t.result == "not ok":
+            tests_not_ok += 1
+            exit_code = 1
+        elif t.result == "skip":
+            tests_skip += 1
+
+    if args.junit_dir:
+        js = TestSuite(s.name, junit_tests)
+        with open(os.path.join(args.junit_dir, os.path.basename(s.name) + '.xml'), 'w') as f:
+            js.to_file(f, [js])
+
+        if os.getenv('VALGRIND') is not None:
+            val_xml = 'valgrind-%s.xml' % os.path.basename(s.name).replace(' ','-')
+            # skipped tests don't generate xml file
+            if os.path.exists(val_xml) is False:
+                continue
+
+            cmd = 'mv %s %s' % (val_xml, args.junit_dir)
+            subprocess.call(cmd, shell=True, )
+
+            cmd = mydir + '/valgrind2xunit.py ' + val_xml
+            subprocess.call(cmd, shell=True, cwd=args.junit_dir)
+
+            # count valgrind results
+            doc = ET.parse(os.path.join(args.junit_dir, 'valgrind-%s_xunit.xml' \
+                                        % (os.path.basename(s.name).replace(' ','-'))))
+            ts = doc.getroot()
+            val_errs += int(ts.get('errors'))
+            val_fails += int(ts.get('failures'))
+            val_skips += int(ts.get('skip'))
+
+print("Summary: %d suites run, %d tests, %d ok, %d not ok, %d skipped" %
+      (suites_count, tests_total, tests_ok, tests_not_ok, tests_skip))
+
+if os.getenv('VALGRIND') is not None:
+    print(" valgrind (memcheck): %d failures, %d skipped" % (val_fails, val_skips))
+    if val_errs or val_fails:
+        exit_code = 1
+
+sys.exit(exit_code)
diff --git a/tools/um/tests/tap13.py b/tools/um/tests/tap13.py
new file mode 100644
index 000000000000..65c73cda7ca1
--- /dev/null
+++ b/tools/um/tests/tap13.py
@@ -0,0 +1,209 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; version 2 of the License
+#
+# Author: Octavian Purdila <tavi@cs.pub.ro>
+#
+# Based on TAP13:
+#
+# Copyright 2013, Red Hat, Inc.
+# Author: Josef Skladanka <jskladan@redhat.com>
+#
+from __future__ import print_function
+
+import re
+import sys
+import yamlish
+
+
+class Reporter(object):
+
+    def start(self, obj):
+        None
+
+    def end(self, obj):
+        None
+
+
+class Test(object):
+    def __init__(self, reporter, result, id, description=None, directive=None,
+                 comment=None):
+        self.reporter = reporter
+        self.result = result
+        if directive:
+            self.result = directive.lower()
+        if id:
+            self.id = int(id)
+        else:
+            self.id = None
+        if description:
+            self.description = description
+        else:
+            self.description = ""
+        if comment:
+            self.comment = "# " + comment
+        else:
+            self.comment = ""
+        self.yaml = None
+        self._yaml_buffer = None
+        self.diagnostics = []
+
+        self.reporter.start(self)
+
+    def end(self):
+        if not self.yaml:
+            self.yaml = yamlish.load(self._yaml_buffer)
+            self.reporter.end(self)
+
+
+class Suite(object):
+    def __init__(self, reporter, start, end, explanation):
+        self.reporter = reporter
+        self.tests = []
+        self.name = explanation
+        self.tests_planned = int(end)
+
+        self.__tests_counter = 0
+        self.__tests_base = 0
+
+        self.reporter.start(self)
+
+    def newTest(self, args):
+        try:
+            self.tests[-1].end()
+        except IndexError:
+            None
+
+        if 'id' not in args or not args['id']:
+            args['id'] = self.__tests_counter
+        else:
+            args['id'] = int(args['id']) + self.__tests_base
+
+        if args['id'] < self.__tests_counter:
+            print("error: bad test id %d, fixing it" % (args['id']))
+            args['id'] = self.__tests_counter
+        # according to TAP13 specs, missing tests must be handled as 'not ok'
+        # here we add the missing tests in sequence
+        while args['id'] > (self.__tests_counter + 1):
+            comment = 'test %d not present' % self.__tests_counter
+            self.tests.append(Test(self.reporter, 'not ok',
+                                   self.__tests_counter, comment=comment))
+            self.__tests_counter += 1
+
+        if args['id'] == self.__tests_counter:
+            if args['directive']:
+                self.test().result = args['directive'].lower()
+            else:
+                self.test().result = args['result']
+            self.reporter.start(self.test())
+        else:
+            self.tests.append(Test(self.reporter, **args))
+            self.__tests_counter += 1
+
+    def test(self):
+        return self.tests[-1]
+
+    def end(self, name, planned):
+        if name == self.name:
+            self.tests_planned += int(planned)
+            self.__tests_base = self.__tests_counter
+            return False
+        try:
+            self.test().end()
+        except IndexError:
+            None
+        if len(self.tests) != self.tests_planned:
+            for i in range(len(self.tests), self.tests_planned):
+                self.tests.append(Test(self.reporter, 'not ok', i+1,
+                                       comment='test not present'))
+        return True
+
+
+class Run(object):
+
+    def __init__(self, reporter):
+        self.reporter = reporter
+        self.suites = []
+
+    def suite(self):
+        return self.suites[-1]
+
+    def test(self):
+        return self.suites[-1].tests[-1]
+
+    def newSuite(self, args):
+        new = False
+        try:
+            if self.suite().end(args['explanation'], args['end']):
+                new = True
+        except IndexError:
+            new = True
+        if new:
+            self.suites.append(Suite(self.reporter, **args))
+
+    def newTest(self, args):
+        self.suite().newTest(args)
+
+
+class Parser(object):
+    RE_PLAN = re.compile(r"^\s*(?P<start>\d+)\.\.(?P<end>\d+)\s*(#\s*(?P<explanation>.*))?\s*$")
+    RE_TEST_LINE = re.compile(r"^\s*(?P<result>(not\s+)?ok|[*]+)\s*(?P<id>\d+)?\s*(?P<description>[^#]+)?\s*(#\s*(?P<directive>TODO|SKIP)?\s*(?P<comment>.+)?)?\s*$",  re.IGNORECASE)
+    RE_EXPLANATION = re.compile(r"^\s*#\s*(?P<explanation>.+)?\s*$")
+    RE_YAMLISH_START = re.compile(r"^\s*---.*$")
+    RE_YAMLISH_END = re.compile(r"^\s*\.\.\.\s*$")
+
+    def __init__(self, reporter):
+        self.seek_test = False
+        self.in_test = False
+        self.in_yaml = False
+        self.run = Run(reporter)
+
+    def parse(self, source):
+        # to avoid input buffering
+        while True:
+            line = source.readline()
+            if not line:
+                break
+
+            if self.in_yaml:
+                if Parser.RE_YAMLISH_END.match(line):
+                    self.run.test()._yaml_buffer.append(line.strip())
+                    self.in_yaml = False
+                else:
+                    self.run.test()._yaml_buffer.append(line.rstrip())
+                continue
+
+            line = line.strip()
+
+            if self.in_test:
+                if Parser.RE_EXPLANATION.match(line):
+                    self.run.test().diagnostics.append(line)
+                    continue
+                if Parser.RE_YAMLISH_START.match(line):
+                    self.run.test()._yaml_buffer = [line.strip()]
+                    self.in_yaml = True
+                    continue
+
+            m = Parser.RE_PLAN.match(line)
+            if m:
+                self.seek_test = True
+                args = m.groupdict()
+                self.run.newSuite(args)
+                continue
+
+            if self.seek_test:
+                m = Parser.RE_TEST_LINE.match(line)
+                if m:
+                    args = m.groupdict()
+                    self.run.newTest(args)
+                    self.in_test = True
+                    continue
+
+            print(line)
+        try:
+            self.run.suite().end(None, 0)
+        except IndexError:
+            None
diff --git a/tools/um/tests/test.c b/tools/um/tests/test.c
new file mode 100644
index 000000000000..37ea21901f99
--- /dev/null
+++ b/tools/um/tests/test.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdarg.h>
+#include <time.h>
+
+#include "test.h"
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
+	printf("1..%d # %s\n", nr, name);
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
+			printf("ok %d %s\n", i, t->name);
+			break;
+		case TEST_SKIP:
+			printf("ok %d %s # SKIP\n", i, t->name);
+			break;
+		case TEST_BAILOUT:
+			status = TEST_BAILOUT;
+			/* fall through; */
+		case TEST_FAILURE:
+		default:
+			if (status != TEST_BAILOUT)
+				status = TEST_FAILURE;
+			printf("not ok %d %s\n", i, t->name);
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
+void lkl_test_log(const char *str, int len)
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
diff --git a/tools/um/tests/test.h b/tools/um/tests/test.h
new file mode 100644
index 000000000000..f63ad6d419cb
--- /dev/null
+++ b/tools/um/tests/test.h
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
+ * @name - test name; must be unique because it is part of the the
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
diff --git a/tools/um/tests/test.sh b/tools/um/tests/test.sh
new file mode 100644
index 000000000000..31b7de5c06f7
--- /dev/null
+++ b/tools/um/tests/test.sh
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
+    file=${OUTPUT}/tests/$(basename $file)
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

