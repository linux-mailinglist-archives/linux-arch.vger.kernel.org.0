Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CFF14418D
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 17:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUQF3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 11:05:29 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:47490 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUQF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 11:05:28 -0500
Received: by mail-wr1-f73.google.com with SMTP id f10so1514089wro.14
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3X3r+FgOCgofu61vtdHWB37xIMZxsUR5auYodQTv4sI=;
        b=FBbFhbGM/NL6HZQV2amTvdwm6oJ8PBno89Nf7NbyoskQOuVRFIvwKbn6qlGjYf08MG
         n+mtcfPPBq6GJCcQl3gkRpuUn3RtJ0HqhbzoqQqyeFwZ/NUkiqAWuFVT506mnRlrw0uk
         irWBGh7lGs3bw+PIVpU622MQdWEygj1ufZd4SEeh9jKvRdsJUyr8vhu+4IMIx/w6RCAE
         f9Sk1qvWNGLIbLTjhAUyVW5eExCkUPhcfmZ0vFZuRFQrsosOwqv9p+QRu/fgpOUqDlcU
         skuxWzMgb63FopNhwUDMHhvsqb5najfIU3as9az8w1KMATO2pI4feIzMm3hUEnXVp9AH
         zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3X3r+FgOCgofu61vtdHWB37xIMZxsUR5auYodQTv4sI=;
        b=CqhYX3LVFIQ+El0EBVl0gYjjptWy/MCLAQzgbvo3xeJB9MmeeMzZ9+/1PGZgDnIsxp
         biqB/+cFRSfNR9otdb9L2OrzTXP6bkTBRtUf+j4s6wPWPVPFtuWNcwFX6yEjkWa6+C7O
         yEBzDqJ+orrxthEzOvLBZILOPr5i6xCpPZm7g+efVSRvzIr+XCmqWtwDiiaV+48vzIg1
         awjWSm/W8ejGw8ixLlp1EiL3nevJAA9LzgSq/n7RIB+kwfqhsoNoU/LRN+T8HtPDT2/i
         ObEOQ6bujQAkYmLq/kG7EYUjIda6VHDe6qsmoDF8C20rLM5Tu3isAPWMBYmSXZdV6llg
         HgOA==
X-Gm-Message-State: APjAAAXk8zAfO7R9LeD3aViqBVHJ9y2TmlNdKsWfgbFsW+cdJSc0sPXB
        A7DAiis4CQmjMAA37zmB23mgav6PRA==
X-Google-Smtp-Source: APXvYqzfJxr4D75m4Ik5cgy7UsP4g2PSH1fin+tK0nv5/tE5NmJRBxtYSpJ0SbTfPGVDI8nfYfiL2JwaQw==
X-Received: by 2002:adf:b193:: with SMTP id q19mr5973633wra.78.1579622725966;
 Tue, 21 Jan 2020 08:05:25 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:05:08 +0100
Message-Id: <20200121160512.70887-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/5] include/linux: Add instrumented.h infrastructure
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dja@axtens.net,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, mhiramat@kernel.org,
        rostedt@goodmis.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        keescook@chromium.org, cyphar@cyphar.com,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds instrumented.h, which provides generic wrappers for memory
access instrumentation that the compiler cannot emit for various
sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
future this will also include KMSAN instrumentation.

Note that, copy_{to,from}_user should use special instrumentation, since
we should be able to instrument both source and destination memory
accesses if both are kernel memory.

The current patch only instruments the memory access where the address
is always in kernel space, however, both may in fact be kernel addresses
when a compat syscall passes an argument allocated in the kernel to a
real syscall. In a future change, both KASAN and KCSAN should check both
addresses in such cases, as well as KMSAN will make use of both
addresses. [It made more sense to provide the completed function
signature, rather than updating it and changing all locations again at a
later time.]

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
---
v2:
* Simplify header, since we currently do not need pre/post user-copy
  distinction.
* Make instrument_copy_{to,from}_user function arguments match
  copy_{to,from}_user and update rationale in commit message.
---
 include/linux/instrumented.h | 109 +++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 include/linux/instrumented.h

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
new file mode 100644
index 000000000000..43e6ea591975
--- /dev/null
+++ b/include/linux/instrumented.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This header provides generic wrappers for memory access instrumentation that
+ * the compiler cannot emit for: KASAN, KCSAN.
+ */
+#ifndef _LINUX_INSTRUMENTED_H
+#define _LINUX_INSTRUMENTED_H
+
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+#include <linux/types.h>
+
+/**
+ * instrument_read - instrument regular read access
+ *
+ * Instrument a regular read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_read(v, size);
+}
+
+/**
+ * instrument_write - instrument regular write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_write(v, size);
+}
+
+/**
+ * instrument_atomic_read - instrument atomic read access
+ *
+ * Instrument an atomic read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_atomic_read(v, size);
+}
+
+/**
+ * instrument_atomic_write - instrument atomic write access
+ *
+ * Instrument an atomic write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_write(v, size);
+}
+
+/**
+ * instrument_copy_to_user - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants). The instrumentation must be inserted before the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ */
+static __always_inline void
+instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	kasan_check_read(from, n);
+	kcsan_check_read(from, n);
+}
+
+/**
+ * instrument_copy_from_user - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants). The instrumentation should be inserted before the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ */
+static __always_inline void
+instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
+{
+	kasan_check_write(to, n);
+	kcsan_check_write(to, n);
+}
+
+#endif /* _LINUX_INSTRUMENTED_H */
-- 
2.25.0.341.g760bfbb309-goog

