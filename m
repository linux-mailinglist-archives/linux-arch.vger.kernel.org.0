Return-Path: <linux-arch+bounces-10253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B6A3E133
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D16E860A08
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038D20B81B;
	Thu, 20 Feb 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RfNgWwSK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758A20B812;
	Thu, 20 Feb 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069717; cv=none; b=e/ihQzpkQ3R0wdAVeXKJFKzz5kB3lBpJMyVllEWw09dQnQUAiIlGW1JZubumRht4B7y7UJGdTFkBhi0pZd/tWxBwSYCSwr3Zj9AO484JuOEXPPitZfeneeFNlP6b4rOEJLBs4vxW51A7/S7vSyOEmX48GGnFjsKqOUzSfRnwRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069717; c=relaxed/simple;
	bh=TYfO4NMFHURGbPNs1cXbVVlPxLhwPSr2YHLvwtMjhy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfVsm20NTzoP24EQd3M8UGi1T/JHVzvfvHBNCjhRHTUGcBaP313EMYYrk2mNfkEsTBtTqrQ2AZjMF6cnb/wUt8xqLsX6OYd/O0duZMpSkKmiuOenhibsghHmXV94b8vrtpLC7C3OaMMki56/A+8biweE1xROHuk3QibOSXLsziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RfNgWwSK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A0F8203D5E9;
	Thu, 20 Feb 2025 08:41:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A0F8203D5E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740069715;
	bh=pNJT56BxP7UvWA0Xz758yN9Ks+B/eGQRDTpNl6/uydA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RfNgWwSKvEiPibsl6QYn1+eHkT30Nn1lw5OPsw1d6PPbcISNOFjUL/xQSqvKSFf8o
	 yoOIzOPYQSxDpQlLZwzRdyB7IKxJeSJ80SjCCl6Rmtksk16rj7gF1Vbsd9EZG8Perr
	 ZiNK0h99Ko8rPXUvLfCrhbWuuKMw7GXCc7mIDVdc=
Message-ID: <13059366-bf72-4e84-ab6c-032b735edaec@linux.microsoft.com>
Date: Thu, 20 Feb 2025 08:41:55 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 6/6] PCI: hv: Get vPCI MSI IRQ domain from
 DeviceTree
To: Michael Kelley <mhklinux@outlook.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-7-romank@linux.microsoft.com>
 <SN6PR02MB4157911BEF8664EDE2B62835D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157911BEF8664EDE2B62835D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/2025 3:29 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, 2025 5:43 PM

[...]

>>   }
> 
> These changes to rename hv_dev to vmbus_root_device, along with the
> introduction of hv_get_vmbus_root_device(), seem like a separate
> patch from the vPCI changes. The rename is definitely needed because
> "hv_dev" as a symbol is very overloaded. But the rename is "no functional
> change", and it doesn't touch the pci-hyperv.c file. You don't have a
> consumer for hv_get_vmbus_root_device() until the vPCI changes, but
> that seems OK to me to be in the subsequent patch.
> 

Thanks, will split the NFC out! I've asked the ACPI maintainers if a
small change in ACPI would be fine to make the functional part of this
patch more palatable, too.

-- 
Thank you,
Roman


