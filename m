Return-Path: <linux-arch+bounces-1921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518F844285
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F20F1F21914
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0B1350E4;
	Wed, 31 Jan 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="spdpNVJY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF182867;
	Wed, 31 Jan 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713105; cv=none; b=BGSosTHxLZp4tZonSzQQfQuuHNW1nG77EwIs7TR66xXSa8mHN+1B2O3z4zC0IlufSKMkl4HZiixTrmTj04Vfz30t7wT810yEQRjviKKn64jnFh09Hz3uR14JgJH5GdNpEwQ1ziweF19lYLKaxjKfgLs9IsUNF8ITNRbYcYUZIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713105; c=relaxed/simple;
	bh=L5pJpQ5dE+OFLWNsblvXxIVZo1jX7Zp/Itn5Bx1Ke3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjERpk64LxZ9rSoS9nPdUe7VOnw1L8OLjqh12eQR4yQpow4n/Qv9tHgej5UQ1qI8jLYazsFQY7m62fcjhwhVW117xVff58Q+s25u90PQxP4DO+LHgiZfQsUeQamDGRl0sGygogIsenyC85LeuQ+x8+Zb+SZBybM0SnDdjFLbbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=spdpNVJY; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706713101;
	bh=L5pJpQ5dE+OFLWNsblvXxIVZo1jX7Zp/Itn5Bx1Ke3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=spdpNVJYLB/Vcpi2FIvZnu7EVWB4/kO/4rDcNA2wvudacQT/We/qyugueJ7Ca1Kci
	 SY8L9mJYTSYWYc1wGpXhTI2UK6GcikePPY16a8v+Nzrmi74ZzUlC3DoB1avnIkjQtF
	 TR+Yp+tT6s0xzO64pJ9E7FlIOoBOWUeiZCT6Hbl8N05ksoGZJfU8vFXpDfj5k556My
	 8EBMzBtWAdsmMFiakP9EeuR5f6Ve25VYI7mbnl0dVPWMdjZB6QWwpQ+nLL3pV7HaR5
	 YX28OXtDEzVik25xabjPMkt68wwozSeLQAJXiSbWZ6QIPhBo3K79Y/06/NDpRx0LMt
	 S20GCkIrCleKg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ4sn1wYGzVrS;
	Wed, 31 Jan 2024 09:58:21 -0500 (EST)
Message-ID: <d30a890a-f64e-4082-8d8e-864bfb3c3800@efficios.com>
Date: Wed, 31 Jan 2024 09:58:21 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/8] Introduce dcache_is_aliasing() across all
 architectures
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-8-mathieu.desnoyers@efficios.com>
 <Zbm1CLy+YZWx2IuO@dread.disaster.area>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Zbm1CLy+YZWx2IuO@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-30 21:48, Dave Chinner wrote:
> On Tue, Jan 30, 2024 at 11:52:54AM -0500, Mathieu Desnoyers wrote:
>> Introduce a generic way to query whether the dcache is virtually aliased
>> on all architectures. Its purpose is to ensure that subsystems which
>> are incompatible with virtually aliased data caches (e.g. FS_DAX) can
>> reliably query this.
>>
>> For dcache aliasing, there are three scenarios dependending on the
>> architecture. Here is a breakdown based on my understanding:
>>
>> A) The dcache is always aliasing:
>>
>> * arc
>> * csky
>> * m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
>> * sh
>> * parisc
> 
> /me wonders why the dentry cache aliasing has problems on these
> systems.
> 
> Oh, dcache != fs/dcache.c (the VFS dentry cache).
> 
> Can you please rename this function appropriately so us dumb
> filesystem people don't confuse cpu data cache configurations with
> the VFS dentry cache aliasing when we read this code? Something like
> cpu_dcache_is_aliased(), perhaps?

Good point, will do. I'm planning go rename as follows for v3 to
eliminate confusion with dentry cache (and with "page cache" in
general):

ARCH_HAS_CACHE_ALIASING -> ARCH_HAS_CPU_CACHE_ALIASING
dcache_is_aliasing() -> cpu_dcache_is_aliasing()

I noticed that you suggested "aliased" rather than "aliasing",
but I followed what arm64 did for icache_is_aliasing(). Do you
have a strong preference one way or another ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


