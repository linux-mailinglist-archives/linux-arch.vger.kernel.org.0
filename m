Return-Path: <linux-arch+bounces-7303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D8978A62
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 23:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2764287C77
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43681154445;
	Fri, 13 Sep 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mGJQhVia"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C81527AC
	for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261455; cv=none; b=M28NgO7cPbs0dPn9sS1AOQXZNVYCs71ffXEvBFs1zD79hbly7zEa1vGG4WMgd4i9eiuJUfGAOtnyloZMMAAdECDjaF5eO9RMuWC2+rMac4M1K0FiKJ34lTeu5kBOYsrLgXhfdcxRsKtrnua4U2BXsBnxc0Y1NnOWW2GvU2yjPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261455; c=relaxed/simple;
	bh=UTbmMbiOdPh2p8MAam907C+8IKVqjc0gQ8Sb2U1VqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn2n54pDHm9ObPSS8yE5RYCRhYhoCOe1DLBMSo9/jn+BcJVoXfXrrLPas5TD/SgQZEl7UVedKEwZx5at4y4nqeS6BxDhnRd+adPgdYgZK/xfIAgjPjW6LN2kyqpA33SzmMZ7OsZJsdeYJNKUcoryh9tu9T9OQ5swKhzi/aK8e78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mGJQhVia; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059112f0a7so13127875ad.3
        for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2024 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726261452; x=1726866252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pGN098PfFZ1p39RZKtno/bb1iGOxyKkQDSILC8HyAbs=;
        b=mGJQhViaeBP8boO4Z3ZlrGQg2Ou1nzmYaw9yb7rukospMvx2utfJB3ZJC/iHXR1zY5
         OHHUQ7APm78lvjgaMAUf8nqLxbwPfkCE6Z5e7ZNILJdFYZ+iil46N6YJi7qrukHgrCj/
         52MTbKyKy529xeaqzrRTzLPQwJPpgli/uI+0fNxnWN+NS2DfW/BXySToSEAivdhd/b1E
         0bhUlMQ9VwSyt4VT3AbPh30kaAP0/NOhpzlX6MgqnmsEjeE/PQpON963yaauaSMSSEog
         9Z7w+mZFQjHElQBLBsbH+wO7gdp/BUvodGBjrviEku9NhDQC1RpY/imscbGB4lWvqiQI
         Jydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726261452; x=1726866252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGN098PfFZ1p39RZKtno/bb1iGOxyKkQDSILC8HyAbs=;
        b=QW2o9o4q/jMCuhmjnvMbLF9xO4FI6Cf0goDPnUVVZX7f2P7HYE8X5Cv+YG6lskdEob
         pyU8b0FIGgzvD1G/M3LHBsQqAkOH39iD1mhs7HhJwGziULX7Qxu+onD4HNm+K67Onr4k
         i1YlMrYtacCzQIfvEZtDaM49CJSzH0KtVKt3KEQR8EQApoq6A/L1MdetWY3WjgB9z1mF
         jxmqp5MimuCWTAA/EWoQrkAbRDTKiK9oUhZahaMB/33ybZC8/8VWWH5KQbg9BLJYvOlm
         auxLsno8wIkJna/9jTH5eaYP17MvrPf1CZtiJb0cS9pfAxDuhiU2fDLu2fNPoGTkwrSm
         Xx1w==
X-Forwarded-Encrypted: i=1; AJvYcCXnH8KpnlEQFkMS7XgK70aW7Cpf5pQ/9mRlpN1N5UzQ6B1Ym/EjPaqe0HNfeEC1OYXRfwLV/LWKiFWd@vger.kernel.org
X-Gm-Message-State: AOJu0YwEv3spoIe6iTQ2izFijsDyZd5kUv4uA7FofnYfVDr41Lk/dd9v
	+dID1yyxxvynGv6lyQdvTD+SaeVloQahbHatjKRlAd4Sc9iMbZtwgju+ZWbXMm8=
X-Google-Smtp-Source: AGHT+IHQy68+7/4em5wfAX0phJQ7a7VsNC8xlp5lvUp2N1zpKPOlth6aUECbhTSHxYBYBN7icOc/wA==
X-Received: by 2002:a17:902:f54f:b0:207:457f:b8a6 with SMTP id d9443c01a7336-2078262ccc1mr54571405ad.12.1726261452005;
        Fri, 13 Sep 2024 14:04:12 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da8c9sm608475ad.17.2024.09.13.14.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:04:11 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:04:06 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, guoren <guoren@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, shuah <shuah@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Chris Torek <chris.torek@gmail.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <ZuSoxh5U3Kj1XgGq@ghost>
References: <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
 <ZuHfp0_tAQhaymdy@arm.com>
 <ZuKHpFB+uWuJe2xm@ghost>
 <d873a994-4efa-4d3a-bdae-5d9a3eff29f2@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d873a994-4efa-4d3a-bdae-5d9a3eff29f2@lucifer.local>

On Fri, Sep 13, 2024 at 08:41:34AM +0100, Lorenzo Stoakes wrote:
> On Wed, Sep 11, 2024 at 11:18:12PM GMT, Charlie Jenkins wrote:
> > On Wed, Sep 11, 2024 at 07:21:27PM +0100, Catalin Marinas wrote:
> > > On Tue, Sep 10, 2024 at 05:45:07PM -0700, Charlie Jenkins wrote:
> > > > On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
> > > > > * Catalin Marinas <catalin.marinas@arm.com> [240906 07:44]:
> > > > > > On Fri, Sep 06, 2024 at 09:55:42AM +0000, Arnd Bergmann wrote:
> > > > > > > On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
> > > > > > > > On Fri, Sep 6, 2024 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > >> It's also unclear to me how we want this flag to interact with
> > > > > > > >> the existing logic in arch_get_mmap_end(), which attempts to
> > > > > > > >> limit the default mapping to a 47-bit address space already.
> > > > > > > >
> > > > > > > > To optimize RISC-V progress, I recommend:
> > > > > > > >
> > > > > > > > Step 1: Approve the patch.
> > > > > > > > Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
> > > > > > > > Step 3: Wait approximately several iterations for Go & OpenJDK
> > > > > > > > Step 4: Remove the 47-bit constraint in arch_get_mmap_end()
> > >
> > > Point 4 is an ABI change. What guarantees that there isn't still
> > > software out there that relies on the old behaviour?
> >
> > Yeah I don't think it would be desirable to remove the 47 bit
> > constraint in architectures that already have it.
> >
> > >
> > > > > > > I really want to first see a plausible explanation about why
> > > > > > > RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
> > > > > > > like all the other major architectures (x86, arm64, powerpc64),
> > > > > >
> > > > > > FWIW arm64 actually limits DEFAULT_MAP_WINDOW to 48-bit in the default
> > > > > > configuration. We end up with a 47-bit with 16K pages but for a
> > > > > > different reason that has to do with LPA2 support (I doubt we need this
> > > > > > for the user mapping but we need to untangle some of the macros there;
> > > > > > that's for a separate discussion).
> > > > > >
> > > > > > That said, we haven't encountered any user space problems with a 48-bit
> > > > > > DEFAULT_MAP_WINDOW. So I also think RISC-V should follow a similar
> > > > > > approach (47 or 48 bit default limit). Better to have some ABI
> > > > > > consistency between architectures. One can still ask for addresses above
> > > > > > this default limit via mmap().
> > > > >
> > > > > I think that is best as well.
> > > > >
> > > > > Can we please just do what x86 and arm64 does?
> > > >
> > > > I responded to Arnd in the other thread, but I am still not convinced
> > > > that the solution that x86 and arm64 have selected is the best solution.
> > > > The solution of defaulting to 47 bits does allow applications the
> > > > ability to get addresses that are below 47 bits. However, due to
> > > > differences across architectures it doesn't seem possible to have all
> > > > architectures default to the same value. Additionally, this flag will be
> > > > able to help users avoid potential bugs where a hint address is passed
> > > > that causes upper bits of a VA to be used.
> > >
> > > The reason we added this limit on arm64 is that we noticed programs
> > > using the top 8 bits of a 64-bit pointer for additional information.
> > > IIRC, it wasn't even openJDK but some JavaScript JIT. We could have
> > > taught those programs of a new flag but since we couldn't tell how many
> > > are out there, it was the safest to default to a smaller limit and opt
> > > in to the higher one. Such opt-in is via mmap() but if you prefer a
> > > prctl() flag, that's fine by me as well (though I think this should be
> > > opt-in to higher addresses rather than opt-out of the higher addresses).
> >
> > The mmap() flag was used in previous versions but was decided against
> > because this feature is more useful if it is process-wide. A
> > personality() flag was chosen instead of a prctl() flag because there
> > existed other flags in personality() that were similar. I am tempted to
> > use prctl() however because then we could have an additional arg to
> > select the exact number of bits that should be reserved (rather than
> > being fixed at 47 bits).
> 
> I am very much not in favour of a prctl(), it would require us to add state
> limiting the address space and the timing of it becomes critical. Then we
> have the same issue we do with the other proposals as to - what happens if
> this is too low?
> 
> What is 'too low' varies by architecture, and for 32-bit architectures
> could get quite... problematic.
> 
> And again, wha is the RoI here - we introducing maintenance burden and edge
> cases vs. the x86 solution in order to... accommodate things that need more
> than 128 TiB of address space? A problem that does not appear to exist in
> reality?
> 
> I suggested the personality approach as the least impactful compromise way
> of this series working, but I think after what Arnd has said (and please
> forgive me if I've missed further discussion have been dipping in and out
> of this!) - adapting risc v to the approach we take elsewhere seems the
> most sensible solution to me.
>
> This remains something we can revisit in future if this turns out to be
> egregious.
>

I appreciate Arnd's comments, but I do not think that making 47-bit the
default is the best solution for riscv. On riscv, support for 48-bit
address spaces was merged in 5.17 and support for 57-bit address spaces
was merged in 5.18 without changing the default addresses provided by
mmap(). It could be argued that this was a mistake, however since at the
time there didn't exist hardware with larger address spaces it wasn't an
issue. The applications that existed at the time that relied on the
smaller address spaces have not been able to move to larger address
spaces. Making a 47-bit user-space address space default solves the
problem, but that is not arch agnostic, and can't be since of the
varying differences in page table sizes across architectures, which is
the other part of the problem I am trying to solve.

> >
> > Opting-in to the higher address space is reasonable. However, it is not
> > my preference, because the purpose of this flag is to ensure that
> > allocations do not exceed 47-bits, so it is a clearer ABI to have the
> > applications that want this guarantee to be the ones setting the flag,
> > rather than the applications that want the higher bits setting the flag.
> 
> Perfect is the enemy of the good :) and an idealised solution may not end
> up being something everybody can agree on.

Yes you are totally right! Although this is not my ideal solution, it
sufficiently accomplishes the goal so I think it is reasonable to
implement this as a personality flag.

> 
> >
> > - Charlie
> >
> > >
> > > --
> > > Catalin
> >
> >
> >

