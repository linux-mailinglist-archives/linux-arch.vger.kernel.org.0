Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC12250859
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHXSpA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXSpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2020 14:45:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E01C061573
        for <linux-arch@vger.kernel.org>; Mon, 24 Aug 2020 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ClVtnBCNL9jSDwJxwBsm6jujknMSQxdDeSZ1zzGivuk=; b=rxaN7eZhp4qz5YrulUzMYvj8V1
        7td3jlTZIwn0xF0kCLC2oi8l3cFA3w+RupkeXySHMHUONyUjX0dtvav0V9TgDhefYgrnIBPO7BA/P
        gfVDHAU4tLeYtS3XcBeHQIuQFZsLg9UE0IKebxWjryhJfmC544PSiBjnpw086neYyLOwefxRwgPMK
        Ic5p05oF3gdJSKAwHlj1tmn7AFh47af7Vrnuewjgp+LoT+yiplB9iAAK2/Zn40lqS3UupNPCn67uS
        XHulbgngKAx3DM1gsoUSy6f/lZo9oaKZS03X3hq1fdc7Fe4beYCT0o5kQsWkDzROnpvsxxkLlDD6N
        UnBudtxg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAHSi-00022u-EK; Mon, 24 Aug 2020 18:44:56 +0000
Subject: Re: [PATCH v8 27/28] arm64: mte: Kconfig entry
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-28-catalin.marinas@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e73f87b-f5fe-5ccf-1b5f-c916703356e0@infradead.org>
Date:   Mon, 24 Aug 2020 11:44:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824182758.27267-28-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 8/24/20 11:27 AM, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Add Memory Tagging Extension support to the arm64 kbuild.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     v7:
>     - Binutils gained initial support for MTE in 2.32.0. However, a late
>       architecture addition (LDGM/STGM) is only supported in the newer
>       2.32.x and 2.33 versions. Change the AS_HAS_MTE option to also check
>       for stgm in addition to .arch armv8.5-a+memtag.
>     
>  arch/arm64/Kconfig | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..10cf81d70657 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1664,6 +1664,37 @@ config ARCH_RANDOM
>  	  provides a high bandwidth, cryptographically secure
>  	  hardware random number generator.
>  
> +config ARM64_AS_HAS_MTE
> +	# Binutils gained initial support for MTE in 2.32.0. However, a
> +	# late architecture addition (LDGM/STGM) is only supported in
> +	# the newer 2.32.x and 2.33 versions.
> +	def_bool $(as-instr,.arch armv8.5-a+memtag\nstgm xzr$(comma)[x0])

Would you mind translating that for me?
Yes, I read the v7 Notes, but that only helped a little bit.


> +
> +config ARM64_MTE
> +	bool "Memory Tagging Extension support"
> +	default y
> +	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	help
> +	  Memory Tagging (part of the ARMv8.5 Extensions) provides
> +	  architectural support for run-time, always-on detection of

	                            runtime,
as is used below.

> +	  various classes of memory error to aid with software debugging
> +	  to eliminate vulnerabilities arising from memory-unsafe
> +	  languages.
> +
> +	  This option enables the support for the Memory Tagging
> +	  Extension at EL0 (i.e. for userspace).
> +
> +	  Selecting this option allows the feature to be detected at
> +	  runtime. Any secondary CPU not implementing this feature will
> +	  not be allowed a late bring-up.
> +
> +	  Userspace binaries that want to use this feature must
> +	  explicitly opt in. The mechanism for the userspace is
> +	  described in:
> +
> +	  Documentation/arm64/memory-tagging-extension.rst.
> +
>  endmenu
>  
>  config ARM64_SVE
> 

thanks.
-- 
~Randy

