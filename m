Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE430F6F5
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhBDP5A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 10:57:00 -0500
Received: from foss.arm.com ([217.140.110.172]:60878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237654AbhBDP4q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 10:56:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0559C11D4;
        Thu,  4 Feb 2021 07:55:59 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A96C83F718;
        Thu,  4 Feb 2021 07:55:56 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:55:30 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, len.brown@intel.com,
        tony.luck@intel.com, libc-alpha@sourceware.org,
        ravi.v.shankar@intel.com, hjl.tools@gmail.com, carlos@redhat.com,
        mpe@ellerman.id.au, jannh@google.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] uapi: Move the aux vector AT_MINSIGSTKSZ define
 to uapi
Message-ID: <20210204155519.GA21837@arm.com>
References: <20210203172242.29644-1-chang.seok.bae@intel.com>
 <20210203172242.29644-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203172242.29644-2-chang.seok.bae@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 09:22:38AM -0800, Chang S. Bae wrote:
> Move the AT_MINSIGSTKSZ definition to generic Linux from arm64. It is
> already used as generic ABI in glibc's generic elf.h, and this move will
> prevent future namespace conflicts. In particular, x86 will re-use this
> generic definition.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: Carlos O'Donell <carlos@redhat.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: libc-alpha@sourceware.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Change from v4:
> * Added as a new patch (Carlos O'Donell)
> ---
>  arch/arm64/include/uapi/asm/auxvec.h | 1 -
>  include/uapi/linux/auxvec.h          | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
> index 743c0b84fd30..767d710c92aa 100644
> --- a/arch/arm64/include/uapi/asm/auxvec.h
> +++ b/arch/arm64/include/uapi/asm/auxvec.h
> @@ -19,7 +19,6 @@
>  
>  /* vDSO location */
>  #define AT_SYSINFO_EHDR	33
> -#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */

Since this is UAPI, I'm wondering whether we should try to preserve this
definition for users of <asm/auxvec.h>.  (Indeed, it is not uncommon to
include <asm/> headers in userspace hackery, since the <linux/> headers
tend to interact badly with the the libc headers.)

In C11 at least, duplicate #defines are not an error if the definitions
are the same.  I don't know about the history, but I suspect this was
true for older standards too.  So maybe we can just keep this definition
with a duplicate definition in the common header.

Otherwise, we could have

#ifndef AT_MINSIGSTKSZ
#define AT_MINSIGSTKSZ 51
#endif

in include/linux/uapi/auxvec.h, and keep the arm64 header unchanged.

>  
>  #define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
>  
> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
> index abe5f2b6581b..cc4fa77bd2a7 100644
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -33,5 +33,6 @@
>  
>  #define AT_EXECFN  31	/* filename of program */
>  
> +#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery  */
>  
>  #endif /* _UAPI_LINUX_AUXVEC_H */

Otherwise, this looks fine as a concept.

AFAICT, no other arch is already using the value 51.

If nobody else objects to the loss of the definition from arm64's
<asm/auxvec.h> then I guess I can put up with that -- but I will wait to
see if anyone gives a view first.

Cheers
---Dave
