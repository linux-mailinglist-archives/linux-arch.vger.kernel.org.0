Return-Path: <linux-arch+bounces-9430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E459F7515
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 08:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A31188C35E
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 07:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB791216E32;
	Thu, 19 Dec 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oY/eWZPR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xmVIewcr"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F482165EF;
	Thu, 19 Dec 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591833; cv=none; b=pWldaWrFM0ODPIhkHvkDukvKbocyLYrKjh/XwzaR32qJNacnsf2jjvgc1a92xNNf4I6w053pmJ+KVrlhyLOKgE5gGToAO4nlGgeH1HEnsmSeyKR8g8wFsUHKcq3Jv3pTxf+esAQzwdMR1ZYGOCNhzJEzW7J8wZDYdP3GKriroFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591833; c=relaxed/simple;
	bh=tCgktG21QZ4s1CtyshhufSdMnug4i6S4kgKHktkjsf0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JLPGZmM2+d72H+zox/kYrOuebvQWrnstdy4F38zJbFTH+quOxEdnoEVvH+KphAgn75EYSolz2IoSvjavFG45QdbFqwoQNOPKbjHjnGlurOJUKsp7AmIMySmgMPJE9KUbr6J75xiLSWCZf4yrddrQb7M0ReQO2jphoelpXVH4vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oY/eWZPR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xmVIewcr; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id A81192003B4;
	Thu, 19 Dec 2024 02:03:49 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 19 Dec 2024 02:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734591829;
	 x=1734599029; bh=k43J5anAB96Ch7IfLVC26goHMZDYKuV3hVA5bdHwPjc=; b=
	oY/eWZPR2hoZOZEID//SUz40plFO0YmL/cDeTW7TVToY9wBGdc79QSqYm/3ZddWP
	+Th5hMXNmlvbAUs4xZsNDVpDtdM7JfAg3wPu/DpEK8xbSRjPm7xvrGYBe+D/RPr5
	uhBvghppkGDojAe9Sc7VdMaJzJvwWDn2yP1SzDpqjgeylzcD5rHha+sBf10Z8MUY
	zjfm122PgsBOKR0kHiwP5TRV3NXqtXgI94ycCBwNvW6SMx4sNtkjl2NCTDuO3GEu
	iKfUTsB4AbJSooNGUEabOjQIahs4jCKEhxVyNGATifNR+f3n3w+MTX/xutBM/8gb
	UBxrEYQCQfco5c4mIW21CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734591829; x=
	1734599029; bh=k43J5anAB96Ch7IfLVC26goHMZDYKuV3hVA5bdHwPjc=; b=x
	mVIewcrb+S5H9Li9t0EtG4J0oD/8yiqFu1YmmnOqwRgrgp9J5yPMWL8Rvxl1fuoZ
	NpoDGZDH8YCBHIu2prkjS8vgZ1vqCIabCOCUlGvuAIufD4Ous8eQIININ4VO9lVw
	5oZ77qqHBP1sYs1oduV+I8oTsihoTp8mJ8JBNCfft4os1YlVvfssjYddbR05S5qa
	jp9Onrs43lK4MxJGpdF3toNCpEh2AI1l/M1u8wIZnvPb613KhWovocwi+UBYD+wH
	5hhbjShUCWAzYPLG092kKaKD6vRVVA1SH4DmfNX2Qj6+vDBJR3iQl+bz4MrGsA3l
	xjUjyx4Pe4xatF866CFrQ==
X-ME-Sender: <xms:UcVjZ08o9oSr4vC-yWs_0rkX3tF_de-kiIiySpphPyx8XsVfKRVEXg>
    <xme:UcVjZ8s_0LfBT76dpGaKaKC5xNr7F44n3_6mhljodlJWfmRa80fVfIJed_f2dC3Ra
    cfcwMot3wYtb8tzXWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghp
    thhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhope
    hvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghpthhtoheplhhi
    nhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegthhhrihhsthhoph
    hhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepphgrlhhmvghrsegu
    rggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhi
    drvgguuhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruh
X-ME-Proxy: <xmx:UcVjZ6Djfy0CqQN4vTzFpZUghuE4c8_GRSujiFZOpqKobULrY7d6Fw>
    <xmx:UcVjZ0cXWSJU04bKlE7dy4vLBmwTvHF0ozAlW27OV-4AamEkxEZKtw>
    <xmx:UcVjZ5N3kO7cMmjcmc96BjTIos7f-PzF-xBfcJV5KR5s8w423K77xQ>
    <xmx:UcVjZ-mXW5UA98QDpStGWiYswp6ZnLl6BM4yXYMLy5PwKkxQmfIdZw>
    <xmx:VcVjZyNnjyvt_EgMYqaOa0zhC1TPcMH5UJqxxwhazRVa7nzB-KExPgbA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84E632220072; Thu, 19 Dec 2024 02:03:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 08:03:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Conor Dooley" <conor@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Russell King" <linux@armlinux.org.uk>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Nam Cao" <namcao@linutronix.de>
Message-Id: <0bdeda72-73e6-4749-8d54-66c7614a6f83@app.fastmail.com>
In-Reply-To: 
 <20241219072552-7cd4512c-4f61-408a-9422-167a6f2810db@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-7-f7aed1bdb3b2@linutronix.de>
 <20241218-action-matchbook-571b597b7f55@spud>
 <20241218162031-ee920684-db10-4f17-b1cb-50373d7ea954@linutronix.de>
 <137c0594-e178-4c91-bc8b-5f99b3ddb2f0@app.fastmail.com>
 <20241219072552-7cd4512c-4f61-408a-9422-167a6f2810db@linutronix.de>
Subject: Re: [PATCH 07/17] riscv: vdso: Switch to generic storage implementation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024, at 07:30, Thomas Wei=C3=9Fschuh wrote:
> On Wed, Dec 18, 2024 at 05:35:31PM +0100, Arnd Bergmann wrote:
>>
>> > There is precedence in providing 64bit only vDSO functions, for exa=
mple
>> > __vdso_clock_gettime64() in arm.
>> > I do have a small, so far untested, proof-of-concept patch for it.
>> > This would even be less code than the ifdefs.
>> >
>> > What do you think about it?
>>=20
>> Yes, simply exposing the normal time64 syscalls through vdso
>> should be fine. I think this currently works on everything except
>> rv32 and sparc32, probably because neither of them have actual
>> users that are able to test.
>
> Should it use the specific _vdso_clock_gettime64() naming or leave out
> the 64 suffix?

The VDSO function name should match the syscall name, with the '64'
suffix. Any syscall ending in _time64 uses the __kernel_time64_t
derived types, while the corresponding syscall names that don't end
in _time64 take a __kernel_old_time_t, which is defined as
__kernel_long_t and only 32 bits wide.

      Arnd

