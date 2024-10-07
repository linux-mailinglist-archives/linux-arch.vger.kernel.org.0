Return-Path: <linux-arch+bounces-7732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703E99243D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00981B22EA9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 06:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC413C807;
	Mon,  7 Oct 2024 06:10:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25259143736;
	Mon,  7 Oct 2024 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281441; cv=none; b=hmuJPK6EDs7Fhk1Tcl7uHmHoY/CPjJGZ+jYRg85n1SNz4oZA00d0+i1BGfyM/DWfvZLisiMeduCP3zCv5LatZq0XT0RuSRiggrcuhJrEbZl2VnDGA+GF7gGaWWnJ4XJSgknYkP3Y1HavV5i//wS2sxAfC1LOYrkZUSPlzbfWqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281441; c=relaxed/simple;
	bh=Pz7YAkecEWI4lLC/CsyGcJiYbFNUqdqlEpWHPvlDfPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3DvBtZ1dPm83Aj9xOCZvIb5MQupNVEEiMmXw6Ia81KaBsSdK+zsosMOIRHRDXauH+nyVTRXS0SDdwBOrHXLomcC5ja8GfKJk9QfL89TFuQQ98sbb0jIypWBqliGdVV10xPkn3dvO5fTTc0zQtWCO2uId7vr6tgo3XlJGR0WzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XMTKS6Q7Rz9sPd;
	Mon,  7 Oct 2024 08:10:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DIML3QXE3sOd; Mon,  7 Oct 2024 08:10:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XMTKS5XC8z9rvV;
	Mon,  7 Oct 2024 08:10:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AB1AD8B765;
	Mon,  7 Oct 2024 08:10:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id XZVaR_2kVu_W; Mon,  7 Oct 2024 08:10:36 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 556AB8B764;
	Mon,  7 Oct 2024 08:10:36 +0200 (CEST)
Message-ID: <0a419a1d-6124-411c-bcae-a8dac87f73d0@csgroup.eu>
Date: Mon, 7 Oct 2024 08:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm: Fix fault format
To: Arnd Bergmann <arnd@arndb.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-2-vincenzo.frascino@arm.com>
 <5b52dfcf-7b4c-4715-b1b2-6e41062302bd@app.fastmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <5b52dfcf-7b4c-4715-b1b2-6e41062302bd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/10/2024 à 15:21, Arnd Bergmann a écrit :
> On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c
>> b/drivers/gpu/drm/i915/gt/intel_gt.c
>> index a6c69a706fd7..352ef5e1c615 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
>> @@ -308,7 +308,7 @@ static void gen6_check_faults(struct intel_gt *gt)
>>   		fault = GEN6_RING_FAULT_REG_READ(engine);
>>   		if (fault & RING_FAULT_VALID) {
>>   			gt_dbg(gt, "Unexpected fault\n"
>> -			       "\tAddr: 0x%08lx\n"
>> +			       "\tAddr: 0x%08x\n"
>>   			       "\tAddress space: %s\n"
>>   			       "\tSource ID: %d\n"
>>   			       "\tType: %d\n",
> 
> Isn't the type of PAGE_MASK still architecture dependent?

Indeed when I commented that PAGE_MASK was type agnostic I was thinking 
about the powerpc PAGE_MASK:

#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))

It should probably be possible to generalise it to all architectures.

But if you keep some PAGE_MASK with forced UL type just like:

#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
#define PAGE_MASK		(~(PAGE_SIZE-1))

Then that version of PAGE_MASK isn't agnostic and ANDing an int with 
that mask makes a long result.

> I think you need a cast to either 'int' or 'long' here to
> make the corresponding format string work across all
> architectures. With the current version of your patch 2/2,
> it looks like it has to be %x for architectures with
> 64-bit phys_addr_t, but %lx for the other ones.
> 
> Changing the 'u32 fault' variable to 'unsigned long'
> would also work here.
> 
>        Arnd

