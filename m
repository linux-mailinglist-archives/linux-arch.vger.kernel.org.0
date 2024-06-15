Return-Path: <linux-arch+bounces-4912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827B909802
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD7E1F21A92
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E783C062;
	Sat, 15 Jun 2024 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WSY166vp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0qc5TkJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D725774;
	Sat, 15 Jun 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718452061; cv=none; b=eDwc2Ads1cznf3IDmJ68Ep82HUmWEDO0Zq5kK4ltsIpBvr5oFZw8A8nzl307dk3Z0MFQ0Gsc6il3NcBHPZnBFN4f0HJ8GWRUyCQH3+/dsPqdJ/AOM9lo2p1DjnwYgRvYx2+i326H1pGyj6te3jTZYUvtBHNzUkFmGbQLWm7S3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718452061; c=relaxed/simple;
	bh=7WFE1QqjkNWXBo2i/uISfGXGpLvGQFIrguU2M2BpI9c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JlL2hbSlc8kkJOPqiod5BKDT6aabk776t5T2J5AIeuIAJEKukSasQVQcw2OBYiz1jYBQ8EQP5rEFaXLVVugIvhx01p/B4ryZgH2OjGYsuQVfOzeD2WUcDcQNPiYqUyh7G/EUO7D7JRBAbMQ41aHbQ1dqyMT+YT4I5efODatc5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WSY166vp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0qc5TkJ; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B76E91C00111;
	Sat, 15 Jun 2024 07:47:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 15 Jun 2024 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718452057;
	 x=1718538457; bh=bnFVDSz3OxRpFnBtZdMfpJNAmQeOJsJhGART8of28Ss=; b=
	WSY166vpNpojltqzOj7XH+S75QcBVaezUQWiOo19qzkm6jpk1oiPR1QhfMSooslY
	c4csVweaRlm8moZSjmt842Rvfzsl6h2NaVq9wAagNEZ0E/J1NN5eHpmGfoZQcTRb
	jJGLMaKo/NM6oq1lBwIR5eEbKePRTEtKqgOOyZWqR+cKqAhZ+bA8j6HAqq9rnSDQ
	Yj8xynsfLWy4J9DwzV4SytW+leCyaUadbl73VT01/bvG4q1DTQd+Bc6jzYOfsXUp
	PhQokkd9czwQBy5/vC9uYKZCKSVlZkcZzAENsZm0GREVOkqWo7NKT3WbFIELnHJw
	U1Z/qsMlOwJGjQGbglcS5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718452057; x=
	1718538457; bh=bnFVDSz3OxRpFnBtZdMfpJNAmQeOJsJhGART8of28Ss=; b=R
	0qc5TkJnd5xpnX0qb4uWYAhfv4ctpPNk2TyKgZqdDogmEmf6iiCXsvQI4n9iuGvH
	t6PcKhlEoCIB+i6MCmlg/JYP6aXvPK2jdTZdDPyDukCHhqa7EIQdzgLHy9PDDrtY
	lH6hWbHmV5sQCWjYRDN4K09omQhiuwzE8Q1/1P0Qc2qE2J4Dl+VoIwqg5RuGYYHH
	npeApyLJb2JlogBGKvowoGadzPJWHLMw9EyEBLjt8gdr2hSxXmF/oyHDdyyIeqf4
	ACVt+6zJJ7vW14fJUh1+r2jHA+6HwZqi16R+AHykb2QDAP8cq47qvpbGT4zYe0R6
	XajT+GpUZCdXiwOgf8KOQ==
X-ME-Sender: <xms:V39tZshhr3tkZMmGqJ_XJhsRivjgFHOPYYgxHR8gB_izTURpAoz-9A>
    <xme:V39tZlBu3Be0kg8UwyleTnl92r0AadsYkeoH-l4nVPDy95zapF4uw5A_4eP6fj0m2
    7Un8iokmhffb5ShTAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:V39tZkEwFz0vkEMF9MHxoxqDOWBrkboTI7z5uBer5A9fUY6ZvV8HCg>
    <xmx:V39tZtRdCfeRYJpbkmU82QduPjfRZdTe0gcz3-xaqYGchcV2AVhfEA>
    <xmx:V39tZpwv_Sym9RUcKjbvPxSU7-om1y4-LD_LZL8uoUNkSe52uyYFyw>
    <xmx:V39tZr4JSk2jltltPq05jd34jISN-QV6VScvPZAgnwiK31GLAlE4Eg>
    <xmx:WX9tZv4HjhyT6kxUqbOglzK6qe2IVl3eami4zaHPcIzpPJcwpd4Of2pa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BDC87B6008D; Sat, 15 Jun 2024 07:47:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
 <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
Date: Sat, 15 Jun 2024 13:47:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>, "Xi Ruoyao" <xry111@xry111.site>
Cc: "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024, at 11:29, Huacai Chen wrote:
> On Sat, Jun 15, 2024 at 4:55=E2=80=AFPM Xi Ruoyao <xry111@xry111.site>=
 wrote:
>>
>> On Sat, 2024-06-15 at 16:52 +0800, Huacai Chen wrote:
>> > Hi, Arnd,
>> >
>> > On Sun, May 12, 2024 at 3:53=E2=80=AFPM Arnd Bergmann <arnd@arndb.d=
e> wrote:
>> > >
>> > > On Sun, May 12, 2024, at 05:11, Huacai Chen wrote:
>> > > > On Sat, May 11, 2024 at 11:39=E2=80=AFPM Arnd Bergmann <arnd@ar=
ndb.de> wrote:
>> > > > > On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
>> > > > > > On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd=
@arndb.de> wrote:
>> > > > > CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
>> > > > > this is the only allowed configuration, while on others (arm32
>> > > > > or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
>> > > > > both 32-bit kernel and on 64-bit kernels with compat mode.
>> > > > I don't know too much detail, but I think riscv32 can do someth=
ing
>> > > > similar to arm32 and x86-32, or we can wait for Xuerui to impro=
ve
>> > > > seccomp. But there is no much time for loongarch because the De=
bian
>> > > > loong64 port is coming soon.
>> > >
>> > > What I meant is that the other architectures only work by
>> > > accident if COMPAT_32BIT_TIME is enabled and statx() gets
>> > > blocked, but then they truncate the timestamps to the tim32
>> > > range, which is not acceptable behavior. Actually mips64 is
>> > > in the same situation because it also only supports 32-bit
>> > > timestamps in newstatat(), despite being a 64-bit
>> > > architecture with a 64-bit time_t in all other syscalls.
>> > We can only wait for the seccomp side to be fixed now? Or we can get
>> > this patch upstream for LoongArch64 at the moment, and wait for
>> > seccomp to fix RISCV32 (and LoongArch32) in future?
>>
>> I'm wondering why not just introduce a new syscall or extend statx wi=
th
>> a new flag, as we've discussed many times.  They have their own
>> disadvantages but better than this, IMO.
> We should move things forward, in any way. :)

Wouldn't it be sufficient to move the AT_EMPTY_PATH hack
from vfs_fstatat() to vfs_statx() so we can make them
behave the same way?

As far as I can tell, the only difference between the two is
that fstatat64() and similar already has added the check for
zero-length strings in order to make using vfs_fstatat()
fast and safe when called from glibc stat().

     Arnd

