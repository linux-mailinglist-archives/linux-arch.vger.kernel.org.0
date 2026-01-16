Return-Path: <linux-arch+bounces-15832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E1D2D8AA
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C96F30C902D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5AE283FE3;
	Fri, 16 Jan 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WI+AsqH1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YilAjyAd"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A084405F7;
	Fri, 16 Jan 2026 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549832; cv=none; b=YBIC9Mxer4IYBblD4NT0sQXQphK8rVFhffMS824D3KZpTHrQkB8YXb2pfdPtcH/ADo0RNLsfuHMCPeRJPiWQXUDPu6qJ6Wrle+bQBDM3qwvLnZ4aTeSe5mAFk1sUjrSaslTSALQvoyFXaTyQMzR3fHwyohl+7HtR8Ryja5V2Lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549832; c=relaxed/simple;
	bh=c9U794JOM/4Q1nHdWaEeGP0/aSgBI9xQERE4aZZHq4A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c/se7n/qIklFB1V88JJ/P5RkNJ5uVnYZ10BAoZWkTRRxCQhiKMy9V5ryAnwoT8ylvUYS2N1uW/WzmBAXT0psLN9iVQURPsmU5yWik2yUT8JvTZo8qMF5gqMhWI2z6ZtYQtXmQcfWNWo9QSWcVvn5HP3sY9nmeIFBXk93JIPF+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WI+AsqH1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YilAjyAd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A48081D0014A;
	Fri, 16 Jan 2026 02:50:29 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 02:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768549829;
	 x=1768636229; bh=c9U794JOM/4Q1nHdWaEeGP0/aSgBI9xQERE4aZZHq4A=; b=
	WI+AsqH1NuI0HB6U16RGBRAghVwIt0qtq1s5xNTJ+7xwcf3wg6d9Sr5k00fIPVDC
	qSgcq7Hzh51WNETr0GBJLE1thCjeP4WN/ke5LgdOsiaH4mO7cb9cRqp/EY6ds/Qa
	uU6TinKf+FkwuxWu38ufUMhMDiKRbSzWIWD3o0xKZtk6jipdQgd1xHlAlPCEPdxv
	jE1N33llm+0ERD72pali0w24xNA/ZVG6aLsc3ycVm8kV6nsNvzTmZT8DGn4Rk+ml
	Jy4/zLsTQ8OEqBSwA2EeWdzMMWBdpJIW1hXK/+E+sblk8lqV2KiTF9ccspi5Aq5n
	R4p8rAt6ldvtiQ1y5cLEKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768549829; x=
	1768636229; bh=c9U794JOM/4Q1nHdWaEeGP0/aSgBI9xQERE4aZZHq4A=; b=Y
	ilAjyAdyYXFBA+bzC04et3CAktskxuqsnSFhO1R63hbBu4r1hQzRYlaDOQSO4fb1
	7JpUKM3vzmfUmDqcZd+S1KHjfZFTXiYXxYOvxZj13ml2szV2Ao1yO4VHIGkjDFls
	k8GIYd+rW9wfNWo+jePxOoNDvbhnGWd8y/AR36xpc+Sn/IZY6BZFEnJWgb5qPyde
	d9zqhmEObYWdiitVldkauB74JHuKPGiHGWYPXnoN7Yr/7/nwxD3cp+81EKdzXQs9
	dF9IGWMjg/sKc4Gbf/dhll5eRHLo+IzSdhnsLCVPo6VDNbfFRd9co57lDHWfI/NG
	rZAuahXdrYOHjEU9HZ3tg==
X-ME-Sender: <xms:xe1paZDxbm8bwCh8RmR-jQHwRt7OFjz55GYrCa-rS5ECwQ9tv7nSpg>
    <xme:xe1paSUOk4srL4yQsf5Vdo9k1NTxqqkmYEHHcBYhTVWjLGOBRd393BNMFBO__8Cpa
    U4_5GAcleP6oI_J5Bmg7WdPU9YjOsvE7jq7FoqB7vdB-vqQJvnJTKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivg
    hnkedruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopegrnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtoheplhhkph
    esihhnthgvlhdrtghomhdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrd
    hisghmrdgtohhm
X-ME-Proxy: <xmx:xe1paXwTIE9gcDn4Zuus3KQBa_s119DN7TUgyQb25-g2nGB2FhVvTw>
    <xmx:xe1paccKshbG-_qHcEAblItqoGZtvvnuql6b5ZlHgBnp2F1RfDlOhQ>
    <xmx:xe1paV3ZqBgJBqL8EzZVaTRtYN_TzjYaWrekFZXmPEDE4_DvyEQ2cg>
    <xmx:xe1padshs1CX50BZxzm-FFJ4GO42ZesM6libE-E_9Sd5pE2bMesfYw>
    <xmx:xe1paexZfHP5VxZEkPiouKc0mrVRNSA4-wBAdwbU-RUwX4qXu28Qm9F4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2D2E5700065; Fri, 16 Jan 2026 02:50:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0bkllDka2_o
Date: Fri, 16 Jan 2026 08:50:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>
Message-Id: <7c531c16-b620-4ca4-88e5-985f908fbfa3@app.fastmail.com>
In-Reply-To: 
 <20260116-vdso-compat-checkflags-v1-1-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-1-4a83b4fbb0d3@linutronix.de>
Subject: Re: [PATCH 1/4] sparc64: vdso: Use 32-bit CHECKFLAGS for compat vDSO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026, at 08:40, Thomas Wei=C3=9Fschuh wrote:
> When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
> are used. These are combined with the 32-bit CFLAGS. This confuses
> sparse, producing false-positive warnings or potentially missing
> real issues.
>
> Manually override the CHECKFLAGS for the compat vDSO with the correct
> 32-bit configuration.
>
> Reported-by: From: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/lkml/202511030021.9v1mIgts-lkp@intel.c=
om/
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

