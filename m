Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE071A1363
	for <lists+linux-arch@lfdr.de>; Tue,  7 Apr 2020 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDGSO7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Apr 2020 14:14:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:7315 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDGSO7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Apr 2020 14:14:59 -0400
IronPort-SDR: sWPo7ahmYzt2gzCFCyAnVLINzSO06zNZ5b2uNofdOn87uTqIp2gexTYA3840XSZ1G7MqNYIvlE
 VoLEQeMuVftw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:14:58 -0700
IronPort-SDR: kJCrsPjoVYdbrOIa/DsHhlgy3v2nC4JN+UUwMGWfglVpv1BJLsoVZYjqnzPZ63YyNHofXQ22Jn
 Cr26BsaSkbgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="451316171"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 11:14:58 -0700
Message-ID: <444d97c4a4f70ccbb12da5e8f7ff498b37a9f60d.camel@intel.com>
Subject: Re: [RFC PATCH v9 14/27] mm: Handle Shadow Stack page fault
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Date:   Tue, 07 Apr 2020 11:14:58 -0700
In-Reply-To: <4902a6ee-cb0f-2700-1f6d-9d756593183c@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-15-yu-cheng.yu@intel.com>
         <4902a6ee-cb0f-2700-1f6d-9d756593183c@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-02-26 at 16:08 -0800, Dave Hansen wrote:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 45442d9a4f52..6daa28614327 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -772,7 +772,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  	 * If it's a COW mapping, write protect it both
> >  	 * in the parent and the child
> >  	 */
> > -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> > +	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
> > +	    arch_copy_pte_mapping(vm_flags)) {
> >  		ptep_set_wrprotect(src_mm, addr, src_pte);
> >  		pte = pte_wrprotect(pte);
> >  	}
> 
> You have to modify this because pte_write()==0 for shadow stack PTEs, right?
> 
> Aren't shadow stack ptes *logically* writable, even if they don't have
> the write bit set?  What would happen if we made pte_write()==1 for them?

Here the vm_flags needs to have VM_MAYWRITE, and the PTE needs to have
_PAGE_WRITE.  A shadow stack does not have either.

To fix checking vm_flags, what about adding a "arch_is_cow_mappping()" to the
generic is_cow_mapping()?

For the PTE, the check actually tries to determine if the PTE is not already
being copy-on-write, which is:

	(!_PAGE_RW && !_PAGE_DIRTY_HW)

So what about making it pte_cow()?

	/*
	 * The PTE is in copy-on-write status.
	 */
	static inline int pte_cow(pte_t pte)
	{
		return !(pte_flags(pte) & (_PAGE_WRITE | _PAGE_DIRTY_HW));
	}
> 
> > @@ -2417,6 +2418,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
> >  	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
> >  	entry = pte_mkyoung(vmf->orig_pte);
> >  	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> > +	entry = pte_set_vma_features(entry, vma);
> >  	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
> >  		update_mmu_cache(vma, vmf->address, vmf->pte);
> >  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > @@ -2504,6 +2506,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
> >  		entry = mk_pte(new_page, vma->vm_page_prot);
> >  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> > +		entry = pte_set_vma_features(entry, vma);
> >  		/*
> >  		 * Clear the pte entry and flush it first, before updating the
> >  		 * pte with the new entry. This will avoid a race condition
> > @@ -3023,6 +3026,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  	pte = mk_pte(page, vma->vm_page_prot);
> >  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
> >  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> > +		pte = pte_set_vma_features(pte, vma);
> >  		vmf->flags &= ~FAULT_FLAG_WRITE;
> >  		ret |= VM_FAULT_WRITE;
> >  		exclusive = RMAP_EXCLUSIVE;
> > @@ -3165,6 +3169,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  	entry = mk_pte(page, vma->vm_page_prot);
> >  	if (vma->vm_flags & VM_WRITE)
> >  		entry = pte_mkwrite(pte_mkdirty(entry));
> > +	entry = pte_set_vma_features(entry, vma);
> >  
> >  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> >  			&vmf->ptl);
> > 
> 
> These seem wrong, or at best inconsistent with what's already done.
> 
> We don't need anything like pte_set_vma_features() today because we have
> vma->vm_page_prot.  We could easily have done what you suggest here for
> things like protection keys: ignore the pkey PTE bits until we create
> the final PTE then shove them in there.
> 
> What are the bit patterns of the shadow stack bits that come out of
> these sites?  Can they be represented in ->vm_page_prot?

Yes, we can put _PAGE_DIRTY_HW in vm_page_prot.  Also set the bit in
ptep_set_access_flags() for shadow stack PTEs.

