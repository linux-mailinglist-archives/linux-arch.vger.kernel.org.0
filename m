Return-Path: <linux-arch+bounces-7752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E909929C4
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E71C1F21F8C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C1198E81;
	Mon,  7 Oct 2024 11:01:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304163FBA5;
	Mon,  7 Oct 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298870; cv=none; b=fxO8Stl48Gn0fcAh9Vn+5rEFJ/nSVC9DFbZTKs1DOTF/MzTGUresqtthzeQRUsSZIAd5Fc/SJZ5kOP8Qs9HY6T1eUAAFIzCxa4c9auskrXkDvGPncXNHUEMuOuHxmx7QSk0gS5LCS61Ds7KrJj2McGszfFHXgpb11hrsiiJbuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298870; c=relaxed/simple;
	bh=FiSKg/kHhCDQOQ/TfOxXjBLaMI+VeWWs/jjr6N/6XTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgb57cJOqFQKq7H4TXqzdzgPghjP3tMo3qI4CaPIe6RA3L8g0hf9DKT9WMqO/+BqofnlY0ZDlp6Vi34rEEQjAV7liVCUkMNTEPxh96cLIyM8eWsKvV7uEgH1qs2A+iBSSiQm01ul4ltcwTJObVy0DZcL9b7bPCiiSy+CAQaD7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02F9CFEC;
	Mon,  7 Oct 2024 04:01:38 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDB013F640;
	Mon,  7 Oct 2024 04:01:05 -0700 (PDT)
Message-ID: <850cdc2a-a336-4dab-bc7a-d9bcae3fb3cf@arm.com>
Date: Mon, 7 Oct 2024 12:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
 <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 14:13, Arnd Bergmann wrote:
> On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Introduce vdso/page.h to make sure that the generic library
>> uses only the allowed namespace.
>>
>> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
>> it supports 64-bit phys_addr_t we might end up in situation in which the
>> top 32 bit are cleared. To prevent this issue this patch provides
>> separate macros for PAGE_MASK.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Looks good to me. I would apply this to the asm-generic
> tree for 6.13, but there is one small detail I'm unsure
> about:
>

Thanks.

>> +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
>> +#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
>> +#else
>> +#define PAGE_MASK	(~(PAGE_SIZE-1))
>> +#endif
> 
> We only want the #if branch for 32-bit architectures, right?
> 
> On 64-bit ones, CONFIG_PHYS_ADDR_T_64BIT is always set, so
> I think that is unnecessary change from the existing version,
> even though it should be harmless.
> 

It seemed harmless from the tests I did. But adding an '&&
defined(CONFIG_32BIT)' makes it logically correct. I will add a comment as well
in the next version.

>      Arnd

-- 
Regards,
Vincenzo

