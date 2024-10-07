Return-Path: <linux-arch+bounces-7753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C989929FB
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2861C225E8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44EC18BC28;
	Mon,  7 Oct 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PJno7Z3y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0CW2jiy"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297415D5C1;
	Mon,  7 Oct 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299233; cv=none; b=mg5MmERwmBDmjcPMmvmfHk+2LwQ1Mk5cijCbuDutAkudjgvjWYMPnfOBnEJDoyh/GAZ2DwRBW7PBVakjvWWVc3L5YWmvOr+hk79LFlF5sPGeuKKCkeDHtamWhzXQ0oL78oMWLP8FuLGqOTd8TcLyvv0hBwVWIHQ331akTyo1JaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299233; c=relaxed/simple;
	bh=AS2rWejTqgWwgGHKJdZPlVVbXELfLdISXsY49qCakVg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NozfHjI3d6FZG42RSv8pZQUvsnbFZSYdFZuzAYrPSjoM2O8fQpWIDgMFvD9BS5IIfA1BzK+E8NdnmlNQ4oJvP+YhSPXEOOssyemgs2Cwrj7Z4v5MOQrboXGlnz7wfnFDkRF1wl9Nb4PwTe1RjZ9y1DK+kiN4asOCLgcbZIdFIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PJno7Z3y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0CW2jiy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EA5F513802B9;
	Mon,  7 Oct 2024 07:07:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 07:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728299230;
	 x=1728385630; bh=ni3WIyeThbcVPqHPIH7k38Z//qYq+R+HBGbjR7fgWb0=; b=
	PJno7Z3y4c9x6rcLNdIJGTEeESilPp4NVk0zxvb40R9pBYEwS7cZ18uw9F04PHtd
	MbnE9X2Tj61oyajwmHXVyV7uMBMmYmES10SF82Krvv9yH5eI3chfn1KkB0PiyKqE
	g1RnuVgQCAodSaOYO0hqNP7X0MUIAlBzY5HHnETmgtFR5vnkamXXa6AQzQOWm43Z
	+amsps2sO63pMn6ZKbBLhHCLnAKGBif5q01HYVmbS3XYcU08CmrK89xJCufCgc5Y
	rGdq+RmUoVBLaj3mS0efxSMH8a0q0ZgrQi5avWU+90XAFLsvDnOimok5F9ajkdhf
	83JfeCLsREwqOy4wkbltCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728299230; x=
	1728385630; bh=ni3WIyeThbcVPqHPIH7k38Z//qYq+R+HBGbjR7fgWb0=; b=l
	0CW2jiyG9Nb5apqBr6QTLrvZApy7Fg2CNbZqWrAKeNQAOdrjC0aP7FOdeUZ4HfyT
	lD5b1QKcTZELxNoxj6PH+pvDQz6b5x4fmJyLXmr3MB1yxiFtJTV48ISfL1E6CxLN
	zFQd0bRvpMnNfsnWTvKFitQ9FASAjz7k222voJzJCnmuJVZijOTZ1cNmHsPWGAVL
	8cgDpiwBHv7IqVx3yeAw/mQjAeUrNLcTjsYU/j8eSsOyao7NBh4hU1tz4+9FJbxq
	Tn5JjhPxiq9pAevFWnbf9hIaMVSur+fbSQBf9RDLyGjwzI2UTmEAfkHK62Dfqipc
	/wtV1yY5HfK4jpfCLny8Q==
X-ME-Sender: <xms:3cADZ3JvJQ82KCTwczV3Spf4MNe8APw90EdIg_UldcgTJxhqd0bh2Q>
    <xme:3cADZ7L7HvbqXc79agm2pniqmpREtsLB5T8E96lC0th0oEi3gPlPEoU65xWdZPlg6
    czdLc8eLk8_iiwVWRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnph
    highhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3cADZ_tuy_yKfecMmWDLnM-MNJS5mpq_8tqEPugWJLYDfQcnjOXsfg>
    <xmx:3cADZwYvm6ZqCnmJEN4YsVt4LjTDpcotldd5XMVCGLMOi5ZItMhTEQ>
    <xmx:3cADZ-YtHia2ComIyHQ8tOl7P0YNMgego9OlI8cSM_lvppQcn9mdXg>
    <xmx:3cADZ0DLBJ2rdDF8KpMrlXPW8CL0S4YMQo2QWsP03_NgZQkMrX--tA>
    <xmx:3sADZ2O_1Bn7VrNf_6HihsweqDARBU6PwyT_cbRugRo00aWaolixcmZa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2FA272220071; Mon,  7 Oct 2024 07:07:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 11:06:47 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <140c4244-1bb2-404c-8372-1e68963eeea5@app.fastmail.com>
In-Reply-To: <850cdc2a-a336-4dab-bc7a-d9bcae3fb3cf@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
 <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com>
 <850cdc2a-a336-4dab-bc7a-d9bcae3fb3cf@arm.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 11:01, Vincenzo Frascino wrote:
> On 04/10/2024 14:13, Arnd Bergmann wrote:

>
> It seemed harmless from the tests I did. But adding an '&&
> defined(CONFIG_32BIT)' makes it logically correct. I will add a comment as well
> in the next version.

To clarify: this has to be "!defined(CONFIG_64BIT)", as most
32-bit architectures don't define the CONFIG_32BIT symbol
(but all 64-bit ones define CONFIG_64BIT).

    Arnd

