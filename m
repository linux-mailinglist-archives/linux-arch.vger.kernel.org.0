Return-Path: <linux-arch+bounces-7100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D1C96EEE3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA682895F9
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573C1C86EF;
	Fri,  6 Sep 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rhRHoIbK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fA+P9AR/"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B881C7B91;
	Fri,  6 Sep 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614074; cv=none; b=uIGaLARVkRp9LRXAO3QTyEtJk1EHJrEZbbewJnZ4lOt1mCELdOiGtu35xdm4urltv+bs6ntUqBUOPnoRQEXuOaxVTvygA4Nqe/bPY1XxLJ1W5gRWGIGJoPB0VDXt5158QrH3JKsHQhxDr71uZ6lYghXlo3C+/K1Nn4cQKO7rbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614074; c=relaxed/simple;
	bh=jPis5Ya78L2vEYZAaqdoWNMrUU8EN6+BbzHRxoHY8SA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G1X8ywCs50oTXL0j+BplI88OQuqn7AZoJ4aXoSdf0Wwa7MNysqevxdqv2g9r5TcqEyEf4ba/Sm4si7u0HrckA9TN5SltuY6Rj5A7kHGsaPvN+CzsWAxAVBKfj6LL832xzOhly8jXcqFarOhGbJMGeCmyG6dcqKopPdOokLzPqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rhRHoIbK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fA+P9AR/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4ECC01140321;
	Fri,  6 Sep 2024 05:14:30 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Sep 2024 05:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725614070;
	 x=1725700470; bh=HqqZZ6TfA9de4ir05q0Y8WhAGkTcX7yt1g8RzTkpSrA=; b=
	rhRHoIbKtDFSnzHI61Rq75TlHSl9k2SjBeupc1+9yYsfutqj0XTUAhwTe67X0El+
	3eGOH5bG9m0bTBqrvXQdcHY4lzA4wOmKR4H/b2DP/iKa65Kq29zI7MZENXoo8tYz
	hd97Qq9TVFeLHqRVUl2+AFbZNUbieaSajw1887Dk8S8dsbgdwYqvZp6I+ybcTZtg
	2Hr1dDPKUAx83AsT6qLRrh0u13B0090NpxIOGolOJf4zBQJ8/4aIS6L8LMrGGjVM
	FuJV09+0VORsSsKn8QnAguepsFVA5QWMn/cQ+7JFlARRPyIff1zNrnH1fhI18UJe
	0+Fn9yfHQsb+oBZSjm+qPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725614070; x=
	1725700470; bh=HqqZZ6TfA9de4ir05q0Y8WhAGkTcX7yt1g8RzTkpSrA=; b=f
	A+P9AR/ByJRZ/Ha0ch+C/+zk4QO0YTdDA4w9ImHouZwYm0oC8dG4gvSqnqJADsHR
	IzwN43wERLjwd7h26Qpk1lRm4W4vaABPLiU+YP32Rm5bNjyG6PQuvz6iNmFARWC5
	bx42Pu+scw3k39Mm9BgUFy3vbUt0RZfCYZ4OzHBraXfx/AIOaP7UmQ9S83DI7hkT
	qSxyIDitipFwMpHUJXNysk7nIjnn7uAAnkXf8Ro+kYKIxxl7TE3UacA885kAgAoW
	PaFzR3EYKMjxTw3XbqPJUXguJeMatqZw+U7AHzWyZTlwFWUyhqo1ar/TwGkNUTj8
	7u6rtwz4vtZlBfThrlCUQ==
X-ME-Sender: <xms:9cfaZh2ZT_FC-WPvVbvQfZPwFcG2XX3UNUoteS3ZhDDrcTUkKOceHw>
    <xme:9cfaZoFbJtdoaCgcpKAC-2wig1xQVXp36e1Twp42-3X1saXO-8mUtL1NbBhprDGqG
    tXu70uHJ4Ve9NumwW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtshhkhiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgrrhhishgt
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshefledtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhprghrtghlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9cfaZh4010GtirbxVcGRnaNBTjQfZdSI5EdzzY75hgZscm07DnGRQA>
    <xmx:9cfaZu2Q_7Web0ZUfzfGGXc6ioi12Vc_YXefRL8S3E8eIArDKsOjDw>
    <xmx:9cfaZkFnxXbFDlrzlrqEsbREC_9JzKdV_QgUIC_tAZiO_QEQiHEmow>
    <xmx:9cfaZv_4o_uw5UmkcZkzuIdi_RdkdMqPcOSNDbkedH7SbQOzaqsxzg>
    <xmx:9sfaZs9LyGysYgm8Zw0BXs-u6pDAEBQm6L7kQOFCapZFQjR1TUzJFQHN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84B61222006F; Fri,  6 Sep 2024 05:14:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Sep 2024 09:14:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Cc: "Charlie Jenkins" <charlie@rivosinc.com>,
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
 "Vlastimil Babka" <vbabka@suse.cz>, shuah <shuah@kernel.org>,
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
Message-Id: <7be08ea9-f343-42da-805f-e5f0d61bde26@app.fastmail.com>
In-Reply-To: <58f39d58-579e-4dd3-8084-baebf86f1ae0@lucifer.local>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <58f39d58-579e-4dd3-8084-baebf86f1ae0@lucifer.local>
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to 47 bits
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2024, at 08:14, Lorenzo Stoakes wrote:
> On Fri, Sep 06, 2024 at 07:17:44AM GMT, Arnd Bergmann wrote:
>> On Thu, Sep 5, 2024, at 21:15, Charlie Jenkins wrote:
>> > Create a personality flag ADDR_LIMIT_47BIT to support applications
>> > that wish to transition from running in environments that support at
>> > most 47-bit VAs to environments that support larger VAs. This
>> > personality can be set to cause all allocations to be below the 47-bit
>> > boundary. Using MAP_FIXED with mmap() will bypass this restriction.
>> >
>> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>
>> I think having an architecture-independent mechanism to limit the size
>> of the 64-bit address space is useful in general, and we've discussed
>> the same thing for arm64 in the past, though we have not actually
>> reached an agreement on the ABI previously.
>
> The thread on the original proposals attests to this being rather a fraught
> topic, and I think the weight of opinion was more so in favour of opt-in
> rather than opt-out.

You mean opt-in to using the larger addresses like we do on arm64 and
powerpc, while "opt-out" means a limit as Charlie suggested?

>> > @@ -22,6 +22,7 @@ enum {
>> >  	WHOLE_SECONDS =		0x2000000,
>> >  	STICKY_TIMEOUTS	=	0x4000000,
>> >  	ADDR_LIMIT_3GB = 	0x8000000,
>> > +	ADDR_LIMIT_47BIT = 	0x10000000,
>> > };
>>
>> I'm a bit worried about having this done specifically in the
>> personality flag bits, as they are rather limited. We obviously
>> don't want to add many more such flags when there could be
>> a way to just set the default limit.
>
> Since I'm the one who suggested it, I feel I should offer some kind of
> vague defence here :)
>
> We shouldn't let perfect be the enemy of the good. This is a relatively
> straightforward means of achieving the aim (assuming your concern about
> arch_get_mmap_end() below isn't a blocker) which has the least impact on
> existing code.
>
> Of course we can end up in absurdities where we start doing
> ADDR_LIMIT_xxBIT... but again - it's simple, shouldn't represent an
> egregious maintenance burden and is entirely opt-in so has things going for
> it.

I'm more confused now, I think most importantly we should try to
handle this consistently across all architectures. The proposed
implementation seems to completely block addresses above BIT(47)
even for applications that opt in by calling mmap(BIT(47), ...),
which seems to break the existing applications.

If we want this flag for RISC-V and also keep the behavior of
defaulting to >BIT(47) addresses for mmap(0, ...) how about
changing arch_get_mmap_end() to return the limit based on
ADDR_LIMIT_47BIT and then make this default to enabled on
arm64 and powerpc but disabled on riscv?

>> It's also unclear to me how we want this flag to interact with
>> the existing logic in arch_get_mmap_end(), which attempts to
>> limit the default mapping to a 47-bit address space already.
>
> How does ADDR_LIMIT_3GB presently interact with that?

That is x86 specific and only relevant to compat tasks, limiting
them to 3 instead of 4 GB. There is also ADDR_LIMIT_32BIT, which
on arm32 is always set in practice to allow 32-bit addressing 
as opposed to ARMv2 style 26-bit addressing (IIRC ARMv3 supported
both 26-bit and 32-bit addressing, while ARMv4 through ARMv7 are
32-bit only.

      Arnd

