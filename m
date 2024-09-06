Return-Path: <linux-arch+bounces-7118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7AE96F4A2
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A51C22A07
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA591C8FA6;
	Fri,  6 Sep 2024 12:51:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A825C8FF;
	Fri,  6 Sep 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627099; cv=none; b=R6DcS48S9of5/i+xNs3czPC9UOGNnpdZQdbEUubWYZDAn0MIoHAhNVFbyllw4CzXJCyzUOQ+YQ0LUF29apeTHXt0wHiYktO60aqOhOfrtZR7EMVyKrjygYPfzsy6YCy4L525TpGrKd/iOA8i5BVAaR4KNHekbqM79vpkWjAHlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627099; c=relaxed/simple;
	bh=XlIjnH4dIYrx7LDtvBOMrleJY8pGMuPFXS/r/MZTZU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjWoy/f26lSoKz0xTXZNehXWahLys0mDbzjMd6kW/kUUVqNQscTcS4/YRsGtwnPUuh8mBsFO9P3kaL+Uup7Sv6B0g6jJry4eyo7+6VGJw6UbPF+H3FVajrjIjXdFGN/f4JICOQX6TtQGbVQ6N8DdzY/wdkBC4EXfomL4OEJrwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A14113E;
	Fri,  6 Sep 2024 05:52:03 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48D8B3F73B;
	Fri,  6 Sep 2024 05:51:33 -0700 (PDT)
Message-ID: <30c2b836-06cf-4631-8de1-90bcd37b0247@arm.com>
Date: Fri, 6 Sep 2024 13:51:31 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vdso: Modify getrandom to include the correct
 namespace
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-10-vincenzo.frascino@arm.com>
 <b899bce8-8704-4288-9f32-bcb2fa0d29a8@csgroup.eu>
 <72f3d6cf-a03b-4a16-9983-77d3dd70b0ea@arm.com>
 <4a4873d9-c783-4374-a505-3628d3c92137@csgroup.eu>
 <3155e7ba-33fe-4de8-bb63-867579c3eac8@arm.com>
 <2aaf06aa-af16-43fc-8bc5-3908760438bb@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <2aaf06aa-af16-43fc-8bc5-3908760438bb@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/09/2024 13:49, Christophe Leroy wrote:
> 
> 
> Le 06/09/2024 à 14:40, Vincenzo Frascino a écrit :
>>
>>
>> On 06/09/2024 13:04, Christophe Leroy wrote:
>>>
>>>
>>> Le 06/09/2024 à 13:52, Vincenzo Frascino a écrit :
>>>>
>>>>
>>>> On 04/09/2024 18:26, Christophe Leroy wrote:
>>>>>
>>>>>
>>>>> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>>>> ...
>>>>
>>
>> ...
>>
>>>
>>> More details:
>>>
>>> $ make ARCH=powerpc CROSS_COMPILE=ppc-linux- mpc885_ads_defconfig
>>>
>>> $ LANG= make ARCH=powerpc CROSS_COMPILE=ppc-linux- vmlinux
>>>    SYNC    include/config/auto.conf
>>>    SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_32.h
>>>    SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_64.h
>>>    SYSTBL  arch/powerpc/include/generated/asm/syscall_table_32.h
>>>    SYSTBL  arch/powerpc/include/generated/asm/syscall_table_64.h
>>>    SYSTBL  arch/powerpc/include/generated/asm/syscall_table_spu.h
>>
>> Thank you Christophe, is upstream code sufficient to reproduce the issue? Or do
>> I need specific patches?
>>
> 
> You need random git tree plus the patch "[PATCH] powerpc patches for Vincenzo's
> series" I have just sent to you.
>

Thank you!

> Christophe

-- 
Regards,
Vincenzo

