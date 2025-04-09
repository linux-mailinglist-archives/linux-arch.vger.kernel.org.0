Return-Path: <linux-arch+bounces-11361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326EA82A80
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 17:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2503A189BCCA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BA26739D;
	Wed,  9 Apr 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HiVZXeJW"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEFF265CB5;
	Wed,  9 Apr 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212445; cv=none; b=NvDyPNo/8fnmvT3zfYye2iarSV530za+YXyHBe1gcjH3GU+33jw7DfIvfpr3A6kHaUeXlxx7vmXL2f171wJLHZJEMaugKcvEyfmCpGDAhz4/tC7+//GfYDGsfpse1y2EWRZRnWuESSLJfPK7jnVBYyCx82MhpBSE8oPF9BGG/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212445; c=relaxed/simple;
	bh=X3NxPrh/Dg6zmeDRgnBwY1KySOioOX8BKWZl/rmzgB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFMLnP+b4A9yvlRv5bbePu/bYATYdOjM5l5ano+QTK8W36yNAg19LQg2VUyCJ5FdV6L9A9H2SHbd+GtAKObF0+VyRhDVp/7aaQvejHQqtlIi+NKTn8dumGeSGncc5aWCflMT8nk2NfsvGnxTHnLOPNpTy9jv463lSdUfpkGmI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HiVZXeJW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A0262114D8A;
	Wed,  9 Apr 2025 08:27:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A0262114D8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744212443;
	bh=UjQX7nAQGu8VWkUrRyRpYAcZbBxisvkDjd3TARXNRv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HiVZXeJWF7w0t2l/4IF8J5ryv6/ZPUKUQ5aYykBziIutp4bcub2znNWPE/Y1Dh/Ge
	 wPcrUU54yJBi/OX2udWa8QfGVA5UwpUJ3rEDsQtkbu2LYD/m1xFmP6y1gt8crnOdXG
	 kECFhb2Vi1RaczcV6Pkxw/I1DktSimbBtg4Gwcdg=
Message-ID: <b56eef68-367d-4b7b-98c4-f5d1291d7993@linux.microsoft.com>
Date: Wed, 9 Apr 2025 08:27:22 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct bitfield
 to not bounce-buffer
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
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <20250409105229.GA5721@lst.de>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250409105229.GA5721@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/2025 3:52 AM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 05:08:34PM -0700, Roman Kisel wrote:
>> Bounce-buffering makes the system spend more time copying
>> I/O data. When the I/O transaction take place between
>> a confidential and a non-confidential endpoints, there is
>> no other way around.
>>
>> Introduce a device bitfield to indicate that the device
>> doesn't need to perform bounce buffering. The capable
>> device may employ it to save on copying data around.
> 
> I have no idea what this is supposed to mean, you need to explain it
> much better.

Thanks for reviewing! I'll fix the description.

> 

-- 
Thank you,
Roman


