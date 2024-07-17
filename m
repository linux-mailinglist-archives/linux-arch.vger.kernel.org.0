Return-Path: <linux-arch+bounces-5456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8635933A03
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6A21C20A6D
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB113BBCE;
	Wed, 17 Jul 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="isyoZPSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuTu2zxP"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819193032A;
	Wed, 17 Jul 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208999; cv=none; b=VHzwP8m5Cqsz+covEh62l2sHQ0K/3MGP1H1YMv0jQ09zfgzxDBOAZRYsCq+aj49CtkfTOKk8IWqRlAGfYDyK1jm3AhKMqT3mtct//D/1gNhsLoovw3WlA7tYNEqGSTE3iE6cqe4K2XSW49OxuJ1rV/pGfLTgJ6eT8cov8lffxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208999; c=relaxed/simple;
	bh=xyjyfNGXdWpRnYLoYvaMCdzkbU3pFFxpX1W4+PfIUb0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ePcSSy9j79BVYdy45mwzVy5MiaIfVWc8BNC1QkuCaa65wsDrtmknIjMlALbhsHKDGCKB8CuGzi7skKAllkXSlLxIJPHgdmuOwqY/Y5QGp0hwCc0waKJd50wAnKC6wp3Oq9g4r70NdEKO6UPSaDcVCtPfmh2zmyQk76E9/ByFOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=isyoZPSE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuTu2zxP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 92EC41380327;
	Wed, 17 Jul 2024 05:36:36 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 05:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721208996; x=1721295396; bh=ds4aqM5Kli
	aeb4EM9aEvOVD2sDxY4nAQiMOn0gmaAbs=; b=isyoZPSErBU9/B/t1RVSo3tn7U
	Tc3YRkr7pgDPJni2+1kEPudKDRq9Z/DhmIm3IdRxv/xc5IbMqawD7hhI4RMUiZc8
	9mACyynTn6yuEc4yNx+Wwg3lJYaxoZOqG9slbIAn4AdR9gu4GwgCVOmY4N0FYFbE
	LQ7sr6n6dmOZ2a8Qp2MpuKR3NDWfVRo9Bmy3D329b6ex17kTCU8oKgUWjgmgk7mz
	qr3c8jdpENSTE7CybQub0T7N8kA3EiBe9qEczTmxUV9bcDNvAguh9t7vQpGd2rJz
	2g3g/Km2lgKDnj8MZetYS2/jbUNsV+KMueiMxxHXdFa+vj60MQw+gfhIIG6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721208996; x=1721295396; bh=ds4aqM5Kliaeb4EM9aEvOVD2sDxY
	4nAQiMOn0gmaAbs=; b=IuTu2zxPr6v2uLemejK0Ei3q2B4Q5qgGmSQzRk8i6DLv
	vTrmN2pXjRAB7TogFn4MgE1l/SlcRTGZFdNhMgX6RowdwUfgZyXdETR7l/oQx8Uz
	acXX3NohpJxvp7OEXzYW402k1xxPokR0RTJ7A3FxrsYAOigVoUPmiM74YMAM7jz6
	PUfcqVFTwhWWYY63PWHaGQUB6ReeN+MssZ8JEUodVtXKlnLS2Ky5GIoUkEKePm6W
	xRLMDKvrDQrp/Im3iLn/kL1I7ykewwGpFDWrRhFJKtH6gP0CoH/HcxfbEZvMCALB
	OeLTYztagTQn3c5EnEI0C4GHxk9qYKBz1JwxEuvoKg==
X-ME-Sender: <xms:o5CXZuhHJeo328Hjywk4ATXGO_xTowOvuBLqBMB9x7vDw3N3_h3p6A>
    <xme:o5CXZvApUPKK7-wHjTzWsNyRJQ2vxM4h4IV9UcTrUVvPT3l8JJUm7IS8o4dZENEDn
    YB1kug2ZKo964UxCck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:o5CXZmHTb_KO_B7rug2PaYI8JJcj3CGwU5Q-oWM_o3p-cfzt28dWmA>
    <xmx:o5CXZnSS1fFdG2a24qTS-iXIVfIn1WLz_T_hXOQBWB2dQPO-29ZlzQ>
    <xmx:o5CXZrxXt7Ba_vQnQnpzMzBBqhuM1FlyIaX28V6hNbIT4Gm9_2zDQw>
    <xmx:o5CXZl7fGWEov250RGBtfHL3SyIT_rpGUYjYUFhCMJk8j0lTbSPSMg>
    <xmx:pJCXZgpR0x6tJgWfugM-QILTlcTWV-om2c6810xHInv2PguUoHyykUCM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 301D919C005F; Wed, 17 Jul 2024 05:36:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d471a38-f86f-429d-a1a3-b882439ef7ba@app.fastmail.com>
In-Reply-To: <Zpd-Bx3VwrYWVeTs@hovoldconsulting.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
 <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>
 <ZpdnhhaQum_epcGp@hovoldconsulting.com>
 <be80d8f6-2a1b-4f63-a43e-652fa5328d11@app.fastmail.com>
 <Zpd-Bx3VwrYWVeTs@hovoldconsulting.com>
Date: Wed, 17 Jul 2024 11:36:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Johan Hovold" <johan@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

On Wed, Jul 17, 2024, at 10:17, Johan Hovold wrote:
> On Wed, Jul 17, 2024 at 10:01:10AM +0200, Arnd Bergmann wrote:
>
> Yeah, that's not something I noticed at least (and I assume I would
> have). And I only did aarch64 builds on a 6.9 x86_64 host (make 4.4.1).

Ok, I can reproduce the problem now: I installed a Fedora
VM guest and chroot mount and I see the same issue in there.

My normal Debian host has make 4.3, so I'll see if I can figure
if a specific change in make does it.

     Arnd

