Return-Path: <linux-arch+bounces-3903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894D98ADD67
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B892D1C21661
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8038225D6;
	Tue, 23 Apr 2024 06:18:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00018AED;
	Tue, 23 Apr 2024 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853091; cv=none; b=WwaQiRMCbqdjBBz1EBcgHdHqvGbEzVnyMe/Es2iZcXMLLOcSgVxtcr4j62th6qu+roR7L5LY5gCc/pg6mME1IXbU9FcVvECkxcvhzfmPvqshGOPbroDyB1HpL54ptfdmcT7nX0gcnnHJVfCOHI41ssbzT8ki8AhjG7e4J8wKmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853091; c=relaxed/simple;
	bh=a7a1rN9kNf6WGRL3kJeNoPiIhGtMJivIOtqJ86BB3Tc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kGEYlDNMfAO6fbNcQ5lwfknLdPweZu2BGVYK/ESsPf5vZuhWXOJALkFS0YKo8yVA/YzMijYnheoqWkkY9hcenByXHo/608uVzRG/CHG/WlGjLfbYVahXQ3StoLeG6xKpeWzjsU2qYbACLc/Nt51sv+FTN8+auxerCICycpK9LnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VNsKk0zmqzvQ5C;
	Tue, 23 Apr 2024 14:15:06 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 3ED3018006B;
	Tue, 23 Apr 2024 14:18:06 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 14:18:05 +0800
Subject: Re: [PATCH v7 01/16] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
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
 <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0ec78ec2-636d-c7b1-4265-7cffa88765e1@huawei.com>
Date: Tue, 23 Apr 2024 14:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/4/18 21:53, Jonathan Cameron wrote:
> Separate code paths, combined with a flag set in acpi_processor.c to
> indicate a struct acpi_processor was for a hotplugged CPU ensured that
> per CPU data was only set up the first time that a CPU was initialized.
> This appears to be unnecessary as the paths can be combined by letting
> the online logic also handle any CPUs online at the time of driver load.
> 
> Motivation for this change, beyond simplification, is that ARM64
> virtual CPU HP uses the same code paths for hotplug and cold path in
> acpi_processor.c so had no easy way to set the flag for hotplug only.
> Removing this necessity will enable ARM64 vCPU HP to reuse the existing
> code paths.
> 
> Leave noisy pr_info() in place but update it to not state the CPU
> was hotplugged.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change.
> v6: New patch.
> RFT: I have very limited test resources for x86 and other
> architectures that may be affected by this change.
> ---
>   drivers/acpi/acpi_processor.c   |  1 -
>   drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
>   include/acpi/processor.h        |  2 +-
>   3 files changed, 14 insertions(+), 33 deletions(-)

Nice simplification,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

