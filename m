Return-Path: <linux-arch+bounces-13237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A569BB2E455
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECF4722AEB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A426B75C;
	Wed, 20 Aug 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0bnL8T2y"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08896258EDD;
	Wed, 20 Aug 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711862; cv=none; b=jZ74kGe4E8URwwnpoeTH70KZiTyHb8SkaiLd6cn/AVwdDDYfQsyR8IdmJmWn1YlzcA2ZtCbBJPPZTQP4qNnzy+Uh8fgUt4KyAuMM2usgJJf2J2dY7I7T7FyKU87+dyclepPJq0j7Bzge3uOc+xVFR0J1G0KHIPVJxM00ei+Wke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711862; c=relaxed/simple;
	bh=KdiDUstdHQrni4Yr7Jvhf1893eG6oulvykElyBviLoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwS0pBEN+Q49OZKsk46Vg3qjYpvx1vukiq+POWlxdZQF+HXI+JDWnABImP3QUsXEeJoMQv48H0QjdOQnVHKlk3kAiaM8PCUKTxldRE9zj4OzxuDy0QMWGVx0gtHTXNnhszuJiBDPPk9YpBNQEPIFvaUhAuBQOqIvvQGcwSnUhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0bnL8T2y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YxAG2wevlF9hvSfOpG1gi4gKf2kHDvkSjadttXruPpE=; b=0bnL8T2ybDOrHa+Py3KB+20XsQ
	krFSkRJ/lGSHI9KlQ0qlkdhK+qS23YBluLAvVOyoBvbJO/SbTCQXDRBwJo0tZ+Cp1m4DSS1z7XGDT
	bq75CSkTotCMGqtD4tBJ7i8YIpE632ix5UOtckpT48GQey1yMweypKEPi1eouIUYb+w6RTQ0TeOYI
	wwoHU5dIl+eMuf1/t1xis+rSnKTjBKynLeo+mDeoVyVPXnDdZUOyF4W1BgoI2zlm/SJELWzpgpvX9
	8tvSWxDqv45x4EHLAoK02HGSqLAaZNADQVCvJUVy3JC9HhNc1ybuyAFZufFH2NHAbbXOxL6igBxc6
	4N59ti0g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uomrD-0000000Eaag-3xcU;
	Wed, 20 Aug 2025 17:44:20 +0000
Message-ID: <a68bf620-14b5-4500-8cb9-26a7b28af058@infradead.org>
Date: Wed, 20 Aug 2025 10:44:18 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
 linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
 Yushan Wang <wangyushan12@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-4-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250820102950.175065-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 3:29 AM, Jonathan Cameron wrote:
> +struct cache_coherency_device *
> +_cache_coherency_device_alloc(const struct coherency_ops *ops, size_t size);
> +/**
> + * cache_coherency_device_alloc - Allocate a cache coherency device
> + * @ops: Cache maintenance operations
> + * @drv_struct: structure that contains the struct cache_coherency_device
> + * @member: Name of the struct cache_coherency_device member in @drv_struct.
> + *
> + * This allocates and initializes the cache_coherency_device embedded in the
> + * drv_struct. Upon success the pointer must be freed via
> + * cache_coherency_device_free().
> + *
> + * Returns a 'drv_struct \*' on success, NULL on error.

Preferably:

 * Returns: a &drv_struct * on success, %NULL on error.


> + */
> +#define cache_coherency_device_alloc(ops, drv_struct, member)	    \
> +	({								    \
> +		static_assert(__same_type(struct cache_coherency_device,    \
> +					  ((drv_struct *)NULL)->member));   \
> +		static_assert(offsetof(drv_struct, member) == 0);	    \
> +		(drv_struct *)_cache_coherency_device_alloc(ops,	    \
> +			sizeof(drv_struct));				    \
> +	})
> +void cache_coherency_device_free(struct cache_coherency_device *ccd);
> +
> +#endif

-- 
~Randy


