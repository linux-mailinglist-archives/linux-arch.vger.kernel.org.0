Return-Path: <linux-arch+bounces-12363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA49ADE611
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AAA7A8179
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5422F4A;
	Wed, 18 Jun 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F5GYRF/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFcoWw+G"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7535963
	for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236599; cv=none; b=e/IcedlwcD0iY6XmMciwoF7ufCc1eZ6Tjoqt87fNcfB0dIX0sP2wDW5YKdqR42lx76qELeM8gddQOzPXv9mG+qfQ7sjrVUhqTAxXvlFKSqyZWAcAUrbAZnloaH1ISD5hSZVevo7Lo9VojU0+397ZgDjZyOS0+6/RMPjVNlTUyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236599; c=relaxed/simple;
	bh=cpsx6PBnuK68nX03ovH4FObKijZ3uFS5//vkPSzE6Rs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dl5QMqXhR1b7qw4Cv0rm/Eb51UO3QCsydKWJ8Ve6ybJAFcXwzxxqSRw/8gPgQ6I7zcPT8CDv1zwkBQJ7o+YNurI8Gz8+wq2UhvCyIuZ7cE/orM85cQGkYNkAa5UYBxQFT47vVaQNuUywA0JVyyoGmpE8Iwyu/hGWQuouktD91g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F5GYRF/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFcoWw+G; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD16025401C6;
	Wed, 18 Jun 2025 04:49:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 18 Jun 2025 04:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750236595;
	 x=1750322995; bh=c/IM5HPfBpYE8o6gWUlQN13QPCuht7vRz9oAz64Fjes=; b=
	F5GYRF/lMfhe3+fEzzNd6HTeJYw6k2GK1Lz3HZ0SNGtuLn9d7/dApeyZt2gixcFJ
	X+ir1kmWXqhyWm+bfXNiM555pB8OgueeacLxlOcrmxm0Dysvahz5UKd36WBIEc6R
	LiUcnARKiucjzaVQfRYU0izd56PfoDFYEpTnNF4LLiFfjihayaVLlaAIdBXkoP9D
	9IZzwRsxH1ASeIgffoZDVFuCcc7pY+c/GTf4T9+P7Nt7+CzoBaWotmXGSWjSmNzH
	wFd46w5qsTj7EU5N7NFjDNWNzevkjFwoTWUtgZJCnurYwe9tTG/pq+TiPlsv7Cl4
	Bm1c3SjVnsBWHLCa4yRcnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750236595; x=
	1750322995; bh=c/IM5HPfBpYE8o6gWUlQN13QPCuht7vRz9oAz64Fjes=; b=I
	FcoWw+Gl+jMcFL1cmeMYIKPK7Atoqo8Z6DSxcWriTLWBOpfXQaV/jwsDLpAjkq7n
	3Fe05Dhv1/e+M9OrdB4UEUqU73tCgsdSk0tC109AM9qZoBFGxPrdC5WCdtgM7y4M
	CA0hifpIW5tj1KH/SOFCnjPoKTid7mysgwL9Vnb4NhAkB+DXElN8vSLVS+X+6S2v
	FnEFsJUum0lIQoXYlO1A9Q+SvO1BZTslDzgkUc3J5JkY6vWon6uZFbyXuoG/smYn
	dFFfzfLP+kDFYzPNL2yIDQNEQFgVpPsSKSQalVwp5t8GWgERffEMUP9Hf0KQhtc5
	ahvqKxfcj99jfvbtIfnXQ==
X-ME-Sender: <xms:s31SaE8RVu0QKPunxeIA1qRh7K0K8KEXQf-RnPkPzB8tcykrhxUpfQ>
    <xme:s31SaMt0_B-Z1CDbSg839tb5wS-WO3y1ZB3dX7ePbXzFNhs_oA396OMD3YfkrR3lI
    aHotYX6vN55CkgSAtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepphgr
    uhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:s31SaKB08BuqQh-0yAm6VlSahlCAVhw00JbjAJBalVYIibQ2Geua5w>
    <xmx:s31SaEfUjHbmgLp6nLPGpLd7Q9Q7zeIauURYjmN_2tna2YHn9FDCLQ>
    <xmx:s31SaJPwZYB1lbmUzIxW-6aFRMZwrXidYt1Sis5aM3aqZl7nuRPiMg>
    <xmx:s31SaOkc9gO8FSGBdJYa2b62wnz1vqr3Bxdev71-hGPXAlrLj0VMUg>
    <xmx:s31SaKI2cXrpUL_vKrNxXwiaC_kgGEHRRJwRfGWsGoV2lbgP8JX7271_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19D48700062; Wed, 18 Jun 2025 04:49:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc0c613839c814f12
Date: Wed, 18 Jun 2025 10:49:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "Russell King" <linux@armlinux.org.uk>
Message-Id: <3b92adce-2fdb-4845-8cf1-a3378ca12217@app.fastmail.com>
In-Reply-To: <e8134255-806e-424a-bb86-68d3d6671536@paulmck-laptop>
References: <e8134255-806e-424a-bb86-68d3d6671536@paulmck-laptop>
Subject: Re: [Not urgent] Systems unable to do 16-bit stores?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 18, 2025, at 09:16, Paul E. McKenney wrote:
> Hello, Arnd,
>
> It has been about a year since the one-byte cmpxchg emulation hit
> mainline, so I figured that I should check up on two-byte cmpxchg
> emulation.  The issue that kicked it out of last year's patch series
> was that there were systems that run Linux that lack 16-bit stores.
>
> Not at all urgent, just figured I should ask.  ;-)

Hi Paul,

The RiscPC machine is still there, my plan was to remove that
and some other platforms around this time. I sent a series[1]
last December, but we never merged the patches.

I need to send a rebased version. 

      Arnd

[1] https://lore.kernel.org/all/20241204102904.1863796-1-arnd@kernel.org/

