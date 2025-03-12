Return-Path: <linux-arch+bounces-10690-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5AA5E668
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5089618979F7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C401EF081;
	Wed, 12 Mar 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pm3SSAYs"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D161EC00C;
	Wed, 12 Mar 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814470; cv=none; b=mqNg+Ibf1+Tw3x9kU9X6EXE7PhVy2hn4GXi9IFZuUwAXdqm3qyiRqr89A9p9kSwp91epwOBMXGME1LKBQBWIx1A89Tfug0hXrKENEqoN05SdRkM1VVYfN2rnBq/u3/hDPao8xTzdVr0CXodWq2XLtb3l+KYVQMxubdyf00fqPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814470; c=relaxed/simple;
	bh=8lk79mDnF9WAaI75FvC+bpLneGj3wkxAcWyHOCuXSjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVexfv4tTndPAZeOpRyvfKJTmGbo2EqBK3lP7F3WSKSWvSzquPlKXny7A1HpPXFC3zK62UFvYJb01AwZamTXmRP6+fMVcQTTShkF7IpVdOF6mHrLKL5dgWPDZk4dcn8WULL0KS7oaROtMuRQcOPNqtmGrWBOqkkgfKpBJag0a2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pm3SSAYs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86B37210B157;
	Wed, 12 Mar 2025 14:21:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86B37210B157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741814467;
	bh=MgNM2rD8/EOf05M0lP85WV+gCmyNEYHLXXzpOfe5KVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pm3SSAYshDZ0/J9DAnDCCWIg7IAiMKcF9WebEeevzy98VYIaLbtZxz8W0R4oz5bs3
	 bx8W1PNJ4LBZ4FkX6cjdoD9OOn1KNZkGtH27nqPcPfkJxVFnXRqfUmYBYdXIJxg7dQ
	 dkyAwa4NZs8ZWgWM4ZixgLD18JrAFkhBHsI7/1wQ=
Message-ID: <996deaab-e1d1-4f04-ba31-c0dcab2d5e1d@linux.microsoft.com>
Date: Wed, 12 Mar 2025 14:21:07 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
To: Arnd Bergmann <arnd@arndb.de>, Michael Kelley <mhklinux@outlook.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Joey Gouly <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
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
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
 <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <caa0d793-3f05-4d7c-88d0-224ec0503cfb@linux.microsoft.com>
 <45171fb1-7533-449f-83d4-066d038c839f@app.fastmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <45171fb1-7533-449f-83d4-066d038c839f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/12/2025 1:25 PM, Arnd Bergmann wrote:
> On Wed, Mar 12, 2025, at 19:33, Roman Kisel wrote:
>> On 3/10/2025 3:18 PM, Michael Kelley wrote:
>>
>> That's a minimal extension, its surprise factor is very low. It has not
>> been seen to cause issues. If no one has strong opinions against that,
>> I'd send that in V6.
>>
> 
> Works for me. Thanks for your detailed explanations.
> 

Thank you for your review very much!

>         Arnd

-- 
Thank you,
Roman


