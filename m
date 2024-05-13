Return-Path: <linux-arch+bounces-4362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4598C452A
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CB61F229AE
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D817565;
	Mon, 13 May 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LbgSsB3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgB7OxUa"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9315E89;
	Mon, 13 May 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618259; cv=none; b=D0nXBOunaXWJq7dslFV1Dc3FOv4fgPGBDvXrpM1GX0dm3Eu4W3L/RKwu26LKNzZdWakrhsEsjoeaRblbnKSZJ7pKIWdZSXY2HYJZKu02+I7UrWjmvyyzZAq2Hy7W9rqmx2yM+2CurWUDYck5WcYiAR54HnX1XuWwDG/JHic2Lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618259; c=relaxed/simple;
	bh=PbdGZ3TwKrbjrqFfabuEQkXoWTXqDP+9zPV11dHeqBc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rpJcJGpbh8CHO4EdrLajF7JXMMADd53+C38TSxte2deEfvaNg63IAHbtQSgYlZT/dxrQYcGVh2mRxQMdctdApuCMLzyDmO2slcnXopP7cT7FF8SWHVT16givPQh8qj8k9xIDr328s2g2AHHrgIkFZ5L+2a+520yrZGfx8ok60kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LbgSsB3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgB7OxUa; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 1D5A01C0013B;
	Mon, 13 May 2024 12:37:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 13 May 2024 12:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715618255; x=1715704655; bh=OLSvBVK4M4
	JqWME4JdbR1HCf22FXxhgdPQQXlahJrro=; b=LbgSsB3B1DF4InZ7czZPRbKrsi
	GrBLdiWNYGTbnDmLfaWPAuxN7MO6pEcCUNlxz6JuTrv5NjAnIY6uJ+MCojpR5N8l
	Fc12LpxcLP7EqiPB36b8d6wa8hxWbT5jRscoGeI/fzbPQK2VM9iLCoNkGLnmqdYk
	MNjmmkhRTUeJsjvFe+4WJx+NtbRKLtQsDkY8UlVBqJKtOiIbDkKhXGWwzPJcjZZT
	vBukDnPzn1uyqoXy9r8YCy6XinKjxgxm6LOdEuKFAas1n2LOAibWN6Q3z5tEerAi
	J0F001aC23C1qDGKM7fnaBEFJWGmfqBCz7HBiUnn4OnFhPoo8PapCqSnrZxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715618255; x=1715704655; bh=OLSvBVK4M4JqWME4JdbR1HCf22FX
	xhgdPQQXlahJrro=; b=LgB7OxUabV7db2HgVqqmHJESTeMk85/ZGbhfTXWK1AE3
	qOZhKJZceOBg7ua7bTD3A4TW6QBUXrADQH7EnZMPgMrsRlr6fKTvRpWMYRnY4jaB
	JcUfsK3hAW4VJvC+RSzAKTZfdT0NlCl5rqfHDh5c5wdo+HH+eMqXeUho3FMENrWA
	I/26hOznOdLn7+RB7MyEaw92M6e7fpUROiQLiA5Rx/Bd+yF/A3ufIJXtC8VhPpcG
	WlaHyM+qRUGIzqQ/Xj2ZNmNW/QC3PCurft2ORz8uTWVJ9RIQPOaPrkpbzRQs3NMU
	7X45WlQUc7zODLPDe8++j803Q4esH3KuX4Y68rzd1w==
X-ME-Sender: <xms:z0FCZqzm1_cl5OKjykPQqeaVlZn7O0ngTBRxDxmSuskZf4wsrANLUg>
    <xme:z0FCZmTbsZZM9so-Smg_XyNcYKXhyD7Bdn37c6cSQsswSYhYi5hJU0xtuf-PWEONj
    PcbkxiZNhNYbBA80q8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:z0FCZsWZZuSWFK25qMk3X94Rv9SkEnyRmVhotR01zV4bStUuisFWPQ>
    <xmx:z0FCZgjjVUqxYS9bjflJlSXx3vt4MhsPV4pGM4XCvx_S_5VvaFqI-g>
    <xmx:z0FCZsCeLkg-qdgOwgaDDd5OYEeeOyjOnsKlZhyK5j27K9qqr_TgzQ>
    <xmx:z0FCZhK0YPiu0g7f1tZcnBTVlGvzNP-VnWC-kaO6fvQJnq4h8nwAwA>
    <xmx:z0FCZv_trafq_oT5d7EKgbyRDn4R5wwWJXI7PbubnJmG4W08s8qBKXGH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 49756B6008D; Mon, 13 May 2024 12:37:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2182538a-640e-4d61-a159-7c8bd1779493@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wh85pfJiHPPTZpknanYf6_JDEVDo=tmvtvy-XW+S7_Y8w@mail.gmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
 <CAHk-=wh85pfJiHPPTZpknanYf6_JDEVDo=tmvtvy-XW+S7_Y8w@mail.gmail.com>
Date: Mon, 13 May 2024 16:36:52 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Thorsten Blum" <thorsten.blum@toblux.com>
Subject: Re: [GIT PULL] asm-generic cleanups for 6.10
Content-Type: text/plain

On Mon, May 13, 2024, at 16:11, Linus Torvalds wrote:
> On Fri, 10 May 2024 at 14:17, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-6.10
>
> Hmm. That tag doesn't exist. The top commit you mention doesn't exist
> under any other name either, so there isn't even a matching branch.

Indeed, I must have forgotten to push out the tag. Unfortunately
I'm traveling at the moment without my gpg key, and won't be
able to upload it until Friday. The contents are of course in
the for-next branch of the above tree (along with the other tag),
but they can all wait as they are all just cleanups that nothing
depends on for the moment.

At least it wasn't the arm-soc branches that I forgot to push,
that would have been more annoying.

     Arnd

