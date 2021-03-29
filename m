Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCD34CDB5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhC2KLI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhC2KKo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 06:10:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6FBC061574
        for <linux-arch@vger.kernel.org>; Mon, 29 Mar 2021 03:10:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so7200854lfq.13
        for <linux-arch@vger.kernel.org>; Mon, 29 Mar 2021 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TrrPoo3NF06Hriy1kiCCzSGcqBJEQPrLMgSJHsg60T0=;
        b=MEEB4gQC+frgKiF9qxjZWukNl+J2hRwRFu7J1PqfnMfeey07tHMtQDPvdpfUrJMj+v
         ygJO68J8dLSogekKUyuyEXo8RQTJ807gbbBdBq6oagwJBdc2IRBWavSbj7y0TeaYGk7E
         1GMkHLPx64SGknP3wTP3iIwhW/hsV3/W7y4ZI2wuMVuSBy4bV9ff4rSSppPkrnAbmDgR
         DUn7cyCOUbkSRIfa4trfe9SwiqvhtJKOiqg6ST1RQmHRJJnJUUL32FPYbRR2YeR7KN3I
         R5SyHZOtuaxGBK7ZXgmwHbpEg33N9z5EquYbNO9sYVg5nO/6x0zL17e5dB0XQojSvKub
         IXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrrPoo3NF06Hriy1kiCCzSGcqBJEQPrLMgSJHsg60T0=;
        b=RzcJ+cp3+KIfan4FichLJQtsDhrCDeZOBdyGb07AjAvXjsrnwzplfoKBHaWrNmYpcN
         6fL4PEJBX/uhpXg//FrsPBGUYVZfFJZhpJWJbVDaTL5yJLTr/zvhKk5UcoqqE6o56hXK
         Gn7GXzxUjtWDItWb+kra/lJwX6L8PhmVoSff5A4gT32NyuzmXE2okTxYLWDl+F56Mttw
         8Ktt0tGBxQSM3LhCgYNE6tnsdUeMu4VBamCLulttTBSU3ZtN01ck53GXoacYOHPvA8h2
         dUHjDxIrdaVLaNOY26lkfAibcPi+dfTFOvRWORsccymI8oGujWFQB82F0x0nvRFpD3DY
         G+jw==
X-Gm-Message-State: AOAM5321Z9B/dxwZPdGRMZXfHYbtraqO/uNxnqH5/EcUISmhculADAXp
        8ewyJ5CKm4n5If74t95onS56UA==
X-Google-Smtp-Source: ABdhPJzFN60J7EkuzOGOBl18JQs7UDI+EF00tDUs2xAE6AjR6wmyHSPcLg0T1AveZfh8xHdfaQ/2vg==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr16097622lfd.496.1617012642015;
        Mon, 29 Mar 2021 03:10:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r66sm1776883lff.93.2021.03.29.03.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:10:41 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DB6C5101FC8; Mon, 29 Mar 2021 13:10:40 +0300 (+03)
Date:   Mon, 29 Mar 2021 13:10:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 18/28] mm/mmap: Add shadow stack pages to memory
 accounting
Message-ID: <20210329101040.sra6aqvgjbmy72bj@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-19-yu-cheng.yu@intel.com>
 <20210322105729.24rt4nwc3blipxsr@box>
 <4b926140-66ac-f538-df94-8213b8a2ab86@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b926140-66ac-f538-df94-8213b8a2ab86@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 26, 2021 at 08:46:30AM -0700, Yu, Yu-cheng wrote:
> On 3/22/2021 3:57 AM, Kirill A. Shutemov wrote:
> > On Tue, Mar 16, 2021 at 08:10:44AM -0700, Yu-cheng Yu wrote:
> > > Account shadow stack pages to stack memory.
> > > 
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >   arch/x86/mm/pgtable.c   |  7 +++++++
> > >   include/linux/pgtable.h | 11 +++++++++++
> > >   mm/mmap.c               |  5 +++++
> > >   3 files changed, 23 insertions(+)
> > > 
> > > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > > index 0f4fbf51a9fc..948d28c29964 100644
> > > --- a/arch/x86/mm/pgtable.c
> > > +++ b/arch/x86/mm/pgtable.c
> > > @@ -895,3 +895,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> > >   #endif /* CONFIG_X86_64 */
> > >   #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
> > > +
> > > +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
> > > +bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
> > > +{
> > > +	return (vm_flags & VM_SHSTK);
> > > +}
> > > +#endif
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index cbd98484c4f1..487c08df4365 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -1470,6 +1470,17 @@ static inline pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma
> > >   #endif /* CONFIG_ARCH_MAYBE_MKWRITE */
> > >   #endif /* CONFIG_MMU */
> > > +#ifdef CONFIG_MMU
> > > +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
> > > +bool arch_shadow_stack_mapping(vm_flags_t vm_flags);
> > > +#else
> > > +static inline bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif /* CONFIG_ARCH_HAS_SHADOW_STACK */
> > > +#endif /* CONFIG_MMU */
> > > +
> > >   /*
> > >    * Architecture PAGE_KERNEL_* fallbacks
> > >    *
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 3f287599a7a3..2ac67882ace2 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1718,6 +1718,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
> > >   	if (file && is_file_hugepages(file))
> > >   		return 0;
> > > +	if (arch_shadow_stack_mapping(vm_flags))
> > > +		return 1;
> > > +
> > 
> > What's wrong with testing (vm_flags & VM_SHSTK) here? VM_SHSTK is 0 on
> > non-x86.
> > 
> > >   	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
> > >   }
> > > @@ -3387,6 +3390,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
> > >   		mm->stack_vm += npages;
> > >   	else if (is_data_mapping(flags))
> > >   		mm->data_vm += npages;
> > > +	else if (arch_shadow_stack_mapping(flags))
> > > +		mm->stack_vm += npages;
> > 
> > Ditto.
> > 
> 
> The thought was, here all testings are done with helpers, e.g.
> is_data_mapping(), so creating a helper for shadow stack is more inline with
> the existing code.  Or, maybe we can call it is_shadow_stack_mapping()?
> And, since we have a helper, use it in accountable_mapping() as well.  Or do
> you have other suggestions?

is_shadow_stack_mapping() sounds reasonable.

My point is that we already have ifdef around #define VM_SHSTK. No need in
duplicating it for helper.

-- 
 Kirill A. Shutemov
