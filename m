Return-Path: <linux-arch+bounces-5070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04478915FE6
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59C328128A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5DD1465BE;
	Tue, 25 Jun 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JI2NnhbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nii1oWgI"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9273463;
	Tue, 25 Jun 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300140; cv=none; b=D0QFeLo1woMP8D+s5IH/CHYFyB17pqZ+vfgzDzL/TycGVVXlFVimxVHhYJFKJgMxMF8L9xZUrcBeBd5EchzvO8Siaiz7fm19Awv8zsjjBe12h2E/VrgfJqFIMcPFAvjOhtUl4tiOEUNcd7EhyQnU1JoLJJvGGTdFr4RteLsfrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300140; c=relaxed/simple;
	bh=ZtgKERiIsUNX97rsswWKHrxmyaCsSAXuWBBDrtHwtnA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pwTZiGycCp529NS/m9Or1h85LLJhwiCjOvHL9AoAeDgrM65ONgs6t2JluKXoXk9UBUSbkMvAR3I6lcAmL6CzBB09+/LUHrLgqwlJY60Psn9dTSpyc21AfMQ70XMD+qLb37TQISrGUvySGzoLlR3bk2BvmWDQeJbgJZs0QZnVRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JI2NnhbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nii1oWgI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2AAC1380260;
	Tue, 25 Jun 2024 03:22:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 25 Jun 2024 03:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719300137; x=1719386537; bh=kqD1JVVmb6
	5kM+8TRypaMtMSw95vRHKsvANGjybyrPs=; b=JI2NnhbDiRz+XtaZOE/bmBmcC9
	y0EyY2llyKi6gdvjKx1r1hA/Sp+YxYTsh5R4n17kBIqknSQAROV1too416xz/ax7
	DnnBJG1hO25/CV60G8SSL08IsslBBeMnfT9net4th4Zh9mhvhU/DJsMRuhBNgS3E
	0VPlxU/h2WIqd5/h+xqpcLNb3FylkO5VgnBAm9vqbLiTkbPF6CfJ5etKz1Kdlz6g
	XsaFDZtzr86kr8O4geYi5FetIADdYnaQpvDBu55+vHHcrV8TKcnZhnAv95+sSFqZ
	lVTTKSD6ezB96+es6B2qbjQ1P3PHFwXreqGZJng2oKC/W4s7uWUK5KrDjiQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719300137; x=1719386537; bh=kqD1JVVmb65kM+8TRypaMtMSw95v
	RHKsvANGjybyrPs=; b=nii1oWgI7WMslQkPVOju+ij36Es5RtXqNHA9yKqnjG8A
	/6sHxHue9WXJ+9DOxwSzTPko23n5KXsoa6MuswLmoNWzrkp/0wwWs+HckTmyWvnS
	vFd+qTvwAua8fFc1olEPYCCyGr7lvmWs7tgKITHfwgjPqGBDu3kq+6GaGAcfil+N
	LRpbttIg9XP1FXvMTRN2LfjT0zLxGzwXnUv8OSFvGh//b/sWkrmRAPEmhfciYZHu
	OISRx6Ws2r+o/pMUq1MEsjtRh0KiuVyyZCKVUE51CtS/Shyj+r2yibWJVJFKZA/0
	2X2NzkLianjEFBwYul+W+025Fgof0A5Fm0c5c6mwnQ==
X-ME-Sender: <xms:KHB6ZgBifU8qyh7Hen9xqhrQWMmo0RsmL9eotuAMGFs1onD0HXFfEA>
    <xme:KHB6ZijWZB5iEGbnIvaynzSW5-TMdpen-UsUCXR4BLvZG7I2RjTuG-0dTnY3Vz_wd
    ErlBUsr4Fx9T_EaFcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KXB6Zjl3l50wSTwqFG8ioukc-g61PgCzgX01VcseaGpdWq4vmYO7FA>
    <xmx:KXB6ZmxlCsqMlCZDJLqUVWfn8MZ7ECDbrhSeaDpY3p-VHvVyycCVaw>
    <xmx:KXB6ZlT7X8HJgRHGH0q78K3BWOn3L8jDW0VFQpTffwcl_djQXWLfew>
    <xmx:KXB6ZhYXApxt0XgYZhF8A9lmJpDbOUWPdh0naveFocTcpqd6K7sm1Q>
    <xmx:KXB6ZmQ60H2urzdeAAEbeBLfc362BpSQsmD9KzkcaS9n3A-vmDQqIAh3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DADC6B60092; Tue, 25 Jun 2024 03:22:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
In-Reply-To: <20240625040500.1788-1-jszhang@kernel.org>
References: <20240625040500.1788-1-jszhang@kernel.org>
Date: Tue, 25 Jun 2024 09:21:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jisheng Zhang" <jszhang@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
Content-Type: text/plain

On Tue, Jun 25, 2024, at 06:04, Jisheng Zhang wrote:
> This series tries to optimize riscv uaccess in the following way:
>
> patch1 implement the user_access_begin and families, I.E the unsafe
> accessors. when a function like strncpy_from_user() is called,
> the userspace access protection is disabled and enabled for every
> word read. After patch1, the protection is disabled at the beginning
> of the copy and enabled at the end.
>
> patch2 is a simple clean up
>
> patch3 uses 'asm goto' for put_user()
> patch4 uses 'asm goto output' for get_user()
>
> Both patch3 and patch4 are based on the fact -- 'asm goto' and
> 'asm goto output'generates noticeably better code since we don't need
> to test the error etc, the exception just jumps to the error handling
> directly.

Nice!

I hope that we can one day make this more straightforward
and share more of the implementation across architectures,
in particular the bits that are just wrappers around
the low-level asm.

We have something like this already on powerpc and x86,
and Linus just did the version for arm64, which I assume
you are using as a template for this. Four architectures
is probably the point at which we should try to consolidate
the code again and move as much as we can into asm-generic.

I think the only bets we really need from an architecture
here are:

- __enable_user_access()/__disable_user_access() in
   the label version
- __raw_get_mem_{1,2,4,8}() and __raw_put_mem_{1,2,4,8}()

and then we can build all the normal interface functions
on those in a way that assumes we have as goto available,
with the appropriate fallback in __raw_get_mem_*() as
long as we need to support gcc-10 and older.

      Arnd

