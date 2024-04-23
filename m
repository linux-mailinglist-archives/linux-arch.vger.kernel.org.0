Return-Path: <linux-arch+bounces-3914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1E8AE574
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 14:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A341FB21DED
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85413E884;
	Tue, 23 Apr 2024 11:58:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F212FF71;
	Tue, 23 Apr 2024 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873515; cv=none; b=m3o6lAaTSvKay2IejNOcQCceUa3XBzJxXLOufFT2DcFa8J+2Vf79a0m+SWW+QsRL/6i72aGxw7+2M2SvChOtOj+8hpohvGQltCSrkcZJdilsgtp1jHP/zIP/Sgs1QQdI0x6KatRzpNDNxG/uMyE534OVFAX2Z0HmQC461JHcgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873515; c=relaxed/simple;
	bh=UwN9B5ZWL0Ik8wZIGWNSkvjuIaxwxH+1NZhCExUifCE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jos/XdCmyM7K0erE7RVmXAtHyaB3bRkjwH/KsoNBmNhsKXUU0gmj5lD/1fglJvzrJd1kkov/EP0AXFuaIZPcBZHUHr8F9N1/5t+epC3YY01qBScGWrTb+34rChl1cR6I704gBfl85aXTblNHQAWyLSMgp59akFcH5zgeNa8zph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VP0wk5VHmzShmm;
	Tue, 23 Apr 2024 19:57:26 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id E579818007D;
	Tue, 23 Apr 2024 19:58:30 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 19:58:29 +0800
Subject: Re: [PATCH v7 06/16] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-7-Jonathan.Cameron@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <d54b7aa7-f890-9f51-7ea7-f035eca1863f@huawei.com>
Date: Tue, 23 Apr 2024 19:58:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418135412.14730-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/4/18 21:54, Jonathan Cameron wrote:
> From: James Morse <james.morse@arm.com>
> 
> The arm64 specific arch_register_cpu() call may defer CPU registration
> until the ACPI interpreter is available and the _STA method can
> be evaluated.
> 
> If this occurs, then a second attempt is made in
> acpi_processor_get_info(). Note that the arm64 specific call has
> not yet been added so for now this will be called for the original
> hotplug case.
> 
> For architectures that do not defer until the ACPI Processor
> driver loads (e.g. x86), for initially present CPUs there will
> already be a CPU device. If present do not try to register again.
> 
> Systems can still be booted with 'acpi=off', or not include an
> ACPI description at all as in these cases arch_register_cpu()
> will not have deferred registration when first called.
> 
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.
> Note this is where the call was prior to the cleanup series so
> there should be no side effects of moving it back again for this
> specific case.
> 
> [PATCH 00/21] Initial cleanups for vCPU HP.
> https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> commit 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: Simplify the logic on whether to hotadd the CPU.
>      This path can only be reached either for coldplug in which
>      case all we care about is has register_cpu() already been
>      called (identifying deferred), or hotplug in which case
>      whether register_cpu() has been called is also sufficient.
>      Checks on _STA related elements or the validity of the ID
>      are no longer necessary here due to similar checks having
>      moved elsewhere in the path.
> v6: Squash the two paths for conventional CPU Hotplug and arm64
>      vCPU HP.
> ---
>   drivers/acpi/acpi_processor.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 127ae8dcb787..4e65011e706c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -350,14 +350,14 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   	}
>   
>   	/*
> -	 *  Extra Processor objects may be enumerated on MP systems with
> -	 *  less than the max # of CPUs. They should be ignored _iff
> -	 *  they are physically not present.
> -	 *
> -	 *  NOTE: Even if the processor has a cpuid, it may not be present
> -	 *  because cpuid <-> apicid mapping is persistent now.
> +	 *  This code is not called unless we know the CPU is present and
> +	 *  enabled. The two paths are:
> +	 *  a) Initially present CPUs on architectures that do not defer
> +	 *     their arch_register_cpu() calls until this point.
> +	 *  b) Hotplugged CPUs (enabled bit in _STA has transitioned from not
> +	 *     enabled to enabled)
>   	 */
> -	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> +	if (!get_cpu_device(pr->id)) {
>   		ret = acpi_processor_hotadd_init(pr, device);
>   
>   		if (ret)

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

