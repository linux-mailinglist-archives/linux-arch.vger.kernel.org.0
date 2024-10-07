Return-Path: <linux-arch+bounces-7779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677AC993475
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC731C23BE9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1691DC759;
	Mon,  7 Oct 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z6Giz9N6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpiOnFx0"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AE1DCB0D;
	Mon,  7 Oct 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320957; cv=none; b=D57dxCiB+YU34oW7Qu48vktpAfLR2kRFjvvrOAevSjP6cdS7YnXgxzAvdRZt2CnzskdrGHiDDzDRdHt96r7azORpv0zJAB7G9QISmUfkiPKZyNIyI6ickqm7ecPf5xNx5I7M7TOpkYThUw5+7dZoTnoSHUP1xxZlzKugDp8JgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320957; c=relaxed/simple;
	bh=BYbB9c8YeanuqzRffKnDJYAWr1Q3ltiaButtE86MKks=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uOTRxqSv6KoXdCvTonRz6JT2EqIBKW5dTJrONME+qsoQLMhV1y3oQm8uRxyIdbFth2qhpD+K1y0gI3+Y5Jl7fcfwSkGrEImJA3xef8ECA/p6OwX6XpuplHozltU4+3hUqDdc4OspjEYtMSRGczzcB6aYFxy5v+U36uUjpFP6opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z6Giz9N6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpiOnFx0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9657113801B6;
	Mon,  7 Oct 2024 13:09:13 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 13:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728320953;
	 x=1728407353; bh=0miWlT+FY4Q8TJOlD7Hd7TgBPUx/cjgFDZgOPGgtSx0=; b=
	Z6Giz9N6ENBvAgkuqqGnwdwE5tVjl7xabAuYqpU17Q8+uuAOc5RzWcfagVcf2Kox
	B6q6Q5ybrW4OFUC6ql6xxJ21jlL1jRgFm5jENIp5A+QrkKM2n333VWw9X8X+cVad
	7pMR2208tH6D1CGheD3kSo2UouSNcggG37CEgj+YS6O0FjTjL5i2SJsA5e5+GO78
	yY4l7ObVvIPJzacQrLJqggC3AlYr2VJoruT4sEjM+W8UAyDBqgeqtjyV4ktqG9c3
	4IlLiqttc0Yn7vfhMcTKG6aZ0+dhupgRJCIGdwK7ZDoVJ4WiMenrmHTrGDRFe0IO
	cwT6s4Kccwm8AnvomoBNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728320953; x=
	1728407353; bh=0miWlT+FY4Q8TJOlD7Hd7TgBPUx/cjgFDZgOPGgtSx0=; b=h
	piOnFx0CGCd85bnqsHI3noeRmNsoJzU4Ar+yT+CKPkJdzmqdQ4V+z/KhKHgQk5ut
	8p/XfTjgMII2x0Y9FctFMncNCYFeLbmAMSBi7ZajMGr9nLIihpgiXi+3DPV1/RX4
	2q1mHdEEJCz/uB+91jD5kjHdzqGcdswkKP/8SDEn5ar7PUgrpPFv2Hnz2uT77iJc
	JwxjEB6LGf5y/74ORaVCJgAs5ZyHqRlntHfwOUJIh5OxDkwayQ/a627MA/TVTDG/
	3WGPFkmc62pgxCzJfOZNYHrGAwfLj8+IvIVrMVizHYtnEEiBj+cwsaChncZNHOXA
	QCSTkxonaSkg3UyHItquQ==
X-ME-Sender: <xms:uRUEZ3H7Jz0IxGq3KaCkOYwkJsq2qpqkiTumhtZlfjNT47gR56MIIg>
    <xme:uRUEZ0WxDwh8-vAAGvs_bnp-ClWcksNw99Jq3NytV0bNEHfh-x_4rtAqrOWAW87fH
    T4Hc2l6wwMxRhBPPsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhlrghighhhthesrg
    gtuhhlrggsrdgtohhmpdhrtghpthhtohepmhgrrhhiuhhsrdgtrhhishhtvggrsehmihgt
    rhhotghhihhprdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uRUEZ5LQ7sDKW7tqFJqC9za7vv8mlxUlHv7OGQdf6c1tbgCdWa3How>
    <xmx:uRUEZ1FmjdwaFKaXTMk3IN8IVrZKyl6rwu43U-Akr6IpZuWvPqItiQ>
    <xmx:uRUEZ9UaEb-MaCYK7YFnPJ3_23ovXd0wVHOK6BQ_fO5If6igtfW3uw>
    <xmx:uRUEZwNnpqu4Ea2wHNHsgwLm1pcaSAv6VsbQbLGVf-C6lJghhIJf_g>
    <xmx:uRUEZwSKhSBi4owt9-l_u2egfYVJ0X3vL57r8V9UfMTzJRMgPtaJXJ_d>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 429AA2220071; Mon,  7 Oct 2024 13:09:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 17:08:52 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marius.Cristea" <Marius.Cristea@microchip.com>,
 "David Laight" <David.Laight@aculab.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <43cee6a3-ce29-402d-978e-a8251d08c522@app.fastmail.com>
In-Reply-To: <2f53046dd5b791845c2ffa783d7637ca94ca330c.camel@microchip.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
 <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
 <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
 <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
 <2f53046dd5b791845c2ffa783d7637ca94ca330c.camel@microchip.com>
Subject: Re: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 14:57, Marius.Cristea@microchip.com wrote:
> On Mon, 2024-10-07 at 14:44 +0000, Arnd Bergmann wrote:
>
> Most probably this request is quite specific to my driver and I'm not
> sure how often it will be used by somebody else.
>
> I'm using block read in order to get multiple registers at a time
> (around 76 bytes) and to increase the efficiency of the transfer over
> I2C. Being a block read there are different registers length involved
> from 16 up to 56 bits long and I need to unpack.

Ok, makes sense. In this case I would keep the exact implementation
you have but move it into your driver where I guess it started out.
If we ever get multiple drivers that need the same thing, we can
still consolidate the implementation.

       Arnd

