Return-Path: <linux-arch+bounces-7453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6A986C61
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41B31F257D4
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DED185941;
	Thu, 26 Sep 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eV621Oyk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YS9DE14l"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA91D5AA2;
	Thu, 26 Sep 2024 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331635; cv=none; b=KvPxr1Mak9KJE9anBmeVvSpH0ZlaqpSVqEnJQCCrmr4HE7/5rDd32KMDo2J/+e0Xst/xHpJjQ90lLixz1uvotGSIWdfRCPyME6FkMEuDhk5/E+Tfn2UtTmEMSK/LpJyTgWVx4bHICg88MCs/lb0Wkr6hshSKBj48UrANRnevk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331635; c=relaxed/simple;
	bh=K+lb9oE17g+Nkuqyar1OGX6Q5vy4YteBZOQIU6Hx3Os=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GgC4gnhPJILAXXfOzo521Gf+/9y3IooaF9ABECA19QY4uAbB5t/4E6EmVsovHjqQSSPPT1Js+t11FIzus3z3jEL1gG173OU0G2APvrrXsA1x/o8PkescCWxS6gm+Lfq23dNxwjwPIsRp9nGEKaSCaDYmEetYuO9wRx5dzMEzZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eV621Oyk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YS9DE14l; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D5E9138047B;
	Thu, 26 Sep 2024 02:20:31 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 02:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727331631;
	 x=1727418031; bh=oQnRU0axIiohza7SOhtqH++E2FBDOQIKGvFilOUjtms=; b=
	eV621OyknrNCy6xeSo0sV13rQCzVMl0ABRPtip0t6rJV/qzAixAqaZlXaI5Sn5ma
	M80YteuI/h3Mq2BAVtVdYJR/tvEmE5KWH4gysQhYQAouJ7My0BNs4U5NtU3cp9RJ
	WBo2wBYGlwWAoMj9hAQpnJRKp1b28id5XhuY6mgFfZjtmMh9w6g9VE6D2y6NEJTk
	uwjaWrnCdgpPJLVF1lkdmEKqvubMcncvtxwYLNK4TKRwoJxmeS7PV6X9Ux8LlZ18
	Ur/GkhD5UiVN056gFjkNsIpgYzVSymVNxFgwg6za/hE11RpyhgkEpqhESElTxoPA
	TIMKBBkU0/Q+tpmlvHHMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727331631; x=
	1727418031; bh=oQnRU0axIiohza7SOhtqH++E2FBDOQIKGvFilOUjtms=; b=Y
	S9DE14lOzEVazQlx4Nw+2e1a9YkqjEhJvMLpCDL7JRPWIghu90pJU+lj5odDpGus
	WT4x0K6kzaA5N9gfdXlkHnbVkgyZ3jkDgzMa2VBi00RH+5wALqgAg7DQLcOLEthv
	g62FR2fan3uA7nFw518aCkJfuMun9zD4QpTYjGnBQ8JE4Q4SSaKsOea7VBSCgy7i
	3lk3DTFc/l4uu9ugxnR0CPaa1wXG7k2nXmWKRcYZocVyXlK1YHBsS5F0eJJlNQH0
	urBVRfgGl1icsZRpignSAXmfzZENHqxGabZqhcjeoA51t571EQfI4oXZne4rMiRR
	xgr6fob7qEC8+Q+gt+kQw==
X-ME-Sender: <xms:LP30ZqOLjFDJsFPiUXU0_7mJ4Jukr9M4Ul6KQS-rGqN5yoNblg5aDQ>
    <xme:LP30Zo8Chu3IG4-13LNC9XH0R1gjv6rxEMZDT0ojjPRxBniuhBKzSlzUOuPlWqnMX
    tVSo7egh-BINsVd_9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtiedguddtkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Lf30ZhTpj91WtFbOBJdFr7iTOhY-SLKb_nLv2F6iihiZcwX2jWyJgA>
    <xmx:Lf30ZquhAR0Wgr6re445FcjlSzg2TcD-RSxfN4RtF8JWHaahAVltHw>
    <xmx:Lf30Zic82WDz8ODbV5FeMshpAghSu7altRLAu4iyFz9Tb--nX9OJ-Q>
    <xmx:Lf30Zu1CZC-hb8PIeEpXwEoJ-j1MIC3U1sl4CSjbDAf9BTVkII_ROg>
    <xmx:L_30ZvBMFfY7Fw4CyBTDqn2qkCP6alkbTtLyb1mFtkbAXXpTECkShTXw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DCAD02220071; Thu, 26 Sep 2024 02:20:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 06:20:08 +0000
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
Message-Id: <35f002ae-44bc-4887-a7e8-c00155b6cf7c@app.fastmail.com>
In-Reply-To: <fb5f8856-5753-4b2b-bfed-82b3e3cd589e@csgroup.eu>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
 <626baa55-ca84-49ba-9131-c1657e0c0454@csgroup.eu>
 <fe23745e-a965-4b74-863d-9479fdef239f@app.fastmail.com>
 <fb5f8856-5753-4b2b-bfed-82b3e3cd589e@csgroup.eu>
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024, at 05:51, Christophe Leroy wrote:
> Le 25/09/2024 =C3=A0 23:23, Arnd Bergmann a =C3=A9crit=C2=A0:
>> I agree that moving the contents out of uapi/ into vdso/ namespace
>> is not a solution here because that removes the contents from
>> the installed user headers, but we still need to do something
>> to solve the issue.
>
> Should header inclusion be reworked so that only UAPI and VDSO pathes=20
> are looked for when including headers in VDSO builds ?

I think that could work. Not sure how hard it will be to
get to that point, but I like the idea.

>> The easiest workaround I see for this particular file is to
>> move the contents of arch/{arm,arm64,parisc,powerpc,sparc,x86}/\
>> include/asm/mman.h into a different file to ensure that the
>> only existing file is the uapi/ one. Unfortunately this does
>> not help to avoid it regressing again in the future.
>
> Could we add a check in checkpatch.pl to ensure UAPI headers do not=20
> include headers that exist both in UAPI and non-UAPI space in the futu=
re ?

That is a much weaker check, I suspect it won't actually catch
most regressions as it's too easy to ignore checkpatch warnings.

     Arnd

