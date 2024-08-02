Return-Path: <linux-arch+bounces-5907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C699E9455FC
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 03:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF021C22CEB
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A3B67E;
	Fri,  2 Aug 2024 01:30:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D43D97A;
	Fri,  2 Aug 2024 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562252; cv=none; b=eUuiU1PdHq0JJZTPxWpjyA5xwwFMxE0APtlZRiUF1ctHYgzHUelaKdC8LcK7UuwKJam0cZEAFSYEd0fy2A7DaUhYCGEskShQj0jHhf+VP7Tj7IJAM8fyY9RGufKT8G4tSlcQk06Mo4vc3J7cE8GJPuNk+rV2B9X+psm7Y6g89iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562252; c=relaxed/simple;
	bh=eSHr6TCbRl9edluYyCnfspp1ybpELwqRdYor8/z9ykc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRNlQoEiNmNmMjkUP0Sj38siJbzEuvcvmeagklK3pYsz/Ml7b+CKWZzilVkbDOxEG9WYx27KzwgoD/RRPnQ8MaFw13dyO/FO1yYFRCISirsVyKmrdhl1M9zEasdzYvMOm4DaWq/8jWpuqvUvOQMyWg6yOUgZht+oH10pb6Ah+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975481007;
	Thu,  1 Aug 2024 18:31:14 -0700 (PDT)
Received: from [10.163.56.112] (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877203F64C;
	Thu,  1 Aug 2024 18:30:46 -0700 (PDT)
Message-ID: <1781c39a-2280-49ed-aaaa-b1684744615e@arm.com>
Date: Fri, 2 Aug 2024 07:00:43 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/2] uapi: Add support for GENMASK_U128()
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <CAAH8bW9sJmwKd19sJzpGrQ5Tr_4fYMyvLnfFyahhxxkG6r6GbA@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAAH8bW9sJmwKd19sJzpGrQ5Tr_4fYMyvLnfFyahhxxkG6r6GbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/1/24 20:13, Yury Norov wrote:
> On Thu, Aug 1, 2024 at 12:16 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> This adds support for GENMASK_U128() and some corresponding tests as well.
>> GENMASK_U128() generated 128 bit masks will be required later on the arm64
>> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.
>>
>> Because GENMAKS_U128() depends on __int128 data type being supported in the
>> compiler, its usage needs to be protected with CONFIG_ARCH_SUPPORTS_INT128.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Cc: Arnd Bergmann <arnd@arndb.de>>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arch@vger.kernel.org
> 
> For the patches:
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks Yury.

> 
> This series doesn't include a real use-case for the new macros. Do you
> have some?
> I can take it via my branch, but I need at least one use-case to not
> merge dead code.

I have recently posted the following patch for arm64 platform although
most of the subsequent work is still in progress. But for now there
are some corresponding tests for this new GENMASK_U128() ABI as well.
Hence it will be really great to have these two patches merged first.
Thank you.

https://lore.kernel.org/all/20240801054436.612024-1-anshuman.khandual@arm.com/

