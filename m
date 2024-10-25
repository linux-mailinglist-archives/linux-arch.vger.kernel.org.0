Return-Path: <linux-arch+bounces-8532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1D9AFC78
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 10:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5641C20D3F
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510401CFECE;
	Fri, 25 Oct 2024 08:26:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F531D0F5F
	for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844783; cv=none; b=X99GhdFpNeWwzt6xlKQ+KmddA5yB/TWdomTaI600rklPDhXO/ngFHMt5Jwy4c2tKUDU3wweOVhCyCe3kvfG+FOrKZhNOAtIaixki0LnIIF1MREbtfccCzywdjBt9ggjttlkAZIg+DiBnhnKhBrSvnUYfw5l6TT9CUZ2PYMaZCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844783; c=relaxed/simple;
	bh=GzpJh/AclxSqPzK2qy5RJr745reWxONjM4NlfhLsSoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvJo/gADoGPiGRDIdWPPTfYx3LgHcJk1ETR1jufGr51REQjv2CJiUeqhxAvMZc3T5VjZQNyqqX8HieSJCExgxKGxdlJowUNMfq4mIvUNndU4Dlcg+Ky+RoH4UH9dRg15ExpAAwpep3N6SMukIVJryIzpmmEK4wu/+qVFmRhP6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34DD8339;
	Fri, 25 Oct 2024 01:26:50 -0700 (PDT)
Received: from [10.57.66.80] (unknown [10.57.66.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2FD3F73B;
	Fri, 25 Oct 2024 01:26:18 -0700 (PDT)
Message-ID: <4da06814-1846-47f1-87f9-f8d38fe2ef33@arm.com>
Date: Fri, 25 Oct 2024 10:26:16 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pkey: Add PKEY_UNRESTRICTED macro
To: Dave Hansen <dave.hansen@intel.com>,
 Yury Khrustalev <yury.khrustalev@arm.com>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, nd@arm.com
References: <20241022120128.359652-1-yury.khrustalev@arm.com>
 <d8c2ff4a-a7b3-409f-aa3c-5ee97ba4c540@intel.com>
 <04426b9c-2686-470b-977e-d6890312d49b@arm.com>
 <585b56ef-6e89-4d1e-be6f-715c0f38b56d@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <585b56ef-6e89-4d1e-be6f-715c0f38b56d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 19:15, Dave Hansen wrote:
> On 10/22/24 08:11, Kevin Brodsky wrote:
>>>> +#define PKEY_UNRESTRICTED	0x0
>>>>  #define PKEY_DISABLE_ACCESS	0x1
>>>>  #define PKEY_DISABLE_WRITE	0x2
>>>>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
>>> It seems sane, but it would be nice to have at least site or two use it
>>> in the kernel so show that it's useful in practice.  Is there any kernel
>>> code or anything in selftests/ that would be improved with this?
>> As a matter of fact this would improve the readability of [1] quite a
>> bit: all those set_pkey_bits(..., 0) calls would become
>> set_pkey_bits(..., PKEY_UNRESTRICTED). I'm sure other pkey-related
>> kselftests could benefit too.
> It would be much appreciated if someone could make a pass over kernel
> code and fix up the places where PKEY_UNRESTRICTED makes things more clear.

It doesn't look like kernel code would have a use for it at the moment,
but I have found a few places in kselftests (mm, ppc) where 0 could be
replaced with PKEY_UNRESTRICTED. I can send a follow-up series.

Kevin

