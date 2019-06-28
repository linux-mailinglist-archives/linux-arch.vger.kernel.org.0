Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4109C5A568
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2019 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfF1Tu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jun 2019 15:50:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:42462 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfF1Tu2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 15:50:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 12:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="164756009"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2019 12:50:27 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH 2/3] Introduce arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE)
Date:   Fri, 28 Jun 2019 12:41:57 -0700
Message-Id: <20190628194158.2431-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628194158.2431-1-yu-cheng.yu@intel.com>
References: <20190628194158.2431-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The CET legacy code bitmap covers the whole user-mode address space and is
located at the top of the user-mode address space.  It is allocated only
when the first time arch_prctl(ARCH_X86_MARK_LEGACY_CODE) is called from
an application.

Introduce:

arch_prctl(ARCH_X86_MARK_LEGACY_CODE, unsigned long *buf)
    Mark an address range as IBT legacy code.

    *buf: starting linear address
    *(buf + 1): size of the legacy code
    *(buf + 2): set (1); clear (0)

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h        |   3 +
 arch/x86/include/asm/processor.h  |  13 +++-
 arch/x86/include/uapi/asm/prctl.h |   1 +
 arch/x86/kernel/Makefile          |   2 +-
 arch/x86/kernel/cet_bitmap.c      | 119 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cet_prctl.c       |  15 ++++
 6 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/cet_bitmap.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 9e613a6598c9..8ca497850f4a 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <asm/processor.h>
 
 struct task_struct;
 struct sc_ext;
@@ -32,6 +33,7 @@ int cet_restore_signal(bool ia32, struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 int cet_setup_ibt(void);
 int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size);
+int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigned long set);
 void cet_disable_ibt(void);
 #else
 static inline int prctl_cet(int option, unsigned long arg2) { return -EINVAL; }
@@ -44,6 +46,7 @@ static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { return -EIN
 static inline int cet_setup_signal(bool ia32, unsigned long rstor,
 				   struct sc_ext *sc) { return -EINVAL; }
 static inline int cet_setup_ibt(void) { return -EINVAL; }
+static inline int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigned long set) { return -EINVAL; }
 static inline void cet_disable_ibt(void) {}
 #endif
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2ae7c1bf4e43..f4600157c73d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -884,7 +884,18 @@ static inline void spin_lock_prefetch(const void *x)
 #define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
-#define STACK_TOP		TASK_SIZE_LOW
+#define MMAP_MAX		(unsigned long)(test_thread_flag(TIF_ADDR32) ? \
+					TASK_SIZE : TASK_SIZE_MAX)
+
+#define IBT_BITMAP_SIZE		(round_up(MMAP_MAX, PAGE_SIZE * BITS_PER_BYTE) / \
+					(PAGE_SIZE * BITS_PER_BYTE))
+
+#define IBT_BITMAP_ADDR		(TASK_SIZE - IBT_BITMAP_SIZE)
+
+#define STACK_TOP		(TASK_SIZE_LOW < IBT_BITMAP_ADDR - PAGE_SIZE ? \
+					TASK_SIZE_LOW : \
+					IBT_BITMAP_ADDR - PAGE_SIZE)
+
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
 #define INIT_THREAD  {						\
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5eb9aeb5c662..5f670e70dc00 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,5 +20,6 @@
 #define ARCH_X86_CET_ALLOC_SHSTK	0x3004
 #define ARCH_X86_CET_GET_LEGACY_BITMAP	0x3005 /* deprecated */
 #define ARCH_X86_CET_SET_LEGACY_BITMAP	0x3006
+#define ARCH_X86_CET_MARK_LEGACY_CODE	0x3007
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index d908c95306fc..754dde1bf9ac 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -140,7 +140,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_X86_INTEL_CET)		+= cet.o cet_prctl.o
+obj-$(CONFIG_X86_INTEL_CET)		+= cet.o cet_prctl.o cet_bitmap.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/cet_bitmap.c b/arch/x86/kernel/cet_bitmap.c
new file mode 100644
index 000000000000..6cb7ac2f66f7
--- /dev/null
+++ b/arch/x86/kernel/cet_bitmap.c
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/bits.h>
+#include <asm/fpu/internal.h>
+#include <asm/cet.h>
+#include <linux/pagemap.h>
+#include <linux/err.h>
+#include <asm/vdso.h>
+
+static int alloc_bitmap(void)
+{
+	unsigned long addr;
+	u64 msr_ia32_u_cet;
+
+	addr = do_mmap_locked(NULL, IBT_BITMAP_ADDR, IBT_BITMAP_SIZE,
+			      PROT_READ | PROT_WRITE,
+			      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE,
+			      VM_IBT | VM_NORESERVE, NULL);
+
+	if (IS_ERR((void *)addr))
+		return addr;
+
+	current->thread.cet.ibt_bitmap_addr = addr;
+	current->thread.cet.ibt_bitmap_size = IBT_BITMAP_SIZE;
+
+	modify_fpu_regs_begin();
+	rdmsrl(MSR_IA32_U_CET, msr_ia32_u_cet);
+	msr_ia32_u_cet |= (MSR_IA32_CET_LEG_IW_EN | addr);
+	wrmsrl(MSR_IA32_U_CET, msr_ia32_u_cet);
+	modify_fpu_regs_end();
+	return 0;
+}
+
+static int set_user_bits(unsigned long __user *buf, unsigned long buf_size,
+			 unsigned long start_bit, unsigned long end_bit, unsigned long set)
+{
+	unsigned long start_ul, end_ul, total_ul;
+	int i, j, r;
+
+	if (round_up(end_bit, BITS_PER_BYTE) / BITS_PER_BYTE > buf_size)
+		end_bit = buf_size * BITS_PER_BYTE - 1;
+
+	start_ul = start_bit / BITS_PER_LONG;
+	end_ul = end_bit / BITS_PER_LONG;
+	total_ul = (end_ul - start_ul + 1);
+
+	i = start_bit % BITS_PER_LONG;
+	j = end_bit % BITS_PER_LONG;
+
+	r = 0;
+	put_user_try {
+		unsigned long tmp;
+		unsigned long x;
+
+		if (total_ul == 1) {
+			get_user_ex(tmp, &buf[start_ul]);
+
+			if (set != 0)
+				tmp |= GENMASK(j, i);
+			else
+				tmp &= ~GENMASK(j, i);
+
+			put_user_ex(tmp, &buf[start_ul]);
+		} else {
+			get_user_ex(tmp, &buf[start_ul]);
+
+			if (set != 0)
+				tmp |= GENMASK(BITS_PER_LONG - 1, i);
+			else
+				tmp &= ~GENMASK(BITS_PER_LONG - 1, i);
+
+			put_user_ex(tmp, &buf[start_ul]);
+
+			get_user_ex(tmp, &buf[end_ul]);
+
+			if (set != 0)
+				tmp |= GENMASK(j, 0);
+			else
+				tmp &= ~GENMASK(j, 0);
+
+			put_user_ex(tmp, &buf[end_ul]);
+
+			if (set != 0) {
+				for (x = start_ul + 1; x < end_ul; x++)
+					put_user_ex(~0UL, &buf[x]);
+			} else {
+				for (x = start_ul + 1; x < end_ul; x++)
+					put_user_ex(0UL, &buf[x]);
+			}
+		}
+	} put_user_catch(r);
+
+	return r;
+}
+
+int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigned long set)
+{
+	unsigned long bitmap_addr, bitmap_size;
+	int r;
+
+	if (!current->thread.cet.ibt_enabled)
+		return -EINVAL;
+
+	if (current->thread.cet.ibt_bitmap_size == 0) {
+		r = alloc_bitmap();
+		if (r)
+			return r;
+	}
+
+	bitmap_addr = current->thread.cet.ibt_bitmap_addr;
+	bitmap_size = current->thread.cet.ibt_bitmap_size;
+
+	r = set_user_bits((unsigned long * __user)bitmap_addr, bitmap_size,
+			  addr / PAGE_SIZE, (addr + size - 1) / PAGE_SIZE, set);
+
+	return r;
+}
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index b7f37bbc0dd3..b2b7f462482f 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -68,6 +68,18 @@ static int handle_bitmap(unsigned long arg2)
 	return cet_setup_ibt_bitmap(addr, size);
 }
 
+static int handle_mark_legacy_code(unsigned long arg2)
+{
+	unsigned long addr, size, set;
+
+	if (get_user(addr, (unsigned long __user *)arg2) ||
+	    get_user(size, (unsigned long __user *)arg2 + 1) ||
+	    get_user(set, (unsigned long __user *)arg2 + 2))
+		return -EFAULT;
+
+	return cet_mark_legacy_code(addr, size, set);
+}
+
 int prctl_cet(int option, unsigned long arg2)
 {
 	if (!cpu_x86_cet_enabled())
@@ -100,6 +112,9 @@ int prctl_cet(int option, unsigned long arg2)
 	case ARCH_X86_CET_SET_LEGACY_BITMAP:
 		return handle_bitmap(arg2);
 
+	case ARCH_X86_CET_MARK_LEGACY_CODE:
+		return handle_mark_legacy_code(arg2);
+
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1

