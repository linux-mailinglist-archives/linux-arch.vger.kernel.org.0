Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA50698157
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfHURd7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 13:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfHURd6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 13:33:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191AC22D6D;
        Wed, 21 Aug 2019 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566408838;
        bh=bs8hczsNPANODvH4KyJJB3Ke129MTzcBxY5ubZQ+el4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egpMmbAIpi3WaaAuHcdz1N5cHHlhmeIXdbl9GEwrlxmRauiS3jNUVkRBTETUsH+62
         eSLY/o1hrwQabl6eUuj5QKiuAKqdZQkPK5Tao3iNY/v1WtQLL+6CwMcB1l9FuEE3sp
         jAAGjQBiyoEh2qOZNuyopa5G+CsiudEpVo1ttDpA=
Date:   Wed, 21 Aug 2019 18:33:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 3/3] arm64: Relax
 Documentation/arm64/tagged-pointers.rst
Message-ID: <20190821173352.yqfgaozi7nfhcofg@willie-the-truck>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
 <20190821164730.47450-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821164730.47450-4-catalin.marinas@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 21, 2019 at 05:47:30PM +0100, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> On AArch64 the TCR_EL1.TBI0 bit is set by default, allowing userspace
> (EL0) to perform memory accesses through 64-bit pointers with a non-zero
> top byte. However, such pointers were not allowed at the user-kernel
> syscall ABI boundary.
> 
> With the Tagged Address ABI patchset, it is now possible to pass tagged
> pointers to the syscalls. Relax the requirements described in
> tagged-pointers.rst to be compliant with the behaviours guaranteed by
> the AArch64 Tagged Address ABI.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/arm64/tagged-pointers.rst | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> index 2acdec3ebbeb..04f2ba9b779e 100644
> --- a/Documentation/arm64/tagged-pointers.rst
> +++ b/Documentation/arm64/tagged-pointers.rst
> @@ -20,7 +20,9 @@ Passing tagged addresses to the kernel
>  --------------------------------------
>  
>  All interpretation of userspace memory addresses by the kernel assumes
> -an address tag of 0x00.
> +an address tag of 0x00, unless the application enables the AArch64
> +Tagged Address ABI explicitly
> +(Documentation/arm64/tagged-address-abi.rst).
>  
>  This includes, but is not limited to, addresses found in:
>  
> @@ -33,13 +35,15 @@ This includes, but is not limited to, addresses found in:
>   - the frame pointer (x29) and frame records, e.g. when interpreting
>     them to generate a backtrace or call graph.
>  
> -Using non-zero address tags in any of these locations may result in an
> -error code being returned, a (fatal) signal being raised, or other modes
> -of failure.
> +Using non-zero address tags in any of these locations when the
> +userspace application did not enable the AArch64 Tagged Address ABI may
> +result in an error code being returned, a (fatal) signal being raised,
> +or other modes of failure.
>  
> -For these reasons, passing non-zero address tags to the kernel via
> -system calls is forbidden, and using a non-zero address tag for sp is
> -strongly discouraged.
> +For these reasons, when the AArch64 Tagged Address ABI is disabled,
> +passing non-zero address tags to the kernel via system calls is
> +forbidden, and using a non-zero address tag for sp is strongly
> +discouraged.
>  
>  Programs maintaining a frame pointer and frame records that use non-zero
>  address tags may suffer impaired or inaccurate debug and profiling
> @@ -59,6 +63,11 @@ be preserved.
>  The architecture prevents the use of a tagged PC, so the upper byte will
>  be set to a sign-extension of bit 55 on exception return.
>  
> +This behaviour is maintained when the AArch64 Tagged Address ABI is
> +enabled. In addition, with the exceptions above, the kernel will
> +preserve any non-zero tags passed by the user via syscalls and stored in
> +kernel data structures (e.g. ``set_robust_list()``, ``sigaltstack()``).

Hmm. I can see the need to provide this guarantee for things like
set_robust_list(), but the problem is that the statement above is too broad
and isn't strictly true: for example, mmap() doesn't propagate the tag of
its address parameter into the VMA.

So I think we need to nail this down a bit more, but I'm having a really
hard time coming up with some wording :(

Will
