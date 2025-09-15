Return-Path: <linux-arch+bounces-13618-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E97B577F6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3DE188C8DE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C02FF157;
	Mon, 15 Sep 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PksHnQkG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMBeYwCv"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC472FE596;
	Mon, 15 Sep 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935251; cv=none; b=qT3UA86HmRvcaxjdpOw5IMtA+B9dIIm+XPRJd6fqX2BSUNyNWAQudX2pNDRSe0JXsuAGN2+OLpgK5nOpQASL3M5Y0jmsblb3I1PfQBDTIRdZFckoIWBIczNZZTkWDYbGvWLHOqKkbbYiHQZTU434jEjO197M6HT3EqW2x2Rs+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935251; c=relaxed/simple;
	bh=zbH3Sq7UGPV7WPhhaxd8Yvi2wuxAjlLJYGnbPaOlAfo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ivpN8d6AKRLYpzdAPvRo39PuO9Yy4Z+M4PpZ7m/mv1MEzG2rKfLdYGjare12Jakhe4gaIbgpMgNcM1w4rmPnawyqIb76aFc/zWEkeBOvH71EOyz2QIjkavL/X2VsZcHhdwEAFu2bsTUKDRFeX01xjkSqxAsn5cG6LUCs6QUeu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PksHnQkG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YMBeYwCv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FD64EC02C5;
	Mon, 15 Sep 2025 07:20:48 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 07:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757935248;
	 x=1758021648; bh=uEk7o86KA2BK6dW6CATkYcz9HATj19zLVA3hWqXLyMI=; b=
	PksHnQkGtt0FGFUKelfpBE+O+Or9ft7uD5K2shvi6ZswaKtxTfYT9gk+WYI+Q23j
	57barHkfQ9gVwOU5tz1Hr0vs1CyINrKHNV7yH3VYNvmWipHJgW/U1AO8RRC/zrZM
	7gGom3ZRnCZ0olHMkfIQFQE+CEbt8fzQD0zBiritQ5i1ozLdHmsepKvvOLHLY9Xu
	VHdMqZVL4w4rvhGTNNmP3OZl1F+4sCmyMyJ/KGVC/PpnNCMZZXBUDhbc9Surh51f
	IK2wq9O8heecXgcEgMWQ/83g7UynILxoXfnF0tY9q7Bq26QiC7efgV6ztilHVBRz
	pKcJJ7qKqfMpTSqeTRpBLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935248; x=
	1758021648; bh=uEk7o86KA2BK6dW6CATkYcz9HATj19zLVA3hWqXLyMI=; b=Y
	MBeYwCvxOa+y0fjL8aSRuIAYmJWcJCZP8dI1uw4dqfNWl0yrKeC9hPwccGTYAf1r
	/M44FQV1wecMxVfdkGHZyiMgd5pgH1O+EHffm/Sh3ayFHR/+HrRS6PfDJMYJoE2K
	jTjPDQBnXdwp1y/l4G1IKGJc6gATzZGyOpoyQU/aXXCSSHBsr/HUb9Qk+5WkoD/E
	/CZN4bNLAvWiz0oAcdojRBjI44Tw9SQPI4HxcPUOP96KrQ8ok8jVJ4XoD/104pAX
	rfV8cl07R+M18znMlXhOS+aDuT0xuzV9bFYmAdSeK2ehpZX9P6QkcTSSRyG61qCn
	YWDyq9qstduOOCbTZOtEA==
X-ME-Sender: <xms:j_bHaK7yocb90JvezdegEb_OhJo-vAsoJxs3066VXYjZ-wdtdVc2qQ>
    <xme:j_bHaD7EWvdkLTOWl8ZRjKXWIcOQbpDbBDNeY3i16qghQ2l22S7tbxxPTjKWmz7Ve
    l62_fEUicoRU1u5EfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhdrrhhuth
    hlrghnugesrghrmhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehfthhhrghinheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmhei
    kehkrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoh
    eplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j_bHaEjGcLrS2FBmAyOM3faqS7XlIXi5iCAdZE3qLbuNIT8uWT9r2w>
    <xmx:j_bHaBZW2rZO67iJEjbyMMYC_vbuXVqWo_-GY_t34A1IkLti42zZLw>
    <xmx:j_bHaJ-oRKeoag4CAWD8VpQxbbc-lwg16R0f7XUJkoZkx9ln6TNXfQ>
    <xmx:j_bHaDM82YI-J4N270SKIQaAjnx2opdP6HLtQ_e_bCv5sgN_GRPwzQ>
    <xmx:kPbHaIIoAn8-4eaNMtACqgP7woLu1G0_fRf7JrFnRTscDMO2TtD_-HsE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4719700065; Mon, 15 Sep 2025 07:20:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-ya5D5_Z2ZZ
Date: Mon, 15 Sep 2025 13:20:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Message-Id: <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
In-Reply-To: <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
 <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 15, 2025, at 12:37, Finn Thain wrote:
> On Mon, 15 Sep 2025, Peter Zijlstra wrote:
>>
>> > When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
>> > - 1) probably doesn't make much sense. But atomic operations get used on 
>> > scalar types (aside from atomic_t and atomic64_t) that don't have natural 
>> > alignment. Please refer to the other thread about this: 
>> > https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/
>> 
>> Perhaps set ARCH_SLAB_MINALIGN ?
>> 
>
> That's not going to help much. The 850 byte offset of task_works into 
> struct task_struct and the 418 byte offset of exit_state in struct 
> task_struct are already misaligned.

Has there been any progress on building m68k kernels with -mint-align?
IIRC there are only a small number of uapi structures that need
__packed annotations to maintain the existing syscall ABI.

       Arnd

