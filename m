Return-Path: <linux-arch+bounces-8543-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF89B0459
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EF61C2258A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5818E76C;
	Fri, 25 Oct 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pjD28qXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBPgG+xz"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859521218A;
	Fri, 25 Oct 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863706; cv=none; b=N5bKdTTJjmpBBNpKS4dj4vibSIcJ4ZpyYl+Hy01ugUQUUn9rtJz0WvVdtALXSsCSYkd+2UYVlZWC8D8EHWt3ld4aszPJX/wlYgF8CtMqmJh5GdBWeb/lIBcCto9JTeDRyGnXWxiO89li5JvgZkPH/8vumDRNVpDKdIOiFElW9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863706; c=relaxed/simple;
	bh=Wm3muLnceJyby21UvU1uoDEPNrI5UR+r2idw9Fs/ibI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XxKNJkEdWGa90UukURTzrvO0Bj6sYNBtMZRVaJF3izcztE2fmn9UBVD3qhwJvOeHXcESnXmdhl8JUtULlTDN9HUQaf8x5MUkjx7ftsHZ9HLJD+K2De1g2WejE+l7hVstDjNIarygOtesGIP4pn9t6kyO42IPNSz+IHUk85fzTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pjD28qXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBPgG+xz; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id EC6081D400AF;
	Fri, 25 Oct 2024 09:41:41 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 25 Oct 2024 09:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729863701;
	 x=1729870901; bh=gtfk2cbRSvuRRxrihIJOvS/KfF1nzk8xhMXUtPvsUnI=; b=
	pjD28qXyOpY/LIxXbSbERv3rie6/Izt8nvJXnVFFhB2PBxXkVUlWs06gqvKSF3J4
	naLVGH1RomAtn/gp9CuMI8EIoAlYiaARGr18Pppe828HCdbHX+IPCIo+Kq0a3kUD
	XUHerAmJ7z5Wfe8LdM7h/sEseQIvCeVk7Eqf4nNILcsdoN5A4YJze79/h+cR8DXF
	LN6Me7jKhh6hXhlD7+XjQiQX336Rzs9bWxJUxcL3CmRaBu6fIt4OFg9Rj0oof8Fy
	2Hd4UT/koWG2vrqcsgoXfZBX8PaHAI9MlyvDefw/q3pLVHq9wV4+fwWD8fnQFp9N
	EIl+GmX/SPA5dZSq1NSrAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729863701; x=
	1729870901; bh=gtfk2cbRSvuRRxrihIJOvS/KfF1nzk8xhMXUtPvsUnI=; b=S
	BPgG+xzhv1g2MYdU4AZF7hh9UMShquw74Z2eAmwVsl2zTSrUguBWZiYF2CNJbhVW
	imRzugNw5phZ8dbUbOS+2l11wuRzI4RK8JEfycORiMx1Wjd/N3zbClZF6IYdPoCv
	70H++0tO9R/xvoaocFnUU0dOeEm4xjxQ0t/TcRz44iQN/qES7ajUC+nSaImy5ZoI
	aDjcNYZMl/a1abMv/y2N8EExnl9YVgZJsTNWPEFJ7wzXRt8MvFsRozWE7M9siYN/
	NJ7RKs6+MpyHhXfHOwxuBt57qZyK11UzBWw5nK9tA8QFODDFPdrmJCmYaeInDdjq
	VOyF9a6tluJZZZ3s4Zn6A==
X-ME-Sender: <xms:FKAbZ3qJFUGpbpsUW9_fereCvIhEuKomff311XueYsVaFQRy9hSq5A>
    <xme:FKAbZxpBHeAYEXwZR4XB1HB-FDE_GiaX8VYvGhuwBQsZh3PYIkiRPI7I_ZaQPSHRe
    1oH-bPesLZArVAW_c4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgieejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:FKAbZ0NsSjwocGY-XDJ1P7KQXGP_qoc3vqROaN1LyW6uNN_DS-vB2A>
    <xmx:FKAbZ662m7W6ZMDHKtvgoeDpUmD9Vpl0KgD5uqQpI1MQxmzY8ecOjg>
    <xmx:FKAbZ27gGML-ufU0a_1Y8OiNjEgKf5iqUggzFXgiBV1uP9QZr-BUkQ>
    <xmx:FKAbZyj_iMh9pE2a6JJFbCNnnMpSyGii9q8Iu8GGvaTegKT49w4jBA>
    <xmx:FaAbZ5wrMkfCwMUJK-_yw-HtdhtVOFf66SdycleW6ivOtc1nCpOXItmP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B8BF82220071; Fri, 25 Oct 2024 09:41:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 13:41:10 +0000
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
Message-Id: <72b75acf-743d-4fe7-9246-aa5a4efabb58@app.fastmail.com>
In-Reply-To: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
References: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
Subject: Re: [PATCH v9 0/5] treewide: Remove I/O port accessors for HAS_IOPORT=n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 24, 2024, at 17:54, Niklas Schnelle wrote:
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

Hi Niklas,

Thanks for your endless work on this. I have now pulled it into
the asm-generic tree as I want to ensure we get enough time to
test this as part of linux-next before the merge window.

If minor issues still come up, I would try to fix those as
add-on patches to avoid rebasing my tree.

I also expect that we will continue with add-on patches in
the future, in particular I hope to make HAS_IOPORT optional
on arm, arm64 and powerpc, and only enabled for
configurations that actually want it.

     Arnd

