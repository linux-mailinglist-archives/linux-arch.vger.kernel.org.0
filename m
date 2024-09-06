Return-Path: <linux-arch+bounces-7105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28B96F1FD
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C02B20920
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B41C9EDE;
	Fri,  6 Sep 2024 10:56:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C71CA6AA;
	Fri,  6 Sep 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620166; cv=none; b=q75esVrPANhDV77+BzDU3SRrTydsg4M19HGKOYSL+0eNj4PaB0CA8FVgaZ90kkZkvXZDTZ3DCxxCIgoU5B6QjpgF6KW0hOyAHbLjwuLhWiruZy3VOdNakQaS5T1wdHnLMiYwzyXBMPI+KMSh6vKVwFb4qW0v+kbPAgMmd0NUkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620166; c=relaxed/simple;
	bh=s65V3MJ9MtbfJfmv2YobiFjfN/XToUEbJVYOauK9bR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X24IxOj8LXofNaJSFEPG3765furcFUlmNyONnxEWdZesPKzA+FO88Glg1aq0GEP1NediFiaMdSwEs+NWT4MaJMbL+zLded7Ytdh0OkPHf698ZKkxeTsUQNCIzFVic7BR59zYHbkjzhdu25T/KfRXPwTp7y88hMRckVINdawmRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82855FEC;
	Fri,  6 Sep 2024 03:56:30 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6EC73F66E;
	Fri,  6 Sep 2024 03:56:00 -0700 (PDT)
Message-ID: <043e992f-487e-4102-9543-16da1f57b7bc@arm.com>
Date: Fri, 6 Sep 2024 11:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] x86: vdso: Introduce asm/vdso/mman.h
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
 <20240903151437.1002990-2-vincenzo.frascino@arm.com>
 <710f9663-e99c-40e2-9c0e-2f5e6e854653@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <710f9663-e99c-40e2-9c0e-2f5e6e854653@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christophe,

Thank you for your review.

On 04/09/2024 17:56, Christophe Leroy wrote:
> 
> 
> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
...

>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_VDSO_MMAN_H
>> +#define __ASM_VDSO_MMAN_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <uapi/linux/mman.h>
>> +
>> +#define VDSO_MMAP_PROT    PROT_READ | PROT_WRITE
>> +#define VDSO_MMAP_FLAGS    MAP_DROPPABLE | MAP_ANONYMOUS
> 
> I still can't see the benefit of duplicating those two defines in every arch.
> 
> I understand your point that some arch might in the future want to use different
> flags, but unless we already have one such architecture in mind we shouldn't
> make things more complicated than needed.
> 
> In case such an architecture is already identified it should be said in the
> commit message
> 

I do not have such an architecture in mind, hence I did not add it to the commit
message.

Apart being future proof the real problem here is to handle the mman.h header.
As Arnd was saying [1] (and I agree), including it on some architectures might
be problematic if they change it in a way that is incompatible with compat vdso.

In this way we make sure that the each architecture that decides to include it
specifically validates it for this purpose. I am not a fan of complicating code
either but this seems the lesser evil. I am open to any solution you can come up
that is better then this one.

The other issue I see is that being these defines in a uapi header that is
included directly by userspace splitting it requires some validation to make
sure we do not break the status quo.

[1]
https://lore.kernel.org/lkml/cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com/

>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +#endif /* __ASM_VDSO_MMAN_H */

-- 
Regards,
Vincenzo

