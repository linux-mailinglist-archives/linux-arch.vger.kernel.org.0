Return-Path: <linux-arch+bounces-10658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72031A5A67F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2061C1891C21
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA831E51F6;
	Mon, 10 Mar 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="McgzG9DD"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B31E1A3B;
	Mon, 10 Mar 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643658; cv=none; b=BTlIM4lJcytjoZpP/zMupEw0xx+hXAAclc0r+deDaqS3XBTMgYoFKItTkGZxN3MaX/Z0rFJ1qx37AiIJgV8RWqqN2E+DQsh8ZVrrL1LGeM7B8JBt2FU9nBWvx3EFXE/2vabMpmF6ZiwQDsugI6rR3EU+7sY/D/BPqu3gkctFj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643658; c=relaxed/simple;
	bh=et/pdKFP+xbz0ie0UenwlW3LyYpkTB1+CTlrZCSRz0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yu6TRuZbzGkduJvmZTBAomjvAMEobyzE2ZyYkNcaeUKBxgW2QUIcVPm5Chza4QiJvDItDukqIDQy/i5YSwbE2crCNaY4E7XI0CaZZQOun7WmsD1oD/k0PVDfMyOj7rgloaYOSdzM2GYUbrsnSxEVlrkflu6eG2T9UVPOHLGbQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=McgzG9DD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 15DAD205492D;
	Mon, 10 Mar 2025 14:54:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15DAD205492D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741643656;
	bh=Q/Uol1uipNTEM+J17AFsSpdT73eLsQ4d8Vvzl/nmsl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=McgzG9DDr6wUujEwBpMK6suD9qJbrij6gjrcnO6q78gHuFDI4Yr4Tspg3OQhzXnvy
	 ZBcTeYtfuccZ9RLNcrdoJVs3fmZPUyV/lIGeyh9OJnGPJJ8tlNKBYhrfODMjRGfclv
	 IMuXMlRQZ/ulJ9+Rs7PP9zZSHIssAH1Tc/M/SXWc=
Message-ID: <28970d64-40b7-408a-a072-c3449d3de08e@linux.microsoft.com>
Date: Mon, 10 Mar 2025 14:54:15 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 01/11] arm64: kvm, smccc: Introduce and use
 API for detectting hypervisor presence
To: Michael Kelley <mhklinux@outlook.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "maz@kernel.org" <maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-2-romank@linux.microsoft.com>
 <BN7PR02MB4148539DEFFF5ABA42AB44D3D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <BN7PR02MB4148539DEFFF5ABA42AB44D3D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 2:16 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 2:03 PM
>>
> 
> In the Subject line,
> 
> s/detectting/detecting/

[...]

> s/cenrtal/central/
> 

My bad, will fix! Thanks for spotting that, I'll be sure to have
the spellchecker on.

-- 
Thank you,
Roman


