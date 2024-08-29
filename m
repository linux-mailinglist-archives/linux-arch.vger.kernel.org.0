Return-Path: <linux-arch+bounces-6834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F99652C1
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 00:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B37D284742
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 22:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76221BAEF1;
	Thu, 29 Aug 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e5UZR09F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E21BA88A
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969822; cv=none; b=SoZBqMIJBjdixk89RZF+b9z/BWLY47yEwHuV2v2ip5NpGkttKLNFww0H8q9JHCrRDs3wL1uThOvO2g+x6mJuFwszvjlGFDHmY37Aj79o8t1hMfz+dsXDhTZrA4m+oxDN1zKQctT4+7Rjbc3p8kH4Mpm1hFVCqTtDSe3GAei7uXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969822; c=relaxed/simple;
	bh=S3Y5v+4JXY8rGBGuZcXLnLhZBs+40lbnirdI/7xGkfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKVI2Aa+P1S+z5MrGWVysJrM1R9quF2nwszgErXYtcbWw7UfygfTxwDpZEiElA9uXse5GpaLHicDj/IUjXoKkMN1eEPO09mHP9c3FnoS9g6VZhsC7DWzHubAuCx659uyjfvGS0c1RL+0mxidLmHxgzMW8hNjzjFA6cK5pH10L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e5UZR09F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7148912a1ebso746187b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724969819; x=1725574619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HRU/HuL9VMJOh5LMUQaHyrA0RHNWNSx8V73gtED6wE=;
        b=e5UZR09FTg525+yZdqOakS5M172xK1w4Wg6EGtu59UzsDAqKe5KerUpLpRCr+FeWHQ
         V3zETWgyqgc+AVjRRz45hEMT3lTh54/Us3SJhwo84nEk6jQlXNWB9PqBNYObZ5BlLApa
         /6aA/N8BYhLgKySNlZsGzMXbLvTO1aRFEmRSUqMOHBhOeNTrj/bwUH82iEorsGzyfnkI
         qAsZYmrdf0IjHJeSOSyGRWGwYLWN4rIdt5FfU5h3Rs1rsrEbXD7EOSgQ2aUSjmaFjJZG
         Zv3sizkYRJo4pdfM+39OpMl31kVpJ29rmuZYGsgvk3I56oZjCJwXrX6yvsBn6853p4mA
         vvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724969819; x=1725574619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HRU/HuL9VMJOh5LMUQaHyrA0RHNWNSx8V73gtED6wE=;
        b=qStQckpcSbIErhT3dqii1A9/ylzt9fYvQHEDYsxL4qxdrF2NPVSMLZJmeudVmDNttj
         8S2eoSezaAUG9KPVQvxMsQ52TiKvnZPcAp4OrzF1U+VkXJS4mC056IJpOmOaFPL22GxM
         ahykZjUOhvU+QHk3wQEdRbhyzrECrPk/KrPEUlUB0u5TVfiADSU3irlS3JxalIe3Xhfn
         BMdQYG6A7oqvidOmq1PWuX+sjYjwSEHbJUAptLp+G2xtqDnNGn2FPcBSIvCmF3YXxu9s
         xeomKA3uL+rvr0/EOwg86vG2tAnIEcLfU4peHD/4BoUzLk+IRVWBtm5Q7yLRBwFiiMvL
         doeA==
X-Forwarded-Encrypted: i=1; AJvYcCXk5Oj9sYKdS4exeMZKhJcpjSjlaki3PwWnjzDMYJUBrqgJ7OryjglLB+hmSHcIew2NhoD/BsfetM3i@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAVezZdfKXojiW13ySQgQvplSElEVbzT6kLXVC6LQVj8Se0g4
	8I0swFW2i7beKf1CU0EzUbU8xmC9EVUqjToa6sXc49IlYsxbcVpWsGa3MY8FRVY=
X-Google-Smtp-Source: AGHT+IHZWh2lrRdTfsFvpo/hEhoIVlXgetb87CMqVZNsK2T/td7vE55JQIoBH8+ZybjcSDXzxTcolg==
X-Received: by 2002:a05:6a21:38c:b0:1c2:8b95:de15 with SMTP id adf61e73a8af0-1cce111b331mr4094496637.53.1724969818957;
        Thu, 29 Aug 2024 15:16:58 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a4ecasm1612655b3a.71.2024.08.29.15.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 15:16:58 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:16:53 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <ZtDzVZLrcbiKRium@ghost>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
 <4e1e9f49-8da4-4832-972b-2024d623a7bb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1e9f49-8da4-4832-972b-2024d623a7bb@lucifer.local>

On Thu, Aug 29, 2024 at 10:54:25AM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 29, 2024 at 09:42:22AM GMT, Lorenzo Stoakes wrote:
> > On Thu, Aug 29, 2024 at 12:15:57AM GMT, Charlie Jenkins wrote:
> > > Some applications rely on placing data in free bits addresses allocated
> > > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > > address returned by mmap to be less than the 48-bit address space,
> > > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > > for the kernel address space).
> >
> > I'm still confused as to why, if an mmap flag is desired, and thus programs
> > are having to be heavily modified and controlled to be able to do this, why
> > you can't just do an mmap() with PROT_NONE early, around a hinted address
> > that, sits below the required limit, and then mprotect() or mmap() over it?
> >
> > Your feature is a major adjustment to mmap(), it needs to be pretty
> > significantly justified, especially if taking up a new flag.
> >
> > >
> > > The riscv architecture needs a way to similarly restrict the virtual
> > > address space. On the riscv port of OpenJDK an error is thrown if
> > > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > > has a comment that sv57 support is not complete, but there are some
> > > workarounds to get it to mostly work [2].
> > >
> > > These applications work on x86 because x86 does an implicit 47-bit
> > > restriction of mmap() address that contain a hint address that is less
> > > than 48 bits.
> >
> > You mean x86 _has_ to limit to physically available bits in a canonical
> > format :) this will not be the case for 5-page table levels though...

I might be misunderstanding but I am not talking about pointer masking
or canonical addresses here. I am referring to the pattern of:

1. Getting an address from mmap()
2. Writing data into bits assumed to be unused in the address
3. Using the data stored in the address
4. Clearing the data from the address and sign extending
5. Dereferencing the now sign-extended address to conform to canonical
   addresses

I am just talking about step 1 and 2 here -- getting an address from
mmap() that only uses bits that will allow your application to not
break. How canonicalization happens is a a separate conversation, that
can be handled by LAM for x86, TBI for arm64, or Ssnpm for riscv.
While LAM for x86 is only capable of masking addresses to 48 or 57 bits,
Ssnpm for riscv allow an arbitrary number of bits to be masked out.
A design goal here is to be able to support all of the pointer masking
flavors, and not just x86.

> >
> > >
> > > Instead of implicitly restricting the address space on riscv (or any
> > > current/future architecture), a flag would allow users to opt-in to this
> > > behavior rather than opt-out as is done on other architectures. This is
> > > desirable because it is a small class of applications that do pointer
> > > masking.
> >
> > I raised this last time and you didn't seem to address it so to be more
> > blunt:
> >
> > I don't understand why this needs to be an mmap() flag. From this it seems
> > the whole process needs allocations to be below a certain limit.

Yeah making it per-process does seem logical, as it would help with
pointer masking.

> >
> > That _could_ be achieved through a 'personality' or similar (though a
> > personality is on/off, rather than allowing configuration so maybe
> > something else would be needed).
> >
> > From what you're saying 57-bit is all you really need right? So maybe
> > ADDR_LIMIT_57BIT?

Addresses will always be limited to 57 bits on riscv and x86 (but not
necessarily on other architectures). A flag like that would have no
impact, I do not understand what you are suggesting. This patch is to
have a configurable number of bits be restricted.

If anything, a personality that was ADDR_LIMIT_48BIT would be the
closest to what I am trying to achieve. Since the issue is that
applications fail to work when the address space is greater than 48
bits.

> >
> > I don't see how you're going to actually enforce this in a process either
> > via an mmap flag, as a library might decide not to use it, so you'd need to
> > control the allocator, the thread library implementation, and everything
> > that might allocate.

It is reasonable to change the implementation to be per-process but that
is not the current proposal.

This flag was designed for applications which already directly manage
all of their addresses like OpenJDK and Go.

This flag implementation was an attempt to make this feature as least
invasive as possible to reduce maintainence burden and implementation
complexity.

> >
> > Liam also raised various points about VMA particulars that I'm not sure are
> > addressed either.
> >
> > I just find it hard to believe that everything will fit together.
> >
> > I'd _really_ need to be convinced that this MAP_ flag is justified, and I"m
> > just not.
> >
> > >
> > > This flag will also allow seemless compatibility between all
> > > architectures, so applications like Go and OpenJDK that use bits in a
> > > virtual address can request the exact number of bits they need in a
> > > generic way. The flag can be checked inside of vm_unmapped_area() so
> > > that this flag does not have to be handled individually by each
> > > architecture.
> >
> > I'm still very unconvinced and feel the bar needs to be high for making
> > changes like this that carry maintainership burden.
> >

I may be naive but what is the burden here? It's two lines of code to
check MAP_BELOW_HINT and restrict the address. There are the additional
flags for hint and mmap_addr but those are also trivial to implement.

> > So for me, it's a no really as an overall concept.
> >
> > Happy to be convinced otherwise, however... (I may be missing details or
> > context that provide more justification).
> >
> 
> Some more thoughts:
> 
> * If you absolutely must keep allocations below a certain limit, you'd
>   probably need to actually associate this information with the VMA so the
>   memory can't be mremap()'d somewhere invalid (you might not control all
>   code so you can't guarantee this won't happen).
> * Keeping a map limit associated with a VMA would be horrid and keeping
>   VMAs as small as possible is a key aim, so that'd be a no go. VMA flags
>   are in limited supply also.

Yes that does seem like it would be challenging.

> * If we did implement a per-process thing, but it were arbitrary, we'd then
>   have to handle all kinds of corner cases forever (this is UAPI, can't
>   break it etc.) with crazy-low values, or determine a minimum that might
>   vary by arch...

Throwing an error if the value is determined to be "too low" seems
reasonable.

> * If we did this we'd absolutely have to implement a check in the brk()
>   implementation, which is a very very sensitive bit of code. And of
>   course, in mmap() and mremap()... and any arch-specific code that might
>   interface with this stuff (these functions are hooked).
> * A fixed address limit would make more sense, but it seems difficult to
>   know what would work for everybody, and again we'd have to deal with edge
>   cases and having a permanent maintenance burden.

A fixed value is not ideal, since a single size probably would not be
suffiecient for every application. However if necessary we could fix it
to 48-bits since arm64 and x86 already do that, and that would still
allow a generic way of defining this behavior.

> * If you did have a map flag what about merging between VMAs above the
>   limit and below it? To avoid that you'd need to implement some kind of a
>   'VMA flag that has an arbitrary characteristic' or a 'limit' field,
>   adjust all the 'can VMA merge' functions and write extensive testing and
>   none of that is frankly acceptable.
> * We have some 'weird' arches that might have problem with certain virtual
>   address ranges or require arbitrary mappings at a certain address range
>   that a limit might not be able to account for.
> 
> I'm absolutely opposed to a new MAP_ flag for this, but even if you
> implemented that, it implies a lot of complexity.
> 
> It implies even more complexity if you implement something per-process
> except if it were a fixed limit.
> 
> And if you implement a fixed limit, it's hard to see that it'll be
> acceptable to everybody, and I suspect we'd still run into some possible
> weirdness.
> 
> So again, I'm struggling to see how this concept can be justified in any
> form.

The piece I am missing here is that this idea is already being used by
x86 and arm64. They implicitly force all allocations to be below the
47-bit boundary if the hint address is below 47 bits. This flag is much
less invasive because it is opt-in and will not impact any existing
code. I am not familiar enough with all of the interactions spread
throughout mm to know how these architectures have managed to ensure
that this 48-bit limit is enforced across things like mremap() as well.

Are you against the idea that there should be a standard way for
applications to consistently obtain address that have free bits, or are
you just against this implementation? From your statement I assume you
mean that every architecture should continue to have varying behavior
and separate implementations for supporting larger address spaces.

- Charlie


