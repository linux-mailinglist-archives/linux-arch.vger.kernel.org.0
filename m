Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E228498F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFJpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJpf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15371C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so7704877pgj.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbeT0aDn84YqpSk2fqmGVshTX0oxiLRkXLCOroc9c3w=;
        b=hfe2tQcambghb51JNMJDDTpzL/d4JDVX2vxR+g4ZHg+XzhqlZIAcc9mUJ3CcxVE4Sn
         SjJFoLUMYlLfV45cKgasUwUge9i+2Ef1lI165YP0DmsOm8UtfkyGvJx/R8HKfm/wiOxQ
         VS8NIqH1oQWcHBpwXbN12FKPa+kyo5UIrtbmIq6Es7FcJsNGap+hqzmyBQa588V7gAyf
         ywo3aq/o78URo5ZvBZWvUCongDy3DXCN5cceT30QtFupgHClnaRVK5AunKW8fCcSCg0w
         MmS9+HqCYT8crJzviu9wUnc0c4JBkv2hU1rvLcV2JGAeXew0wflF7VRXgBJwhak7t+oM
         +D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbeT0aDn84YqpSk2fqmGVshTX0oxiLRkXLCOroc9c3w=;
        b=ABGZ97+1wvdI873xdg7yShx0W0K+/72FYZli+i+t6KNyGwJgT8kNS/oqNmLiKnPkwM
         tABSjb6hoX3O9RDjiTc2yKE1lLeBD1QXC7wrzFqL1P2LfXvJD5eDFm3DhDk3/mQut9e0
         7rYbu1IImfIgWdokry8K7yZ8q1WI4J72wpWU12fjvmHuF0nNaZR1HdTLsacO1yd0FoNv
         ahLSmCIQMAWYRyPVTjqK4QHEU7JYdZMLHRzzp6olgWEJ+Uz0QyD9Vjmf4RplYEeLuRJV
         4Umk5KhbWISpogNijwo+BSr3xIbbIS8N5zLQB2u7/fbgBGnzZKsZ/b+JFF/AYcQC9KuH
         +sZQ==
X-Gm-Message-State: AOAM533cqezKLFAcmAbxIGw+Vq2H3LWUUh07HlaHjVSb4exc3A6VgmT0
        +mOqRMOlgVgzKSM9Z4heGfk=
X-Google-Smtp-Source: ABdhPJxIrgkOuS8aipER/E00hq7YWGLtA6asVHREU3Y+sZxPUbODjZKm/JrMURN+rN9J0VXj/x+XlQ==
X-Received: by 2002:a62:1414:0:b029:152:44af:42e with SMTP id 20-20020a6214140000b029015244af042emr3644588pfu.66.1601977534356;
        Tue, 06 Oct 2020 02:45:34 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 126sm2845981pfg.192.2020.10.06.02.45.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:33 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id C6C3C20390F4BF; Tue,  6 Oct 2020 18:45:27 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 08/21] um: add nommu mode for UML library mode
Date:   Tue,  6 Oct 2020 18:44:17 +0900
Message-Id: <ac5a99db869705b284307dea21b37068ee5ae7d2.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch introduces the nommu operation with UML code so that host
interface can be shrineked for broader environments support.

The nommu mode is implemneted as SUBARCH of arch/um, which places at
arch/um/nommu. This SUBARCH defines mode-specific code of memory
management as well as thread implementation, along with the uapi headers
to be exported to users.

The headers we introduce in this patch are simple wrappers to the
asm-generic headers or stubs for things we don't support, such as
ptrace, DMA, signals, ELF handling and low level processor operations.

nommu mode shares most of arch/um code (irq, thread_info, process
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
   |-- nommu           SUBARCH dir (internally =um/nommu)
   |   |-- include
   |   |   |-- asm     headers for subarch specific info
   |   |   `-- uapi    headers for user-visible APIs
   |   `-- um
   |       `-- shared  headers for subarch specific info
   `-- scripts         added a script for header installation

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/nommu/Makefile                        |   1 +
 arch/um/nommu/Makefile.um                     |  22 ++++
 arch/um/nommu/include/asm/Kbuild              |   6 +
 arch/um/nommu/include/asm/archparam.h         |   1 +
 arch/um/nommu/include/asm/atomic.h            |  11 ++
 arch/um/nommu/include/asm/atomic64.h          | 114 ++++++++++++++++++
 arch/um/nommu/include/asm/bitsperlong.h       |  12 ++
 arch/um/nommu/include/asm/byteorder.h         |   7 ++
 arch/um/nommu/include/asm/cpu.h               |  13 ++
 arch/um/nommu/include/asm/elf.h               |  15 +++
 arch/um/nommu/include/asm/mm_context.h        |   8 ++
 arch/um/nommu/include/asm/processor.h         |  46 +++++++
 arch/um/nommu/include/asm/ptrace.h            |  21 ++++
 arch/um/nommu/include/asm/sched.h             |  23 ++++
 arch/um/nommu/include/asm/segment.h           |   9 ++
 arch/um/nommu/include/uapi/asm/Kbuild         |   6 +
 arch/um/nommu/include/uapi/asm/bitsperlong.h  |  11 ++
 arch/um/nommu/include/uapi/asm/byteorder.h    |  11 ++
 arch/um/nommu/include/uapi/asm/sigcontext.h   |  12 ++
 arch/um/nommu/um/delay.c                      |  31 +++++
 arch/um/nommu/um/shared/sysdep/archsetjmp.h   |  13 ++
 arch/um/nommu/um/shared/sysdep/faultinfo.h    |   8 ++
 .../nommu/um/shared/sysdep/kernel-offsets.h   |  12 ++
 arch/um/nommu/um/shared/sysdep/mcontext.h     |   9 ++
 arch/um/nommu/um/shared/sysdep/ptrace.h       |  42 +++++++
 arch/um/nommu/um/shared/sysdep/ptrace_user.h  |   7 ++
 arch/um/nommu/um/unimplemented.c              |  70 +++++++++++
 arch/um/nommu/um/user_constants.h             |  13 ++
 28 files changed, 554 insertions(+)
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/Makefile.um
 create mode 100644 arch/um/nommu/include/asm/Kbuild
 create mode 100644 arch/um/nommu/include/asm/archparam.h
 create mode 100644 arch/um/nommu/include/asm/atomic.h
 create mode 100644 arch/um/nommu/include/asm/atomic64.h
 create mode 100644 arch/um/nommu/include/asm/bitsperlong.h
 create mode 100644 arch/um/nommu/include/asm/byteorder.h
 create mode 100644 arch/um/nommu/include/asm/cpu.h
 create mode 100644 arch/um/nommu/include/asm/elf.h
 create mode 100644 arch/um/nommu/include/asm/mm_context.h
 create mode 100644 arch/um/nommu/include/asm/processor.h
 create mode 100644 arch/um/nommu/include/asm/ptrace.h
 create mode 100644 arch/um/nommu/include/asm/sched.h
 create mode 100644 arch/um/nommu/include/asm/segment.h
 create mode 100644 arch/um/nommu/include/uapi/asm/Kbuild
 create mode 100644 arch/um/nommu/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/um/nommu/include/uapi/asm/byteorder.h
 create mode 100644 arch/um/nommu/include/uapi/asm/sigcontext.h
 create mode 100644 arch/um/nommu/um/delay.c
 create mode 100644 arch/um/nommu/um/shared/sysdep/archsetjmp.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/faultinfo.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/kernel-offsets.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/mcontext.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/ptrace.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/ptrace_user.h
 create mode 100644 arch/um/nommu/um/unimplemented.c
 create mode 100644 arch/um/nommu/um/user_constants.h

diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
new file mode 100644
index 000000000000..792d6005489e
--- /dev/null
+++ b/arch/um/nommu/Makefile
@@ -0,0 +1 @@
+#
diff --git a/arch/um/nommu/Makefile.um b/arch/um/nommu/Makefile.um
new file mode 100644
index 000000000000..3808462d8283
--- /dev/null
+++ b/arch/um/nommu/Makefile.um
@@ -0,0 +1,22 @@
+KBUILD_CFLAGS += -fno-builtin -fPIC
+ELF_FORMAT=$(shell $(LD) -r -print-output-format)
+
+ifeq ($(shell uname -s), Linux)
+NPROC=$(shell nproc)
+else # e.g., FreeBSD
+NPROC=$(shell sysctl -n hw.ncpu)
+endif
+
+um_headers_install: $(objtree)/$(HOST_DIR)/include/generated/uapi/asm/syscall_defs.h headers
+# if syscall_defs.h is newer than generated headers (autoconf.h)
+	$(Q)if [ ! -r $(objtree)/tools/um/include/lkl/autoconf.h ] || \
+	  [ $< -nt $(objtree)/tools/um/include/lkl/autoconf.h ]; then \
+		$(srctree)/$(ARCH_DIR)/scripts/headers_install.py \
+			$(subst -j,-j$(NPROC),$(findstring -j,$(MAKEFLAGS))) \
+			$(INSTALL_PATH)/include ; \
+	fi
+
+$(objtree)/$(HOST_DIR)/include/generated/uapi/asm/syscall_defs.h: vmlinux
+	$(Q)$(OBJCOPY) -j .syscall_defs -O binary --set-section-flags .syscall_defs=alloc $< $@
+	$(Q) export tmpfile=$(shell mktemp); \
+	sed 's/\x0//g' $@ > $$tmpfile; mv $$tmpfile $@ ; rm -f $$tmpfile
diff --git a/arch/um/nommu/include/asm/Kbuild b/arch/um/nommu/include/asm/Kbuild
new file mode 100644
index 000000000000..2532e1a0a0d1
--- /dev/null
+++ b/arch/um/nommu/include/asm/Kbuild
@@ -0,0 +1,6 @@
+generic-y += cmpxchg.h
+generic-y += local64.h
+generic-y += seccomp.h
+generic-y += string.h
+generic-y += syscall.h
+generic-y += user.h
diff --git a/arch/um/nommu/include/asm/archparam.h b/arch/um/nommu/include/asm/archparam.h
new file mode 100644
index 000000000000..ea32a7d3cf1b
--- /dev/null
+++ b/arch/um/nommu/include/asm/archparam.h
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0 */
diff --git a/arch/um/nommu/include/asm/atomic.h b/arch/um/nommu/include/asm/atomic.h
new file mode 100644
index 000000000000..63e2e16bda92
--- /dev/null
+++ b/arch/um/nommu/include/asm/atomic.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_ATOMIC_H
+#define __UM_NOMMU_ATOMIC_H
+
+#include <asm-generic/atomic.h>
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+#include "atomic64.h"
+#endif /* !CONFIG_GENERIC_ATOMIC64 */
+
+#endif
diff --git a/arch/um/nommu/include/asm/atomic64.h b/arch/um/nommu/include/asm/atomic64.h
new file mode 100644
index 000000000000..949360dea7af
--- /dev/null
+++ b/arch/um/nommu/include/asm/atomic64.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_ATOMIC64_H
+#define __UM_NOMMU_ATOMIC64_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_SMP
+#error "SMP is not supported on this platform"
+#else
+#define ATOMIC64_OP(op, c_op)					\
+	static inline void atomic64_##op(s64 i, atomic64_t *v)	\
+	{							\
+		unsigned long flags;				\
+								\
+		raw_local_irq_save(flags);			\
+		v->counter = v->counter c_op i;			\
+		raw_local_irq_restore(flags);			\
+	}
+
+#define ATOMIC64_OP_RETURN(op, c_op)					\
+	static inline s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
+	{								\
+		unsigned long flags;					\
+		s64 ret;						\
+									\
+		raw_local_irq_save(flags);				\
+		ret = (v->counter = v->counter c_op i);			\
+		raw_local_irq_restore(flags);				\
+									\
+		return ret;						\
+	}
+
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+	static inline s64 atomic64_fetch_##op(s64 i, atomic64_t *v)	\
+	{								\
+		unsigned long flags;					\
+		s64 ret;						\
+									\
+		raw_local_irq_save(flags);				\
+		ret = v->counter;					\
+		v->counter = v->counter c_op i;				\
+		raw_local_irq_restore(flags);				\
+									\
+		return ret;						\
+	}
+#endif /* CONFIG_SMP */
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
diff --git a/arch/um/nommu/include/asm/bitsperlong.h b/arch/um/nommu/include/asm/bitsperlong.h
new file mode 100644
index 000000000000..a150cee41e75
--- /dev/null
+++ b/arch/um/nommu/include/asm/bitsperlong.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_BITSPERLONG_H
+#define __UM_NOMMU_BITSPERLONG_H
+
+#include <uapi/asm/bitsperlong.h>
+
+#define BITS_PER_LONG __BITS_PER_LONG
+
+#define BITS_PER_LONG_LONG 64
+
+#endif
+
diff --git a/arch/um/nommu/include/asm/byteorder.h b/arch/um/nommu/include/asm/byteorder.h
new file mode 100644
index 000000000000..920a5fd26cad
--- /dev/null
+++ b/arch/um/nommu/include/asm/byteorder.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_BYTEORDER_H
+#define __UM_NOMMU_BYTEORDER_H
+
+#include <uapi/asm/byteorder.h>
+
+#endif
diff --git a/arch/um/nommu/include/asm/cpu.h b/arch/um/nommu/include/asm/cpu.h
new file mode 100644
index 000000000000..c101c078ef21
--- /dev/null
+++ b/arch/um/nommu/include/asm/cpu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_CPU_H
+#define __UM_NOMMU_CPU_H
+
+int lkl_cpu_get(void);
+void lkl_cpu_put(void);
+int lkl_cpu_try_run_irq(int irq);
+int lkl_cpu_init(void);
+void lkl_cpu_wait_shutdown(void);
+void lkl_cpu_change_owner(lkl_thread_t owner);
+void lkl_cpu_set_irqs_pending(void);
+
+#endif
diff --git a/arch/um/nommu/include/asm/elf.h b/arch/um/nommu/include/asm/elf.h
new file mode 100644
index 000000000000..edcf63edeed1
--- /dev/null
+++ b/arch/um/nommu/include/asm/elf.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_ELF_H
+#define __UM_NOMMU_ELF_H
+
+#define elf_check_arch(x) 0
+
+#ifdef CONFIG_64BIT
+#define ELF_CLASS ELFCLASS64
+#else
+#define ELF_CLASS ELFCLASS32
+#endif
+
+#define elf_gregset_t long
+#define elf_fpregset_t double
+#endif
diff --git a/arch/um/nommu/include/asm/mm_context.h b/arch/um/nommu/include/asm/mm_context.h
new file mode 100644
index 000000000000..a2e53984aabd
--- /dev/null
+++ b/arch/um/nommu/include/asm/mm_context.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_MM_CONTEXT_H
+#define __UM_NOMMU_MM_CONTEXT_H
+
+struct uml_arch_mm_context {
+};
+
+#endif
diff --git a/arch/um/nommu/include/asm/processor.h b/arch/um/nommu/include/asm/processor.h
new file mode 100644
index 000000000000..3e8ba870caaf
--- /dev/null
+++ b/arch/um/nommu/include/asm/processor.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_PROCESSOR_H
+#define __UM_NOMMU_PROCESSOR_H
+
+#include <asm/host_ops.h>
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
+#define task_pt_regs(tsk) (struct pt_regs *)(NULL)
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
diff --git a/arch/um/nommu/include/asm/ptrace.h b/arch/um/nommu/include/asm/ptrace.h
new file mode 100644
index 000000000000..b214410e9825
--- /dev/null
+++ b/arch/um/nommu/include/asm/ptrace.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_PTRACE_H
+#define __UM_NOMMU_PTRACE_H
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
diff --git a/arch/um/nommu/include/asm/sched.h b/arch/um/nommu/include/asm/sched.h
new file mode 100644
index 000000000000..a4496f482633
--- /dev/null
+++ b/arch/um/nommu/include/asm/sched.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_SCHED_H
+#define __UM_NOMMU_SCHED_H
+
+#include <linux/sched.h>
+#include <uapi/asm/host_ops.h>
+
+static inline void thread_sched_jb(void)
+{
+	if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD)) {
+		set_ti_thread_flag(current_thread_info(), TIF_SCHED_JB);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		lkl_ops->jmp_buf_set(&current_thread_info()->task->thread.arch.sched_jb,
+				     schedule);
+	} else {
+		lkl_bug("%s can be used only for host task", __func__);
+	}
+}
+
+void switch_to_host_task(struct task_struct *);
+int host_task_stub(void *unused);
+
+#endif
diff --git a/arch/um/nommu/include/asm/segment.h b/arch/um/nommu/include/asm/segment.h
new file mode 100644
index 000000000000..5608da95cb60
--- /dev/null
+++ b/arch/um/nommu/include/asm/segment.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_SEGMENT_H
+#define __UM_NOMMU_SEGMENT_H
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+#endif /* _ASM_LKL_SEGMENT_H */
diff --git a/arch/um/nommu/include/uapi/asm/Kbuild b/arch/um/nommu/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..0d55c408dac2
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/Kbuild
@@ -0,0 +1,6 @@
+# UAPI Header export list
+
+generated-y += syscall_defs.h
+
+# no generated-y since we need special user headers handling
+# see arch/um/script/headers_install.py
diff --git a/arch/um/nommu/include/uapi/asm/bitsperlong.h b/arch/um/nommu/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..852566ac2e52
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_BITSPERLONG_H
+#define __UM_NOMMU_UAPI_BITSPERLONG_H
+
+#ifdef CONFIG_64BIT
+#define __BITS_PER_LONG 64
+#else
+#define __BITS_PER_LONG 32
+#endif
+
+#endif
diff --git a/arch/um/nommu/include/uapi/asm/byteorder.h b/arch/um/nommu/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..e7ad11a751cf
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/byteorder.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_BYTEORDER_H
+#define __UM_NOMMU_UAPI_BYTEORDER_H
+
+#if defined(CONFIG_BIG_ENDIAN)
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#endif
diff --git a/arch/um/nommu/include/uapi/asm/sigcontext.h b/arch/um/nommu/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..b934ae7f5550
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/sigcontext.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_SIGCONTEXT_H
+#define __UM_NOMMU_UAPI_SIGCONTEXT_H
+
+#include <asm/ptrace-generic.h>
+
+struct sigcontext {
+	struct pt_regs regs;
+	unsigned long oldmask;
+};
+
+#endif
diff --git a/arch/um/nommu/um/delay.c b/arch/um/nommu/um/delay.c
new file mode 100644
index 000000000000..58a366d9b5f0
--- /dev/null
+++ b/arch/um/nommu/um/delay.c
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
diff --git a/arch/um/nommu/um/shared/sysdep/archsetjmp.h b/arch/um/nommu/um/shared/sysdep/archsetjmp.h
new file mode 100644
index 000000000000..4a5c10d7521b
--- /dev/null
+++ b/arch/um/nommu/um/shared/sysdep/archsetjmp.h
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
diff --git a/arch/um/nommu/um/shared/sysdep/faultinfo.h b/arch/um/nommu/um/shared/sysdep/faultinfo.h
new file mode 100644
index 000000000000..49210742212d
--- /dev/null
+++ b/arch/um/nommu/um/shared/sysdep/faultinfo.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_FAULTINFO_H
+#define __ARCH_UM_FAULTINFO_H
+
+struct faultinfo {
+};
+
+#endif /* __ARCH_UM_FAULTINFO_H */
diff --git a/arch/um/nommu/um/shared/sysdep/kernel-offsets.h b/arch/um/nommu/um/shared/sysdep/kernel-offsets.h
new file mode 100644
index 000000000000..a004bffb7b8d
--- /dev/null
+++ b/arch/um/nommu/um/shared/sysdep/kernel-offsets.h
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
diff --git a/arch/um/nommu/um/shared/sysdep/mcontext.h b/arch/um/nommu/um/shared/sysdep/mcontext.h
new file mode 100644
index 000000000000..b734012a74da
--- /dev/null
+++ b/arch/um/nommu/um/shared/sysdep/mcontext.h
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
diff --git a/arch/um/nommu/um/shared/sysdep/ptrace.h b/arch/um/nommu/um/shared/sysdep/ptrace.h
new file mode 100644
index 000000000000..bfdfb520a21d
--- /dev/null
+++ b/arch/um/nommu/um/shared/sysdep/ptrace.h
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
diff --git a/arch/um/nommu/um/shared/sysdep/ptrace_user.h b/arch/um/nommu/um/shared/sysdep/ptrace_user.h
new file mode 100644
index 000000000000..86d5cb20fb9f
--- /dev/null
+++ b/arch/um/nommu/um/shared/sysdep/ptrace_user.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_UM_PTRACE_USER_H
+#define __ARCH_UM_PTRACE_USER_H
+
+#define FP_SIZE 1
+
+#endif
diff --git a/arch/um/nommu/um/unimplemented.c b/arch/um/nommu/um/unimplemented.c
new file mode 100644
index 000000000000..fe33e02e39e5
--- /dev/null
+++ b/arch/um/nommu/um/unimplemented.c
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
diff --git a/arch/um/nommu/um/user_constants.h b/arch/um/nommu/um/user_constants.h
new file mode 100644
index 000000000000..2245d3d24120
--- /dev/null
+++ b/arch/um/nommu/um/user_constants.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_USER_CONSTANTS_H
+#define __UM_NOMMU_USER_CONSTANTS_H
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

