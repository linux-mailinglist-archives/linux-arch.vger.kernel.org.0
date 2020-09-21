Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05990271E7C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIUJDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 05:03:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgIUJDN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 05:03:13 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 46539BE2DF49309FE3B4;
        Mon, 21 Sep 2020 10:03:11 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 10:03:10 +0100
Date:   Mon, 21 Sep 2020 10:01:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atish Patra <atish.patra@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFT PATCH v3 2/5] arm64, numa: Change the numa init functions
 name to be generic
Message-ID: <20200921100131.00005238@Huawei.com>
In-Reply-To: <20200918201140.3172284-3-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
        <20200918201140.3172284-3-atish.patra@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.13]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 18 Sep 2020 13:11:37 -0700
Atish Patra <atish.patra@wdc.com> wrote:

> As we are using generic numa implementation code, modify the acpi & numa
> init functions name to indicate that generic implementation.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Other than the double include of linux/acpi.h below this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/arm64/kernel/acpi_numa.c | 13 -------------
>  arch/arm64/mm/init.c          |  4 ++--
>  drivers/base/arch_numa.c      | 31 +++++++++++++++++++++++++++----
>  include/asm-generic/numa.h    |  4 ++--
>  4 files changed, 31 insertions(+), 21 deletions(-)
> 
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
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 481d22c32a2e..93b660229e1d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -418,10 +418,10 @@ void __init bootmem_init(void)
>  	max_pfn = max_low_pfn = max;
>  	min_low_pfn = min;
>  
> -	arm64_numa_init();
> +	arch_numa_init();
>  
>  	/*
> -	 * must be done after arm64_numa_init() which calls numa_init() to
> +	 * must be done after arch_numa_init() which calls numa_init() to
>  	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
>  	 * while allocating required CMA size across online nodes.
>  	 */
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 73f8b49d485c..1649c90a3bc5 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -13,7 +13,9 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  
> -#include <asm/acpi.h>
> +#ifdef CONFIG_ACPI_NUMA
> +#include <linux/acpi.h>
> +#endif

Why do we need this ifdef stuff here?
In particular acpi_disabled is defined in that header
in the !CONFIG_ACPI case so seems like we should include it always.

Also given we've just moved arch/arm64/numa.c to become this file,
it has an include of that header a few lines off the top of this diff anyway.

So I think you can just drop the additional include here.


>  #include <asm/sections.h>
>  
>  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> @@ -444,16 +446,37 @@ static int __init dummy_numa_init(void)
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
>   * last fallback is dummy single node config encomapssing whole memory.
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
> diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> index 2718d5a6ff03..e7962db4ba44 100644
> --- a/include/asm-generic/numa.h
> +++ b/include/asm-generic/numa.h
> @@ -27,7 +27,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
>  }
>  #endif
>  
> -void __init arm64_numa_init(void);
> +void __init arch_numa_init(void);
>  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
>  void __init numa_set_distance(int from, int to, int distance);
>  void __init numa_free_distance(void);
> @@ -41,7 +41,7 @@ void numa_remove_cpu(unsigned int cpu);
>  static inline void numa_store_cpu_info(unsigned int cpu) { }
>  static inline void numa_add_cpu(unsigned int cpu) { }
>  static inline void numa_remove_cpu(unsigned int cpu) { }
> -static inline void arm64_numa_init(void) { }
> +static inline void arch_numa_init(void) { }
>  static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
>  
>  #endif	/* CONFIG_NUMA */


