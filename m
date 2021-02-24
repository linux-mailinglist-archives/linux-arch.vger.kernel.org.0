Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C332416E
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhBXP4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 10:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBXPgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 10:36:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21330C061786;
        Wed, 24 Feb 2021 07:35:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d1800cad8e5da06da911c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:cad8:e5da:6da:911c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7B071EC059E;
        Wed, 24 Feb 2021 16:34:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614180899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/uJb+CugCxZSQUf2FuIWyTbep6Ia1H3jI84SFaxyhw8=;
        b=g15qgOUyEATYclyqm0SXIr/lZQRAmKe+KRgwywS0gTeOvIMNDng/GQNY4CFW5Kl1dKILle
        oIoqGn6Qq6iSko7NfmUeUntU7oa+PCUqiEZAMKevWNOkWbzkHYJhra8M1Uuli6KS4LRXON
        +KeHJcSC6fnFYw2qKrTefLylBVr+GvE=
Date:   Wed, 24 Feb 2021 16:34:57 +0100
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
Subject: Re: [PATCH v21 05/26] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <20210224153457.GC20344@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217222730.15819-6-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 17, 2021 at 02:27:09PM -0800, Yu-cheng Yu wrote:
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 546d6ecf0a35..fae6b3ea1f6d 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -933,4 +933,23 @@
>  #define MSR_VM_IGNNE                    0xc0010115
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>  
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
> +#define CET_SHSTK_EN		BIT_ULL(0)
> +#define CET_WRSS_EN		BIT_ULL(1)
> +#define CET_ENDBR_EN		BIT_ULL(2)
> +#define CET_LEG_IW_EN		BIT_ULL(3)
> +#define CET_NO_TRACK_EN		BIT_ULL(4)
> +#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
> +#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
> +#define CET_SUPPRESS		BIT_ULL(10)
> +#define CET_WAIT_ENDBR		BIT_ULL(11)
> +
> +#define MSR_IA32_PL0_SSP	0x6a4 /* kernel shadow stack pointer */
> +#define MSR_IA32_PL1_SSP	0x6a5 /* ring-1 shadow stack pointer */
> +#define MSR_IA32_PL2_SSP	0x6a6 /* ring-2 shadow stack pointer */
> +#define MSR_IA32_PL3_SSP	0x6a7 /* user shadow stack pointer */
> +#define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shadow stack table */

When you look at the formatting in that file and the MSR numbers in it, what
stops you from formatting your addition the same way?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
