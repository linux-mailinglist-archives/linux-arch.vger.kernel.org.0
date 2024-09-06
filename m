Return-Path: <linux-arch+bounces-7097-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D541C96EBC6
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 09:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D1A1C2176C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524E14A630;
	Fri,  6 Sep 2024 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AxWQcdQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQ4vAzl5"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E017C9B;
	Fri,  6 Sep 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607088; cv=none; b=HhR5TZukNob9tX/+qsdLIqJS/p2N6JYH11j7DANP7JMSm/03eo8aHP0uM/41gekKkDPxe1IJ1B3RizLAhimdosg/NnhV2UcyEAZvsNU222pdqvxJnT/H1yg9tp+XZMrlx3h08a4uMg1usdmzoMmonRpmJKgDwW3wV6jGV74QfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607088; c=relaxed/simple;
	bh=0oCmPSvWGTy2f0VIdWGKCPBfc6W/HQIHL52ESx/jxuM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PrdUkNuybv/+MsxoeVcL+UlbJEyeslsr8D+MoBagNihIrOSzNo9b4WTS0tzoKHZAhLS30t4LpMjhPDtlghk5AUW5tnY65VNuPbmoiC1oBr2EsJasvyQwna5IPCvJnf+q9Q2W8x7rs3N/9TPA35APdVWaDh6iKrmumMr4ELTTNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AxWQcdQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQ4vAzl5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B5CB13802C7;
	Fri,  6 Sep 2024 03:18:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Sep 2024 03:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725607085;
	 x=1725693485; bh=v3KUbqaJkdY70T8W1uPjXNY2qtbx3TSnJ5p4uWowLhw=; b=
	AxWQcdQBBy5MY5LR3xwmV8ftTMSDyfzy8uMAIvGDGYA/4FNSSidR03Q6z8e0TXug
	PpEjS5YqgQ502cAyrm7j6Nvigzq605yz5YwSO3JiOe3/FXBCHlngY5V5PVMIr487
	VUSjL4tJVP6OFjnnqg1HoF8QsB+6sI7taNK/oAdpOcFiUnH686sKqO25I2yHKOuM
	JrZVX/t8Us5zu5WM9jZMRlrMnBpKfykFgLNwiCWlwt6U2yw0jnOj3SW5OIquyZUO
	fdhfRgBq2xT4DRug2Kn62hViO+kh82DPTKBqaj3HDxG0eHkKtmh1khZl5XN4pJkM
	K28AGb4R3bhfJPmD9CxpdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725607085; x=
	1725693485; bh=v3KUbqaJkdY70T8W1uPjXNY2qtbx3TSnJ5p4uWowLhw=; b=l
	Q4vAzl5ij40FSbTZDX/TJGtvv3jSjWN9u7tzU4cP9jEF02ckmc7h7qV/g9Hh5vHu
	moq2s7qwuxoIzzvDrBRkj2L/Nr9L14oTTEwaYRCzKdz2eXVyWOpY+kNb+doOLSnp
	LnLr+MIsc8ritmbQtAD8TQBh19o0rNgY+sWgTpZsL+UzbVzTg8HkIG4zekAU1tUH
	G2ZIj3cMcg5S8cRUTOU531MMMRQOWsLajMgegRsv4tYKdb2lvfkoL6QbmMGj0smz
	tBED5Z/sifZ4Ghm7/SsZIyRPWvQOGTWbuu/HV2Qxyr3dh7E8aoqWFFU4+KBpUesq
	ymdnutIS9npVG3PhDFqdg==
X-ME-Sender: <xms:rKzaZrLvHla75wnlpr7R0cPoVM6UBF1_EWMOZGA0tiLDWOElOVpnIw>
    <xme:rKzaZvIWlBIXV2FXaH9I65MyhU46-F6cXbblgwEjSKOkJ2yD9UtuF3px4bdOoKsaV
    kGnV4ibnHsbtORFbzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeitddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghskhihsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghs
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmihhpsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhprghrihhs
    tgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsfeeltd
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhshhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgrrhgtlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rKzaZjuJI_ANUMt0I1G1DfxkRxmMCNydPTWWeEmukidR1uUeo8eH3w>
    <xmx:rKzaZkbcsx13sdy1VYkCpEYC9g_s7t24UGGF5Hf43eKq3-D9-scrkw>
    <xmx:rKzaZiZyRz7TWGuH6LednS29c8h60NR5cEeKjOP3IhSS8TIXYXQSfg>
    <xmx:rKzaZoBa6GQ3HsTE0ps1XLUtiuVXIFzxJ0IP6raLl7erRlSZA3T0Tw>
    <xmx:razaZvTZpuiRYNqT2HYIcH8xgOUDfaV4t3ghWazI53ACXqDOZDab_IM4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 99D14222006F; Fri,  6 Sep 2024 03:18:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Sep 2024 07:17:44 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>, guoren <guoren@kernel.org>,
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
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, shuah <shuah@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Michal Hocko" <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 "Chris Torek" <chris.torek@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Message-Id: <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
In-Reply-To: 
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to 47 bits
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 5, 2024, at 21:15, Charlie Jenkins wrote:
> Create a personality flag ADDR_LIMIT_47BIT to support applications
> that wish to transition from running in environments that support at
> most 47-bit VAs to environments that support larger VAs. This
> personality can be set to cause all allocations to be below the 47-bit
> boundary. Using MAP_FIXED with mmap() will bypass this restriction.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

I think having an architecture-independent mechanism to limit the size
of the 64-bit address space is useful in general, and we've discussed
the same thing for arm64 in the past, though we have not actually
reached an agreement on the ABI previously.

> @@ -22,6 +22,7 @@ enum {
>  	WHOLE_SECONDS =		0x2000000,
>  	STICKY_TIMEOUTS	=	0x4000000,
>  	ADDR_LIMIT_3GB = 	0x8000000,
> +	ADDR_LIMIT_47BIT = 	0x10000000,
> };

I'm a bit worried about having this done specifically in the
personality flag bits, as they are rather limited. We obviously
don't want to add many more such flags when there could be
a way to just set the default limit.

It's also unclear to me how we want this flag to interact with
the existing logic in arch_get_mmap_end(), which attempts to
limit the default mapping to a 47-bit address space already.

For some reason, it appears that the arch_get_mmap_end()
logic on RISC-V defaults to the maximum address
space for the 'addr==0' case which is inconsistentn with
the other architectures, so we should probably fix that
part first, possibly moving more of that logic into a
shared implementation.

      Arnd

