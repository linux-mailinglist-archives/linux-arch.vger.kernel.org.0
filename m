Return-Path: <linux-arch+bounces-8417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C69AA11D
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784C21C21AFC
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BDE140E38;
	Tue, 22 Oct 2024 11:26:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84713199FB4;
	Tue, 22 Oct 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596391; cv=none; b=udRDIX5TxehrrKrITaT6fLiRTW4fITmEVtciM1sUkmSAKgpTAo0Gb/FDz7sQrL86c7tbcFpleECGVUdwIhwX+WLR1/ciKLRHQ0co9yYWt76u9t8aQ5YRq4P/CgikBxVM/MOYCm/PYfG7Fyx0hpfwNsbVetZUkX86sjNQjw14sXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596391; c=relaxed/simple;
	bh=cmvsw12VRAOlfs1D267/9TxMnnuNkQD7IOlnuekt8LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP1VS5U5olb2fHNiqwpN7yAwrYqhfaH3kzttmyp9BNyQIsxGeCQFWrzlWWyxC9th1BRxSZLSbUD8iLvEC90pFiEYtnUAqDKHY6UGKsGnxlSyvvrBJwqMOC0ou/a91SuAlKTq9bYeKhR5vU/I7N7BuVcxhYwoHOTqRHLEd+fRf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C301497;
	Tue, 22 Oct 2024 04:26:56 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4113A3F73B;
	Tue, 22 Oct 2024 04:26:25 -0700 (PDT)
Message-ID: <01d59bcb-b7fe-4ae8-9c16-e6fdb2305824@arm.com>
Date: Tue, 22 Oct 2024 12:26:23 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] s390: Remove remaining _PAGE_* macros
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, kernel test robot <lkp@intel.com>
References: <20241014151340.1639555-1-vincenzo.frascino@arm.com>
 <20241014151340.1639555-4-vincenzo.frascino@arm.com>
 <ZxIEWLKWF8SMnQSU@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <ZxIEWLKWF8SMnQSU@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 18/10/2024 07:46, Alexander Gordeev wrote:
> On Mon, Oct 14, 2024 at 04:13:40PM +0100, Vincenzo Frascino wrote:
> 
> Hi Vincenzo,
> 
>> The introduction of vdso/page.h made redundant the definition of
>> _PAGE_SHIFT, _PAGE_SIZE, _PAGE_MASK.
>>
>> Refactor the code to remove the macros.
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202410112106.mvc2U2p0-lkp@intel.com/
> 
> Is my understanding correct that with patch 3/3 you fix an issue
> introduced with patch 2/3?
> 

Logically yes, but please note that patch 2/3 has a small transitional change to
not break bisectability.

>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/s390/include/asm/page.h    | 3 ---
>>  arch/s390/include/asm/pgtable.h | 2 +-
>>  arch/s390/mm/fault.c            | 2 +-
>>  arch/s390/mm/gmap.c             | 6 +++---
>>  arch/s390/mm/pgalloc.c          | 4 ++--
>>  5 files changed, 7 insertions(+), 10 deletions(-)
> 
> Thanks!

-- 
Regards,
Vincenzo

