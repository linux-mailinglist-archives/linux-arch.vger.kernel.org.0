Return-Path: <linux-arch+bounces-7833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55F994A2B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D531C24B8D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049221DED64;
	Tue,  8 Oct 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sP5CoCMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUrYXwy1"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFE1DD552;
	Tue,  8 Oct 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390599; cv=none; b=BlSyheYR4o3ub8wyjB6VxJrxv+va7Jl7/u/BQ0nLbGdlWfVcNoD7b9tP6kp4eF94N3KmQitUagK7ovfjus6QuhYJ/s8NB+02KlZOI8prgiiBoXS9oeJhOy3MMR39g22ttXGc5iwvfc+Cup+wfG1TDree5Mas/hLyK7AqqfDSXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390599; c=relaxed/simple;
	bh=SwiKyk1qXPVibzNAdevq0KXsDs6bwkBWLmS/QmHNEeU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O9sZBlVDvQyyVFlmtIxUhAnRVwoc//I41DooAnCqgYx6akJA7W0fkyf0jiUXUtWrlMb2i5XAy7qY/MwDVbVqxqxSeWP56Sa+pIFy+O3+brb6WCNSHguDqQe//xYwj6KvuYx/w/Tcdwzinbtz0wL+vZLWYy0IXPHitB2yhb3gkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sP5CoCMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUrYXwy1; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 3443C2006F4;
	Tue,  8 Oct 2024 08:29:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728390596;
	 x=1728397796; bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=
	sP5CoCMsvWtNg92ykp0ui/Ue3nHw3oTNECqS2IzrNwt4GIFIv46ErsPMVU60J3Lu
	ddjCzsPXinEkY342h4vUYYG6H430MbR8qbJIJLymtNK/kulDuSBqVMPA+Fe3Uysq
	J0wTpvL0pM/tGj43qO8NxS/yK+UPWz9rH7yq7UCCatZYhqtnXIxJpBHY1klSBt8P
	moR3Kg8daYHw1IxfJXNw/o+tFc/45rkbq071DwQz6OvaaZUhjHJ3pH3DDomH+aFp
	qfAHyGcT47cxz9/FWB5i39qPIxLv3IvE2SZa0eJCYz2ZaS7a76zc13VKEi8jx9zB
	dzRgrBBoG9ybsWIuqi/fPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728390596; x=
	1728397796; bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=d
	UrYXwy1mGCaJxx8eNdVrRYylV15yjyqyPiXWJGQmD5t6JaMa3ZkBzsvHoUxahe9p
	xXBwOSmVP9TA8Z6nMsj2mTIJsOSKKTGRFnRvAU90kgHaTg9JyfD56rhdiwCFOhf/
	buWc6cxz74kFCmsPSIu2gxefNTm/euHmH4XUVPDDzAzkG7dCAMctG2n2hMwuxHAH
	BDdoMDI5BQhtOZkumlVGHyd9lXc1ILcKkXH2GUNFCjB6zG/wRdN+kRzMtyNp7z+w
	1D1kkuYoNpDCE6oybck8EfdSCXxITtIaQ1nA/I+TF1HodWOYtC2h76Nyeyy57XyY
	xPXJA2L6tn4kwoV1/+x1w==
X-ME-Sender: <xms:wCUFZ-iJGwvzPE8nix2a16h8A0_vo8cISUscsF4O6JEnEffbmvmyXg>
    <xme:wCUFZ_BDdhL9_G1zbpqk3xOVURIT3K8CJ2iMVRamFnZ8WfRCOQ8hxy167-oqfHgir
    CKwhoc8utZ3SCm6H3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhg
    rdhukhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtoh
    hmpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgughgvghhrvgih
    shdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhroh
    huphdrvghupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghp
    thhtohepmhgrthhtshhtkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhpihhggh
    hinhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghllhgvrhesghhmgidruggv
X-ME-Proxy: <xmx:wCUFZ2HlBNZwY4mnSHZdZzNxbehNHwgnB8hhonJDgBbKx7vaVDsgcw>
    <xmx:wCUFZ3Q8el7Z6qda2BHCthGLfbb8Ds2qtqLa_KfBmYIKmAg9lJJooQ>
    <xmx:wCUFZ7y5j5vRnz5oY_e5dafS_A-mhgmr-1-4cOE22nlDwH6iZgDIxQ>
    <xmx:wCUFZ16ZRx-hWNNhZ4rr0wnQvf9zcQoVo1SURaXHKlp5EwELdbn_tw>
    <xmx:xCUFZ0CHdFwvQjJDwttyR4lvWRMhmyKj7_bs2R_T_Z0KS-c7GPljodcN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4FC22220071; Tue,  8 Oct 2024 08:29:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 12:29:32 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Julian Vetter" <jvetter@kalrayinc.com>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-sound@vger.kernel.org, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <b54a6f76-fcfd-40bd-b478-ca0a7e1af128@app.fastmail.com>
In-Reply-To: <ZwUbsviaqFUtjKEQ@infradead.org>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
 <20241008075023.3052370-2-jvetter@kalrayinc.com>
 <ZwUbsviaqFUtjKEQ@infradead.org>
Subject: Re: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024, at 11:46, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 09:50:09AM +0200, Julian Vetter wrote:
>>  lib/iomap_copy.c         | 127 +++++++++++++++++++++++++++++++++++++++
>
> On top of the previous comments:  this really should be iomem_copy.c
> instead.

Right, I suggested adding it to the existing file since the
functions are logically related, but the naming of that file
identifiers in it is unfortunate:

__iowrite32_copy/__iowrite64_copy/__ioread32_copy sound like
they are meant to work on both IORESOURCE_MEM and IORESOURCE_IO
mappings the same way that iowrite64/ioread64/ioread32 do,
but actually using them on x86 port I/O (from pci_iomap or
ioport_map) would lead to a NULL pointer dereference.

      Arnd

