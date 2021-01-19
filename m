Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92AF2FBA5C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jan 2021 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbhASOxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 09:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbhASLJO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 06:09:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915BC061573;
        Tue, 19 Jan 2021 03:07:06 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00c2aa0e949335efb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:c2aa:e94:9335:efb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CD181EC05DE;
        Tue, 19 Jan 2021 12:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611054425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CRGl/u4vxGN+WxlP0KAC1sbS3k8pNEXivCxE9nwD1Kg=;
        b=FJmtEc/Bd8pzj81PNmZ8TxlCmQrZgNxGipGb9Q3em4Qa7ig24RPVseKjNGTSr0ayHmvp7e
        6I4isDyPVd9MafYg6by2PO7hqhPsedzYpEHmyTPzmWB+6JTdqLnxxavrBbFqh0/jqC8eNN
        e0w3yWpF+O83k6Wx68Y19M1XZzwAFDQ=
Date:   Tue, 19 Jan 2021 12:06:59 +0100
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
Subject: Re: [PATCH v17 02/26] x86/cet/shstk: Add Kconfig option for
 user-mode control-flow protection
Message-ID: <20210119110659.GG27433@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229213053.16395-3-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 29, 2020 at 01:30:29PM -0800, Yu-cheng Yu wrote:
> Shadow Stack provides protection against function return address
> corruption.  It is active when the processor supports it, the kernel has
> CONFIG_X86_CET_USER enabled, and the application is built for the feature.
> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
> non-Shadow Stack applications continue to work, but without protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/Kconfig           | 22 ++++++++++++++++++++++
>  arch/x86/Kconfig.assembler |  5 +++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7b6dd10b162a..72cff400b9ae 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1950,6 +1950,28 @@ config X86_SGX
>  
>  	  If unsure, say N.
>  
> +config ARCH_HAS_SHADOW_STACK
> +	def_bool n
> +
> +config X86_CET_USER

That thing needs to be X86_CET. How many times do I need to type this
before you do it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
