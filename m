Return-Path: <linux-arch+bounces-5612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D157693B0C8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C3B1F21CE9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAC4157461;
	Wed, 24 Jul 2024 11:59:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC85695;
	Wed, 24 Jul 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822350; cv=none; b=N3YX4I8tw/RJ2IePNMZCjdPqHMGDXaGlDqIOmVCUVvLWiZaR4ccFvy+hBG17SD6Wfhtl9YJGhUvxjnCa6jTf9jiOtXxcIxF59u9o1vMJf6NNfSxhgg6WsZWk5BxPDk49spZwGGLLNE0HRgE5RS4j2/QycAvDO5053jsY9BrWAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822350; c=relaxed/simple;
	bh=rWKmFEfFUQpltJjCuvQIcACUQVh/AStq91RKt7MEVt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFBUeEcuihpd5XuNoUDCIUw7RqHOTWfaulDSn0VZZVDVzFdogSQN6PvXQh19d4Brze+uAg9yw20s/9f7Q/aDE3KmiHziMjySrh9r7qBnH8f+RbCj8JN2UyYtyn34knHBF+0ky5d+zk94LBZpaCQvIBBJuETIL3HgBemy+MA6ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2EB106F;
	Wed, 24 Jul 2024 04:59:33 -0700 (PDT)
Received: from [10.163.54.221] (unknown [10.163.54.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5F583F5A1;
	Wed, 24 Jul 2024 04:59:05 -0700 (PDT)
Message-ID: <7d075af2-e94e-4201-9d5d-35fd53124c4c@arm.com>
Date: Wed, 24 Jul 2024 17:29:02 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] uapi: Define GENMASK_U128
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
 <20240724103142.165693-2-anshuman.khandual@arm.com>
 <d0fadaa3-94d4-4600-8e92-a8fe5b0f141b@app.fastmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d0fadaa3-94d4-4600-8e92-a8fe5b0f141b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/24 16:33, Arnd Bergmann wrote:
> On Wed, Jul 24, 2024, at 12:31, Anshuman Khandual wrote:
>> --- a/include/uapi/asm-generic/bitsperlong.h
>> +++ b/include/uapi/asm-generic/bitsperlong.h
>> @@ -28,4 +28,8 @@
>>  #define __BITS_PER_LONG_LONG 64
>>  #endif
>>
>> +#ifndef __BITS_PER_U128
>> +#define __BITS_PER_U128 128
>> +#endif
> 
> I would hope we don't need this definition. Not that it
> hurts at all, but __BITS_PER_LONG_LONG was already kind
> of pointless since we don't run on anything else and
> __BITS_PER_U128 clearly can't have any other sensible
> definition than a plain 128.

Agreed, although this just followed __BITS_PER_LONG_LONG.
But sure __BITS_PER_U128 can be plain 128.

So would you like to have #ifndef __BITS_PER_LONG_LONG dropped here 
as well ? But should that be folded or in a separate patch ?

> 
>>  #define __AC(X,Y)	(X##Y)
>>  #define _AC(X,Y)	__AC(X,Y)
>>  #define _AT(T,X)	((T)(X))
>> +#define _AC128(X)	((unsigned __int128)(X))
> 
> I just tried using this syntax and it doesn't seem to do
> what you expected. gcc silently truncates the constant

But numbers passed into _AC128() are smaller in the range [128..0].
Hence the truncation might not be problematic in this context ? OR
could it be ?

> to a 64-bit value here, while clang fails the build.

Should this be disabled for CC_IS_CLANG ?

> See also https://godbolt.org/z/rzEqra7nY
> https://stackoverflow.com/questions/63328802/unsigned-int128-literal-gcc

So unless the value in there is beyond 64 bits, it should be good ?
OR am I missing something.

> 
> The __GENMASK_U128() macro however seems to work correctly
> since you start out with a smaller number and then shift
> it after the type conversion.

_U128() never receives anything beyond [127..0] range. So then this
should be good ?

