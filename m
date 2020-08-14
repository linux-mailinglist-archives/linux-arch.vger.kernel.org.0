Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B658B245017
	for <lists+linux-arch@lfdr.de>; Sat, 15 Aug 2020 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHNXWB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 19:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNXWB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 19:22:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E9AC061385;
        Fri, 14 Aug 2020 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gcuzMKy5ca6nfpuGB7Mj7FbeflYqFCzDME2EUzPv4RI=; b=fAOOWOgbBBcaQyop3AF67ybOEX
        k/WF+pgpKGKLLKzbe7Ulx6Ps2XQvg8KHEStyZjDY9NPvQupoQrFENxvNiHJrEXtnvlGDDUcxy1Hyj
        XQLxy2PVel5XjaOyffpPuWnLysmtajdns/y4kJge3K1NOqDyk0EmYxCucuH0KGwYOq93fSKGR2n3r
        hSFZ36NXhNa4O7937jfUb3hG0bXZkcE2na7NvzfjDoV9YDkKDgrif4pPhgnyTq8LvLvE7ANflQpbA
        taeK74i9uBbRoIqgS7v6qkVtUqX9qrXlOIoFxcn/S+q8EUPAi1jZ4EhqobOVsVaOKHKzUHG4/pn35
        1748qU+Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6j19-0003gu-0n; Fri, 14 Aug 2020 23:21:53 +0000
Subject: Re: [RFC/RFT PATCH 6/6] riscv: Add numa support for riscv64 platform
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200814214725.28818-1-atish.patra@wdc.com>
 <20200814214725.28818-7-atish.patra@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d5046a4-8b7e-6279-ccd2-e02b2a091139@infradead.org>
Date:   Fri, 14 Aug 2020 16:21:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814214725.28818-7-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/14/20 2:47 PM, Atish Patra wrote:
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7b5905529146..4bd67f94aaac 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -137,7 +137,7 @@ config PAGE_OFFSET
>  	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>  
>  config ARCH_FLATMEM_ENABLE
> -	def_bool y
> +	def_bool !NUMA
>  
>  config ARCH_SPARSEMEM_ENABLE
>  	def_bool y
> @@ -295,6 +295,35 @@ config TUNE_GENERIC
>  
>  endchoice
>  
> +# Common NUMA Features
> +config NUMA
> +	bool "Numa Memory Allocation and Scheduler Support"

	      NUMA

> +	select GENERIC_ARCH_NUMA
> +	select OF_NUMA
> +	select ARCH_SUPPORTS_NUMA_BALANCING
> +	help
> +	  Enable NUMA (Non-Uniform Memory Access) support.
> +
> +	  The kernel will try to allocate memory used by a CPU on the
> +	  local memory of the CPU and add some more NUMA awareness to the kernel.
> +
> +config NODES_SHIFT
> +	int "Maximum NUMA Nodes (as a power of 2)"
> +	range 1 10
> +	default "2"
> +	depends on NEED_MULTIPLE_NODES
> +	help
> +	  Specify the maximum number of NUMA Nodes available on the target
> +	  system.  Increases memory reserved to accommodate various tables.
> +
> +config USE_PERCPU_NUMA_NODE_ID
> +	def_bool y
> +	depends on NUMA
> +
> +config NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	def_bool y
> +	depends on NUMA
> +
>  config RISCV_ISA_C
>  	bool "Emit compressed instructions when building Linux"
>  	default y


thanks.
-- 
~Randy

