Return-Path: <linux-arch+bounces-7032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544D96C560
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8F11C25329
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB71E2008;
	Wed,  4 Sep 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="h1s4T6m4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NhO+4sF9"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5B1D0169;
	Wed,  4 Sep 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470629; cv=none; b=ZbGgf7n8WAw/NBiiOyn7WOveK5fxOIu/fhPsmnCy7Qykhb4xaHZSD061Rm6VPVi6pm37xt05s0JvmJzNClKmtEiiwUr6szwMgiZE0L9YVC89T8kCgiIoeN+eBqlteYtCBdZaaz0xJtKlP660fAjCe4GX8Xj/l9vqKIbhnKQf3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470629; c=relaxed/simple;
	bh=s2efDce6CDX31pgQiN32+eqcS1MxoqBaGVtMSiBMXWI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FvNOW2LPY5aruw5typNs9BLpImCUcSnNtO3HTSOFgGrLD/UkCYOGX9Cfg3+Y7r/Nmh2xLwl1HXhFNVMXTIaKn0ocHXRkenykbkDRQ1Hw86jkR19c0pn53bk2W0H4Mb4Exn61eKKvtR9ooVpaA9l0denz91SYtg50xz0olTfbDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=h1s4T6m4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NhO+4sF9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D83CE13801B5;
	Wed,  4 Sep 2024 13:23:45 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 13:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725470625;
	 x=1725557025; bh=gejL7XLc5uyclMWWJdGk4rD+yPLuNoi/CA2jk7RUBJw=; b=
	h1s4T6m4iK2zaF3B0ZwkXrMbhPP2nwgbKVXxqnhCfSQEnjN53s8t3yVDUSAev9KC
	3AEjGSgDaLKTQNRwoi7fbJSG9C1QJJ8tp/5HWeDe4Zzyocfh8wKIBihi+b6Orcfc
	ieLkV2zyWCko+STaBJqUHF/aO3SxLPtfQotKAUbJVPkchcd3zLu1Iu7YKMJ3rqVo
	elLg5YnOCQvFQiRSAQZ492Dn4eDuhvrEZCbOFvKBEVu1rsgp5dqrFdu8xHpmo79L
	xTiK0stcIwKi0Ihsk8ubKPfQKVbEb9+a9lgYUIzimL4YoTq2gfkEiqUdSqN1WyU3
	GLMs5zBfBLKmuN81Phay2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725470625; x=
	1725557025; bh=gejL7XLc5uyclMWWJdGk4rD+yPLuNoi/CA2jk7RUBJw=; b=N
	hO+4sF9227F3QJuwaq7xvDb0H7crblJIVyuynjtvnBEZasu6OX4UfSHw4p6QhIRO
	zJ7sjUw61uKsQrJHxW4wXM0U6TwJOYckamYvSA9CQUXnjCnqxRF1Pa7W4IuhphpC
	1tfe0mT89Gi0+WmjVz0gFwtgNWkOlVnSY1IIAVZ9AeHaWOyl16UuxEWUaiToDHTi
	hqAtJ5mA9FzKktpUQHjG2z1QWU5hBVXjzILIVP0JAq+Db3Lp9x4sTzvSc26dVcYj
	Ix4v79rY+WHgh0F1kp0f6rpUgRW2nbvFKuOQGVHiiDsVEpn4qdua+X3yVua1Ujdo
	YMG/Wx2YChwU1gFE4cgnQ==
X-ME-Sender: <xms:oJfYZlJz4HzYpfZ91WDDlaWdiSSdqb_coPO9POqoTUSa1LQCbpkrVQ>
    <xme:oJfYZhLiuoaPqIJCtbig3f9vp8AG6NdBrMb0lfVOc-ankVT7f5nqhLSd-I4xbGZGv
    Vgnkd5bLjBfqTYhE3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgt
    phhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtg
    hpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
    pdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnh
    hpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohho
    ughmihhsrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oJfYZtvFpkA9rcBOZ1jgUYe9gHISIPWjwZQkBUvRmnhvmUE7iX0JDA>
    <xmx:oJfYZmZsjPErShFS0ldf-_fntBtiV7un_d1OH7s6vBvsrwzHo-Rwwg>
    <xmx:oJfYZsaPeaCFve5BbPMgCQm116oWRLhYnb7skgTJ1EiQQFebW6_OXA>
    <xmx:oJfYZqC3XEp3bkHYUUlEHZVtxwhrcCy0VoW-bkQffQnhMuhZeoKtbQ>
    <xmx:oZfYZsOv0G6dQMMz0hfmsvPCpUPxnHW-PNR-ysEkGjd3t6UCzd2wmjYS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 960A82220083; Wed,  4 Sep 2024 13:23:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 17:23:24 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <780d969f-8057-41aa-901f-08a5fbebcba9@app.fastmail.com>
In-Reply-To: <b78eab34-61f5-4c9e-b080-d2524cd30eb8@csgroup.eu>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-6-vincenzo.frascino@arm.com>
 <b78eab34-61f5-4c9e-b080-d2524cd30eb8@csgroup.eu>
Subject: Re: [PATCH 5/9] vdso: Split linux/minmax.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024, at 17:17, Christophe Leroy wrote:
> Le 03/09/2024 =C3=A0 17:14, Vincenzo Frascino a =C3=A9crit=C2=A0:
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>=20
>> Split linux/minmax.h to make sure that the generic library
>> uses only the allowed namespace.
>
> It is probably easier to just don't use min_t() in VDSO. Can be open=20
> coded without impeeding readability.

Right, or possibly the even simpler MIN()/MAX() if the arguments
have no side-effects.

       Arnd

