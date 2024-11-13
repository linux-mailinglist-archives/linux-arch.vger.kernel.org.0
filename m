Return-Path: <linux-arch+bounces-9061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24D9C6F3F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7572B22D2F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583D1DEFF4;
	Wed, 13 Nov 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GUSuTEqD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="io+D/WvT"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211354C81;
	Wed, 13 Nov 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501336; cv=none; b=KCZZKLxuEj++gd1C6hfW94NkvjJVmvt/wrhFX+eYzcUgSlhCAtpGneZwvCYYiVA682yUCOrOlYTU6SRY3MojErahTNk1ZSWnAw3gTFNQ6l3/Hnv7RzgcJAXPX6ZkkSOhd51WT2ADS+ZuiApyZgFx+n4aE/gpQoJndld4VWh6JpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501336; c=relaxed/simple;
	bh=8mOXWjNAQeHQEuspChDGux1yTH5M5sBCW9lyH1jWrrE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R+JnCg9XEPVTw+5LCWbUPwNcLxhE27fEvh4A7AiB18kzL0ANw5zriA7hnb6dcomUmjUNy9/PpW9sKfeZ2oyfrntzcJxQkyMup2a0GMcI4xP3NN2jdHLNnsAM3GuHt/RUgFrmwdu5wN9gXjHgntwKsznMlHvOXWwSu8bqjgKkwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GUSuTEqD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=io+D/WvT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 01B4C114016F;
	Wed, 13 Nov 2024 07:35:31 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 07:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731501331;
	 x=1731587731; bh=7yQcPD6JKWI/AejdrgqAP/w+PsVFxDeTyBvHlplIogQ=; b=
	GUSuTEqDi+mYAIPY+kGshJR7f7xQK54SEbz9tFeD/9UdAge5heTetCpzzmEAV4o9
	ZzJg+jJt+nFU5c3lKVAOoIICjh+mS5ZdqjEVfNxkRyroZehLMrtAKR5uKXm07lYA
	jzdvt47epDi7hEz4Tp5sK4fl01k53mkNrDgPBTnrZcswsX/r5kpIas+0yBvWWldj
	mgWjU26E1ekEeJK7TpXv9BzrOit5P6sKJQe4n+f8xsYeAQfZYVjfsfYJQwgdwdct
	8P0BX9y/6B0rQTyMQI2tVODc7suV3eD++uQeUyeiFS2LpRnrBr0NiBQGPRz4WpfX
	O2JSIskkIZKV9CUO2LYosg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731501331; x=
	1731587731; bh=7yQcPD6JKWI/AejdrgqAP/w+PsVFxDeTyBvHlplIogQ=; b=i
	o+D/WvTHpAkM/VHWYwkuGKd7CqpAvpJ28TRsgj1qFFwQvflADdEUXkZzKbJDcSpZ
	f3EZ3CFCEAym2y+Q2PEGqyK2FLGK/nmVkKTySENWJ2esu3fI9TyBeJTn1pPVke4h
	odaBqNGCDPRHiQ0uu/RQoiaAsX3daEQ54cwtJsw+Via1AK56TmTSW6MH3QwB1rej
	TmnxhmPBIg9zgFNI1J14Mnh31eND3VtWjaVIERh9cN+YY5p5/lv7jghpgqFVkXFB
	KW2/QezENoq1XXpnK6tqIuUmFUgql9W12mzI7qn61erGR0GsmtoWieXazGIaStYC
	a/HhHY00jSu92EeZyX+og==
X-ME-Sender: <xms:E500Z4n1UrBCWK1iX-Sk_5o2ZkkTi_n0WtOdkgYnkxCjrBQJmLeJ3A>
    <xme:E500Z329LQzPQkqIm-naFOkRXDY0gjnyuOLJd8Plxx2WVY3jmPuynqEMxmx1TYhfW
    qommCDdU-mTxcm1LVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrgh
    dprhgtphhtthhopehjohhnrdhgrhhimhhmsegrmhgurdgtohhmpdhrtghpthhtohepshgr
    nhhtohhshhdrshhhuhhklhgrsegrmhgurdgtohhmpdhrtghpthhtohepshhurhgrvhgvvg
    drshhuthhhihhkuhhlphgrnhhithesrghmugdrtghomhdprhgtphhtthhopehvrghsrghn
    thdrhhgvghguvgesrghmugdrtghomhdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhi
    esrghrmhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhhumhgrrhgrnhgrnhgusehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hprghnughohhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:E500Z2pUVFQeoBEq1DbiNr21iH6tAyhWwMFPWNeGyAftzeViTM2meg>
    <xmx:E500Z0mZWq7QFt_LFv4UWt_Otf5N9NKj_DiDx0WLMr68yu26hk8IIg>
    <xmx:E500Z22e2nv9JopT-9FA8pbJYQlp-v_acmDkTl_usY6nQTl6hw6QAQ>
    <xmx:E500Z7v-zTnF4uGjBOjzrQ5ZdhDeKH9WKnYsoFXN8Uxe3QUg3lHlqA>
    <xmx:E500Z51synjgB7CPleMo3dzeaHEk3gSPGsAzAsXmPrK2YK1B4UzftYEp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C11B2220071; Wed, 13 Nov 2024 07:35:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 13:35:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: "Joerg Roedel" <joro@8bytes.org>, "Robin Murphy" <robin.murphy@arm.com>,
 vasant.hegde@amd.com, "Uros Bizjak" <ubizjak@gmail.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Kevin Tian" <kevin.tian@intel.com>, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Message-Id: <558bf28e-6cf8-436d-b2ef-382ff421bb00@app.fastmail.com>
In-Reply-To: <20241113120327.5239-3-suravee.suthikulpanit@amd.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-3-suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v10 02/10] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is
 not supported
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> According to the AMD IOMMU spec, IOMMU hardware reads the entire DTE
> in a single 256-bit transaction. It is recommended to update DTE using
> 128-bit operation followed by an INVALIDATE_DEVTAB_ENTYRY command when
> the IV=1b or V=1b before the change.
>
> According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
> to family 10h Processor [1], which is the first introduction of AMD IOMMU,
> AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
> Therefore, it is safe to assume cmpxchg128 is available with all AMD
> processor w/ IOMMU.

Makes sense. More specifically, I'm fairly sure the only x86-64
CPUs without cmpxchg16b are very early NetBurst Xeons, while AMD
had the instruction from the start, and dropping the runtime check
entirely would work just as well.

      Arnd

