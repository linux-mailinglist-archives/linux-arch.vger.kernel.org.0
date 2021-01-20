Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8D2FC94F
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbhATDoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbhATC3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF6C061798
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j12so1188343pjy.5
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYXUS6vCXQ3BGuo4l5mocbEkIJbH43di4lVFS7s9Dvw=;
        b=LLyPGdyZ2nocmjcAHda1dXhXJSz+93eERg0/Rq1ACGR107fuuBOoSgq0qz5g6/EfgA
         bx2G+y0smsu/gcL2KQzDNPYw4kQt3SNlxz+bRw16zns9WNjboSVFhAQ1hMwXm6OR5Ncn
         y/DNhhF+7eul40L1oGFlAQ6pmlTnnqtxfpgTozndzeFdgCpbHnGUgsQUVbqg1gwBr6s0
         0CSv3EP2iBzwhL64CXaJhla0iLgGawMg1DV/KoX6Yu3PyG4Kw8Q3oTpoNEJWym9/B9Xl
         foTAwHIXuJSzjIiPdecFF85cVV5vAbLRt7F8AkNRNR79DD/RPaOJOXib9hQIr7T41qTD
         0sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYXUS6vCXQ3BGuo4l5mocbEkIJbH43di4lVFS7s9Dvw=;
        b=L2isWIJXV5AXpLZGshPAEd2nELGB5GDEXMX9evJr1qByQLMf7M26PAKtpGk6Fl/aX0
         fcbYH3q7K3fp2snL74eewyCygpM5nc63iRIECThpX1Nesa3tKgfi7cGFtG2WH1HRxKz+
         hMdh9Iap59ou6HWrOtjvJUGfBjZJcTnZtypC63nwITqIXkJ+RLk03YtLMvskelITlfSt
         ciWMG4iFsSKBajqaMK5u2Kh+ahyl1jo6oecpa0sFgszbi4YHAh/muOeuTyHRkIZ8GM54
         VGoFrXtYQGyYKuYjg0gythcx3nlFrl+OVA8yy8n+us2VEwf17IOAsD8QZkf3QSbLnQxp
         1rxw==
X-Gm-Message-State: AOAM533jMyjySVBmX6reEbo/zbb1f/bBSnlvN7x7BbnhqC4wZ3d8Gr/R
        oJvNzGLgORGRtD5c9PimIH8=
X-Google-Smtp-Source: ABdhPJwfkJwBy3SdBpMwDJN+2duAKDn0V1ecf50C6chodd8qUxi78KHZ5+vpjESH+aQQz4yHa4btlw==
X-Received: by 2002:a17:902:bd44:b029:de:74ae:771e with SMTP id b4-20020a170902bd44b02900de74ae771emr7792526plx.73.1611109702455;
        Tue, 19 Jan 2021 18:28:22 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 16sm260808pjc.28.2021.01.19.18.28.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:21 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 5ABB520442D325; Wed, 20 Jan 2021 11:28:19 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 06/20] um: add UML library mode
Date:   Wed, 20 Jan 2021 11:27:11 +0900
Message-Id: <30b989750979c00b5ceec4fe5faa6fb8332212d5.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch introduces the library mode with UML code so that
applications can link the Linux kernel code as a reusable library.

The library mode is implemented as SUBARCH of arch/um, which places at
arch/um/lkl. This SUBARCH defines mode-specific code of memory
management as well as thread implementation, along with the uapi headers
to be exported to users.

The headers we introduce in this patch are simple wrappers to the
asm-generic headers or stubs for things we don't support, such as
ptrace, DMA, signals, ELF handling and low level processor operations.

library mode shares most of arch/um code (irq, thread_info, process
scheduling) but implements its own facilities, which are memory
management (nommu), thread primitives (struct arch_thread), system call
interface, and console.

The outlook of updated directory structure is as follows:

   arch/um
   |-- configs         (untouched)
   |-- drivers         unuse stdio_console.c for !MMU
   |-- include
   |   |-- asm         updated with !CONFIG_MMU
   |   |-- linux       (untouched)
   |   `-- shared      updated with new functions
   |       `-- skas    (untouched)
   |   `-- uapi        added for upai header installation
   |-- kernel          updated to integrate with !MMU
   |   `-- skas        (untouched, don't use for !MMU)
   |-- lkl             SUBARCH dir (internally =um/lkl)
   |   |-- include
   |   |   |-- asm     headers for subarch specific info
   |   |   `-- uapi    headers for user-visible APIs
   |   `-- um
   |       `-- shared  headers for subarch specific info
   `-- scripts         added a script for header installation

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/Kconfig                               | 20 +++-
 arch/um/lkl/Makefile                          |  2 +
 arch/um/lkl/Makefile.um                       |  2 +
 arch/um/lkl/include/asm/Kbuild                |  7 ++
 arch/um/lkl/include/asm/archparam.h           |  1 +
 arch/um/lkl/include/asm/atomic.h              | 11 +++
 arch/um/lkl/include/asm/atomic64.h            | 91 +++++++++++++++++++
 arch/um/lkl/include/asm/elf.h                 | 19 ++++
 arch/um/lkl/include/asm/mm_context.h          |  8 ++
 arch/um/lkl/include/asm/processor.h           | 48 ++++++++++
 arch/um/lkl/include/asm/ptrace.h              | 21 +++++
 arch/um/lkl/include/asm/segment.h             |  9 ++
 arch/um/lkl/include/uapi/asm/bitsperlong.h    | 13 +++
 arch/um/lkl/include/uapi/asm/byteorder.h      | 11 +++
 arch/um/lkl/include/uapi/asm/sigcontext.h     | 12 +++
 arch/um/lkl/um/Kconfig                        | 21 +++++
 arch/um/lkl/um/delay.c                        | 31 +++++++
 arch/um/lkl/um/shared/sysdep/archsetjmp.h     | 13 +++
 arch/um/lkl/um/shared/sysdep/faultinfo.h      |  8 ++
 arch/um/lkl/um/shared/sysdep/kernel-offsets.h | 12 +++
 arch/um/lkl/um/shared/sysdep/mcontext.h       |  9 ++
 arch/um/lkl/um/shared/sysdep/ptrace.h         | 42 +++++++++
 arch/um/lkl/um/shared/sysdep/ptrace_user.h    |  7 ++
 arch/um/lkl/um/unimplemented.c                | 70 ++++++++++++++
 arch/um/lkl/um/user_constants.h               | 13 +++
 25 files changed, 498 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/lkl/Makefile
 create mode 100644 arch/um/lkl/Makefile.um
 create mode 100644 arch/um/lkl/include/asm/Kbuild
 create mode 100644 arch/um/lkl/include/asm/archparam.h
 create mode 100644 arch/um/lkl/include/asm/atomic.h
 create mode 100644 arch/um/lkl/include/asm/atomic64.h
 create mode 100644 arch/um/lkl/include/asm/elf.h
 create mode 100644 arch/um/lkl/include/asm/mm_context.h
 create mode 100644 arch/um/lkl/include/asm/processor.h
 create mode 100644 arch/um/lkl/include/asm/ptrace.h
 create mode 100644 arch/um/lkl/include/asm/segment.h
 create mode 100644 arch/um/lkl/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/um/lkl/include/uapi/asm/byteorder.h
 create mode 100644 arch/um/lkl/include/uapi/asm/sigcontext.h
 create mode 100644 arch/um/lkl/um/Kconfig
 create mode 100644 arch/um/lkl/um/delay.c
 create mode 100644 arch/um/lkl/um/shared/sysdep/archsetjmp.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/faultinfo.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/kernel-offsets.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/mcontext.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/ptrace.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/ptrace_user.h
 create mode 100644 arch/um/lkl/um/unimplemented.c
 create mode 100644 arch/um/lkl/um/user_constants.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9e2d9efbcdd1..53c7919ec5b7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -23,9 +23,23 @@ config UML
 	select TTY # Needed for line.c
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config UMMODE_LIB
+	bool "UML mode: library mode"
+	depends on !SMP
+	select UACCESS_MEMCPY
+	select ARCH_THREAD_STACK_ALLOCATOR
+	help
+	 This mode switches a mode to build a library of UML (Linux
+	 Kernel Library/LKL).  If this is Y, the build only generates,
+	 library files so, standalone executable of linux/vmlinux will
+	 not be created.
+
+	 For more detail about LKL, see
+	 <file:Documentation/virt/uml/lkl.txt>.
+
 config MMU
 	bool
-	default y
+	default y if !UMMODE_LIB
 
 config NO_IOMEM
 	def_bool y
@@ -46,12 +60,12 @@ config LOCKDEP_SUPPORT
 
 config STACKTRACE_SUPPORT
 	bool
-	default y
+	default y if !UMMODE_LIB
 	select STACKTRACE
 
 config GENERIC_CALIBRATE_DELAY
 	bool
-	default y
+	default y if !UMMODE_LIB
 
 config HZ
 	int
diff --git a/arch/um/lkl/Makefile b/arch/um/lkl/Makefile
new file mode 100644
index 000000000000..0ea94aaf5c95
--- /dev/null
+++ b/arch/um/lkl/Makefile
@@ -0,0 +1,2 @@
+# empty file to avoid `include arch/$(SRCARCH)/Makefile` error
+# at $(srctree)/Makefile
diff --git a/arch/um/lkl/Makefile.um b/arch/um/lkl/Makefile.um
new file mode 100644
index 000000000000..7d3f590d88a2
--- /dev/null
+++ b/arch/um/lkl/Makefile.um
@@ -0,0 +1,2 @@
+KBUILD_CFLAGS += -fno-builtin -fPIC
+ELF_FORMAT=$(shell $(LD) -r -print-output-format)
diff --git a/arch/um/lkl/include/asm/Kbuild b/arch/um/lkl/include/asm/Kbuild
new file mode 100644
index 000000000000..54ffd5cfa69c
--- /dev/null
+++ b/arch/um/lkl/include/asm/Kbuild
@@ -0,0 +1,7 @@
+generic-y += bitsperlong.h
+generic-y += cmpxchg.h
+generic-y += local64.h
+generic-y += seccomp.h
+generic-y += string.h
+generic-y += syscall.h
+generic-y += user.h
diff --git a/arch/um/lkl/include/asm/archparam.h b/arch/um/lkl/include/asm/archparam.h
new file mode 100644
index 000000000000..ea32a7d3cf1b
--- /dev/null
+++ b/arch/um/lkl/include/asm/archparam.h
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0 */
diff --git a/arch/um/lkl/include/asm/atomic.h b/arch/um/lkl/include/asm/atomic.h
new file mode 100644
index 000000000000..849148f43ef3
--- /dev/null
+++ b/arch/um/lkl/include/asm/atomic.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_ATOMIC_H
+#define __UM_LIBMODE_ATOMIC_H
+
+#include <asm-generic/atomic.h>
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+#include "atomic64.h"
+#endif /* !CONFIG_GENERIC_ATOMIC64 */
+
+#endif
diff --git a/arch/um/lkl/include/asm/atomic64.h b/arch/um/lkl/include/asm/atomic64.h
new file mode 100644
index 000000000000..f6157c4a6de6
--- /dev/null
+++ b/arch/um/lkl/include/asm/atomic64.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_ATOMIC64_H
+#define __UM_LIBMODE_ATOMIC64_H
+
+#include <linux/types.h>
+
+#define ATOMIC64_OP(op, c_op)					\
+	static inline void atomic64_##op(s64 i, atomic64_t *v)	\
+	{							\
+		__atomic_fetch_##op(&v->counter, i, __ATOMIC_RELAXED);	\
+	}
+
+#define ATOMIC64_OP_RETURN(op, c_op)					\
+	static inline s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
+	{								\
+		return __atomic_##op##_fetch(&v->counter, i, __ATOMIC_RELAXED); \
+	}
+
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+	static inline s64 atomic64_fetch_##op(s64 i, atomic64_t *v)	\
+	{								\
+		return __atomic_fetch_##op(&v->counter, i, __ATOMIC_RELAXED); \
+	}
+
+#ifndef atomic64_add_return
+ATOMIC64_OP_RETURN(add, +)
+#endif
+
+#ifndef atomic64_sub_return
+	ATOMIC64_OP_RETURN(sub, -)
+#endif
+
+#ifndef atomic64_fetch_add
+	ATOMIC64_FETCH_OP(add, +)
+#endif
+
+#ifndef atomic64_fetch_sub
+	ATOMIC64_FETCH_OP(sub, -)
+#endif
+
+#ifndef atomic64_fetch_and
+	ATOMIC64_FETCH_OP(and, &)
+#endif
+
+#ifndef atomic64_fetch_or
+	ATOMIC64_FETCH_OP(or, |)
+#endif
+
+#ifndef atomic64_fetch_xor
+	ATOMIC64_FETCH_OP(xor, ^)
+#endif
+
+#ifndef atomic64_and
+	ATOMIC64_OP(and, &)
+#endif
+
+#ifndef atomic64_or
+	ATOMIC64_OP(or, |)
+#endif
+
+#ifndef atomic64_xor
+	ATOMIC64_OP(xor, ^)
+#endif
+
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP_RETURN
+#undef ATOMIC64_OP
+
+
+#define ATOMIC64_INIT(i)       { (i) }
+
+	static inline void atomic64_add(s64 i, atomic64_t *v)
+{
+	atomic64_add_return(i, v);
+}
+
+static inline void atomic64_sub(s64 i, atomic64_t *v)
+{
+	atomic64_sub_return(i, v);
+}
+
+#ifndef atomic64_read
+#define atomic64_read(v)       READ_ONCE((v)->counter)
+#endif
+
+#define atomic64_set(v, i) WRITE_ONCE(((v)->counter), (i))
+
+#define atomic64_xchg(ptr, v)          (xchg(&(ptr)->counter, (v)))
+#define atomic64_cmpxchg(v, old, new)  (cmpxchg(&((v)->counter), (old), (new)))
+
+#endif /* __LKL_ATOMIC64_H */
diff --git a/arch/um/lkl/include/asm/elf.h b/arch/um/lkl/include/asm/elf.h
new file mode 100644
index 000000000000..9716174154c7
--- /dev/null
+++ b/arch/um/lkl/include/asm/elf.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_ELF_H
+#define __UM_LIBMODE_ELF_H
+
+/* no proper elf loader support yet */
+#define elf_check_arch(x) 0
+
+#ifdef CONFIG_64BIT
+#define ELF_CLASS ELFCLASS64
+#else
+#define ELF_CLASS ELFCLASS32
+#endif
+
+/*
+ * ELF register definitions.
+ */
+#define elf_gregset_t long
+#define elf_fpregset_t double
+#endif
diff --git a/arch/um/lkl/include/asm/mm_context.h b/arch/um/lkl/include/asm/mm_context.h
new file mode 100644
index 000000000000..b76e728bacd0
--- /dev/null
+++ b/arch/um/lkl/include/asm/mm_context.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_MM_CONTEXT_H
+#define __UM_LIBMODE_MM_CONTEXT_H
+
+struct uml_arch_mm_context {
+};
+
+#endif
diff --git a/arch/um/lkl/include/asm/processor.h b/arch/um/lkl/include/asm/processor.h
new file mode 100644
index 000000000000..e3cab244dd81
--- /dev/null
+++ b/arch/um/lkl/include/asm/processor.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_PROCESSOR_H
+#define __UM_LIBMODE_PROCESSOR_H
+
+#include <asm/host_ops.h>
+
+struct alt_instr;
+
+struct arch_thread {
+	struct lkl_sem *sched_sem;
+	bool dead;
+	lkl_thread_t tid;
+	struct lkl_jmp_buf sched_jb;
+	unsigned long stackend;
+};
+
+#include <asm/ptrace-generic.h>
+#include <asm/processor-generic.h>
+
+#define INIT_ARCH_THREAD {}
+#define task_pt_regs(tsk) ((struct pt_regs *)(NULL))
+
+static inline void cpu_relax(void)
+{
+	unsigned long flags;
+
+	/* since this is usually called in a tight loop waiting for some
+	 * external condition (e.g. jiffies) lets run interrupts now to allow
+	 * the external condition to propagate
+	 */
+	local_irq_save(flags);
+	local_irq_restore(flags);
+}
+
+#define KSTK_EIP(tsk)	(0)
+#define KSTK_ESP(tsk)	(0)
+
+static inline void trap_init(void)
+{
+}
+
+static inline void arch_copy_thread(struct arch_thread *from,
+				    struct arch_thread *to)
+{
+	panic("unimplemented %s: fork isn't supported yet", __func__);
+}
+
+#endif
diff --git a/arch/um/lkl/include/asm/ptrace.h b/arch/um/lkl/include/asm/ptrace.h
new file mode 100644
index 000000000000..83f4e10fb677
--- /dev/null
+++ b/arch/um/lkl/include/asm/ptrace.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_PTRACE_H
+#define __UM_LIBMODE_PTRACE_H
+
+#include <linux/errno.h>
+
+static int reg_dummy __attribute__((unused));
+
+#define PT_REGS_ORIG_SYSCALL(r) (reg_dummy)
+#define PT_REGS_SYSCALL_RET(r) (reg_dummy)
+#define PT_REGS_SET_SYSCALL_RETURN(r, res) (reg_dummy = (res))
+#define REGS_SP(r) (reg_dummy)
+
+#define user_mode(regs) 0
+#define kernel_mode(regs) 1
+#define profile_pc(regs) 0
+#define user_stack_pointer(regs) 0
+
+extern void new_thread_handler(void);
+
+#endif
diff --git a/arch/um/lkl/include/asm/segment.h b/arch/um/lkl/include/asm/segment.h
new file mode 100644
index 000000000000..1f6746866b8b
--- /dev/null
+++ b/arch/um/lkl/include/asm/segment.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_SEGMENT_H
+#define __UM_LIBMODE_SEGMENT_H
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+#endif /* _ASM_LKL_SEGMENT_H */
diff --git a/arch/um/lkl/include/uapi/asm/bitsperlong.h b/arch/um/lkl/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..f6657ba0ff9b
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_UAPI_BITSPERLONG_H
+#define __UM_LIBMODE_UAPI_BITSPERLONG_H
+
+#ifdef CONFIG_64BIT
+#define __BITS_PER_LONG 64
+#else
+#define __BITS_PER_LONG 32
+#endif
+
+#include <asm-generic/bitsperlong.h>
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/byteorder.h b/arch/um/lkl/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..a4ae973f440b
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/byteorder.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_UAPI_BYTEORDER_H
+#define __UM_LIBMODE_UAPI_BYTEORDER_H
+
+#if defined(CONFIG_BIG_ENDIAN)
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/sigcontext.h b/arch/um/lkl/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..9481e6e92203
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/sigcontext.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_UAPI_SIGCONTEXT_H
+#define __UM_LIBMODE_UAPI_SIGCONTEXT_H
+
+#include <asm/ptrace-generic.h>
+
+struct sigcontext {
+	struct pt_regs regs;
+	unsigned long oldmask;
+};
+
+#endif
diff --git a/arch/um/lkl/um/Kconfig b/arch/um/lkl/um/Kconfig
new file mode 100644
index 000000000000..4e15bc0dd0a3
--- /dev/null
+++ b/arch/um/lkl/um/Kconfig
@@ -0,0 +1,21 @@
+config 64BIT
+	bool
+	default y
+
+config GENERIC_CSUM
+	def_bool y
+
+config GENERIC_ATOMIC64
+	bool
+	default y if !64BIT
+
+config SECCOMP
+	bool
+	default n
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config PRINTK_TIME
+	bool
+	default y
diff --git a/arch/um/lkl/um/delay.c b/arch/um/lkl/um/delay.c
new file mode 100644
index 000000000000..58a366d9b5f0
--- /dev/null
+++ b/arch/um/lkl/um/delay.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+#include <os.h>
+
+void __ndelay(unsigned long nsecs)
+{
+	long long start = os_nsecs();
+
+	while (os_nsecs() < start + nsecs)
+		;
+}
+
+void __udelay(unsigned long usecs)
+{
+	__ndelay(usecs * NSEC_PER_USEC);
+}
+
+void __const_udelay(unsigned long xloops)
+{
+	__udelay(xloops / 0x10c7ul);
+}
+
+void __delay(unsigned long loops)
+{
+	__ndelay(loops / 5);
+}
+
+void calibrate_delay(void)
+{
+}
diff --git a/arch/um/lkl/um/shared/sysdep/archsetjmp.h b/arch/um/lkl/um/shared/sysdep/archsetjmp.h
new file mode 100644
index 000000000000..4a5c10d7521b
--- /dev/null
+++ b/arch/um/lkl/um/shared/sysdep/archsetjmp.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_SETJMP_H
+#define __ARCH_UM_SETJMP_H
+
+struct __jmp_buf {
+	unsigned long __dummy;
+};
+#define JB_IP __dummy
+#define JB_SP __dummy
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif /* __ARCH_UM_SETJMP_H */
diff --git a/arch/um/lkl/um/shared/sysdep/faultinfo.h b/arch/um/lkl/um/shared/sysdep/faultinfo.h
new file mode 100644
index 000000000000..49210742212d
--- /dev/null
+++ b/arch/um/lkl/um/shared/sysdep/faultinfo.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_FAULTINFO_H
+#define __ARCH_UM_FAULTINFO_H
+
+struct faultinfo {
+};
+
+#endif /* __ARCH_UM_FAULTINFO_H */
diff --git a/arch/um/lkl/um/shared/sysdep/kernel-offsets.h b/arch/um/lkl/um/shared/sysdep/kernel-offsets.h
new file mode 100644
index 000000000000..a004bffb7b8d
--- /dev/null
+++ b/arch/um/lkl/um/shared/sysdep/kernel-offsets.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/elf.h>
+#include <linux/crypto.h>
+#include <linux/kbuild.h>
+#include <asm/mman.h>
+
+void foo(void)
+{
+#include <common-offsets.h>
+}
diff --git a/arch/um/lkl/um/shared/sysdep/mcontext.h b/arch/um/lkl/um/shared/sysdep/mcontext.h
new file mode 100644
index 000000000000..b734012a74da
--- /dev/null
+++ b/arch/um/lkl/um/shared/sysdep/mcontext.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_MCONTEXT_H
+#define __ARCH_UM_MCONTEXT_H
+
+extern void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc);
+
+#define GET_FAULTINFO_FROM_MC(fi, mc) (fi = fi)
+
+#endif /* __ARCH_UM_MCONTEXT_H */
diff --git a/arch/um/lkl/um/shared/sysdep/ptrace.h b/arch/um/lkl/um/shared/sysdep/ptrace.h
new file mode 100644
index 000000000000..bfdfb520a21d
--- /dev/null
+++ b/arch/um/lkl/um/shared/sysdep/ptrace.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_PTRACE_H
+#define __ARCH_UM_PTRACE_H
+
+#include <generated/user_constants.h>
+#include <linux/errno.h>
+
+struct task_struct;
+
+#define UPT_SYSCALL_NR(r) ((r)->syscall)
+#define UPT_RESTART_SYSCALL(r) ((r)->syscall--) /* XXX */
+
+#define UPT_SP(r) 0
+#define UPT_IP(r) 0
+#define EMPTY_UML_PT_REGS { }
+
+#define MAX_REG_OFFSET (UM_FRAME_SIZE)
+#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
+
+/* unused */
+struct uml_pt_regs {
+	unsigned long gp[1];
+	unsigned long fp[1];
+	long faultinfo;
+	long syscall;
+	int is_user;
+};
+
+extern void arch_init_registers(int pid);
+
+static inline long arch_ptrace(struct task_struct *child,
+			       long request, unsigned long addr,
+			       unsigned long data)
+{
+	return -EINVAL;
+}
+
+static inline void ptrace_disable(struct task_struct *child) {}
+static inline void user_enable_single_step(struct task_struct *child) {}
+static inline void user_disable_single_step(struct task_struct *child) {}
+
+#endif /* __ARCH_UM_PTRACE_H */
diff --git a/arch/um/lkl/um/shared/sysdep/ptrace_user.h b/arch/um/lkl/um/shared/sysdep/ptrace_user.h
new file mode 100644
index 000000000000..86d5cb20fb9f
--- /dev/null
+++ b/arch/um/lkl/um/shared/sysdep/ptrace_user.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_PTRACE_USER_H
+#define __ARCH_UM_PTRACE_USER_H
+
+#define FP_SIZE 1
+
+#endif
diff --git a/arch/um/lkl/um/unimplemented.c b/arch/um/lkl/um/unimplemented.c
new file mode 100644
index 000000000000..fe33e02e39e5
--- /dev/null
+++ b/arch/um/lkl/um/unimplemented.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/signal.h>
+#include <sysdep/ptrace.h>
+#include <asm/ptrace.h>
+
+/* physmem.c  */
+unsigned long high_physmem;
+
+/* x86/um/setjmp*.S  */
+void kernel_longjmp(void)
+{}
+void kernel_setjmp(void)
+{}
+
+/* trap.c */
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
+{}
+void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
+{}
+void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+{}
+void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+{}
+
+/* tlb.c */
+void flush_tlb_kernel_vm(void)
+{}
+void force_flush_all(void)
+{}
+
+/* skas/process.c */
+void halt_skas(void)
+{}
+int is_skas_winch(int pid, int fd, void *data)
+{
+	return 0;
+}
+void reboot_skas(void)
+{}
+
+int __init start_uml(void)
+{
+	return 0;
+}
+
+/* exec.c */
+void flush_thread(void)
+{}
+
+/* x86/ptrace_64.c */
+int is_syscall(unsigned long addr)
+{
+	return 0;
+}
+
+
+/* x86/sysrq.c */
+void show_regs(struct pt_regs *regs)
+{}
+
+/* x86/signal.c */
+int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *mask)
+{
+	return 0;
+}
+
+/* x86/bugs.c */
+void arch_check_bugs(void)
+{}
diff --git a/arch/um/lkl/um/user_constants.h b/arch/um/lkl/um/user_constants.h
new file mode 100644
index 000000000000..2eb692a86c9c
--- /dev/null
+++ b/arch/um/lkl/um/user_constants.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_LIBMODE_USER_CONSTANTS_H
+#define __UM_LIBMODE_USER_CONSTANTS_H
+
+/* XXX: put dummy values */
+#define UM_FRAME_SIZE 4
+#define HOST_FP_SIZE 1
+#define HOST_IP 1
+#define HOST_SP 2
+#define HOST_BP 3
+#define UM_NR_CPUS 1
+
+#endif
-- 
2.21.0 (Apple Git-122.2)

