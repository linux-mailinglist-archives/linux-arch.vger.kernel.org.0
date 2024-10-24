Return-Path: <linux-arch+bounces-8520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A39AE31B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 12:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF2B1C223F5
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647B1C8FCE;
	Thu, 24 Oct 2024 10:52:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249F176AAD;
	Thu, 24 Oct 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767175; cv=none; b=gOfo3Wfoca++OGmgNWwnFY9LOeolu56VpUWmGSQPuVxJUtBpqbC0z7rstA5O5Y4g4xNTG/EW9KbShKmCv1z6fm0WVTCv5BcjtTg16VI9WUkpWnFbEwHPNEDCKuYPk8eo0Xj1zK7U0lNb3CRkgI6s8tBhR+DzFCpGzcWAUOMmyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767175; c=relaxed/simple;
	bh=gPlA1+J0NJzLZMqSBN3DdFrWVxb4cP6uwM/TMB44Xh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2odxkdl13w70K1QbFujqkSUxRsrfHonhmrMTjh7bvNymP+5nA+36n+q0rdIY26Dq917WBfHbIcA5pbbzEgYHDGrFaMt0w+sXmFwcKXiLTWNaX1CZIUzeeoKHaGjDAeG+rPjC7KCWeTWfB7W41U8cTW/kJ2XUSeI5+q6Qh66y64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D23C339;
	Thu, 24 Oct 2024 03:53:21 -0700 (PDT)
Received: from [10.1.30.45] (e122027.cambridge.arm.com [10.1.30.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67C983F71E;
	Thu, 24 Oct 2024 03:52:42 -0700 (PDT)
Message-ID: <b11631ba-224f-41fb-b82e-59f1b258aea1@arm.com>
Date: Thu, 24 Oct 2024 11:52:40 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <yu7um2tcxg2apoz372rmzpkrfgbb42ndvabvrsp4usb2e3bkrf@huaucjsp5vlj>
 <Ztnp3OAIRz/daj7s@ghost>
 <pbotlphw77fkfacldtpxfjcs2w5nhb2uvxszv5rmlrhjm42akd@4pvcqb7ojq4v>
 <b6ca55b7-4de2-4085-97bd-619f91d9fcb8@arm.com>
 <5u7xntjdye5ejjmkgpp7m3ogpzblxcztrwngulejdft63fzuwf@xcxfcbaccqtw>
 <07c5e292-5218-43ee-a167-da09d108a663@arm.com>
 <gcyxymiqvxgkkhn76a6ksvevzcq36rridwakgyjsa24obcab3t@leqlqjcx3va3>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <gcyxymiqvxgkkhn76a6ksvevzcq36rridwakgyjsa24obcab3t@leqlqjcx3va3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 19:10, Liam R. Howlett wrote:
> * Steven Price <steven.price@arm.com> [241023 05:31]:
>>>>   * Box64 seems to have a custom allocator based on reading 
>>>>     /proc/self/maps to allocate a block of VA space with a low enough 
>>>>     address [1]
>>>>
>>>>   * PHP has code reading /proc/self/maps - I think this is to find a 
>>>>     segment which is close enough to the text segment [2]
>>>>
>>>>   * FEX-Emu mmap()s the upper 128TB of VA on Arm to avoid full 48 bit
>>>>     addresses [3][4]
>>>
>>> Can't the limited number of applications that need to restrict the upper
>>> bound use an LD_PRELOAD compatible library to do this?
>>
>> I'm not entirely sure what point you are making here. Yes an LD_PRELOAD
>> approach could be used instead of a personality type as a 'hack' to
>> preallocate the upper address space. The obvious disadvantage is that
>> you can't (easily) layer LD_PRELOAD so it won't work in the general case.
> 
> My point is that riscv could work around the limited number of
> applications that requires this.  It's not really viable for you.

Ah ok - thanks for the clarification.

>>
>>>>
>>>>   * pmdk has some funky code to find the lowest address that meets 
>>>>     certain requirements - this does look like an ALSR alternative and 
>>>>     probably couldn't directly use MAP_BELOW_HINT, although maybe this 
>>>>     suggests we need a mechanism to map without a VA-range? [5]
>>>>
>>>>   * MIT-Scheme parses /proc/self/maps to find the lowest mapping within 
>>>>     a range [6]
>>>>
>>>>   * LuaJIT uses an approach to 'probe' to find a suitable low address 
>>>>     for allocation [7]
>>>>
>>>
>>> Although I did not take a deep dive into each example above, there are
>>> some very odd things being done, we will never cover all the use cases
>>> with an exact API match.  What we have today can be made to work for
>>> these users as they have figured ways to do it.
>>>
>>> Are they pretty? no.  Are they common? no.  I'm not sure it's worth
>>> plumbing in new MM code in for these users.
>>
>> My issue with the existing 'solutions' is that they all seem to be fragile:
>>
>>  * Using /proc/self/maps is inherently racy if there could be any other
>> code running in the process at the same time.
> 
> Yes, it is not thread safe.  Parsing text is also undesirable.
> 
>>
>>  * Attempting to map the upper part of the address space only works if
>> done early enough - once an allocation arrives there, there's very
>> little you can robustly do (because the stray allocation might be freed).
>>
>>  * LuaJIT's probing mechanism is probably robust, but it's inefficient -
>> LuaJIT has a fallback of linear probing, following by no hint (ASLR),
>> followed by pseudo-random probing. I don't know the history of the code
>> but it looks like it's probably been tweaked to try to avoid performance
>> issues.
>>
>>>> The biggest benefit I see of MAP_BELOW_HINT is that it would allow a
>>>> library to get low addresses without causing any problems for the rest
>>>> of the application. The use case I'm looking at is in a library and 
>>>> therefore a personality mode wouldn't be appropriate (because I don't 
>>>> want to affect the rest of the application). Reading /proc/self/maps
>>>> is also problematic because other threads could be allocating/freeing
>>>> at the same time.
>>>
>>> As long as you don't exhaust the lower limit you are trying to allocate
>>> within - which is exactly the issue riscv is hitting.
>>
>> Obviously if you actually exhaust the lower limit then any
>> MAP_BELOW_HINT API would also fail - there's really not much that can be
>> done in that case.
> 
> Today we reverse the search, so you end up in the higher address
> (bottom-up vs top-down) - although the direction is arch dependent.
> 
> If the allocation is too high/low then you could detect, free, and
> handle the failure.

Agreed, that's fine.

>>
>>> I understand that you are providing examples to prove that this is
>>> needed, but I feel like you are better demonstrating the flexibility
>>> exists to implement solutions in different ways using todays API.
>>
>> My intention is to show that today's API doesn't provide a robust way of
>> doing this. Although I'm quite happy if you can point me at a robust way
>> with the current API. As I mentioned my goal is to be able to map memory
>> in a (multithreaded) library with a (ideally configurable) number of VA
>> bits. I don't particularly want to restrict the whole process, just
>> specific allocations.
> 
> If you don't need to restrict everything, won't the hint work for your
> usecase?  I must be missing something from your requirements.

The hint only works if the hint address is actually free. Otherwise
mmap() falls back to as if the hint address wasn't specified.

E.g.

> 	for(int i = 0; i < 2; i++) {
> 		void *addr = mmap((void*)(1UL << 32), PAGE_SIZE, PROT_NONE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 		printf("%p\n", addr);
> 	}

Prints something like:

0x100000000
0x7f20d21e0000

The hint is ignored for the second mmap() because there's already a VMA
at the hint address.

So the question is how to generate a hint value that is (or has a high
likelihood of being) empty? This AFAICT is the LuaJIT approach, but
their approach is to pick random values in the hope of getting a free
address (and then working linearly up for subsequent allocations). Which
doesn't meet my idea of "robust".

>>
>> I had typed up a series similar to this one as a MAP_BELOW flag would
>> fit my use-case well.
>>
>>> I think it would be best to use the existing methods and work around the
>>> issue that was created in riscv while future changes could mirror amd64
>>> and arm64.
>>
>> The riscv issue is a different issue to the one I'm trying to solve. I
>> agree MAP_BELOW_HINT isn't a great fix for that because we already have
>> differences between amd64 and arm64 and obviously no software currently
>> out there uses this new flag.
>>
>> However, if we had introduced this flag in the past (e.g. if MAP_32BIT
>> had been implemented more generically, across architectures and with a
>> hint value, like this new flag) then we probably wouldn't be in this
>> situation. Applications that want to restrict the VA space would be able
>> to opt-in and be portable across architectures.
> 
> I don't think that's true.  Some of the applications want all of the
> allocations below a certain threshold and by the time they are adding
> flags to allocations, it's too late.  What you are looking for is a
> counterpart to mmap_min_addr, but for higher addresses?  This would have
> to be set before any of the allocations occur for a specific binary (ie:
> existing libraries need to be below that threshold too), I think?

Well that's not what *I* am looking for. A mmap_max_addr might be useful
for others for the purpose of restricting all allocations.

I think there are roughly three classes of application:

 1. Applications which do nothing special with pointers. This is most
applications and they could benefit from any future expansions to the VA
size without any modification. E.g. if 64 bit VA addresses were somehow
available they could deal with them today (without recompilation).

 2. Applications which need VA addresses to meet certain requirements.
They might be emulating another architecture (e.g. FEX) and want
pointers that can be exposed to the emulation. They might be aware of
restrictions in JIT code (e.g. PHP). Or they might want to store
pointers in 'weird' ways which involve fewer bits - AFAICT that's the
LuaJIT situation. These applications are usually well aware that they
are doing something "unusual" and would likely use a Linux API if it
existed.

 3. Applications which abuse the top bits of a VA because they've read
the architecture documentation and they "know" that the VA space is limited.

Class 3 would benefit from mmap_max_addr - either because the
architecture has been extended (although that's been worked around by
requiring the hint value to allocate into the top address space) or
because they get ported to another architecture (which I believe is the
RiscV issue). There is some argument these applications are buggy but
"we don't break userspace" so we deal with them in kernel until they get
ported and then ideally the bugs are fixed.

Class 1 is the applications we know and love, they don't need anything
special.

Class 2 is the case I care about. The application knows it wants special
addresses, and in the cases I've detailed there has been significant
code written to try to achieve this. But the kernel isn't currently
providing a good mechanism to do this.

>>
>> Another potential option is a mmap3() which actually allows the caller
>> to place constraints on the VA space (e.g. minimum, maximum and
>> alignment). There's plenty of code out there that has to over-allocate
>> and munmap() the unneeded part for alignment reasons. But I don't have a
>> specific need for that, and I'm guessing you wouldn't be in favour.
> 
> You'd probably want control of the direction of the search too.

Very true, and one of the reasons I don't want to do a mmap3() is that
I'm pretty I'd miss something.

> I think mmap3() would be difficult to have accepted as well.

And that's the other major reason ;)

Thanks,

Steve

> ...
> 
> Thanks,
> Liam
> 


