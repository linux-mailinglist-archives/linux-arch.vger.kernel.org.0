Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83108310C17
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 14:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBENqU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 08:46:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhBENny (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 08:43:54 -0500
Received: from zn.tnic (p200300ec2f0bad00265302c9d3d9d03f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ad00:2653:2c9:d3d9:d03f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E98A1EC046E;
        Fri,  5 Feb 2021 14:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612532592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BsMjYDoNfcMteGQMdj+hPtQS3ZX8QWITgjgkQYNdXtc=;
        b=YzijYPKtAqMP2MqrfGnz3t31fNY/zPFrkTj2ehYytDWViV6kZUo4CtNASZ2CnHcx8S86Vw
        y5qIvs15h1rv6vlp8O27q0914Upa00rdc66PWg8hr+kc/wrP/BcACcocdSr0l+OyANMuMG
        hKHvoe2AFLvlCWaa1dHn1xhhsMn5I4Q=
Date:   Fri, 5 Feb 2021 14:43:05 +0100
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 04/25] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
Message-ID: <20210205134305.GG17488@zn.tnic>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:26PM -0800, Yu-cheng Yu wrote:
> @@ -1252,6 +1260,13 @@ static void __init cpu_parse_early_param(void)
>  	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>  		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>  
> +#ifdef CONFIG_X86_CET
> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
> +	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
> +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> +#endif

Any particular need for the ifdeffery?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
