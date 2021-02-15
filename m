Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1B31BFC9
	for <lists+linux-arch@lfdr.de>; Mon, 15 Feb 2021 17:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBOQwR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Feb 2021 11:52:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:28435 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhBOQuK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Feb 2021 11:50:10 -0500
IronPort-SDR: ivtVOqrPC8gPzaTHaN3JyqJ443xBcw0FbfM8hwkKlBI/yMGtXFaBY7DPq70b50MUx1ZP5LdrF/
 9CgJ4evlA2LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="179218670"
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="179218670"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 08:49:15 -0800
IronPort-SDR: qrnNDKcuiVv1NLGj4QSyRfIFTrNz7/dFpMkynYX/nWO0kmiebauSV2ScArn+9Pz1AwPGn7XHeo
 P83p4ANuFnSw==
X-IronPort-AV: E=Sophos;i="5.81,181,1610438400"; 
   d="scan'208";a="383439501"
Received: from gbravo-mobl.amr.corp.intel.com (HELO [10.212.239.42]) ([10.212.239.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 08:49:06 -0800
Subject: Re: [PATCH v20 08/25] x86/mm: Introduce _PAGE_COW
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-9-yu-cheng.yu@intel.com>
 <202102101137.E109C9FE6@keescook>
 <819b6d6a-64ea-d908-76ad-0a6366ed0d53@intel.com>
Message-ID: <66b7f5ef-2554-0b2d-13d3-a3f3467d968c@intel.com>
Date:   Mon, 15 Feb 2021 08:49:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <819b6d6a-64ea-d908-76ad-0a6366ed0d53@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/10/2021 12:28 PM, Yu, Yu-cheng wrote:
> On 2/10/2021 11:42 AM, Kees Cook wrote:
>> On Wed, Feb 10, 2021 at 09:56:46AM -0800, Yu-cheng Yu wrote:
>>> There is essentially no room left in the x86 hardware PTEs on some OSes
>>> (not Linux).  That left the hardware architects looking for a way to
>>> represent a new memory type (shadow stack) within the existing bits.
>>> They chose to repurpose a lightly-used state: Write=0, Dirty=1.
>>>
>>> The reason it's lightly used is that Dirty=1 is normally set by hardware
>>> and cannot normally be set by hardware on a Write=0 PTE.  Software must
>>> normally be involved to create one of these PTEs, so software can simply
>>> opt to not create them.
>>>
>>> In places where Linux normally creates Write=0, Dirty=1, it can use the
>>> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY.  In 
>>> other
>>> words, whenever Linux needs to create Write=0, Dirty=1, it instead 
>>> creates
>>> Write=0, Cow=1, except for shadow stack, which is Write=0, Dirty=1.  
>>> This
>>> clearly separates shadow stack from other data, and results in the
>>> following:
>>>
>>> (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
>>> (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
>>>      The user page is in a R/O VMA, and get_user_pages() needs a 
>>> writable
>>>      copy.  The page fault handler creates a copy of the page and sets
>>>      the new copy's PTE as Write=0 and Cow=1.
>>> (c) A shadow stack PTE: (Write=0, Dirty=1)
>>> (d) A shared shadow stack PTE: (Write=0, Cow=1)
>>>      When a shadow stack page is being shared among processes (this 
>>> happens
>>>      at fork()), its PTE is made Dirty=0, so the next shadow stack 
>>> access
>>>      causes a fault, and the page is duplicated and Dirty=1 is set 
>>> again.
>>>      This is the COW equivalent for shadow stack pages, even though it's
>>>      copy-on-access rather than copy-on-write.
>>> (e) A page where the processor observed a Write=1 PTE, started a 
>>> write, set
>>>      Dirty=1, but then observed a Write=0 PTE.  That's possible 
>>> today, but
>>>      will not happen on processors that support shadow stack.
>>>
>>> Define _PAGE_COW and update pte_*() helpers and apply the same 
>>> changes to
>>> pmd and pud.
>>
>> I still find this commit confusing mostly due to _PAGE_COW being 0
>> without CET enabled. Shouldn't this just get changed universally? Why
>> should this change depend on CET?
>>
> 
> For example, in...
> 
> static inline int pte_write(pte_t pte)
> {
>      if (cpu_feature_enabled(X86_FEATURE_SHSTK))
>          return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY);
>      else
>          return pte_flags(pte) & _PAGE_RW;
> }
> 
> There are four cases:
> 
> (a) RW=1, Dirty=1 -> writable
> (b) RW=1, Dirty=0 -> writable
> (c) RW=0, Dirty=0 -> not writable
> (d) RW=0, Dirty=1 -> shadow stack, or not-writable if !X86_FEATURE_SHSTK
> 
> Case (d) is ture only when shadow stack is enabled, otherwise it is not 
> writable.  With shadow stack feature, the usual dirty, copy-on-write PTE 
> becomes RW=0, Cow=1.
> 
> We can get this changed universally, but all usual dirty, copy-on-write 
> PTEs need the Dirty/Cow swapping, always.  Is that desirable?
> 

Instead of working on _PAGE_COW directly, create three helpers: 
pte_make_cow(), pte_clear_cow(), pte_shstk().  The decision of swapping 
_PAGE_DIRTY/_PAGE_COW is now in the helpers.  For example, 
pte_wrprotect() is now:

static inline pte_t pte_wrprotect(pte_t pte)
{
	pte = pte_clear_flags(pte, _PAGE_RW);

	if (pte_dirty(pte))
		pte = pte_make_cow(pte);
	return pte;
}

How is that?  The revise patch is the following.

Yu-cheng




diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..1a6c0784af0a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -121,11 +121,21 @@ extern pmdval_t early_pmd_flags;
   * The following only work if pte_present() is true.
   * Undefined behaviour if not..
   */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
  {
-	return pte_flags(pte) & _PAGE_DIRTY;
+	/*
+	 * A dirty PTE has Dirty=1 or Cow=1.
+	 */
+	return pte_flags(pte) & _PAGE_DIRTY_BITS;
  }

+static inline bool pte_shstk(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return false;
+
+	return (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
+}

  static inline u32 read_pkru(void)
  {
@@ -160,9 +170,20 @@ static inline int pte_young(pte_t pte)
  	return pte_flags(pte) & _PAGE_ACCESSED;
  }

-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
  {
-	return pmd_flags(pmd) & _PAGE_DIRTY;
+	/*
+	 * A dirty PMD has Dirty=1 or Cow=1.
+	 */
+	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
+}
+
+static inline bool pmd_shstk(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return false;
+
+	return (pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
  }

  static inline int pmd_young(pmd_t pmd)
@@ -170,9 +191,12 @@ static inline int pmd_young(pmd_t pmd)
  	return pmd_flags(pmd) & _PAGE_ACCESSED;
  }

-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
  {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	/*
+	 * A dirty PUD has Dirty=1 or Cow=1.
+	 */
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
  }

  static inline int pud_young(pud_t pud)
@@ -182,7 +206,7 @@ static inline int pud_young(pud_t pud)

  static inline int pte_write(pte_t pte)
  {
-	return pte_flags(pte) & _PAGE_RW;
+	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
  }

  static inline int pte_huge(pte_t pte)
@@ -314,6 +338,24 @@ static inline pte_t pte_clear_flags(pte_t pte, 
pteval_t clear)
  	return native_make_pte(v & ~clear);
  }

+static inline pte_t pte_make_cow(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pte;
+
+	pte = pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_set_flags(pte, _PAGE_COW);
+}
+
+static inline pte_t pte_clear_cow(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pte;
+
+	pte = pte_set_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_COW);
+}
+
  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
  static inline int pte_uffd_wp(pte_t pte)
  {
@@ -333,7 +375,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)

  static inline pte_t pte_mkclean(pte_t pte)
  {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
  }

  static inline pte_t pte_mkold(pte_t pte)
@@ -343,7 +385,16 @@ static inline pte_t pte_mkold(pte_t pte)

  static inline pte_t pte_wrprotect(pte_t pte)
  {
-	return pte_clear_flags(pte, _PAGE_RW);
+	pte = pte_clear_flags(pte, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pte_dirty(pte))
+		pte = pte_make_cow(pte);
+	return pte;
  }

  static inline pte_t pte_mkexec(pte_t pte)
@@ -353,7 +404,18 @@ static inline pte_t pte_mkexec(pte_t pte)

  static inline pte_t pte_mkdirty(pte_t pte)
  {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pteval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PTEs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
+		dirty = _PAGE_COW;
+
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return pte_clear_cow(pte);
  }

  static inline pte_t pte_mkyoung(pte_t pte)
@@ -363,7 +425,12 @@ static inline pte_t pte_mkyoung(pte_t pte)

  static inline pte_t pte_mkwrite(pte_t pte)
  {
-	return pte_set_flags(pte, _PAGE_RW);
+	pte = pte_set_flags(pte, _PAGE_RW);
+
+	if (pte_dirty(pte))
+		pte = pte_clear_cow(pte);
+
+	return pte;
  }

  static inline pte_t pte_mkhuge(pte_t pte)
@@ -410,6 +477,24 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, 
pmdval_t clear)
  	return native_make_pmd(v & ~clear);
  }

+static inline pmd_t pmd_make_cow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pmd;
+
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_COW);
+}
+
+static inline pmd_t pmd_clear_cow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pmd;
+
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_COW);
+}
+
  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
  static inline int pmd_uffd_wp(pmd_t pmd)
  {
@@ -434,17 +519,36 @@ static inline pmd_t pmd_mkold(pmd_t pmd)

  static inline pmd_t pmd_mkclean(pmd_t pmd)
  {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
  }

  static inline pmd_t pmd_wrprotect(pmd_t pmd)
  {
-	return pmd_clear_flags(pmd, _PAGE_RW);
+	pmd = pmd_clear_flags(pmd, _PAGE_RW);
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PMD (RW=0, Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pmd_dirty(pmd))
+		pmd = pmd_make_cow(pmd);
+	return pmd;
  }

  static inline pmd_t pmd_mkdirty(pmd_t pmd)
  {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pmdval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & 
_PAGE_RW))
+		dirty = _PAGE_COW;
+
+	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	return pmd_clear_cow(pmd);
  }

  static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -464,7 +568,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)

  static inline pmd_t pmd_mkwrite(pmd_t pmd)
  {
-	return pmd_set_flags(pmd, _PAGE_RW);
+	pmd = pmd_set_flags(pmd, _PAGE_RW);
+
+	if (pmd_dirty(pmd))
+		pmd = pmd_clear_cow(pmd);
+	return pmd;
  }

  static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
@@ -481,6 +589,24 @@ static inline pud_t pud_clear_flags(pud_t pud, 
pudval_t clear)
  	return native_make_pud(v & ~clear);
  }

+static inline pud_t pud_make_cow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pud;
+
+	pud = pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_set_flags(pud, _PAGE_COW);
+}
+
+static inline pud_t pud_clear_cow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pud;
+
+	pud = pud_set_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_COW);
+}
+
  static inline pud_t pud_mkold(pud_t pud)
  {
  	return pud_clear_flags(pud, _PAGE_ACCESSED);
@@ -488,17 +614,32 @@ static inline pud_t pud_mkold(pud_t pud)

  static inline pud_t pud_mkclean(pud_t pud)
  {
-	return pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
  }

  static inline pud_t pud_wrprotect(pud_t pud)
  {
-	return pud_clear_flags(pud, _PAGE_RW);
+	pud = pud_clear_flags(pud, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PUD (RW=0, Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pud_dirty(pud))
+		pud = pud_make_cow(pud);
+	return pud;
  }

  static inline pud_t pud_mkdirty(pud_t pud)
  {
-	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pudval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pud_flags(pud) & 
_PAGE_RW))
+		dirty = _PAGE_COW;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
  }

  static inline pud_t pud_mkdevmap(pud_t pud)
@@ -518,7 +659,11 @@ static inline pud_t pud_mkyoung(pud_t pud)

  static inline pud_t pud_mkwrite(pud_t pud)
  {
-	return pud_set_flags(pud, _PAGE_RW);
+	pud = pud_set_flags(pud, _PAGE_RW);
+
+	if (pud_dirty(pud))
+		pud = pud_clear_cow(pud);
+	return pud;
  }

  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
@@ -1131,7 +1276,7 @@ extern int pmdp_clear_flush_young(struct 
vm_area_struct *vma,
  #define pmd_write pmd_write
  static inline int pmd_write(pmd_t pmd)
  {
-	return pmd_flags(pmd) & _PAGE_RW;
+	return (pmd_flags(pmd) & _PAGE_RW) || pmd_shstk(pmd);
  }

  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
