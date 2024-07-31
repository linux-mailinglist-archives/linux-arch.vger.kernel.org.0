Return-Path: <linux-arch+bounces-5738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DA942488
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 04:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C641F23F26
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3D156CF;
	Wed, 31 Jul 2024 02:39:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760514F70;
	Wed, 31 Jul 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393583; cv=none; b=h4vXYBFdhqmWbzNcmF0heLww1d1XJEB00vNCTSdZdB1UtFL+0vugUdLL9e0BxBQF2HgyYO79+iFkzA73eKRsbtxNwXPqOAWvi841g5TSZUtEfBNY2uXg7nVL6otOHsncuUwc8cqAaJCOYbtgoBcu7yQYE9f92KF6CQl5kxpy1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393583; c=relaxed/simple;
	bh=pYQq6bhxKyUy+nx+x00iAclGhtWNWcFAbLfSMsv/0Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPMyo6orMp85pXPAxhFt0QaKVWR7C/7DWNtMsMrJCleB+vFs3sU/B3xUSKhvx1aowKmnws8PzZajfZw6fw+ExX6FuB8lwXTCrUpb6EMYv5RCL3jcJp0Mxt5xnzc1qAiVJiLcxs5SpjGBIaivIHSEDrSuRJPjEDaZyY7DsslSrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCB441007;
	Tue, 30 Jul 2024 19:40:05 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E10063F64C;
	Tue, 30 Jul 2024 19:39:37 -0700 (PDT)
Message-ID: <f423dcb2-f23e-4d33-b4e3-7c63b50a30ea@arm.com>
Date: Wed, 31 Jul 2024 08:09:34 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] uapi: Add support for GENMASK_U128()
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <08e6c85e-2c82-4c15-bfe7-d42900d1c68f@arm.com>
 <79960e1a-6fa1-4d15-b842-0dc4d6a2bc1b@app.fastmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <79960e1a-6fa1-4d15-b842-0dc4d6a2bc1b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 17:59, Arnd Bergmann wrote:
> On Tue, Jul 30, 2024, at 06:29, Anshuman Khandual wrote:
>> On 7/25/24 11:18, Anshuman Khandual wrote:
>>>
>>> - Wrapped genmask_u128_test() with CONFIG_ARCH_SUPPORTS_INT128
>>> - Defined __BITS_PER_U128 unconditionally as 128
>>> - Defined __GENMASK_U128() via new _BIT128()
>>> - Dropped _U128() and _AC128()
>>
>> Does the changed series look good ? Please do let me know if something
>> further needs to be changed. Thank you.
> 
> Yes, these look fine to me, please add
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.

> 
> One detail: You are not actually using __BITS_PER_U128 at
> all now, so I think it would be better to not add it at all.

Sure, will do, missed that some how.

