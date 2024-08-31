Return-Path: <linux-arch+bounces-6883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0C966E81
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 03:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8440C1F23EFA
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 01:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191982C87C;
	Sat, 31 Aug 2024 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3XcPAx6O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A722611
	for <linux-arch@vger.kernel.org>; Sat, 31 Aug 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725068758; cv=none; b=qWag4/WyFs99G2zWgZFs/ASbAQgDxyuPtbfJApu60Yng5duJrJ/iPiOSazh+0JxKbkNOXwGak3J4v/5yL35MtGSKcutEDJd2L/eDmLpPdr0W3y9r/gaAVCvngU3sNYc1nPNQuLmqzu9gjRkmNzUD/hUmCZNY1PjFkpJrwiZw/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725068758; c=relaxed/simple;
	bh=2nZ/phqd9zUIZNf3VU8cPyu+P7jbu8CALYM+pmW9h24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7GGukvjXAi2N972BCSw1dfVNsTBtUDmpV5L38pH4UM/dV52/eg5WCOhhbayQ19U1lwKSFrqFFLXsL1lQWBlahZoX6nKikqkj0gPZ6PuSdxaHhc+3KDMCNmU9TcfWS7diEv5JE2rSNv8AO1vlbt5gHjKwCbz7MgDHzX8aowAKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3XcPAx6O; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3df08d53820so1326170b6e.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725068754; x=1725673554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWQ958MOBtA3GjvWU1gp01NcgMHFs7/eNjRoTvtuHOU=;
        b=3XcPAx6Ozx1imZLEBImmLJdhYpLBGDpB2tGK+QW9BULLZ42mbM2FQTbMgTLjuegDPo
         rdNUpx5VBlTyJ35rtWSLMyp93n4b+Pas79JOq08AoEj/st4AlK/WxFRN53spLvEEVn8Y
         BWx1U+X7x64fRTIBkV9PJZ7ew2ayINEFAVTMscN8eKYQJP3UBzetw0Qzz2jdlBOOJs86
         01pPKmwfX8lXZ5/KXEoBaIcX0R0oGIVw0LZ9ckYCN7IT5sf5z8SJCuIjKFnNfPQ9bbMQ
         rH1suu/SoG1rJd4Qq+DMc6QtOYsrAFhkyOB6JgOi5/giktW99pY1Y+hcDqFzWielUdsV
         tmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725068754; x=1725673554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWQ958MOBtA3GjvWU1gp01NcgMHFs7/eNjRoTvtuHOU=;
        b=FkM5hwXq+ykrh4ED0QDg/rbalJXPlBRqclOXsyCHTl4JJakJiaDfW4DOBMyyEBlHnp
         e2mu49lJ32MzSsf1oiHYUamKaOWcL51i9HXSmNnL10RvUmkY7wKhfrlBOBEjTEhEvKSc
         r8qD7nS6QebafPkuqGo6aoWvNXG7eWKufE0v3GrF+UGx7RF2m+Mu9xi+45eXFFLjnORX
         SOBNurMRgXOL15lKg8tCUAb6FKer5aI4xHd7WtARFa8zuMp7v6TL2pkGRF5jt9TpEvFL
         pY91G25xD00yew8LKU+n8V48XH66bPe5BVWS6BFOh1+4qoYszwH4F4+NM1t98oXNDBZX
         YVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAIgxJVo+PR7WfwlS68euGE4Bj+ABpeAr4/VDwxXvdZDSxyv2r7robr3xJxlqchNJQOz6uVjZqzfvu@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPnEd31UkZgeEvtVd2jQeueSktwcKqDpwUOqqq958EgTiz59R
	RRwM3Ozf69HpZojTbWWcsBkBES1h6pVu00pTdBtZJxxpFJCyWz4YZIa14MIqJbQ=
X-Google-Smtp-Source: AGHT+IFi2HK/l/FY7SmSHqzhOPJTOA9tjJwRHbcyC4AyXXIo3z6WC91Eur3TRe9GO4wG0WnnoAgfhA==
X-Received: by 2002:a05:6808:1988:b0:3d9:2fd5:6c14 with SMTP id 5614622812f47-3df1c110388mr1307949b6e.29.1725068754046;
        Fri, 30 Aug 2024 18:45:54 -0700 (PDT)
Received: from ghost (c-67-164-127-253.hsd1.ca.comcast.net. [67.164.127.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5761eecsm3339302b3a.212.2024.08.30.18.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 18:45:53 -0700 (PDT)
Date: Fri, 30 Aug 2024 18:45:48 -0700
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
Message-ID: <ZtJ1zJWV60NGI6vi@ghost>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
 <4e1e9f49-8da4-4832-972b-2024d623a7bb@lucifer.local>
 <ZtDzVZLrcbiKRium@ghost>
 <b31a2c87-0c90-4062-9feb-6d6b813c0bde@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31a2c87-0c90-4062-9feb-6d6b813c0bde@lucifer.local>

On Fri, Aug 30, 2024 at 10:52:01AM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 29, 2024 at 03:16:53PM GMT, Charlie Jenkins wrote:
> > On Thu, Aug 29, 2024 at 10:54:25AM +0100, Lorenzo Stoakes wrote:
> > > On Thu, Aug 29, 2024 at 09:42:22AM GMT, Lorenzo Stoakes wrote:
> > > > On Thu, Aug 29, 2024 at 12:15:57AM GMT, Charlie Jenkins wrote:
> > > > > Some applications rely on placing data in free bits addresses allocated
> > > > > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > > > > address returned by mmap to be less than the 48-bit address space,
> > > > > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > > > > for the kernel address space).
> > > >
> > > > I'm still confused as to why, if an mmap flag is desired, and thus programs
> > > > are having to be heavily modified and controlled to be able to do this, why
> > > > you can't just do an mmap() with PROT_NONE early, around a hinted address
> > > > that, sits below the required limit, and then mprotect() or mmap() over it?
> > > >
> > > > Your feature is a major adjustment to mmap(), it needs to be pretty
> > > > significantly justified, especially if taking up a new flag.
> > > >
> > > > >
> > > > > The riscv architecture needs a way to similarly restrict the virtual
> > > > > address space. On the riscv port of OpenJDK an error is thrown if
> > > > > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > > > > has a comment that sv57 support is not complete, but there are some
> > > > > workarounds to get it to mostly work [2].
> > > > >
> > > > > These applications work on x86 because x86 does an implicit 47-bit
> > > > > restriction of mmap() address that contain a hint address that is less
> > > > > than 48 bits.
> > > >
> > > > You mean x86 _has_ to limit to physically available bits in a canonical
> > > > format :) this will not be the case for 5-page table levels though...
> >
> > I might be misunderstanding but I am not talking about pointer masking
> > or canonical addresses here. I am referring to the pattern of:
> >
> > 1. Getting an address from mmap()
> > 2. Writing data into bits assumed to be unused in the address
> > 3. Using the data stored in the address
> > 4. Clearing the data from the address and sign extending
> > 5. Dereferencing the now sign-extended address to conform to canonical
> >    addresses
> >
> > I am just talking about step 1 and 2 here -- getting an address from
> > mmap() that only uses bits that will allow your application to not
> > break. How canonicalization happens is a a separate conversation, that
> > can be handled by LAM for x86, TBI for arm64, or Ssnpm for riscv.
> > While LAM for x86 is only capable of masking addresses to 48 or 57 bits,
> > Ssnpm for riscv allow an arbitrary number of bits to be masked out.
> > A design goal here is to be able to support all of the pointer masking
> > flavors, and not just x86.
> 
> Right I get that, I was just saying that the implicit limitation in x86 is
> due to virtual addresses _having_ to be less than 48 bits. So that's why
> that is right? I mean perhaps I'm mistaken?
> 
> Or is it such that x86 can provide a space for tagging for CPU technology
> that supports it (UAI perhaps?).
> 
> I agree with what Michal and others said about the decision to default to
> the reduced address space size and opt-in for higher bits. Your series
> doesn't do this...
> 
> >
> > > >
> > > > >
> > > > > Instead of implicitly restricting the address space on riscv (or any
> > > > > current/future architecture), a flag would allow users to opt-in to this
> > > > > behavior rather than opt-out as is done on other architectures. This is
> > > > > desirable because it is a small class of applications that do pointer
> > > > > masking.
> > > >
> > > > I raised this last time and you didn't seem to address it so to be more
> > > > blunt:
> > > >
> > > > I don't understand why this needs to be an mmap() flag. From this it seems
> > > > the whole process needs allocations to be below a certain limit.
> >
> > Yeah making it per-process does seem logical, as it would help with
> > pointer masking.
> 
> To me it's the only feasible way forward, you can't control all libraries,
> a map flag continues to seem a strange way to implement this, and I
> understand that your justification is that it is the _least invasive_ way
> of doing this, but as I've said below, it's actually pretty invasive if you
> think about it, the current implementation seems to me to be insufficient
> without having VMA flags etc.
> 
> >
> > > >
> > > > That _could_ be achieved through a 'personality' or similar (though a
> > > > personality is on/off, rather than allowing configuration so maybe
> > > > something else would be needed).
> > > >
> > > > From what you're saying 57-bit is all you really need right? So maybe
> > > > ADDR_LIMIT_57BIT?
> >
> > Addresses will always be limited to 57 bits on riscv and x86 (but not
> > necessarily on other architectures). A flag like that would have no
> > impact, I do not understand what you are suggesting. This patch is to
> > have a configurable number of bits be restricted.
> 
> I get that, but as I say below, I don't think a customisable limit is
> workable.
> 
> So I was trying to find a compromise that _might_ be more workable.
> 
> >
> > If anything, a personality that was ADDR_LIMIT_48BIT would be the
> > closest to what I am trying to achieve. Since the issue is that
> > applications fail to work when the address space is greater than 48
> > bits.
> 
> OK so this is at least some possible road forward given there is quite a
> bit of push-back to alternatives.
> 
> >
> > > >
> > > > I don't see how you're going to actually enforce this in a process either
> > > > via an mmap flag, as a library might decide not to use it, so you'd need to
> > > > control the allocator, the thread library implementation, and everything
> > > > that might allocate.
> >
> > It is reasonable to change the implementation to be per-process but that
> > is not the current proposal.
> 
> I mean maybe I wasn't direct enough - I oppose the current proposal as-is.
> 
> >
> > This flag was designed for applications which already directly manage
> > all of their addresses like OpenJDK and Go.
> >
> > This flag implementation was an attempt to make this feature as least
> > invasive as possible to reduce maintainence burden and implementation
> > complexity.
> 
> I realise, and as I said below, I don't think your implementation is
> correct in this form.
> 
> Also if you can control everything + for whatever reason can _absolutely
> know_ no program will use a FFI or a 3rd party library or whatever that
> mremap()'s, I don't see why you can't use mmap() in a creative way to solve
> this rather than adding maintenance burden.
> 
> A couple ideas:
> 
> 1. mmap(high_address - domain_size - buffer, ..., PROT_NONE, MAP_FIXED,
>    ...) a vast domain. You will almost certainly get the hint you
>    want. Then mprotect() regions to PROT_READ | PROT_WRITE as you use (or
>    even mmap() with MAP_FIXED_REPLACE over them), all will have high bits
>    clear.
> 
> 2. (suggested by Liam separately) mmap() with PROT_NONE addresses in the
>    higher range, which prevents mmap() or any other means of allocating
>    memory from allocating there. Acting as a 'huge guard page'.
> 
> Neither require any changes.
> 
> You kinda can't have it both ways - if you are absolutely controlling all
> allocations with no risk of a 3rd party library doing an allocation outside
> of this - then you can just use existing mechanics.
> 
> If you don't, then MAP_BELOW_HINT is insufficient.
> 
> >
> > > >
> > > > Liam also raised various points about VMA particulars that I'm not sure are
> > > > addressed either.
> > > >
> > > > I just find it hard to believe that everything will fit together.
> > > >
> > > > I'd _really_ need to be convinced that this MAP_ flag is justified, and I"m
> > > > just not.
> > > >
> > > > >
> > > > > This flag will also allow seemless compatibility between all
> > > > > architectures, so applications like Go and OpenJDK that use bits in a
> > > > > virtual address can request the exact number of bits they need in a
> > > > > generic way. The flag can be checked inside of vm_unmapped_area() so
> > > > > that this flag does not have to be handled individually by each
> > > > > architecture.
> > > >
> > > > I'm still very unconvinced and feel the bar needs to be high for making
> > > > changes like this that carry maintainership burden.
> > > >
> >
> > I may be naive but what is the burden here? It's two lines of code to
> > check MAP_BELOW_HINT and restrict the address. There are the additional
> > flags for hint and mmap_addr but those are also trivial to implement.
> 
> You're taking up a MAP_ flag (in short supply) which we have to maintain
> forever across all arches and have to respect a limited map range.
> 
> And everything in this realm has edge cases. I don't see how you can
> implement this correctly or usefully without a VMA flag, and see below for
> my concerns on that.
> 
> This is UAPI (and really UABI) so this is _forever_. The bar is high. To me
> this proposal does not hit that, and as you keep saying this isn't even
> what you want.
> 
> You want something per-process so I think the correct proposal is
> per-process.
> 
> A configurable per-process thing is horrible in itself, so I think the only
> workable proposal is a fixed personality.
> 
> >
> > > > So for me, it's a no really as an overall concept.
> > > >
> > > > Happy to be convinced otherwise, however... (I may be missing details or
> > > > context that provide more justification).
> > > >
> > >
> > > Some more thoughts:
> > >
> > > * If you absolutely must keep allocations below a certain limit, you'd
> > >   probably need to actually associate this information with the VMA so the
> > >   memory can't be mremap()'d somewhere invalid (you might not control all
> > >   code so you can't guarantee this won't happen).
> > > * Keeping a map limit associated with a VMA would be horrid and keeping
> > >   VMAs as small as possible is a key aim, so that'd be a no go. VMA flags
> > >   are in limited supply also.
> >
> > Yes that does seem like it would be challenging.
> 
> Right so to me this rules out the MAP_BELOW_HINT. And makes this
> implementation invalid.
> 
> >
> > > * If we did implement a per-process thing, but it were arbitrary, we'd then
> > >   have to handle all kinds of corner cases forever (this is UAPI, can't
> > >   break it etc.) with crazy-low values, or determine a minimum that might
> > >   vary by arch...
> >
> > Throwing an error if the value is determined to be "too low" seems
> > reasonable.
> 
> What's "too low"? This will vary by arch too right? Keep in mind this is
> 'forever'...
> 
> >
> > > * If we did this we'd absolutely have to implement a check in the brk()
> > >   implementation, which is a very very sensitive bit of code. And of
> > >   course, in mmap() and mremap()... and any arch-specific code that might
> > >   interface with this stuff (these functions are hooked).
> > > * A fixed address limit would make more sense, but it seems difficult to
> > >   know what would work for everybody, and again we'd have to deal with edge
> > >   cases and having a permanent maintenance burden.
> >
> > A fixed value is not ideal, since a single size probably would not be
> > suffiecient for every application. However if necessary we could fix it
> > to 48-bits since arm64 and x86 already do that, and that would still
> > allow a generic way of defining this behavior.
> 
> This is more acceptable. It avoids pretty much all of the rest of the
> issues.
> 
> >
> > > * If you did have a map flag what about merging between VMAs above the
> > >   limit and below it? To avoid that you'd need to implement some kind of a
> > >   'VMA flag that has an arbitrary characteristic' or a 'limit' field,
> > >   adjust all the 'can VMA merge' functions and write extensive testing and
> > >   none of that is frankly acceptable.
> > > * We have some 'weird' arches that might have problem with certain virtual
> > >   address ranges or require arbitrary mappings at a certain address range
> > >   that a limit might not be able to account for.
> > >
> > > I'm absolutely opposed to a new MAP_ flag for this, but even if you
> > > implemented that, it implies a lot of complexity.
> > >
> > > It implies even more complexity if you implement something per-process
> > > except if it were a fixed limit.
> > >
> > > And if you implement a fixed limit, it's hard to see that it'll be
> > > acceptable to everybody, and I suspect we'd still run into some possible
> > > weirdness.
> 
> > >
> > > So again, I'm struggling to see how this concept can be justified in any
> > > form.
> >
> > The piece I am missing here is that this idea is already being used by
> > x86 and arm64. They implicitly force all allocations to be below the
> > 47-bit boundary if the hint address is below 47 bits. This flag is much
> > less invasive because it is opt-in and will not impact any existing
> > code. I am not familiar enough with all of the interactions spread
> > throughout mm to know how these architectures have managed to ensure
> > that this 48-bit limit is enforced across things like mremap() as well.
> >
> 
> I just wrote a bunch above about this and did in the original email.
> 
> The 48-bit limit is much more workable and is across-the-board so it's easy
> to implement. It's the variable thing or map flag thing that's the problem.
> 
> > Are you against the idea that there should be a standard way for
> > applications to consistently obtain address that have free bits, or are
> > you just against this implementation? From your statement I assume you
> > mean that every architecture should continue to have varying behavior
> > and separate implementations for supporting larger address spaces.
> >
> 
> I'm against this implementation, or one with a variable limit.
> 
> An ADDR_LIMIT_48BIT personality I think is the most workable form of
> this. Others may have opinions on this also, but it avoids pretty much all
> of the aforementioned issues and is the least invasive.
> 
> > - Charlie
> >
> 
> Sorry to push back so much on your series, your efforts are appreciated, I
> am simply trying to head off issues in the future especially those that end
> up exposed to userland! :)

No I really appreciate it, thank you for your input! Having a variable
limit is not necessary. The motivation is to create a UABI that would be
flexible into the future where an application may want more (or less)
bits reserved than what ADDR_LIMIT_48BIT would provide. However,
current applications are happy to work with 48-bit address spaces so
having the 48-bit personality is sufficient.

There will still need to be some management in the userland software to
ensure that the personality has been set before any allocations, but
that is unavoidable with any solution.

- Charlie



