Return-Path: <linux-arch+bounces-4092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66CE8B7D49
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 18:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC641F22531
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8117F377;
	Tue, 30 Apr 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdPI3j+f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA017BB2A;
	Tue, 30 Apr 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495087; cv=none; b=JThwONKuLajeqEkc5qsvkMIqE9uT76C0v+HDooB7hjRJ4EUDjgk3PbW1X4I78eEkAXGocBpcUNWK7Y7U9iFjf1SZ9oMun2QwOGj7hXGT8FwYZyW7z+Ztdi9QwmzR41b/SDdop8h0IyTSRHCpyJDEf8u0hFObInDdYdh1gLIcY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495087; c=relaxed/simple;
	bh=Ea+j+o7qluZ3aaBqBGHNFexj3b3TayUV5vNIzNDaABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5dyto/fmiYabjWx+YT4RBepLZqnJfWisOxdHm+/AhKgZaeEgH0Vjy1uRbaZzPymH+XcFvpGJlA6CgKsPxOJk6WVZXPZ2LL4xEhZ/gBMazYX8z+RmTIF7lZhB8wxKja2mVHG6uvR0xb0K3M82QjBz8HXeFpPUY8jp04Khr//Rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdPI3j+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA2C2BBFC;
	Tue, 30 Apr 2024 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714495087;
	bh=Ea+j+o7qluZ3aaBqBGHNFexj3b3TayUV5vNIzNDaABo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdPI3j+fJEvjdlmQPVgXo3qL61z93kiPiPU0GNMO6P3czlrBXGHu0O7CqbtW1hc9l
	 b0kfasC3XiEb1jdrIHpCbYfctwchFwn04bFT9tTFyydOPjsIVO64QoyuerTG/mtHWc
	 f1MQmuDA1ZgE+6qtsvMJvNOYzV2vgey+Mt0Bz1ANY8ZEQSC3vcnMjGKrhPBQyybJ80
	 FzN/GqlqNxKYAWaqTu4sGINBQ2HfbuDQG6Vu4Zn7vzfSJ7bCmjQ0yv3q+PVjVvvP6c
	 GEEkw7yk9uFtjwpX9eM+pdS1suoz4V6eKZK+spUuRAZnIrIhqniB6yD8zKvuuR9/bp
	 apKC0UzuqlvYQ==
Date: Tue, 30 Apr 2024 18:37:58 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, Russell King <linux@armlinux.org.uk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	James Morse <james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
	justin.he@arm.com, jianyong.wu@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 09/16] arm64: acpi: Move get_cpu_for_acpi_id() to a
 header
Message-ID: <ZjEeZkn5J+m086pR@lpieralisi>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-10-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426135126.12802-10-Jonathan.Cameron@huawei.com>

On Fri, Apr 26, 2024 at 02:51:19PM +0100, Jonathan Cameron wrote:
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
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v8: Picked up tags.
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

Apologies for the late reply.

If anything, it may make sense to squash this patch into the commit that
is actually needing it, lest we might end up with a change that is
useless if it is taken stand alone.

That's all there is to say so:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

>  static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
>  				      const unsigned long end)
>  {
> -- 
> 2.39.2
> 

