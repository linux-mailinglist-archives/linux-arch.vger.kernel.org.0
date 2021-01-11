Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C982F1D3D
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jan 2021 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbhAKR5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jan 2021 12:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389680AbhAKR5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2021 12:57:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C25C0617A4;
        Mon, 11 Jan 2021 09:56:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f088f00ad31e6206ee73146.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:ad31:e620:6ee7:3146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D700E1EC04DD;
        Mon, 11 Jan 2021 18:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610387808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/5CtVo/UwrBSJWcpm5LHTVgzx79jnr7sh5lj/gNN1EE=;
        b=r1dRCcuAAzNinHRwv70Jc/k2NLJRF6q7sDui9/+Zn1f8PG48sZQFwQ07YaMmLil58/Jk3e
        8Ix8pm+/1koZXCLgJ5Pd/KygG1l+XQOydfsHuyx1X7+DolK4jzI04VBxJp9VDGVeqQI3xa
        0TVfTxuAUigDYWZxsnFfYFG320gE/So=
Date:   Mon, 11 Jan 2021 18:56:43 +0100
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
Subject: Re: [PATCH v17 04/26] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
Message-ID: <20210111175643.GD25645@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229213053.16395-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 29, 2020 at 01:30:31PM -0800, Yu-cheng Yu wrote:
> @@ -895,6 +903,12 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +static void init_cet_features(struct cpuinfo_x86 *c)
> +{
> +	if (cpu_has(c, X86_FEATURE_SHSTK) || cpu_has(c, X86_FEATURE_IBT))
> +		set_cpu_cap(c, X86_FEATURE_CET);
> +}

No need for that function - just add this two-liner to bsp_init_intel()
and not in get_cpu_cap().

> +static void adjust_combined_cpu_features(void)
> +{
> +#ifdef CONFIG_X86_CET_USER
> +	if (test_bit(X86_FEATURE_SHSTK, (unsigned long *)cpu_caps_cleared) &&
> +	    test_bit(X86_FEATURE_IBT, (unsigned long *)cpu_caps_cleared))
> +		setup_clear_cpu_cap(X86_FEATURE_CET);
> +#endif

There's no need for this function...

> +}
> +
>  /*
>   * We parse cpu parameters early because fpu__init_system() is executed
>   * before parse_early_param().
> @@ -1252,9 +1276,19 @@ static void __init cpu_parse_early_param(void)
>  	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>  		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>  
> +	/*
> +	 * CET states are XSAVES states and options must be parsed early.
> +	 */
> +#ifdef CONFIG_X86_CET_USER
> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);

... when you can do

	setup_clear_cpu_cap(X86_FEATURE_CET);

here and...

> +	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
> +		setup_clear_cpu_cap(X86_FEATURE_IBT);

... here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
