Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284861A2864
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 20:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgDHSSm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 14:18:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:9409 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbgDHSSm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 14:18:42 -0400
IronPort-SDR: iBzdk4uT5hwrJAJNXwA3SKDmB6fhcVoiV9G4OKur+zJNuYnocK8Ps1WpH4RFS3fN3NtFRwg9U6
 +vIvCd4uBFsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 11:18:40 -0700
IronPort-SDR: CNm41iviOJIvAgGIZX8BJww1bpJ5otfTDnIih7sOZvyjmkptybo793Ymrk15h0DnpBroWhaorW
 ju876jl99enA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="269829512"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2020 11:18:40 -0700
Message-ID: <231585ae895a083b0d65be766c6e2e9c44e933da.camel@intel.com>
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
Date:   Wed, 08 Apr 2020 11:18:40 -0700
In-Reply-To: <e432d102-7f69-7ba3-6146-c0165eef87e1@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-15-yu-cheng.yu@intel.com>
         <4902a6ee-cb0f-2700-1f6d-9d756593183c@intel.com>
         <444d97c4a4f70ccbb12da5e8f7ff498b37a9f60d.camel@intel.com>
         <e432d102-7f69-7ba3-6146-c0165eef87e1@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-04-07 at 15:21 -0700, Dave Hansen wrote:
> On 4/7/20 11:14 AM, Yu-cheng Yu wrote:
> > On Wed, 2020-02-26 at 16:08 -0800, Dave Hansen wrote:
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 45442d9a4f52..6daa28614327 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -772,7 +772,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > >  	 * If it's a COW mapping, write protect it both
> > > >  	 * in the parent and the child
> > > >  	 */
> > > > -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> > > > +	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
> > > > +	    arch_copy_pte_mapping(vm_flags)) {
> > > >  		ptep_set_wrprotect(src_mm, addr, src_pte);
> > > >  		pte = pte_wrprotect(pte);
> > > >  	}
> > > 
> > > You have to modify this because pte_write()==0 for shadow stack PTEs, right?
> > > 
> > > Aren't shadow stack ptes *logically* writable, even if they don't have
> > > the write bit set?  What would happen if we made pte_write()==1 for them?
> > 
> > Here the vm_flags needs to have VM_MAYWRITE, and the PTE needs to have
> > _PAGE_WRITE.  A shadow stack does not have either.
> 
> I literally mean taking pte_write(), and doing something l
> 
> static inline int pte_write(pte_t pte)
> {
> 	if (pte_present(pte) && pte_is_shadow_stack(pte))
> 		return 1;
> 
>         return pte_flags(pte) & _PAGE_RW;
> }
> 
> Then if is_cow_mapping() returns true for shadow stack VMAs, the above
> code doesn't need to change.

One benefit of this change is can_follow_write_pte() does not need any changes. 
A shadow stack PTE not in copy-on-write status is pte_write().

However, there are places that use pte_write() to determine if the PTE can be
made _PAGE_RW.  One such case is in change_pte_range(), where

	preserve_write = prot_numa && pte_write(oldpte);

and later,

	if (preserve_write)
		ptent = pte_mk_savedwrite(ptent);

Currently, there are other checks and shadow stack PTEs won't become _PAGE_RW. 
I am wondering if this can be overlooked later when the code is modified.

Another potential issue is, because pte_write()==1, a shadow stack PTE is made a
write migration entry, and can later accidentally become _PAGE_RW.  I think the
page fault handler would catch that, but still call it out in case I miss
anything.

Yu-cheng

