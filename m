Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B132F3F4F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKHFES (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33110 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfKHFES (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so3319158pgn.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WO9m4WzshepB6PS603/vcxAyp/YZaL7tWfAUAPvTLlw=;
        b=dSTDhwSUeeTr0NJIObTdisO1upij8ctcARHf/WE/qr6GXCGUTbnbTYsgxBlBN8GV+q
         46oMVXdfOxR7DVCQDKtlw3p+A8UMG5BxFwkEtgOOOm+jm6VA9dHaVk5N3VgdTmheSsT0
         9iV6MJfV3o6Cs736GZ8bAqPKsmnhhWwziAOCSnx65BwGqq3lDyHAtbdUHB5TVa/jEpUb
         fTMErty4LzAVlFx2xkEgBNzQ4nySaHPgNKreqPSELb1eSN6gX6IZ3AuIPHcX/kN4wtmY
         CZTm4grpy+7QCKgfrTqP9fa/f/CxwuCHxr6ZSOuU5TlQdNR0cQEa1Ka3y0gzCbXi9YIt
         dn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WO9m4WzshepB6PS603/vcxAyp/YZaL7tWfAUAPvTLlw=;
        b=lXi4Tv/m89rHp9PoWiTMIK1jQz8jC2z978avRZMtn4fEr/eyDC0we8RZigRyZsph1k
         7AQSbTn/pgvFkYmpok0CBGtwSIJ1NBh/g8Q1CJ5WzUQje3JghWaXf5aG4EhVFEI/oubp
         5yMCTJciyzRYu0NOXAfvQQR82556+Ap+5zbHWhO8KHMbh2iMP8QeXr/s5x81vRzGNaQ5
         9Gbw6KAofkZZfqH+DGJCM7jCPia26PUDrrUDlCXYQxtUynfekdMy7K0Mz+R6c4J69gca
         0xGg7JJMkiiqHNSBUfdzOq1ubBB0KJXLNgE23GmvlpRdrRu+uI5FG1F79GSdImbi1biR
         2JmQ==
X-Gm-Message-State: APjAAAXIGC5qj0FwydQ2BIvQtNM3eOjyJfdGZf99IjeVFdc3x95L7SVe
        5CpRH0mgwXuJdxebK6VGY/0=
X-Google-Smtp-Source: APXvYqzrDypvTOFqang9w+A1eMasLnQaKo1mQQoZ3Jeju3xMw1wd4PZV310ngQn3V3xuuXYRZ6LpbA==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr9401881pgk.255.1573189455740;
        Thu, 07 Nov 2019 21:04:15 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id 70sm4979438pfw.160.2019.11.07.21.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:14 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 97B37201ACFE7D; Fri,  8 Nov 2019 14:04:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Xiao Jia <xiaoj@google.com>, Yuan Liu <liuyuan@google.com>
Subject: [RFC v2 28/37] lkl: add system call hijack support
Date:   Fri,  8 Nov 2019 14:02:43 +0900
Message-Id: <66c17c6fe352c81f1f1d9de52d68215df9b8faf8.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit introduces initial support of system call hijack, based on
LD_PRELOAD with POSIX applications on a host.

Note that system call hijack by renaming symbol by LD_PRELOAD is not a
complete solution: it must address various issues with dirty tricks.

Those tricks/issues are:
- introduce file descriptor offset (i.e., fd + offset)
- path name isolation (i.e., chrooted)
- need of handling mixture of fd between host and lkl-ed ones
- un-hijackable symbol (__socket inside if_nametoindex() of linux
  glibc) needs to be hijacked by upper call (i.e., if_nametoindex)

Nevertheless, it is powerful in some case such as replacing network
stack only for an application.

It has been tested with socket(AF_INET/AF_INET6/AF_NETLINK) without any
external netdevices, i.e. only works with localhost (127.0.0.1/::1).
It may need more work on non-Linux host.

The below should work on Linux.
% ./tools/lkl/bin/hijack.sh ip ad

Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Thomas Liebetraut <thomas@tommie-lie.de>
Signed-off-by: Xiao Jia <xiaoj@google.com>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
[Octavian: use lkl_sys_* calls instead of lkl_sys_wrapper_* calls]
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/Targets              |   9 +
 tools/lkl/bin/lkl-hijack.sh    |  23 +
 tools/lkl/lib/hijack/Build     |   4 +
 tools/lkl/lib/hijack/hijack.c  | 607 +++++++++++++++++++++++++++
 tools/lkl/lib/hijack/init.c    | 241 +++++++++++
 tools/lkl/lib/hijack/init.h    |   8 +
 tools/lkl/lib/hijack/xlate.c   | 613 +++++++++++++++++++++++++++
 tools/lkl/lib/hijack/xlate.h   |  13 +
 tools/lkl/tests/hijack-test.sh | 737 +++++++++++++++++++++++++++++++++
 tools/lkl/tests/run_netperf.sh |  98 +++++
 10 files changed, 2353 insertions(+)
 create mode 100755 tools/lkl/bin/lkl-hijack.sh
 create mode 100644 tools/lkl/lib/hijack/Build
 create mode 100644 tools/lkl/lib/hijack/hijack.c
 create mode 100644 tools/lkl/lib/hijack/init.c
 create mode 100644 tools/lkl/lib/hijack/init.h
 create mode 100644 tools/lkl/lib/hijack/xlate.c
 create mode 100644 tools/lkl/lib/hijack/xlate.h
 create mode 100755 tools/lkl/tests/hijack-test.sh
 create mode 100755 tools/lkl/tests/run_netperf.sh

diff --git a/tools/lkl/Targets b/tools/lkl/Targets
index 5a4b3508f0a2..3ec093af1722 100644
--- a/tools/lkl/Targets
+++ b/tools/lkl/Targets
@@ -14,3 +14,12 @@ LDLIBS_fs2tar-$(LKL_HOST_CONFIG_NEEDS_LARGP) += -largp
 
 progs-$(LKL_HOST_CONFIG_FUSE) += lklfuse
 LDLIBS_lklfuse-y := -lfuse
+
+ifneq ($(LKL_HOST_CONFIG_BSD),y)
+libs-$(LKL_HOST_CONFIG_POSIX) += lib/hijack/liblkl-hijack
+endif
+LDFLAGS_lib/hijack/liblkl-hijack-y += -shared -nodefaultlibs
+LDLIBS_lib/hijack/liblkl-hijack-y += -ldl
+LDLIBS_lib/hijack/liblkl-hijack-$(LKL_HOST_CONFIG_ARM) += -lgcc -lc
+LDLIBS_lib/hijack/liblkl-hijack-$(LKL_HOST_CONFIG_AARCH64) += -lc
+LDLIBS_lib/hijack/liblkl-hijack-$(LKL_HOST_CONFIG_I386) += -lc_nonshared
diff --git a/tools/lkl/bin/lkl-hijack.sh b/tools/lkl/bin/lkl-hijack.sh
new file mode 100755
index 000000000000..7cf92856dfad
--- /dev/null
+++ b/tools/lkl/bin/lkl-hijack.sh
@@ -0,0 +1,23 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+##
+## This wrapper script works to replace system calls symbols such as
+## socket(2), recvmsg(2) for the redirection to LKL. Ideally it works
+## with any applications, but in practice (tm) it depends on the maturity
+## of hijack library (liblkl-hijack.so).
+##
+## Since LD_PRELOAD technique with setuid/setgid binary is tricky, you may
+## need to use sudo (or equivalents) to do it (e.g., ping).
+##
+## % sudo hijack.sh ping 127.0.0.1
+##
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+
+export LD_LIBRARY_PATH=${script_dir}/../lib/hijack
+if [ -n ${LKL_HIJACK_DEBUG+x}  ]
+then
+  trap '' TSTP
+fi
+LD_PRELOAD=liblkl-hijack.so $*
diff --git a/tools/lkl/lib/hijack/Build b/tools/lkl/lib/hijack/Build
new file mode 100644
index 000000000000..e68e93a3328a
--- /dev/null
+++ b/tools/lkl/lib/hijack/Build
@@ -0,0 +1,4 @@
+liblkl-hijack-y += hijack.o
+liblkl-hijack-y += init.o
+liblkl-hijack-y += xlate.o
+
diff --git a/tools/lkl/lib/hijack/hijack.c b/tools/lkl/lib/hijack/hijack.c
new file mode 100644
index 000000000000..485c15d7c279
--- /dev/null
+++ b/tools/lkl/lib/hijack/hijack.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * system calls hijack code
+ * Copyright (c) 2015 Hajime Tazaki
+ *
+ * Author: Hajime Tazaki <tazaki@sfc.wide.ad.jp>
+ *
+ * Note: some of the code is picked from rumpkernel, written by Antti Kantee.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#define __USE_GNU
+#include <dlfcn.h>
+#include <sys/socket.h>
+#include <sys/select.h>
+#include <sys/epoll.h>
+#include <stdint.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <poll.h>
+#include <sys/ioctl.h>
+#include <assert.h>
+#include <pthread.h>
+#include <lkl.h>
+#include <lkl_host.h>
+
+#include "xlate.h"
+#include "init.h"
+
+static int is_lklfd(int fd)
+{
+	if (fd < LKL_FD_OFFSET)
+		return 0;
+
+	return 1;
+}
+
+static void *resolve_sym(const char *sym)
+{
+	void *resolv;
+
+	resolv = dlsym(RTLD_NEXT, sym);
+	if (!resolv) {
+		fprintf(stderr, "dlsym fail %s (%s)\n", sym, dlerror());
+		assert(0);
+	}
+	return resolv;
+}
+
+typedef long (*host_call)(long p1, long p2, long p3, long p4, long p5, long p6);
+
+static host_call host_calls[__lkl__NR_syscalls];
+/* internally managed fd list for epoll */
+int dual_fds[LKL_FD_OFFSET];
+
+#define HOOK_FD_CALL(name)						\
+	static void __attribute__((constructor(101)))			\
+	init_host_##name(void)						\
+	{								\
+		host_calls[__lkl__NR_##name] = resolve_sym(#name);	\
+	}								\
+									\
+	long name##_hook(long p1, long p2, long p3, long p4, long p5,	\
+			 long p6)					\
+	{								\
+		long p[6] = {p1, p2, p3, p4, p5, p6 };			\
+									\
+		if (!host_calls[__lkl__NR_##name])			\
+			host_calls[__lkl__NR_##name] = resolve_sym(#name); \
+		if (!is_lklfd(p1))					\
+			return host_calls[__lkl__NR_##name](p1, p2, p3,	\
+							    p4, p5, p6); \
+									\
+		return lkl_set_errno(lkl_syscall(__lkl__NR_##name, p));	\
+	}								\
+	asm(".global " #name);						\
+	asm(".set " #name "," #name "_hook")
+
+#define HOOK_CALL_USE_HOST_BEFORE_START(name)				\
+	static void __attribute__((constructor(101)))			\
+	init_host_##name(void)						\
+	{								\
+		host_calls[__lkl__NR_##name] = resolve_sym(#name);	\
+	}								\
+									\
+	long name##_hook(long p1, long p2, long p3, long p4, long p5,	\
+			 long p6)					\
+	{								\
+		long p[6] = {p1, p2, p3, p4, p5, p6 };			\
+									\
+		if (!host_calls[__lkl__NR_##name])			\
+			host_calls[__lkl__NR_##name] = resolve_sym(#name); \
+		if (!lkl_running)					\
+			return host_calls[__lkl__NR_##name](p1, p2, p3,	\
+							    p4, p5, p6); \
+									\
+		return lkl_set_errno(lkl_syscall(__lkl__NR_##name, p));	\
+	}								\
+	asm(".global " #name);						\
+	asm(".set " #name "," #name "_hook")
+
+#define HOST_CALL(name)							\
+	static long (*host_##name)();					\
+	static void __attribute__((constructor(101)))			\
+	init2_host_##name(void)						\
+	{								\
+		host_##name = resolve_sym(#name);			\
+	}
+
+#define HOOK_CALL(name)							\
+	long name##_hook(long p1, long p2, long p3, long p4, long p5,	\
+			 long p6)					\
+	{								\
+		long p[6] = {p1, p2, p3, p4, p5, p6};			\
+									\
+		return lkl_set_errno(lkl_syscall(__lkl__NR_##name, p));	\
+	}								\
+	asm(".global " #name);						\
+	asm(".set " #name "," #name "_hook")
+
+#define CHECK_HOST_CALL(name)					\
+	do {							\
+		if (!host_##name)				\
+			host_##name = resolve_sym(#name);	\
+	} while (0)
+
+static int lkl_call(int nr, int args, ...)
+{
+	long params[6];
+	va_list vl;
+	int i;
+
+	va_start(vl, args);
+	for (i = 0; i < args; i++)
+		params[i] = va_arg(vl, long);
+	va_end(vl);
+
+	return lkl_set_errno(lkl_syscall(nr, params));
+}
+
+HOOK_FD_CALL(recvmsg);
+HOOK_FD_CALL(sendmsg);
+HOOK_FD_CALL(sendmmsg);
+HOOK_FD_CALL(getsockname);
+HOOK_FD_CALL(getpeername);
+HOOK_FD_CALL(bind);
+HOOK_FD_CALL(connect);
+HOOK_FD_CALL(listen);
+HOOK_FD_CALL(shutdown);
+HOOK_FD_CALL(accept);
+HOOK_FD_CALL(write);
+HOOK_FD_CALL(writev);
+HOOK_FD_CALL(sendto);
+HOOK_FD_CALL(read);
+HOOK_FD_CALL(readv);
+HOOK_FD_CALL(recvfrom);
+HOOK_FD_CALL(splice);
+HOOK_FD_CALL(vmsplice);
+
+HOOK_CALL_USE_HOST_BEFORE_START(accept4);
+HOOK_CALL_USE_HOST_BEFORE_START(pipe2);
+
+HOST_CALL(write);
+HOST_CALL(pipe2);
+
+HOST_CALL(setsockopt);
+int setsockopt(int fd, int level, int optname, const void *optval,
+	       socklen_t optlen)
+{
+	CHECK_HOST_CALL(setsockopt);
+	if (!is_lklfd(fd))
+		return host_setsockopt(fd, level, optname, optval, optlen);
+	return lkl_call(__lkl__NR_setsockopt, 5, fd, lkl_solevel_xlate(level),
+			lkl_soname_xlate(optname), (void *)optval, optlen);
+}
+
+HOST_CALL(getsockopt);
+int getsockopt(int fd, int level, int optname, void *optval, socklen_t *optlen)
+{
+	CHECK_HOST_CALL(getsockopt);
+	if (!is_lklfd(fd))
+		return host_getsockopt(fd, level, optname, optval, optlen);
+	return lkl_call(__lkl__NR_getsockopt, 5, fd, lkl_solevel_xlate(level),
+			lkl_soname_xlate(optname), optval, (int *)optlen);
+}
+
+HOST_CALL(socket);
+int socket(int domain, int type, int protocol)
+{
+	CHECK_HOST_CALL(socket);
+	if (domain == AF_UNIX || domain == PF_PACKET)
+		return host_socket(domain, type, protocol);
+
+	if (!lkl_running)
+		return host_socket(domain, type, protocol);
+
+	return lkl_call(__lkl__NR_socket, 3, domain, type, protocol);
+}
+
+HOST_CALL(ioctl);
+int ioctl(int fd, unsigned long req, ...)
+{
+	va_list vl;
+	long arg;
+
+	va_start(vl, req);
+	arg = va_arg(vl, long);
+	va_end(vl);
+
+	CHECK_HOST_CALL(ioctl);
+
+	if (!is_lklfd(fd))
+		return host_ioctl(fd, req, arg);
+	return lkl_call(__lkl__NR_ioctl, 3, fd, lkl_ioctl_req_xlate(req), arg);
+}
+
+
+HOST_CALL(fcntl);
+int fcntl(int fd, int cmd, ...)
+{
+	va_list vl;
+	long arg;
+
+	va_start(vl, cmd);
+	arg = va_arg(vl, long);
+	va_end(vl);
+
+	CHECK_HOST_CALL(fcntl);
+
+	if (!is_lklfd(fd))
+		return host_fcntl(fd, cmd, arg);
+	return lkl_call(__lkl__NR_fcntl, 3, fd, lkl_fcntl_cmd_xlate(cmd), arg);
+}
+
+HOST_CALL(poll);
+int poll(struct pollfd *fds, nfds_t nfds, int timeout)
+{
+	unsigned int i, lklfds = 0, hostfds = 0;
+
+	CHECK_HOST_CALL(poll);
+
+	for (i = 0; i < nfds; i++) {
+		if (is_lklfd(fds[i].fd))
+			lklfds = 1;
+		else
+			hostfds = 1;
+	}
+
+	/* FIXME: need to handle mixed case of hostfd and lklfd. */
+	if (lklfds && hostfds)
+		return lkl_set_errno(-LKL_EOPNOTSUPP);
+
+
+	if (hostfds)
+		return host_poll(fds, nfds, timeout);
+
+	return lkl_sys_poll((struct lkl_pollfd *)fds, nfds, timeout);
+}
+
+int __poll(struct pollfd *, nfds_t, int) __attribute__((alias("poll")));
+
+HOST_CALL(select);
+int select(int nfds, fd_set *r, fd_set *w, fd_set *e, struct timeval *t)
+{
+	int fd, hostfds = 0, lklfds = 0;
+
+	CHECK_HOST_CALL(select);
+
+	for (fd = 0; fd < nfds; fd++) {
+		if (r != 0 && FD_ISSET(fd, r)) {
+			if (is_lklfd(fd))
+				lklfds = 1;
+			else
+				hostfds = 1;
+		}
+		if (w != 0 && FD_ISSET(fd, w)) {
+			if (is_lklfd(fd))
+				lklfds = 1;
+			else
+				hostfds = 1;
+		}
+		if (e != 0 && FD_ISSET(fd, e)) {
+			if (is_lklfd(fd))
+				lklfds = 1;
+			else
+				hostfds = 1;
+		}
+	}
+
+	/* FIXME: handle mixed case of hostfd and lklfd */
+	if (lklfds && hostfds)
+		return lkl_set_errno(-LKL_EOPNOTSUPP);
+
+	if (hostfds)
+		return host_select(nfds, r, w, e, t);
+
+	return lkl_sys_select(nfds, (lkl_fd_set *)r, (lkl_fd_set *)w,
+			      (lkl_fd_set *)e, (struct lkl_timeval *)t);
+}
+
+HOST_CALL(close);
+int close(int fd)
+{
+	CHECK_HOST_CALL(close);
+
+	if (!is_lklfd(fd)) {
+		/* handle epoll's dual_fd */
+		if ((dual_fds[fd] != -1) && lkl_running) {
+			lkl_call(__lkl__NR_close, 1, dual_fds[fd]);
+			dual_fds[fd] = -1;
+		}
+
+		return host_close(fd);
+	}
+
+	return lkl_call(__lkl__NR_close, 1, fd);
+}
+
+HOST_CALL(epoll_create);
+int epoll_create(int size)
+{
+	int host_fd;
+
+	CHECK_HOST_CALL(epoll_create);
+
+	host_fd = host_epoll_create(size);
+	if (!host_fd) {
+		fprintf(stderr, "%s fail (%d)\n", __func__, errno);
+		return -1;
+	}
+
+	if (!lkl_running)
+		return host_fd;
+
+	dual_fds[host_fd] = lkl_sys_epoll_create(size);
+
+	/* always returns the host fd */
+	return host_fd;
+}
+
+HOST_CALL(epoll_create1);
+int epoll_create1(int flags)
+{
+	int host_fd;
+
+	CHECK_HOST_CALL(epoll_create1);
+
+	host_fd = host_epoll_create1(flags);
+	if (!host_fd) {
+		fprintf(stderr, "%s fail (%d)\n", __func__, errno);
+		return -1;
+	}
+
+	if (!lkl_running)
+		return host_fd;
+
+	dual_fds[host_fd] = lkl_sys_epoll_create1(flags);
+
+	/* always returns the host fd */
+	return host_fd;
+}
+
+
+HOST_CALL(epoll_ctl);
+int epoll_ctl(int epollfd, int op, int fd, struct epoll_event *event)
+{
+	CHECK_HOST_CALL(epoll_ctl);
+
+	if (!is_lklfd(fd))
+		return host_epoll_ctl(epollfd, op, fd, event);
+
+	return lkl_call(__lkl__NR_epoll_ctl, 4, dual_fds[epollfd],
+			op, fd, event);
+}
+
+struct epollarg {
+	int epfd;
+	struct epoll_event *events;
+	int maxevents;
+	int timeout;
+	int pipefd;
+	int errnum;
+};
+
+HOST_CALL(epoll_wait)
+static void *host_epollwait(void *arg)
+{
+	struct epollarg *earg = arg;
+	int ret;
+
+	ret = host_epoll_wait(earg->epfd, earg->events,
+			      earg->maxevents, earg->timeout);
+	if (ret == -1)
+		earg->errnum = errno;
+	lkl_call(__lkl__NR_write, 3, earg->pipefd, &ret, sizeof(ret));
+
+	return (void *)(intptr_t)ret;
+}
+
+int epoll_wait(int epfd, struct epoll_event *events,
+	       int maxevents, int timeout)
+{
+	CHECK_HOST_CALL(epoll_wait);
+	CHECK_HOST_CALL(pipe2);
+
+	int l_pipe[2] = {-1, -1}, h_pipe[2] = {-1, -1};
+	struct epoll_event host_ev, lkl_ev;
+	int ret_events = maxevents;
+	struct epoll_event h_events[ret_events], l_events[ret_events];
+	struct epollarg earg;
+	pthread_t thread;
+	void *trv_val;
+	int i, ret, ret_lkl, ret_host;
+
+	ret = lkl_sys_pipe(l_pipe);
+	if (ret == -1) {
+		fprintf(stderr, "lkl pipe error(errno=%d)\n", errno);
+		return -1;
+	}
+
+	ret = host_pipe2(h_pipe, 0);
+	if (ret == -1) {
+		fprintf(stderr, "host pipe error(errno=%d)\n", errno);
+		return -1;
+	}
+
+	if (dual_fds[epfd] == -1) {
+		fprintf(stderr, "epollfd isn't available (%d)\n", epfd);
+		abort();
+	}
+
+	/* wait pipe at host/lkl epoll_fd */
+	memset(&lkl_ev, 0, sizeof(lkl_ev));
+	lkl_ev.events = EPOLLIN;
+	lkl_ev.data.fd = l_pipe[0];
+	ret = lkl_call(__lkl__NR_epoll_ctl, 4, dual_fds[epfd], EPOLL_CTL_ADD,
+		       l_pipe[0], &lkl_ev);
+	if (ret == -1) {
+		fprintf(stderr, "epoll_ctl error(epfd=%d:%d, fd=%d, err=%d)\n",
+			epfd, dual_fds[epfd], l_pipe[0], errno);
+		return -1;
+	}
+
+	memset(&host_ev, 0, sizeof(host_ev));
+	host_ev.events = EPOLLIN;
+	host_ev.data.fd = h_pipe[0];
+	ret = host_epoll_ctl(epfd, EPOLL_CTL_ADD, h_pipe[0], &host_ev);
+	if (ret == -1) {
+		fprintf(stderr, "host epoll_ctl error(%d, %d, %d, %d)\n",
+			epfd, h_pipe[0], h_pipe[1], errno);
+		return -1;
+	}
+
+
+	/* now wait by epoll_wait on 2 threads */
+	memset(h_events, 0, sizeof(struct epoll_event) * ret_events);
+	memset(l_events, 0, sizeof(struct epoll_event) * ret_events);
+	earg.epfd = epfd;
+	earg.events = h_events;
+	earg.maxevents = maxevents;
+	earg.timeout = timeout;
+	earg.pipefd = l_pipe[1];
+	pthread_create(&thread, NULL, host_epollwait, &earg);
+
+	ret_lkl = lkl_sys_epoll_wait(dual_fds[epfd],
+				     (struct lkl_epoll_event *)l_events,
+				     maxevents, timeout);
+	if (ret_lkl == -1) {
+		fprintf(stderr,
+			"lkl_%s_wait error(epfd=%d:%d, fd=%d, err=%d)\n",
+			__func__, epfd, dual_fds[epfd], l_pipe[0], errno);
+		return -1;
+	}
+	host_write(h_pipe[1], &ret, sizeof(ret));
+	pthread_join(thread, &trv_val);
+	ret_host = (int)(intptr_t)trv_val;
+	if (ret_host == -1) {
+		fprintf(stderr,
+			"host epoll_ctl error(%d, %d, %d, %d)\n", epfd,
+			h_pipe[0], h_pipe[1], errno);
+		return -1;
+	}
+
+	ret = lkl_call(__lkl__NR_epoll_ctl, 4, dual_fds[epfd], EPOLL_CTL_DEL,
+		       l_pipe[0], &lkl_ev);
+	if (ret == -1) {
+		fprintf(stderr,
+			"lkl epoll_ctl error(epfd=%d:%d, fd=%d, err=%d)\n",
+			epfd, dual_fds[epfd], l_pipe[0], errno);
+		return -1;
+	}
+
+	ret = host_epoll_ctl(epfd, EPOLL_CTL_DEL, h_pipe[0], &host_ev);
+	if (ret == -1) {
+		fprintf(stderr, "host epoll_ctl error(%d, %d, %d, %d)\n",
+			epfd, h_pipe[0], h_pipe[1], errno);
+		return -1;
+	}
+
+	memset(events, 0, sizeof(struct epoll_event) * maxevents);
+	ret = 0;
+	if (ret_host > 0) {
+		for (i = 0; i < ret_host; i++) {
+			if (h_events[i].data.fd == h_pipe[0])
+				continue;
+			if (is_lklfd(h_events[i].data.fd))
+				continue;
+
+			memcpy(events, &(h_events[i]),
+			       sizeof(struct epoll_event));
+			events++;
+			ret++;
+		}
+	}
+	if (ret_lkl > 0) {
+		for (i = 0; i < ret_lkl; i++) {
+			if (l_events[i].data.fd == l_pipe[0])
+				continue;
+			if (!is_lklfd(l_events[i].data.fd))
+				continue;
+
+			memcpy(events, &(l_events[i]),
+			       sizeof(struct epoll_event));
+			events++;
+			ret++;
+		}
+	}
+
+	lkl_call(__lkl__NR_close, 1, l_pipe[0]);
+	lkl_call(__lkl__NR_close, 1, l_pipe[1]);
+	host_close(h_pipe[0]);
+	host_close(h_pipe[1]);
+
+	return ret;
+}
+
+int eventfd(unsigned int count, int flags)
+{
+	if (!lkl_running) {
+		int (*f)(unsigned int a, int b) = resolve_sym("eventfd");
+
+		return f(count, flags);
+	}
+
+	return lkl_sys_eventfd2(count, flags);
+}
+
+HOST_CALL(eventfd_read);
+int eventfd_read(int fd, uint64_t *value)
+{
+	CHECK_HOST_CALL(eventfd_read);
+
+	if (!is_lklfd(fd))
+		return host_eventfd_read(fd, value);
+
+	return lkl_sys_read(fd, (void *) value,
+			    sizeof(*value)) != sizeof(*value) ? -1 : 0;
+}
+
+HOST_CALL(eventfd_write);
+int eventfd_write(int fd, uint64_t value)
+{
+	CHECK_HOST_CALL(eventfd_write);
+
+	if (!is_lklfd(fd))
+		return host_eventfd_write(fd, value);
+
+	return lkl_sys_write(fd, (void *) &value,
+			     sizeof(value)) != sizeof(value) ? -1 : 0;
+}
+
+HOST_CALL(mmap)
+void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
+{
+	CHECK_HOST_CALL(mmap);
+
+	if (addr != NULL || flags != (MAP_ANONYMOUS|MAP_PRIVATE) ||
+	    prot != (PROT_READ|PROT_WRITE) || fd != -2 || offset != 0)
+		return (void *)host_mmap(addr, length, prot, flags, fd, offset);
+	return lkl_sys_mmap(addr, length, prot, flags, fd, offset);
+}
+
+ssize_t send(int fd, const void *buf, size_t len, int flags)
+{
+	return sendto(fd, buf, len, flags, 0, 0);
+}
+
+ssize_t recv(int fd, void *buf, size_t len, int flags)
+{
+	return recvfrom(fd, buf, len, flags, 0, 0);
+}
+
+extern int pipe2(int fd[2], int flag);
+int pipe(int fd[2])
+{
+	if (!lkl_running)
+		return host_calls[__lkl__NR_pipe2]((long)fd, 0, 0, 0, 0, 0);
+
+	return pipe2(fd, 0);
+
+}
diff --git a/tools/lkl/lib/hijack/init.c b/tools/lkl/lib/hijack/init.c
new file mode 100644
index 000000000000..2145fb7ec2cb
--- /dev/null
+++ b/tools/lkl/lib/hijack/init.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * system calls hijack code
+ * Copyright (c) 2015 Hajime Tazaki
+ *
+ * Author: Hajime Tazaki <tazaki@sfc.wide.ad.jp>
+ *
+ * Note: some of the code is picked from rumpkernel, written by Antti Kantee.
+ */
+
+#include <stdio.h>
+#include <net/if.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <signal.h>
+#include <lkl.h>
+#include <lkl_host.h>
+#include <lkl_config.h>
+
+#include "xlate.h"
+#include "init.h"
+
+#define __USE_GNU
+#include <dlfcn.h>
+
+#define _GNU_SOURCE
+#include <sched.h>
+
+/* Mount points are named after filesystem types so they should never
+ * be longer than ~6 characters.
+ */
+#define MAX_FSTYPE_LEN 50
+
+static void PinToCpus(const cpu_set_t *cpus)
+{
+	if (sched_setaffinity(0, sizeof(cpu_set_t), cpus))
+		perror("sched_setaffinity");
+}
+
+static void PinToFirstCpu(const cpu_set_t *cpus)
+{
+	int j;
+	cpu_set_t pinto;
+
+	CPU_ZERO(&pinto);
+	for (j = 0; j < CPU_SETSIZE; j++) {
+		if (CPU_ISSET(j, cpus)) {
+			lkl_printf("LKL: Pin To CPU %d\n", j);
+			CPU_SET(j, &pinto);
+			PinToCpus(&pinto);
+			return;
+		}
+	}
+}
+
+int lkl_debug, lkl_running;
+
+static struct lkl_config *cfg;
+
+static int config_load(void)
+{
+	int len, ret = -1;
+	char *buf;
+	int fd;
+	char *path = getenv("LKL_HIJACK_CONFIG_FILE");
+
+	cfg = (struct lkl_config *)malloc(sizeof(struct lkl_config));
+	if (!cfg) {
+		perror("config malloc");
+		return -1;
+	}
+	memset(cfg, 0, sizeof(struct lkl_config));
+
+	ret = lkl_load_config_env(cfg);
+	if (ret < 0)
+		return ret;
+
+	if (path)
+		fd = open(path, O_RDONLY, 0);
+	else if (access("lkl-hijack.json", R_OK) == 0)
+		fd = open("lkl-hijack.json", O_RDONLY, 0);
+	else
+		return 0;
+	if (fd < 0) {
+		fprintf(stderr, "config_file open %s: %s\n",
+			path, strerror(errno));
+		return -1;
+	}
+	len = lseek(fd, 0, SEEK_END);
+	lseek(fd, 0, SEEK_SET);
+	if (len < 0) {
+		perror("config size check (lseek)");
+		return -1;
+	} else if (len == 0) {
+		return 0;
+	}
+	buf = (char *)malloc(len * sizeof(char) + 1);
+	if (!buf) {
+		perror("config buf malloc");
+		return -1;
+	}
+	ret = read(fd, buf, len);
+	if (ret < 0) {
+		perror("config file read");
+		free(buf);
+		return -1;
+	}
+	ret = lkl_load_config_json(cfg, buf);
+	free(buf);
+	return ret;
+}
+
+void __attribute__((constructor))
+hijack_init(void)
+{
+	int ret, i, dev_null;
+	int single_cpu_mode = 0;
+	cpu_set_t ori_cpu;
+
+	ret = config_load();
+	if (ret < 0)
+		return;
+
+	/* reflect pre-configuration */
+	lkl_load_config_pre(cfg);
+
+	/* hijack library specific configurations */
+	if (cfg->debug)
+		lkl_register_dbg_handler();
+
+	if (lkl_debug & 0x200) {
+		char c;
+
+		printf("press 'enter' to continue\n");
+		if (scanf("%c", &c) <= 0) {
+			fprintf(stderr, "scanf() fails\n");
+			return;
+		}
+	}
+	if (cfg->single_cpu) {
+		single_cpu_mode = atoi(cfg->single_cpu);
+		switch (single_cpu_mode) {
+		case 0:
+		case 1:
+		case 2:
+			break;
+		default:
+			fprintf(stderr, "single cpu mode must be 0~2.\n");
+			single_cpu_mode = 0;
+			break;
+		}
+	}
+
+	if (single_cpu_mode) {
+		if (sched_getaffinity(0, sizeof(cpu_set_t), &ori_cpu)) {
+			perror("sched_getaffinity");
+			single_cpu_mode = 0;
+		}
+	}
+
+	/* Pin to a single cpu.
+	 * Any children thread created after it are pinned to the same CPU.
+	 */
+	if (single_cpu_mode == 2)
+		PinToFirstCpu(&ori_cpu);
+
+	if (single_cpu_mode == 1)
+		PinToFirstCpu(&ori_cpu);
+
+	ret = lkl_start_kernel(&lkl_host_ops, cfg->boot_cmdline);
+	if (ret) {
+		fprintf(stderr, "can't start kernel: %s\n", lkl_strerror(ret));
+		return;
+	}
+
+	lkl_running = 1;
+
+	/* initialize epoll manage list */
+	memset(dual_fds, -1, sizeof(int) * LKL_FD_OFFSET);
+
+	/* restore cpu affinity */
+	if (single_cpu_mode)
+		PinToCpus(&ori_cpu);
+
+	ret = lkl_set_fd_limit(65535);
+	if (ret)
+		fprintf(stderr, "lkl_set_fd_limit failed: %s\n",
+			lkl_strerror(ret));
+
+	/* fillup FDs up to LKL_FD_OFFSET */
+	ret = lkl_sys_mknod("/dev_null", LKL_S_IFCHR | 0600, LKL_MKDEV(1, 3));
+	dev_null = lkl_sys_open("/dev_null", LKL_O_RDONLY, 0);
+	if (dev_null < 0) {
+		fprintf(stderr, "failed to open /dev/null: %s\n",
+				lkl_strerror(dev_null));
+		return;
+	}
+
+	for (i = 1; i < LKL_FD_OFFSET; i++)
+		lkl_sys_dup(dev_null);
+
+	/* lo iff_up */
+	lkl_if_up(1);
+
+	/* reflect post-configuration */
+	lkl_load_config_post(cfg);
+}
+
+void __attribute__((destructor))
+hijack_fini(void)
+{
+	int i;
+	int err;
+
+	/* The following pauses the kernel before exiting allowing one
+	 * to debug or collect stattistics/diagnosis info from it.
+	 */
+	if (lkl_debug & 0x100) {
+		while (1)
+			pause();
+	}
+
+	if (!cfg)
+		return;
+
+	lkl_unload_config(cfg);
+	free(cfg);
+
+	if (!lkl_running)
+		return;
+
+	for (i = 0; i < LKL_FD_OFFSET; i++)
+		lkl_sys_close(i);
+
+	err = lkl_sys_halt();
+	if (err)
+		fprintf(stderr, "lkl_sys_halt: %s\n", lkl_strerror(err));
+}
diff --git a/tools/lkl/lib/hijack/init.h b/tools/lkl/lib/hijack/init.h
new file mode 100644
index 000000000000..c4039e018b2b
--- /dev/null
+++ b/tools/lkl/lib/hijack/init.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_HIJACK_INIT_H
+#define _LKL_HIJACK_INIT_H
+
+extern int lkl_running;
+extern int dual_fds[];
+
+#endif /*_LKL_HIJACK_INIT_H */
diff --git a/tools/lkl/lib/hijack/xlate.c b/tools/lkl/lib/hijack/xlate.c
new file mode 100644
index 000000000000..b96a0107116a
--- /dev/null
+++ b/tools/lkl/lib/hijack/xlate.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#define __USE_GNU
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#undef st_atime
+#undef st_mtime
+#undef st_ctime
+#include <lkl.h>
+
+#include "xlate.h"
+
+long lkl_set_errno(long err)
+{
+	if (err >= 0)
+		return err;
+
+	switch (err) {
+	case -LKL_EPERM:
+		errno = EPERM;
+		break;
+	case -LKL_ENOENT:
+		errno = ENOENT;
+		break;
+	case -LKL_ESRCH:
+		errno = ESRCH;
+		break;
+	case -LKL_EINTR:
+		errno = EINTR;
+		break;
+	case -LKL_EIO:
+		errno = EIO;
+		break;
+	case -LKL_ENXIO:
+		errno = ENXIO;
+		break;
+	case -LKL_E2BIG:
+		errno = E2BIG;
+		break;
+	case -LKL_ENOEXEC:
+		errno = ENOEXEC;
+		break;
+	case -LKL_EBADF:
+		errno = EBADF;
+		break;
+	case -LKL_ECHILD:
+		errno = ECHILD;
+		break;
+	case -LKL_EAGAIN:
+		errno = EAGAIN;
+		break;
+	case -LKL_ENOMEM:
+		errno = ENOMEM;
+		break;
+	case -LKL_EACCES:
+		errno = EACCES;
+		break;
+	case -LKL_EFAULT:
+		errno = EFAULT;
+		break;
+	case -LKL_ENOTBLK:
+		errno = ENOTBLK;
+		break;
+	case -LKL_EBUSY:
+		errno = EBUSY;
+		break;
+	case -LKL_EEXIST:
+		errno = EEXIST;
+		break;
+	case -LKL_EXDEV:
+		errno = EXDEV;
+		break;
+	case -LKL_ENODEV:
+		errno = ENODEV;
+		break;
+	case -LKL_ENOTDIR:
+		errno = ENOTDIR;
+		break;
+	case -LKL_EISDIR:
+		errno = EISDIR;
+		break;
+	case -LKL_EINVAL:
+		errno = EINVAL;
+		break;
+	case -LKL_ENFILE:
+		errno = ENFILE;
+		break;
+	case -LKL_EMFILE:
+		errno = EMFILE;
+		break;
+	case -LKL_ENOTTY:
+		errno = ENOTTY;
+		break;
+	case -LKL_ETXTBSY:
+		errno = ETXTBSY;
+		break;
+	case -LKL_EFBIG:
+		errno = EFBIG;
+		break;
+	case -LKL_ENOSPC:
+		errno = ENOSPC;
+		break;
+	case -LKL_ESPIPE:
+		errno = ESPIPE;
+		break;
+	case -LKL_EROFS:
+		errno = EROFS;
+		break;
+	case -LKL_EMLINK:
+		errno = EMLINK;
+		break;
+	case -LKL_EPIPE:
+		errno = EPIPE;
+		break;
+	case -LKL_EDOM:
+		errno = EDOM;
+		break;
+	case -LKL_ERANGE:
+		errno = ERANGE;
+		break;
+	case -LKL_EDEADLK:
+		errno = EDEADLK;
+		break;
+	case -LKL_ENAMETOOLONG:
+		errno = ENAMETOOLONG;
+		break;
+	case -LKL_ENOLCK:
+		errno = ENOLCK;
+		break;
+	case -LKL_ENOSYS:
+		errno = ENOSYS;
+		break;
+	case -LKL_ENOTEMPTY:
+		errno = ENOTEMPTY;
+		break;
+	case -LKL_ELOOP:
+		errno = ELOOP;
+		break;
+	case -LKL_ENOMSG:
+		errno = ENOMSG;
+		break;
+	case -LKL_EIDRM:
+		errno = EIDRM;
+		break;
+	case -LKL_ECHRNG:
+		errno = ECHRNG;
+		break;
+	case -LKL_EL2NSYNC:
+		errno = EL2NSYNC;
+		break;
+	case -LKL_EL3HLT:
+		errno = EL3HLT;
+		break;
+	case -LKL_EL3RST:
+		errno = EL3RST;
+		break;
+	case -LKL_ELNRNG:
+		errno = ELNRNG;
+		break;
+	case -LKL_EUNATCH:
+		errno = EUNATCH;
+		break;
+	case -LKL_ENOCSI:
+		errno = ENOCSI;
+		break;
+	case -LKL_EL2HLT:
+		errno = EL2HLT;
+		break;
+	case -LKL_EBADE:
+		errno = EBADE;
+		break;
+	case -LKL_EBADR:
+		errno = EBADR;
+		break;
+	case -LKL_EXFULL:
+		errno = EXFULL;
+		break;
+	case -LKL_ENOANO:
+		errno = ENOANO;
+		break;
+	case -LKL_EBADRQC:
+		errno = EBADRQC;
+		break;
+	case -LKL_EBADSLT:
+		errno = EBADSLT;
+		break;
+	case -LKL_EBFONT:
+		errno = EBFONT;
+		break;
+	case -LKL_ENOSTR:
+		errno = ENOSTR;
+		break;
+	case -LKL_ENODATA:
+		errno = ENODATA;
+		break;
+	case -LKL_ETIME:
+		errno = ETIME;
+		break;
+	case -LKL_ENOSR:
+		errno = ENOSR;
+		break;
+	case -LKL_ENONET:
+		errno = ENONET;
+		break;
+	case -LKL_ENOPKG:
+		errno = ENOPKG;
+		break;
+	case -LKL_EREMOTE:
+		errno = EREMOTE;
+		break;
+	case -LKL_ENOLINK:
+		errno = ENOLINK;
+		break;
+	case -LKL_EADV:
+		errno = EADV;
+		break;
+	case -LKL_ESRMNT:
+		errno = ESRMNT;
+		break;
+	case -LKL_ECOMM:
+		errno = ECOMM;
+		break;
+	case -LKL_EPROTO:
+		errno = EPROTO;
+		break;
+	case -LKL_EMULTIHOP:
+		errno = EMULTIHOP;
+		break;
+	case -LKL_EDOTDOT:
+		errno = EDOTDOT;
+		break;
+	case -LKL_EBADMSG:
+		errno = EBADMSG;
+		break;
+	case -LKL_EOVERFLOW:
+		errno = EOVERFLOW;
+		break;
+	case -LKL_ENOTUNIQ:
+		errno = ENOTUNIQ;
+		break;
+	case -LKL_EBADFD:
+		errno = EBADFD;
+		break;
+	case -LKL_EREMCHG:
+		errno = EREMCHG;
+		break;
+	case -LKL_ELIBACC:
+		errno = ELIBACC;
+		break;
+	case -LKL_ELIBBAD:
+		errno = ELIBBAD;
+		break;
+	case -LKL_ELIBSCN:
+		errno = ELIBSCN;
+		break;
+	case -LKL_ELIBMAX:
+		errno = ELIBMAX;
+		break;
+	case -LKL_ELIBEXEC:
+		errno = ELIBEXEC;
+		break;
+	case -LKL_EILSEQ:
+		errno = EILSEQ;
+		break;
+	case -LKL_ERESTART:
+		errno = ERESTART;
+		break;
+	case -LKL_ESTRPIPE:
+		errno = ESTRPIPE;
+		break;
+	case -LKL_EUSERS:
+		errno = EUSERS;
+		break;
+	case -LKL_ENOTSOCK:
+		errno = ENOTSOCK;
+		break;
+	case -LKL_EDESTADDRREQ:
+		errno = EDESTADDRREQ;
+		break;
+	case -LKL_EMSGSIZE:
+		errno = EMSGSIZE;
+		break;
+	case -LKL_EPROTOTYPE:
+		errno = EPROTOTYPE;
+		break;
+	case -LKL_ENOPROTOOPT:
+		errno = ENOPROTOOPT;
+		break;
+	case -LKL_EPROTONOSUPPORT:
+		errno = EPROTONOSUPPORT;
+		break;
+	case -LKL_ESOCKTNOSUPPORT:
+		errno = ESOCKTNOSUPPORT;
+		break;
+	case -LKL_EOPNOTSUPP:
+		errno = EOPNOTSUPP;
+		break;
+	case -LKL_EPFNOSUPPORT:
+		errno = EPFNOSUPPORT;
+		break;
+	case -LKL_EAFNOSUPPORT:
+		errno = EAFNOSUPPORT;
+		break;
+	case -LKL_EADDRINUSE:
+		errno = EADDRINUSE;
+		break;
+	case -LKL_EADDRNOTAVAIL:
+		errno = EADDRNOTAVAIL;
+		break;
+	case -LKL_ENETDOWN:
+		errno = ENETDOWN;
+		break;
+	case -LKL_ENETUNREACH:
+		errno = ENETUNREACH;
+		break;
+	case -LKL_ENETRESET:
+		errno = ENETRESET;
+		break;
+	case -LKL_ECONNABORTED:
+		errno = ECONNABORTED;
+		break;
+	case -LKL_ECONNRESET:
+		errno = ECONNRESET;
+		break;
+	case -LKL_ENOBUFS:
+		errno = ENOBUFS;
+		break;
+	case -LKL_EISCONN:
+		errno = EISCONN;
+		break;
+	case -LKL_ENOTCONN:
+		errno = ENOTCONN;
+		break;
+	case -LKL_ESHUTDOWN:
+		errno = ESHUTDOWN;
+		break;
+	case -LKL_ETOOMANYREFS:
+		errno = ETOOMANYREFS;
+		break;
+	case -LKL_ETIMEDOUT:
+		errno = ETIMEDOUT;
+		break;
+	case -LKL_ECONNREFUSED:
+		errno = ECONNREFUSED;
+		break;
+	case -LKL_EHOSTDOWN:
+		errno = EHOSTDOWN;
+		break;
+	case -LKL_EHOSTUNREACH:
+		errno = EHOSTUNREACH;
+		break;
+	case -LKL_EALREADY:
+		errno = EALREADY;
+		break;
+	case -LKL_EINPROGRESS:
+		errno = EINPROGRESS;
+		break;
+	case -LKL_ESTALE:
+		errno = ESTALE;
+		break;
+	case -LKL_EUCLEAN:
+		errno = EUCLEAN;
+		break;
+	case -LKL_ENOTNAM:
+		errno = ENOTNAM;
+		break;
+	case -LKL_ENAVAIL:
+		errno = ENAVAIL;
+		break;
+	case -LKL_EISNAM:
+		errno = EISNAM;
+		break;
+	case -LKL_EREMOTEIO:
+		errno = EREMOTEIO;
+		break;
+	case -LKL_EDQUOT:
+		errno = EDQUOT;
+		break;
+	case -LKL_ENOMEDIUM:
+		errno = ENOMEDIUM;
+		break;
+	case -LKL_EMEDIUMTYPE:
+		errno = EMEDIUMTYPE;
+		break;
+	case -LKL_ECANCELED:
+		errno = ECANCELED;
+		break;
+	case -LKL_ENOKEY:
+		errno = ENOKEY;
+		break;
+	case -LKL_EKEYEXPIRED:
+		errno = EKEYEXPIRED;
+		break;
+	case -LKL_EKEYREVOKED:
+		errno = EKEYREVOKED;
+		break;
+	case -LKL_EKEYREJECTED:
+		errno = EKEYREJECTED;
+		break;
+	case -LKL_EOWNERDEAD:
+		errno = EOWNERDEAD;
+		break;
+	case -LKL_ENOTRECOVERABLE:
+		errno = ENOTRECOVERABLE;
+		break;
+	case -LKL_ERFKILL:
+		errno = ERFKILL;
+		break;
+	case -LKL_EHWPOISON:
+		errno = EHWPOISON;
+		break;
+	}
+
+	return -1;
+}
+
+int lkl_soname_xlate(int soname)
+{
+	switch (soname) {
+	case SO_DEBUG:
+		return LKL_SO_DEBUG;
+	case SO_REUSEADDR:
+		return LKL_SO_REUSEADDR;
+	case SO_TYPE:
+		return LKL_SO_TYPE;
+	case SO_ERROR:
+		return LKL_SO_ERROR;
+	case SO_DONTROUTE:
+		return LKL_SO_DONTROUTE;
+	case SO_BROADCAST:
+		return LKL_SO_BROADCAST;
+	case SO_SNDBUF:
+		return LKL_SO_SNDBUF;
+	case SO_RCVBUF:
+		return LKL_SO_RCVBUF;
+	case SO_SNDBUFFORCE:
+		return LKL_SO_SNDBUFFORCE;
+	case SO_RCVBUFFORCE:
+		return LKL_SO_RCVBUFFORCE;
+	case SO_KEEPALIVE:
+		return LKL_SO_KEEPALIVE;
+	case SO_OOBINLINE:
+		return LKL_SO_OOBINLINE;
+	case SO_NO_CHECK:
+		return LKL_SO_NO_CHECK;
+	case SO_PRIORITY:
+		return LKL_SO_PRIORITY;
+	case SO_LINGER:
+		return LKL_SO_LINGER;
+	case SO_BSDCOMPAT:
+		return LKL_SO_BSDCOMPAT;
+#ifdef SO_REUSEPORT
+	case SO_REUSEPORT:
+		return LKL_SO_REUSEPORT;
+#endif
+	case SO_PASSCRED:
+		return LKL_SO_PASSCRED;
+	case SO_PEERCRED:
+		return LKL_SO_PEERCRED;
+	case SO_RCVLOWAT:
+		return LKL_SO_RCVLOWAT;
+	case SO_SNDLOWAT:
+		return LKL_SO_SNDLOWAT;
+	case SO_RCVTIMEO:
+		return LKL_SO_RCVTIMEO;
+	case SO_SNDTIMEO:
+		return LKL_SO_SNDTIMEO;
+	case SO_SECURITY_AUTHENTICATION:
+		return LKL_SO_SECURITY_AUTHENTICATION;
+	case SO_SECURITY_ENCRYPTION_TRANSPORT:
+		return LKL_SO_SECURITY_ENCRYPTION_TRANSPORT;
+	case SO_SECURITY_ENCRYPTION_NETWORK:
+		return LKL_SO_SECURITY_ENCRYPTION_NETWORK;
+	case SO_BINDTODEVICE:
+		return LKL_SO_BINDTODEVICE;
+	case SO_ATTACH_FILTER:
+		return LKL_SO_ATTACH_FILTER;
+	case SO_DETACH_FILTER:
+		return LKL_SO_DETACH_FILTER;
+	case SO_PEERNAME:
+		return LKL_SO_PEERNAME;
+	case SO_TIMESTAMP:
+		return LKL_SO_TIMESTAMP;
+	case SO_ACCEPTCONN:
+		return LKL_SO_ACCEPTCONN;
+	case SO_PEERSEC:
+		return LKL_SO_PEERSEC;
+	case SO_PASSSEC:
+		return LKL_SO_PASSSEC;
+	case SO_TIMESTAMPNS:
+		return LKL_SO_TIMESTAMPNS;
+	case SO_MARK:
+		return LKL_SO_MARK;
+	case SO_TIMESTAMPING:
+		return LKL_SO_TIMESTAMPING;
+	case SO_PROTOCOL:
+		return LKL_SO_PROTOCOL;
+	case SO_DOMAIN:
+		return LKL_SO_DOMAIN;
+	case SO_RXQ_OVFL:
+		return LKL_SO_RXQ_OVFL;
+#ifdef SO_WIFI_STATUS
+	case SO_WIFI_STATUS:
+		return LKL_SO_WIFI_STATUS;
+#endif
+#ifdef SO_PEEK_OFF
+	case SO_PEEK_OFF:
+		return LKL_SO_PEEK_OFF;
+#endif
+#ifdef SO_NOFCS
+	case SO_NOFCS:
+		return LKL_SO_NOFCS;
+#endif
+#ifdef SO_LOCK_FILTER
+	case SO_LOCK_FILTER:
+		return LKL_SO_LOCK_FILTER;
+#endif
+#ifdef SO_SELECT_ERR_QUEUE
+	case SO_SELECT_ERR_QUEUE:
+		return LKL_SO_SELECT_ERR_QUEUE;
+#endif
+#ifdef SO_BUSY_POLL
+	case SO_BUSY_POLL:
+		return LKL_SO_BUSY_POLL;
+#endif
+#ifdef SO_MAX_PACING_RATE
+	case SO_MAX_PACING_RATE:
+		return LKL_SO_MAX_PACING_RATE;
+#endif
+	}
+
+	return soname;
+}
+
+int lkl_solevel_xlate(int solevel)
+{
+	switch (solevel) {
+	case SOL_SOCKET:
+		return LKL_SOL_SOCKET;
+	}
+
+	return solevel;
+}
+
+unsigned long lkl_ioctl_req_xlate(unsigned long req)
+{
+	switch (req) {
+	case FIOSETOWN:
+		return LKL_FIOSETOWN;
+	case SIOCSPGRP:
+		return LKL_SIOCSPGRP;
+	case FIOGETOWN:
+		return LKL_FIOGETOWN;
+	case SIOCGPGRP:
+		return LKL_SIOCGPGRP;
+	case SIOCATMARK:
+		return LKL_SIOCATMARK;
+	case SIOCGSTAMP:
+		return LKL_SIOCGSTAMP;
+	case SIOCGSTAMPNS:
+		return LKL_SIOCGSTAMPNS;
+	}
+
+	/* TODO: asm/termios.h translations */
+
+	return req;
+}
+
+int lkl_fcntl_cmd_xlate(int cmd)
+{
+	switch (cmd) {
+	case F_DUPFD:
+		return LKL_F_DUPFD;
+	case F_GETFD:
+		return LKL_F_GETFD;
+	case F_SETFD:
+		return LKL_F_SETFD;
+	case F_GETFL:
+		return LKL_F_GETFL;
+	case F_SETFL:
+		return LKL_F_SETFL;
+	case F_GETLK:
+		return LKL_F_GETLK;
+	case F_SETLK:
+		return LKL_F_SETLK;
+	case F_SETLKW:
+		return LKL_F_SETLKW;
+	case F_SETOWN:
+		return LKL_F_SETOWN;
+	case F_GETOWN:
+		return LKL_F_GETOWN;
+	case F_SETSIG:
+		return LKL_F_SETSIG;
+	case F_GETSIG:
+		return LKL_F_GETSIG;
+#ifndef LKL_CONFIG_64BIT
+	case F_GETLK64:
+		return LKL_F_GETLK64;
+	case F_SETLK64:
+		return LKL_F_SETLK64;
+	case F_SETLKW64:
+		return LKL_F_SETLKW64;
+#endif
+	case F_SETOWN_EX:
+		return LKL_F_SETOWN_EX;
+	case F_GETOWN_EX:
+		return LKL_F_GETOWN_EX;
+	}
+
+	return cmd;
+}
+
diff --git a/tools/lkl/lib/hijack/xlate.h b/tools/lkl/lib/hijack/xlate.h
new file mode 100644
index 000000000000..0c0281f241a6
--- /dev/null
+++ b/tools/lkl/lib/hijack/xlate.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_HIJACK_XLATE_H
+#define _LKL_HIJACK_XLATE_H
+
+long lkl_set_errno(long err);
+int lkl_soname_xlate(int soname);
+int lkl_solevel_xlate(int solevel);
+unsigned long lkl_ioctl_req_xlate(unsigned long req);
+int lkl_fcntl_cmd_xlate(int cmd);
+
+#define LKL_FD_OFFSET (FD_SETSIZE/2)
+
+#endif /* _LKL_HIJACK_XLATE_H */
diff --git a/tools/lkl/tests/hijack-test.sh b/tools/lkl/tests/hijack-test.sh
new file mode 100755
index 000000000000..097af6cff3ba
--- /dev/null
+++ b/tools/lkl/tests/hijack-test.sh
@@ -0,0 +1,737 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+
+clear_wdir()
+{
+    test -f ${VDESWITCH}.pid && kill $(cat ${VDESWITCH}.pid)
+    rm -rf ${wdir}
+    tap_cleanup
+    tap_cleanup 1
+}
+
+set_cfgjson()
+{
+    cfgjson=${wdir}/hijack-test$1.conf
+
+    cat > ${cfgjson}
+
+    export_vars cfgjson
+}
+
+run_hijack_cfg()
+{
+    lkl_test_cmd LKL_HIJACK_CONFIG_FILE=$cfgjson $hijack $@
+}
+
+run_hijack()
+{
+    lkl_test_cmd $hijack $@
+}
+
+run_netperf()
+{
+    lkl_test_cmd TEST_NETSERVER_PORT=$TEST_NETSERVER_PORT \
+                 LKL_HIJACK_CONFIG_FILE=$cfgjson $netperf $@
+}
+
+test_ping()
+{
+    set -e
+
+    run_hijack ${ping} -c 1 127.0.0.1
+}
+
+test_ping6()
+{
+    set -e
+
+    run_hijack ${ping6} -c 1 ::1
+}
+
+test_mount_and_dump()
+{
+    set -e
+
+    set_cfgjson << EOF
+    {
+        "mount":"proc,sysfs",
+        "dump":"/sysfs/class/net/lo/mtu,/sysfs/class/net/lo/dev_id",
+        "debug": "1"
+    }
+EOF
+
+    ans=$(run_hijack_cfg $(lkl_test_cmd which true))
+    echo "$ans"
+    echo "$ans" | grep "^65536" # lo's MTU
+    echo "$ans" | grep "0x0" # lo's dev_id
+}
+
+test_boot_cmdline()
+{
+    set -e
+
+    set_cfgjson << EOF
+    {
+        "debug":"1",
+        "boot_cmdline":"loglevel=1"
+    }
+EOF
+
+    ans=$(run_hijack_cfg $(lkl_test_cmd which true))
+    echo "$ans"
+    [ $(echo "$ans" | wc -l) = 1 ]
+}
+
+
+test_pipe_setup()
+{
+    set -e
+
+    mkfifo ${fifo1}
+    mkfifo ${fifo2}
+
+    set_cfgjson << EOF
+    {
+        "interfaces":
+        [
+            {
+                "type":"pipe",
+                "param":"${fifo1}|${fifo2}",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "mac":"$TEST_MAC0",
+            }
+        ]
+    }
+EOF
+
+    # Make sure our device has the addresses we expect
+    addr=$(run_hijack_cfg ip addr)
+    echo "$addr" | grep eth0
+    echo "$addr" | grep $(ip_lkl)
+    echo "$addr" | grep "$TEST_MAC0"
+}
+
+test_pipe_ping()
+{
+    set -e
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_lkl)",
+        "gateway6":"$(ip6_lkl)",
+        "interfaces":
+        [
+            {
+                "type":"pipe",
+                "param":"${fifo1}|${fifo2}",
+                "ip":"$(ip_host)",
+                "masklen":"$TEST_IP_NETMASK",
+                "mac":"$TEST_MAC0",
+                "ipv6":"$(ip6_host)",
+                "masklen6":"$TEST_IP6_NETMASK"
+            }
+        ]
+    }
+EOF
+
+    run_hijack_cfg $(lkl_test_cmd which sleep) 10 &
+
+    set_cfgjson 2 << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"pipe",
+                "param":"${fifo2}|${fifo1}",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "mac":"$TEST_MAC0",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK"
+            }
+        ]
+    }
+EOF
+
+    # Ping under LKL
+    run_hijack_cfg ${ping} -c 1 -w 10 $(ip_host)
+
+    # Ping 6 under LKL
+    run_hijack_cfg ${ping6} -c 1 -w 10 $(ip6_host)
+
+    wait
+}
+
+test_tap_setup()
+{
+    set -e
+
+    # Set up the TAP device we'd like to use
+    tap_setup
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "debug":"1",
+        "interfaces": [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac": "$TEST_MAC0"
+            }
+        ]
+    }
+EOF
+
+    # Make sure our device has the addresses we expect
+    addr=$(run_hijack_cfg ip addr)
+    echo "$addr" | grep eth0
+    echo "$addr" | grep $(ip_lkl)
+    echo "$addr" | grep "$TEST_MAC0"
+    echo "$addr" | grep "$(ip6_lkl)"
+    ! echo "$addr" | grep "WARN: failed to free"
+}
+
+test_tap_cleanup()
+{
+    tap_cleanup
+    tap_cleanup 1
+}
+
+test_tap_ping_host()
+{
+    set -e
+
+    # Make sure we can ping the host from inside LKL
+    run_hijack_cfg ${ping} -c 1 $(ip_host)
+    run_hijack_cfg ${ping6} -c 1 $(ip6_host)
+}
+
+test_tap_ping_lkl()
+{
+    set -e
+
+    # Now let's check that the host can see LKL.
+    lkl_test_cmd sudo ip -6 neigh del $(ip6_lkl) dev $(tap_ifname)
+    lkl_test_cmd sudo ip neigh del $(ip_lkl) dev $(tap_ifname)
+    run_hijack_cfg $(lkl_test_cmd which sleep) 3 &
+    sleep 2
+    lkl_test_cmd sudo ping -i 0.01 -c 65 $(ip_lkl)
+    lkl_test_cmd sudo ping6 -i 0.01 -c 65 $(ip6_lkl)
+}
+
+test_tap_neighbours()
+{
+    set -e
+
+    neigh1="$(ip_add 100)|12:34:56:78:9a:bc"
+    neigh2="$(ip6_add 100)|12:34:56:78:9a:be"
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "neigh":"${neigh1};${neigh2}"
+            }
+        ]
+    }
+EOF
+
+    # add neighbor entries
+    ans=$(run_hijack_cfg ip neighbor show) || true
+    echo "$ans" | tail -n 15 | grep "12:34:56:78:9a:bc"
+    echo "$ans" | tail -n 15 | grep "12:34:56:78:9a:be"
+
+    # gateway
+    ans=$(run_hijack_cfg ip route show) || true
+    echo "$ans" | tail -n 15 | grep "$(ip_host)"
+
+    # gateway v6
+    ans=$(run_hijack_cfg ip -6 route show) || true
+    echo "$ans" | tail -n 15 | grep "$(ip6_host)"
+}
+
+test_tap_netperf_stream_tso_csum()
+{
+    set -e
+
+    # offload
+    # LKL_VIRTIO_NET_F_HOST_TSO4 && LKL_VIRTIO_NET_F_GUEST_TSO4
+    # LKL_VIRTIO_NET_F_CSUM && LKL_VIRTIO_NET_F_GUEST_CSUM
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "offload":"0x883",
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK"
+            }
+        ]
+    }
+EOF
+
+    run_netperf $(ip_host) TCP_STREAM
+}
+
+test_tap_netperf_maerts_csum_tso()
+{
+    run_netperf $(ip_host) TCP_MAERTS
+}
+
+test_tap_netperf_stream_csum_tso_mrgrxbuf()
+{
+    set -e
+
+    # offload
+    # LKL_VIRTIO_NET_F_HOST_TSO4 && LKL_VIRTIO_NET_F_MRG_RXBUF
+    # LKL_VIRTIO_NET_F_CSUM && LKL_VIRTIO_NET_F_GUEST_CSUM
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "offload":"0x8803",
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK"
+            }
+        ]
+    }
+EOF
+
+    run_netperf $(ip_host) TCP_MAERTS
+}
+
+test_tap_netperf_tcp_rr()
+{
+    set -e
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK"
+            }
+        ]
+    }
+EOF
+
+    run_netperf $(ip_host) TCP_RR
+}
+
+test_tap_netperf_tcp_stream()
+{
+    set -e
+
+    run_netperf $(ip_host) TCP_STREAM
+}
+
+test_tap_netperf_tcp_maerts()
+{
+    set -e
+
+    run_netperf $(ip_host) TCP_MAERTS
+}
+
+
+test_tap_qdisc()
+{
+    set -e
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac":"$TEST_MAC0",
+                "qdisc":"root|fq"
+            }
+        ]
+    }
+EOF
+
+    qdisc=$(run_hijack_cfg tc -s -d qdisc show)
+    echo "$qdisc"
+    echo "$qdisc" | grep "qdisc fq" > /dev/null
+    echo "$qdisc" | grep throttled > /dev/null
+}
+
+test_tap_multi_if_setup()
+{
+    set -e
+
+    # Set up 2nd TAP device we'd like to use
+    tap_setup 1
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac":"$TEST_MAC0"
+            },
+            {
+                "type":"tap",
+                "param":"$(tap_ifname 1)",
+                "ip":"$(ip_lkl 1)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl 1)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac":"$TEST_MAC1"
+            }
+        ]
+    }
+EOF
+
+    # Make sure our device has the addresses we expect
+    addr=$(run_hijack_cfg ip addr)
+    echo "$addr" | grep eth0
+    echo "$addr" | grep $(ip_lkl)
+    echo "$addr" | grep "$TEST_MAC0"
+    echo "$addr" | grep "$(ip6_lkl)"
+    echo "$addr" | grep eth1
+    echo "$addr" | grep $(ip_lkl 1)
+    echo "$addr" | grep "$TEST_MAC1"
+    echo "$addr" | grep "$(ip6_lkl 1)"
+    ! echo "$addr" | grep "WARN: failed to free"
+}
+
+test_tap_multi_if_ping()
+{
+    run_hijack_cfg ${ping} -c 1 $(ip_host)
+    run_hijack_cfg ${ping6} -c 1 $(ip6_host)
+    run_hijack_cfg ${ping} -c 1 $(ip_host 1)
+    run_hijack_cfg ${ping6} -c 1 $(ip6_host 1)
+}
+
+test_tap_multi_if_neigh()
+{
+
+    neigh1="$(ip_host)00|12:34:56:78:9a:bc"
+    neigh2="$(ip6_host)00|12:34:56:78:9a:be"
+    neigh3="$(ip_host 1)00|12:34:56:78:9a:bd"
+    neigh4="$(ip6_host 1)00|12:34:56:78:9a:bf"
+
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac":"$TEST_MAC0",
+                "neigh":"${neigh1};${neigh2}"
+            },
+            {
+                "type":"tap",
+                "param":"$(tap_ifname 1)",
+                "ip":"$(ip_lkl 1)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl 1)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac":"$TEST_MAC1",
+                "neigh":"${neigh3};${neigh4}"
+            }
+        ]
+    }
+EOF
+
+    # add neighbor entries
+    ans=$(run_hijack_cfg ip neighbor show) || true
+    echo "$ans" | tail -n 15 | grep "12:34:56:78:9a:bc"
+    echo "$ans" | tail -n 15 | grep "12:34:56:78:9a:be"
+    echo "$ans" | tail -n 15 | grep "12:34:56:78:9a:bd"
+    echo "$ans" | tail -n 15 | grep "12:34:56:78:9a:bf"
+}
+
+test_tap_multi_if_gateway()
+{
+    ans=$(run_hijack_cfg ip route show) || true
+    echo "$ans" | tail -n 15 | grep "$(ip_host)"
+}
+
+test_tap_multi_if_gateway_v6()
+{
+    ans=$(run_hijack_cfg ip -6 route show) || true
+    echo "$ans" | tail -n 15 | grep "$(ip6_host)"
+}
+
+
+test_tap_multitable_setup()
+{
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"tap",
+                "param":"$(tap_ifname)",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ifgateway":"$(ip_host)",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "ifgateway6":"$(ip6_host)",
+                "mac":"$TEST_MAC0",
+                "neigh":"${neigh1};${neigh2}"
+            },
+            {
+                "type":"tap",
+                "param":"$(tap_ifname 1)",
+                "ip":"$(ip_lkl 1)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ifgateway":"$(ip_host 1)",
+                "ipv6":"$(ip6_lkl 1)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "ifgateway6":"$(ip6_host 1)",
+                "mac":"$TEST_MAC1",
+                "neigh":"${neigh3};${neigh4}"
+            }
+        ]
+    }
+EOF
+}
+
+test_tap_multitable_ipv4_rule()
+{
+    addr=$(run_hijack_cfg ip rule show)
+    echo "$addr" | grep $(ip_lkl)
+    echo "$addr" | grep $(ip_lkl 1)
+}
+
+test_tap_multitable_ipv6_rule()
+{
+    addr=$(run_hijack_cfg ip -6 rule show)
+    echo "$addr" | grep $(ip6_lkl)
+    echo "$addr" | grep $(ip6_lkl 1)
+}
+
+test_tap_multitable_ipv4_rule_table_4()
+{
+    addr=$(run_hijack_cfg ip route show table 4)
+    echo "$addr" | grep $(ip_host)
+}
+
+test_tap_multitable_ipv6_rule_table_5()
+{
+    addr=$(run_hijack_cfg ip -6 route show table 5)
+    echo "$addr" | grep fc03::
+    echo "$addr" | grep $(ip6_host)
+}
+
+test_tap_multitable_ipv6_rule_table_6()
+{
+    addr=$(run_hijack_cfg ip route show table 6)
+    echo "$addr" | grep $(ip_host 1)
+}
+
+test_tap_multitable_ipv6_rule_table_7()
+{
+    addr=$(run_hijack_cfg ip -6 route show table 7)
+    echo "$addr" | grep fc04::
+    echo "$addr" | grep $(ip6_host 1)
+}
+
+test_vde_setup()
+{
+    set_cfgjson << EOF
+    {
+        "gateway":"$(ip_host)",
+        "gateway6":"$(ip6_host)",
+        "interfaces":
+        [
+            {
+                "type":"vde",
+                "param":"${VDESWITCH}",
+                "ip":"$(ip_lkl)",
+                "masklen":"$TEST_IP_NETMASK",
+                "ipv6":"$(ip6_lkl)",
+                "masklen6":"$TEST_IP6_NETMASK",
+                "mac":"$TEST_MAC0",
+                "neigh":"${neigh1};${neigh2}"
+            }
+        ]
+    }
+EOF
+
+    tap_setup
+
+    sleep 2
+    vde_switch -d -t $(tap_ifname) -s ${VDESWITCH} -p ${VDESWITCH}.pid
+
+    # Make sure our device has the addresses we expect
+    addr=$(run_hijack_cfg ip addr)
+    echo "$addr" | grep eth0
+    echo "$addr" | grep $(ip_lkl)
+    echo "$addr" | grep "$TEST_MAC0"
+}
+
+test_vde_cleanup()
+{
+    tap_cleanup
+}
+
+test_vde_ping_host()
+{
+    run_hijack_cfg ./ping $(ip_host) -c 1
+}
+
+test_vde_ping_lkl()
+{
+    lkl_test_cmd sudo arp -d $(ip_lkl)
+    lkl_test_cmd sudo ping -i 0.01 -c 65 $(ip_lkl) &
+    run_hijack_cfg sleep 3
+}
+
+source ${script_dir}/test.sh
+source ${script_dir}/net-setup.sh
+
+if [[ ! -e ${basedir}/lib/hijack/liblkl-hijack.so ]]; then
+    lkl_test_plan 0 "hijack tests"
+    echo "missing liblkl-hijack.so"
+    exit 0
+fi
+
+# Make a temporary directory to run tests in, since we'll be copying
+# things there.
+wdir=$(mktemp -d)
+cp `which ping` ${wdir}
+cp `which ping6` ${wdir}
+ping=${wdir}/ping
+ping6=${wdir}/ping6
+hijack=$basedir/bin/lkl-hijack.sh
+netperf=$basedir/tests/run_netperf.sh
+
+fifo1=${wdir}/fifo1
+fifo2=${wdir}/fifo2
+VDESWITCH=${wdir}/vde_switch
+
+# And make sure we clean up when we're done
+trap "clear_wdir &>/dev/null" EXIT
+
+lkl_test_plan 5 "hijack basic tests"
+lkl_test_run 1 run_hijack ip addr
+lkl_test_run 2 run_hijack ip route
+lkl_test_run 3 test_ping
+lkl_test_run 4 test_ping6
+lkl_test_run 5 test_mount_and_dump
+lkl_test_run 6 test_boot_cmdline
+
+if [ -z "$(QUIET=1 lkl_test_cmd which mkfifo)" ]; then
+    lkl_test_plan 0 "hijack pipe backend tests"
+    echo "no mkfifo command"
+else
+    lkl_test_plan 2 "hijack pipe backend tests"
+    lkl_test_run 1 test_pipe_setup
+    lkl_test_run 2 test_pipe_ping
+fi
+
+tap_prepare
+
+if ! lkl_test_cmd test -c /dev/net/tun &>/dev/null; then
+    lkl_test_plan 0 "hijack tap backend tests"
+    echo "missing /dev/net/tun"
+else
+    lkl_test_plan 23 "hijack tap backend tests"
+    lkl_test_run 1 test_tap_setup
+    lkl_test_run 2 test_tap_ping_host
+    lkl_test_run 3 test_tap_ping_lkl
+    lkl_test_run 4 test_tap_neighbours
+    lkl_test_run 5 test_tap_netperf_tcp_rr
+    lkl_test_run 6 test_tap_netperf_tcp_stream
+    lkl_test_run 7 test_tap_netperf_tcp_maerts
+    lkl_test_run 8 test_tap_netperf_stream_tso_csum
+    lkl_test_run 9 test_tap_netperf_maerts_csum_tso
+    lkl_test_run 10 test_tap_netperf_stream_csum_tso_mrgrxbuf
+    lkl_test_run 11 test_tap_qdisc
+    lkl_test_run 12 test_tap_multi_if_setup
+    lkl_test_run 13 test_tap_multi_if_ping
+    lkl_test_run 14 test_tap_multi_if_neigh
+    lkl_test_run 15 test_tap_multi_if_gateway
+    lkl_test_run 16 test_tap_multi_if_gateway_v6
+    lkl_test_run 17 test_tap_multitable_setup
+    lkl_test_run 18 test_tap_multitable_ipv4_rule
+    lkl_test_run 19 test_tap_multitable_ipv6_rule
+    lkl_test_run 20 test_tap_multitable_ipv4_rule_table_4
+    lkl_test_run 21 test_tap_multitable_ipv6_rule_table_5
+    lkl_test_run 22 test_tap_multitable_ipv6_rule_table_6
+    lkl_test_run 23 test_tap_multitable_ipv6_rule_table_7
+    lkl_test_run 24 test_tap_cleanup
+fi
+
+if [ -z "$LKL_HOST_CONFIG_VIRTIO_NET_VDE" ]; then
+    lkl_test_plan 0 "vde tests"
+    echo "vde not supported"
+elif [ ! -x "$(which vde_switch)" ]; then
+    lkl_test_plan 0 "hijack vde tests"
+    echo "could not find a vde_switch executable"
+else
+    lkl_test_plan 3 "hijack vde tests"
+    lkl_test_run 1 test_vde_setup
+    lkl_test_run 2 test_vde_ping_host
+    lkl_test_run 3 test_vde_ping_lkl
+    lkl_test_run 4 test_vde_cleanup
+fi
diff --git a/tools/lkl/tests/run_netperf.sh b/tools/lkl/tests/run_netperf.sh
new file mode 100755
index 000000000000..08c4337b7830
--- /dev/null
+++ b/tools/lkl/tests/run_netperf.sh
@@ -0,0 +1,98 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Usage
+#  ./run_netperf.sh [ip] [test_name] [use_taskset] [num_runs]
+
+set -e
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+hijack_script=${script_dir}/../bin/lkl-hijack.sh
+
+num_runs="1"
+test_name="TCP_STREAM"
+use_taskset="0"
+host_ip="localhost"
+taskset_cmd="taskset -c 1"
+test_len=10  # second
+
+if [ ! -x "$(which netperf)" ]; then
+    echo "WARNING: Cannot find a netserver executable, skipping netperf tests."
+    exit $TEST_SKIP
+fi
+
+if [ $# -ge 1 ]; then
+    host_ip=$1
+fi
+if [ $# -ge 2 ]; then
+    test_name=$2
+fi
+if [ $# -ge 3 ]; then
+    use_taskset=$2
+fi
+if [ $# -ge 4 ]; then
+    num_runs=$3
+fi
+if [ $# -ge 5 ]; then
+    echo "BAD NUMBER of INPUTS."
+    exit 1
+fi
+
+if [ $use_taskset = "0" ]; then
+  taskset_cmd=""
+fi
+
+clean() {
+    kill %1 || true
+}
+
+clean_with_tap() {
+    tap_cleanup &> /dev/null || true
+    clean
+    rm -rf ${work_dir}
+}
+
+# LKL_HIJACK_CONFIG_FILE is not set, which means it's not called from
+# hijack-test.sh. Needs to set up things first.
+if [ -z ${LKL_HIJACK_CONFIG_FILE+x} ]; then
+
+    # Setting up environmental vars and TAP
+    work_dir=$(mktemp -d)
+    cfgjson=${work_dir}/hijack-test.conf
+    export LKL_HIJACK_CONFIG_FILE=$cfgjson
+
+    cat <<EOF > ${cfgjson}
+    {
+         "interfaces": [
+               {
+                    "type": "tap"
+                    "param": "$(tap_ifname)"
+                    "ip": "$(ip_lkl)"
+                    "masklen":"$TEST_IP_NETMASK"
+                    "ipv6":"$(ip6_lkl)"
+                    "masklen6":"$TEST_IP6_NETMASK"
+               }
+         ]
+    }
+EOF
+
+    . $script_dir/net-setup.sh
+    host_ip=$(ip_host)
+
+    tap_prepare
+    tap_setup
+    trap clean_with_tap EXIT
+fi
+
+netserver -D -N -p $TEST_NETSERVER_PORT &
+
+trap clean EXIT
+
+echo NUM=$num_runs, TEST=$test_name, TASKSET=$use_taskset
+for i in `seq $num_runs`; do
+    echo Test: $i
+    set -x
+    $taskset_cmd ${hijack_script} netperf -p $TEST_NETSERVER_PORT -H $host_ip \
+		         -t $test_name -l $test_len
+    set +x
+done
-- 
2.20.1 (Apple Git-117)

