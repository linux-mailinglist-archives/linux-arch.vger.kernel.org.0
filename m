Return-Path: <linux-arch+bounces-7178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BB97374F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 14:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901B7B24E08
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DE19067A;
	Tue, 10 Sep 2024 12:28:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF401917DD;
	Tue, 10 Sep 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971338; cv=none; b=BLrbkM4FzQzfKx95UPXjz/8i+x+qLvrFBuIV3xoqVekTLXRb9E0GbtlESlPGArztLuoZED7l/09Ia8LBpn+lpxdM7QUNgQch3zj6f7gWTxUwb+Iq0kYnX7K/pOw4k16Se60tWPgf59ELpfj9eNNnfZcaaNNkmBNB7GPrabCDBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971338; c=relaxed/simple;
	bh=n34LZR4/qpKiZct0K9lqzEzS5dlXP8p0VQpr2dubN1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXU/gLYvZAk85RaTBknyFXEQ4hZvcRgsF6Ib0zTKqgVV96lFVoxRIT/5GgTs7bfYkYrRLWZBGUocIAhSpNoNCssU7DZlfXxIT8DpfBiFxh3s03gMtZdlP4EU6g9j4003MHEhxWWFQTtVGioCYO0pYt6sVFkjOVD4+FvMzZbtbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X330Q0FPrz9sPd;
	Tue, 10 Sep 2024 14:28:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g4B1QPtPZwoU; Tue, 10 Sep 2024 14:28:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X330P6NX8z9rvV;
	Tue, 10 Sep 2024 14:28:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C726F8B770;
	Tue, 10 Sep 2024 14:28:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id r9qBl1ofIMM4; Tue, 10 Sep 2024 14:28:53 +0200 (CEST)
Received: from [192.168.232.177] (unknown [192.168.232.177])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EBF1B8B766;
	Tue, 10 Sep 2024 14:28:52 +0200 (CEST)
Message-ID: <2234a5e1-5926-4b2d-a8f2-c780bf374a27@csgroup.eu>
Date: Tue, 10 Sep 2024 14:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
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
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
 <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
 <e28e1974-cced-462c-8f57-ca1474272e73@arm.com>
 <11527a80-7453-4624-b406-e88c5692b015@app.fastmail.com>
 <ccaac82f-0c43-491e-ab8a-1da8bf8c7477@csgroup.eu>
 <8868ef2c-6bfb-4ab7-ac5e-640e05658ee1@app.fastmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <8868ef2c-6bfb-4ab7-ac5e-640e05658ee1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/09/2024 à 22:48, Arnd Bergmann a écrit :
> On Fri, Sep 6, 2024, at 18:40, Christophe Leroy wrote:
>> Le 06/09/2024 à 21:19, Arnd Bergmann a écrit :
>>> On Fri, Sep 6, 2024, at 11:20, Vincenzo Frascino wrote:
> 
>>>> Looking at the definition of PAGE_SIZE and PAGE_MASK for each architecture they
>>>> all depend on CONFIG_PAGE_SHIFT but they are slightly different, e.g.:
>>>>
>>>> x86:
>>>> #define PAGE_SIZE        (_AC(1,UL) << PAGE_SHIFT)
>>>>
>>>> powerpc:
>>>> #define PAGE_SIZE        (ASM_CONST(1) << PAGE_SHIFT)
>>>>
>>>> hence I left to the architecture the responsibility of redefining the constants
>>>> for the VSDO.
>>>
>>> ASM_CONST() is a powerpc-specific macro that is defined the
>>> same way as _AC(). We could probably just replace all ASM_CONST()
>>> as a cleanup, but for this purpose, just remove the custom PAGE_SIZE
>>> and PAGE_SHIFT macros. This can be a single patch fro all
>>> architectures.
>>>
>>
>> I'm not worried about _AC versus ASM_CONST, but I am by the 1UL versus 1.
>>
>>
>> This can be a problem on 32 bits platforms with 64 bits phys_addr_t
> 
> But that would already be a bug if anything used this, however
> none of them do. The only instance of an open-coded
> 
> #define PAGE_SIZE       (1 << PAGE_SHIFT)
> 
> is from openrisc, but that is only used inside of __ASSEMBLY__, for
> the same effect as _AC().

Maybe I was not clear enough. The problem is not with PAGE_SHIFT but 
with PAGE_MASK, and that's what I show with my exemple.

If take the definition from ARM64 (which is the same as several other 
artchitectures):

#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
#define PAGE_MASK		(~(PAGE_SIZE-1))

PAGE_SHIFT is 12
PAGE_SIZE is then 4096 UL
PAGE_MASK is then 0xfffff000 UL

So if I take the probe() in drivers/uio/uio_pci_generic.c, it has:

	uiomem->addr = r->start & PAGE_MASK;

uiomem->addr is a phys_addr_t
r->start is a ressource_size_t hence a phys_addr_t

And phys_addr_t is defined as:

	#ifdef CONFIG_PHYS_ADDR_T_64BIT
	typedef u64 phys_addr_t;
	#else
	typedef u32 phys_addr_t;
	#endif

On a 32 bits platform, UL is unsigned 32 bits, so the r->start & 
PAGE_MASK will and r->start with 0x00000000fffff000

That is wrong.


That's the reason why powerpc does not define PAGE_MASK like ARM64 but 
defines PAGE_MASK as:

	(~((1 << PAGE_SHIFT) - 1))

When using 1 instead of 1UL, PAGE_MASK is still 0xfffff000 but it is a 
signed constant, so when it is anded with an u64, it gets 
signed-extended to 0xfffffffffffff000 which gives the expected result.

That's what I wanted to illustrate with the exemple in my previous 
message. The function f() was using the signed PAGE_MASK while function 
g() was using the unsigned PAGE_MASK:

00000000 <f>:
    0:    54 84 00 26     clrrwi  r4,r4,12
    4:    4e 80 00 20     blr

00000008 <g>:
    8:    54 84 00 26     clrrwi  r4,r4,12
    c:    38 60 00 00     li      r3,0
   10:    4e 80 00 20     blr

Function f() returns the given u64 value with the 12 lowest bits cleared
Function g() returns the given u64 value with the 12 lowest bits cleared 
and the 32 highest bits cleared as well, which is unexpected.

Christophe

