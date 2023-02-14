Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0D695536
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 01:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBNAJy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 19:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNAJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 19:09:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A0121
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 16:09:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mg23so6955848pjb.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wafRvFtpoaUPeKy4BH9nydSNV62pORjUA+IPmwJBn+I=;
        b=pQbN+hQ5P2HnOheTT+gYeCeyltivCsBRliCKe9K1C3GNPGDHI5h6dp/QlFRrnehCN6
         Tdk3QhsBk9F4N04SlocSX28nAejEB/9gSbJSRDAZcbnNKSHK0FVahXIJmsK+OuTCkyno
         swq2CeZXFUvGzOxygjkaMVEJRi0SAlssyhRhQ25BhYC+jK2bzHdVBo6MWGAFZ1ChP0ZG
         hwFwvg3+lBPPmlICv+xW6tFJTxeb4rTi4SHa8nHHvISaI07vVIWinTfd6LjmKXqf7aW6
         h8U5xHT0i5eJOpsXcsOpiYUDWjOmPNOknbuNdtQfLEoyd3lJW4/6McCYOfg9HGuNMJTl
         FiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wafRvFtpoaUPeKy4BH9nydSNV62pORjUA+IPmwJBn+I=;
        b=4lXG56rY/81jzlS1xfzgL3ggxUCNnMBltiMbLKoqmr93GSnTv3bZxqYcNvrZVjnCNv
         83xT2UjCEyievd2TZLjm637v6PRjP0NQ4vAQ3UzQcZxudnex9Q/9F8OmdYGGYSdHwr1j
         VxRZpnjWmr1+bAo2+mtVzJWVu/L6zFj/Km5kWlWTF5tXUcM+GOre0rvsHGhj4nXrWuK6
         OStR1hiz7HmGjUjZoNCFdK8Rb4+qKzshM6pZuQs409uQ57xjP/zGYOIbv/JiTV193GCj
         W+U3z+2jllmlpm3PgZKn6c3Yt1RmiXHo5Bxn/rftTU1uj5v7T8SW5MdrAa4gVWt9Rtsb
         jaTA==
X-Gm-Message-State: AO0yUKVAG8/nJ0NFaryKAVHZ0yjolc0v8cSqoEq3xyhxBeakGKj2m9GV
        dp8VreNVAafkY1MbCNwAZRR2Bw==
X-Google-Smtp-Source: AK7set9HjlAaKSWUg5OUHj0WQmlr8FQa9bAoHK9nkuOdv8y1POrZgcGxG7My2GrW4SaF7tGeKgFNXQ==
X-Received: by 2002:a17:903:230a:b0:196:6162:1a76 with SMTP id d10-20020a170903230a00b0019661621a76mr903634plh.0.1676333390417;
        Mon, 13 Feb 2023 16:09:50 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id iw6-20020a170903044600b0019ab6beea1esm81093plb.87.2023.02.13.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 16:09:49 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:09:47 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <20230214000947.GB4016181@debug.ba.rivosinc.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-20-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-20-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since I've a general question on outcome of discussion of how to handle
`pte_mkwrite`, so I am top posting.

I have posted patches yesterday targeting riscv zisslpcfi extension.
https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/

Since there're similarities in extension(s), patches have similarity too.
One of the similarity was updating `maybe_mkwrite`. I was asked (by dhildenb
on my patch #11) to look at x86 approach on how to approach this so that
core-mm approach fits multiple architectures along with the need to
update `pte_mkwrite` to consume vma flags.
In x86 CET patch series, I see that locations where `pte_mkwrite` is
invoked are updated to check for shadow stack vma and not necessarily
`pte_mkwrite` itself is updated to consume vma flags. Let me know if my
understanding is correct and that's the current direction (to update
call sites for vma check where `pte_mkwrite` is invoked)

Being said that as I've mentioned in my patch series that there're
similarities between x86, arm and now riscv for implementing shadow stack
and indirect branch tracking, overall it'll be a good thing if we can
collaborate and come up with common bits.


Rest inline.


On Thu, Jan 19, 2023 at 01:22:57PM -0800, Rick Edgecombe wrote:
>From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>
>The x86 Control-flow Enforcement Technology (CET) feature includes a new
>type of memory called shadow stack. This shadow stack memory has some
>unusual properties, which requires some core mm changes to function
>properly.
>
>With the introduction of shadow stack memory there are two ways a pte can
>be writable: regular writable memory and shadow stack memory.
>
>In past patches, maybe_mkwrite() has been updated to apply pte_mkwrite()
>or pte_mkwrite_shstk() depending on the VMA flag. This covers most cases
>where a PTE is made writable. However, there are places where pte_mkwrite()
>is called directly and the logic should now also create a shadow stack PTE
>in the case of a shadow stack VMA.
>
>- do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE
>  directly and call pte_mkwrite(). Teach it about pte_mkwrite_shstk()
>
>- When userfaultfd is creating a PTE after userspace handles the fault
>  it calls pte_mkwrite() directly. Teach it about pte_mkwrite_shstk()
>
>To make the code cleaner, introduce is_shstk_write() which simplifies
>checking for VM_WRITE | VM_SHADOW_STACK together.
>
>In other cases where pte_mkwrite() is called directly, the VMA will not
>be VM_SHADOW_STACK, and so shadow stack memory should not be created.
> - In the case of pte_savedwrite(), shadow stack VMA's are excluded.
> - In the case of the "dirty_accountable" optimization in mprotect(),
>   shadow stack VMA's won't be VM_SHARED, so it is not necessary.
>
>Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>Tested-by: John Allen <john.allen@amd.com>
>Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Cc: Kees Cook <keescook@chromium.org>
>---
>
>v5:
> - Fix typo in commit log
>
>v3:
> - Restore do_anonymous_page() that accidetally moved commits (Kirill)
> - Open code maybe_mkwrite() cases from v2, so the behavior doesn't change
>   to mark that non-writable PTEs dirty. (Nadav)
>
>v2:
> - Updated commit log with comment's from Dave Hansen
> - Dave also suggested (I understood) to maybe tweak vm_get_page_prot()
>   to avoid having to call maybe_mkwrite(). After playing around with
>   this I opted to *not* do this. Shadow stack memory memory is
>   effectively writable, so having the default permissions be writable
>   ended up mapping the zero page as writable and other surprises. So
>   creating shadow stack memory needs to be done with manual logic
>   like pte_mkwrite().
> - Drop change in change_pte_range() because it couldn't actually trigger
>   for shadow stack VMAs.
> - Clarify reasoning for skipped cases of pte_mkwrite().
>
>Yu-cheng v25:
> - Apply same changes to do_huge_pmd_numa_page() as to do_numa_page().
>
> arch/x86/include/asm/pgtable.h |  3 +++
> arch/x86/mm/pgtable.c          |  6 ++++++
> include/linux/pgtable.h        |  7 +++++++
> mm/memory.c                    |  5 ++++-
> mm/migrate_device.c            |  4 +++-
> mm/userfaultfd.c               | 10 +++++++---
> 6 files changed, 30 insertions(+), 5 deletions(-)
>
>diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>index 45b1a8f058fe..87d3068734ec 100644
>--- a/arch/x86/include/asm/pgtable.h
>+++ b/arch/x86/include/asm/pgtable.h
>@@ -951,6 +951,9 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
> }
> #endif  /* CONFIG_PAGE_TABLE_ISOLATION */
>
>+#define is_shstk_write is_shstk_write
>+extern bool is_shstk_write(unsigned long vm_flags);
>+
> #endif	/* __ASSEMBLY__ */
>
>
>diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>index e4f499eb0f29..d103945ba502 100644
>--- a/arch/x86/mm/pgtable.c
>+++ b/arch/x86/mm/pgtable.c
>@@ -880,3 +880,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>
> #endif /* CONFIG_X86_64 */
> #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>+
>+bool is_shstk_write(unsigned long vm_flags)
>+{
>+	return (vm_flags & (VM_SHADOW_STACK | VM_WRITE)) ==
>+	       (VM_SHADOW_STACK | VM_WRITE);
>+}

Can we call this function something along the lines `is_shadow_stack_vma`?
Reason being, we're actually checking for vma property here.

Also can we move this into common code? Common code can then further call  
`arch_is_shadow_stack_vma`. Respective arch can implement their own shadow
stack encoding. I see that x86 is using one of the arch bit. Current riscv
implementation uses presence of only `VM_WRITE` as shadow stack encoding.

Please see patch #11 and #12 in the series I posted (URL at the top of
this e-mail).


>diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>index 14a820a45a37..49ce1f055242 100644
>--- a/include/linux/pgtable.h
>+++ b/include/linux/pgtable.h
>@@ -1578,6 +1578,13 @@ static inline bool arch_has_pfn_modify_check(void)
> }
> #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
>
>+#ifndef is_shstk_write
>+static inline bool is_shstk_write(unsigned long vm_flags)
>+{
>+	return false;
>+}
>+#endif
>+
> /*
>  * Architecture PAGE_KERNEL_* fallbacks
>  *
>diff --git a/mm/memory.c b/mm/memory.c
>index aad226daf41b..5e5107232a26 100644
>--- a/mm/memory.c
>+++ b/mm/memory.c
>@@ -4088,7 +4088,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>
> 	entry = mk_pte(page, vma->vm_page_prot);
> 	entry = pte_sw_mkyoung(entry);
>-	if (vma->vm_flags & VM_WRITE)
>+
>+	if (is_shstk_write(vma->vm_flags))
>+		entry = pte_mkwrite_shstk(pte_mkdirty(entry));
>+	else if (vma->vm_flags & VM_WRITE)
> 		entry = pte_mkwrite(pte_mkdirty(entry));
>
> 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>index 721b2365dbca..53d417683e01 100644
>--- a/mm/migrate_device.c
>+++ b/mm/migrate_device.c
>@@ -645,7 +645,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
> 			goto abort;
> 		}
> 		entry = mk_pte(page, vma->vm_page_prot);
>-		if (vma->vm_flags & VM_WRITE)
>+		if (is_shstk_write(vma->vm_flags))
>+			entry = pte_mkwrite_shstk(pte_mkdirty(entry));
>+		else if (vma->vm_flags & VM_WRITE)
> 			entry = pte_mkwrite(pte_mkdirty(entry));
> 	}
>
>diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>index 0499907b6f1a..832f0250ca61 100644
>--- a/mm/userfaultfd.c
>+++ b/mm/userfaultfd.c
>@@ -63,6 +63,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> 	int ret;
> 	pte_t _dst_pte, *dst_pte;
> 	bool writable = dst_vma->vm_flags & VM_WRITE;
>+	bool shstk = dst_vma->vm_flags & VM_SHADOW_STACK;
> 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> 	bool page_in_cache = page_mapping(page);
> 	spinlock_t *ptl;
>@@ -84,9 +85,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> 		writable = false;
> 	}
>
>-	if (writable)
>-		_dst_pte = pte_mkwrite(_dst_pte);
>-	else
>+	if (writable) {
>+		if (shstk)
>+			_dst_pte = pte_mkwrite_shstk(_dst_pte);
>+		else
>+			_dst_pte = pte_mkwrite(_dst_pte);
>+	} else
> 		/*
> 		 * We need this to make sure write bit removed; as mk_pte()
> 		 * could return a pte with write bit set.
>-- 
>2.17.1
>
