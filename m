Return-Path: <linux-arch+bounces-6346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CE957AE3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 03:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824D12842BF
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F4B657;
	Tue, 20 Aug 2024 01:25:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BD1B7F4;
	Tue, 20 Aug 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117125; cv=none; b=I7t7ouZ3wrZCLhadjesONq3b1viQNtSKyIVQ+qAsXaL25Dd64sDE6pZDnrqzZoJiDWAezNWjDBJGBSGIkeOIkXkgJH4uRa6fNMhQ3y9aYotWER/OI47BwAVOEx4QJGdFAlNlEpLxPuppr7+ARmZ5tIV04fCVU/IVHXOSu51aV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117125; c=relaxed/simple;
	bh=NYpqG6MuyLP+uwqlcSvTaHZzQ56TalLVNSBSB5HjaDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7MMZhlZTb/z4EEBY7BUuGpEuvRDHkeCD3fUnz9gLrs2XtjfVC1q2Ihirx1M+OlqAJhI/DjNnPJTc3H2f18Z6YWOgizzrXN9oE/PwxybsOnWTGnnKGFzQM53QPKBFB9yI+ym0HX0TQuqZ0aHvSflsKvFwGDViZ7H4FCsU2Se3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0657339;
	Mon, 19 Aug 2024 18:25:47 -0700 (PDT)
Received: from [10.163.58.147] (unknown [10.163.58.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414F73F73B;
	Mon, 19 Aug 2024 18:25:18 -0700 (PDT)
Message-ID: <17020e56-b0a9-4705-8ee3-c675eca99490@arm.com>
Date: Tue, 20 Aug 2024 06:55:16 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] uapi: Define GENMASK_U128
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-2-anshuman.khandual@arm.com>
 <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
 <3b219e52-1d2a-4e6d-adff-efbab3e2282d@app.fastmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3b219e52-1d2a-4e6d-adff-efbab3e2282d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/24 12:43, Arnd Bergmann wrote:
> On Fri, Aug 16, 2024, at 08:28, Anshuman Khandual wrote:
>>
>> This is caused by ((unsigned __int128)(1) << (128)) which is generated
>> via (h + 1) element in __GENMASK_U128().
>>
>> #define _BIT128(x)	((unsigned __int128)(1) << (x))
>> #define __GENMASK_U128(h, l) \
>> 	((_BIT128((h) + 1)) - (_BIT128(l)))
> 
> Right, makes sense.
> 
>>
>> The most significant bit in the generate mask can be added separately
>> , thus voiding that extra shift. The following patch solves the build
>> problem.
>>
>> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
>> index 4d4b7b08003c..4e50f635c6d9 100644
>> --- a/include/uapi/linux/bits.h
>> +++ b/include/uapi/linux/bits.h
>> @@ -13,6 +13,6 @@
>>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>>
>>  #define __GENMASK_U128(h, l) \
>> -       ((_BIT128((h) + 1)) - (_BIT128(l)))
>> +       (((_BIT128(h)) - (_BIT128(l))) | (_BIT128(h)))
> 
> This could probably use a comment then, as it's less intuitive.

Right, a comment explaining the need for this additional bit to
cover the corner 127 bit case could be added for reference.

> 
> Another solution might be to use a double shift, as in
> 
> #define __GENMASK_U128(h, l) \
>        ((_BIT128((h)) << 1) - (_BIT128(l)))

This looks much cleaner, passed all the tests without warning.
But for the above 127 bit case, wondering how the bit position
is managed after the second shift operation because it still
goes beyond __int128 element's 128 bit representation.

(_BIT128((127)) << 1)
(((unsigned __int128)(1) << (127)) << 1)

Should not the second shift operation warn about the possible
overflow scenario ? But actually it does not. Or the compiler
is too smart in detecting what's happening next in the overall
equation and do the needful while creating the mask below the
highest bit.

> 
> but I have not checked if this is correct for all inputs
> or if it avoids the warning. Your version looks fine to
> me otherwise.

This approach is much cleaner, passes all tests without warning,
unless something else shows up, will fold this in instead.

