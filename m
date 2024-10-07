Return-Path: <linux-arch+bounces-7762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF45992D7A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711401C21F50
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DDF1D4604;
	Mon,  7 Oct 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YHDQhAmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JBkwBIcq"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDB1D4159;
	Mon,  7 Oct 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308041; cv=none; b=YudPmVal+kyBViQBUsEnjUa/z6oUY+u+dWg49QICz78gtoUT/4xbcVGA+YPoGankxcQGjDA1eg5irfcayRpZgD4SBfJC/iRffkPtSD2ZCKdMaEPusgb2PeCelhHCIGzvYu/a/sJhFk+LxnZ/V+pfxtidftppOCvBgQs30AiIHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308041; c=relaxed/simple;
	bh=5IT89C5Z4Q1RiqreCJfy/hqsNpJb/KeSkB1u9wGbwi8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bYZu2blJPmW3nxd1qm0Ez9hzmza+N6d1I0dsr/c0R8mVpg6Two1kA9VGfAejOx0wOsc9wEejjCWjGUJ2n9j/ZiFPS58Xs9sk+aGRzjpSUz+7TurDwj/bIxtJLfmpEVO9/SuLROkDU266l4eG5FZ2pviGirxVc35i//wtZG5IS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YHDQhAmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JBkwBIcq; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id A2F0020035A;
	Mon,  7 Oct 2024 09:33:57 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 09:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728308037;
	 x=1728315237; bh=K4c7rwEkHHs7JNOKsZBJCFJ86mbVpg4BE5CRtZ2UsCQ=; b=
	YHDQhAmzydIOpgSHcA3YX0bmb8syVBfcIexSwhZNHqVXfNqJQAAEONGAzq55GI7p
	11R3aiC6t3bTHYkuwCRHP8uQNKlivqk1VlRSfr+LyAupIOCTld72Lz2xRAgJwy6g
	v0+HxuUy4H9fd/3GFspxk+vtiE9AQq9lxb5uGrJkvyWX/MUlE08uRIoBEOjpNDMs
	kyxpKiDkTmbHYAz64QA+PdrQo9yknVgsa2R7VGm4F9vw5IW+l9kOLUsY2EHtz3D6
	Tc4gIZd/o5le3GeLm9o6eRM5eCP8T6vKwVthZBPzY6YCn2MsjHJHZdoHrjaKS6ho
	6oVxa7NzWaEavQiMc77pPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728308037; x=
	1728315237; bh=K4c7rwEkHHs7JNOKsZBJCFJ86mbVpg4BE5CRtZ2UsCQ=; b=J
	BkwBIcqSWTLRYBYgCse0kmNIG0FalO2AoyqyWQlelRAffPOG5VukkG0bhsa0xWqI
	TueRSYf0SzV/OStG+nWoxmGlyElfc09kw1Ereb93gkykZefc2vER0XdnyCrESkrQ
	5eFstOGTbfu5qY1mcHIhlatNVHAAXZVXkTRQ0ohc+0SJASdxpjLDwPopxB5/KM/6
	XFMcLd4FsccvlOg/10ruCm7YrzoKxvOTmu04G8jNJrOVr7xc4jFNxMCbd3AduiJx
	RjhyQWIChWToyQq1FcS8XkaoWAWuUf3yA4hMpXelWxZh99NibmdvviiCzP8ZgTRE
	m87OApOVJKR5y9V+mg9PQ==
X-ME-Sender: <xms:ROMDZ2uhzN6iUlqUhyXgRzGdbkYhwsnC4IkYuifqhiHCNMinKjElnQ>
    <xme:ROMDZ7f4wJbjZIYRpZ_zseQcOm9roVh8jslwmBLju73undd42jdBBXWys0eHSF6zR
    kUPGSMLcTbp2aAkuRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopedvledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlhhivggu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgrthhrihhkrdhrrdhjrghkohgsshhsohhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtph
    htthhopehluhgtrghsrdguvghmrghrtghhihesihhnthgvlhdrtghomhdprhgtphhtthho
    pehrohgurhhighhordhvihhvihesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhnug
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:ROMDZxyosoEJgK0h0mYtt9W4kbfEv2X46qXcZB-2HLhzVVD24kQ77Q>
    <xmx:ROMDZxMozkL7hpKXIZSPf__oKocXC8ZuETUVXgc7DgfmMw5DTwU2xg>
    <xmx:ROMDZ2_mj1FR00fok_BZPG6amC8ZVGoa9--w6heHTT5fRrNSay8ijQ>
    <xmx:ROMDZ5VzhzRK_RqqQ_UXW6Wg8vTthGqsypD5csOvJMsv8UElFxut3w>
    <xmx:ReMDZ4Ez-gpcLv6QqQ8ntic7pnvCNRVE7_8UAFdm54iPfSDSKMyerq4i>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A32892220072; Mon,  7 Oct 2024 09:33:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 13:33:36 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Brian Cain" <bcain@quicinc.com>, "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Patrik Jakobsson" <patrik.r.jakobsson@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Dave Airlie" <airlied@redhat.com>,
 "Gerd Hoffmann" <kraxel@redhat.com>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <724b9809-49b9-49a4-be4e-0c464c29a1f0@app.fastmail.com>
In-Reply-To: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
Subject: Re: [PATCH v6 0/5] treewide: Remove I/O port accessors for HAS_IOPORT=n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 11:40, Niklas Schnelle wrote:
> Hi All,
>
> This is a follow up in my long running effort of making inb()/outb() and
> similar I/O port accessors compile-time optional. After initially
> sending this as a treewide series with the latest revision at[0]
> we switched to per subsystem series. Now though as we're left with only
> 5 patches left I'm going back to a single series with Arnd planning
> to take this via the the asm-generic tree.
>
> This series may also be viewed for your convenience on my git.kernel.org
> tree[1] under the b4/has_ioport branch. As for compile-time vs runtime
> see Linus' reply to my first attempt[2].

This all looks good to me and I'd like to merge it all in the
asm-generic tree in the next few days, assuming nobody has any
further objections.

If something breaks, we can fix it with a patch on top.

I have a few more patches make it possible to build arm64 kernels
without CONFIG_HAS_IOPORT, but we don't need them as part of your
series and can merge them through driver trees independently.

     Arnd

