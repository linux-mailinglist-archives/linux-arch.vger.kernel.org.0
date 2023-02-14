Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA966958D8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 07:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBNGKO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 01:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBNGKN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 01:10:13 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465556A5F
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 22:10:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id ct17so3913830pfb.12
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 22:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NG4gcbUUK30ZHhhVbfm4gzBvWsoUmaEF9T4G8HFC5DU=;
        b=imc+WDA64o/oCZFfk+tk7K24NCVK59euUCIFuRoHhcwxXrhR58u+VydiYPBt1jdoh9
         xxrvRYiFQdB8N2yDX7rHkHANnRRm7US53h7EUC9hRO7lo6NFDLRuvPuAlVIhTQujpsUL
         IyQegsZbYlKPSQ/3ou44CTHTppHMiqCF5SPPOJ7SKpnzHt8cai6tQiwEj3fH4PPetk2E
         Kf3fskCHTb7bOfDHQsne4YBol5eN0j6zYx/9QcD4hmoWAtmhyZBZIpF4M2GhnPPsVN9p
         QbK9CDDCh9V3V9jyIpCl/n+053EEAvLW5DP8VdA9eoa+gkdE5WLOXLTKz1m2B3NFvj04
         clCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG4gcbUUK30ZHhhVbfm4gzBvWsoUmaEF9T4G8HFC5DU=;
        b=pb20/1qCH7uoevMNxi1VYFyDsdrMoTc1GcTxWW+O9GR9B4w8PT3Up+scXZMA+6BQOE
         k2fXW9JP2YY4ccT0jlgWjErhW74dyVPVQKSCzwAwFWBJAFADmjl06IAje2aAMrVdfHFO
         L1s+SBAVgXBzjc+7hDKwKE/lw3n0hZmDdiBwIa4aXlkfoZ4SpQzFyEBdTd8aZEu5IXjz
         RdTHWLsi5jGIK+jPEFqC9XTrAw4BAstYm80bBtH0uHKo3UcM3rzEQFJncx8Jl/vONTFl
         l/SrIZNIEc3tmQcI/HjrNRVpSKLgTrRsxYaZZOggRi+QDppgUUBOisnekGoOAc/rAT14
         1cLA==
X-Gm-Message-State: AO0yUKW6d1EP8skGyK4MhOLvr4U5BbvWuT1ao53zZ8nX3Ebz21o8DY5I
        MNFVwpEYXlqLdw0v6f3Nfnya9A==
X-Google-Smtp-Source: AK7set8EpHinXKztvT8UlqHA6mo7YSo/ZczyCzuoRhPTml/zlOTu5lm33Qc63djl+IVA2FPiFzFkpA==
X-Received: by 2002:a62:1b47:0:b0:5a8:b1bc:4ac4 with SMTP id b68-20020a621b47000000b005a8b1bc4ac4mr1173950pfb.4.1676355010515;
        Mon, 13 Feb 2023 22:10:10 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0058e24050648sm9222236pfn.12.2023.02.13.22.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:10:09 -0800 (PST)
Date:   Mon, 13 Feb 2023 22:10:07 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <20230214061007.GC4016181@debug.ba.rivosinc.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-20-rick.p.edgecombe@intel.com>
 <20230214000947.GB4016181@debug.ba.rivosinc.com>
 <1dd1c61c69739fde6db445df79ebbbbec0efe8cd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1dd1c61c69739fde6db445df79ebbbbec0efe8cd.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 14, 2023 at 01:07:24AM +0000, Edgecombe, Rick P wrote:
>On Mon, 2023-02-13 at 16:09 -0800, Deepak Gupta wrote:
>> Since I've a general question on outcome of discussion of how to
>> handle
>> `pte_mkwrite`, so I am top posting.
>>
>> I have posted patches yesterday targeting riscv zisslpcfi extension.
>>
>https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
>>
>> Since there're similarities in extension(s), patches have similarity
>> too.
>> One of the similarity was updating `maybe_mkwrite`. I was asked (by
>> dhildenb
>> on my patch #11) to look at x86 approach on how to approach this so
>> that
>> core-mm approach fits multiple architectures along with the need to
>> update `pte_mkwrite` to consume vma flags.
>> In x86 CET patch series, I see that locations where `pte_mkwrite` is
>> invoked are updated to check for shadow stack vma and not necessarily
>> `pte_mkwrite` itself is updated to consume vma flags. Let me know if
>> my
>> understanding is correct and that's the current direction (to update
>> call sites for vma check where `pte_mkwrite` is invoked)
>>
>> Being said that as I've mentioned in my patch series that there're
>> similarities between x86, arm and now riscv for implementing shadow
>> stack
>> and indirect branch tracking, overall it'll be a good thing if we can
>> collaborate and come up with common bits.
>
>Oh interesting. I've made the changes to have pte_mkwrite() take a VMA.
>It seems to work pretty well with the core MM code, but I'm letting 0-
>day chew on it for a bit because it touched so many arch's. I'll
>include you when I send it out, hopefully later this week.

Thanks.
>
>From just a quick look, I see some design aspects that have been
>problematic on the x86 implementation.
>
>There was something like PROT_SHADOW_STACK before, but there were two
>problems:
>1. Writable windows while provisioning restore tokens (maybe this is
>just an x86 thing)
>2. Adding guard pages when a shadow stack was mprotect()ed to change it
>from writable to shadow stack. Again this might be an x86 need, since
>it needed to have it writable to add a restore token, and the guard
>pages help with security.

I've not seen your earlier patch but I am assuming when you say window you
mean that shadow stack was open to regular stores (or I may be missing
something here)

I am wondering if mapping it as shadow stack (instead of having temporary
writeable mapping) and using `wruss` was an option to put the token or
you wanted to avoid it?

And yes on riscv, architecture itself doesn't define token or its format.
Since it's RISC, software can define the token format and thus can use
either `sspush` or `ssamoswap` to put a token on `shadow stack` virtual
memory.

>
>So instead this series creates a map_shadow_stack syscall that maps a
>shadow stack and writes the token from the kernel side. Then mprotect()
>is prevented from making shadow stack's conventionally writable.
>
>another difference is enabling shadow stack based on elf header bits
>instead of the arch_prctl()s. See the history and reasoning here
>(section "Switch Enabling Interface"):
>
>https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
>
>Not sure if those two issues would be problems on riscv or not.

Apart from mapping and window issue that you mentioned, I couldn't
understand on why elf header bit is an issue only in this case for x86
shadow stack and not an issue for let's say aarch64. I can see that
aarch64 pretty much uses elf header bit for BTI. Eventually indirect
branch tracking also needs to be enabled which is analogous to BTI.

BTW eventually riscv binaries plan to use `.riscv.attributes` section
in riscv elf binary instead of `.gnu.note.property`. So I am hoping that
part will go into arch specific code of elf parsing for riscv and will be
contained.

>
>For sharing the prctl() interface. The other thing is that x86 also has
>this "wrss" instruction that can be enabled with shadow stack. The
>current arch_prctl() interface supports both. I'm thinking it's
>probably a pretty arch-specific thing.

yes ability to perform writes on shadow stack absolutely are prevented on
x86. So enabling that should be a arch specific prctl.

>
>ABI-wise, are you planning to automatically allocate shadow stacks for
>new tasks? If the ABI is completely different it might be best to not
>share user interfaces. But also, I wonder why is it different.

Yes as of now planning both:
- allocate shadow stack for new task based on elf header
- task can create them using `prctls` (from glibc)

And yes `fork` will get the all cfi properties (shdow stack and branch tracking)
from parent.
>
>>
>>
>> Rest inline.
>>
>>
>> On Thu, Jan 19, 2023 at 01:22:57PM -0800, Rick Edgecombe wrote:
>> > From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> >
>> > The x86 Control-flow Enforcement Technology (CET) feature includes
>> > a new
>> > type of memory called shadow stack. This shadow stack memory has
>> > some
>> > unusual properties, which requires some core mm changes to function
>> > properly.
>> >
>> > With the introduction of shadow stack memory there are two ways a
>> > pte can
>> > be writable: regular writable memory and shadow stack memory.
>> >
>> > In past patches, maybe_mkwrite() has been updated to apply
>> > pte_mkwrite()
>> > or pte_mkwrite_shstk() depending on the VMA flag. This covers most
>> > cases
>> > where a PTE is made writable. However, there are places where
>> > pte_mkwrite()
>> > is called directly and the logic should now also create a shadow
>> > stack PTE
>> > in the case of a shadow stack VMA.
>> >
>> > - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE
>> >  directly and call pte_mkwrite(). Teach it about
>> > pte_mkwrite_shstk()
>> >
>> > - When userfaultfd is creating a PTE after userspace handles the
>> > fault
>> >  it calls pte_mkwrite() directly. Teach it about
>> > pte_mkwrite_shstk()
>> >
>> > To make the code cleaner, introduce is_shstk_write() which
>> > simplifies
>> > checking for VM_WRITE | VM_SHADOW_STACK together.
>> >
>> > In other cases where pte_mkwrite() is called directly, the VMA will
>> > not
>> > be VM_SHADOW_STACK, and so shadow stack memory should not be
>> > created.
>> > - In the case of pte_savedwrite(), shadow stack VMA's are excluded.
>> > - In the case of the "dirty_accountable" optimization in
>> > mprotect(),
>> >   shadow stack VMA's won't be VM_SHARED, so it is not necessary.
>> >
>> > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> > Tested-by: John Allen <john.allen@amd.com>
>> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> > Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > ---
>> >
>> > v5:
>> > - Fix typo in commit log
>> >
>> > v3:
>> > - Restore do_anonymous_page() that accidetally moved commits
>> > (Kirill)
>> > - Open code maybe_mkwrite() cases from v2, so the behavior doesn't
>> > change
>> >   to mark that non-writable PTEs dirty. (Nadav)
>> >
>> > v2:
>> > - Updated commit log with comment's from Dave Hansen
>> > - Dave also suggested (I understood) to maybe tweak
>> > vm_get_page_prot()
>> >   to avoid having to call maybe_mkwrite(). After playing around
>> > with
>> >   this I opted to *not* do this. Shadow stack memory memory is
>> >   effectively writable, so having the default permissions be
>> > writable
>> >   ended up mapping the zero page as writable and other surprises.
>> > So
>> >   creating shadow stack memory needs to be done with manual logic
>> >   like pte_mkwrite().
>> > - Drop change in change_pte_range() because it couldn't actually
>> > trigger
>> >   for shadow stack VMAs.
>> > - Clarify reasoning for skipped cases of pte_mkwrite().
>> >
>> > Yu-cheng v25:
>> > - Apply same changes to do_huge_pmd_numa_page() as to
>> > do_numa_page().
>> >
>> > arch/x86/include/asm/pgtable.h |  3 +++
>> > arch/x86/mm/pgtable.c          |  6 ++++++
>> > include/linux/pgtable.h        |  7 +++++++
>> > mm/memory.c                    |  5 ++++-
>> > mm/migrate_device.c            |  4 +++-
>> > mm/userfaultfd.c               | 10 +++++++---
>> > 6 files changed, 30 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/arch/x86/include/asm/pgtable.h
>> > b/arch/x86/include/asm/pgtable.h
>> > index 45b1a8f058fe..87d3068734ec 100644
>> > --- a/arch/x86/include/asm/pgtable.h
>> > +++ b/arch/x86/include/asm/pgtable.h
>> > @@ -951,6 +951,9 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t
>> > *pgdp, pgd_t pgd)
>> > }
>> > #endif  /* CONFIG_PAGE_TABLE_ISOLATION */
>> >
>> > +#define is_shstk_write is_shstk_write
>> > +extern bool is_shstk_write(unsigned long vm_flags);
>> > +
>> > #endif	/* __ASSEMBLY__ */
>> >
>> >
>> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> > index e4f499eb0f29..d103945ba502 100644
>> > --- a/arch/x86/mm/pgtable.c
>> > +++ b/arch/x86/mm/pgtable.c
>> > @@ -880,3 +880,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long
>> > addr)
>> >
>> > #endif /* CONFIG_X86_64 */
>> > #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>> > +
>> > +bool is_shstk_write(unsigned long vm_flags)
>> > +{
>> > +	return (vm_flags & (VM_SHADOW_STACK | VM_WRITE)) ==
>> > +	       (VM_SHADOW_STACK | VM_WRITE);
>> > +}
>>
>> Can we call this function something along the lines
>> `is_shadow_stack_vma`?
>> Reason being, we're actually checking for vma property here.
>>
>> Also can we move this into common code? Common code can then further
>> call
>> `arch_is_shadow_stack_vma`. Respective arch can implement their own
>> shadow
>> stack encoding. I see that x86 is using one of the arch bit. Current
>> riscv
>> implementation uses presence of only `VM_WRITE` as shadow stack
>> encoding.
>
>In the next version I've successfully moved all of the shadow stack
>bits out of core MM. It doesn't need is_shstk_write() after the
>pte_mkwrite() change, and changing this other one:
>
>https://lore.kernel.org/lkml/20230119212317.8324-26-rick.p.edgecombe@intel.com/
>For that I added an arch_check_zapped_pte() which an arch can use to
>add warnings.
>
>So I wonder if riscv won't need anything either?
>
>>
>> Please see patch #11 and #12 in the series I posted (URL at the top
>> of
>> this e-mail).
>>
>>
>> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> > index 14a820a45a37..49ce1f055242 100644
>> > --- a/include/linux/pgtable.h
>> > +++ b/include/linux/pgtable.h
>> > @@ -1578,6 +1578,13 @@ static inline bool
>> > arch_has_pfn_modify_check(void)
>> > }
>> > #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
>> >
>> > +#ifndef is_shstk_write
>> > +static inline bool is_shstk_write(unsigned long vm_flags)
>> > +{
>> > +	return false;
>> > +}
>> > +#endif
>> > +
>> > /*
>> >  * Architecture PAGE_KERNEL_* fallbacks
>> >  *
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index aad226daf41b..5e5107232a26 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -4088,7 +4088,10 @@ static vm_fault_t do_anonymous_page(struct
>> > vm_fault *vmf)
>> >
>> > 	entry = mk_pte(page, vma->vm_page_prot);
>> > 	entry = pte_sw_mkyoung(entry);
>> > -	if (vma->vm_flags & VM_WRITE)
>> > +
>> > +	if (is_shstk_write(vma->vm_flags))
>> > +		entry = pte_mkwrite_shstk(pte_mkdirty(entry));
>> > +	else if (vma->vm_flags & VM_WRITE)
>> > 		entry = pte_mkwrite(pte_mkdirty(entry));
>> >
>> > 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf-
>> > >address,
>> > diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> > index 721b2365dbca..53d417683e01 100644
>> > --- a/mm/migrate_device.c
>> > +++ b/mm/migrate_device.c
>> > @@ -645,7 +645,9 @@ static void migrate_vma_insert_page(struct
>> > migrate_vma *migrate,
>> > 			goto abort;
>> > 		}
>> > 		entry = mk_pte(page, vma->vm_page_prot);
>> > -		if (vma->vm_flags & VM_WRITE)
>> > +		if (is_shstk_write(vma->vm_flags))
>> > +			entry = pte_mkwrite_shstk(pte_mkdirty(entry));
>> > +		else if (vma->vm_flags & VM_WRITE)
>> > 			entry = pte_mkwrite(pte_mkdirty(entry));
>> > 	}
>> >
>> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> > index 0499907b6f1a..832f0250ca61 100644
>> > --- a/mm/userfaultfd.c
>> > +++ b/mm/userfaultfd.c
>> > @@ -63,6 +63,7 @@ int mfill_atomic_install_pte(struct mm_struct
>> > *dst_mm, pmd_t *dst_pmd,
>> > 	int ret;
>> > 	pte_t _dst_pte, *dst_pte;
>> > 	bool writable = dst_vma->vm_flags & VM_WRITE;
>> > +	bool shstk = dst_vma->vm_flags & VM_SHADOW_STACK;
>> > 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
>> > 	bool page_in_cache = page_mapping(page);
>> > 	spinlock_t *ptl;
>> > @@ -84,9 +85,12 @@ int mfill_atomic_install_pte(struct mm_struct
>> > *dst_mm, pmd_t *dst_pmd,
>> > 		writable = false;
>> > 	}
>> >
>> > -	if (writable)
>> > -		_dst_pte = pte_mkwrite(_dst_pte);
>> > -	else
>> > +	if (writable) {
>> > +		if (shstk)
>> > +			_dst_pte = pte_mkwrite_shstk(_dst_pte);
>> > +		else
>> > +			_dst_pte = pte_mkwrite(_dst_pte);
>> > +	} else
>> > 		/*
>> > 		 * We need this to make sure write bit removed; as
>> > mk_pte()
>> > 		 * could return a pte with write bit set.
>> > --
>> > 2.17.1
>> >
