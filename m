Return-Path: <linux-arch+bounces-13769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F06B9F2FC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637465603AC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F743009F6;
	Thu, 25 Sep 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="k7ZYVILd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boAEafgq"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB43009E8;
	Thu, 25 Sep 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802518; cv=none; b=DhPC2XnmzbBAdDHb2WNbW5kicoqrM7fxB/LyGsmHUMBqr1Idb9QrYdUZAfrU/tpxaK+i//ppgHoJaqXdOIiAkBUWfeDSche/lp+BCVEu4sLwNyPd08th9QnLELYqKzb8usIGwN2Rx/BJmYon6QtbPZLdLsSgmyJ+EBxy1n3GnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802518; c=relaxed/simple;
	bh=kXI2PAmGPAfmnMskribuV8ncqsscXU/4oEdNK46b2f8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jGNfWizigPsW6y6Fgp/6e/Pc78/EMkcN7zsV6bA/J0bGGaMCbZnUcXNpleSdRajTyA+EIuJvm8BtpUPir5m9s4BsMHa29Ek8sKoApOmu4ziSaHDMj9TU9zok3AXWxz3pmFbBoWSXwY5XGktxldhJFCi5xzzJDXoRHHcyN34BmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=k7ZYVILd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boAEafgq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D771140015D;
	Thu, 25 Sep 2025 08:15:13 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 08:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758802513;
	 x=1758888913; bh=Ai0hYxP2PHoEjzhHhI6JRyRV6fkyqh8ZPvnm+y+DYqY=; b=
	k7ZYVILdsJod+OM49xS7E+s3gGgZ1GA77sHlgC+10UnNRrToF8VAvHnGBIf0aTF1
	hGOJXu07+4t0IPxXE2yTk6e8ZrqSfFC2P0gTJDARJ6B/gVat7bVhnNmE62JgaOIb
	iEGZo6hSwrOrIG5VEDoBAemZsAvn0LypwmSTf7hmQaVaFUBekk12dXtZ0i9Dq63q
	pyTN1FqFzBcGNzvI1dlFzYuoA0kuu+xrnBtTVbRD/FXY2248HTVvnayAiEcgmjOw
	b9HIpAk0vXexXEX+K2R4j0RsPZltnOqaDgnVXeqy5XxPDhsgYXmam3iCm0wGZ76d
	2GYPepUFxAQhP9egZh/yMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758802513; x=
	1758888913; bh=Ai0hYxP2PHoEjzhHhI6JRyRV6fkyqh8ZPvnm+y+DYqY=; b=b
	oAEafgqKRMFLdIFQ7JWyjyZUq/hf0TVQ+50kU+GC8hO1eAvc6Tb8BE9J1lFwj78F
	xKYzW8uGrt0gj5G1SphzE1otiiiGTlAQk57cQlpdWm+RXaHR+WZ5hWCA3y16qXLk
	kfoky9B23tF0UG4KKyg67ra57AJybiiG4Db+5uQ8R2k1nsklU5Xapv+MToOLqa+A
	VY+ai4KNQ9R+AGUqcN8lVBGgLo+rw0aUR2teHjm92s37kJFoCQQzQ2HcyDeCXxzF
	S+XUJe9MJ2nK74B1+wdgXNllzAX58PlvGSN7U6Y1QZK0CdqlQLcVcEbqhW0nSX0x
	/6OQcUQX26UwErgiIYQAA==
X-ME-Sender: <xms:TjLVaDAqfPQJKSeB82080_w8myikU6CFtjJ87KgI6TS3kguuEjONJQ>
    <xme:TjLVaEXqkwbM-rTpVcf-PlfO-AxL5aAS6K07hQx8Q_N26yCiEHu_mA-qlA_--PLXS
    kVaUQQfpKTjyj9thvO967ZOVRArdXYqOwa86YgmE1GtuuVbag2tghc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtg
    hpthhtohepghhithesrghmugdrtghomhdprhgtphhtthhopehmrghnihhkrghnthgrrdhg
    uhhnthhuphgrlhhlihesrghmugdrtghomhdprhgtphhtthhopehmihgthhgrlhdrshhimh
    gvkhesrghmugdrtghomhdprhgtphhtthhopehrrgguhhgvhidrshhhhigrmhdrphgrnhgu
    vgihsegrmhgurdgtohhmpdhrtghpthhtohepshhhuhgshhhrrghjhihothhirdgurghtth
    grsegrmhgurdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhgohhuugesrghmugdr
    tghomhdprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghssegrnhgrlhhoghdrtghomh
    dprhgtphhtthhopegsihhllhihpghtshgrihesrghsphgvvgguthgvtghhrdgtohhm
X-ME-Proxy: <xmx:TjLVaMDX1NFaLybwHy91IpY30WTDOhrIX_osSHckubrvs--4eXazTA>
    <xmx:TjLVaBKca4pXGXUILZAhxdDpLLHl1zQz1ZIh0OvEE1mp4q1_0X-UAQ>
    <xmx:TjLVaPFNu3S6CyXqTrXDTyKe43Cd8UWZQFmQDIFJZ9Q4jDW7YgzSKA>
    <xmx:TjLVaEGpeIO1n9n-3qlOOT4Bme4vdCdsNJZWG9Yj-ydvgXL4cqZHOw>
    <xmx:UTLVaIvWpFoULt3HQvQOAm8etplCK4CTnVARH_LQbyAqz4iaznu49IfD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9CE98700069; Thu, 25 Sep 2025 08:15:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0nVfrWCY5as
Date: Thu, 25 Sep 2025 14:14:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>,
 "git (AMD-Xilinx)" <git@amd.com>, "Michal Simek" <michal.simek@amd.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Rob Herring" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
 "quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Jarkko Nikula" <jarkko.nikula@linux.intel.com>,
 "Jorge Marques" <jorge.marques@analog.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "Goud, Srinivas" <srinivas.goud@amd.com>,
 "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
 "manion05gk@gmail.com" <manion05gk@gmail.com>
Message-Id: <b2ce3e0b-a639-4e70-a5e7-ffbdc855153e@app.fastmail.com>
In-Reply-To: 
 <DM4PR12MB61090F307DBA2B99AFC93B168C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <295ee05e-3366-4846-9c8b-85ac09d79d48@app.fastmail.com>
 <DM4PR12MB61090F307DBA2B99AFC93B168C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo()
 and i3c_writel_fifo()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 25, 2025, at 11:26, Guntupalli, Manikanta wrote:

>> Can you explain how that works? What I see is that your
>> readsl_be()/writesl_be() functions do a byteswap on every four bytes, so the
>> bytestream that gets copied to/from the FIFO gets garbled, in particular the final
>> (unaligned) bytes of the kernel buffer end up in the higher bytes of the FIFO register
>> rather than the first bytes as they do on a big-endian kernel.
>>
>> Are both the big-endian and little-endian kernels in your tests on microblaze, using
>> the upstream version of asm/io.h? Is there a hardware byteswap between the CPU
>> local bus and the i3c controller? If there is one, is it set the same way for both
>> kernels?
>>
> To clarify, my testing was performed on the latest upstream kernel on a 
> ZCU102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian) with 
> big-endian FIFOs and no bus-level byteswap. For more details, please 
> refer to my reply in Re: [PATCH] [v2] i3c: fix big-endian FIFO 
> transfers.

Ok, thanks fro the clarification. I got confused by your description
mentioning big-endian in [PATCH V7 3/4] and assumed this would be on
a big-endian microblaze CPU, after I saw that the original i3c_readl_fifo()
had a bug in that configuration that your patch addressed and this
being a driver for a xilinx design. That fix just turned out unrelated
to what you were actually trying to do ;-)

> Please don't take this as negative or aggressive-my intention is purely 
> to learn and ensure it works correctly in all cases.

No worries, I should not have jumped to conclusions myself based
on what I saw in your implementation and assumed that fixing the
one bug would address your problem as well.

I do understand that your driver clearly needs a special case,
we just need to come to a conclusion what exactly the hardware
does and how to best deal with it. This is partly about whether
you may be able to use an external DMA engine such as
xlnx,zynqmp-dma-1.0 or xlnx,zynqmp-dpdma, and whether that would
need the same byteswap.

If you already plan to add that support, you likely need to
allocate a bounce buffer and byteswap the data in place
to have it copied in and out of the FIFO, and when you have
that, you can use the regular i3c_readl_fifo() unchanged.
If you are sure that the i3c controller is not going to be
used with DMA, or if the FIFO register as seen by the DMA
master does not require a byteswap, having a local helper
for the transfer is likely easier.

     Arnd

