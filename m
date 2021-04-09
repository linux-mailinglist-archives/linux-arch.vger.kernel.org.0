Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9D359BB0
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhDIKPm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 06:15:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233851AbhDIKMb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 06:12:31 -0400
Received: from zn.tnic (p200300ec2f0be10048f842a34b65c796.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:48f8:42a3:4b65:c796])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5143E1EC0345;
        Fri,  9 Apr 2021 12:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617963136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=koEbuNDmdhGDu2ay8IpM2qYEJm21DVX8eeBWkuWqc2I=;
        b=JOjOjGo6n8ctViJXkPL+UQEHtj5zYd8rpZrcP+sZezMa1SBathd+X2ZANVtH3ls4n/eoYb
        VZP38BQpV+Qv7OU47u+1xlbjMsBo1L/PI+lytUBsoMo3U9GugzTZG2nnh/UGDRP3E+/YyZ
        9N1soZxem3P3MhhtTg9MdzUnZ0kOe98=
Date:   Fri, 9 Apr 2021 12:12:14 +0200
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v24 04/30] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
Message-ID: <20210409101214.GC15567@zn.tnic>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:38PM -0700, Yu-cheng Yu wrote:
> Introduce a software-defined X86_FEATURE_CET, which indicates either Shadow
> Stack or Indirect Branch Tracking (or both) is present.  Also introduce
> related cpu init/setup functions.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
> v24:
> - Update #ifdef placement to reflect Kconfig changes of splitting shadow stack and ibt.
> 
>  arch/x86/include/asm/cpufeatures.h          |  2 +-
>  arch/x86/include/asm/disabled-features.h    |  9 ++++++++-
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/cpu/common.c                | 14 ++++++++++++++
>  arch/x86/kernel/cpu/intel.c                 |  3 +++
>  5 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index bf861fc89fef..d771e62677de 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -108,7 +108,7 @@
>  #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
>  #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
>  #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
> -/* free					( 3*32+29) */
> +#define X86_FEATURE_CET			( 3*32+29) /* Control-flow enforcement */

Right, I know we talked about having this synthetic flag but now that we
are moving to CONFIG_X86_SHADOW_STACK and separate SHSTK and IBT feature
bits, that synthetic flag is not needed anymore.

For the cases where you wanna test whether any of the two are present,
we're probably better off adding a x86_cet_enabled() helper which tests
SHSTK and IBT bits.

I haven't gone through the whole thing yet but depending on the context
and the fact that AMD doesn't support IBT, that helper might need some
tweaking too. I'll see.

>  #define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
>  #define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
>  
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index e5c6ed9373e8..018cd7acd3e9 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -74,13 +74,20 @@
>  #define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_CET

And you don't need that config item either - AFAICT, you can use
CONFIG_X86_SHADOW_STACK everywhere.

Which would simplify that config space.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
