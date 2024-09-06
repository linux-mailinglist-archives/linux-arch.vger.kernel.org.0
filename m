Return-Path: <linux-arch+bounces-7116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5139296F469
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5FC285E27
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313E1CB15C;
	Fri,  6 Sep 2024 12:40:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686A1552FA;
	Fri,  6 Sep 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626421; cv=none; b=RJeCq67hprxPOJHmNg/7Lse406wW3mIePKsQjpJvyS79eeUsI01+T7HYsNnHoZM2Q86hj0f9fmzYjb8M+B7qTSRNLbEuv/oyLzUGoOZnqggQE7D+jfmaOIfQmttlF3Cst9RhWmX9rOTr8a8RaMsJbQWnSQRQEUtNkfTrbTINQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626421; c=relaxed/simple;
	bh=dT1BaUR2hyzvKwLo2RLvq+090K2uM/NqPj1L7uIxuJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhT49PrYUYZwBd5nRrnt2uMY9tp1j8RgmU6y4PRDSJx3YBlieP5GHvEJE4MiOPKpZYWwNQou1yMb32tEY2QFVRPOvBBfqohl4YDvJ0teqYf1Yp5pHeFArr3GBaXQ9jQ1cEIMEIKj2GtVDJ2i3iF8mww2TGl3WnOMrnd1u+JvcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2BA4113E;
	Fri,  6 Sep 2024 05:40:45 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A343F73B;
	Fri,  6 Sep 2024 05:40:16 -0700 (PDT)
Message-ID: <3155e7ba-33fe-4de8-bb63-867579c3eac8@arm.com>
Date: Fri, 6 Sep 2024 13:40:15 +0100
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
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <4a4873d9-c783-4374-a505-3628d3c92137@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/09/2024 13:04, Christophe Leroy wrote:
> 
> 
> Le 06/09/2024 à 13:52, Vincenzo Frascino a écrit :
>>
>>
>> On 04/09/2024 18:26, Christophe Leroy wrote:
>>>
>>>
>>> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>> ...
>>

...

> 
> More details:
> 
> $ make ARCH=powerpc CROSS_COMPILE=ppc-linux- mpc885_ads_defconfig
> 
> $ LANG= make ARCH=powerpc CROSS_COMPILE=ppc-linux- vmlinux
>   SYNC    include/config/auto.conf
>   SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_32.h
>   SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_64.h
>   SYSTBL  arch/powerpc/include/generated/asm/syscall_table_32.h
>   SYSTBL  arch/powerpc/include/generated/asm/syscall_table_64.h
>   SYSTBL  arch/powerpc/include/generated/asm/syscall_table_spu.h

Thank you Christophe, is upstream code sufficient to reproduce the issue? Or do
I need specific patches?

> 
> 
> Christophe
> 

-- 
Regards,
Vincenzo

