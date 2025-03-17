Return-Path: <linux-arch+bounces-10921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B27A65AD1
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB2C3A9269
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07F1A76BB;
	Mon, 17 Mar 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qW//4OF7"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3587B1A2860;
	Mon, 17 Mar 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232520; cv=none; b=eod61DNMkTrrdIQMz8OhpEW7rDoSFgNN06eXtp2zlTXzsTYYY0fnTYyAeDLZCMdKv0vrhItd93ubNnVXy92hf536XbtWmxdVkFSoHLaytxqu2PjQ8+Xyo3P6NxnRw5s1sVk/jXziAPXVNxzLIgCuqBuo8oToJ5tuVJDCbBivNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232520; c=relaxed/simple;
	bh=HgPy2MVKYIb+/rPyka6akjIQhM6Dre9PhzaEo/M1Oi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh5/tleOl3ZcNvMhZEsqikDVA8LVyGpgvLcyTQeCZGIkyg/hiWy9emut/Uf+OyoiU2p//m8n7tWlT04oIGlex5roRIFL09JrSyZG2eX937O/8Ab75RQApJQfTN5U90RATUsZ6RfqRsa5zlvyqcLhEqWs7Z4xch8j6+NAI+0qpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qW//4OF7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 55E892033444;
	Mon, 17 Mar 2025 10:28:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55E892033444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742232518;
	bh=YMfowKBMnXKcm1mHwfTnIc3m4wrvseXvS07OkG54pgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qW//4OF7eJr0KsFfmdhpzFvcdq0RAq9/HGXEIVUGIiz0XlLXWifohTbu+e6MEtFZG
	 k/KtMNYFCdC8M3ybw+MkjaOtxWZOJDsFbqgALENs2EiKm0gd6js37TYj0kU3wDxAFC
	 w03VOm4OQbzyTqPvS78AfTHSYqjGmXqnza+N3+wk=
Message-ID: <238beef1-16d3-4c72-ac7f-7d578ab8fc3d@linux.microsoft.com>
Date: Mon, 17 Mar 2025 10:28:38 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 01/11] arm64: kvm, smccc: Introduce and use
 API for detecting hypervisor presence
To: Arnd Bergmann <arnd@arndb.de>
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com, bhelgaas@google.com, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Joey Gouly <joey.gouly@arm.com>, krzk+dt@kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 ssengar@linux.microsoft.com, Sudeep Holla <sudeep.holla@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-2-romank@linux.microsoft.com>
 <96bc4caf-b79a-4111-bafa-a7662260f4be@linux.microsoft.com>
 <50ec2615-97cf-423d-bfe6-f65092a14348@app.fastmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <50ec2615-97cf-423d-bfe6-f65092a14348@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/15/2025 6:12 AM, Arnd Bergmann wrote:
> On Sat, Mar 15, 2025, at 01:27, Roman Kisel wrote:
>> On 3/14/2025 5:19 PM, Roman Kisel wrote:
>>
>> While the change is Acked, here is the caveat maybe.
>>
>> This patch produces warnings wtih sparse and CHECK_ENDING.
>> That said, the kernel build produces a whole lot more other warnings
>> from building with sparse by itself and/or with CHECK_ENDING.
>>
>> I am not sure how to proceed with that, thinking I should
>> not add warnings yet at the same time there are many others.
>> Not certain if folks take these signals as fyi or blockers.
> 
> It would be best not to add warnigns. There is slow progress on
> fixing all the endianess warnings and I hope this can eventually
> complete, so even if there are many existing ones please try to
> keep new code clean.
> 

Will fix the warnings, appreciate providing the guidance!

>       Arnd

-- 
Thank you,
Roman


