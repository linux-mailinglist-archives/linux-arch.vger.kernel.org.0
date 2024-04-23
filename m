Return-Path: <linux-arch+bounces-3904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155758ADD74
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 08:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEDB23345
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64124B28;
	Tue, 23 Apr 2024 06:22:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729424B23;
	Tue, 23 Apr 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853337; cv=none; b=kst76Jw2nBIAniUrF3Crfa15vAcvlYqNWVJmk1r4mVH85kY7BT9xQ7OwIf8o0sZsoWURFL/ZGU7sKuMUul2f5x1gcripFn+hr22qbnNc7/8NxdTIluTpK0cHVnC6dWYGSYeJP+ebCmrofctaD7DkpbfB9/yGcnVOADBuCmfte7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853337; c=relaxed/simple;
	bh=DKoT7BMoGVPNdwMs/lk7idD2NHilETaVsqVtGIKyMtE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rkf1nspxmgOeaCQE6CJApWMLYOSHSjmhmlXVsHd+Kb/ay4jc2yNJxmU9mOV1hheARFPnTJ8BOGttSFmPEpJWkaK+0qrQm+CHcXFXQ2XILPil+RVWgvLVkNPVgSCHVtS4fD3CFjsrSN/Sq5LetbK7uJYvjBOYTMB6bSN5YojiuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VNsQP3WfJz1j0tK;
	Tue, 23 Apr 2024 14:19:09 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BE5414037D;
	Tue, 23 Apr 2024 14:22:12 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 14:22:11 +0800
Subject: Re: [PATCH v7 02/16] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
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
 <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <20b7c778-68c0-9ba3-06fb-61194ed3e04e@huawei.com>
Date: Tue, 23 Apr 2024 14:22:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/4/18 21:53, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI
> interpreter us up and running so in those cases the arch specific
> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: Fix condition to not print the error message of success (thanks Russell!)
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 56fba44ba391..7b83e9c87d7c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
>   
>   	for_each_present_cpu(i) {
>   		ret = arch_register_cpu(i);
> -		if (ret)
> +		if (ret && ret != -EPROBE_DEFER)
>   			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

