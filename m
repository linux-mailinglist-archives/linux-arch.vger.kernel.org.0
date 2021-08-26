Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5973F8C0D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhHZQZj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 12:25:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243097AbhHZQZd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 12:25:33 -0400
Received: from zn.tnic (p200300ec2f131000dba9b80c472eda01.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1000:dba9:b80c:472e:da01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1D801EC05A0;
        Thu, 26 Aug 2021 18:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629995079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nAR7I+RvkkR/CrtB9Lh5jb8RkckwGTFjzOTKJm0aJng=;
        b=Fv5in2D0HjkccNSYDhG+FSvC/iX9cjzHUQdJQToLlOkfDP7a/N8oTZciIY7S/3bDe82h3m
        ix8Spe+M056b1gjhQeLRDPPZPBWO3+W2s6SQcOAvtunECnZo8gqH1zzVBzzJnCvo/M8jNy
        9fPksymjuHyNGHV1LbVz3DmW57apopg=
Date:   Thu, 26 Aug 2021 18:25:17 +0200
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v29 23/32] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <YSfAbaMxQegvmN2p@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-24-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820181201.31490-24-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 20, 2021 at 11:11:52AM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> new file mode 100644
> index 000000000000..6432baf4de1f
> --- /dev/null
> +++ b/arch/x86/include/asm/cet.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CET_H
> +#define _ASM_X86_CET_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +struct task_struct;
> +
> +/*
> + * Per-thread CET status
> + */

That comment is superfluous and wrong now. The struct name says exactly
what that thing is.

> +static unsigned long alloc_shstk(unsigned long size)
> +{
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr, populate;

s/populate/unused/

> +
> +	mmap_write_lock(mm);
> +	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
> +		       &populate, NULL);
> +	mmap_write_unlock(mm);
> +
> +	return addr;
> +}
> +
> +int shstk_setup(void)
> +{
> +	struct thread_shstk *shstk = &current->thread.shstk;
> +	unsigned long addr, size;
> +	int err;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return 0;
> +
> +	size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
> +	addr = alloc_shstk(size);
> +	if (IS_ERR_VALUE(addr))
> +		return PTR_ERR((void *)addr);
> +
> +	start_update_msrs();

You're setting CET_U with the MSR writes below. Why do you need to do
XRSTOR here? To zero out PL[012]_SSP?

If so, you can WRMSR those too - no need for a full XRSTOR...

> +	err = wrmsrl_safe(MSR_IA32_PL3_SSP, addr + size);
> +	if (!err)
> +		wrmsrl_safe(MSR_IA32_U_CET, CET_SHSTK_EN);
> +	end_update_msrs();
> +
> +	if (!err) {
> +		shstk->base = addr;
> +		shstk->size = size;
> +	}
> +
> +	return err;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
