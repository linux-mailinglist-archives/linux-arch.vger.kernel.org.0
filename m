Return-Path: <linux-arch+bounces-3885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C98ACB28
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A14B210E1
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEC8146A6F;
	Mon, 22 Apr 2024 10:44:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D31465B7;
	Mon, 22 Apr 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782692; cv=none; b=KPivesD5vnZACg3ieTzLakBnYUH5TP8YnccFhcUp5F/DBi6aDjFE7nlMqI1aUEbmPN/y2/vnHtOWYC4gCMWxJ1h2XIDn22eWeW4OyoZ5duSIAVOGq+NUnyQ6zVEmtQ6ZH6xDNJUThZUv96C/MEYjww5mrephMMm6A3cES3IbcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782692; c=relaxed/simple;
	bh=LQOyJBwa32Rwknql+J5ecVpfiOY0Le5C4/h4EPSQHzA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b714lZSffL+77drz8cKvjG1Z2hb3chPbnqGyNvdJTE3d/7QQYdBQPHG8VLEYKHklqVC1Zl0UQObVCqbH4LbFgROxaQefwhGp02DbiTaCNyYc5FvnOpX/qPgSdfX1lJUBC+0NFUWy4McgVc0gejZKsGE+oAJ8nKhQOdiq+MrOGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNMJn61WCz6JBSj;
	Mon, 22 Apr 2024 18:42:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 61C63140AB8;
	Mon, 22 Apr 2024 18:44:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 11:44:46 +0100
Date: Mon, 22 Apr 2024 11:44:45 +0100
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
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linuxarm@huawei.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 12/16] arm64: psci: Ignore DENIED CPUs
Message-ID: <20240422114445.00003047@Huawei.com>
In-Reply-To: <20240418135412.14730-13-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-13-Jonathan.Cameron@huawei.com>
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

On Thu, 18 Apr 2024 14:54:08 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a CPU is marked as disabled, but online capable in the MADT, PSCI
> applies some firmware policy to control when it can be brought online.
> PSCI returns DENIED to a CPU_ON request if this is not currently
> permitted. The OS can learn the current policy from the _STA enabled bit.
> 
> Handle the PSCI DENIED return code gracefully instead of printing an
> error.
> 
> See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [ morse: Rewrote commit message ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Focus until now as ACPI side of things (hopefully we are now close on that)
but upshot is we failed to +CC some other relevant maintainers.

+CC Mark and Lorenzo - Not 100% sure who is right person for this, but
PSCI in general seems to be your problem.


> ---
> v7: No change
> ---
>  arch/arm64/kernel/psci.c | 2 +-
>  arch/arm64/kernel/smp.c  | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 29a8e444db83..fabd732d0a2d 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
>  {
>  	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
>  	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
> -	if (err)
> +	if (err && err != -EPERM)
>  		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
>  
>  	return err;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4ced34f62dab..dc0e0b3ec2d4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -132,7 +132,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	/* Now bring the CPU into our world */
>  	ret = boot_secondary(cpu, idle);
>  	if (ret) {
> -		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> +		if (ret != -EPERM)
> +			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  		return ret;
>  	}
>  


