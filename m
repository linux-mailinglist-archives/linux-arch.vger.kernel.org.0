Return-Path: <linux-arch+bounces-11383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64FA84C97
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3603AE847
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2F28EA4A;
	Thu, 10 Apr 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P7hSa02M"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901628D83E;
	Thu, 10 Apr 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312233; cv=none; b=cE4BR3cNUrN98s78m6dAO32sQGF+nH4ZCXwR6yAk1kdjXVzcz1vbZttss7FlFLgB54egFDzU9nJkt6tFTh2jd1nhjw3GunbBD/j0miY7VGIfs8+agaPdogQPPe/w5KP6nV9XVlHrRrqZNYLBhUVxKPWmEpk0pt5VpDetvn5MFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312233; c=relaxed/simple;
	bh=MwU13Bp26U6V3maPsnG2tuN0xljevYyWsfzq1qfrCS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXXbWmfkonJGg7LmRgfG0lEyhLx7gWsEnRitxy8D/BXE+Mmtra0+nwWxOv41dRmBy6GnGA0xFBwzhKEeLDq82g3VaOrvVLPyl2rTQlrZHQ9d2I8aJwP5KzwbcGv7JfttZ4+GQ1cjShpp83fC7HhuJVsIo1eePvWDnRgvLA740CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P7hSa02M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.159.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B95962114DA8;
	Thu, 10 Apr 2025 12:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B95962114DA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744312231;
	bh=GIf52GlovbvkGrmF0yuwN/3vnWv6uH/x4VM7bLG+QCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P7hSa02M3iPJfwyVRh9ul8Qqg3w3S9nzYdXt1Jguz+zzE2jU7vdU4NAeqNKF9CJpV
	 SLgW6C2o4uN4t7kSkTROtIOX2QqjDT3/uXC+0yxmK45wBRqoJVxJonTcXFFAeY59o2
	 mMrZ3NYMSyQOYMfz6rugX2MXe3gTtYW6AzauSq5U=
Message-ID: <fb7de79c-100c-4423-a6f5-6f7b9acfccbc@linux.microsoft.com>
Date: Thu, 10 Apr 2025 12:10:30 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 1/6] Documentation: hyperv: Confidential VMBus
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, aleksander.lobakin@intel.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 gregkh@linuxfoundation.org, haiyangz@microsoft.com, hch@lst.de,
 hpa@zytor.com, James.Bottomley@HansenPartnership.com,
 Jonathan.Cameron@huawei.com, kys@microsoft.com, leon@kernel.org,
 lukas@wunner.de, luto@kernel.org, m.szyprowski@samsung.com,
 martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
 quic_zijuhu@quicinc.com, robin.murphy@arm.com, tglx@linutronix.de,
 wei.liu@kernel.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-2-romank@linux.microsoft.com>
 <724f9f7d-137b-4cf5-aff5-bbb9727c23c1@oracle.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <724f9f7d-137b-4cf5-aff5-bbb9727c23c1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/10/2025 9:54 AM, ALOK TIWARI wrote:
> 
> 

[...]

> 
> typo trsuted  -> trusted
> 
>> +To support confidential communication with the paravisor, a VmBus client
>> +will first attempt to use regular, non-isolated mechanisms for 
>> communication.
>> +To do this, it must:
> 

Thanks for your help with this patch, and the other ones!! I'll make
sure to use the spellchecker on the patches before sending another
version out.

> 
> Thanks,
> Alok

-- 
Thank you,
Roman


