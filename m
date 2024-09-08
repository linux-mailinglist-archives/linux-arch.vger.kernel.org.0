Return-Path: <linux-arch+bounces-7120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F19706D6
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 13:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3AC1C20BAD
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2AB1531CD;
	Sun,  8 Sep 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="oHOi2tzi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fg90YUwB"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E114C5AE;
	Sun,  8 Sep 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794794; cv=none; b=WLT3NBmDpcWc8wBAQCGpyeAQS8PMCy4fGTLalsiD5tmcSnfzdBdRHQyvqR1CiWrMnF6fZb09N+KYZeJxQRkIAnE4SQdjI0vA5JpOdRdB3GxQgbSD5kuF/8uRKKq4r8g1MHOnk0F+VbQjzYJyj0DkQFPsDdjfSXDH9fkDafQmUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794794; c=relaxed/simple;
	bh=s22LiCvHg5GCcJ/0gjfyATBl5wTKkAzg5feHIKI+9mg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aYcxkp484MmM+FrfRhD5VqerfdH0vkf5usJzw9Ghkfl4K39nUeCD69aafatkYKxxoX0GF9+PfHeBSmsv7DyVf5SfxfjGmFZ8kqhvwHMb4IYPV86KsFqp/Z9O6HSxvWhcCllcb1GxDdYIG4+LTUYbentBtcLlj05RkPYMWq0BieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=oHOi2tzi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fg90YUwB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 303BC1140239;
	Sun,  8 Sep 2024 07:26:31 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sun, 08 Sep 2024 07:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725794791;
	 x=1725881191; bh=XEUlxjTawgkGJUbuV5995m7w7A2+JrHLDxzMf66rOFU=; b=
	oHOi2tziFYipU/36G0P4pMedwfORQXdZAEe5c9Wj6Pkgv2OwPwT8YruLqHeDtPPl
	aYsVkmP6MoSs3CPhOdnNnBGy1EB5dQRcXluTi7nR3uZ/IDhEp7vIUihrBhkfgOQR
	4j/c6PqoGTCGYa4f9b5UUfA47nFjzGxrAO5K6afnIZDUmCftz5UOHhJvGMudLFdR
	rSgAL4fXR0uC4GGqwHMng2woukdSPh5Nqwjlr2tYXmkYDBL4QJWPUAkQDVZrkSYD
	oCgX/0eT5ac+iDDRk/ni/6T8yfLtxVDLu3kVGfhB6uGlgNQxAoF7BKg/Uo7g09m6
	MdYX7iA0mE0HTDF/kiQgZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725794791; x=
	1725881191; bh=XEUlxjTawgkGJUbuV5995m7w7A2+JrHLDxzMf66rOFU=; b=f
	g90YUwBHInWhIR7eot/GF/L5V8rTEiLKyfgrEwEGaITOsFWt+MRMHpLTuqzTFmCc
	HA44h/q1BXd4iJMNi4nfHe6z24uwouoQ4RMWlqcwyKrjROgMakTgYu6gfEHlzrUr
	i0hjfXXqfZRRehxdtj+aZa+1cwviPfTK+T6zzG6WGuFIe0xPI7jQ2Y3nPhlYRt37
	Z5c7fxczZEhGsHiXmlTZFd3F73OxlTU5QGWxZSnZ3oUznMRj9qp+QkcdwGmLd5ZU
	LjBieS65NRQt0Ufia4wkB0gY7cNhU/+mjeq4n2QgZCei4VKJJM5vk5T2uR8ZIyce
	A8dS7WV0a6DERl6qoyLBg==
X-ME-Sender: <xms:5ondZv5EyLULksTd86Gox8AAQuTkdW8_EDaOnSzJ807aoMMq3SvXKw>
    <xme:5ondZk6wX3pv5Yj08ahY3NmdyrnN8xyC9XqeN4JEBp7G18z0_I04to5vGA7mByLdc
    zyCAe6ZBI3bkPAOBEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgrlhhphhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqtghskhihsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhmihhpshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhprghrihhstgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhshhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5ondZmd9bDZgTBNLmCVK9WctNnt9UdyUUYLzicp8fRUQJOEeEHozCQ>
    <xmx:5ondZgJbs9ZbQEnjCxeIQX3jr6jp32cCYqcxW8vB_4rDfb71lY8o7g>
    <xmx:5ondZjJQPWwtLvEPjhQrPNIUhMsNJM9qEgpuiiWJGtcO2UPfCU6EbA>
    <xmx:5ondZpytJvdFgsOqTwWS9Vs06wpz46tg4dTRIE_gHhIODGZYtV_FWQ>
    <xmx:54ndZlxfc3c_LrCS3N9s-1LqRMFbltsGr3zCZwtJfxdiMSPhLMCNLrFL>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 900D51C20065; Sun,  8 Sep 2024 07:26:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 08 Sep 2024 12:26:09 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>, "Guo Ren" <guoren@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Shuah Khan" <shuah@kernel.org>, "Christoph Hellwig" <hch@infradead.org>,
 "Michal Hocko" <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 "Chris Torek" <chris.torek@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Message-Id: <53384dc9-38c9-4d05-bcde-a3552fbed7ac@app.fastmail.com>
In-Reply-To: 
 <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
Subject: Re: [PATCH RFC v3 0/2] mm: Introduce ADDR_LIMIT_47BIT personality flag
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B49=E6=9C=885=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=8810:15=EF=BC=8CCharlie Jenkins=E5=86=99=E9=81=93=EF=BC=9A
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the 48-bit address space,
> unless the hint address uses more than 47 bits (the 48th bit is reserv=
ed
> for the kernel address space).
>
> The riscv architecture needs a way to similarly restrict the virtual
> address space. On the riscv port of OpenJDK an error is thrown if
> attempted to run on the 57-bit address space, called sv57 [1].  golang
> has a comment that sv57 support is not complete, but there are some
> workarounds to get it to mostly work [2].
>
> These applications work on x86 because x86 does an implicit 47-bit
> restriction of mmap() address that contain a hint address that is less
> than 48 bits.
>
> Instead of implicitly restricting the address space on riscv (or any
> current/future architecture), provide a flag to the personality syscall
> that can be used to ensure an application works in any arbitrary VA
> space. A similar feature has already been implemented by the personali=
ty
> syscall in ADDR_LIMIT_32BIT.
>
> This flag will also allow seemless compatibility between all
> architectures, so applications like Go and OpenJDK that use bits in a
> virtual address can request the exact number of bits they need in a
> generic way. The flag can be checked inside of vm_unmapped_area() so
> that this flag does not have to be handled individually by each
> architecture.=20

Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Tested on MIPS VA 48 system, fixed pointer tagging on mozjs!

Thanks!

[...]
--=20
- Jiaxun

