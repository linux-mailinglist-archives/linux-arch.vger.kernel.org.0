Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15FD867A5
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404110AbfHHRG5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 13:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404096AbfHHRG5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 13:06:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8752173C;
        Thu,  8 Aug 2019 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565284016;
        bh=6NCSbiarfUPfvof9H5iq7rmAMMlI2cd617d7HXVu71g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1niW5am1bbF4Y9RSMMymm4zzkeUeufEryPN345TaPK7w+GonSZ1rNl8wpHLRBLFG
         apjOg0dRj6TDjUIPf33HCxD0zUnsF1nMyDaqLs3YA1oqvPdwD/q3+P8icRXeDz3ZAK
         +QLIaoMpiB2x+zLWsiPwRQJgwnODecpqoloH9XTs=
Date:   Thu, 8 Aug 2019 18:06:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v7 2/2] arm64: Relax
 Documentation/arm64/tagged-pointers.rst
Message-ID: <20190808170651.c6hflztfunjmisgm@willie-the-truck>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-3-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807155321.9648-3-catalin.marinas@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 07, 2019 at 04:53:21PM +0100, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
> the userspace (EL0) is allowed to set a non-zero value in the
> top byte but the resulting pointers are not allowed at the
> user-kernel syscall ABI boundary.
> 
> With the relaxed ABI proposed in this set, it is now possible to pass
> tagged pointers to the syscalls, when these pointers are in memory
> ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().
> 
> Relax the requirements described in tagged-pointers.rst to be compliant
> with the behaviours guaranteed by the ARM64 Tagged Address ABI.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [catalin.marinas@arm.com: minor tweaks]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/arm64/tagged-pointers.rst | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> index 2acdec3ebbeb..82a3eff71a70 100644
> --- a/Documentation/arm64/tagged-pointers.rst
> +++ b/Documentation/arm64/tagged-pointers.rst
> @@ -20,7 +20,8 @@ Passing tagged addresses to the kernel
>  --------------------------------------
>  
>  All interpretation of userspace memory addresses by the kernel assumes
> -an address tag of 0x00.
> +an address tag of 0x00, unless the application enables the AArch64
> +Tagged Address ABI explicitly.

I think we should have the link to Documentation/arm64/tagged-address-abi.rst
here so people see it when it's first referenced.

> +The AArch64 Tagged Address ABI description and the guarantees it
> +provides can be found in: Documentation/arm64/tagged-address-abi.rst.

Then this sentence can be dropped.

Will
