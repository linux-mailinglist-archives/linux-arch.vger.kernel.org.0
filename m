Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA52A9A8F
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFROM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 12:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFROM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 12:14:12 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5940722202;
        Fri,  6 Nov 2020 17:14:07 +0000 (UTC)
Date:   Fri, 6 Nov 2020 17:14:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v4 2/5] arm64, numa: Change the numa init functions name
 to be generic
Message-ID: <20201106171403.GK29329@gaia>
References: <20201006001752.248564-1-atish.patra@wdc.com>
 <20201006001752.248564-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006001752.248564-3-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 05:17:49PM -0700, Atish Patra wrote:
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 7ff800045434..96502ff92af5 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
>  
>  	node_set(node, numa_nodes_parsed);
>  }
> -
> -int __init arm64_acpi_numa_init(void)
> -{
> -	int ret;
> -
> -	ret = acpi_numa_init();
> -	if (ret) {
> -		pr_info("Failed to initialise from firmware\n");
> -		return ret;
> -	}
> -
> -	return srat_disabled() ? -EINVAL : 0;
> -}

I think it's better if arm64_acpi_numa_init() and arm64_numa_init()
remained in the arm64 code. It's not really much code to be shared.

> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 73f8b49d485c..74b4f2ddad70 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -13,7 +13,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  
> -#include <asm/acpi.h>
>  #include <asm/sections.h>
>  
>  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> @@ -444,16 +443,37 @@ static int __init dummy_numa_init(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI_NUMA
> +static int __init arch_acpi_numa_init(void)
> +{
> +	int ret;
> +
> +	ret = acpi_numa_init();
> +	if (ret) {
> +		pr_info("Failed to initialise from firmware\n");
> +		return ret;
> +	}
> +
> +	return srat_disabled() ? -EINVAL : 0;
> +}
> +#else
> +static int __init arch_acpi_numa_init(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif
> +
>  /**
> - * arm64_numa_init() - Initialize NUMA
> + * arch_numa_init() - Initialize NUMA
>   *
>   * Try each configured NUMA initialization method until one succeeds. The
> - * last fallback is dummy single node config encomapssing whole memory.
> + * last fallback is dummy single node config encompassing whole memory.
>   */
> -void __init arm64_numa_init(void)
> +void __init arch_numa_init(void)
>  {
>  	if (!numa_off) {
> -		if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
> +		if (!acpi_disabled && !numa_init(arch_acpi_numa_init))
>  			return;
>  		if (acpi_disabled && !numa_init(of_numa_init))
>  			return;

Does riscv even have an acpi_disabled variable?

-- 
Catalin
