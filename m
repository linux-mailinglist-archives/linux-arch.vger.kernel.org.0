Return-Path: <linux-arch+bounces-7695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9E990444
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9641C2130B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F337217916;
	Fri,  4 Oct 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PpkGJL3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Drtxg1i/"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6B217907;
	Fri,  4 Oct 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048334; cv=none; b=MGhuiriDuUln6Te+vNOk/oXVfLpGutvYF5sD9hZ5Nw6lXi2baP7nRIeNmnAfrri2DhFQbM0z7soXcusmO00c72ofoAa3j8MnnQrIHIShYpAzZqBTjEkhZT8MB6u43Npt2bzQsi71p/C29qX6JRG53NVxJXmZnH2liblo0uXuSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048334; c=relaxed/simple;
	bh=7ClJ3sAN7SIcD7DktMGV2qyfk2KhaTbquYwInl+3V7s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VA0piUGV8IGrcTRnHql9mlb2mP7krWSdq+VcDooSHFVGyFL0r1WTt0FhHz68DXfUNpO5go0+WGuloFL2+CKd31bO7lSSi9jePQ+JCm4xIIV7K1R2jReDGAaFcveraKyJNcTof7wk06XOLetuAKBqtFN/8YMcYiEbq8XbakGw1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PpkGJL3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Drtxg1i/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C501114017E;
	Fri,  4 Oct 2024 09:25:32 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 04 Oct 2024 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728048332;
	 x=1728134732; bh=cc9La4QN0dfEV0HU2X84WhVbfANEZU3wSpI2fa6yTmQ=; b=
	PpkGJL3CidFRPjlvZwqHd7zdsoiQl4sEGdtOAYkyZ0R9SbbGH+eVah+JsY9HiU0U
	OklNJkvBxVCwph+0pYC0w9iuK/LCUOkZK4I9OCeeubQis0m+cmKoMsUgIKWpE2f5
	C4H9pQjOxhJWwHKe2xiMh8GYZmvB4ck4SFW6IQtpbyLORaawQBxYV5hFFwofLrb/
	ocqhfoAh9dxxWYhB1CqGzUmEjuoTEQakRiBqDTeV5bUcaeS2EMidVK4xEvf5wm+A
	an00sO+8vLMrxi2CpElSqAfXsNRbYwEdyneLe9lULl/aPtjS1HiFyzE+rebxcNMz
	/sp2u3jjwsmFrEKJkr51bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728048332; x=
	1728134732; bh=cc9La4QN0dfEV0HU2X84WhVbfANEZU3wSpI2fa6yTmQ=; b=D
	rtxg1i/tASW+l3oYRbh/8ueRvssV6lhZxGdPd3rXUHvBDUf/Ai+PM5j7V9u7CgFU
	f9atrwZlKqn39ry0T7qy3V+baJxGTQKk/jduvfv8EgPZa7hDGIK3zdBikgo16uRS
	IwTr40n+P6Bes25gvG+iE9b/oy6/cpZW3DXlnb0N5s8YOskGk4E1o+KN8FrWsQwE
	ETOVR3/ppR7aF4fALq68YS7OZRAY4rTdKSN6c7YxursoNeLPXJ86OtFPIVTphALB
	9bGuSYT3Gzp/spKZWIBajDqQfsWDFUk//n2c2GnjG4tYxWWEj5hnRvydgNhNbI49
	9uE3NxH7kWlZDtuUc7GWw==
X-ME-Sender: <xms:y-z_ZknBC-5FtoE0YNff0pUkjzbq3xI67nwmWtZCnZonM0u2VJvbcw>
    <xme:y-z_Zj3-6q8eMMKr9S3MKsEO5Cs2RBLll39dIAmtgqWbN6EVZBLkMaZvhABWvm9cH
    nHzvuo_FIM0-bS_SwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepnhhp
    ihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehnihgtohesfhhluhignh
    hitgdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:y-z_ZipmFUXJw9HbAlPHTjOh1Wj0HG-kb__sCvPpSsPfYfi5fr6Xtg>
    <xmx:y-z_ZgmogYMiezizZB5XQ2ljzvatL7KT4oRvddxKiFj32KZKaiYmvA>
    <xmx:y-z_Zi1mvG3PRQ1WdrFWxOy6bpn7VIJWvhxH0qTHk87KU7O4B6dP0Q>
    <xmx:y-z_ZnuLZrW57WHox-7BEOJOnjwF5EXwGuSABr_ErVKnjf6wkCB3SQ>
    <xmx:zOz_ZlQdTf3rPCcaxcgZGxygOi0QrMJapDJnhnK_-b0a2sHyr_66Rii5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C999F2220071; Fri,  4 Oct 2024 09:25:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 13:25:11 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolas Pitre" <nico@fluxnic.net>, "Russell King" <linux@armlinux.org.uk>
Cc: "Nicolas Pitre" <npitre@baylibre.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <75c272ce-b4dd-4360-9489-b9af33b87a33@app.fastmail.com>
In-Reply-To: <20241003211829.2750436-1-nico@fluxnic.net>
References: <20241003211829.2750436-1-nico@fluxnic.net>
Subject: Re: [PATCH v4 0/4] simplify do_div() with constant divisor
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 3, 2024, at 21:16, Nicolas Pitre wrote:
> While working on mul_u64_u64_div_u64() improvements I realized that there
> is a better way to perform a 64x64->128 bits multiplication with overflow
> handling.
>
> Change from v3:
>
> - Added timings to commit log of patch #4.
>
> Link to v3: 
> https://lore.kernel.org/lkml/20240708012749.2098373-2-nico@fluxnic.net/T/

Looks good to me. There are no other comments, I would apply this
in the asm-generic tree for 6.13.

       Arnd

