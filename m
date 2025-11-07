Return-Path: <linux-arch+bounces-14562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 460A7C3FFD3
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F7B4EF6F6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA7284889;
	Fri,  7 Nov 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qChaefVE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQuoyt1G"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAE28507B;
	Fri,  7 Nov 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519830; cv=none; b=oN4L26h4jKqNQ9WA48M5Oq/VCt0aOLIdV5rPTzWNGjcBzmnietr71SF9uGrX5PlTLLmPFZvg91+aXMOoP/RPWDCVg2tuitPWYFD/rOWzB4IIfIfLCcWYpH7Ad9zgbPQbvK9vJ4pe4Gv5hvfgGxhZQaFzoyA0SH+gLmPchjE+Ztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519830; c=relaxed/simple;
	bh=pAGwvfl0H7mdN4CM0rfF4FNsJkd5mKjss2RM62GObLA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HWUOIeJQ+JGCsVnQ6SL8va+BLYS8/Wj2VqDBnFOn09NLMCdphZCyT2d577P1OfReiwTGGlhmV5xR+1scO30wYQXg0lq/jWjAaXthVT7BYEFGPFmewo71UZA3m+6TjZAyegpao9RLkUTnU+m2or5INxc/BJgWadIk+6zLPsvLvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qChaefVE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQuoyt1G; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E452EC02A9;
	Fri,  7 Nov 2025 07:50:27 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 07:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762519827;
	 x=1762606227; bh=3C46CBmXvkNh/lNjT5LsxgIlwhV7BbbpfhRABJ49noQ=; b=
	qChaefVEsgOZdf6lVF15n4ab38MYqDzr1mqd/5XHKwbiMkHaV5Dpmq9lC6UY3nvH
	NLLARRlbmvHW9qvCr5nkfH2PW/80SVSWwScra/KDzw++XDKmOT29+VjlGRyMvFlL
	O2J0jgHOUHpWHpUD2Zsxi9m6yURAuJGKcE7tFkSHLIPRjuHb7JjQ3S5O5OpOZHWZ
	rhlMnpHKan2SVqGuYZBOSEpNsVqtdD3GYqeXAeh2XXXX1XPQnkZSV7zRxPZCFbRe
	kOf7OnxwwSvLD8Jtztvr83sjMCdAmxmEpaigTovocm8YROIPRKSO6ZFP4IyIJ4V6
	dNbfXrjQqpEwBuZUe2p9xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762519827; x=
	1762606227; bh=3C46CBmXvkNh/lNjT5LsxgIlwhV7BbbpfhRABJ49noQ=; b=n
	Quoyt1GkFfWLYSqEEnibICGaxv4GhAWsUOcAfICcb+O6WBR/Rlkdfxz6OdjmAfdB
	+LX3ULKcF+9kpM4K/OBBoEPadUP6+BkG4nktOdyeElK5gNvA9M/Xh0RjlaQW8ZkX
	BTZ4xfJsqKxvwLt+HTDiFYApHblC5GL+CCAkFUXtQH0u+lpj+g/I0uk+Seipos5P
	WePnZlT6j3JCKl6+64pc12MltjukZ4KKBY04u5DN+fiNyckiRZouyYQf+U9LJ8We
	DFC51um+oBHVlYWVj1Ob/fRXZgBjhYAxo/HQfpA1Gpa7IBxxYRkVc2IJRFFMf+LO
	GxIpaiwqrpos5Yz2WSKbg==
X-ME-Sender: <xms:EusNaXe9cGgx0dI-PeJ5w3StTzQ9h72ZQBBez2U254nuiMPPCA1eVg>
    <xme:EusNaYBpfHkPJWs8qd_EnBU66ZZftLJQviuvpfzUM8CC1xpKlEycwVu-LGnVwH980
    C6p8jhEg0RIu-L8JoeqJmOZRJd0nOQW_1jSIl_T94WPXQ5fYw2r3As>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkvghvihhnrdgsrhhoughskhihsegrrhhmrdgtohhmpdhrtghpth
    htohepihhofihorhhkvghrtdesghhmrghilhdrtghomhdprhgtphhtthhopehvihhshhgr
    lhdrmhhoohhlrgesghhmrghilhdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggrih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlrghn
    tggvrdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegthhgvnhhhuhgrtggrih
    eslhhoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:EusNabR-hy4dOJ6b7ZA8_OFZ906Sv72CGyDtu6rj06WnoCapJDAqAA>
    <xmx:EusNaZf2IH8cXFinuUPh-BfmQ8e6WYQh-EMZSzWReoRJff04oWaKnA>
    <xmx:EusNaUuLtn1Ywbkws_-PhRTvfwWOoFFn5Kdzpe5Vu10hRHz0PJV0-A>
    <xmx:EusNaVKkyJhqbpZVHw5r5dtgmXjTIEYS4wun2GGp7vf5IzK2kWW1Zw>
    <xmx:E-sNaWadqPTvujXbbeGKAQETVX3PdlND9csF6KeOmKufF6lgMZO8MUNA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 572CF70006B; Fri,  7 Nov 2025 07:50:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvUhhSuyoH3V
Date: Fri, 07 Nov 2025 13:50:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lance Yang" <ioworker0@gmail.com>, "Huacai Chen" <chenhuacai@loongson.cn>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, david@kernel.org,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, vishal.moola@gmail.com,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>
In-Reply-To: <20251107114455.59111-1-ioworker0@gmail.com>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
 <20251107114455.59111-1-ioworker0@gmail.com>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*() about
 HIGHMEM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 7, 2025, at 12:44, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> On Fri,  7 Nov 2025 17:59:22 +0800, Huacai Chen wrote:
>> 
>>   */
>>  static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>  {
>> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
>> -			~__GFP_HIGHMEM, 0);
>> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
>
> I looked into the history and it seems you are right. This defensive pattern
> was likely introduced by Vishal Moola in commit c787ae5[1].

Right, so not even so long ago, so we need to make sure we agree
on a direction and don't send opposite patches in the name of
cleanups.

> After this cleanup, would it make sense to add a BUILD_BUG_ON() somewhere
> to check that __GFP_HIGHMEM is not present in GFP_PGTABLE_KERNEL and
> GFP_PGTABLE_USER? This would prevent any future regression ;)
>
> Just a thought ...

I think we can go either way here, but I'd tend towards not
adding more checks but instead removing any mention of __GFP_HIGHMEM
that we can show is either pointless or can be avoided, with
the goal of having only a small number of actual highmem
allocations remaining in places we do care about (normal
page cache, zram, possibly huge pages).

      Arnd

