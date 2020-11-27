Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226DF2C6A6D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 18:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgK0RKV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 12:10:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43272 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbgK0RKU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 12:10:20 -0500
Received: from zn.tnic (p200300ec2f0ffb00fa2fd8ad942748bd.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:fb00:fa2f:d8ad:9427:48bd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 456451EC042F;
        Fri, 27 Nov 2020 18:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606497018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u6W3Ih82jfxbD+DI9YweOatwjesltCvnSeq3TqSUtnU=;
        b=Qw32cDom4Nr5D+nAiugyMDt4WopNk82UIfnsTh5TWW1Ae4XcJ39IcPoa+GzKogo5QrQHIx
        mhiTK2D5SSwXq/kn76nb1bJDepO55LKV+yfJo5RWlQTjDati38TpRWUk7AU1iO/ivRrs2Z
        jO7gcT+EvHc/iDMLoOBjlIBtqbVpVmA=
Date:   Fri, 27 Nov 2020 18:10:12 +0100
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
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack
Message-ID: <20201127171012.GD13163@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-6-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:50AM -0800, Yu-cheng Yu wrote:
> +config X86_CET
> +	def_bool n
> +
> +config ARCH_HAS_SHADOW_STACK
> +	def_bool n
> +
> +config X86_SHADOW_STACK_USER

Is X86_SHADOW_STACK_KERNEL coming too?

Regardless, you can add it when it comes and you can use only X86_CET
for now and drop this one and simplify this pile of Kconfig symbols.

> +	prompt "Intel Shadow Stacks for user-mode"
> +	def_bool n
> +	depends on CPU_SUP_INTEL && X86_64
> +	depends on AS_HAS_SHADOW_STACK
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select X86_CET
> +	select ARCH_HAS_SHADOW_STACK
> +	help
> +	  Shadow Stacks provides protection against program stack
> +	  corruption.  It's a hardware feature.  This only matters
> +	  if you have the right hardware.  It's a security hardening
> +	  feature and apps must be enabled to use it.  You get no
> +	  protection "for free" on old userspace.  The hardware can
> +	  support user and kernel, but this option is for user space
> +	  only.
> +	  Support for this feature is only known to be present on
> +	  processors released in 2020 or later.  CET features are also
> +	  known to increase kernel text size by 3.7 KB.

This help text needs some rewriting. You can find an inspiration about
more adequate style in that same Kconfig file.

> +
> +	  If unsure, say N.
> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI
> diff --git a/scripts/as-x86_64-has-shadow-stack.sh b/scripts/as-x86_64-has-shadow-stack.sh
> new file mode 100755
> index 000000000000..fac1d363a1b8
> --- /dev/null
> +++ b/scripts/as-x86_64-has-shadow-stack.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +echo "wrussq %rax, (%rbx)" | $* -x assembler -c -

						      2> /dev/null

otherwise you get

{standard input}: Assembler messages:
{standard input}:1: Error: no such instruction: `wrussq %rax,(%rbx)

on non-enlightened toolchains during build.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
