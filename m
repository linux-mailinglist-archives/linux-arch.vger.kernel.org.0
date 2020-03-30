Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00B1197EE3
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgC3Osr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:48:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40645 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3Osr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:48:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so6804693plk.7
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dY0Cs2GLN9B5IOjRYUJ63n4TqEafLZsrxeHrY3G99Jc=;
        b=Fa+WRSqUiIltRWhKht/wQOiSiU2lqQdv8mYt9Fu47t+LC8OPm+tfdbUFAjerghbRXV
         +VwBniwyaW131Icf3CEdGXmI9pdiVj9k0ROJHa5EOpPaIycqHuLHV0ja/R1KJDYluenN
         XciPsgcbHEspb04WkOX7bRlyqzfEcnsbY5eBsdFiMD6Sv/J3pj9b8Gdzhk+hC9mA5jv/
         IQcnGfv8wSdW8CqZLZYtBYXcF/yyXqtRKFfTjnf2oFNf1JPr/uS2jZI53rVFBQo/Nxds
         YJgZgflPHBZA70pdxE0/p0P+FJ4X8oJdsG9lVVkG8tyW9kjaEfIBQUvlqH6tvNk/z3xd
         CEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dY0Cs2GLN9B5IOjRYUJ63n4TqEafLZsrxeHrY3G99Jc=;
        b=XYYriVAQ+pNVUe7X8kDjGEJSotI+6EXKlUGcmvhimHIGkI8AIP7AMHktsjY4CJ+6jd
         WNAinXPdsT7edRH6aQ2lCxXPoLrd446URHgaVXVAK35UuTNqfT9IMHXSAlIQTdPdl6te
         VfR57gzCnkPwWboYR9kEnOB2uKTFCQDcS5rGZ+xASzvPsF+HrA27DdcURoIrRHC8lQB/
         3XmtSPo95W/fPgd2JR/eXAm8IVrf44WTpT89gNjNGaTVB0ipWw/tACS5asH//Wfgb+ci
         qNYl7hlsR+q8knvyKv6xwITYiA4IhPtJtKQ8gbp1DiPoS/SyI9e76tWw9qFruos+KbZG
         c/Ww==
X-Gm-Message-State: ANhLgQ3fT6jHqXf1lS+8xUC5BIyveUNoUDsa+mLerzTo8343fO0cRV0v
        Ath7LgxPys7Ke+aM4ozLiGE=
X-Google-Smtp-Source: ADFU+vu+ZrY4qted6aEfyuACjZirAg7C8VoKDRdxpZCXlaer3jY1lDFnBQ51/8bhwwH+i+I+JEOE+g==
X-Received: by 2002:a17:90a:fb94:: with SMTP id cp20mr16699074pjb.117.1585579724444;
        Mon, 30 Mar 2020 07:48:44 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id c9sm10277862pjr.47.2020.03.30.07.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:48:43 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 85A12202804E43; Mon, 30 Mar 2020 23:48:41 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>,
        David Disseldorp <ddiss@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luca Dariz <luca.dariz@gmail.com>,
        Mark Stillwell <mark@stillwell.me>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 17/25] lkl tools: add test programs
Date:   Mon, 30 Mar 2020 23:45:49 +0900
Message-Id: <faa2b00f2c1d4683b3649c41a7ebeb149bfc5e13.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Add a simple LKL test application (boot) that starts the kernel and
performs simple tests that minimally exercise the LKL API. Networking
and block device tests are also added which are useful to detect
regressions.

Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: David Disseldorp <ddiss@suse.de>
Cc: H.K. Jerry Chu <hkchu@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Luca Dariz <luca.dariz@gmail.com>
Cc: Mark Stillwell <mark@stillwell.me>
Cc: Motomu Utsumi <motomuman@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Petros Angelatos <petrosagg@gmail.com>
Cc: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/.gitignore              |   5 +
 tools/lkl/Makefile                |   5 +-
 tools/lkl/Targets                 |   3 +
 tools/lkl/tests/Build             |   3 +
 tools/lkl/tests/boot.c            | 562 ++++++++++++++++++++++++++++++
 tools/lkl/tests/boot.sh           |   9 +
 tools/lkl/tests/cla.c             | 159 +++++++++
 tools/lkl/tests/cla.h             |  33 ++
 tools/lkl/tests/disk.c            | 189 ++++++++++
 tools/lkl/tests/disk.sh           |  61 ++++
 tools/lkl/tests/net-setup.sh      |  73 ++++
 tools/lkl/tests/net-test.c        | 299 ++++++++++++++++
 tools/lkl/tests/net.sh            |  90 +++++
 tools/lkl/tests/run.py            | 179 ++++++++++
 tools/lkl/tests/tap13.py          | 209 +++++++++++
 tools/lkl/tests/test.c            | 126 +++++++
 tools/lkl/tests/test.h            |  72 ++++
 tools/lkl/tests/test.sh           | 182 ++++++++++
 tools/lkl/tests/valgrind.supp     | 105 ++++++
 tools/lkl/tests/valgrind2xunit.py |  69 ++++
 20 files changed, 2432 insertions(+), 1 deletion(-)
 create mode 100644 tools/lkl/tests/Build
 create mode 100644 tools/lkl/tests/boot.c
 create mode 100755 tools/lkl/tests/boot.sh
 create mode 100644 tools/lkl/tests/cla.c
 create mode 100644 tools/lkl/tests/cla.h
 create mode 100644 tools/lkl/tests/disk.c
 create mode 100755 tools/lkl/tests/disk.sh
 create mode 100644 tools/lkl/tests/net-setup.sh
 create mode 100644 tools/lkl/tests/net-test.c
 create mode 100755 tools/lkl/tests/net.sh
 create mode 100755 tools/lkl/tests/run.py
 create mode 100644 tools/lkl/tests/tap13.py
 create mode 100644 tools/lkl/tests/test.c
 create mode 100644 tools/lkl/tests/test.h
 create mode 100644 tools/lkl/tests/test.sh
 create mode 100644 tools/lkl/tests/valgrind.supp
 create mode 100755 tools/lkl/tests/valgrind2xunit.py

diff --git a/tools/lkl/.gitignore b/tools/lkl/.gitignore
index 1aed58bfe171..4e08254dbd46 100644
--- a/tools/lkl/.gitignore
+++ b/tools/lkl/.gitignore
@@ -2,3 +2,8 @@ Makefile.conf
 include/lkl_autoconf.h
 tests/autoconf.sh
 bin/stat
+tests/net-test
+tests/disk
+tests/boot
+tests/valgrind*.xml
+*.pyc
diff --git a/tools/lkl/Makefile b/tools/lkl/Makefile
index 11ea7e9095bb..0abccb9d86b6 100644
--- a/tools/lkl/Makefile
+++ b/tools/lkl/Makefile
@@ -117,8 +117,11 @@ programs_install: $(progs-y:%=$(OUTPUT)%$(EXESUF))
 install: headers_install libraries_install programs_install
 
 
+run-tests:
+	./tests/run.py $(tests)
+
 FORCE: ;
-.PHONY: all clean FORCE
+.PHONY: all clean FORCE run-tests
 .PHONY: headers_install libraries_install programs_install install
 .NOTPARALLEL : lib/lkl.o
 .SECONDARY:
diff --git a/tools/lkl/Targets b/tools/lkl/Targets
index 24c985e64638..a9f74c3cc8fb 100644
--- a/tools/lkl/Targets
+++ b/tools/lkl/Targets
@@ -1,3 +1,6 @@
 libs-y += lib/liblkl
 
+progs-y += tests/boot
+progs-y += tests/disk
+progs-y += tests/net-test
 
diff --git a/tools/lkl/tests/Build b/tools/lkl/tests/Build
new file mode 100644
index 000000000000..ace86a3d3438
--- /dev/null
+++ b/tools/lkl/tests/Build
@@ -0,0 +1,3 @@
+boot-y += boot.o test.o
+disk-y += disk.o cla.o test.o
+net-test-y += net-test.o cla.o test.o
diff --git a/tools/lkl/tests/boot.c b/tools/lkl/tests/boot.c
new file mode 100644
index 000000000000..b021e9540147
--- /dev/null
+++ b/tools/lkl/tests/boot.c
@@ -0,0 +1,562 @@
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
+	unsigned long long start, stop, sum = 0;
+	static const int count = 1000;
+	long delta;
+
+	*min = 1000000000;
+	*max = -1;
+
+	for (i = 0; i < count; i++) {
+		start = lkl_host_ops.time();
+		f();
+		stop = lkl_host_ops.time();
+		delta = stop - start;
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
+LKL_TEST_CALL(creat, lkl_sys_creat, 0, "/file", access_rights)
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
+	ret = lkl_sys_fstat(0, &stat);
+
+	lkl_test_logf("lkl_sys_fstat=%ld mode=%o size=%zd\n", ret, stat.st_mode,
+		      stat.st_size);
+
+	if (ret == 0 && stat.st_size == sizeof(wrbuf) &&
+	    stat.st_mode == (access_rights | LKL_S_IFREG))
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+LKL_TEST_CALL(mkdir, lkl_sys_mkdir, 0, "/mnt", access_rights)
+
+int lkl_test_stat(void)
+{
+	struct lkl_stat stat;
+	long ret;
+
+	ret = lkl_sys_stat("/mnt", &stat);
+
+	lkl_test_logf("lkl_sys_stat(\"/mnt\")=%ld mode=%o\n", ret,
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
+LKL_TEST_CALL(mount_fs_proc, lkl_mount_fs, 0, "proc");
+LKL_TEST_CALL(umount_fs_proc, lkl_umount_timeout, 0, "proc", 0, 1000);
+LKL_TEST_CALL(lo_ifup, lkl_if_up, 0, 1);
+
+static int lkl_test_mutex(void)
+{
+	long ret = TEST_SUCCESS;
+	/*
+	 * Can't do much to verify that this works, so we'll just let Valgrind
+	 * warn us on CI if we've made bad memory accesses.
+	 */
+
+	struct lkl_mutex *mutex;
+
+	mutex = lkl_host_ops.mutex_alloc(0);
+	lkl_host_ops.mutex_lock(mutex);
+	lkl_host_ops.mutex_unlock(mutex);
+	lkl_host_ops.mutex_free(mutex);
+
+	mutex = lkl_host_ops.mutex_alloc(1);
+	lkl_host_ops.mutex_lock(mutex);
+	lkl_host_ops.mutex_lock(mutex);
+	lkl_host_ops.mutex_unlock(mutex);
+	lkl_host_ops.mutex_unlock(mutex);
+	lkl_host_ops.mutex_free(mutex);
+
+	return ret;
+}
+
+static int lkl_test_semaphore(void)
+{
+	long ret = TEST_SUCCESS;
+	/*
+	 * Can't do much to verify that this works, so we'll just let Valgrind
+	 * warn us on CI if we've made bad memory accesses.
+	 */
+
+	struct lkl_sem *sem = lkl_host_ops.sem_alloc(1);
+
+	lkl_host_ops.sem_down(sem);
+	lkl_host_ops.sem_up(sem);
+	lkl_host_ops.sem_free(sem);
+
+	return ret;
+}
+
+static int lkl_test_gettid(void)
+{
+	long tid = lkl_host_ops.gettid();
+
+	lkl_test_logf("%ld", tid);
+
+	/* As far as I know, thread IDs are non-zero on all reasonable
+	 * systems.
+	 */
+	if (tid)
+		return TEST_SUCCESS;
+	else
+		return TEST_FAILURE;
+}
+
+static void test_thread(void *data)
+{
+	int *pipe_fds = (int *) data;
+	char tmp[LKL_PIPE_BUF+1];
+	int ret;
+
+	ret = lkl_sys_read(pipe_fds[0], tmp, sizeof(tmp));
+	if (ret < 0)
+		lkl_test_logf("%s: %s\n", __func__, lkl_strerror(ret));
+}
+
+static int lkl_test_syscall_thread(void)
+{
+	int pipe_fds[2];
+	char tmp[LKL_PIPE_BUF+1];
+	long ret;
+	lkl_thread_t tid;
+
+	ret = lkl_sys_pipe2(pipe_fds, 0);
+	if (ret) {
+		lkl_test_logf("pipe2: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_fcntl(pipe_fds[0], LKL_F_SETPIPE_SZ, 1);
+	if (ret < 0) {
+		lkl_test_logf("fcntl setpipe_sz: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	tid = lkl_host_ops.thread_create(test_thread, pipe_fds);
+	if (!tid) {
+		lkl_test_logf("failed to create thread\n");
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_write(pipe_fds[1], tmp, sizeof(tmp));
+	if (ret != sizeof(tmp)) {
+		if (ret < 0)
+			lkl_test_logf("write error: %s\n", lkl_strerror(ret));
+		else
+			lkl_test_logf("short write: %ld\n", ret);
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_host_ops.thread_join(tid);
+	if (ret) {
+		lkl_test_logf("failed to join thread\n");
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+#ifndef __MINGW32__
+static void thread_get_pid(void *unused)
+{
+	lkl_sys_getpid();
+}
+
+static int lkl_test_many_syscall_threads(void)
+{
+	lkl_thread_t tid;
+	int count = 65, ret;
+
+	while (--count > 0) {
+		tid = lkl_host_ops.thread_create(thread_get_pid, NULL);
+		if (!tid) {
+			lkl_test_logf("failed to create thread\n");
+			return TEST_FAILURE;
+		}
+
+		ret = lkl_host_ops.thread_join(tid);
+		if (ret) {
+			lkl_test_logf("failed to join thread\n");
+			return TEST_FAILURE;
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+#endif
+
+static void thread_quit_immediately(void *unused)
+{
+}
+
+static int lkl_test_join(void)
+{
+	lkl_thread_t tid = lkl_host_ops.thread_create(thread_quit_immediately,
+						      NULL);
+	int ret = lkl_host_ops.thread_join(tid);
+
+	if (ret == 0) {
+		lkl_test_logf("joined %ld\n", tid);
+		return TEST_SUCCESS;
+	}
+
+	lkl_test_logf("failed joining %ld\n", tid);
+	return TEST_FAILURE;
+}
+
+LKL_TEST_CALL(start_kernel, lkl_start_kernel, 0, &lkl_host_ops,
+	     "mem=16M loglevel=8");
+LKL_TEST_CALL(stop_kernel, lkl_sys_halt, 0);
+
+struct lkl_test tests[] = {
+	LKL_TEST(mutex),
+	LKL_TEST(semaphore),
+	LKL_TEST(join),
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
+	LKL_TEST(lo_ifup),
+	LKL_TEST(gettid),
+	LKL_TEST(syscall_thread),
+	/*
+	 * Wine has an issue where the FlsCallback is not called when
+	 * the thread terminates which makes testing the automatic
+	 * syscall threads cleanup impossible under wine.
+	 */
+#ifndef __MINGW32__
+	LKL_TEST(many_syscall_threads),
+#endif
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
diff --git a/tools/lkl/tests/boot.sh b/tools/lkl/tests/boot.sh
new file mode 100755
index 000000000000..d985c04b0ac1
--- /dev/null
+++ b/tools/lkl/tests/boot.sh
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
diff --git a/tools/lkl/tests/cla.c b/tools/lkl/tests/cla.c
new file mode 100644
index 000000000000..a34badeb5f06
--- /dev/null
+++ b/tools/lkl/tests/cla.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#ifdef __MINGW32__
+#include <winsock2.h>
+#else
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#endif
+
+#include "cla.h"
+
+static int cl_arg_parse_bool(struct cl_arg *arg, const char *value)
+{
+	*((int *)arg->store) = 1;
+	return 0;
+}
+
+static int cl_arg_parse_str(struct cl_arg *arg, const char *value)
+{
+	*((const char **)arg->store) = value;
+	return 0;
+}
+
+static int cl_arg_parse_int(struct cl_arg *arg, const char *value)
+{
+	errno = 0;
+	*((int *)arg->store) = strtol(value, NULL, 0);
+	return errno == 0;
+}
+
+static int cl_arg_parse_str_set(struct cl_arg *arg, const char *value)
+{
+	const char **set = arg->set;
+	int i;
+
+	for (i = 0; set[i] != NULL; i++) {
+		if (strcmp(set[i], value) == 0) {
+			*((int *)arg->store) = i;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static int cl_arg_parse_ipv4(struct cl_arg *arg, const char *value)
+{
+	unsigned int addr;
+
+	if (!value)
+		return -1;
+
+	addr = inet_addr(value);
+	if (addr == INADDR_NONE)
+		return -1;
+	*((unsigned int *)arg->store) = addr;
+	return 0;
+}
+
+static cl_arg_parser_t parsers[] = {
+	[CL_ARG_BOOL] = cl_arg_parse_bool,
+	[CL_ARG_INT] = cl_arg_parse_int,
+	[CL_ARG_STR] = cl_arg_parse_str,
+	[CL_ARG_STR_SET] = cl_arg_parse_str_set,
+	[CL_ARG_IPV4] = cl_arg_parse_ipv4,
+};
+
+static struct cl_arg *find_short_arg(char name, struct cl_arg *args)
+{
+	struct cl_arg *arg;
+
+	for (arg = args; arg->short_name != 0; arg++) {
+		if (arg->short_name == name)
+			return arg;
+	}
+
+	return NULL;
+}
+
+static struct cl_arg *find_long_arg(const char *name, struct cl_arg *args)
+{
+	struct cl_arg *arg;
+
+	for (arg = args; arg->long_name; arg++) {
+		if (strcmp(arg->long_name, name) == 0)
+			return arg;
+	}
+
+	return NULL;
+}
+
+static void print_help(struct cl_arg *args)
+{
+	struct cl_arg *arg;
+
+	fprintf(stderr, "usage:\n");
+	for (arg = args; arg->long_name; arg++) {
+		fprintf(stderr, "-%c, --%-20s %s", arg->short_name,
+			arg->long_name, arg->help);
+		if (arg->type == CL_ARG_STR_SET) {
+			const char **set = arg->set;
+
+			fprintf(stderr, " [ ");
+			while (*set != NULL)
+				fprintf(stderr, "%s ", *(set++));
+			fprintf(stderr, "]");
+		}
+		fprintf(stderr, "\n");
+	}
+}
+
+int parse_args(int argc, const char **argv, struct cl_arg *args)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		struct cl_arg *arg = NULL;
+		cl_arg_parser_t parser;
+
+		if (argv[i][0] == '-') {
+			if (argv[i][1] != '-')
+				arg = find_short_arg(argv[i][1], args);
+			else
+				arg = find_long_arg(&argv[i][2], args);
+		}
+
+		if (!arg) {
+			fprintf(stderr, "unknown option '%s'\n", argv[i]);
+			print_help(args);
+			return -1;
+		}
+
+		if (arg->type == CL_ARG_USER || arg->type >= CL_ARG_END)
+			parser = arg->parser;
+		else
+			parser = parsers[arg->type];
+
+		if (!parser) {
+			fprintf(stderr, "can't parse --'%s'/-'%c'\n",
+				arg->long_name, args->short_name);
+			return -1;
+		}
+
+		if (parser(arg, argv[i + 1]) < 0) {
+			fprintf(stderr, "can't parse '%s'\n", argv[i]);
+			print_help(args);
+			return -1;
+		}
+
+		if (arg->has_arg)
+			i++;
+	}
+
+	return 0;
+}
diff --git a/tools/lkl/tests/cla.h b/tools/lkl/tests/cla.h
new file mode 100644
index 000000000000..f8369be02e5a
--- /dev/null
+++ b/tools/lkl/tests/cla.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_TEST_CLA_H
+#define _LKL_TEST_CLA_H
+
+enum cl_arg_type {
+	CL_ARG_USER = 0,
+	CL_ARG_BOOL,
+	CL_ARG_INT,
+	CL_ARG_STR,
+	CL_ARG_STR_SET,
+	CL_ARG_IPV4,
+	CL_ARG_END,
+};
+
+struct cl_arg;
+
+typedef int (*cl_arg_parser_t)(struct cl_arg *arg, const char *value);
+
+struct cl_arg {
+	const char *long_name;
+	char short_name;
+	const char *help;
+	int has_arg;
+	enum cl_arg_type type;
+	void *store;
+	void *set;
+	cl_arg_parser_t parser;
+};
+
+int parse_args(int argc, const char **argv, struct cl_arg *args);
+
+
+#endif /* _LKL_TEST_CLA_H */
diff --git a/tools/lkl/tests/disk.c b/tools/lkl/tests/disk.c
new file mode 100644
index 000000000000..0aa039876b54
--- /dev/null
+++ b/tools/lkl/tests/disk.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <lkl.h>
+#include <lkl_host.h>
+#ifndef __MINGW32__
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#else
+#include <windows.h>
+#endif
+
+#include "test.h"
+#include "cla.h"
+
+static struct {
+	int printk;
+	const char *disk;
+	const char *fstype;
+	int partition;
+} cla;
+
+struct cl_arg args[] = {
+	{"disk", 'd', "disk file to use", 1, CL_ARG_STR, &cla.disk},
+	{"partition", 'P', "partition to mount", 1, CL_ARG_INT, &cla.partition},
+	{"type", 't', "filesystem type", 1, CL_ARG_STR, &cla.fstype},
+	{0},
+};
+
+
+static struct lkl_disk disk;
+static int disk_id = -1;
+
+int lkl_test_disk_add(void)
+{
+#ifdef __MINGW32__
+	disk.handle = CreateFile(cla.disk, GENERIC_READ | GENERIC_WRITE,
+			       0, NULL, OPEN_EXISTING, 0, NULL);
+	if (!disk.handle)
+#else
+	disk.fd = open(cla.disk, O_RDWR);
+	if (disk.fd < 0)
+#endif
+		goto out_unlink;
+
+	disk.ops = NULL;
+
+	disk_id = lkl_disk_add(&disk);
+	if (disk_id < 0)
+		goto out_close;
+
+	goto out;
+
+out_close:
+#ifdef __MINGW32__
+	CloseHandle(disk.handle);
+#else
+	close(disk.fd);
+#endif
+
+out_unlink:
+#ifdef __MINGW32__
+	DeleteFile(cla.disk);
+#else
+	unlink(cla.disk);
+#endif
+
+out:
+	lkl_test_logf("disk fd/handle %x disk_id %d", disk.fd, disk_id);
+
+	if (disk_id >= 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+int lkl_test_disk_remove(void)
+{
+	int ret;
+
+	ret = lkl_disk_remove(disk);
+
+#ifdef __MINGW32__
+	CloseHandle(disk.handle);
+#else
+	close(disk.fd);
+#endif
+
+	if (ret == 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+
+static char mnt_point[32];
+
+LKL_TEST_CALL(mount_dev, lkl_mount_dev, 0, disk_id, cla.partition, cla.fstype,
+	      0, NULL, mnt_point, sizeof(mnt_point))
+
+static int lkl_test_umount_dev(void)
+{
+	long ret, ret2;
+
+	ret = lkl_sys_chdir("/");
+
+	ret2 = lkl_umount_dev(disk_id, cla.partition, 0, 1000);
+
+	lkl_test_logf("%ld %ld", ret, ret2);
+
+	if (!ret && !ret2)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+struct lkl_dir *dir;
+
+static int lkl_test_opendir(void)
+{
+	int err;
+
+	dir = lkl_opendir(mnt_point, &err);
+
+	lkl_test_logf("lkl_opedir(%s) = %d %s\n", mnt_point, err,
+		      lkl_strerror(err));
+
+	if (err == 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+static int lkl_test_readdir(void)
+{
+	struct lkl_linux_dirent64 *de = lkl_readdir(dir);
+	int wr = 0;
+
+	while (de) {
+		wr += lkl_test_logf("%s ", de->d_name);
+		if (wr >= 70) {
+			lkl_test_logf("\n");
+			wr = 0;
+			break;
+		}
+		de = lkl_readdir(dir);
+	}
+
+	if (lkl_errdir(dir) == 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+LKL_TEST_CALL(closedir, lkl_closedir, 0, dir);
+LKL_TEST_CALL(chdir_mnt_point, lkl_sys_chdir, 0, mnt_point);
+LKL_TEST_CALL(start_kernel, lkl_start_kernel, 0, &lkl_host_ops,
+	     "mem=16M loglevel=8");
+LKL_TEST_CALL(stop_kernel, lkl_sys_halt, 0);
+
+struct lkl_test tests[] = {
+	LKL_TEST(disk_add),
+	LKL_TEST(start_kernel),
+	LKL_TEST(mount_dev),
+	LKL_TEST(chdir_mnt_point),
+	LKL_TEST(opendir),
+	LKL_TEST(readdir),
+	LKL_TEST(closedir),
+	LKL_TEST(umount_dev),
+	LKL_TEST(stop_kernel),
+	LKL_TEST(disk_remove),
+
+};
+
+int main(int argc, const char **argv)
+{
+	if (parse_args(argc, argv, args) < 0)
+		return -1;
+
+	lkl_host_ops.print = lkl_test_log;
+
+	return lkl_test_run(tests, sizeof(tests)/sizeof(struct lkl_test),
+			    "disk %s", cla.fstype);
+}
diff --git a/tools/lkl/tests/disk.sh b/tools/lkl/tests/disk.sh
new file mode 100755
index 000000000000..9bdcb16f2d5c
--- /dev/null
+++ b/tools/lkl/tests/disk.sh
@@ -0,0 +1,61 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+
+source $script_dir/test.sh
+
+function prepfs()
+{
+    set -e
+
+    file=`mktemp`
+
+    dd if=/dev/zero of=$file bs=1024 count=204800
+
+    yes | mkfs.$1 $file
+
+    if ! [ -z $BSD_WDIR ]; then
+        $MYSSH mkdir -p $BSD_WDIR
+        ssh_copy $file $BSD_WDIR
+        rm $file
+        file=$BSD_WDIR/$(basename $file)
+    fi
+
+    export_vars file
+}
+
+function cleanfs()
+{
+    set -e
+
+    if ! [ -z $BSD_WDIR ]; then
+        $MYSSH rm $1
+        $MYSSH rm $BSD_WDIR/disk
+    else
+        rm $1
+    fi
+}
+
+if [ "$1" = "-t" ]; then
+    shift
+    fstype=$1
+    shift
+fi
+
+if [ -z "$fstype" ]; then
+    fstype="ext4"
+fi
+
+if [ -z $(which mkfs.$fstype) ]; then
+    lkl_test_plan 0 "disk $fstype"
+    echo "no mkfs.$fstype command"
+    exit 0
+fi
+
+lkl_test_plan 1 "disk $fstype"
+lkl_test_run 1 prepfs $fstype
+lkl_test_exec $script_dir/disk -d $file -t $fstype $@
+lkl_test_plan 1 "disk $fstype"
+lkl_test_run 1 cleanfs $file
+
diff --git a/tools/lkl/tests/net-setup.sh b/tools/lkl/tests/net-setup.sh
new file mode 100644
index 000000000000..0cfc42a30a54
--- /dev/null
+++ b/tools/lkl/tests/net-setup.sh
@@ -0,0 +1,73 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_IP_NETWORK=192.168.113.0
+TEST_IP_NETMASK=24
+TEST_IP6_NETWORK=fc03::0
+TEST_IP6_NETMASK=64
+TEST_MAC0="aa:bb:cc:dd:ee:ff"
+TEST_MAC1="aa:bb:cc:dd:ee:aa"
+TEST_NETSERVER_PORT=11223
+
+# $1 - count
+# $2 - netcount
+ip_add()
+{
+    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' \
+         `echo $TEST_IP_NETWORK | sed -e 's/\./ /g'`)
+    NET_COUNT=$(( 1 << (32 - $TEST_IP_NETMASK) ))
+    NEXT_IP_HEX=$(printf %.8X `echo $((0x$IP_HEX + $1 + ${2:-0} * $NET_COUNT))`)
+    NEXT_IP=$(printf '%d.%d.%d.%d\n' \
+          `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
+    echo -n "$NEXT_IP"
+}
+
+# $1 - count
+# $2 - netcount
+ip6_add()
+{
+    IP6_PREFIX=${TEST_IP6_NETWORK%*::*}
+    IP6_HOST=${TEST_IP6_NETWORK#*::*}
+    echo -n "$(printf "%x" $((0x$IP6_PREFIX+${2:-0})))::$(($IP6_HOST+$1))"
+}
+
+ip_host()
+{
+
+    ip_add 1 $1
+}
+
+ip_lkl()
+{
+    ip_add 2 $1
+}
+
+ip_host_mask()
+{
+    echo -n "$(ip_host $1)/$TEST_IP_NETMASK"
+}
+
+ip_net_mask()
+{
+    echo "$(ip_add 0 $1)/$TEST_IP_NETMASK"
+}
+
+ip6_host()
+{
+    ip6_add 1 $1
+}
+
+ip6_lkl()
+{
+    ip6_add 2 $1
+}
+
+ip6_host_mask()
+{
+    echo -n "$(ip6_host $1)/$TEST_IP6_NETMASK"
+}
+
+ip6_net_mask()
+{
+    echo "$(ip6_add 0 $1)/$TEST_IP6_NETMASK"
+}
diff --git a/tools/lkl/tests/net-test.c b/tools/lkl/tests/net-test.c
new file mode 100644
index 000000000000..5a8e39a52417
--- /dev/null
+++ b/tools/lkl/tests/net-test.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#ifdef __FreeBSD__
+#include <sys/types.h>
+#endif
+#ifdef __MINGW32__
+#include <winsock2.h>
+#else
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#endif
+
+#include <lkl.h>
+#include <lkl_host.h>
+
+#include "cla.h"
+#include "test.h"
+
+enum {
+	BACKEND_NONE,
+};
+
+const char *backends[] = { "loopback", NULL };
+static struct {
+	int backend;
+	const char *ifname;
+	int dhcp, nmlen;
+	unsigned int ip, dst, gateway, sleep;
+} cla = {
+	.backend = BACKEND_NONE,
+	.ip = INADDR_NONE,
+	.gateway = INADDR_NONE,
+	.dst = INADDR_NONE,
+	.sleep = 0,
+};
+
+
+struct cl_arg args[] = {
+	{"backend", 'b', "network backend type", 1, CL_ARG_STR_SET,
+	 &cla.backend, backends},
+	{"ifname", 'i', "interface name", 1, CL_ARG_STR, &cla.ifname},
+	{"dhcp", 'd', "use dhcp to configure LKL", 0, CL_ARG_BOOL, &cla.dhcp},
+	{"ip", 'I', "IPv4 address to use", 1, CL_ARG_IPV4, &cla.ip},
+	{"netmask-len", 'n', "IPv4 netmask length", 1, CL_ARG_INT,
+	 &cla.nmlen},
+	{"gateway", 'g', "IPv4 gateway to use", 1, CL_ARG_IPV4, &cla.gateway},
+	{"dst", 'D', "IPv4 destination address", 1, CL_ARG_IPV4, &cla.dst},
+	{"sleep", 's', "sleep", 1, CL_ARG_INT, &cla.sleep},
+	{0},
+};
+
+u_short
+in_cksum(const u_short *addr, register int len, u_short csum)
+{
+	int nleft = len;
+	const u_short *w = addr;
+	u_short answer;
+	int sum = csum;
+
+	while (nleft > 1)  {
+		sum += *w++;
+		nleft -= 2;
+	}
+
+	if (nleft == 1)
+		sum += htons(*(u_char *)w << 8);
+
+	sum = (sum >> 16) + (sum & 0xffff);
+	sum += (sum >> 16);
+	answer = ~sum;
+	return answer;
+}
+
+static int lkl_test_sleep(void)
+{
+	struct lkl_timespec ts = {
+		.tv_sec = cla.sleep,
+	};
+	int ret;
+
+	ret = lkl_sys_nanosleep((struct __lkl__kernel_timespec *)&ts, NULL);
+	if (ret < 0) {
+		lkl_test_logf("nanosleep error: %s\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_icmp(void)
+{
+	int sock, ret;
+	struct lkl_iphdr *iph;
+	struct lkl_icmphdr *icmp;
+	struct lkl_sockaddr_in saddr;
+	struct lkl_pollfd pfd;
+	char buf[32];
+
+	if (cla.dst == INADDR_NONE)
+		return TEST_SKIP;
+
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sin_family = AF_INET;
+	saddr.sin_addr.lkl_s_addr = cla.dst;
+
+	lkl_test_logf("pinging %s\n",
+		      inet_ntoa(*(struct in_addr *)&saddr.sin_addr));
+
+	sock = lkl_sys_socket(LKL_AF_INET, LKL_SOCK_RAW, LKL_IPPROTO_ICMP);
+	if (sock < 0) {
+		lkl_test_logf("socket error (%s)\n", lkl_strerror(sock));
+		return TEST_FAILURE;
+	}
+
+	icmp = malloc(sizeof(struct lkl_icmphdr));
+	icmp->type = LKL_ICMP_ECHO;
+	icmp->code = 0;
+	icmp->checksum = 0;
+	icmp->un.echo.sequence = 0;
+	icmp->un.echo.id = 0;
+	icmp->checksum = in_cksum((u_short *)icmp, sizeof(*icmp), 0);
+
+	ret = lkl_sys_sendto(sock, icmp, sizeof(*icmp), 0,
+			     (struct lkl_sockaddr *)&saddr,
+			     sizeof(saddr));
+	if (ret < 0) {
+		lkl_test_logf("sendto error (%s)\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	free(icmp);
+
+	pfd.fd = sock;
+	pfd.events = LKL_POLLIN;
+	pfd.revents = 0;
+
+	ret = lkl_sys_poll(&pfd, 1, 1000);
+	if (ret < 0) {
+		lkl_test_logf("poll error (%s)\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	ret = lkl_sys_recv(sock, buf, sizeof(buf), LKL_MSG_DONTWAIT);
+	if (ret < 0) {
+		lkl_test_logf("recv error (%s)\n", lkl_strerror(ret));
+		return TEST_FAILURE;
+	}
+
+	if (ret < (int)sizeof(struct lkl_iphdr)) {
+		lkl_test_logf("short length of received ip packet (len=%d)\n",
+			      ret);
+		return TEST_FAILURE;
+	}
+	iph = (struct lkl_iphdr *)buf;
+
+	if (ret < (int)((iph->ihl * 4) + sizeof(struct lkl_icmphdr))) {
+		lkl_test_logf("short length of received icmp packet (len=%d)\n",
+			      ret);
+		return TEST_FAILURE;
+	}
+	icmp = (struct lkl_icmphdr *)(buf + iph->ihl * 4);
+
+	/* DHCP server may issue an ICMP echo request to a dhcp client */
+	if ((icmp->type != LKL_ICMP_ECHOREPLY || icmp->code != 0) &&
+	    (icmp->type != LKL_ICMP_ECHO)) {
+		lkl_test_logf("no ICMP echo reply (type=%d, code=%d)\n",
+			      icmp->type, icmp->code);
+		return TEST_FAILURE;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static struct lkl_netdev *nd;
+
+static int lkl_test_nd_create(void)
+{
+	switch (cla.backend) {
+	case BACKEND_NONE:
+		return TEST_SKIP;
+	}
+
+	if (!nd) {
+		lkl_test_logf("failed to create netdev\n");
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int nd_id;
+
+static int lkl_test_nd_add(void)
+{
+	if (cla.backend == BACKEND_NONE)
+		return TEST_SKIP;
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_nd_remove(void)
+{
+	if (cla.backend == BACKEND_NONE)
+		return TEST_SKIP;
+
+	return TEST_SUCCESS;
+}
+
+LKL_TEST_CALL(start_kernel, lkl_start_kernel, 0, &lkl_host_ops,
+	"mem=16M loglevel=8 %s", cla.dhcp ? "ip=dhcp" : "");
+LKL_TEST_CALL(stop_kernel, lkl_sys_halt, 0);
+
+static int nd_ifindex;
+
+static int lkl_test_nd_ifindex(void)
+{
+	if (cla.backend == BACKEND_NONE)
+		return TEST_SKIP;
+
+	nd_ifindex = lkl_netdev_get_ifindex(nd_id);
+	if (nd_ifindex < 0) {
+		lkl_test_logf("failed to get ifindex for netdev id %d: %s\n",
+			      nd_id, lkl_strerror(nd_ifindex));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+LKL_TEST_CALL(if_up, lkl_if_up, 0,
+	      cla.backend == BACKEND_NONE ? 1 : nd_ifindex);
+
+static int lkl_test_set_ipv4(void)
+{
+	int ret;
+
+	if (cla.backend == BACKEND_NONE || cla.ip == LKL_INADDR_NONE)
+		return TEST_SKIP;
+
+	ret = lkl_if_set_ipv4(nd_ifindex, cla.ip, cla.nmlen);
+	if (ret < 0) {
+		lkl_test_logf("failed to set IPv4 address: %s\n",
+			      lkl_strerror(ret));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int lkl_test_set_gateway(void)
+{
+	int ret;
+
+	if (cla.backend == BACKEND_NONE || cla.gateway == LKL_INADDR_NONE)
+		return TEST_SKIP;
+
+	ret = lkl_set_ipv4_gateway(cla.gateway);
+	if (ret < 0) {
+		lkl_test_logf("failed to set IPv4 gateway: %s\n",
+			      lkl_strerror(ret));
+		return TEST_BAILOUT;
+	}
+
+	return TEST_SUCCESS;
+}
+
+struct lkl_test tests[] = {
+	LKL_TEST(nd_create),
+	LKL_TEST(nd_add),
+	LKL_TEST(start_kernel),
+	LKL_TEST(nd_ifindex),
+	LKL_TEST(if_up),
+	LKL_TEST(set_ipv4),
+	LKL_TEST(set_gateway),
+	LKL_TEST(sleep),
+	LKL_TEST(icmp),
+	LKL_TEST(nd_remove),
+	LKL_TEST(stop_kernel),
+};
+
+int main(int argc, const char **argv)
+{
+	if (parse_args(argc, argv, args) < 0)
+		return -1;
+
+	if (cla.ip != LKL_INADDR_NONE && (cla.nmlen < 0 || cla.nmlen > 32)) {
+		fprintf(stderr, "invalid netmask length %d\n", cla.nmlen);
+		return -1;
+	}
+
+	lkl_host_ops.print = lkl_test_log;
+
+	return lkl_test_run(tests, sizeof(tests)/sizeof(struct lkl_test),
+			    "net %s", backends[cla.backend]);
+}
diff --git a/tools/lkl/tests/net.sh b/tools/lkl/tests/net.sh
new file mode 100755
index 000000000000..32e8452b0406
--- /dev/null
+++ b/tools/lkl/tests/net.sh
@@ -0,0 +1,90 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+
+source $script_dir/test.sh
+source $script_dir/net-setup.sh
+
+cleanup_backend()
+{
+    set -e
+
+    case "$1" in
+    "loopback")
+        ;;
+    esac
+}
+
+get_test_ip()
+{
+    # DHCP test parameters
+    TEST_HOST=8.8.8.8
+    HOST_IF=$(lkl_test_cmd ip route get $TEST_HOST | head -n1 |cut -d ' ' -f5)
+    HOST_GW=$(lkl_test_cmd ip route get $TEST_HOST | head -n1 | cut -d ' ' -f3)
+    if lkl_test_cmd ping -c1 -w1 $HOST_GW; then
+        TEST_IP_REMOTE=$HOST_GW
+    elif lkl_test_cmd ping -c1 -w1 $TEST_HOST; then
+        TEST_IP_REMOTE=$TEST_HOST
+    else
+        echo "could not find remote test ip"
+        return $TEST_SKIP
+    fi
+
+    export_vars HOST_IF TEST_IP_REMOTE
+}
+
+setup_backend()
+{
+    set -e
+
+    if [ "$LKL_HOST_CONFIG_POSIX" != "y" ] &&
+       [ "$1" != "loopback" ]; then
+        echo "not a posix environment"
+        return $TEST_SKIP
+    fi
+
+    case "$1" in
+    "loopback")
+        ;;
+    *)
+        echo "don't know how to setup backend $1"
+        return $TEST_FAILED
+        ;;
+    esac
+}
+
+run_tests()
+{
+    case "$1" in
+    "loopback")
+        lkl_test_exec $script_dir/net-test --dst 127.0.0.1
+        ;;
+    esac
+}
+
+if [ "$1" = "-b" ]; then
+    shift
+    backend=$1
+    shift
+fi
+
+if [ -z "$backend" ]; then
+    backend="loopback"
+fi
+
+lkl_test_plan 1 "net $backend"
+lkl_test_run 1 setup_backend $backend
+
+if [ $? = $TEST_SKIP ]; then
+    exit 0
+fi
+
+trap "cleanup_backend $backend" EXIT
+
+run_tests $backend
+
+trap : EXIT
+lkl_test_plan 1 "net $backend"
+lkl_test_run 1 cleanup_backend $backend
+
diff --git a/tools/lkl/tests/run.py b/tools/lkl/tests/run.py
new file mode 100755
index 000000000000..b72299aaabee
--- /dev/null
+++ b/tools/lkl/tests/run.py
@@ -0,0 +1,179 @@
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
+    'disk.sh -t ext4',
+    'disk.sh -t vfat',
+    'disk.sh -t btrfs',
+    'net.sh -b loopback',
+    'lklfuse.sh -t ext4',
+    'lklfuse.sh -t vfat',
+    'lklfuse.sh -t btrfs',
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
diff --git a/tools/lkl/tests/tap13.py b/tools/lkl/tests/tap13.py
new file mode 100644
index 000000000000..65c73cda7ca1
--- /dev/null
+++ b/tools/lkl/tests/tap13.py
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
diff --git a/tools/lkl/tests/test.c b/tools/lkl/tests/test.c
new file mode 100644
index 000000000000..3e334d106c48
--- /dev/null
+++ b/tools/lkl/tests/test.c
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
+			/* fall through */
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
diff --git a/tools/lkl/tests/test.h b/tools/lkl/tests/test.h
new file mode 100644
index 000000000000..f63ad6d419cb
--- /dev/null
+++ b/tools/lkl/tests/test.h
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
diff --git a/tools/lkl/tests/test.sh b/tools/lkl/tests/test.sh
new file mode 100644
index 000000000000..f4d652b9fbe8
--- /dev/null
+++ b/tools/lkl/tests/test.sh
@@ -0,0 +1,182 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+basedir=$(cd $script_dir/..; pwd)
+base_objdir=$(cd ${OUTPUT}/; pwd)
+source ${script_dir}/autoconf.sh
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
diff --git a/tools/lkl/tests/valgrind.supp b/tools/lkl/tests/valgrind.supp
new file mode 100644
index 000000000000..2a0e270f2292
--- /dev/null
+++ b/tools/lkl/tests/valgrind.supp
@@ -0,0 +1,105 @@
+{
+   <unfinished timer 1>
+   Memcheck:Leak
+   match-leak-kinds: possible
+   ...
+   fun:pthread_create@@GLIBC_2.2.5
+   fun:__start_helper_thread
+   fun:__pthread_once_slow
+   fun:timer_create@@GLIBC_2.3.3
+   fun:timer_alloc
+   fun:clockevent_set_state_oneshot
+   ...
+   fun:__clockevents_switch_state
+   fun:clockevents_switch_state
+   fun:tick_setup_periodic
+   ...
+}
+
+{
+   <unfinished timer 2>
+   Memcheck:Leak
+   match-leak-kinds: possible
+   ...
+   fun:allocate_stack
+   fun:pthread_create@@GLIBC_2.2.5
+   fun:timer_helper_thread
+   fun:start_thread
+   ...
+}
+
+{
+   <pid1 kernel thread>
+   Memcheck:Leak
+   match-leak-kinds: possible
+   ...
+   fun:thread_create
+   fun:copy_thread
+   fun:copy_thread_tls
+   ...
+   fun:rest_init
+   ...
+   fun:start_kernel
+   ...
+}
+
+{
+   <xfs uninitialized buf error: delete this once upstream is fixed>
+   Memcheck:Value8
+   fun:crc32_body
+   fun:crc32_le_generic
+   fun:__crc32c_le
+   fun:chksum_update
+   fun:crypto_shash_update
+   fun:crc32c
+   fun:xlog_cksum
+}
+
+{
+   <xfs pwrite64 issue: delete this once upstream is fixed>
+   Memcheck:Param
+   pwrite64(buf)
+   ...
+   fun:blk_request
+   fun:blk_enqueue
+   fun:virtio_process_one
+   fun:virtio_process_queue
+   fun:virtio_write
+   fun:__raw_writel
+   fun:writel
+   fun:vm_notify
+   fun:virtqueue_notify
+   fun:virtio_queue_rq
+   fun:blk_mq_dispatch_rq_list
+   fun:blk_mq_sched_dispatch_requests
+}
+
+{
+   <virtio_net_pipe xmits>
+   Memcheck:Param
+   writev(vector[...])
+   ...
+   fun:fd_net_tx
+   fun:net_enqueue
+   fun:virtio_process_one
+   fun:virtio_process_queue
+   fun:virtio_write
+   fun:__raw_writel
+   fun:writel
+   fun:vm_notify
+   ...
+   fun:netdev_start_xmit
+   ...
+}
+
+{
+   <ubd_kern.c>
+   Memcheck:Param
+   read(buf)
+   ...
+   fun:read
+   fun:os_read_file
+   fun:bulk_req_safe_read.constprop.11
+   fun:io_thread
+   ...
+}
diff --git a/tools/lkl/tests/valgrind2xunit.py b/tools/lkl/tests/valgrind2xunit.py
new file mode 100755
index 000000000000..ab7c12b83377
--- /dev/null
+++ b/tools/lkl/tests/valgrind2xunit.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+
+##
+## Downloader from
+## http://humdi.net/wiki/tips/valgrind-to-xunit-xml-converter
+##
+
+import xml.etree.ElementTree as ET
+import sys
+import os
+
+fname = sys.argv[1]
+if fname is None:
+    fname = 'valgrind.xml'
+
+doc = ET.parse(fname)
+errors = doc.findall('.//error')
+
+out = open(os.path.splitext(os.path.basename(fname))[0]+'_xunit.xml',"w")
+out.write('<?xml version="1.0" encoding="UTF-8"?>\n')
+out.write('<testsuite name="valgrind" tests="'+str(len(errors))+'" errors="0" failures="'+str(len(errors))+'" skip="0">\n')
+errorcount=0
+for error in errors:
+    errorcount=errorcount+1
+
+    kind = error.find('kind')
+    what = error.find('what')
+    if  what == None:
+        what = error.find('xwhat/text')
+
+    stack = error.find('stack')
+    frames = stack.findall('frame')
+
+    for frame in frames:
+        fi = frame.find('file')
+        li = frame.find('line')
+        if fi != None and li != None:
+            break
+
+    if fi != None and li != None:
+        out.write('    <testcase classname="ValgrindMemoryCheck" name="Memory check '+str(errorcount)+' ('+kind.text+', '+fi.text+':'+li.text+')" time="0">\n')
+    else:
+        out.write('    <testcase classname="ValgrindMemoryCheck" name="Memory check '+str(errorcount)+' ('+kind.text+')" time="0">\n')
+    out.write('        <error type="'+kind.text+'">\n')
+    out.write('  '+what.text+'\n\n')
+
+    for frame in frames:
+        ip = frame.find('ip')
+        fn = frame.find('fn')
+        fi = frame.find('file')
+        li = frame.find('line')
+
+        if fn is None:
+            bodytext = '(unresolved symbol)'
+        else:
+            bodytext = fn.text
+        bodytext = bodytext.replace("&","&amp;")
+        bodytext = bodytext.replace("<","&lt;")
+        bodytext = bodytext.replace(">","&gt;")
+        if fi != None and li != None:
+            out.write('  '+ip.text+': '+bodytext+' ('+fi.text+':'+li.text+')\n')
+        else:
+            out.write('  '+ip.text+': '+bodytext+'\n')
+
+    out.write('        </error>\n')
+    out.write('    </testcase>\n')
+out.write('</testsuite>\n')
+out.close()
-- 
2.21.0 (Apple Git-122.2)

