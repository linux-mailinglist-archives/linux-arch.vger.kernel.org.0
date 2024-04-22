Return-Path: <linux-arch+bounces-3886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29E8ACB33
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 12:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963D1B23644
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D14145B1D;
	Mon, 22 Apr 2024 10:46:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22BE14A8B;
	Mon, 22 Apr 2024 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782806; cv=none; b=INhdwBZkxxy/xTGn4pXr4LMN1N8lcBqEhAq/8/diPnnKzPFRL1tj0Br4M/rdkRM+E9cU/ErG5NDuAvcSEDaL9fWf5UM5iBVAiCBnhD9XVIR/WqYjDEROgk0FlDjepTvTMPvISVFXX9UBcVEIYrpGWXUkPwlozrErbd4XJO1NH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782806; c=relaxed/simple;
	bh=TBfSszjsYeu8dxmuoA7yzrZI7AlIw4uTE4Ri0Sho5Z4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se6ioeX757YOHIu6GxsCvU0gxaZXpeQVDFk8WxqMLHhWW/jkvaAvozVzjzvlGsVFVOpqmZqi4lXme15VljhFdGuki/v8O7LLSstJ1t05T6j7IIlLYYawFN8pCr3dZPUozQIvbEoqtlRwQCgzLDfEkFlEd7dxIJBlw3fnh9hpnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNMPR49BXz6K9Mn;
	Mon, 22 Apr 2024 18:46:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 382BF1406AC;
	Mon, 22 Apr 2024 18:46:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 11:46:40 +0100
Date: Mon, 22 Apr 2024 11:46:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v7 09/16] arm64: acpi: Move get_cpu_for_acpi_id() to a
 header
Message-ID: <20240422114639.0000651a@Huawei.com>
In-Reply-To: <20240418135412.14730-10-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-10-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Apr 2024 14:54:05 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> ACPI identifies CPUs by UID. get_cpu_for_acpi_id() maps the ACPI UID
> to the Linux CPU number.
> 
> The helper to retrieve this mapping is only available in arm64's NUMA
> code.
> 
> Move it to live next to get_acpi_id_for_cpu().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Another one where we'd been focused on the general ACPI aspects so long
the CC list didn't include relevant maintainers.

+CC Lorenzo, Hanjun and Sudeep.


> ---
> v7: No change
> ---
>  arch/arm64/include/asm/acpi.h | 11 +++++++++++
>  arch/arm64/kernel/acpi_numa.c | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 6792a1f83f2a..bc9a6656fc0c 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -119,6 +119,17 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>  	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>  }
>  
> +static inline int get_cpu_for_acpi_id(u32 uid)
> +{
> +	int cpu;
> +
> +	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> +		if (uid == get_acpi_id_for_cpu(cpu))
> +			return cpu;
> +
> +	return -EINVAL;
> +}
> +
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  void __init acpi_init_cpus(void);
>  int apei_claim_sea(struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index e51535a5f939..0c036a9a3c33 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -34,17 +34,6 @@ int __init acpi_numa_get_nid(unsigned int cpu)
>  	return acpi_early_node_map[cpu];
>  }
>  
> -static inline int get_cpu_for_acpi_id(u32 uid)
> -{
> -	int cpu;
> -
> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (uid == get_acpi_id_for_cpu(cpu))
> -			return cpu;
> -
> -	return -EINVAL;
> -}
> -
>  static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
>  				      const unsigned long end)
>  {


