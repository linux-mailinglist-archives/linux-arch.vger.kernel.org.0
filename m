Return-Path: <linux-arch+bounces-8623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A289B16CD
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 12:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090782823C2
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D91B21B1;
	Sat, 26 Oct 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KRjx2r59";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exHmHpaw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4C18C928;
	Sat, 26 Oct 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937076; cv=none; b=JYzI4qSMxb4xlR90rUd7jrxF4DJ3PGhyLmqX+SRpLRiT8+z1P8dgAmU10QPXHqln1KHsGq7bDZ4O7I6GghSKUSNUlMKDgPqEagE+s+YzqFfIVoRRIR7IR/tje+ebVO7pJWgmBEaqQJm/vilFa6HtBSLSFMSDMSLzbHf9ukRsntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937076; c=relaxed/simple;
	bh=27ovSQbzB/aC9QWZWwR8rDyb1ygtfsTAMf3eBgNh0n8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U1tM1OmF5jJQ4YfAq3Pqbb0niAXND2yVl6tQFJKCAW+CLQ231sDJeTu8gk3MD621VjZ5Ybg1b4p0qbpoHV1NYkswA4Gd/+wD34Orj/6TxE6nMitxyFx+gzbnwLchn2Tum+JVVLMV6gE23EZouwjGdAMYk4NL2aVqGHYLPnXgHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KRjx2r59; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exHmHpaw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 11C0313802A3;
	Sat, 26 Oct 2024 06:04:31 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 26 Oct 2024 06:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729937071;
	 x=1730023471; bh=+19wIwNYiPzxfxiueq3PQMyxFF3GEUtZ5cijthD56tU=; b=
	KRjx2r598ZWRhKNTI2QrdIM0XiXby5P3y3Ul3aLUC7Flb954TW5xZtrHii4EDmF6
	/ZrXepomA3LJQTOswpUfXbwBcJ6IRFBg62gr+ELz5czVAoiGZ06sK0qOG9+W7kBj
	VewXEHheSzPJ0rQyjvKDZAZ0A99I4u26cTNxXIW7G2ZDgJ0fPMY7P7E9JVf+5Hkn
	k3qC6fwf4fAdwSjzbVzOgZXAuiPxPOrElQQJ+PHoHGepEgijmvy638TPgy4rk2aB
	IXAAAisDHbk1uH+z7etiyPdufQ5KeJHKfza8ueElrPeNbWWJJUlE5FJrgDmosf9b
	wuL634mPk1bIc1aVqiSS/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729937071; x=
	1730023471; bh=+19wIwNYiPzxfxiueq3PQMyxFF3GEUtZ5cijthD56tU=; b=e
	xHmHpaw2iS3raR5dwWI2h2TYkmZ/jaXridaO8vFPNmnQyWS4dwAQObzFi3vagGVo
	+yPtZFo/ZcNnvN6Kisq3iH47+XOfw4b/iC9K1uYdRRpZgMkTo5y9TAtZ4/Y1XMd9
	uRLNGZa+BCzfBnJQOh31hLyI3szv9P7P6htDdjQqUF0HVpDWszB6ot9Xb+JD/Gos
	cmTdsIVgQXNdEi7wZNC4q0xo0RbqjB10JYL/GUiIsSwTBh4VXdM9dIeiKra2YjOq
	oQfxVczHTYk7fDn6BlQT3MM8ltcEUjThqUydCs/Aetqp3F0FTPUoKYPb/u/jNddF
	uGnhFttcq2aqTuJjn6M3g==
X-ME-Sender: <xms:rr4cZxgk0HbyuSnFT0LrI4UObTEhXfEr5LP4PvZFUGgobSFi6FrWZQ>
    <xme:rr4cZ2AKI_UQCoWsK0R6liks4xVIPQK2pJZu8x9cRtdJz-l0ms6_h-BTLYYpqjlbg
    6aqKODPP2_vOmmBoyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepnhhi
    tghosehflhhugihnihgtrdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rr4cZxEDHqNB5FvKbi2c4MWcE96EWKCXt3XBJjcF6rJ1u7y5rJzhNg>
    <xmx:rr4cZ2QAGEG-Y3at-fML7H06W_-Z2mJM9YnhKG4OpovMyqXGWdLC9w>
    <xmx:rr4cZ-zGBZjbbfw-0-6dRasDZUwS50mItUXucczF068mKHZJYDvtbg>
    <xmx:rr4cZ85WpHViIxgKWan-u9PMP3tcQwH7w2aDTUwaVbdMLMaOiq7_Dg>
    <xmx:r74cZy-Ih59L4WVJ7qIQ5_YTz8mrAIM5H5ie8v2g1zmcXy9o43UbZ_QB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F6E42220071; Sat, 26 Oct 2024 06:04:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Oct 2024 10:04:09 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolas Pitre" <nico@fluxnic.net>
Cc: "Russell King" <linux@armlinux.org.uk>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <5777a9f3-a56c-424f-8e02-6bc6af1af9e8@app.fastmail.com>
In-Reply-To: <463oq322-5p62-2293-q8pp-15p3507888pr@syhkavp.arg>
References: <20241003211829.2750436-1-nico@fluxnic.net>
 <75c272ce-b4dd-4360-9489-b9af33b87a33@app.fastmail.com>
 <463oq322-5p62-2293-q8pp-15p3507888pr@syhkavp.arg>
Subject: Re: [PATCH v4 0/4] simplify do_div() with constant divisor
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 26, 2024, at 00:36, Nicolas Pitre wrote:
> On Fri, 4 Oct 2024, Arnd Bergmann wrote:
>
>> On Thu, Oct 3, 2024, at 21:16, Nicolas Pitre wrote:
>> > While working on mul_u64_u64_div_u64() improvements I realized that there
>> > is a better way to perform a 64x64->128 bits multiplication with overflow
>> > handling.
>> >
>> > Change from v3:
>> >
>> > - Added timings to commit log of patch #4.
>> >
>> > Link to v3: 
>> > https://lore.kernel.org/lkml/20240708012749.2098373-2-nico@fluxnic.net/T/
>> 
>> Looks good to me. There are no other comments, I would apply this
>> in the asm-generic tree for 6.13.
>
> Hello Arnd, still no sign of those patches in the asm-generic tree nor 
> the linux-next tree.

Thanks for the reminder, I've applied it now.

     Arnd

