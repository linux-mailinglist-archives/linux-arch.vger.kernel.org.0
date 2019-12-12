Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4611CB44
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 11:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfLLKsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 05:48:38 -0500
Received: from foss.arm.com ([217.140.110.172]:42154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfLLKsi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 05:48:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E37C9328;
        Thu, 12 Dec 2019 02:48:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 117503F718;
        Thu, 12 Dec 2019 02:48:33 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:48:32 +0000
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
Subject: Re: [PATCH v4 03/12] mm: Reserve asm-generic prot flag 0x10 for arch
 use
Message-ID: <20191212104831.GD18258@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-4-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 03:41:57PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> The asm-generic mman definitions are used by a few architectures
> that also define an arch-specific PROT flag with value 0x10.  This
> currently applies to sparc and powerpc, and arm64 will soon join
> in.
> 
> To help future maintainers, document the use of this flag in the
> asm-generic header too.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/uapi/asm-generic/mman-common.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index c160a5354eb6..81442d2aaecb 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -11,6 +11,7 @@
>  #define PROT_WRITE	0x2		/* page can be written */
>  #define PROT_EXEC	0x4		/* page can be executed */
>  #define PROT_SEM	0x8		/* page may be used for atomic ops */
> + /*			0x10		   reserved for arch-specific use */
>  #define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */

Since the BTI will likely be merged before the MTE series, please
consider reserving 0x20 as well. The updated patch, acked by Arnd:

https://lore.kernel.org/linux-arm-kernel/20191211184027.20130-2-catalin.marinas@arm.com/

-- 
Catalin
