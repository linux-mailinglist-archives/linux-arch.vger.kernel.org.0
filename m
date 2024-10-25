Return-Path: <linux-arch+bounces-8545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C858B9B058E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE781C22A25
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A101632F8;
	Fri, 25 Oct 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ABY0h0DT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMDBtAyi"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7521216E;
	Fri, 25 Oct 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866034; cv=none; b=Abwv/t2YNoFN8y7XBNB3cEsVhOyJO5/bdGYRftISrDMrS0s3WYVSLkJmYf/BvUK5rf0khCaYRMlfzxAZegow4m+VpgJr195IHC0A0Chbg3RMdCKVDJjxVGSb8tEr08sCwuTA0hwHvdz5bcgTskPQ8bdQScRvvC69wR8429nucw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866034; c=relaxed/simple;
	bh=jO2eJCq3o1UQyWfSIXb4J+AN0Vw5/ZfDFBnPWf9w6Uc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o+u8UMk7GiGTFXXE49kDTHV3eo7Pt8amkkuqqVeG9Lck0QX61KAWSO7PNxjgB0D0ZNpXKIgROOJV0XkP9qYionY/O/YRnZF2JqOeg3x0ch0pVzIn0m2ESKJzvVM8n1HEvKtan0oU3P560Xne2t8KET9KZekNUknIOa9KX5EjgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ABY0h0DT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMDBtAyi; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7146011400DA;
	Fri, 25 Oct 2024 10:20:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 25 Oct 2024 10:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729866029;
	 x=1729952429; bh=wscwvk+/zfYGrxB9o7ElzO1RcnFw9HTQg1kU47YxPvw=; b=
	ABY0h0DTDAGctuJpIL6sS/zNH1ENNSmPu1GTEjlpQ5i/MnCrJwqbpzaF8Fzl6SAE
	ty89srR+XMB3y0GO59LDr1lbqoSGUHF5vYQgUpFuvNnO1I9a4HVWWkekFIh4+iw3
	++kRrGeULuovgoGE3lEBDVxVt76SyxQs7lrHVSg8RuKA40TCIekZuPf24SgW3VWv
	y3Go9YZsNXysA0v31RtM5mhjq55MKMYCRF8fvYc4ghnxRT3QD8XS1b9MC2d8P6d6
	Z8U2JobiENX6AweBG/AEkr2ZKdC++1C11Tmg1u0yUG3X4E9UHQDdWn82DAio4qtN
	aMp4W5bYIp8Yz6/pab3idg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729866029; x=
	1729952429; bh=wscwvk+/zfYGrxB9o7ElzO1RcnFw9HTQg1kU47YxPvw=; b=A
	MDBtAyiMr0utwlTGZ9ahqEfZF+IyfWeBqehZ/0Ns+cmcssE0+i0bkROW05yMQsdU
	cOTraYDNR+PM39pXp17Q9l9ugknz+vTCTQqT/gZhppAEN6O0InRdGseTWr8j1cze
	Fh85jShfOWDbEdB0hWDEpn6IEq1jIfU7dSqLAnRoCGh4mEvMa8892HRjDW/qPVrh
	sqZA/2i1Ti+Bigv3Tveu8uo1Y8isbmRx0sJLqb1tUaroWhRIpYaXvCvPydz38kPd
	pYcZr+L3SnOemqTzyNUjsUx5qUUrTSGRa8aYrLXmY/VkDwv4EtZ/DOZ7py6b/hVf
	mW3ecRgZZT5G1a+zLc9rw==
X-ME-Sender: <xms:LKkbZ6icSWtXOvkpYM87hQ0HLds7qfX9s7056_cXCQ0XSAle9zkPOA>
    <xme:LKkbZ7C_7DPvl407kdsjlRrFBtoBQJcEsNgwljwRSIMZwcU56VrT5yfDgceTXrYKx
    0resZ0Qv9r5yzYJWd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhlrghighhhthesrg
    gtuhhlrggsrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrd
    gtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehjvhgvthhtvghrsehkrghlrhgrhihinhgtrdgtohhmpdhrtghpthhtohephihsihhonh
    hnvggruheskhgrlhhrrgihihhntgdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LKkbZyEWph2OfuX5rp36qDXrBJGFeVx6L1j670c9oST-ROWHYLjhYQ>
    <xmx:LKkbZzR-6CCISyD9v6h5geDwiCkn4rdaBNnAtm7k4SX1CIBqrMUUXQ>
    <xmx:LKkbZ3w4lJB7XWYZExVb0i0_12fv6iRgHLcVQnpS3OZQYPaEV3l1GQ>
    <xmx:LKkbZx4REtWx5i2Ye5_3HOyXw3kOW56cp2xiDUXTExtzk2q_YJoAQw>
    <xmx:LakbZ8y4B_V6lMqvAbM25tHAe9VzZYCl0gf6JwYlrpYjDtQ8-3zK5Ogl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E61A2220071; Fri, 25 Oct 2024 10:20:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 14:20:06 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Laight" <David.Laight@aculab.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Takashi Iwai" <tiwai@suse.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Christoph Hellwig" <hch@infradead.org>
Cc: 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <a6c524d4-d741-438a-b8ae-2492058a3b3b@app.fastmail.com>
In-Reply-To: <0577266edb9440acb082c9e02c0a73b9@AcuMS.aculab.com>
References: <20241021133154.516847-1-jvetter@kalrayinc.com>
 <0577266edb9440acb082c9e02c0a73b9@AcuMS.aculab.com>
Subject: Re: [PATCH v10 0/4] Replace fallback for IO memcpy and IO memset
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 21, 2024, at 14:16, David Laight wrote:
> From: Julian Vetter
>> Sent: 21 October 2024 14:32
>> 
>> Thank you again for your remarks Arnd and Christoph! I have updated the
>> patchset, and placed the functions directly in asm-generic/io.h. I have
>> dropped the libs/iomem_copy.c and have updated/clarified the commit
>> message in the first patch.
>
> Apart from build 'issues' what is the justification for inlining
> these functions?

I think I wasn't clear enough with my previous comment, and Julian
just misunderstood what I was asking him to do. Sorry about causing
extra work here.

> They are quite large for inlining and some drivers could easily
> call them many times.
>
> The I/O cycles themselves are likely to be slow enough that
> the cost of a function call is pretty much likely to be noise.

I'm not overly worried about the this, as the functions are
not that big and there are not that many callers. If a file
contains multiple calls to this function, we can expect the
compiler to be smart enough to keep it out of line, though it
still gets duplicated in each driver calling it.

The bit that I am worried about however is the extra #include
for linux/unaligned.h that pulls in fairly large headers
and may lead to circular header dependencies.

To be clear: what I had expected here was to not have any
changes to the v9 version of lib/iomem_copy.c and to simplify
the asm-generic/io.h change to the version below.

       Arnd

---
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1211,7 +1211,6 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 #endif
 
 #ifndef memset_io
-#define memset_io memset_io
 /**
  * memset_io   Set a range of I/O memory to a constant value
  * @addr:      The beginning of the I/O-memory range to set
@@ -1220,15 +1219,10 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
  *
  * Set a range of I/O memory to a given value.
  */
-static inline void memset_io(volatile void __iomem *addr, int value,
-                            size_t size)
-{
-       memset(__io_virt(addr), value, size);
-}
+void memset_io(volatile void __iomem *addr, int value, size_t size);
 #endif
 
 #ifndef memcpy_fromio
-#define memcpy_fromio memcpy_fromio
 /**
  * memcpy_fromio       Copy a block of data from I/O memory
  * @dst:               The (RAM) destination for the copy
@@ -1237,16 +1231,11 @@ static inline void memset_io(volatile void __iomem *addr, int value,
  *
  * Copy a block of data from I/O memory.
  */
-static inline void memcpy_fromio(void *buffer,
-                                const volatile void __iomem *addr,
-                                size_t size)
-{
-       memcpy(buffer, __io_virt(addr), size);
-}
+void memcpy_fromio(void *buffer, const volatile void __iomem *addr,
+                  size_t size);
 #endif
 
 #ifndef memcpy_toio
-#define memcpy_toio memcpy_toio
 /**
  * memcpy_toio         Copy a block of data into I/O memory
  * @dst:               The (I/O memory) destination for the copy
@@ -1255,11 +1244,8 @@ static inline void memcpy_fromio(void *buffer,
  *
  * Copy a block of data to I/O memory.
  */
-static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
-                              size_t size)
-{
-       memcpy(__io_virt(addr), buffer, size);
-}
+void memcpy_toio(volatile void __iomem *addr, const void *buffer,
+                size_t size);
 #endif
 
 extern int devmem_is_allowed(unsigned long pfn);

