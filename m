Return-Path: <linux-arch+bounces-2727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F65867720
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8281C2979C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C512A15C;
	Mon, 26 Feb 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="acUP74UJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRfsMFat"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DF129A8F;
	Mon, 26 Feb 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955233; cv=none; b=Z6K3yXu5OadIBaPm6hHCu7Jvn+u3KI852ZzBEmMarrsS263kmFAma5tNrHkxJmFVbaC9bwSChLEPyIm7P+ZnIk9ZEUxNrx6Q4Hs3aWvaRqPcAXmanMJrVwepvIF9EmHXJC1VrCBPlx/PJaj6PiPcbpIZaP6PlVUZL4+woDkADkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955233; c=relaxed/simple;
	bh=eJjDKWoKh4iQaxPxySS728JDwYFeD/6g1kPRnb36634=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pF7zOiP42pNHrVZ8th0d6deUQekSaeOTK7W27GycrBpS9PZPKK2P/BfVDuUJyGC5TbcTt/hhCWkf0JNhBl+BgPlWvgYqPsvuo3KyRWYOV9zFgVKtm2ktE6JfcIRTN+MYtLjk1xcPAhXlekyhF0b77sBkD8QCwk7owwCffidy2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=acUP74UJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRfsMFat; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C35251380059;
	Mon, 26 Feb 2024 08:47:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 08:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708955230; x=1709041630; bh=a1PSlUV0gC
	w1dBpXCUcLNWCgd48YCMKuI96VEVuc7N4=; b=acUP74UJ+xsVl9E9SnUTFssEvv
	hMieduIVj8yuJdaGAFUU9SIfunAb0DIBLbXxah3BtLPd623MJbXj8RoL+/5TC82I
	NfXlT+Gmk+p8jARsKXRPJFHzzXSKB3r64IxkYjMLR0u9MOIRevWICrM/4b9STQQT
	6m+/qUd0gCJhHULjvmNK3AZ3AWIVJWIB5X9ngcJQvN0ncL8cp1IM9lLoI0y1w3qn
	+3VTPJEWmdXF6pL+6oNiejiUpbnIoX6C36Ix7qilg4D7k/72s3Zj3SQ/4eaCTXi4
	ZT2wcDAFPFG7tyQdac9xV9F1nng7ol98rjjXGxxVJ2hw6SpVu42Fimlsex2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708955230; x=1709041630; bh=a1PSlUV0gCw1dBpXCUcLNWCgd48Y
	CMKuI96VEVuc7N4=; b=mRfsMFatDH3J3fLd4ATDIdcusHzpzRiJJTs+97urpncz
	g5s+p7kls+KFvKm6+SvDHADqwMAK+rrQmaYp9SZ2VYutrviuTd00+iVN1/+gZpRD
	htk3Ejpk0X2KNHsbgOMZAmpgaHma4d1GE3gTnsaNm4k5b4d218xtWyLV/x5rqz8p
	HV1tCPLWaglNWl75jQMQZDmXMnZycxJUhrQnxZ9HWzurOSyddel6FcXzglVh72ky
	1wsHZC+rJ4yiDucYzjRWmG+xwfy8O6LbpVajks++dDJFcEUwThtglS3IIMYjm2nB
	J3MxFKvYNSVldPZURXtWQlfpAcaPYeQuYEKJyVjqOA==
X-ME-Sender: <xms:XZbcZR4G3DJi8fFm80olcVwb9SwVNeAm4K4QsHILs0q_C7TXd_WgJA>
    <xme:XZbcZe6qy0QHuOFDH0wQT-oui-WS7nzfodeH-dQCxKkJg275Nd6ZrXCnWMAST0JRP
    w9GPpkRtB7o6Gy2lNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XpbcZYfzETUKKjlWtt642IGujcU3ow5G5VEmD1Z5OG15D5Q2-KWf6w>
    <xmx:XpbcZaJmx5AbYUiBgzZuJyUSyyU-CnkEb2b1-h2u3oqgtXFLveRKCg>
    <xmx:XpbcZVIDuCArvpJnN0P9CasHHa_5yQ0jzurrjs_kbKY8xm7X0f-EYQ>
    <xmx:XpbcZXhzH7RT_3IGHoJHE5lFUcufsx4b3GdCw9cWVVHynQsN738mSA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D8D5DB6008D; Mon, 26 Feb 2024 08:47:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef732971-bf70-4d8c-9fe8-3ca163a0c29c@app.fastmail.com>
In-Reply-To: <20240226-graustufen-hinsehen-6c578a744806@brauner>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
 <20240226-graustufen-hinsehen-6c578a744806@brauner>
Date: Mon, 26 Feb 2024 14:46:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Xi Ruoyao" <xry111@xry111.site>, "Icenowy Zheng" <uwu@icenowy.me>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 linux-api@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, "Jianmin Lv" <lvjianmin@loongson.cn>,
 "Xiaotian Wu" <wuxiaotian@loongson.cn>, "WANG Rui" <wangrui@loongson.cn>,
 "Miao Wang" <shankerwangmiao@gmail.com>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Content-Type: text/plain

On Mon, Feb 26, 2024, at 14:32, Christian Brauner wrote:
> On Mon, Feb 26, 2024 at 10:20:23AM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 26, 2024, at 08:09, Xi Ruoyao wrote:
>
> What this tells me without knowing the exact reason is that they thought
> "Oh, if we just return ENOSYS then the workload or glibc will just
> always be able to fallback to fstat() or fstatat()". Which ultimately is
> the exact same thing that containers often assume.
>
> So really, just skipping on various system calls isn't going to work.
> You can't just implement new system calls and forget about the rest
> unless you know exactly what workloads your architecure will run on.
>
> Please implement fstat() or fstatat() and stop inventing hacks for
> statx() to make weird sandboxing rules work, please.

Do you mean we should add fstat64_time64() for all architectures
then? Would use use the same structure layout as statx for this,
the 64-bit version of the 'struct stat' layout from
include/uapi/asm-generic/stat.h, or something new that solves
the same problems?

I definitely don't want to see a new time32 API added to
mips64 and the 32-bit architectures, so the existing stat64
interface won't work as a statx replacement.

     Arnd

