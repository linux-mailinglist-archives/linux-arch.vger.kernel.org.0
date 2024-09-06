Return-Path: <linux-arch+bounces-7122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE29707E4
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 15:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F94281429
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE116F909;
	Sun,  8 Sep 2024 13:53:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFA158528;
	Sun,  8 Sep 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725803590; cv=none; b=smyNS7lrSdoZqAn6xL5cdP6yjz3jKa6wOVYXuNqkbehGAevGnWCno4/cHTiKOG4sZAadapq5qc+d+kFV75zq5z4phM74PiZuHp7HPaRe4AZUBHNauNQs+S5pK3ar7rWagrXChjAPUZY2hbG8iftidRjwrGseoBr4EoswnP7Syxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725803590; c=relaxed/simple;
	bh=aEdLEikBSLEPzKcxCjBbIOioRyI64/UAVQIiVNGhYT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVyl2I7h7dvhhl/yfWweoKqV1ZVAiKRQ6FCI3Cg0WO0mJ5ExTsDSLnKgm+ieXB3ka3hbGAFd7aev4xL35+jlS/y/kw8CaOOZoHYOtEEsbYqtBWPYbBU9NjTC2KJIa2uhPvhuFDwzgyBBLP2iu4YTL4E8bo8oRWOmDvsygEV3YF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X1ryW1Z3zz9sS7;
	Sun,  8 Sep 2024 15:53:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xr9tftewbl7Q; Sun,  8 Sep 2024 15:53:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X1rvW6thvz9sWW;
	Sun,  8 Sep 2024 15:50:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E3AC8BFDA;
	Fri,  6 Sep 2024 20:40:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DQ3Yl1oMtObJ; Fri,  6 Sep 2024 20:40:50 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6735D8BFD1;
	Fri,  6 Sep 2024 20:40:49 +0200 (CEST)
Message-ID: <ccaac82f-0c43-491e-ab8a-1da8bf8c7477@csgroup.eu>
Date: Fri, 6 Sep 2024 20:40:49 +0200
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <11527a80-7453-4624-b406-e88c5692b015@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arnd,

Le 06/09/2024 à 21:19, Arnd Bergmann a écrit :
> On Fri, Sep 6, 2024, at 11:20, Vincenzo Frascino wrote:
>> On 04/09/2024 15:52, Arnd Bergmann wrote:
>>> On Tue, Sep 3, 2024, at 15:14, Vincenzo Frascino wrote:
>> Looking at the definition of PAGE_SIZE and PAGE_MASK for each architecture they
>> all depend on CONFIG_PAGE_SHIFT but they are slightly different, e.g.:
>>
>> x86:
>> #define PAGE_SIZE        (_AC(1,UL) << PAGE_SHIFT)
>>
>> powerpc:
>> #define PAGE_SIZE        (ASM_CONST(1) << PAGE_SHIFT)
>>
>> hence I left to the architecture the responsibility of redefining the constants
>> for the VSDO.
> 
> ASM_CONST() is a powerpc-specific macro that is defined the
> same way as _AC(). We could probably just replace all ASM_CONST()
> as a cleanup, but for this purpose, just remove the custom PAGE_SIZE
> and PAGE_SHIFT macros. This can be a single patch fro all
> architectures.
> 

I'm not worried about _AC versus ASM_CONST, but I am by the 1UL versus 1.

The two functions below don't provide the same result:

#define PAGE_SIZE (1 << 12)
#define PAGE_MASK (~(PAGE_SIZE - 1))

unsigned long long f(unsigned long long x)
{
	return x & PAGE_MASK;
}

#define PAGE_SIZE_2 (1UL << 12)
#define PAGE_MASK_2 (~(PAGE_SIZE_2 - 1))

unsigned long long g(unsigned long long x)
{
	return x & PAGE_MASK_2;
}

00000000 <f>:
    0:	54 84 00 26 	clrrwi  r4,r4,12
    4:	4e 80 00 20 	blr

00000008 <g>:
    8:	54 84 00 26 	clrrwi  r4,r4,12
    c:	38 60 00 00 	li      r3,0
   10:	4e 80 00 20 	blr


This can be a problem on 32 bits platforms with 64 bits phys_addr_t

Christophe

