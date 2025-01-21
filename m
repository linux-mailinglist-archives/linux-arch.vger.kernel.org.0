Return-Path: <linux-arch+bounces-9845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E68A18738
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 22:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C165C3A6D0E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A21BBBC4;
	Tue, 21 Jan 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="t1RrP9iQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcSlaumx"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0F23A9;
	Tue, 21 Jan 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494294; cv=none; b=unQxstEJew1yKJin9LMmj5CFIGyVXVj9s/cSxEm16SUFn8u8xv3fRZkiXyBTvBj1tTjoiRn6sLfakC7jLnr/uYUutNDufRwB3HCvrU0m5ahbKw8DEHnOp3JNMwrGlZHDewP2Kq1tyLaFRFtKdJTTVbrZqQsYjxGrWinffgDiGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494294; c=relaxed/simple;
	bh=sXHu10aY2+J27YyWutuubChy8v/79YTwiDfhxvuUYos=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sQBDYRllyOoKLTBAxUirl3iHkCWo9VWDynjj0WGIbx6tREJl6bxcXVwD3zSZCK4uZnoLYb1W7Emlg09yob7+v09y//puseaWt2soDc0SufzhN8LZYzLGmOCiVfbSkrupZ02X1l3B5gIOuT2QOuLhjUwfBEv1vV1Wu6V1qDKCvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=t1RrP9iQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcSlaumx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 68176138086D;
	Tue, 21 Jan 2025 16:18:11 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 21 Jan 2025 16:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737494291;
	 x=1737580691; bh=B7VUtW6RNhlluTyQUoNjUJwfoJe71nWoT8+gGXcFYrY=; b=
	t1RrP9iQ7U9Mwa235yzKdJsnJMXHDaaRpFo1VE05q7jIIr3p7Jxny/uOZE3+Jpqh
	uvfO6UiaVZ1ikxlSSFi2+ffVG14uNQVVNlifF+DsdMXo1LYF9KH3qDERFlbitJGv
	Xo9n6IstVxAd2LCRBXAG2aNuo7rw4/pldZ0hd21Pqw63WY4gbC+0+YeAinC8ummV
	mJ9YNT11mtUKw98oOvdoXmkGEyXkPRa8cByaZU8ZbfBVgBtLqr4bSTYxxqOg1A8o
	6hhotnd0ly4uCKoAhuTXYyE3aJ7SNjyguge7mM+XhunpAk6HH7AO/3D2AmZR1LxX
	eo0RHe+m8d/yCqBv05mwCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737494291; x=
	1737580691; bh=B7VUtW6RNhlluTyQUoNjUJwfoJe71nWoT8+gGXcFYrY=; b=N
	cSlaumxAfIjTucRw+RQCxSAbvvcr5q6vCQwvSU/B5/9r7/CJUOkflgFwy/uJoJ63
	bkS7y5D2AjysGOcJdc1kM5GWXC35NPCACXAXKUhLq7Zd65Jut1J4qP+HbDXDftDZ
	wKB6I8HAvHT7DW2ScYIucEScrXCzjGL2LjwSALI1dDA4EFvN4M8gQT03qEc/KrhK
	uKP8xPuW9yRHUOl/nyYw9YjQM309bfeWuSruJnS3qVkstPq7Gf60jpuRC6W2gzti
	CMqwcXl1CgoF+AKo3nsRHjU7KB81FUdDe3Hcanhe78GepO9ty/sDcTCP3Jr6kooG
	jqw9zWslFE9P7qOR1Fa4g==
X-ME-Sender: <xms:Ew-QZ0kmyGRk83tFe5gm-gZ5i1sLAZwrV0FZyYvdjcwjkUcpoNPJ8Q>
    <xme:Ew-QZz3_35yRqPrpVk5_Ym6LGud8rcdBXlKgvL6DhW7Rzgq82EFBtZI7x5rsnTuut
    TPYBZ4W_jhfdVwsVnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepshhhvghnhhgrnhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepgihurhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghsrghhihhrohihsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:Ew-QZyrTTDQmYlCpJ9r9Q8W8DM4KMlOB9xIgFO7Au6BGK-SXYRF-2Q>
    <xmx:Ew-QZwkRCaYflkQNJs2ts8JvuXobxU6GTxuRZWz668Rafwi3pd7jng>
    <xmx:Ew-QZy0bupXC-nsScxbY2judniakAZFX7XzhLZlmlI7wnFZeNuPEjA>
    <xmx:Ew-QZ3ucColAhh9_sFnXK0ZiMq-HdN8Y8nbheD4UUPEPmYVSl9OM6w>
    <xmx:Ew-QZ_vDPCfml-P1zAJqNKGYHtkOfTZHIGmmB4YIEJhW2Zjglqs6Uis7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1EBB02220072; Tue, 21 Jan 2025 16:18:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 22:17:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rong Xu" <xur@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 "Han Shen" <shenhan@google.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Kees Cook" <kees@kernel.org>, "Jann Horn" <jannh@google.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <c5855908-df1f-46be-a8cf-aba066b52585@app.fastmail.com>
In-Reply-To: 
 <CAF1bQ=QFxE8AvnpOeSjSeL1buxDDACKVNufLjw99cQir0pyS_Q@mail.gmail.com>
References: <20250120212839.1675696-1-arnd@kernel.org>
 <CAF1bQ=QFxE8AvnpOeSjSeL1buxDDACKVNufLjw99cQir0pyS_Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025, at 18:45, Rong Xu wrote:
> On Mon, Jan 20, 2025 at 1:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
> Yes. The order could be conditional. As a matter of fact, the first
> version was conditional.
> I changed it based on the reviewer comments to reduce conditions for
> more maintainable code.
> I would like to work from the ld.bfd side to see if we can fix the pro=
blem.

Makes sense. At least once we understand what makes the linker so slow
and fix future versions, it should also be possible to come up with
a more effective workaround for the existing linkers that suffer from it.

     Arnd

