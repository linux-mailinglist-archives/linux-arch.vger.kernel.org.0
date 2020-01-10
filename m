Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3274C1375FC
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 19:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAJS2G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 13:28:06 -0500
Received: from foss.arm.com ([217.140.110.172]:49744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgAJS2G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 13:28:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7653730E;
        Fri, 10 Jan 2020 10:28:05 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996263F6C4;
        Fri, 10 Jan 2020 10:28:02 -0800 (PST)
Date:   Fri, 10 Jan 2020 18:28:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 04/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20200110182800.GI8786@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-5-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 03:41:58PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index fbebb411ae20..212bba1f8d84 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -35,8 +35,16 @@
>  #define GIC_PRIO_PSR_I_SET		(1 << 4)
>  
>  /* Additional SPSR bits not exposed in the UABI */
> +#define PSR_BTYPE_SHIFT		10
> +
>  #define PSR_IL_BIT		(1 << 20)
>  
> +/* Convenience names for the values of PSTATE.BTYPE */
> +#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)

Would these be better placed in the uapi/ptrace.h?

> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a9d98a443fc..ef80ecbd6eaf 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -98,6 +98,24 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	regs->orig_x0 = regs->regs[0];
>  	regs->syscallno = scno;
>  
> +	/*
> +	 * BTI note:
> +	 * The architecture does not guarantee that SPSR.BTYPE is zero
> +	 * on taking an SVC, so we could return to userspace with a
> +	 * non-zero BTYPE after the syscall.

On page 2580 of the ARM ARM there is a statement that "any instruction
other than BR, ..." sets BTYPE to 0. Wouldn't SVC fall into the same
category?

> +	 *
> +	 * This shouldn't matter except when userspace is explicitly
> +	 * doing something stupid, such as setting PROT_BTI on a page
> +	 * that lacks conforming BTI/PACIxSP instructions, falling
> +	 * through from one executable page to another with differing
> +	 * PROT_BTI, or messing with BYTPE via ptrace: in such cases,

s/BYTPE/BTYPE/

Apart from the nitpicks above, the patch looks good to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
