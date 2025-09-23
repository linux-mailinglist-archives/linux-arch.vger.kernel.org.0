Return-Path: <linux-arch+bounces-13732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A35B9736C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2BA7A258E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163F301039;
	Tue, 23 Sep 2025 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lJn6nA1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYAXmHck"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454D15624D;
	Tue, 23 Sep 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652711; cv=none; b=eCzOD4lppXePyOahfRfIHHBHJ7T5ly6jDBDXrBNFT5k99KeqjDz2F73/N7iJTUIoBAvPLohKrq1Xkjr5silPRdzWG/P5OLA9TBLL3/pCLCyoNJzK0toSGgw/n39BoPBNRG+XhVbHYzfGAbr3DFmKXSQavtDSIWhDWlO/BCU5mtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652711; c=relaxed/simple;
	bh=t2EVhTFHcrFWdD8mGR/DN3WAjW3UGWDzKTUo9Nq/hHU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ba4DqKov8Hs+ymGBQu7Sqfzm0N93RIDaX67dutQIHWRg8/fv8qCyGW49K4vztksHCot5qL6NavmX3XxtCJZzmNWUIFVkSOQuP5nxJNNGa9O76WRToAK7F3KRHCJNNPD7wDvG6b3x+qA36wF4T/HBO3wJZJTSTvNvapx9Fvi/+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lJn6nA1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYAXmHck; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 386B37A005A;
	Tue, 23 Sep 2025 14:38:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 14:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758652706;
	 x=1758739106; bh=nrFGLCTqsqckTBO72y0mzJiE3AI4L/6qnMuJTwts27c=; b=
	lJn6nA1HpgkmgmqwMc38pEELag25O4m7V1154CFjEaF2JMyFFxmEy3ky5K0Wvbjh
	yEBVh2XTFkA4eGaO9e5WziEm/2NJI4XXh63+AIzc3NQwb37RmtIGXg5CZOJG4X76
	gzqobwRnrswlXWsdKmio53LajbWZ3xI0Jwu+sAO7+MwhtDRYYaBS+YgzgEoqNZ7W
	oTFx/DDHWRlKyXtoJbOuVng0PYJCRwGoZWHFzQkFEZaCTirKlL9dOWuGW/PrTCiX
	jC1vLziFkOifmn67n5balgePsmEuYvbbFFF5I7U8vIYyHX1UnVX9RSLZjymTTBTd
	d5PHIXb6fm8fetq6zUPt2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758652706; x=
	1758739106; bh=nrFGLCTqsqckTBO72y0mzJiE3AI4L/6qnMuJTwts27c=; b=J
	YAXmHckyu4MQkIOlTYEc6J05OCQk7KMy0rYBvhKm+/KiQDgRTRxZlBjuzI6cvJxv
	njBPteLk5DpaneGgjfPuiA/ByYRFTkdhdDsZ9l4xP0HNZ1GyxyyoNcNwhMfZqxO1
	M3cTJZCaD9qE7FX4Cec+YH0V0sPB/TYweSAzdxQ6F5Bv7bI+IlcxNavD+1PbH65l
	W2V5maIkVHUD3xRqPkSQVS65qkH68Fc52n3qzDIp3F0lsw6f5xhM0eVvFTSJu0DI
	xNanhvIL6t4Ien8+l3w2WGC7qzmsB3l2Dzinm1uueUtss82fqCWJQmk2ZNSOaLKH
	cOXUr5jq6EKcoCBo76YSg==
X-ME-Sender: <xms:H-nSaPZowPSpN4ObvaPjHY1jIFD0LaqDAgXiXr23B5wn871_AGHJag>
    <xme:H-nSaJOIkAbliPKAXAasNevLFglGIpEpjqmd68BcffpEwucw2MpCPZP8M9D1aR_nl
    5HbUhaI7HcwyCXjiaazE31tXiOzMpMVfL5YVKcd0EoW7cND4_VpFZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:H-nSaFBWn68svDp462uoZMn7DaJxZR9ykjAminvbrPesSi1cjHpcwg>
    <xmx:H-nSaFdOPTr3hanxMTPGv8vnrYSE9G3UU2l3Ky8Lr8UsSzCwb-mxng>
    <xmx:H-nSaK94NjpD3eg0hYqCK5Wqdb8sjguBgaZCFvTczesvvexkmohbZg>
    <xmx:H-nSaNHCZKDKQnAY0Ntz2XWSItuejCrSVw1e1jm7X4alD8fCeksUAw>
    <xmx:IunSaAHS6yrl0ixjA0hmHQn6FInEVKycskBZTF3F8YsXkHnTmo3xiJwj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C605F70006B; Tue, 23 Sep 2025 14:38:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5BcZzk33eMV
Date: Tue, 23 Sep 2025 20:38:03 +0200
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
Message-Id: <cde37e36-4763-48ca-a038-4a19eb1ef914@app.fastmail.com>
In-Reply-To: <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025, at 17:45, Manikanta Guntupalli wrote:
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

I feel like we already have too many accessor functions like these,
what's wrong with just using io{read,write}{8,16,32,64}be() in
your driver?

On most architectures (including arm, riscv, powerpc and microblaze,
but not x86), the ioread/write helpers are identical to the
readl/writel style helpers, the only difference being that on x86
they add an extra indirection for the port I/O check.

At the moment, there are only six drivers that use the
io{read,write}{8,16,32,64}be() style helpers. They
are all powerpc specific and can probably be changed
to io{read,write}be.

      Arnd

