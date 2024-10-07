Return-Path: <linux-arch+bounces-7766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0F993006
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A49C1F23472
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52651DA10A;
	Mon,  7 Oct 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Up5FKcIp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6dMbAbu"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970D1DA0E1;
	Mon,  7 Oct 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312646; cv=none; b=QJonFNTaS/Ey5BNbGHtH4JS+pAa84sCtz+kjiqWI8qshmAqgzgLWp+SooDQnLEnJ7oGQSLT2wl8iAN9xdRwsSSIy+7SzYJU4khIBTP9Vpy0zpD3n40LB0Pgjc1FLDG1dMNTfSnjCjhwDGlC31hVSckzNq97QEfoPLVRbFkUr4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312646; c=relaxed/simple;
	bh=W2w7gTUvh0BGYfQhkvqmW52Vx3VUkPOS9FriqRELruk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n+1leI2jcD027owy6cbYbiK60fS8VdvtMOD9aUodCfFHhtQORquRnxvfC5Im2i3Oj2n8gvEp8HBrR6ujImiR07f8iG3NMYnaIhsri1hgXlaz+3ZslAPCkhrWCVvUGd8M/3RCdaGtvbwHgaJnTFsigmn+noIqDTjMBNuTdSk6Ruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Up5FKcIp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6dMbAbu; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 1C5DC20056E;
	Mon,  7 Oct 2024 10:50:44 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 10:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728312644;
	 x=1728319844; bh=etD4e8fREf9I10+o9SUXvRJ3oUE/2nTOuOsA3IfGV0I=; b=
	Up5FKcIpjBZ6k6OO9HvsIVrtn+oyytHREAsBXp6Oexcg+99JEzromzAQIH4UmAAA
	x9JqWwcMF/ICY//C+mZObEm3sG5NCGUp8cqnz1R7uDgsYhIEOSWD9vn/EXP4Wxim
	yqnKXJ5xAo2Ec7sa5GwvOHSV2sHeFN+AqlGlsOkXxl7UbnwZuxP9sqq8IJDKVVYc
	Ue5XPJzJKi1AGpKrW/s/2+4QjwXztRWGLl/qNHNof5iFl0I5gh8hyLclasmY/1PE
	GEtpoTHkWgoCfT7TFQL7pY61kIcXj6+AxYKQoxFU2GOMzEGM8VlBWXsfQYDUuC4Y
	QzV12/5hIMFxr/JH3iCRXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728312644; x=
	1728319844; bh=etD4e8fREf9I10+o9SUXvRJ3oUE/2nTOuOsA3IfGV0I=; b=J
	6dMbAbusojRSCSe9UnR6C3k8JdJVJevEoZHv/Lnz9PETzXw9HoWr3mXoxRc1sG8a
	GTcE9ngpub/XS2GinrGwG2qrIYjyfqC/nN+63f92KZe741WLbKYz2JolBW3M6/hd
	svpZ+DpWS0IuO6OyEgOdorM3AQQYtapQoJ08UkZpPEyTcRTFSCUSdfJV8a7YqQMQ
	/lI74RQZE94PPxyLoPPoUhLHMyBeW/9cCCHeneCCcBYyHFfdayAyauhQeR1NACk4
	f0xGDnDn0wVS4dFYj/3LOS/W/l1Gck/u5aCAFGa8OtI5MoYBlySDpNJdpgbjVKwY
	0x8tsx2J1tIeENv9gmgpg==
X-ME-Sender: <xms:Q_UDZ1Yizc8iqp72AWNwAlQIzhnZ-5ZRDnYyvEZPj62NU4VqkVW3JQ>
    <xme:Q_UDZ8b-bkrU1pb64mikfrQ4wH0WxPnYn3P--VK9KB4ujQ2RJtzvf_ovTUuV_1328
    YWUSmNC99yn6ViQCjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtg
    hhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehl
    uhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehprghtrhhikhdrrh
    drjhgrkhhosghsshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlhes
    hhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhutggrshdruggvmhgrrhgthhhise
    hinhhtvghlrdgtohhmpdhrtghpthhtoheprhhoughrihhgohdrvhhivhhisehinhhtvghl
    rdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q_UDZ3-2EPROruSgT8GW1PbVwSNM-dUV4TQEZQVPNTgpR7BkSYI-ug>
    <xmx:Q_UDZzo6C5Mu6AEw2E-QjoA96ZZX7yK2h0S8UeCN9XoWTHYFouXsjw>
    <xmx:Q_UDZwqr0-eTXOX_gSC1UArZNUyW35LA2rhkPo2ukZlYqtWmYtlThw>
    <xmx:Q_UDZ5Rr6brJB6oXR0tLZ_ghHteD7HYyIYrIcJ6iKg0KFiUJKLAIpg>
    <xmx:RPUDZyhlRtMuy3U--PRER_M7LuMc2pt9keUGA9G5u16wBEFfl7ppTrg->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 20D602220071; Mon,  7 Oct 2024 10:50:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 14:50:11 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Brian Cain" <bcain@quicinc.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Patrik Jakobsson" <patrik.r.jakobsson@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Dave Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-serial@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <c58ab639-f0de-4cea-b745-13e9cfe0e588@app.fastmail.com>
In-Reply-To: 
 <3wh4nsirm5kjapft47oe3gaqgzdjwlhzku5lrctb4hhfjxicv3@n2sow3o36chc>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
 <20241007-b4-has_ioport-v6-3-03f7240da6e5@linux.ibm.com>
 <3wh4nsirm5kjapft47oe3gaqgzdjwlhzku5lrctb4hhfjxicv3@n2sow3o36chc>
Subject: Re: [PATCH v6 3/5] drm: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 14:39, Lucas De Marchi wrote:
> as an example:
> $ git grep -lw outb -- drivers/gpu/drm/
> drivers/gpu/drm/gma500/cdv_device.c
> drivers/gpu/drm/i915/display/intel_vga.c
> drivers/gpu/drm/qxl/qxl_cmd.c
> drivers/gpu/drm/qxl/qxl_irq.c
> drivers/gpu/drm/tiny/bochs.c
> drivers/gpu/drm/tiny/cirrus.c
>
> you are adding the dependency on xe, but why are you keeping i915 out?
> What approach did you use to determine the dependency?

I did a lot of 'randconfig' build testing on earlier versions
(and this version) of the series, which eventually catches
all of them. The i915 driver depends on CONfIG_X86 since it
is only used in Intel PC chipsets that already rely on PIO.

The XE driver is also used for add-on cards, so the drivers
can be built on all architectures including those that do
not support PCI I/O space access. Adding the dependency on
i915 as well wouldn't be wrong, but is not required for
correctness.

I also sent a patch for vmwgfx, which can be used on arm64.
arm64 currently always sets HAS_IOPORT, so my patch is not
required as a dependency for [PATCH v6 5/5], but we eventually
want this so HAS_IOPORT can become optional on arm64.

      Arnd

