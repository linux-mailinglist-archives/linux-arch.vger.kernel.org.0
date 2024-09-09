Return-Path: <linux-arch+bounces-7152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09E971440
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6711C22EA3
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BB51B3748;
	Mon,  9 Sep 2024 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lBPc6O4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHZrriof"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow8-smtp.messagingengine.com (flow8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264631B2536;
	Mon,  9 Sep 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875231; cv=none; b=c6CwM0GEWzgxO2iwG7AloAj3zgCG6DKmavV7IN9ZpH+2fK0pnhVw9H1DWMWbXWC+LUVsquZtniHdOKYSNHSREatV8ZQ3XQORQpv/RgsetZbwV9exzduXg40Qekh1i1HcKBDutLp6fFJnYCFtG2Mu3i/cmKWdPS+snQQQxY3U8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875231; c=relaxed/simple;
	bh=lNwIR+xwbUxOSrIXTaBwVx4ar9uDyirb5m/6fHAwWXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEu935tA4JqTNIWUtUVHEBBaBmIqMbqWGRisU7t2HW5FJM8JK5sJV+snmQLkb1RWy/zFFOAjKPY7Xco2fUMIwrm6dft3AxPoMMCQBKEBtx1tJZ7Sz+x5zXySbUGES//1c9QCdV79l170snMTW6vaC2ActHRviAJYtHg0TC17ZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lBPc6O4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHZrriof; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id EE18E2001DE;
	Mon,  9 Sep 2024 05:47:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Sep 2024 05:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1725875227; x=
	1725882427; bh=BPa+t0OgPawOKIqR0T18RRhFI6N40wyPm8P4uVOmsYQ=; b=l
	BPc6O4vkdjuFdPUQx/GWkjNHlfzM1blnQCFwmbYPk3ohfiJXU2katsOTsV/itMcP
	I0kFE8ETPJ7hYqbwvzxprTbBjV24twDtCgKPsbHt0/ZHZgZkTCtITsYA91OWMeS8
	5ToMm7yZ59k8mTdDcR+nlGo7XFtpVtWiKkfNQzQcNR2Cwplo4kvqxS3wcvBhIMzq
	l/H2k3IBsAOTWMbejZoEwAqhKho3zUo2Tzq9tr+gfJoIIaoekqpRpDt3QN8JX7OA
	E/W1pu07hhdoy+toDNG55B8/dOiDpeuBZgt2ZAU2x0NcUUZvZdVWPyco45pIDl67
	hdfqVF2AGsJXsfUNyZ8LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725875227; x=1725882427; bh=BPa+t0OgPawOKIqR0T18RRhFI6N4
	0wyPm8P4uVOmsYQ=; b=bHZrriofaN4DC5WZCdXMUPXMz+etATu4nCBewnpqNsaw
	FVV5NMsyoUF6Jr7J9/iQwdiQiVwufXFxL1xjmZ3ZTXtwAs7Xd47X8IK5kCeLH5Zx
	gbn/t616nSUZyaLl27+WADgQM/2MzJLc4Dt9sX2YGuJzO5P9+Fe74Y2Sd9Q3QFL+
	dR5RgCUMgdOfG/W5lQhba6p1V2wWv2l/tjStQSEN1k6fYC7IwDuKE+6kI4GRhDg3
	Rwju+/48bdXwh3AMr3yD5uJoXxgqonm3AeH6u6SgW6lpschh0v4d93IkcQHj1qUP
	wuiKGnPJX2TLpvB6TTW/yB3cxzohBLwQqOOJm56rNw==
X-ME-Sender: <xms:GMTeZkb4ykAOR_EMJb8_tDn0TMOZFONau-MwujjLNHRr-Wkqt2dSUQ>
    <xme:GMTeZva1-M1im4Jp1LIjaav2rAfFhxsHMXAhODt7T02hM4BuADB0ZzL__nLHdiiBz
    SSxNINKU_xZ_uRM6kI>
X-ME-Received: <xmr:GMTeZu_ViDBBY4wFBsBlNsC4hDIPt8FmsrKwqowsMOAkJLYpv49F3w-i-FZSYdAC09X5zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhr
    ohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuh
    htvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepleetudegtdfgheduudfhteel
    ieeuvddtheeijeejudefjeefgeettedutdeggfdunecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepheejpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhn
    tgdrtghomhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheprh
    hitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    ihhnkhesjhhurhgrshhsihgtrdhprghrkhdrmhhsuhdrrhhupdhrtghpthhtohepmhgrth
    htshhtkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvhhguhhpthgrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgv
    nhhhuhgrtggriheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GMTeZuo8r1nq-l9Iy1GG6lbrKIDlKAUfTYSJNOcMHx7SoM3_DQR_3Q>
    <xmx:GMTeZvrvUvANLRDy_9LJ18nIkHenEaJwEIED0prbXl6sE_8pVNQDOQ>
    <xmx:GMTeZsRlSV4fkIBrTLkTKBp6pnJALT50swFC-8I2Ke2cX1KpAQISKA>
    <xmx:GMTeZvr9-1ECM5FvQVeumcsYIs50J0UTzC6J0l-CHe5sOz5eneb3pw>
    <xmx:G8TeZngmbMM6nDA0aBg4nycXlZwqiuUgtwXCgxP4Ok8DOYuuB710QBwh>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 05:46:47 -0400 (EDT)
Date: Mon, 9 Sep 2024 12:46:42 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 	Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
 	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, 	WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 	Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 	Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 	Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Thomas Gleixner <tglx@linutronix.de>, 	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 	Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, 	linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <pbotlphw77fkfacldtpxfjcs2w5nhb2uvxszv5rmlrhjm42akd@4pvcqb7ojq4v>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <yu7um2tcxg2apoz372rmzpkrfgbb42ndvabvrsp4usb2e3bkrf@huaucjsp5vlj>
 <Ztnp3OAIRz/daj7s@ghost>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztnp3OAIRz/daj7s@ghost>

On Thu, Sep 05, 2024 at 10:26:52AM -0700, Charlie Jenkins wrote:
> On Thu, Sep 05, 2024 at 09:47:47AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Aug 29, 2024 at 12:15:57AM -0700, Charlie Jenkins wrote:
> > > Some applications rely on placing data in free bits addresses allocated
> > > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > > address returned by mmap to be less than the 48-bit address space,
> > > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > > for the kernel address space).
> > > 
> > > The riscv architecture needs a way to similarly restrict the virtual
> > > address space. On the riscv port of OpenJDK an error is thrown if
> > > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > > has a comment that sv57 support is not complete, but there are some
> > > workarounds to get it to mostly work [2].

I also saw libmozjs crashing with 57-bit address space on x86.

> > > These applications work on x86 because x86 does an implicit 47-bit
> > > restriction of mmap() address that contain a hint address that is less
> > > than 48 bits.
> > > 
> > > Instead of implicitly restricting the address space on riscv (or any
> > > current/future architecture), a flag would allow users to opt-in to this
> > > behavior rather than opt-out as is done on other architectures. This is
> > > desirable because it is a small class of applications that do pointer
> > > masking.

You reiterate the argument about "small class of applications". But it
makes no sense to me.

With full address space by default, this small class of applications is
going to *broken* unless they would handle RISC-V case specifically.

On other hand, if you limit VA to 128TiB by default (like many
architectures do[1]) everything would work without intervention.
And if an app needs wider address space it would get it with hint opt-in,
because it is required on x86-64 anyway. Again, no RISC-V-specific code.

I see no upside with your approach. Just worse user experience.

[1] See va_high_addr_switch test case in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/mm/Makefile#n115

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

