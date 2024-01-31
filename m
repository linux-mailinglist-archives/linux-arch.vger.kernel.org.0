Return-Path: <linux-arch+bounces-1920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC98441B2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 15:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367061C25F31
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA77BB02;
	Wed, 31 Jan 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z01Ot9+m"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491F81ACF
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710813; cv=none; b=NWNBlCggJ/miidsCtZh7sOnbZTcUgDtQEARzgNXUgejVNlBShqJ1gkxPYZ0TzWZLc8bA+ByHyKdM8jcFKH4k5ldtamYsQxs5r+muGugeL5ZEqrD4j9Dt/tSJz/w616R0m23ogmnAe3KdcUkLCjXWwUnn70hvSu9ikus4hPLdWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710813; c=relaxed/simple;
	bh=IL1GPoNzL7QSd5vUAqTFQj0vKy+cgDd6bxQdbYB88ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx4YgEHWpyuxTRqYHTj0uTNkG9cPAp0HLFoWFdR9GlFZIJCg6+msgLi674JuACZ/V0+S8ArcZ9f3BeoV9yGlxG3WnMDaQIIfwtj2r45NAYA8gF1f9oV0jTBiia/36TBfiJtDT828AFf8Zjf6RkzNNuKbbp/H4dhjwgGZRALr/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z01Ot9+m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706710810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EJ5IuSkHp6LD0vYjmHgDCJ3/HytjuH6PXzpbQ2D4dxA=;
	b=Z01Ot9+mHQyt1ZHaxCdazhjdI0qFMS3gXIonW8xaoGtwhCXd4A5EU1Fv9CajMTTVBfZw1I
	MVJdp+SRFl2aaHjBZxUmcTO7fmDdWGSm+49+f5oYy64kn1MHCRZb+4r+j9Y7XOxr5uRC9x
	zg/7+lWC2LAI5+b1K88abwJX6B4aFn8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-aB3UDMbOMhmzyoANGC2jRA-1; Wed, 31 Jan 2024 09:20:07 -0500
X-MC-Unique: aB3UDMbOMhmzyoANGC2jRA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso3639585e9.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 06:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710806; x=1707315606;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ5IuSkHp6LD0vYjmHgDCJ3/HytjuH6PXzpbQ2D4dxA=;
        b=e3L1Jf+1Rh5i+603icsXbzDh30eZ/ULRM/8GyEw1HUcqOYakF5QRItDBv+xGWZUGdS
         W2wZhHGZKem6DldkveX/V835SjRAPVCs7sgl+RiZG/ZPjD7dzaZJ50DgUJE8Q3Nyu9eM
         rKE2ncr+lEPcksMOBl+KBkSYo4bBOdlHuTUbt+gdaSCuf+tojcrSsLuNz3D43c62UueR
         kNTok+BOTQ1v7hFr3J2YrKb0wWcF/Tivn2hPfaKtziYxrSmT1uytH5xZnPm5D0db4YbO
         70XrsmY9C1ZKlfTT+TJyK2vJa88LEtthU8qKY1/m7c+MZ17tzTQUMk+Iipgqc524EpdH
         26yQ==
X-Gm-Message-State: AOJu0YzJEjVeXsbEnuIVp1rGmNEZJ0iUcnugseuoSwnMBDj+A7gH4e4T
	jdgm8eNwIoSQk84z/1YdZaq67JblXRPdPAv7fvJ6hHJw97A5xL1Y83HWz/QGyasNecdFrH1vKYx
	dre6pY8E2FtsAhrWhdADK/B3jvlIFE1RNJKbCLSmKoD6juknvQ2rKE0s6LwU=
X-Received: by 2002:a05:600c:1e16:b0:40e:f972:9918 with SMTP id ay22-20020a05600c1e1600b0040ef9729918mr1606340wmb.29.1706710805915;
        Wed, 31 Jan 2024 06:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVS0DLc03z9UjF+ShKdgT2iE+aZAHubGYficvaqYAxhORIFpUTuMxb55nVEcr4Ub+xdd+4nQ==
X-Received: by 2002:a05:600c:1e16:b0:40e:f972:9918 with SMTP id ay22-20020a05600c1e1600b0040ef9729918mr1606301wmb.29.1706710805551;
        Wed, 31 Jan 2024 06:20:05 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b0040ed1d6ce7csm1745809wms.46.2024.01.31.06.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:20:05 -0800 (PST)
Message-ID: <e55a111d-0f09-4981-94e1-f547bdfad059@redhat.com>
Date: Wed, 31 Jan 2024 15:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
References: <20240129143221.263763-1-david@redhat.com>
 <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
 <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
 <1fd26a83-8e6f-4b96-9d27-dd46de9488cc@arm.com> <ZbpUVXa-Aujp6gWO@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZbpUVXa-Aujp6gWO@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 15:08, Michal Hocko wrote:
> On Wed 31-01-24 10:26:13, Ryan Roberts wrote:
>> IIRC there is an option to zero memory when it is freed back to the buddy? So
>> that could be a place where time is proportional to size rather than
>> proportional to folio count? But I think that option is intended for debug only?
>> So perhaps not a problem in practice?
> 
> init_on_free is considered a security/hardening feature more than a
> debugging one. It will surely add an overhead and I guess this is
> something people who use it know about. The batch size limit is a latency
> reduction feature for !PREEMPT kernels but by no means it should be
> considered low latency guarantee feature. A lot of has changed since
> the limit was introduced and the current latency numbers will surely be
> different than back then. As long as soft lockups do not trigger again
> this should be acceptable IMHO.

It could now be zeroing out ~512 MiB. That shouldn't take double-digit 
seconds unless we are running in a very problematic environment 
(over-committed VM). But then, we might have different problems already.

I'll do some sanity checks with an extremely large processes (as much as 
I can fit on my machines), with a !CONFIG_PREEMPT kernel and 
init_on_free, to see if anything pops up.

Thanks Michal!

-- 
Cheers,

David / dhildenb


