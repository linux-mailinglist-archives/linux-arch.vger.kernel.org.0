Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB41276A69
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgIXHQQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgIXHQQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:16:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B9C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:16:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d6so1329334pfn.9
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8X530ewYdklTpRShu04QgcFqIloEAYvsR2T5wI/7yQ=;
        b=p2UFUQc7xZvO0JVqEnhRfp+Mn7w7n+RjKhglUpdVcTm36RmXPrIGfX5o+h36chiVW0
         5HbnnlQ8n3n31U2wzMQWnD9mZq0Mzhv/57KNbMVnyPmBfjAcrkeVRUSfxB2joLzOfbd1
         4Tg/s+QoD+Q+z/W3ANj0rINyTVlwLYktLPVO85VIk79BuXBBiuxRetaaj7o0GjvhDJq5
         ze4Jk4/zdj8ylO8iXPThxvz0k9xh6Agl71fisfklIAOC7PZ7oXFc8bc+SDo09kqEeaKW
         VkdPs9AyxSGU3YEcK+zuRCvCTxu0VLkE0PI4OYHYtuTQmNzqr0LoIhuLzu7yBeFL6FxV
         NewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8X530ewYdklTpRShu04QgcFqIloEAYvsR2T5wI/7yQ=;
        b=towjFpqriKtq7t+K63SkVdBXnRGYelA4zNdIj9Aghuy/SRuAJflab1JyT9xVfYa14E
         3N8vLfOR70shoPoUkfQlGK9cI+SDCDf4Q3m6w5SGaIshOOD9oYzvwbVdD7LNhZFuEBMv
         WHPe5GnaC8iLpznxFzLwlAkjAJUy0y83HWD0YVXQne4u6Dgxel+tOTjoyHcsbhCoaEY4
         EuoXfnshEVazZ+f/lz3s+E3da6CfsHwr8BxuYEAkDNxW5Y/rvo1KzgxCp7O72vIVY3du
         VO467qWMJrJot12Ag2AhmjnWniFe08PnpcHFCl2G3xw2UJA5oDzfs6EVZzP522NgxNhP
         S6xw==
X-Gm-Message-State: AOAM532790+fgryU+dG5jEvTh37LpqIu17npwL1ApJxZYqtY5bpwbqXE
        TrjMmEWOh/+dLgi/z+D5eB0=
X-Google-Smtp-Source: ABdhPJxfifKa0OZyq8V4uwu3hypYKMx7Q9NBWA07LeiSLhHRAmaFGtH6rPXcFFgUMcW149QsTlSu9w==
X-Received: by 2002:aa7:96af:0:b029:142:6a8f:c04b with SMTP id g15-20020aa796af0000b02901426a8fc04bmr3396020pfk.30.1600931775668;
        Thu, 24 Sep 2020 00:16:15 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id x4sm1811050pfm.86.2020.09.24.00.16.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:16:15 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 192FE2037C20F0; Thu, 24 Sep 2020 16:16:05 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 18/21] um: host: add utilities functions
Date:   Thu, 24 Sep 2020 16:12:58 +0900
Message-Id: <598d65c578c9cc5a61509241cf9a63234be1cfeb.1600922529.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add basic utility functions for getting a string from a kernel error
code and a fprintf like function that uses the host print
operation. The latter is useful for informing the user about errors
that occur in the host library.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/um/lib/Build     |   4 +
 tools/um/lib/jmp_buf.c |  14 +++
 tools/um/lib/jmp_buf.h |   8 ++
 tools/um/lib/utils.c   | 210 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 tools/um/lib/Build
 create mode 100644 tools/um/lib/jmp_buf.c
 create mode 100644 tools/um/lib/jmp_buf.h
 create mode 100644 tools/um/lib/utils.c

diff --git a/tools/um/lib/Build b/tools/um/lib/Build
new file mode 100644
index 000000000000..fc967af4104a
--- /dev/null
+++ b/tools/um/lib/Build
@@ -0,0 +1,4 @@
+include $(objtree)/include/config/auto.conf
+
+liblinux-$(CONFIG_UMMODE_LIB) += utils.o
+liblinux-$(CONFIG_UMMODE_LIB) += jmp_buf.o
diff --git a/tools/um/lib/jmp_buf.c b/tools/um/lib/jmp_buf.c
new file mode 100644
index 000000000000..f6bdd7e4bd83
--- /dev/null
+++ b/tools/um/lib/jmp_buf.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <setjmp.h>
+#include <lkl_host.h>
+
+void jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void))
+{
+	if (!setjmp(*((jmp_buf *)jmpb->buf)))
+		f();
+}
+
+void jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val)
+{
+	longjmp(*((jmp_buf *)jmpb->buf), val);
+}
diff --git a/tools/um/lib/jmp_buf.h b/tools/um/lib/jmp_buf.h
new file mode 100644
index 000000000000..8782cbaaf51f
--- /dev/null
+++ b/tools/um/lib/jmp_buf.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_JMP_BUF_H
+#define _LKL_LIB_JMP_BUF_H
+
+void jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void));
+void jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val);
+
+#endif
diff --git a/tools/um/lib/utils.c b/tools/um/lib/utils.c
new file mode 100644
index 000000000000..4930479a8a35
--- /dev/null
+++ b/tools/um/lib/utils.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <lkl_host.h>
+
+static const char * const lkl_err_strings[] = {
+	"Success",
+	"Operation not permitted",
+	"No such file or directory",
+	"No such process",
+	"Interrupted system call",
+	"I/O error",
+	"No such device or address",
+	"Argument list too long",
+	"Exec format error",
+	"Bad file number",
+	"No child processes",
+	"Try again",
+	"Out of memory",
+	"Permission denied",
+	"Bad address",
+	"Block device required",
+	"Device or resource busy",
+	"File exists",
+	"Cross-device link",
+	"No such device",
+	"Not a directory",
+	"Is a directory",
+	"Invalid argument",
+	"File table overflow",
+	"Too many open files",
+	"Not a typewriter",
+	"Text file busy",
+	"File too large",
+	"No space left on device",
+	"Illegal seek",
+	"Read-only file system",
+	"Too many links",
+	"Broken pipe",
+	"Math argument out of domain of func",
+	"Math result not representable",
+	"Resource deadlock would occur",
+	"File name too long",
+	"No record locks available",
+	"Invalid system call number",
+	"Directory not empty",
+	"Too many symbolic links encountered",
+	"Bad error code", /* EWOULDBLOCK is EAGAIN */
+	"No message of desired type",
+	"Identifier removed",
+	"Channel number out of range",
+	"Level 2 not synchronized",
+	"Level 3 halted",
+	"Level 3 reset",
+	"Link number out of range",
+	"Protocol driver not attached",
+	"No CSI structure available",
+	"Level 2 halted",
+	"Invalid exchange",
+	"Invalid request descriptor",
+	"Exchange full",
+	"No anode",
+	"Invalid request code",
+	"Invalid slot",
+	"Bad error code", /* EDEADLOCK is EDEADLK */
+	"Bad font file format",
+	"Device not a stream",
+	"No data available",
+	"Timer expired",
+	"Out of streams resources",
+	"Machine is not on the network",
+	"Package not installed",
+	"Object is remote",
+	"Link has been severed",
+	"Advertise error",
+	"Srmount error",
+	"Communication error on send",
+	"Protocol error",
+	"Multihop attempted",
+	"RFS specific error",
+	"Not a data message",
+	"Value too large for defined data type",
+	"Name not unique on network",
+	"File descriptor in bad state",
+	"Remote address changed",
+	"Can not access a needed shared library",
+	"Accessing a corrupted shared library",
+	".lib section in a.out corrupted",
+	"Attempting to link in too many shared libraries",
+	"Cannot exec a shared library directly",
+	"Illegal byte sequence",
+	"Interrupted system call should be restarted",
+	"Streams pipe error",
+	"Too many users",
+	"Socket operation on non-socket",
+	"Destination address required",
+	"Message too long",
+	"Protocol wrong type for socket",
+	"Protocol not available",
+	"Protocol not supported",
+	"Socket type not supported",
+	"Operation not supported on transport endpoint",
+	"Protocol family not supported",
+	"Address family not supported by protocol",
+	"Address already in use",
+	"Cannot assign requested address",
+	"Network is down",
+	"Network is unreachable",
+	"Network dropped connection because of reset",
+	"Software caused connection abort",
+	"Connection reset by peer",
+	"No buffer space available",
+	"Transport endpoint is already connected",
+	"Transport endpoint is not connected",
+	"Cannot send after transport endpoint shutdown",
+	"Too many references: cannot splice",
+	"Connection timed out",
+	"Connection refused",
+	"Host is down",
+	"No route to host",
+	"Operation already in progress",
+	"Operation now in progress",
+	"Stale file handle",
+	"Structure needs cleaning",
+	"Not a XENIX named type file",
+	"No XENIX semaphores available",
+	"Is a named type file",
+	"Remote I/O error",
+	"Quota exceeded",
+	"No medium found",
+	"Wrong medium type",
+	"Operation Canceled",
+	"Required key not available",
+	"Key has expired",
+	"Key has been revoked",
+	"Key was rejected by service",
+	"Owner died",
+	"State not recoverable",
+	"Operation not possible due to RF-kill",
+	"Memory page has hardware error",
+};
+
+const char *lkl_strerror(int err)
+{
+	if (err < 0)
+		err = -err;
+
+	if ((size_t)err >= sizeof(lkl_err_strings) / sizeof(const char *))
+		return "Bad error code";
+
+	return lkl_err_strings[err];
+}
+
+void lkl_perror(char *msg, int err)
+{
+	const char *err_msg = lkl_strerror(err);
+	/* We need to use 'real' printf because lkl_host_ops.print can
+	 * be turned off when debugging is off.
+	 */
+	lkl_printf("%s: %s\n", msg, err_msg);
+}
+
+static int lkl_vprintf(const char *fmt, va_list args)
+{
+	int n;
+	char *buffer;
+	va_list copy;
+
+	if (!lkl_host_ops.print)
+		return 0;
+
+	va_copy(copy, args);
+	n = vsnprintf(NULL, 0, fmt, copy);
+	va_end(copy);
+
+	buffer = lkl_host_ops.mem_alloc(n + 1);
+	if (!buffer)
+		return (-1);
+
+	vsnprintf(buffer, n + 1, fmt, args);
+
+	lkl_host_ops.print(buffer, n);
+	lkl_host_ops.mem_free(buffer);
+
+	return n;
+}
+
+int lkl_printf(const char *fmt, ...)
+{
+	int n;
+	va_list args;
+
+	va_start(args, fmt);
+	n = lkl_vprintf(fmt, args);
+	va_end(args);
+
+	return n;
+}
+
+void lkl_bug(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	lkl_vprintf(fmt, args);
+	va_end(args);
+
+	lkl_host_ops.panic();
+}
-- 
2.21.0 (Apple Git-122.2)

