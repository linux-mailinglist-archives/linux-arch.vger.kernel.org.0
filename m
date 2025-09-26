Return-Path: <linux-arch+bounces-13789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A34BA3701
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C2A7B8BAB
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A802F5331;
	Fri, 26 Sep 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Evynv28w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+WmblRB"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D02F39AD;
	Fri, 26 Sep 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884627; cv=none; b=WAtNZgVQmXCAuQEHogYNUJ6tQar+e4aVW314209Pe0T8zFcZzTnsNHlLdbxZkQpu/atg2W8YJIWAF/oSzu/dNBc5jX/MKa38Lepvbgmy9BF9IHSBzG0/HbaFYis+o5UME5nGBK+f3kCtsm3bxjPLSEdFzdbE4+YYPiOY2UT5MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884627; c=relaxed/simple;
	bh=eDXDjI0Bhxth+86YvJY9YxJtSVBHcM4sSIY6iAe8CZQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rv51iv5rkNwQnQ8yHa66wprFHjhIbiQ9rPghMxHfXtA96wEJpg8pDy7mz+SIRzSnY0caG6sRw2NrjzRTN+eY9ST3TpyiJ55qdmhsjGTKBP98YrtTUZ6f3Uo9PTWKYtVMzfpjQ6wND5AHvcq+pB3JuMe9Qcous+xHsZwJqkGaFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Evynv28w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+WmblRB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 86EEFEC017B;
	Fri, 26 Sep 2025 07:03:44 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 26 Sep 2025 07:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758884624;
	 x=1758971024; bh=PvL16n+18TtzXaiQmMMz6FRycmVwxpPMWvjB6k/vDwE=; b=
	Evynv28wm/NV0ZWs+3WnrnCLKV+nK6T+enyqV/L5ChTMzfhbriQlPBiEK7IM8pvj
	Qr7Iy+r1IE+St4VnWi/JRjwGHeTH/9MM/sCmlXHhQQl+PWTZTMsRGhxHgBCCV7b7
	lIwlOR0gsQNx3z7nNnmHSYuEvRl/7/hZsrte2ZlluM3WbxsiFRKRtx4TbFYo2ba1
	vKxAIgODr3f/D1/aYs/44qX7BMcGGabal2o6XTQiNyfLH7T+WUCkMQhq2zqbjyJv
	q03zAiIJhyChf3A/JJ/K75YAWAWbHXgzpl1bWFim5W6feqW605YdnLnT/eQLc9cC
	X6ZVnFTjmgw51KP1F/XCFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758884624; x=
	1758971024; bh=PvL16n+18TtzXaiQmMMz6FRycmVwxpPMWvjB6k/vDwE=; b=U
	+WmblRB3IbCdMR0nNE9zCvty3cOabwQjBKNEzC9UJUjUP14ykxdlrBoarosDE956
	Qm3I28Rb6z8ujwHKRWheBLx9TuMLtoGJY1OcSUCilIZsjlaRU+wzSZaYA7iUorXm
	MC4Mocymq/AA4uM8o4hoXL/yAUfx6NlJklgKALoBpAmHaBXLKZYTYeWXnUSB54a4
	6kppcrUi159LhvLTXImaOz6YzzxDw6cXJf+0px8sT/3bZcB6+JJIbdpbXrrrgDkA
	h/muCcJmqzKN1naFKD7W07KhFeINytI1v4D9kWWVVBmaJ4KBgeej34GjY7FGPR5K
	4z9sfWpDM2++AINJTlN6Q==
X-ME-Sender: <xms:DXPWaIukjtSSBFYRvOB7OcP6T_VsELwvH6pgfhQQgCPOfiz3ICa8wg>
    <xme:DXPWaATFQ76ZtR4W2BSZ5Tq12JKNjSfvYtkFF0AbwokSXokGH8Ex3Sxw2SIW98_vV
    hLMR4vbY9fctkY3Y7ckxyeUbKelibT-pkHU7NAl2F_tk8wviQ5ZRtgx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtg
    hpthhtohepghhithesrghmugdrtghomhdprhgtphhtthhopehmrghnihhkrghnthgrrdhg
    uhhnthhuphgrlhhlihesrghmugdrtghomhdprhgtphhtthhopehmihgthhgrlhdrshhimh
    gvkhesrghmugdrtghomhdprhgtphhtthhopehrrgguhhgvhidrshhhhigrmhdrphgrnhgu
    vgihsegrmhgurdgtohhmpdhrtghpthhtohepshhhuhgshhhrrghjhihothhirdgurghtth
    grsegrmhgurdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhgohhuugesrghmugdr
    tghomhdprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghssegrnhgrlhhoghdrtghomh
    dprhgtphhtthhopegsihhllhihpghtshgrihesrghsphgvvgguthgvtghhrdgtohhm
X-ME-Proxy: <xmx:DXPWaLNqxtk-4W_Q1j1WTcWidKRWZrdILFCI16kpIL39djm3wQkQ0Q>
    <xmx:DXPWaIl_USgfUt6KPymHtALbiZmpj53D6jw1J-fqc6Ccn6NGGJ6JYg>
    <xmx:DXPWaJwRrh2b7GdwJNo4RiX6cWiV1WTB3rWdVH9JG0TWg_Snrp3N3g>
    <xmx:DXPWaBCbRTo44TawIyG3AHo7s6ykTxs7lyrK7aLyLz8oE2Gci9MzmA>
    <xmx:EHPWaKovkDHBfCP_NUcoE87udMgRd9rjX6kmpE3uxhVlzvvLH-xjngws>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7574F700069; Fri, 26 Sep 2025 07:03:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1PyFc3e_3vw
Date: Fri, 26 Sep 2025 13:03:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, git@amd.com,
 "Michal Simek" <michal.simek@amd.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 tommaso.merciai.xr@bp.renesas.com, quic_msavaliy@quicinc.com,
 Shyam-sundar.S-k@amd.com, "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Jarkko Nikula" <jarkko.nikula@linux.intel.com>,
 "Jorge Marques" <jorge.marques@analog.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-hardening@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
 shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Message-Id: <42afd2b3-ea3d-4413-b32b-b3f1ef651fba@app.fastmail.com>
In-Reply-To: <20250926105349.2932952-3-manikanta.guntupalli@amd.com>
References: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
 <20250926105349.2932952-3-manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V8 2/5] asm-generic/io.h: Add big-endian MMIO accessors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025, at 12:53, Manikanta Guntupalli wrote:
> Add MMIO accessors to support big-endian memory operations. These help=
ers
> include {read, write}{w, l, q}_be() and {read, write}s{w, l, q}_be(),
> which allows to access big-endian memory regions while returning
> the results in the CPU=E2=80=99s native endianness.
>
> This provides a consistent interface to interact with hardware using
> big-endian register layouts.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

My general feeling to this patch has not changed: I don't think
these should be added in asm-generic/io.h at all, for multiple
reasons

- the {read,write}{w,l,q}be() helpers are redundant
  as they do the same as io{read,write}{16,32,64}be() for
  all practical purposes
- Adding them caused build failures on some of the
  architectures that already have the same interfaces
- You are not actually using any of them in your patch
- The two functions that you do use, {read,write}sl()
  do not do what they claim to do and are impossible
  to use in portable code because they only work on
  byte-swapped FIFO registers when using a little-endian
  kernel.

Please just fold whatever code you end up needing into
your own driver as you had it in earlier versions.

     Arnd

