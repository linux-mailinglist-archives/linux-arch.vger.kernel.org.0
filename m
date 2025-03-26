Return-Path: <linux-arch+bounces-11148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1AA720D1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986F317B09E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92D1A0BF1;
	Wed, 26 Mar 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bjP8F5De";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwnQi8Av"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59364D;
	Wed, 26 Mar 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024799; cv=none; b=SE+u95wH4pL9e5YFgtb2+bI+deDau4dHwpLzTKltt8ejB96oxfKRdUyYRk3Wc1/lDa5pbBVwWj2jKvifyb/wEBkS2fPofTqF2vwTa2UXbsahNuKDc3ZCehOtK3MfGblTo0ORIDBf0A/gc26WH9kjJg4OFwMgIApf4K0eRXMDxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024799; c=relaxed/simple;
	bh=n0XOhzwZhLMH2flKOyxecwEG6knDVr7RLXRZpv66m3M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KAxiW6Bobl/U1wT0oJmS0ctOw2D3816kn0GPDnsGeeVGgqn66ZuvLw9o0VFeFwR2/XP3mfrSlSXG2BxZjv9eiHBphp7ILgv05GXIDBzfswxf5xq1d08GhKzf4jIW0TaydlgtHQ756ZVBhAh3MQ3ydWugwbAHIDiM06tgto+azTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bjP8F5De; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwnQi8Av; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A49A114025C;
	Wed, 26 Mar 2025 17:33:16 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 17:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743024796;
	 x=1743111196; bh=V11GpFRgrx+bJA6y0MdeOFUCy+2rHUwQfLFe2+VIqUA=; b=
	bjP8F5Deb7eqk6BLVZ/6CLWDZXm35A94h7W7llt4Gogkw6fLudNGI2IfOwCJpeOe
	wBlqklqiMAoZx1ANnGvyZN0HAFBgyT9t0DIhEE1CrX9gibfAR5N2r9r2VHgmMDvj
	GI2Kh8AvSssAeHcTaBQ9q3SpKX8PGzMqyaIwbqq3UA9bbBh2+fHsIBZKa7z3kSe5
	C9tfDOiTQmjJngbQC0eDlGCNiml4h0PtDj1I58glbQ6HqBJtivecGz3Dz0YKb42o
	aXrBb5sn+d3TI/z8zyIeig4jT/nbcV5wcakOGPK3ybR2wMFJirADtTns2N9AfJMn
	0r9UpA5vqgCXrDSMXCRQog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743024796; x=
	1743111196; bh=V11GpFRgrx+bJA6y0MdeOFUCy+2rHUwQfLFe2+VIqUA=; b=A
	wnQi8AvOqS/oAftEXVEpCFYyBiT11YkQXcxMYn0BFzvdIwPxRq8XI4qS6yDLKED2
	M86WSymNPB9s9BADMHwBFPzfVYc3bmZR3YvoBAwsGmOXR+1F13orTyP1XUWDYCIV
	6SktEEWIKiFSSr42H74Xjz+wEOuyKkHaerxHCWSyzy0gVCyIwTL5AnBw5s4w1LPJ
	wPOQYA72U7IaO2px5LE+Z7fXh3vkJH2LY7I+o7tdm1wh2FX+mHf1dF6wu/9gC1R4
	YsHhibrRaWRG6THTsSBDd/EwRfZPd+3VjLO32Pz4GC1i+JQbM+P0h+L3ehf4rnKO
	zWDCJaXFbVcMJLCCxw01Q==
X-ME-Sender: <xms:nHLkZ3M3byighQQOy66pX5liMZcOUE6NR9d-rB9V2HMv0u5UdjDJ-Q>
    <xme:nHLkZx8KJkNMC909x4gjRreDV_EkFYp7ZypSJOXeSYenazKy85C3J9tXdr6TrcR2H
    _jOYzCIHxK3fmskCDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeiiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelveff
    feelkeeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnrghthhgr
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqd
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nHLkZ2SBPvJgaTVO3C911doo3vgUt3hYSweHgcSws2cISobTpilO5A>
    <xmx:nHLkZ7tb8JFPcaCKDpE2234LHjy127Nb6vg8TtM909FQkWQknDGQ-g>
    <xmx:nHLkZ_fUaAxqVM06dwBe-_5z55213jEMCCuvFiCz3Z0pJRxz6bFK3w>
    <xmx:nHLkZ30zk352AboL6vneGonNaZrv1AWKZi9SEioktsOAOEQRmdaIDw>
    <xmx:nHLkZ25z-ixpgWXFGYMWx5OWc6EoGxy792E7PRvr8a4MqMed1HzjYVrZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2D7422220072; Wed, 26 Mar 2025 17:33:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcd9fae1fedaeca94
Date: Wed, 26 Mar 2025 22:32:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jann Horn" <jannh@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Nathan Chancellor" <nathan@kernel.org>
Message-Id: <8ec475fb-9972-45d9-8fd2-9406ed3862ec@app.fastmail.com>
In-Reply-To: 
 <CAG48ez0ZahF98zN+qKrizDC8MBM7CM=WMBOzk7ybr55Er37=pA@mail.gmail.com>
References: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
 <CAG48ez0ZahF98zN+qKrizDC8MBM7CM=WMBOzk7ybr55Er37=pA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 6.15
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, at 22:08, Jann Horn wrote:
> On Wed, Mar 26, 2025 at 8:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> The following changes since commit 2014c95afecee3e76ca4a56956a936e232=
83f05b:
>>
>>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.gi=
t tags/asm-generic-6.15
>>
>> for you to fetch changes up to ece69af2ede103e190ffdfccd9f9ec850606ab=
5e:
>>
>>   rwonce: handle KCSAN like KASAN in read_word_at_a_time() (2025-03-2=
5 17:50:38 +0100)
> [...]
>> Jann Horn (1):
>>       rwonce: handle KCSAN like KASAN in read_word_at_a_time()
>
> Uh, sorry about this...
>
> Nathan Chancellor just pointed out that my commit "rwonce: handle
> KCSAN like KASAN in read_word_at_a_time()" breaks the arm64 build when
> LTO is enabled (<https://lore.kernel.org/all/20250326203926.GA10484@ax=
162/>).
> I just posted a patch that undoes the buggy part of my patch at
> <https://lore.kernel.org/r/20250326-rwaat-fix-v1-1-600f411eaf23@google=
.com>.
>
> @Linus: Sorry for throwing a spanner in the works here... maybe you
> should only pull up to the commit before mine (luckily mine's the last
> in the stack, and it's not important), or wait for Arnd to give his
> opinion.

I've already tagged a tags/asm-generic-6.15-2 with your fix included
and the same tag description.

I don't think it's worth doing a partial pull here.

Linus, if you have already pulled the tags/asm-generic-6.15 tag,
I suggest you just apply the fix directly yourself, otherwise
you can use the tags/asm-generic-6.15-2 tag instead, or hold off
for today and wait for me to send a new pull request after
I get an ok from Nathan.

     Arnd

