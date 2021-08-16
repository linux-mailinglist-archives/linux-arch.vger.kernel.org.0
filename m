Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5C3EDBF7
	for <lists+linux-arch@lfdr.de>; Mon, 16 Aug 2021 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhHPRD5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhHPRDz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2021 13:03:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43432C0613CF;
        Mon, 16 Aug 2021 10:03:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08b500a9c2327ac48af0d7.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:b500:a9c2:327a:c48a:f0d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 045F31EC0516;
        Mon, 16 Aug 2021 19:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629133395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cdjFAwQRlWFZrMh487IcfeXjtfV+kPYJk4xdQyxxwG8=;
        b=NUhUMN3z0T5t1Vvly3U2phQ+JRBo7JbQ8+kHQYZTrWatPMnvakMbGX9OCYIvzB8DUgNiZt
        3rFOUKsALV6KjJSsyxTWCiPKl9M3JpH0v9SzbA6vMHgawtmQG+yebfxl2m+mllhj+FPIrh
        dQjTxAjZbSBwv9k/ww48hnbm+fPbw5M=
Date:   Mon, 16 Aug 2021 19:03:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 16/32] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <YRqaesuEy9ZGttZ6@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-17-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-17-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:52:03PM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3364fe62b903..ba449d12ec32 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -610,6 +610,26 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
> +{
> +	if (likely(vma->vm_flags & VM_WRITE))
> +		pte = pte_mkwrite(pte);
> +	else if (likely(vma->vm_flags & VM_SHADOW_STACK))
> +		pte = pte_mkwrite_shstk(pte);
> +	return pte;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> +{
> +	if (likely(vma->vm_flags & VM_WRITE))
> +		pmd = pmd_mkwrite(pmd);
> +	else if (likely(vma->vm_flags & VM_SHADOW_STACK))
> +		pmd = pmd_mkwrite_shstk(pmd);

What are all those likely()ies here for?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
