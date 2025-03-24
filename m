Return-Path: <linux-arch+bounces-11060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07EAA6DD39
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 15:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A65B188C033
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74925F999;
	Mon, 24 Mar 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TXDFYQ66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kn0Coouh"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016C25C6FE;
	Mon, 24 Mar 2025 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827238; cv=none; b=YMViJuVDsXxYOcgOP9mB288xHk9RdstSjSOkJQKhhZ7Do2cVgJe7vWRlDUdYEg6Yn4YHh2Q1CXlIwsvFdxUVHWsFDwBZpTNRdQVLrTtshrt7HY/dYSdQHTu4JmCRD88NowVvb7Not9b51dma0DBABXZAHPBjvx4OV0hjT8cuEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827238; c=relaxed/simple;
	bh=OETh/t0TuaywTDU7ioRsqi5fw0soxg7OWwoPE2zMDuQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=frxRQu6Uu92M37YbV6WgRyFkr7PgHFxk8YqsY6WFyI4wlCERaoszcVjkhqNJE22WH6GmFoLKJFQgeDI4a/vq5+h1Lwka2iS2iGVRVxVQ7fYi0H9XQ8+ctExoWF0XSE3nVMZWnDXlNfDtU2xUFZ82OhRdxvpX7gLAUtPCP1ETEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TXDFYQ66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kn0Coouh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EBAE61383B18;
	Mon, 24 Mar 2025 10:40:34 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 10:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742827234;
	 x=1742913634; bh=n76Uj10bdEPtDvI3mHeDGPdivbBmYZRpkA5AZkl/TEg=; b=
	TXDFYQ66pGiemkLg+N3hVLyohz+9d+K45Q1eRTdvfkgO+rZDNmva/hGeG7jbCR9t
	h6fVyNu7MLfDa1oAAdoMTqAuX9nSyGjxbtX3K9/Qfi/DzcqE0A3aiOBpy4SvPCsu
	V4CL0TsnpGQBniyn8bss3zfMnHZ/CM6u5kcgpRgx48efo6u9npGwJEb4TyQR82Qf
	zrRzYO2ydN9+1R3hcPHPnI/blDwXDPTksUPiGZEa64bDmu+bED8k4UADMmFIMnjI
	D2TyEyC6jESUgnTE3vMxv41UlB5KoqdTRlfrw6+Uip9AZCVe6lIrKMU9xwln/V2G
	CGG0gXCBudPVHTTt4pWgiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742827234; x=
	1742913634; bh=n76Uj10bdEPtDvI3mHeDGPdivbBmYZRpkA5AZkl/TEg=; b=K
	n0Coouh6co6nnWuJMZEo5y1Ha2vMNqs3vbOZUWJswU90Hopfj3MG6rB6FnB2Vli7
	RRZsv8R0TdK713T0/WcXihtphM5LKKeIAw9Wnhe3rXW5OshdOT6HMSoinEFlJV3J
	RXl4QRjCf1k4i0pUEahU7mCpGnmbY1AhwkizG0mvPIw4F49X5V3M/6l3TsX8qFjZ
	Hv8UPukyzgBRnXuSfhwuGKn6oklz1SuYf8nfGIczO3OXo9c7A1k+fn7eVDno2Aj+
	Uav/zqIcpdOPc+KjeDMiNerZDw5Xvjozcla7KSOdFboJy2wu1HUBy6w83YFSiDwT
	8HOTCBWoguGOKQg1Nc8Kg==
X-ME-Sender: <xms:4G7hZ9opzXWYYMMLprNdNZhWR3VnkTXZ5cjbLNjAz-xGqD_KJy2Iew>
    <xme:4G7hZ_rJ4mSpPBo57ulAbHucCMzRBu1qWRrxposD98WEVrCffJOVspkHdvORW_UwU
    SdDQxL4fBBAp4EFuxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlph
    hhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghr
    ohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrih
    gurdgruhdprhgtphhtthhopehmrghtthhsthekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrse
    hgmhigrdguvgdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrh
    hshhhiphdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4G7hZ6Pz3qtnB2guwtcbIMy5BnBXoH5jmsWnq3qulB4EBStql0deXQ>
    <xmx:4G7hZ46a-bVZ0ZEb6b97EFB1c_OoktumAMPu0aFS8LZeRT_m9ZN2Zw>
    <xmx:4G7hZ84mTpfuxjXkjyc9KUpZL_eJTar_uNkNoB9HVp8_V6P9Z9vH1g>
    <xmx:4G7hZwg28o1A40L-m7WKyS3nxEgQr-4Uy9U6SqjG2z0lhXoYf2xJlQ>
    <xmx:4m7hZ3x_r4JGE8fZpLpxh3gan8DRthDVv3ooEN5rzbh5pW5q6SnxmMEt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC8B02220073; Mon, 24 Mar 2025 10:40:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T53f4a10e7512c522
Date: Mon, 24 Mar 2025 15:40:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Ungerer" <gerg@linux-m68k.org>, "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Julian Vetter" <julian@outer-limits.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <a41f1b20-a76c-43d8-8c36-f12744327a54@app.fastmail.com>
In-Reply-To: <9076d00e-c469-4a05-a686-94e3e55c8389@linux-m68k.org>
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-7-arnd@kernel.org>
 <64f226e5-7931-40ba-878a-a28688da82fd@linux-m68k.org>
 <4a31c6a8-7c99-4d8f-8248-92e0e52b8db6@app.fastmail.com>
 <9076d00e-c469-4a05-a686-94e3e55c8389@linux-m68k.org>
Subject: Re: [PATCH 6/6] m68k/nommu: stop using GENERIC_IOMAP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 24, 2025, at 14:50, Greg Ungerer wrote:
> On 24/3/25 18:02, Arnd Bergmann wrote:
>> On Mon, Mar 24, 2025, at 02:33, Greg Ungerer wrote:
>>> On 15/3/25 20:59, Arnd Bergmann wrote:
>> 
>> Does this fixup work for you?
>
> Yes, this looks good, works for me.
> Feel free to add this if you like:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Added now, thanks!

>> On a related note, I'm curious about how the MCF54xx chips are
>> used in practice, as I see that they are the only coldfire chips
>> with PCI and they all have an MMU. Are there actual users of these
>> chips that have PCI but choose not to use the MMU?
>
> No, I think everyone with these uses them with MMU enabled.
>
> It is probably more of an historical curiosity to use them with
> the MMU disabled. That supported pre-dated mainline kernels having
> full ColdFire MMU support by a good few years.

Ok, good to know. Given that there are no other chips that allow
PCI on !MMU kernels, I wonder if we should just make PCI itself
depend on MMU, and remove the "depends on MMU" for any PCI
drivers that currently have it.

There is no fundamental dependency here, but it is something that
breaks occasionally because of in-kernel interfaces that don't
work as expected on !MMU configurations, and with an extra
dependency we could stop fixing those.

      Arnd

