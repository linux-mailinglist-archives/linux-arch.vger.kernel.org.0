Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CABE250D20
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHYAa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:30:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:12299 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgHYAaK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:30:10 -0400
IronPort-SDR: zZLh7F+tHQSDNA0aE8rUNVJ0ug8iHjYAYgGtA+0nlbH3qWFTOmrLuNHtqhHHr6bOBQeQZZYZP0
 PLA5y4xSIcvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075333"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:46 -0700
IronPort-SDR: vBxtYzbcxKNaKSno6bFQ3E6UFyj551jhcVZWN6WfuCl4+Px/9HFVxgnyYKvLeQXEykBTwHw5PN
 5eDLWR18+fdg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474135046"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:45 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for shadow stack
Date:   Mon, 24 Aug 2020 17:25:40 -0700
Message-Id: <20200825002540.3351-26-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
    Get CET feature status.

    The parameter 'args' is a pointer to a user buffer.  The kernel returns
    the following information:

    *args = shadow stack/IBT status
    *(args + 1) = shadow stack base address
    *(args + 2) = shadow stack size

arch_prctl(ARCH_X86_CET_DISABLE, u64 features)
    Disable CET features specified in 'features'.  Return -EPERM if CET is
    locked.

arch_prctl(ARCH_X86_CET_LOCK)
    Lock in CET features.

arch_prctl(ARCH_X86_CET_MMAP_SHSTK, u64 *args)
    Allocate a new shadow stack.

    The parameter 'args' is a pointer to a user buffer.

    *args = desired size
    *(args + 1) = MAP_32BIT or MAP_POPULATE

    On returning, *args is the allocated shadow stack address.

Also change do_arch_prctl_common()'s parameter 'cpuid_enabled' to
'arg2', as it is now also passed to prctl_cet().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v11:
- Check input for invalid features.
- Fix prctl_cet() return values.
- Change ARCH_X86_CET_ALLOC_SHSTK to ARCH_X86_CET_MMAP_SHSTK to take
  MAP_32BIT, MAP_POPULATE as inputs.

v10:
- Verify CET is enabled before handling arch_prctl.
- Change input parameters from unsigned long to u64, to make it clear they
  are 64-bit.

 arch/x86/include/asm/cet.h              |  4 +
 arch/x86/include/uapi/asm/prctl.h       |  5 ++
 arch/x86/kernel/Makefile                |  2 +-
 arch/x86/kernel/cet.c                   | 26 +++++++
 arch/x86/kernel/cet_prctl.c             | 98 +++++++++++++++++++++++++
 arch/x86/kernel/process.c               |  6 +-
 tools/arch/x86/include/uapi/asm/prctl.h |  5 ++
 7 files changed, 142 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/cet_prctl.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 71dc92acd2f2..f7eb197998ad 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -14,16 +14,20 @@ struct sc_ext;
 struct cet_status {
 	unsigned long	shstk_base;
 	unsigned long	shstk_size;
+	unsigned int	locked:1;
 };
 
 #ifdef CONFIG_X86_INTEL_CET
+int prctl_cet(int option, u64 arg2);
 int cet_setup_shstk(void);
 int cet_setup_thread_shstk(struct task_struct *p);
+unsigned long cet_alloc_shstk(unsigned long size, int flags);
 void cet_disable_free_shstk(struct task_struct *p);
 int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp);
 void cet_restore_signal(struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
+static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
 static inline int cet_setup_thread_shstk(struct task_struct *p) { return 0; }
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
 static inline void cet_restore_signal(struct sc_ext *sc) { return; }
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..3aaac13cdc87 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -14,4 +14,9 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#define ARCH_X86_CET_STATUS		0x3001
+#define ARCH_X86_CET_DISABLE		0x3002
+#define ARCH_X86_CET_LOCK		0x3003
+#define ARCH_X86_CET_MMAP_SHSTK		0x3004
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 76f27f518266..97556e4204d6 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,7 +145,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_X86_INTEL_CET)		+= cet.o
+obj-$(CONFIG_X86_INTEL_CET)		+= cet.o cet_prctl.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index b30c61a66c8e..2bf1a6b6abb6 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -148,6 +148,32 @@ static int create_rstor_token(bool ia32, unsigned long ssp,
 	return 0;
 }
 
+unsigned long cet_alloc_shstk(unsigned long len, int flags)
+{
+	unsigned long token;
+	unsigned long addr, ssp;
+
+	addr = alloc_shstk(round_up(len, PAGE_SIZE), flags);
+
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	/* Restore token is 8 bytes and aligned to 8 bytes */
+	ssp = addr + len;
+	token = ssp;
+
+	if (!in_ia32_syscall())
+		token |= TOKEN_MODE_64;
+	ssp -= 8;
+
+	if (write_user_shstk_64(ssp, token)) {
+		vm_munmap(addr, len);
+		return -EINVAL;
+	}
+
+	return addr;
+}
+
 int cet_setup_shstk(void)
 {
 	unsigned long addr, size;
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
new file mode 100644
index 000000000000..cc49eef08ab0
--- /dev/null
+++ b/arch/x86/kernel/cet_prctl.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+#include <linux/prctl.h>
+#include <linux/compat.h>
+#include <linux/mman.h>
+#include <linux/elfcore.h>
+#include <asm/processor.h>
+#include <asm/prctl.h>
+#include <asm/cet.h>
+
+/* See Documentation/x86/intel_cet.rst. */
+
+static int copy_status_to_user(struct cet_status *cet, u64 arg2)
+{
+	u64 buf[3] = {0, 0, 0};
+
+	if (cet->shstk_size) {
+		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+		buf[1] = (u64)cet->shstk_base;
+		buf[2] = (u64)cet->shstk_size;
+	}
+
+	return copy_to_user((u64 __user *)arg2, buf, sizeof(buf));
+}
+
+static int handle_mmap_shstk(u64 arg2)
+{
+	u64 buf[3];
+	unsigned long addr, size;
+	int allowed_flags;
+
+	if (copy_from_user(buf, (unsigned long __user *)arg2, sizeof(buf)))
+		return -EFAULT;
+
+	size = buf[0];
+
+	/*
+	 * Check invalid flags
+	 */
+	allowed_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_32BIT | MAP_POPULATE;
+
+	if (buf[1] & ~allowed_flags)
+		return -EINVAL;
+
+	addr = cet_alloc_shstk(size, buf[1]);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	if (put_user(addr, (u64 __user *)arg2)) {
+		vm_munmap(addr, size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int prctl_cet(int option, u64 arg2)
+{
+	struct cet_status *cet;
+
+	/*
+	 * GLIBC's ENOTSUPP == EOPNOTSUPP == 95, and it does not recognize
+	 * the kernel's ENOTSUPP (524).  So return EOPNOTSUPP here.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
+		return -EOPNOTSUPP;
+
+	cet = &current->thread.cet;
+
+	if (option == ARCH_X86_CET_STATUS)
+		return copy_status_to_user(cet, arg2);
+
+	if (!static_cpu_has(X86_FEATURE_SHSTK))
+		return -EOPNOTSUPP;
+
+	switch (option) {
+	case ARCH_X86_CET_DISABLE:
+		if (cet->locked)
+			return -EPERM;
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_INVAL)
+			return -EINVAL;
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+			cet_disable_free_shstk(current);
+		return 0;
+
+	case ARCH_X86_CET_LOCK:
+		cet->locked = 1;
+		return 0;
+
+	case ARCH_X86_CET_MMAP_SHSTK:
+		return handle_mmap_shstk(arg2);
+
+	default:
+		return -ENOSYS;
+	}
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6fe5b061841..5a657a9774dc 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -980,14 +980,14 @@ unsigned long get_wchan(struct task_struct *p)
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
+		return set_cpuid_mode(task, arg2);
 	}
 
-	return -EINVAL;
+	return prctl_cet(option, arg2);
 }
diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..3aaac13cdc87 100644
--- a/tools/arch/x86/include/uapi/asm/prctl.h
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -14,4 +14,9 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#define ARCH_X86_CET_STATUS		0x3001
+#define ARCH_X86_CET_DISABLE		0x3002
+#define ARCH_X86_CET_LOCK		0x3003
+#define ARCH_X86_CET_MMAP_SHSTK		0x3004
+
 #endif /* _ASM_X86_PRCTL_H */
-- 
2.21.0

