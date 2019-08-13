Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168338C2B7
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfHMVDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:03:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:18661 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfHMVDr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="194276008"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2019 14:03:42 -0700
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
Subject: [PATCH v8 14/14] Introduce arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE)
Date:   Tue, 13 Aug 2019 13:53:59 -0700
Message-Id: <20190813205359.12196-15-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205359.12196-1-yu-cheng.yu@intel.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When CET Indirect Branch Tracking (IBT) is enabled, the processor expects
every branch target is an ENDBR instruction, or the target's address is
marked as legacy in the legacy code bitmap.  The bitmap covers the whole
user-mode address space (TASK_SIZE_MAX for 64-bit, TASK_SIZE for IA32),
and each bit represents one page of linear address range.  The bitmap is
located at the topmost address: (TASK_SIZE - IBT_BITMAP_SIZE).

It is allocated only when the first time ARCH_X86_MARK_LEGACY_CODE
is called from an application.

The IBT bitmap is visiable from user-mode, but not writable.

Introduce:

arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE, unsigned long *buf)
    Mark an address range as IBT legacy code.

    *buf: starting linear address
    *(buf + 1): size of the legacy code
    *(buf + 2): set (1); clear (0)

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h        |   3 +
 arch/x86/include/asm/processor.h  |  13 +-
 arch/x86/include/uapi/asm/prctl.h |   1 +
 arch/x86/kernel/Makefile          |   2 +-
 arch/x86/kernel/cet_bitmap.c      | 210 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cet_prctl.c       |  15 +++
 mm/memory.c                       |   8 ++
 7 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/cet_bitmap.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 2561efe081ad..d5f693d082b0 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <asm/processor.h>
 
 struct task_struct;
 struct sc_ext;
@@ -30,6 +31,7 @@ void cet_disable_free_shstk(struct task_struct *p);
 int cet_restore_signal(bool ia32, struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 int cet_setup_ibt(void);
+int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigned long set);
 void cet_disable_ibt(void);
 #else
 static inline int prctl_cet(int option, unsigned long arg2) { return -EINVAL; }
@@ -42,6 +44,7 @@ static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { return -EIN
 static inline int cet_setup_signal(bool ia32, unsigned long rstor,
 				   struct sc_ext *sc) { return -EINVAL; }
 static inline int cet_setup_ibt(void) { return -EINVAL; }
+static inline int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigned long set) { return -EINVAL; }
 static inline void cet_disable_ibt(void) {}
 #endif
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0f9bc7fd1351..af3bdd545a55 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -888,7 +888,18 @@ static inline void spin_lock_prefetch(const void *x)
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
index 02243127dcf6..da39d4bde4e1 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,5 +20,6 @@
 #define ARCH_X86_CET_ALLOC_SHSTK	0x3004
 #define ARCH_X86_CET_GET_LEGACY_BITMAP	0x3005 /* deprecated */
 #define ARCH_X86_CET_SET_LEGACY_BITMAP	0x3006 /* deprecated */
+#define ARCH_X86_CET_MARK_LEGACY_CODE	0x3007
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 311829335521..228906364513 100644
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
index 000000000000..25eb441eb094
--- /dev/null
+++ b/arch/x86/kernel/cet_bitmap.c
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/memcontrol.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/oom.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+#include <linux/swap.h>
+#include <asm/cet.h>
+#include <asm/fpu/internal.h>
+
+/*
+ * For read fault, provide the zero page.  For write fault coming from
+ * get_user_pages(), clear the page already allocated.
+ */
+static vm_fault_t bitmap_fault(const struct vm_special_mapping *sm,
+			       struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	if (!(vmf->flags & FAULT_FLAG_WRITE)) {
+		vmf->page = ZERO_PAGE(vmf->address);
+		return 0;
+	} else {
+		vm_fault_t r;
+
+		if (!vmf->cow_page)
+			return VM_FAULT_ERROR;
+
+		clear_user_highpage(vmf->cow_page, vmf->address);
+		__SetPageUptodate(vmf->cow_page);
+		r = finish_fault(vmf);
+		return r ? r : VM_FAULT_DONE_COW;
+	}
+}
+
+static int bitmap_mremap(const struct vm_special_mapping *sm,
+			 struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
+static const struct vm_special_mapping bitmap_mapping = {
+	.name	= "[ibt_bitmap]",
+	.fault	= bitmap_fault,
+	.mremap	= bitmap_mremap,
+};
+
+static int alloc_bitmap(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	u64 msr_ia32_u_cet;
+	int r = 0;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	vma = _install_special_mapping(mm, IBT_BITMAP_ADDR, IBT_BITMAP_SIZE,
+				       VM_READ | VM_MAYREAD | VM_MAYWRITE,
+				       &bitmap_mapping);
+
+	if (IS_ERR(vma))
+		r = PTR_ERR(vma);
+
+	up_write(&mm->mmap_sem);
+
+	if (r)
+		return r;
+
+	current->thread.cet.ibt_bitmap_used = 1;
+
+	modify_fpu_regs_begin();
+	rdmsrl(MSR_IA32_U_CET, msr_ia32_u_cet);
+	msr_ia32_u_cet |= (MSR_IA32_CET_LEG_IW_EN | IBT_BITMAP_ADDR);
+	wrmsrl(MSR_IA32_U_CET, msr_ia32_u_cet);
+	modify_fpu_regs_end();
+	return 0;
+}
+
+/*
+ * Set bits in the IBT legacy code bitmap, which is read-only user memory.
+ */
+static int set_bits(unsigned long start_bit, unsigned long end_bit,
+		    unsigned long set)
+{
+	unsigned long start_ul, end_ul, nr_ul;
+	unsigned long start_ul_addr, tmp_addr, len;
+	int i, j;
+
+	start_ul = start_bit / BITS_PER_LONG;
+	end_ul = end_bit / BITS_PER_LONG;
+	i = start_bit % BITS_PER_LONG;
+	j = end_bit % BITS_PER_LONG;
+
+	start_ul_addr = IBT_BITMAP_ADDR + start_ul * sizeof(0UL);
+	nr_ul = end_ul - start_ul + 1;
+
+	tmp_addr = start_ul_addr;
+	len = nr_ul * sizeof(0UL);
+
+	down_read(&current->mm->mmap_sem);
+	while (len) {
+		unsigned long *first, *last, mask, bytes;
+		int ret, offset;
+		void *kern_page_addr;
+		struct page *page = NULL;
+
+		ret = get_user_pages(tmp_addr, 1, FOLL_WRITE | FOLL_FORCE,
+				     &page, NULL);
+
+		if (ret <= 0) {
+			up_read(&current->mm->mmap_sem);
+			return ret;
+		}
+
+		kern_page_addr = kmap(page);
+
+		bytes = len;
+		offset = tmp_addr & (PAGE_SIZE - 1);
+
+		/* Is end_ul in this page? */
+		if (bytes > (PAGE_SIZE - offset)) {
+			bytes = PAGE_SIZE - offset;
+			last = NULL;
+		} else {
+			last = (unsigned long *)(kern_page_addr + offset + bytes) - 1;
+		}
+
+		/* Is start_ul in this page? */
+		if (tmp_addr == start_ul_addr)
+			first = (unsigned long *)(kern_page_addr + offset);
+		else
+			first = NULL;
+
+		if (nr_ul == 1) {
+			mask = GENMASK(j, i);
+
+			if (set)
+				*first |= mask;
+			else
+				*first &= ~mask;
+		} else {
+			if (first) {
+				mask = GENMASK(BITS_PER_LONG - 1, i);
+
+				if (set)
+					*first |= mask;
+				else
+					*first &= ~mask;
+			}
+
+			if (last) {
+				mask = GENMASK(j, 0);
+
+				if (set)
+					*last |= mask;
+				else
+					*last &= ~mask;
+			}
+
+			if (nr_ul > 2) {
+				void *p = kern_page_addr + offset;
+				int cnt = bytes;
+
+				if (first) {
+					p += sizeof(*first);
+					cnt -= sizeof(*first);
+				}
+
+				if (last)
+					cnt -= sizeof(*last);
+
+				if (set)
+					memset(p, 0xff, cnt);
+				else
+					memset(p, 0, cnt);
+			}
+		}
+
+		set_page_dirty_lock(page);
+		kunmap(page);
+		put_page(page);
+
+		len -= bytes;
+		tmp_addr += bytes;
+	}
+	up_read(&current->mm->mmap_sem);
+	return 0;
+}
+
+int cet_mark_legacy_code(unsigned long addr, unsigned long size, unsigned long set)
+{
+	int r;
+
+	if (!current->thread.cet.ibt_enabled)
+		return -EINVAL;
+
+	if ((addr >= IBT_BITMAP_ADDR) || (addr + size > IBT_BITMAP_ADDR))
+		return -EINVAL;
+
+	if (!current->thread.cet.ibt_bitmap_used) {
+		r = alloc_bitmap();
+		if (r)
+			return r;
+	}
+
+	return set_bits(addr / PAGE_SIZE, (addr + size - 1) / PAGE_SIZE, set);
+}
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index 09d8c4ea935c..eec5baf8b0da 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -57,6 +57,18 @@ static int handle_alloc_shstk(unsigned long arg2)
 	return 0;
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
@@ -83,6 +95,9 @@ int prctl_cet(int option, unsigned long arg2)
 	case ARCH_X86_CET_ALLOC_SHSTK:
 		return handle_alloc_shstk(arg2);
 
+	case ARCH_X86_CET_MARK_LEGACY_CODE:
+		return handle_mark_legacy_code(arg2);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index be93a73b5152..75076f727be0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3290,6 +3290,12 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
+
+	if (is_zero_pfn(pte_pfn(entry))) {
+		entry = pte_mkspecial(entry);
+		goto alloc_set_pte_out;
+	}
+
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
@@ -3302,6 +3308,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
 	}
+
+alloc_set_pte_out:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
 	/* no need to invalidate: a not-present page won't be cached */
-- 
2.17.1

