Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459EE3E4966
	for <lists+linux-arch@lfdr.de>; Mon,  9 Aug 2021 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhHIQGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Aug 2021 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHIQGP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2021 12:06:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F7C0613D3;
        Mon,  9 Aug 2021 09:05:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26f300329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:f300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BF771EC03FE;
        Mon,  9 Aug 2021 18:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628525148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s2ntZeqeJGbKUjPfb411owuDAN9mXxOKqADe9H8U+hA=;
        b=rPEKiMmwifFY97BTzPSyOIN1JPTQ9tkQqVSbKx0IaCiz3awHzGYY5viV5CbZmAg1Mtwc4E
        s9XTWoeiGL5JBWRsxcns22j8wq2X0N2N7KC6PNvISv+pvQYwVmOX9CzDBoez8gJ4fmomir
        /b4187J5NZZOwhLk1tDUe/EjY/gSiSM=
Date:   Mon, 9 Aug 2021 18:06:27 +0200
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v28 04/32] x86/cpufeatures: Introduce CPU setup and
 option parsing for CET
Message-ID: <YRFSg45dDMfeiGbt@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:51PM -0700, Yu-cheng Yu wrote:
>  /*
>   * Some CPU features depend on higher CPUID levels, which may not always
>   * be available due to CPUID level capping or broken virtualization
> @@ -1249,6 +1257,11 @@ static void __init cpu_parse_early_param(void)
>  	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>  		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>  
> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
> +	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
> +		setup_clear_cpu_cap(X86_FEATURE_IBT);

Patch 1 says:

"Disabling shadow stack also disables IBT."

I don't see that here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
