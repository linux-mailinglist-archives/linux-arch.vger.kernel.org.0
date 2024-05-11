Return-Path: <linux-arch+bounces-4329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B428C322D
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A80C1F2188C
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8356472;
	Sat, 11 May 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W3xYMTQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9s0hzG7"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2985645E;
	Sat, 11 May 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441941; cv=none; b=kt5IyfwGvscpDR8TWevSPBA3DK0Bw3a2QmnS9zk1t7uDguK+UPn0NDAycCT0fjW7R6BlQzdWFuUaSOLFJLxNIyadPD42W/jBGXCVQ+XFUdCQ7fOAivXiF4GfVwWTMucujzpPGHICYvJD79ZaowniynLhhhWoz6eeK4iybjx3JcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441941; c=relaxed/simple;
	bh=VjHyt4PxjoG0E9okA2UFHhBH4xk5VAMX/pgWQymeuBA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dBLMc/E8Qs4EFGmwxQER6z//PZAJ9Gj5r1bJaH0LF8rfW1ZfYaQmGC0XuC6fs18c84EHmqWVfI/gCuw/0LoWBo/h6AUlFPh07yJrLpQOKIyDco9hHShlb3gYVHEc1tgBNQpAtoiqnXYzwmXNRW3lyZ9/8idFZaus5uWn32/hx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W3xYMTQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9s0hzG7; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8A7821800132;
	Sat, 11 May 2024 11:38:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 11 May 2024 11:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715441937;
	 x=1715528337; bh=8b8AVLMPdkUb+D8MVCXQcH/74dxje6vo4/P3A1sCtUY=; b=
	W3xYMTQ8Cu6R/MGafIQnLV63habC+ESIvbsmHH2yv1D921mzlAQcWjsCfrRrBTz4
	Iwz1pG6MZ5xF+/00K25sblSah+NR7xgHcoKIjjwyVR7JnqffYXG/LdSdbARppVcy
	YcPs+lu8D3937lyK+P+Skhy9m8EaZH+oszDqMZz7eye82ks51kKhX3CK/tAa7lT2
	HlPYhWL7kg6gSMg35L4XvfNaMi3wb6BbrHmTudMBRLuUyiCLhpJmMQfNDKk4YQAa
	grSXPyGl6nIW1HSZDFfKX1kUNaHch1GrOTIKiOmMurzUWVLGuE1m7X37I7srjOv6
	Ve1Vju6g6vjU0B2QMklCDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715441937; x=
	1715528337; bh=8b8AVLMPdkUb+D8MVCXQcH/74dxje6vo4/P3A1sCtUY=; b=L
	9s0hzG7qX7xl6mtn/ErqXc2WlD9Tw1tOe5z+ih5mad3pUPpu2KqCEG0dNQOkLjJI
	AFSIOzg0xM5Zv0ktX6NcFoSpogUcvolpdwZbBCZ7HRB51cezuiIbbcqYiSqoyXyM
	fFJsxd3nSK/okbyuEEHQ/WGcUGuy7llvZwIP30T19J9xCyuWxSrEWRAJOr41lGwu
	AOoUEge1eHP+PYxZLm1G6d8nWAnMxYG/scJbHdCx7SdV/4EJzrEGzFSNsYF1A9J/
	5DRDNkKJWhVEMWWSxFihS0k6pskANMEsd1AMfd7XUfcxQtzLq4AaSpUtxu9lxH5O
	JK0VOOPIJu0TKGkPd51Pg==
X-ME-Sender: <xms:D5E_ZkW5aNg6cbgExq6yeXV-nz6s_gF3nYkDE3cC2ByOrn3EXayklw>
    <xme:D5E_Zon8nCSUsrV47b89x1rqiO5zUIKvMMQMH1B3xtupdw5bytoVbve8jPj2N2WXQ
    lHA-B-1a04Z_8YdpCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:D5E_Zob0ZjV8-6kjefM-s2_--mSstfXe0jNLdYD7asSr-F7EclvBsA>
    <xmx:D5E_ZjXt8SBJiO8SGgszIQu-26WYAofPGMycAbf6wLl6JNtcdaKFTQ>
    <xmx:D5E_ZulhP0E0e2d9kwwYkMr7wj1PBKdtrtXsZBBJ0bh-HHy8345IGg>
    <xmx:D5E_ZoeipotAVfkg_RP02iG_yw-cFZXqrVjXuP16bWKTE2sJLSL8Tw>
    <xmx:EZE_ZndA1l2C30DLVL-c_8_tv19OHNYF-xbwQ0TsD_RfQq0KYNyKIUbN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CE5DEB6008D; Sat, 11 May 2024 11:38:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
Date: Sat, 11 May 2024 17:38:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
> On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:

>> Importantly, we can't just add fstatat64() on riscv32 because
>> there is no time64 version for it other than statx(), and I don't
>> want the architectures to diverge more than necessary.
>> I would not mind adding a variant of statx() that works for
>> both riscv32 and loongarch64 though, if it gets added to all
>> architectures.
>
> As far as I know, Ren Guo is trying to implement riscv64 kernel +
> riscv32 userspace, so I think riscv32 kernel won't be widely used?

I was talking about the ABI, so it doesn't actually matter
what the kernel is: any userspace ABI without
CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
this is the only allowed configuration, while on others (arm32
or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
both 32-bit kernel and on 64-bit kernels with compat mode.

     Arnd

