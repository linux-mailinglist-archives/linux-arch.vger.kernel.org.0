Return-Path: <linux-arch+bounces-4148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884278BA297
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AE285A15
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7F57C86;
	Thu,  2 May 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XpEDIhln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqYcEfBJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F51DDF8;
	Thu,  2 May 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714686647; cv=none; b=He13dzGMDOzlyHIZp5WoEFLP1/QRV+AxMWWhCBwt6pKCGujUdL3PXuZfX+4X7oj2paazXkAc4WzweGoLhkapDS/SN1MHuO27qHksQLZkaW7ZPCwvBpTMQqo9d8GmpjIu7JWkvP3knwIzth1RlU+WpJ704SoQnkTOAy0JOSZVito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714686647; c=relaxed/simple;
	bh=Jed1AV3CR49t4uVWxKmzdIyhNPvwZTczj+PGto7SL0U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZJ4/cVJHZHvkAHIWDQq1eGBfrsFmPmBgYtdiExaWRinCEUDwXL2JgyoJYvMICl+UmbQAE7i6uft7eKGZkotuAVwHv/iArnkOQHh+Edit3KtVTpPDgk1GGTZ2vvTaBWDszXD/8sPS/liAzzZwVF0OGWIgujX1cJKcfS5MAMVqr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XpEDIhln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqYcEfBJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B8A15114019D;
	Thu,  2 May 2024 17:50:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 02 May 2024 17:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714686643; x=1714773043; bh=2xEr8h3gVE
	JjoI3V/19V222CsfqNzPh7c1A+pTfcW+0=; b=XpEDIhlnx+gGfH5QINmQXyIC1o
	pQFGmEXk/ULgFP3Js0Q0bKj8GYAVG9I544Hq30Y6jonL54NKwZQQtL11WD+SJcnB
	yz8EBYLyXl0cvtdQLa9etSzJAhJ0hoB6BKmj/qJLoPw4htv7CrO4UfakihPPRdMd
	C+ZMTDOMRxLeHEtqNNeCWzDBCHRWV3We6NTyseBe5x/w5p9ZBOY6fZE80WBwMks8
	jUSvSXPQQDWBigS7eteelP178i3IQdntfxaLHZOFIhSCySg/9/s9ikUC178Ijci0
	52KActs94Iqx4gxOr8aalrIN8WLd5J1c+ST/fikWm9/2AFyu8g9PtQgqXOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714686643; x=1714773043; bh=2xEr8h3gVEJjoI3V/19V222CsfqN
	zPh7c1A+pTfcW+0=; b=dqYcEfBJj+XlXwR4w5HyWGrjeevy3Xlmyyx+4eVMZo/s
	8lyPE+uQFIRvpCVQSCds9pfdU9SAumLlCN+8ErTurQzMLvZAc6MKOkEQeLtiPy3N
	4Yk5/zOELWUjbvvjqYuoT+ICJmkzUnqQ40i/5ySV77Qkcfbkj6ArxbMJ8GyiKCTU
	CfewxGVzhP/raBsQbC6v7ajQja0uUW61nYrLU+Ws6eciLK1sncJsHbdaN4vMCNom
	JNliaqgFZUxdBdzZRX5wxGqVIekjRZAy/WTV9fgkcO/8JzXKlxLHkXBPHlvWXZoq
	zFtYXPDYhvfdFUlbdvg75MzNxbPoTpvhHe35CpAr0Q==
X-ME-Sender: <xms:sgo0ZtJNV7xOum_0SyBfFZaftwnJl7jrB6puXbKT33iaFdn5Kn3Zmg>
    <xme:sgo0ZpLqpMIcMMYeEWMCWGCUb8pmyegsfhnfur7nTJe3hEnCumTgVnNdNaia_KHlL
    usvG5z0arjNzeibl8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sgo0Zltk79zBjJMu8ABYAS7v9CNi4U9CdCChMIN0A0DKOitU4toYMQ>
    <xmx:sgo0Zubo3tjszCMexsJo1oVmeonYW5aOVnnmqqR0EtwYG1rq44HdFA>
    <xmx:sgo0ZkaScwAnhb101P0bzTrtIDgginbtCyTWHl0buOzPYBdF8lpI5g>
    <xmx:sgo0ZiDIDhTL_LUW_6zSSyaJABNmHrzf36PfrQ2VqiusQJZvKuAkWw>
    <xmx:swo0ZkL1ID9PR3Xoyf3yvOE2vXxIn9rmwF65xTpI1Lwd8Fx35BoEZJKz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B1E5BB6008D; Thu,  2 May 2024 17:50:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <989112a7-c12a-40be-9c0d-e516880380ad@app.fastmail.com>
In-Reply-To: <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
Date: Thu, 02 May 2024 23:50:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Marco Elver" <elver@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Doug Anderson" <dianders@chromium.org>, "Petr Mladek" <pmladek@suse.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>, kernel-team@meta.com,
 "Andi Shyti" <andi.shyti@linux.intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, linux-sh@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Content-Type: text/plain

On Thu, May 2, 2024, at 15:33, Paul E. McKenney wrote:
> On Thu, May 02, 2024 at 07:11:52AM +0200, John Paul Adrian Glaubitz wrote:
>> On Wed, 2024-05-01 at 22:06 -0700, Paul E. McKenney wrote:
>> > > Does cmpxchg_emu_u8() have any advantages over the native xchg_u8()?
>> > 
>> > That would be 8-bit xchg() rather than 8-byte cmpxchg(), correct?
>> 
>> Indeed. I realized this after sending my reply.
>
> So this one-byte-only series affects only Alpha systems lacking
> single-byte load/store instructions.  If I understand correctly, Alpha
> 21164A (EV56) and later *do* have single-byte load/store instructions,
> and thus are still just fine.  In fact, it looks like EV56 also has
> two-byte load/store instructions, and so would have been OK with
> the original one-/two-byte RFC series.

Correct, the only other architecture I'm aware of that is missing
16-bit load/store entirely is ARMv3.

> Arnd will not be shy about correcting me if I am wrong.  ;-)

I'll take this as a reminder to send out my EV4/EV5 removal
series. I've merged my patches with Al's bugfixes and rebased
all on top of 6.9-rc now. It's a bit late now, so I'll
send this tomorrow:

https://git.kernel.org/pub/scm/linux/kernel/garch/alpha/include/asm/cmpxchg.hit/arnd/asm-generic.git/log/?h=alpha-cleanup-6.9

     Arnd

