Return-Path: <linux-arch+bounces-8591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B609B13D7
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 02:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EB4282F96
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AC6FD5;
	Sat, 26 Oct 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="S2h892Hl";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GPEHgqkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ia265a+C"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E35333F6;
	Sat, 26 Oct 2024 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729902989; cv=none; b=sINDdOK3y0rUmusfMbhjXpDDxnu6sipzZBiMoCzBDtO9FD5UQtJyxHQ/acZnucyIcqHUh9WR5uz02ORtEYEcsUb57Lj1KdM6ngymvmpCSpR1v7zMcV8xRRjL0BH0RGJsz7t+8eJNVqX23D2kK8J6mY9031QQ9GWcjjsLEVOeoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729902989; c=relaxed/simple;
	bh=IjehEx/7XD1lz+wkASw6x5CpAXR/vnv5UunqnHkN29c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OaLSbK0R3WhcYeKxivx/7JISV3U7st5Z2MECy7NHzraNeJXZfOvHjEdQaCjBG8EukZTMoTtFX7b0ex3gh+khRlAFarFhjhG+A1yDhIZAwWD5o9sMusd0hCWJXlTjO6Ulo+PXOxB/rHo2ltxlIEImprQs86fEgvO6BJgjuAc/voA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=S2h892Hl; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GPEHgqkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ia265a+C; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EE691140177;
	Fri, 25 Oct 2024 20:36:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 25 Oct 2024 20:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=2016-12.pbsmtp; t=1729902985; x=1729989385;
	 bh=Rji4eBwRGb5PGBFB6Pd2LGXmg85l7Io7gAQYQ3u6ots=; b=S2h892Hl+nzb
	CHOHg4ZA3INJjOVYdFKLEZYtkmRANr30bfeb/cN3bIoIvtsZJX+bvrTxKf+qdMXh
	5bTGU+EO4f3sNBJCSIotrMOnZgpdK6M/gh7CPGcR3RdoQx1jgQiFFlcuRINTpjZa
	/JW9FCxyPLCqjK2+dMVsBxvvZdSv4Ps=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729902985; x=1729989385; bh=Rji4eBwRGb
	5PGBFB6Pd2LGXmg85l7Io7gAQYQ3u6ots=; b=GPEHgqkkG+wl09AtknO1DW7KqG
	GFKNkZ7QAP/ztlM2tcsusr+Vw67pAtIF8vSQUDvKuc8PxtaBB9TqY8LLMuCi/mWN
	mu6cM0/J6voPtMvrmvrM8rMD6wu7BW2vhO8ZCpd5t+fg31pejCk4ffp7aacuz8LA
	VdOaQkZgu4hCKG1ojxkuJFnIKO85lF6un0YAsFzuxLINmPBSrmSIJKfhvy5qbaSL
	OK1dGYlhFOrr9RWiF3R2Pe5O6oFMzqB4XE+IqGk2vZxDijyFVN5JFANf5aHBnzJi
	wMD97L1B8TcXkXVeOUDagnhO1H50ahDI8C+4z1tL4146OnSAwv1TC3W5vBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729902985; x=1729989385; bh=Rji4eBwRGb5PGBFB6Pd2LGXmg85l
	7Io7gAQYQ3u6ots=; b=Ia265a+CsDYPqAn/VA/b7neeEkDXIRoKvQIhmypS25mU
	PLsCZGrMnmWdziuIHu/N6oeSbs8Bds5bHeEQslgKb71S3c7L4dGDJXXzXUKf4Cgd
	mLNSG2fKg2f/ptPujL7jts2hdkPhTH8EV3vv8rpa9jmRpjltZMNU/0FhF765QV8l
	g4b7q2L2ssihU3lOo5ZGsL3ENN6EYFqvefne+/Nwk2YhLef576xsZouWjifBs2u3
	ujBvtRdpc9AqTtkjKs9FSR4f639w7Xf1UUYVNCqJ3xxnRFg1K2XCLFovfaWa4QjX
	MNdKPYOqcq6dV9x0UwMvPrJ+yLE+fqrAYfxPr/J3/Q==
X-ME-Sender: <xms:iDkcZ66Gfr-xqtbtNj96tK7VYxX2f898vgmnhKRXJZ-qJGq2ltGhgg>
    <xme:iDkcZz7IPYoGyZbLcTu0n3zWqre3fTht1wc2x1xhZjNzTbvTc8f--DkvBxdMfQpCr
    LNXBNgDn8HRFeOaup4>
X-ME-Received: <xmr:iDkcZ5dOvrI7NkZBsv6RMxYQqHn1GIzbvNHoNN-OWMmlO81bLOi0IegTVmV63kQzgdPWKu61jCWLvLoaWRwCSmCOodrgDREz9KqP7AD8bRMvq-egdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejfedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekveelgeetveekleegkeelffevleefledvleejudfg
    kefgheffffeifeelfffgtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohep
    rghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iDkcZ3KMur9vQoJjV-tmhw2zdzWhzJf9YPma5l-LlJbvBV5Hnco2xQ>
    <xmx:iDkcZ-L8980kUbd30C7sQZN2j2LI9gsRq02NXf-f9rdVu_eH0CiOrA>
    <xmx:iDkcZ4xUCB1efWhVK5fCnR2yhZI3ahQU4RfRobwLumMjglZ7zjgicQ>
    <xmx:iDkcZyJZL6TM-hgEZgihkHRhpiqaUE5Z1KYp8GOZT873zxRvvGMeFQ>
    <xmx:iTkcZwjzWOfkNcy8WaG8VqJU_cvEUeXFvIupFBBXD3_dxhNTmpDq4FCw>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 20:36:24 -0400 (EDT)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DFCC1E8D016;
	Fri, 25 Oct 2024 20:36:23 -0400 (EDT)
Date: Fri, 25 Oct 2024 20:36:23 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: Russell King <linux@armlinux.org.uk>, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] simplify do_div() with constant divisor
In-Reply-To: <75c272ce-b4dd-4360-9489-b9af33b87a33@app.fastmail.com>
Message-ID: <463oq322-5p62-2293-q8pp-15p3507888pr@syhkavp.arg>
References: <20241003211829.2750436-1-nico@fluxnic.net> <75c272ce-b4dd-4360-9489-b9af33b87a33@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Arnd Bergmann wrote:

> On Thu, Oct 3, 2024, at 21:16, Nicolas Pitre wrote:
> > While working on mul_u64_u64_div_u64() improvements I realized that there
> > is a better way to perform a 64x64->128 bits multiplication with overflow
> > handling.
> >
> > Change from v3:
> >
> > - Added timings to commit log of patch #4.
> >
> > Link to v3: 
> > https://lore.kernel.org/lkml/20240708012749.2098373-2-nico@fluxnic.net/T/
> 
> Looks good to me. There are no other comments, I would apply this
> in the asm-generic tree for 6.13.

Hello Arnd, still no sign of those patches in the asm-generic tree nor 
the linux-next tree.


Nicolas

