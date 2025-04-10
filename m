Return-Path: <linux-arch+bounces-11380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC220A84785
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B289170A42
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538671E5B93;
	Thu, 10 Apr 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pPUwqlOB"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA115B135;
	Thu, 10 Apr 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298163; cv=none; b=b/9O2qFhQlunX27UxmWAGstWOTmhtc13LHhV2yyDhDfpMz7BOA9YLnr+we8ZqY9hO2SyqIK7wXg3Y/fC0eeGxJ30dKBr3xoq8R/kwqEuObpBNRU1AOIXZ+Z5fjdCqv95dccKOeZ46GJHiT/hoGI3tmrXhXwhQSgT9fJMerAJhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298163; c=relaxed/simple;
	bh=FJiKHY0yXYvYpnwTi6b4QY4wSVLzbkccdNokb8K2uZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snCZJ9I/aHDcMjrS7VsTzv98j0ny5jfJj0i26N9kmJzfQOTX3vs0RBK7vAN/rqsVeWlH7254WoREOhcNPovxqsiYdmAq5s/mXQGwIgx552W8zHrd7rEGV+cRMUC5MKLOpFG6y9+Yqux9+cF+z1byt3BBSpCZ7yW/Scyh8KaYSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pPUwqlOB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.159.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA497203B86C;
	Thu, 10 Apr 2025 08:16:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA497203B86C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744298161;
	bh=b/USx7FyrAAP0KVFJIR3S9nGQoNXd7rpnvG6sRwEcjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pPUwqlOBrIErhRnMenQuuETY6McFAU1X0L10gqqB+/k7VCThivMB270N9MVPVqKZv
	 OKxIXSvIKMZxOqZulERNSc4wZJRTLL80Ml0pDUeMCwWwOhmkq4niN8+MWNU6gCLoNP
	 iRC71M6wjwxVnS1zZO8WpZAJaxORmPm0mctceOLU=
Message-ID: <e169cb52-8f2d-4ac5-b667-87c3357c11a7@linux.microsoft.com>
Date: Thu, 10 Apr 2025 08:16:00 -0700
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
Cc: Robin Murphy <robin.murphy@arm.com>, aleksander.lobakin@intel.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 gregkh@linuxfoundation.org, haiyangz@microsoft.com, hpa@zytor.com,
 James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
 kys@microsoft.com, leon@kernel.org, lukas@wunner.de, luto@kernel.org,
 m.szyprowski@samsung.com, martin.petersen@oracle.com, mingo@redhat.com,
 peterz@infradead.org, quic_zijuhu@quicinc.com, tglx@linutronix.de,
 wei.liu@kernel.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
 <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
 <20250410072150.GA32563@lst.de>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250410072150.GA32563@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/2025 12:21 AM, Christoph Hellwig wrote:
> On Wed, Apr 09, 2025 at 09:44:03AM -0700, Roman Kisel wrote:
>> Do you feel this is shoehorned in `struct device`? I couldn't find an
>> appropriate private (== opaque pointer) part in the structure to store
>> that bit (`struct device_private` wouldn't fit the bill) and looked like
>> adding it to the struct itself would do no harm. However, my read of the
>> room is that folks see that as dubious :)
> 
> We'll need per-device information.  But it is much higher level than a
> need bounce buffer flag.
> 

I see, thanks for the explanation!

-- 
Thank you,
Roman


