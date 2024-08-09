Return-Path: <linux-arch+bounces-6142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827194D780
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6FB20EA3
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B515F401;
	Fri,  9 Aug 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rp46QHR+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jp5zb9cG"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54784101E6;
	Fri,  9 Aug 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232542; cv=none; b=lhJKoB7VKPaxmiNimhkWkiQuplm73JVTK1vFJ5Gqgj2l3gZ0+X9oaI514UPyNk/PFLVzINF/u2G4Rmba48skOh5dEqHEWtjnn4YVA2/Cr2O2+Dl2/b7WIyj9EEYzlHifCMZ9mLiB0TLp6TCmNpUK43GH711eKfxCJ4LhB96ROTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232542; c=relaxed/simple;
	bh=tclaRpL2H/toCm7e347ieAc2LgjeBry9iVGCm1RK9yA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X6bEg6S4p+ZsvTR1g5cMO1EYtr9wt1JZ4SpK6ftMb++edIOMuLeU3uibh+HjqwM3cxxlBi64m1MCCQKTtUc8NJYUL+PSGzsTCYrp5TIdx1AXmFISVRKdFKYubBHOSTBwqPlhOgNBcR+3l1mhNoiFh9M63smAaHjDJyyN0jvaMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rp46QHR+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jp5zb9cG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5E3CD1388200;
	Fri,  9 Aug 2024 15:42:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 15:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723232539;
	 x=1723318939; bh=+jbITZ+KV7Pn3QxvU2tZAWF7/BSd4ZxIKMbe2jdtxbw=; b=
	rp46QHR+NS7tu0DvKopq43Y2KP6ZrkXmfdARB8avwh3qDkYO8AJExNO5KXzDrEc6
	JVzVAJoV7j86EN6RzqxgDzGBPjjvA4+2YekVYZGdzWdf9SHth81uIgq6U0jqQJcz
	CAEPYr0uBYsQ9+wD5JFMElXEn8lDuFE2VoOYoudbt0eUIszfSuMfocHEw3DiAXEA
	gQ4g5IvExQuDUnJfPIIsDW8zs7afMMbuTIYQb9k2SgMSfd4Dwtrla5YWh8s03gID
	kR5JC/mlIMB7Hf+hYhL8mE3mvXi/P+N42O6UpkK8Ri95gM4upAqFHma2i0Xogyzr
	pCGZhbQAKiD04aIAungeKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723232539; x=
	1723318939; bh=+jbITZ+KV7Pn3QxvU2tZAWF7/BSd4ZxIKMbe2jdtxbw=; b=j
	p5zb9cGC6fhszmL887QilwM2dpEm119NrOc6Y9qX9E/G4RLT5nIYSNrWGQyEWrRr
	jYhPvVQGm0CsyPp2FnqZOggFPEc8USWmJoW72lryl0bEJ9N3kO7rSr9FzWkHXYCC
	iFeAE9mOh1EJpWQnI/rc7C8V41qpprdl2mQ5SmL2l8GN1eiNH//J29mUjZgsNSoF
	uMWCDp94bPhLV2FHAJm99X6ZF2ozLrEhxK1HMpB/x6LykNkL+7MA2b9bGOYiBpeC
	Q1z57o9v5dEpIcJ1qZd1c2YF8mBL+ss7QID3y0ksEjZDSJ0U1joqzqQDg/TM7oAS
	wmd8eIzmon1WiEd1spaUA==
X-ME-Sender: <xms:G3G2ZqrSUk14jpj63l271Fbtv1xy6A6XHKRn7Kl2kNB86sJeWRR5iw>
    <xme:G3G2ZoqKNj6XlipcnLBgdIDsSffcjgmbs1TTXGf4pnSNYo4KDXxa1P1tZxCPz1558
    dsSEfLXik2kuH5jonA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrd
    hfrhgrnhhkvghnrdguvgdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G3G2ZvNQSdgYaiJfiGWLO_021SkZdI4ZXOflLWMNDILXDbT9tuhwNw>
    <xmx:G3G2Zp412ZR3cM1VQ6ZN0-XNTOmzgZ8SAj4idhBo-GmfW09Zbqrr1g>
    <xmx:G3G2Zp6MkzRC14SmhUBg4v1uEbOeTq66AbFDJ--PICShdgnhzyKb7w>
    <xmx:G3G2ZphvtxlGKuOANKGtlib6D4ng8ubCOtuMzQdTE-NeGr5cqogFkA>
    <xmx:G3G2Zms2IiiyHNlyrW8Lb9roaJn3dar-q96lVj7xHuv5DLhPHarsdFxS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 23EC8B6008D; Fri,  9 Aug 2024 15:42:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 21:41:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mips@vger.kernel.org
Message-Id: <70f908d0-7cca-40c3-9aaa-c838b02dc4c4@app.fastmail.com>
In-Reply-To: <20240809-mips-numa-v1-1-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
 <20240809-mips-numa-v1-1-568751803bf8@flygoat.com>
Subject: Re: [PATCH 1/7] arch_numa: Provide platform numa init hook
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 9, 2024, at 21:25, Jiaxun Yang wrote:
> For some pre-devicetree systems, NUMA information may come from
> platform specific way.
>
> Provide platform numa init hook to allow platform code kick in
> as last resort method to supply NUMA configuration.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Can you do this with a Kconfig symbol in the header instead
of a __weak symbol?

      Arnd

