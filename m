Return-Path: <linux-arch+bounces-13722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB64B94968
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 08:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FE917011A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89A30E0FC;
	Tue, 23 Sep 2025 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PoyGypxh"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4156E30F809;
	Tue, 23 Sep 2025 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609581; cv=none; b=XKNFN78cpjcIvjsvmYogE9KqW7Cy199fPgjlscgLGnzfmN1NT8JE91QFQk2BoiHlR7PrBy6/a3Vx4bpoceO2oJvN/iIRPlmCkhP/6ycmI0wUnjUSB/K1B2y7nqQ1ijb5r2okRiEa3zXhq1fED/uU/ENcepdU0kYJxNqunrBI2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609581; c=relaxed/simple;
	bh=sBCSxw2Du136/zyemB7LP7VOMletXa/Q9L7u5R6oZSo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V+jNeG0N1mPfwp8D057nefEDU5L605OAHWsClKTK94FRduwfhLf4nonZNfAEbfAp7VkraTUOiN7KulDCWtWw0tKyQl0OJpKGBb5lDqNPc+RqByDZS7XMYJSB1jU3NEy2PrBjdISEfFaNHZlEF2yMQU/uI1LDdfOqFUjFpeFM6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PoyGypxh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FA88EC0105;
	Tue, 23 Sep 2025 02:39:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 02:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758609578; x=1758695978; bh=WjdOhOTebQP+EKWii4PIUkCVph+E5lxqgnB
	eIS3Ngpo=; b=PoyGypxhhxUvJ2UxTUfDq9jxiJlIsHG5IP7DzKPTx8hNujNTp12
	u5zTS7Gd4DoIDfqdwnQhuQPSDsy2Z3Xdo+c6zPe8HNt7imnItQsZ9X5LZtCQWCwW
	Jb18ZsIqQdnQ/LQstzfeKhDNymFf42QDXqISjXONf7Eru7fDdqf27IcADql3ow0u
	IzsOH2+VQ3doEpPmS45PBheytGqBl+pPlk9kU9FJWsxZhQuYaryKXHWE2mXvzDRX
	oQ6kzqCRhxCd7yghBfl8FEw2p8hWT+n/igl6vrdU33Di/NArQH5IaZiEVTANNzKi
	83wr5gN+LsCr8lwGfOYDWum41ivcUbDQSXg==
X-ME-Sender: <xms:qUDSaImfL75LKT0jafZ3DwXROWZwCZfbgdeOfZvVjv_x9Oc-HbyK5g>
    <xme:qUDSaDvWzJps-WQ5x1LhCiIMrwP8H_OKvLmD35FddUeZRNEcp5_RgaJIb3kyJZ1m6
    P0Gkk2HDfQUBn7-T6baFpr4jgWgV5jM9h96Jqxj4acDZStV5nlxTw>
X-ME-Received: <xmr:qUDSaDpU32l3B4bvQ9owr74JFiTOcs8y6g44sUt6C2ZGmdz_S1GANJRvgBHDJn_aY5TPbq_Ci75RpjPMEO_73G5MTY4h2mcWew4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpth
    htohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrh
    hkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtg
    hhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qUDSaJdjbGisanGgPUOBJoTuv42g8RqBslKU4iPL9ysSpTzwO-TN6A>
    <xmx:qUDSaLlKJWHoNIsk3lk9qZDwmvp8xzcU0LnHIrv0JBiKhsuY2pebnA>
    <xmx:qUDSaAZEPWEkseMu4y2C24hYXu_-TEEul8hN62wDrAlLcodU8Rj9Gw>
    <xmx:qUDSaA7xRaK1bIWv-GM8U8hcN59vDUp8kQpyB1fyfbxjoaEGHI4CGA>
    <xmx:qkDSaJyOFPOJJymVhSMgseQ-bos9Cc-LpInCcKcNmhTBMtt-YA4jezmE>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 02:39:34 -0400 (EDT)
Date: Tue, 23 Sep 2025 16:39:31 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <61895919-76ef-485d-ad5c-0cff866566f3@app.fastmail.com>
Message-ID: <3d3b1a8f-7f60-f03b-f13e-089f605961e6@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org> <20250915080054.GS3419281@noisy.programming.kicks-ass.net> <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net> <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org> <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com> <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org> <534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
 <0d93c6e5-a4cb-2f5c-e87d-e42a283324d6@linux-m68k.org> <61895919-76ef-485d-ad5c-0cff866566f3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 22 Sep 2025, Arnd Bergmann wrote:

> 
> I don't think automated transformation is going to work well here, as 
> you may not want the same approach in each case, depending on what the 
> code is:
> 
> - it may be enough to annotate a single member as packed in order to 
>   make the entire structure compatible

Right, and that's the only transformation I mentioned.

> - some structures may have lots of misaligned members, but no holes, so 
>   a global __attribute__((packed, aligned(2))) on that struct is cleaner

That simplification should be amenable to further automation, if the first 
transformation is.

> - if there are holes, some strategic additions of explicit padding can 
>   be cleaner than annotating each misaligned member.

It's a matter of taste.

> - automation won't be able to tell whether a structure is ABI relevant 
>   or not

Right. That's why I said the list of struct members would need to be 
"manually pared down". But even that task may be too large to be feasible.

> - similarly, many files are not going to be interesting for m68k. E.g. 
>   if drivers/infiniband has an ABI that is different for -malign-int, 
>   that can likely be ignored because nobody cares in practice.
> 

Right. That's why I advocated running the plug-in on a "normal build" not 
a contrived mass of #includes and structs.

