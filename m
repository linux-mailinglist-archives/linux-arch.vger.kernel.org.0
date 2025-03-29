Return-Path: <linux-arch+bounces-11181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC51A75491
	for <lists+linux-arch@lfdr.de>; Sat, 29 Mar 2025 08:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFE3AD9CD
	for <lists+linux-arch@lfdr.de>; Sat, 29 Mar 2025 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846F282F5;
	Sat, 29 Mar 2025 07:14:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585EE555;
	Sat, 29 Mar 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743232464; cv=none; b=brFRUl+/ETDuqQgIbe58fFHOOP6IGU6v+MrqOHpvaBd3LloSPeULiw+KLv2IZLF/zjOji92Wq66ikUGimjsiBcVyrNuowgUaWWmeH1/Zpm/S+ZKIfiiuCDnpFFipu2ZePypOof3V/scoiDu9Pa5vHv+8sNZLhnpc/QV/LVjVBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743232464; c=relaxed/simple;
	bh=JSJAaEbxKHrj1mtwJ0nQl9ZXA31VR3uimlpharCw9+0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kbuz1j/RxL5x0/ulJHASnUJbvUoes5siJYu3DAZoPkyorgmdM3oRHacgsXH9/lqWfjNF6hJrJQJ1xmxtrtIb0yyb1VpfMQWmjuaKylvhu849svuLnuq5X4iY6OOkWydoY+9+L1BOIE27z/PE1ilBIsRVVTMxhR84oPBZAqWNCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZPpWQ2TNJztRbD;
	Sat, 29 Mar 2025 15:12:50 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C43E1800B4;
	Sat, 29 Mar 2025 15:14:16 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 29 Mar 2025 15:14:15 +0800
CC: <yangyicong@hisilicon.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <james.morse@arm.com>,
	<conor@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/6] arm64: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
To: Catalin Marinas <catalin.marinas@arm.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
 <20250320174118.39173-3-Jonathan.Cameron@huawei.com>
 <Z-bo7AQ1h6VQr65V@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <64ae0e68-b025-4a33-9389-5393ee887fb4@huawei.com>
Date: Sat, 29 Mar 2025 15:14:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z-bo7AQ1h6VQr65V@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/3/29 2:22, Catalin Marinas wrote:
> On Thu, Mar 20, 2025 at 05:41:14PM +0000, Jonathan Cameron wrote:
>> +struct system_cache_flush_method {
>> +	int (*invalidate_memregion)(int res_desc,
>> +				    phys_addr_t start, size_t len);
>> +};
> [...]
>> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
>> +{
>> +	guard(spinlock_irqsave)(&scfm_lock);
>> +	if (!scfm_data)
>> +		return -EOPNOTSUPP;
>> +
>> +	return scfm_data->invalidate_memregion(res_desc, start, len);
>> +}
> 
> WBINVD on x86 deals with the CPU caches as well. Even the API naming in
> Linux implies CPU caches. IIUC, devices registering to the above on Arm
> SoCs can only deal with system caches. Is it sufficient?
> 

The device driver who register this method should handle this. If the
hardware support maintaining the coherency among the system, for example
on system cache invalidation the hardware is also able to invalidate the
involved cachelines on all the subordinate caches (L1/L2/etc, by back
invalidate snoop or other ways), then software don't need to invalidate
the non-system cache explicitly. Otherwise the driver need to explicitly
invalidate the non-system cache explicitly in their
scfm_data::invalidate_memregion() method. Here in the generally code we
simply don't know the capability of the hardware.

Thanks.


