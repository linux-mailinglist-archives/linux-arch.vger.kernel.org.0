Return-Path: <linux-arch+bounces-13716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C728B91E36
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBB1900901
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048362E03F3;
	Mon, 22 Sep 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="g2nV0Kex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzbAe1jD"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAB192B75;
	Mon, 22 Sep 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554529; cv=none; b=Hjw24r1K65VZj6ZmVDaZplS8LfFe8kxOdPo+HjW7QEOe4v1jlmitaLA36H1DhKzyyzxIUn7n0zmHUC9e7lFR3y1YXoxvTJRe32M+1UjyAjVs8yOBegMeawha4V0EnHGqLnjZuyg3n8vRqnZIBMxhEt6kWL1bYPSr48pKiBpH1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554529; c=relaxed/simple;
	bh=IgATrXO91VR9Hs0/GWvI5q1OG1RkIqn3kxafeoyKJjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IzTXJ0ahvMqclFqVTSMD6GAU5x46JQeXClXm8HpO8cfXVTFw8qSzkx3kSsamp+oJQZhetB1YcvcoCiNGIkfeBV/6JygjgnwDfsh7nElYGt46qaOvKM3FK23bUjMRCDCA7/wX36DGVOf23PG+zVHJA3gxR6I4Q15VozuX8dLWnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=g2nV0Kex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzbAe1jD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 864581400029;
	Mon, 22 Sep 2025 11:22:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 22 Sep 2025 11:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758554526;
	 x=1758640926; bh=ya7VGGpmpXv8BTTLA/PuENk8KsOGcjcqd2vAO4qYW/U=; b=
	g2nV0Kex8bQfzQ0MyhdkvOtqyNdHFrVDtzzNKj3vEvsaG4mB0DlrAWehueVkKjJZ
	PtwNTJbSkpTHDF9vOg92OyW40QICFeydshIv+ntVRXzpFXQLhA/n6jOMAjhm0J+I
	4wp3Z/xdjL4SWUa0VK0o/Q3UTDHjqUOgqgDPu13kK/SFyb+OogLDNTwo6l4b4WlT
	0e0IPalnA4bADo2Zex/MzuFrVWFYaB98ucUsWqkiQukF/GX2kADOPvL3MIzPhE6S
	JmiVmecAZhKhTefAl+7gtyE+Q/ESvb6WYAZr85pFtBiUa8Ivkh4wXwZEygfg/Cov
	mVQ07EOqxOjAX+cIT4QNWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758554526; x=
	1758640926; bh=ya7VGGpmpXv8BTTLA/PuENk8KsOGcjcqd2vAO4qYW/U=; b=l
	zbAe1jD09npJLGHf3/IvIsRJxvCNpbA2CWyumWw5BX+jAJ0YymtHuYTeGXtdXx28
	Ro3IW1cwZSMBLqavOEa1CmMDwuQ3eRpzwXVqk2hOecP6smFaPTTbHTn+WSLQ0VCt
	uTkuu4yOuZ6kHJ2WwzEmS81d4LY0a41wt6vDPGLnIJ69vtMZ+MHYUtgHyAK/0Flf
	MAJ4HPskMdDie5/WE/qpJXlt8B05JaHQcA34GBM+JdhnYrrU34SoTY4N3FiVxhqd
	1AEzORzBUYJ9Y8qj2U6e04/93A2yskTYr/JTukLNkqufNQLMXkWj8Wle3t+kiaRz
	QqfKsFVK4Loi1pRCaATnA==
X-ME-Sender: <xms:nWnRaKfa0gxWh59JdvT0I8-iCRpKuatq8RpzDnRr2Xkt8T7Cua9NIA>
    <xme:nWnRaPD2uyWISJrxKva8FXR8R2QpncFyjAbh7svzS51zs9vS4cKAAag41rWQHwiZS
    PBCwPIIoefixTBrQ_WqIfsLpN55IXhp03FljHlWi3K0wNkrz-trtQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeggfejudejvdeijeeglefgtdfhudffieetfedugefhffekjeefhedtjeefjeetfeen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhdrrhhuth
    hlrghnugesrghrmhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehfthhhrghinheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmhei
    kehkrdhorhhgpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghvpd
    hrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:nWnRaKYC4UZddIWr7FgJ70jGfUvY8Mwhfd-XBC8iAaZTBa0kqA7ZZw>
    <xmx:nWnRaDzDoQ0d-dIU6qgL7VsWsCYEmDxHm9D4v0CloTU6s4UL5KpF6w>
    <xmx:nWnRaBMqiKNYA_7mTeBEuvwJGxFm7ripqfLnqmCbu8Z2GcRE5l-oSA>
    <xmx:nWnRaKebuJ_F6SjpIUSAqHS_6ZoHWbLakPealYRKZJAy_aXiVxmaaw>
    <xmx:nmnRaGVWiwQkV2qk8oDks-mSus7AB9T0YPjtM8bf306BRdPCKzfqnVgL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0D34700069; Mon, 22 Sep 2025 11:22:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Mon, 22 Sep 2025 17:21:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
In-Reply-To: <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 22, 2025, at 10:16, Finn Thain wrote:
>
> Yes, I noticed that also, after I started building with defconfigs.
> I pushed a new patch to my github repo.
>
> https://github.com/fthain/linux/tree/atomic_t

I had a look at that repository, and I think the extra
annotations you added on a lot of structures have the
same mistake that I made when looking at annotating
ABI structures for -malign-int earlier:

Adding __aligned__((sizeof(long))) to a structure definition
only changes the /outer/ alignment of the structure itself,
so e.g.

struct {
    short a;
    int b;
} __attribute__((aligned(sizeof(long))));

creates a structure with 4-byte alignment and 8-byte
size when building with -mno-align-int, but the padding
is added after 'b', which is still misaligned.

In order to align members the same way that -malign-int does,
each unaligned member needs a separate attribute to force
aligning it, like

struct {
    short a;
    int b __attribute__((aligned(sizeof(int))));
};

This is different from how __attribute__((packed)) works,
as that is always applied to each member of the struct
if you add it to the end.

      Arnd

