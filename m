Return-Path: <linux-arch+bounces-7842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15D995174
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B6EB20E35
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC821DE3AE;
	Tue,  8 Oct 2024 14:20:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CD14EC59;
	Tue,  8 Oct 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397241; cv=none; b=M31xqDzxgGFd4WSBA3LF5Uome2jBL4ge/jnC1vBE2VhLm4riTKuKvHaK3SN7KUmVwWf4FWJkXwjDzkbhSuy0QDtcviQCnEIlfmEFA+R6xd/8cbiLnZKuWozLshk/zX/UY5NJXj/vh21wUcZY4I1vI33/FlGhmGP4IZ0U3T7KJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397241; c=relaxed/simple;
	bh=Q1rVwS8443I896s0/Zl20azyLBs17oSGuNZsryEPaVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cV/g/A25Z2j1SF0avXTSqa6V2xKSvSx3J6XdEhy13TaP9zWyvp6/5xJsQGZ6rIsdM0gR+A5upKBXnqDpVwrgJ/vfg/qy7ttUzQHXniLLhLs37SOyOrYW9ZIe1Q/obeaT2Ff70+PlFhQ3iqMNO063OTkcMj7UEpVEkQjokah1Q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24311DA7;
	Tue,  8 Oct 2024 07:21:08 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7510B3F64C;
	Tue,  8 Oct 2024 07:20:35 -0700 (PDT)
Message-ID: <db160fbd-ba7a-4cd0-88ed-2970a90c209b@arm.com>
Date: Tue, 8 Oct 2024 15:20:33 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
 <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com> <87ldyzubk4.ffs@tglx>
 <acfd8173-9ee5-460c-92d3-1cb48f8d3fc9@app.fastmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <acfd8173-9ee5-460c-92d3-1cb48f8d3fc9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/10/2024 14:11, Arnd Bergmann wrote:
> On Mon, Oct 7, 2024, at 16:23, Thomas Gleixner wrote:
>> On Fri, Oct 04 2024 at 13:13, Arnd Bergmann wrote:
>>> On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
>>>> The VDSO implementation includes headers from outside of the
>>>> vdso/ namespace.
>>>>
>>>> Introduce vdso/page.h to make sure that the generic library
>>>> uses only the allowed namespace.
>>>>
>>>> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
>>>> it supports 64-bit phys_addr_t we might end up in situation in which the
>>>> top 32 bit are cleared. To prevent this issue this patch provides
>>>> separate macros for PAGE_MASK.
>>>>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>
>>> Looks good to me. I would apply this to the asm-generic
>>> tree for 6.13, but there is one small detail I'm unsure
>>> about:
>>
>> Please don't. We have related changes upcoming for VDSO which would
>> heavily conflict. I rather take it through my tree.
> 
> Ok.
> 
> Vincenzo, in that case please add 
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> to the two paches when you send v4 to Thomas.
>

Thank you Arnd and Thomas,

I am completing the testing and will do that.

>      Arnd

-- 
Regards,
Vincenzo

