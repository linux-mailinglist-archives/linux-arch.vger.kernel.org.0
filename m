Return-Path: <linux-arch+bounces-8421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC79AB1C0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CD12869FE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432C1A0BFE;
	Tue, 22 Oct 2024 15:11:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5807A1A00D6
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609895; cv=none; b=D2GpqMUSmGaU+Ynv8Ac1AzGF9gEzVmE+tecAYjqR6aZQW8tRjt7vISQx2Ga3UdEEPF6CgQ0pJSc0qdVqD9eeeuqJNpnOAOFz8aviZuM3oAHEZZ8gCswu8ZcTMNrka7Yvhm7aMoLAeM7H24cX/r3UusPx+vsA+yfd+Aj4C+4R2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609895; c=relaxed/simple;
	bh=BSdMlyasjLj7ts8JPdxWA0q63fbgBHkv3C1c2r4knb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lr5HJ2nXStgKKlv7IQPgeeVvk5PgC55tKeQEQvklqOvPEeSNctBXgZY/oJ57FwJ16XwO6CVrKDyrC8U0dG5Z7A28jPd0k5NG4sY8f4FikFwzNx/muuZwX2GhRs8WAicGFFWcs+57bR6BDAH+tRJJmOP4pVT66Ljq4ag/nTBvgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E7CD497;
	Tue, 22 Oct 2024 08:12:02 -0700 (PDT)
Received: from [10.57.66.29] (unknown [10.57.66.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A05B3F73B;
	Tue, 22 Oct 2024 08:11:30 -0700 (PDT)
Message-ID: <04426b9c-2686-470b-977e-d6890312d49b@arm.com>
Date: Tue, 22 Oct 2024 17:11:27 +0200
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
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <d8c2ff4a-a7b3-409f-aa3c-5ee97ba4c540@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 16:04, Dave Hansen wrote:
> On 10/22/24 05:01, Yury Khrustalev wrote:
>> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
>> index 6ce1f1ceb432..ea40e27e6dea 100644
>> --- a/include/uapi/asm-generic/mman-common.h
>> +++ b/include/uapi/asm-generic/mman-common.h
>> @@ -82,6 +82,7 @@
>>  /* compatibility flags */
>>  #define MAP_FILE	0
>>  
>> +#define PKEY_UNRESTRICTED	0x0
>>  #define PKEY_DISABLE_ACCESS	0x1
>>  #define PKEY_DISABLE_WRITE	0x2
>>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> It seems sane, but it would be nice to have at least site or two use it
> in the kernel so show that it's useful in practice.  Is there any kernel
> code or anything in selftests/ that would be improved with this?

As a matter of fact this would improve the readability of [1] quite a
bit: all those set_pkey_bits(..., 0) calls would become
set_pkey_bits(..., PKEY_UNRESTRICTED). I'm sure other pkey-related
kselftests could benefit too.

Kevin

[1]
https://lore.kernel.org/linux-arm-kernel/20241017133909.3837547-5-kevin.brodsky@arm.com/

