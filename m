Return-Path: <linux-arch+bounces-7622-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC0A98DB7C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38781C2141A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2771D2716;
	Wed,  2 Oct 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="SD/30Ml+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C821D2701
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879197; cv=none; b=MMsgc8Y25S1rz7ozm4ZcDRoEgapAClNMPzV4I74BPb9S6Rb80e8CPo6oC8yTt9tBNPFLUzA8Un2J8fUkzcsD0LquZJ5Ujpzp87R3ORs7NYrI/WmDwv3kjvxYrhDQ+PEAI5eh8amNt9eGTZdZJq1VGFbSM6oKv/5CAaD4tyLOhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879197; c=relaxed/simple;
	bh=aCFCZJFzvE1bkbpS9hq4+5y5zL1d5gjRJcjpIdftZ/k=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=bHjrmTJPaiopDZ2pEhp4rtDRwM6bammmYvhvKg44ERVdObU0nr0F4bqx15mOKmAi5rLMNLDQd+x7WT36snynIaPhSlXaGsbe64Xemu2FowQZspcZEvsTlpfos5gCuz23HMNMrSwi4obaUW7G9h8sYsKImCHSuGmcMeRCJcv0mYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=SD/30Ml+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e09ff2d890so5696219a91.0
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1727879194; x=1728483994; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uOcXAMjC7XDZjDd/akc0amsyLu8m5OVtpNVeGFczMRY=;
        b=SD/30Ml+Tok20r3tgjGddoHNePpI87umKJYLEmCW9RJRtZAaFxsMuog/oHAMbH5JLr
         IgqYXSeFdUGqhBu9A+n2uEbFeQrqGywM6iivTlDK7iBqNjPSopoRQX83URf4rMMX4sq2
         QEIVpFiPt1XNL3V05EH4Xv2mWQtOXSg6CBtNFqu7mJaIzXzlKrCPQ8zDC+EPTuix/Mwg
         uxKP8EVlmZ9TAKF3scyqGP1fH9DlLSlzVCwxwmr95AfXM/niIih4DHwqxVtIFnZmiS1Z
         m79HI9p1er/F04E6sK+949k4x2HVIQEiWCYlIKr/VsWQrKEvZTc5xtsmNPoFREJJCC2r
         HI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879194; x=1728483994;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOcXAMjC7XDZjDd/akc0amsyLu8m5OVtpNVeGFczMRY=;
        b=ajX3PCeJ4Wqs5DFT73AhAzdDHXiDf9XqHMW+vr2keZaWuvN0a7gSDykgvnCkGutVpd
         RZ0Vj5nAwH4oYPla6EWQ9j2rwvm21S4Q36JQOEatCKieAXp6nxBdNUyw6Z+kBiaOjIrN
         cvpSRGqJSTYFF87BdbUe/dqzly4DE9NL809pQD2/ca0dB6tM3EQYMEvVHjmeMrSdRfAa
         HXj0GBNXbR4NLWTYIwHR7i5gqy7b1Ptf9J6m++cBQXPc1BFnT4ghYBVA64DkR2lpo4lp
         ydlM3ZSTHhNAJn4DHIag4l5XtGlZA56sVsC6UKu963efh6oJaizf5aC3k1nUfh2xdbok
         GxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqozTLM6jcEH1hpQXFlSsc3F/bKDVBZZkflwZWGNW5waiySfXi663F2GYYklcpXYFqaQfBxdSEQgSr@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbsA5wecl8J8aheby93TqEwSQP33OGRnf12LjGqCUYqK4Fwib
	K/t0A7cRu6/D7DLs8zPVvbanQvQhw0ux3nl4DoNH4Yw32RrADmKqv4rUmfk1vm4=
X-Google-Smtp-Source: AGHT+IHNNKdcu5kwdDsRcpptaNSlsD6gvL0I++M5UX28lY+Nyv67bj3x07yZ+LRvd6o8h2+EV/Ug6A==
X-Received: by 2002:a17:90a:be10:b0:2e0:7b2b:f76 with SMTP id 98e67ed59e1d1-2e18468cc49mr4757443a91.19.1727879193916;
        Wed, 02 Oct 2024 07:26:33 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f79bb04sm1615137a91.30.2024.10.02.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:26:32 -0700 (PDT)
Date: Wed, 02 Oct 2024 07:26:32 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2024 07:26:31 PDT (-0700)
Subject:     Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to 47 bits
In-Reply-To: <ZuSoxh5U3Kj1XgGq@ghost>
CC: Catalin Marinas <catalin.marinas@arm.com>, Liam.Howlett@oracle.com,
  Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
  ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
  chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de,
  James.Bottomley@hansenpartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
  christophe.leroy@csgroup.eu, naveen@kernel.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
  hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
  ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net,
  andreas@gaisler.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
  dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
  muchun.song@linux.dev, akpm@linux-foundation.org, vbabka@suse.cz, shuah@kernel.org,
  Christoph Hellwig <hch@infradead.org>, mhocko@suse.com, kirill@shutemov.name, chris.torek@gmail.com,
  linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
  linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
  loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
  sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
  linux-abi-devel@lists.sourceforge.net
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>, lorenzo.stoakes@oracle.com
Message-ID: <mhng-411f66df-5f86-4aeb-b614-a6f64587549c@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

On Fri, 13 Sep 2024 14:04:06 PDT (-0700), Charlie Jenkins wrote:
> On Fri, Sep 13, 2024 at 08:41:34AM +0100, Lorenzo Stoakes wrote:
>> On Wed, Sep 11, 2024 at 11:18:12PM GMT, Charlie Jenkins wrote:
>> > On Wed, Sep 11, 2024 at 07:21:27PM +0100, Catalin Marinas wrote:
>> > > On Tue, Sep 10, 2024 at 05:45:07PM -0700, Charlie Jenkins wrote:
>> > > > On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
>> > > > > * Catalin Marinas <catalin.marinas@arm.com> [240906 07:44]:
>> > > > > > On Fri, Sep 06, 2024 at 09:55:42AM +0000, Arnd Bergmann wrote:
>> > > > > > > On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
>> > > > > > > > On Fri, Sep 6, 2024 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> > > > > > > >> It's also unclear to me how we want this flag to interact with
>> > > > > > > >> the existing logic in arch_get_mmap_end(), which attempts to
>> > > > > > > >> limit the default mapping to a 47-bit address space already.
>> > > > > > > >
>> > > > > > > > To optimize RISC-V progress, I recommend:
>> > > > > > > >
>> > > > > > > > Step 1: Approve the patch.
>> > > > > > > > Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
>> > > > > > > > Step 3: Wait approximately several iterations for Go & OpenJDK
>> > > > > > > > Step 4: Remove the 47-bit constraint in arch_get_mmap_end()
>> > >
>> > > Point 4 is an ABI change. What guarantees that there isn't still
>> > > software out there that relies on the old behaviour?
>> >
>> > Yeah I don't think it would be desirable to remove the 47 bit
>> > constraint in architectures that already have it.
>> >
>> > >
>> > > > > > > I really want to first see a plausible explanation about why
>> > > > > > > RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
>> > > > > > > like all the other major architectures (x86, arm64, powerpc64),
>> > > > > >
>> > > > > > FWIW arm64 actually limits DEFAULT_MAP_WINDOW to 48-bit in the default
>> > > > > > configuration. We end up with a 47-bit with 16K pages but for a
>> > > > > > different reason that has to do with LPA2 support (I doubt we need this
>> > > > > > for the user mapping but we need to untangle some of the macros there;
>> > > > > > that's for a separate discussion).
>> > > > > >
>> > > > > > That said, we haven't encountered any user space problems with a 48-bit
>> > > > > > DEFAULT_MAP_WINDOW. So I also think RISC-V should follow a similar
>> > > > > > approach (47 or 48 bit default limit). Better to have some ABI
>> > > > > > consistency between architectures. One can still ask for addresses above
>> > > > > > this default limit via mmap().
>> > > > >
>> > > > > I think that is best as well.
>> > > > >
>> > > > > Can we please just do what x86 and arm64 does?
>> > > >
>> > > > I responded to Arnd in the other thread, but I am still not convinced
>> > > > that the solution that x86 and arm64 have selected is the best solution.
>> > > > The solution of defaulting to 47 bits does allow applications the
>> > > > ability to get addresses that are below 47 bits. However, due to
>> > > > differences across architectures it doesn't seem possible to have all
>> > > > architectures default to the same value. Additionally, this flag will be
>> > > > able to help users avoid potential bugs where a hint address is passed
>> > > > that causes upper bits of a VA to be used.
>> > >
>> > > The reason we added this limit on arm64 is that we noticed programs
>> > > using the top 8 bits of a 64-bit pointer for additional information.
>> > > IIRC, it wasn't even openJDK but some JavaScript JIT. We could have
>> > > taught those programs of a new flag but since we couldn't tell how many
>> > > are out there, it was the safest to default to a smaller limit and opt
>> > > in to the higher one. Such opt-in is via mmap() but if you prefer a
>> > > prctl() flag, that's fine by me as well (though I think this should be
>> > > opt-in to higher addresses rather than opt-out of the higher addresses).
>> >
>> > The mmap() flag was used in previous versions but was decided against
>> > because this feature is more useful if it is process-wide. A
>> > personality() flag was chosen instead of a prctl() flag because there
>> > existed other flags in personality() that were similar. I am tempted to
>> > use prctl() however because then we could have an additional arg to
>> > select the exact number of bits that should be reserved (rather than
>> > being fixed at 47 bits).
>>
>> I am very much not in favour of a prctl(), it would require us to add state
>> limiting the address space and the timing of it becomes critical. Then we
>> have the same issue we do with the other proposals as to - what happens if
>> this is too low?
>>
>> What is 'too low' varies by architecture, and for 32-bit architectures
>> could get quite... problematic.
>>
>> And again, wha is the RoI here - we introducing maintenance burden and edge
>> cases vs. the x86 solution in order to... accommodate things that need more
>> than 128 TiB of address space? A problem that does not appear to exist in
>> reality?
>>
>> I suggested the personality approach as the least impactful compromise way
>> of this series working, but I think after what Arnd has said (and please
>> forgive me if I've missed further discussion have been dipping in and out
>> of this!) - adapting risc v to the approach we take elsewhere seems the
>> most sensible solution to me.

There's one wrinkle here: RISC-V started out with 39-bit VAs by default, 
and we've had at least one report of userspace breaking when moving to 
48-bit addresses.  That was just address sanitizer, so maybe nobody 
cares, but we're still pretty early in the transition to 48-bit systems 
(most of the HW is still 39-bit) so it's not clear if that's going to be 
the only bug.

So we're sort of in our own world of backwards compatibility here.  
39-bit vs 48-bit is just an arbitrary number, but "38 bits are enough 
for userspace" doesn't seem as sane a "47 bits are enough for 
userspace".  Maybe the right answer here is to just say the 38-bit 
userspace is broken and that it's a Linux-ism that 64-bit sytems have 
47-bit user addresses by default.

>> This remains something we can revisit in future if this turns out to be
>> egregious.
>>
>
> I appreciate Arnd's comments, but I do not think that making 47-bit the
> default is the best solution for riscv. On riscv, support for 48-bit
> address spaces was merged in 5.17 and support for 57-bit address spaces
> was merged in 5.18 without changing the default addresses provided by
> mmap(). It could be argued that this was a mistake, however since at the
> time there didn't exist hardware with larger address spaces it wasn't an
> issue. The applications that existed at the time that relied on the
> smaller address spaces have not been able to move to larger address
> spaces. Making a 47-bit user-space address space default solves the
> problem, but that is not arch agnostic, and can't be since of the
> varying differences in page table sizes across architectures, which is
> the other part of the problem I am trying to solve.
>
>> >
>> > Opting-in to the higher address space is reasonable. However, it is not
>> > my preference, because the purpose of this flag is to ensure that
>> > allocations do not exceed 47-bits, so it is a clearer ABI to have the
>> > applications that want this guarantee to be the ones setting the flag,
>> > rather than the applications that want the higher bits setting the flag.
>>
>> Perfect is the enemy of the good :) and an idealised solution may not end
>> up being something everybody can agree on.
>
> Yes you are totally right! Although this is not my ideal solution, it
> sufficiently accomplishes the goal so I think it is reasonable to
> implement this as a personality flag.
>
>>
>> >
>> > - Charlie
>> >
>> > >
>> > > --
>> > > Catalin
>> >
>> >
>> >

