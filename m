Return-Path: <linux-arch+bounces-11362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF5A82AFE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777BE9A2E3D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48682267B1B;
	Wed,  9 Apr 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Mp2nvG16"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC19026772E;
	Wed,  9 Apr 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213006; cv=none; b=UyP3/2gAnmjCOyWCwrILM/tIMIbFvJ3Bo+f8qnNi+D3ZFYoaGob0UG1RC4pCDteHqYhPp9F4toJlWsjQOUqtKcGkhmFUy7zpvC56IDbhw1VnKPWnbduiTqxtE1V+5OyF20dj/9FiivLwodNQelX/97p1eBbDNvp/4K9EOlFJYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213006; c=relaxed/simple;
	bh=mra/8qKW0Evjk3Ofx4vXnWBF0Y2y8/XWWI9ZGtde6nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmW36qKip7sFPc5Es4uZVRujFmroYvsI9BoKkGkQy/umo4yi/kW4frENrBTnc8JIhk4/Iwy/PRo6xeB6seVqCC1j3ttuBOdMAR16M+DNoqPj3xZqt6lykY+cNFT0zKA1gvRsDg6htKVPiTrK7fDKrfd4AAWqoVgxxg7Ufq4mfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Mp2nvG16; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC5202114D83;
	Wed,  9 Apr 2025 08:36:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC5202114D83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744213004;
	bh=STjRVpgg0Yp0bRazVRJxjrVKHPO2bSZ4lShot4vAUzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mp2nvG161guzkA5jkhuWIpYyBT04WkL0edtyczcFZXoq8eK8Ezwe8HEmiBEcfvDCy
	 deajHxHYyWZU7h7pWiFKRJXXcUnyRylUnG5vNOAzszEOLLM9KKKiWnfuRP81BheV+I
	 WY2pVGQeqqiyxm/f+Q6cp3ADRSs3IuXWn24zdJDY=
Message-ID: <d8876120-5478-4d2f-acad-b0a59261bbc5@linux.microsoft.com>
Date: Wed, 9 Apr 2025 08:36:43 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 6/6] drivers: SCSI: Do not bounce-bufffer for
 the confidential VMBus
To: Christoph Hellwig <hch@lst.de>
Cc: aleksander.lobakin@intel.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com, corbet@lwn.net,
 dakr@kernel.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com,
 decui@microsoft.com, gregkh@linuxfoundation.org, haiyangz@microsoft.com,
 hpa@zytor.com, James.Bottomley@HansenPartnership.com,
 Jonathan.Cameron@huawei.com, kys@microsoft.com, leon@kernel.org,
 lukas@wunner.de, luto@kernel.org, m.szyprowski@samsung.com,
 martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
 quic_zijuhu@quicinc.com, robin.murphy@arm.com, tglx@linutronix.de,
 wei.liu@kernel.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-7-romank@linux.microsoft.com>
 <20250409105332.GB5721@lst.de>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250409105332.GB5721@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/2025 3:53 AM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 05:08:35PM -0700, Roman Kisel wrote:
>> The device bit that indicates that the device is capable of I/O
>> with private pages lets avoid excessive copying in the Hyper-V
>> SCSI driver.
>>
>> Set that bit equal to the confidential external memory one to
>> not bounce buffer
> 
> Drivers have absolutely no business telling this.  The need for bounce
> buffering or not is a platform/IOMMU decision and not one specific to
> a certain device or driver.

Seemed to work although I cannot claim nothing is going to be broken
ever. It did appear from the code that one could have this per-device
bit.

As I understand, you're saying this is architecturally broken. Do you
think a broader set of changes would improve the implementation?

> 

-- 
Thank you,
Roman


