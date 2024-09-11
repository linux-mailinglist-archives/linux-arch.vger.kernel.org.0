Return-Path: <linux-arch+bounces-7203-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876E974B2C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 09:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706BF1C24700
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750C139D0A;
	Wed, 11 Sep 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F9rNEoeX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHb72+mh"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D62746B;
	Wed, 11 Sep 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039533; cv=none; b=qerDN4Xtf28HvmD93Ed4HJ9DdXVP80bdd9nJqh06cR0cpT3JIAOwTqoAtLo4LW52YMiAHLERo38o+7MriThqz2XXdikYpBBbpMOl4nin8EivgvU3J7VIfLLiz1Cbsvi2lZ26hRmPeMffUVWRQkeIgaLersHbTJmxpAbtlrG74hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039533; c=relaxed/simple;
	bh=ETLIKsU+6j3dbE0k0YACQOp91RGJ8e3OeoJa4Cxcffs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KGfzXzjsvo+q3RlAiQmg2omTdGMAQK2s8tn7bWzEr/GoU7xb6W9da2Do5jtvzA1EqLxyy7W5FLSCA1IkJ2X9eWuDc33fxT3Tmjblv7425ypqBXmwij82v5T5XS6RHjmPcyNuJa0LddNxVQx555NWm+9UfTBregbkSzzMEIHq24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F9rNEoeX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHb72+mh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDD0C1140240;
	Wed, 11 Sep 2024 03:25:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 03:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726039529;
	 x=1726125929; bh=yCULKLzEw1t/f1sPt/nrm6FrZBRX7uDhUSLEPSMpBQQ=; b=
	F9rNEoeXKRYFxLjIk6eWo1N3gMclbpeQ4mgz4w/7cs9zcRDxkyX0Agm0WNqgCD2W
	Z7VyyBFKG6orB8gELxqQHkPsZcor9zgyhSaWnMODwD5IWoNXBCfuTJGnX8SoseKi
	eZdTmPVJZj29qoghoSOoRCe1AaE/65K57zLJI8b3R6sjqoIkd1qVqWJ1TaT8Hk+/
	caAys40jlQbCO53cxkBQpbv8n3T+XSXoiscoHdGG+NlKQd95f2KcMzzTKCCQIKVA
	PmMIBu478Mygj7KL8uE9ChBcat9bONZcEEsZk5fbfhalKZdLHb9JNlc/ZUUljrPK
	7deYeUcezD6jBuhp5knKYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726039529; x=
	1726125929; bh=yCULKLzEw1t/f1sPt/nrm6FrZBRX7uDhUSLEPSMpBQQ=; b=i
	Hb72+mhQrasBkqcf21vPbxa4UB9x2/tuvmT6y+NJmJyl2py0sIVynyrlpW9jey9I
	QJ4QERkexr8fEESdSpc5HnseScjtuuv3ksr8SnTZnXN7Fv3NtghoGaxEKas1BowI
	1tAbWOF2iikDni2CUFp49Dox8KhYNKF1uhUzMkO98i6hO8wclK+bKHkwuT6PMGtJ
	yJuiVLpH+NSq/7upriOuVH7rOiZSG/zUmhOKkEYP4iSxXhjNb8uKrugDYk4N2Do6
	V7ekBaAaXpEHA6UcL1+ASGMC45d/AthQxpmT2tux7hrHgGS0DepRcSLxPbdKv9Xk
	e9T2+zMwzn9LwNSVZT0sg==
X-ME-Sender: <xms:6UXhZt3m-pMBRlHMZU--b0W5KR7cdzcUBC9XeArjzwkTaiuk1cOvgA>
    <xme:6UXhZkH28C7mLvG5siINNulUqZzKMzVZr-Gl-G4qHmLVJ1GN32rNUxQeZqTGPZMDR
    JyWviMcm_XBsNwLJNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfekledtffefhffghfetteehuefhgfetgefhtdeu
    feduueeltefghedtjeeifffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrlhhphhgrsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghskhihsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsth
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmihhpshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhprghrihhstg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsfeeltdes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhshhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6UXhZt6XI9N7K5x4FuO5Jep1e4nhCE-fajk4GZfRPdu_E-1ecOdOcQ>
    <xmx:6UXhZq2JJKpyeLi1DOP4afQLZO2hhoYgij5qeTxPZprwZ_VXUQUTeQ>
    <xmx:6UXhZgHR_3IqQxzu4b1epWpksbhP_QqWwqItj78HEyYVo40zEiQfxQ>
    <xmx:6UXhZr9_hdiUOaREZuhLCbLUz3rUa94b8KuKNRBZutD7A3WOkXcswQ>
    <xmx:6UXhZj8AB8bxwabQoO712cDT24Zu-1llJWVXq4kLXrEIhdkN-l9wFQ-s>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 466A32220072; Wed, 11 Sep 2024 03:25:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 07:25:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, shuah <shuah@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Michal Hocko" <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 "Chris Torek" <chris.torek@gmail.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Message-Id: <8130e50c-01e2-45c3-a516-45f5499311f2@app.fastmail.com>
In-Reply-To: <ZuDoExckq21fePoe@ghost>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to 47 bits
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 11, 2024, at 00:45, Charlie Jenkins wrote:
> On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
>
> I responded to Arnd in the other thread, but I am still not convinced
> that the solution that x86 and arm64 have selected is the best solution.
> The solution of defaulting to 47 bits does allow applications the
> ability to get addresses that are below 47 bits. However, due to
> differences across architectures it doesn't seem possible to have all
> architectures default to the same value. Additionally, this flag will be
> able to help users avoid potential bugs where a hint address is passed
> that causes upper bits of a VA to be used.
>
> The other issue I have with this is that if there is not a hint address
> specified to be greater than 47 bits on x86, then mmap() may return an
> address that is greater than 47-bits. The documentation in
> Documentation/arch/x86/x86_64/5level-paging.rst says:
>
> "If hint address set above 47-bit, but MAP_FIXED is not specified, we try
> to look for unmapped area by specified address. If it's already
> occupied, we look for unmapped area in *full* address space, rather than
> from 47-bit window."

This is also in the commit message of b569bab78d8d ("x86/mm: Prepare
to expose larger address space to userspace"), which introduced it.
However, I don't actually see the fallback to the full address space,
instead the actual behavior seems to be the same as arm64.

Am I missing something in the x86 implementation, or do we just
need to update the documentation?

      Arnd

