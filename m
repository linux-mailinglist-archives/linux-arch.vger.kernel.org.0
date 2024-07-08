Return-Path: <linux-arch+bounces-5312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B6929B84
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 07:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46C41C20D5D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 05:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAD12E75;
	Mon,  8 Jul 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bgsJegKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rg6wh3yg"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03C12E48;
	Mon,  8 Jul 2024 05:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720416089; cv=none; b=FVbvcX5NHNr1ohjDXVxycj/lRXzlIGx7G48kyD8asHKb3WKL9xpIPlYPFVQ2BfDb+jjAbCv+JzT4EP4EzO6oXKxebXxgMVsPRen8JxseqKzgzILEpn20WcAT0BfIrYtGqtwN0YOnqFhRFM86qKsAL590cLo8XDJxxvU+UIzYOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720416089; c=relaxed/simple;
	bh=D+YA0EdV8mwqi8DbHhgLkiqZ4m1XY/+zf+eyz01wBAI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Jz46zYgDuyrRCxPu6zy66QDggLuj8d2v2SXKj7+O3oEbDaHOzZRVVTqaFUW5wnDjFpyRoVxEe3v+MjPbTuRyP4/69mJD+cEKhbSvY5Q7CtH+RyVZbb8F/z8/4bvYTQo5zJDabh0/QSUVIOnnsTpJDTMMrDJfqstP1nGS7e/5qRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bgsJegKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rg6wh3yg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 39BFA1380630;
	Mon,  8 Jul 2024 01:21:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Jul 2024 01:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720416085; x=1720502485; bh=9cw3liCa6J
	OsDHRRWnPpBkVEUBgrmVrocIAJhOArXc0=; b=bgsJegKJQtUX4O+YwZBoocDCZ6
	V2F49kfn1XQjFQxutRlp/HdyI7jCRhLB2PniU9qy4gg6Y5bCFeEAXL8SGTW18Azw
	JYvDa6snBN6rAwMsWbxdGdt+oX5hxOxR3hEaQjxBr6k2NqV5mEf0vsDDHtI6eYrO
	g8MXfcHXJzixAac5zVknYJ3w0v2Vj3XW03OVKRPLhh4SH1g2hbelI3dps+aSDot5
	hAelZzi/l/+WwWKfbtcHwrcUmuyPVHM9hzzlyC18yJ6dIdmLboRKVP03YZI/VxRH
	VdSziY1n0gEQzkwLWzuGeso8XLeKR15WBlP0P6QodTxEe3jllZdKEpz3Vd0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720416085; x=1720502485; bh=9cw3liCa6JOsDHRRWnPpBkVEUBgr
	mVrocIAJhOArXc0=; b=Rg6wh3ygiXlKw5cMykah+BB3buiJXWN1/bxJjbSUtkvH
	F2FLx7jgPssSfcyB+tdshnjq7GKrvnONTyE/cgM5fVYzJM+Py2eKs0+OLDYd6wtq
	FDduAyQoZHvnBANL3EQSPYzenEzAZmsOgAIfMjaFiLD0Xp/yN8DdsUWBdTQbFjmJ
	knD1YymeorefaZfh5dpGNtO3TOD4aa0Pi/W0f68DtMgoIRjx8qYYstHcbrxXBtkl
	11WmJaFQVdVKFXvNrcY+AAi+frts2sti9rAmZuoj+AQxC6eni+3i9Vb1TyWEyQcU
	rtGb8HN3JuGLoEkxbj1YqXzBK1MkavOwHYYSZez9wA==
X-ME-Sender: <xms:U3eLZjS2HvC3YeYtZ2CyihkvG-USKvHruVlnDzpcQyyWG8-9xcfKCQ>
    <xme:U3eLZkxorCyx9VjGvFWwr5bcWE89A2yizFM8gEEci5lfuU-hgBeu2-XkFK0fL7OQA
    VSsHdne_N6xpPHBeHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VHeLZo0IjfBFyeOSniCX5pKiV9LCw6pEGP88OsCKSJo5N8mO7qGmCw>
    <xmx:VHeLZjC-mo7oKSmwuoPLw3hzhZbKBYp2iqj-c1cgaC89OP2BrwGfAQ>
    <xmx:VHeLZsjeRe8wWEhEb8Bna0xFYutsCOzo4_8lUTaueiIX9XFqyu8pgA>
    <xmx:VHeLZnonLvj0tp2X132j89X6g0xiEtKJSp-Gpni4pLUwB1WUNVUILQ>
    <xmx:VXeLZltCwghKpDk280Q6cEc8zxM4b8M3yRyHDX8UtsP9hRIEwPj6n4Mq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DEA44B6008F; Mon,  8 Jul 2024 01:21:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6fa4d8af-0f9e-4525-adf6-8c3c3d059b2f@app.fastmail.com>
In-Reply-To: <57srp3ps-n7p8-orqq-86rq-p04o2246pn7s@syhkavp.arg>
References: <20240707171919.1951895-1-nico@fluxnic.net>
 <20240707171919.1951895-5-nico@fluxnic.net>
 <55a8cff0-1d73-4743-9c56-2792616426c7@app.fastmail.com>
 <8251045r-26sn-4674-p820-4qp6s5o322qq@syhkavp.arg>
 <3dc8f89e-4525-4084-9d4a-facb6105239c@app.fastmail.com>
 <57srp3ps-n7p8-orqq-86rq-p04o2246pn7s@syhkavp.arg>
Date: Mon, 08 Jul 2024 07:21:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolas Pitre" <nico@fluxnic.net>
Cc: "Russell King" <linux@armlinux.org.uk>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when optimizing for
 performance
Content-Type: text/plain

On Mon, Jul 8, 2024, at 03:21, Nicolas Pitre wrote:
> On Sun, 7 Jul 2024, Arnd Bergmann wrote:
>> On Sun, Jul 7, 2024, at 21:14, Nicolas Pitre wrote:
>
> Oh, most likely yes. The non-constant base has to go through the whole 
> one-bit-at-a-time division loop whereas the constant base with 
> __div64_const32 results in 4 64-bits multiply and add. Moving 
> __arch_xprod_64() out of line adds the argument shuffling overhead and 
> it can't skip overflow handling, but still.
>
> Here's some numbers. With latest patches using __always_inline:
>
> test_div64: Starting 64bit/32bit division and modulo test
> test_div64: Completed 64bit/32bit division and modulo test, 0.048285584s elapsed
>
> Latest patches but __always_inline left out:
>
> test_div64: Starting 64bit/32bit division and modulo test
> test_div64: Completed 64bit/32bit division and modulo test, 0.053023584s elapsed
>
> Forcing both constant and non-constant base through the same path:
>
> test_div64: Starting 64bit/32bit division and modulo test
> test_div64: Completed 64bit/32bit division and modulo test, 0.103263776s elapsed
>
> It is worth noting that test_div64 does half the test with non constant 
> divisors already so the impact is greater than what those numbers show.
>
> And for what it is worth, those numbers were obtained using QEMU. The 
> gcc version is 14.1.0.

Right, so with the numbers in qemu matching your explanation,
that seems reasonable to assume it will behave the same way
across a wide range of physical CPUs.

    Arnd

