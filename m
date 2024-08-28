Return-Path: <linux-arch+bounces-6732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A2963163
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 22:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004B8284A71
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5FF1AB50F;
	Wed, 28 Aug 2024 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="L5CkIwdX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTaZv7iJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8773AC2B;
	Wed, 28 Aug 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875313; cv=none; b=nr3dIZVxqBNiI++n1R0YA6j6OkXpdqtQ1n/yAi+J7wYfB1Jp/xUm5kSkDBaiq+ybCh8PfGgSQL34Bxs2mfKe5kuewXTD+vLEJR/ZaxpZ4P6ak5bayZdM8q7BAfM81wOFzffSxFxE8MB0veNPyyzmq0DzWp/3Z+JaqvGwZBz406A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875313; c=relaxed/simple;
	bh=F/DqEhIax/SEgiB7bpr7KLFZzIj/Zgv1gdYBSaDykp4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FzUywbckp/klF+EugUZSORNmsD6qMKpgjdwHgYjyslHB/yTwnuojJgqS8qodTHQmWvwA2NXlukdBsDiH5tC/+HOEwsRZhwdUyqkQSWpwkoUAMakxQqUFCkA2H4FYqTaDBnslCHHt3dl1EN/5eD3f9rH1allhNS3CbAsA9WNVISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=L5CkIwdX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTaZv7iJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A6F811140557;
	Wed, 28 Aug 2024 16:01:49 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 28 Aug 2024 16:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724875309;
	 x=1724961709; bh=ed7LujsTpZKV3Khr/dqL+Zy9OCqu4p5alag84yh45KA=; b=
	L5CkIwdXM0+wNYsjcmZIdZY/xOxo8EIBpJwkJ8DT5RKcsdZV67qbDGGyjbHXWf4Q
	CZgXm+d54btaVAJ4MC1z+0IURoR0dJV07KloBg2oVbKyTM6ko6TtFv96nVjFPtqx
	MFt20zKTk2Ep4+AO380q0w37JdYL34uVBqDsB7j4pn3d4G081eiq2APq6M6RLkIs
	A+hTdFq/UX2teguAKUB6Dl9iTGEPzqcARuUvsueWwFG+GrNKaNgjtR10UEZc+eh6
	nFsQyLt2XqLfOQ0C+vEwfEzlzMTJhBgaGnyH1JNkmwHAmrfxDpCkpy+9Ywc2dH4I
	cc65GtwAP9YZRtQcgiTV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724875309; x=
	1724961709; bh=ed7LujsTpZKV3Khr/dqL+Zy9OCqu4p5alag84yh45KA=; b=e
	TaZv7iJt8kh54ngKSp9jc8NGjd2GWsOydeF1Xs3LyBtOd02kaYHLzm6JZPlyaLri
	/4EwO+sM+vfunP7qxhY5TZEQuHbHxOZiljtUpLAf54Zkm94uGLl1irD3UzsTvpdM
	Yo/8hzq6eG7qphDTp8lnhCxMwV6x0mcE82C2v4MiqnL/1PsER4zk9cU9W9szAtX0
	2Khhc8j7ZhLlqrQwooaRUKsxvbJbjDw1Ph3IlabaRNcZslOUKquu+rC1U1pg5C86
	qnWmyRvxi5O2UN/kN/nvPiicPGwCdpWKPLs8ioH5otv+/vn6ywbG6a9gXuzH7vUG
	KN4fJZ1jqLnGL3wrVE3iw==
X-ME-Sender: <xms:LYLPZuz0PdbqzpOrAvhRoPJVM2vgNj8Z8zUGXUeNBoK0yaPPoagWbg>
    <xme:LYLPZqRs85tFtWW_duYTuUYi9npPNFFfkwY7jpWAQZAivG_aJJHniF3REOTVarWaq
    9EHG9YQOJ6YH4uLcFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:LYLPZgXy0HBp5HSdX7RSDmd5gqV3y-Hb1XXEwHJue6MZutegI4abjg>
    <xmx:LYLPZkj25nkPEJHy9BqCer-qgAiBa7PnTBWlOUMh3Y2pPHh-jJgLVQ>
    <xmx:LYLPZgBRPx_mw603Wf78RU6yq9uIuis4DuOx1dNXczN_SFr_gQQBPA>
    <xmx:LYLPZlIZol0pyadOzs03CaAsRvVXAYonVBiLhnt-jDeelJjU1Vc98A>
    <xmx:LYLPZjN-Q8y_0fcnhmUb2Gx2_eePe20swxasINj0z2UtLU7dV9R5pzr->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5D7B52220071; Wed, 28 Aug 2024 16:01:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Aug 2024 22:01:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <9242c5c2-2011-45bf-8679-3f918323788e@app.fastmail.com>
In-Reply-To: <289c7e10-06df-435b-a30d-c2a5bc4eea29@paulmck-laptop>
References: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
 <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>
 <289c7e10-06df-435b-a30d-c2a5bc4eea29@paulmck-laptop>
Subject: Re: 16-bit store instructions &c?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 28, 2024, at 14:22, Paul E. McKenney wrote:
> On Wed, Aug 28, 2024 at 01:48:41PM +0000, Arnd Bergmann wrote:
>
>> There is a related problem with ARM RiscPC, which
>> uses a kernel built with -march=armv3, and that
>> disallows 16-bit load/store instructions entirely,
>> similar to how alpha ev5 and earlier lacked both
>> byte and word access.
>
> And one left to go.  Progress, anyway.  ;-)

What I meant to say about this one is also that we can probably
ignore it as well, since it's on the way out already, at the latest
when gcc-9 becomes the minimum compiler, as gcc-8 was the last
to support -march=armv3. We can also ask Russell if he's ok with
dropping it earlier, as he is almost certainly the only user.

>> Everything else that I see has native load/store
>> on 16-bit words and either has 16-bit atomics or
>> can emulate them using the 32-bit ones.
>> 
>> However, the one thing that people usually
>> want 16-bit xchg() for is qspinlock, and that
>> one not only depends on it being atomic but also
>> on strict forward-progress guarantees, which
>> I think the emulated version can't provide
>> in general.
>> 
>> This does not prevent architectures from doing
>> it anyway.
>
> Given that the simpler spinlock does not provide forward-progress
> guarantees, I don't see any reason that these guarantees cannot be voided
> for architectures without native 16-bit stores and atomics.
>
> After all, even without those guarantees, qspinlock provides very real
> benefits over simple spinlocks.

My understanding of this problem is that with a trivial bit spinlock,
the worst case is that one task never gets the lock while others
also want it, but a qspinlock based on a flawed xchg() implementation
may end with none of the CPUs ever getting the lock. It may not
matter in practice, but it does feel worse.

      Arnd

