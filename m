Return-Path: <linux-arch+bounces-7123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28E970941
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902B02818FE
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07393BBF6;
	Sun,  8 Sep 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pIelrbMj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WTh6/Dma"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0391C01;
	Sun,  8 Sep 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821327; cv=none; b=dr+YWgqdLzbWiSgD4UggV0x35A/X1KNaNx2wmcnzppgRGcRWdDprUzVRWt2BUhjNeJ5usAQjBNWoLYHdEHByC9CswlCgVtiMTbKEsPoRWiKjqhN6gLHHsip3YtIg1LV4AodeEE0a9NldynhAbBpCmyumplKvY5y0bsn78kdsO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821327; c=relaxed/simple;
	bh=yPWXRto6tdgYRKT/hZX27dOSn/QmreMfWXsYaWnFT04=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MH6SUWmKjbNhJxHzLbc7PSVpKITEypmKPEOp0MCfarfSajvobwgSioKjuv6P+yYtPHh1k+A6WbsvT65z9qRRH7tRaNb+f5cKh4xAuoRX5KKHLUEOrDW7SzzWK1Mhyx4B7Ai8YUf7HLtR72ypTVynAPzaPLKynVIBNIJtrzjPQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pIelrbMj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WTh6/Dma; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 49AAF13801AA;
	Sun,  8 Sep 2024 14:48:44 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sun, 08 Sep 2024 14:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725821324;
	 x=1725907724; bh=JkD38rG6xdhn5i8WXaenEJLcpRWMj44PoaCjb/hfV80=; b=
	pIelrbMjzXjQ8Ew5W3xoLJu9A3jIsP2Oag3u1DOyAtDF1mZypFx7NT/+QlyxQN3V
	YxqnFHci0MgsFyLMmF9Krglm61h60GF4srEKy+HQgGMTOMYKbjdaG5CuTdNEcSxL
	hy2/vEXVaV5RSxycEYsCNWT/VFG8+f+Qg0qFwO2VX+ezBBvm78Llo6HeV8fDpEP1
	C/ct0ps3Hy/20VFpEl8Me1SwQG2aFrbtIHUHJ9xrqeVKE2dK5T0tckVEaewxkUgt
	QlhqSa9sC7BDCU0KJBd5zAIOvq2RtF3/0DTcrN3V2CDASmJxKmhCZ8I354vE4+Xm
	DvtDeCt84FIHjpb2oDQw9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725821324; x=
	1725907724; bh=JkD38rG6xdhn5i8WXaenEJLcpRWMj44PoaCjb/hfV80=; b=W
	Th6/Dmaz4u1MUSFoaoOfiwdXeUB08JQfEM0hLCPrVZ/a3zeAAyTOmGjosgRs/Uo4
	5Udzf9x48lGNmOrN8eRZlAl5CQGdtUzKfulrF82PkTtxfZcF1/wszW1TKuMYcBHP
	lQnrcnuXUJpZv9i9C9TP3ur0m3MLWwBea3WhfFRnExn9v6I9eee0IGF2Oyo7ZdNm
	zx5etOmTYb57giFL33yt6PPifMZtjKH7dvANLZAqNZtAbTy5jYcRCNZnPBjAV5eJ
	OU94CAQdThroc/6wk2PgCkLbAgbTAboSEHY05pn4gqVLW2WfQhzY+f+LJLzYzHL9
	dcfZsEKvM7YMGyITv3/RQ==
X-ME-Sender: <xms:ivHdZv0xhuAuvkevwC6DJx68nNBhhaBFW5zP1DvgPMzgyRrYe6EwCw>
    <xme:ivHdZuGyPu0LiUbax-bh1niuN_UdPSVWZ2qVd4ptM0SVVsmwxNa8aMBViPsKTydAD
    BphhdRHzt8uAzX1BCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedgudeftdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ivHdZv6nNFUrn5XmLkKF35GTSouNKkWWLuX06yE0YPeK45vVKKveZw>
    <xmx:ivHdZk0nZf1Feto-7H40HJ2v6Ui881h5W2au4eJAHrLCAhnVHcOx9g>
    <xmx:ivHdZiGuoALEufxRpE90cCMmr3F1uSBqk195kxtAAA26uP7U_9nxyw>
    <xmx:ivHdZl9mLiBRJfdqfZsXkPOAxKWqTpzkx1_bU2dot9dvmF2pQmxVaw>
    <xmx:jPHdZiL9IJJKlrUNvAQBAi0GcSLaQ74LAykM6vwkuMak7swWOT-VvxS8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C28F8222006F; Sun,  8 Sep 2024 14:48:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 08 Sep 2024 20:48:06 +0000
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
Message-Id: <8868ef2c-6bfb-4ab7-ac5e-640e05658ee1@app.fastmail.com>
In-Reply-To: <ccaac82f-0c43-491e-ab8a-1da8bf8c7477@csgroup.eu>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
 <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
 <e28e1974-cced-462c-8f57-ca1474272e73@arm.com>
 <11527a80-7453-4624-b406-e88c5692b015@app.fastmail.com>
 <ccaac82f-0c43-491e-ab8a-1da8bf8c7477@csgroup.eu>
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024, at 18:40, Christophe Leroy wrote:
> Le 06/09/2024 =C3=A0 21:19, Arnd Bergmann a =C3=A9crit=C2=A0:
>> On Fri, Sep 6, 2024, at 11:20, Vincenzo Frascino wrote:

>>> Looking at the definition of PAGE_SIZE and PAGE_MASK for each archit=
ecture they
>>> all depend on CONFIG_PAGE_SHIFT but they are slightly different, e.g=
.:
>>>
>>> x86:
>>> #define PAGE_SIZE        (_AC(1,UL) << PAGE_SHIFT)
>>>
>>> powerpc:
>>> #define PAGE_SIZE        (ASM_CONST(1) << PAGE_SHIFT)
>>>
>>> hence I left to the architecture the responsibility of redefining th=
e constants
>>> for the VSDO.
>>=20
>> ASM_CONST() is a powerpc-specific macro that is defined the
>> same way as _AC(). We could probably just replace all ASM_CONST()
>> as a cleanup, but for this purpose, just remove the custom PAGE_SIZE
>> and PAGE_SHIFT macros. This can be a single patch fro all
>> architectures.
>>=20
>
> I'm not worried about _AC versus ASM_CONST, but I am by the 1UL versus=
 1.
>
>
> This can be a problem on 32 bits platforms with 64 bits phys_addr_t

But that would already be a bug if anything used this, however
none of them do. The only instance of an open-coded

#define PAGE_SIZE       (1 << PAGE_SHIFT)

is from openrisc, but that is only used inside of __ASSEMBLY__, for
the same effect as _AC().

    Arnd

