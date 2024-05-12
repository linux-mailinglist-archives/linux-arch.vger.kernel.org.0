Return-Path: <linux-arch+bounces-4337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C98C3560
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 09:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0191C208F6
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825D14F62;
	Sun, 12 May 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IWHYpZkF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R528yBLu"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FD3D6A;
	Sun, 12 May 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715500400; cv=none; b=oLxdQMhO2kj5QmSxIa/DolEM/G6NC6qVV7YCYTqlcIqdk5OvTtOreVxr3b26OxzcgvhBKsTJHaVLkp9w6pAtvr255NsSpKrndXD7Qn79sjXjsENu4djvM6gSxIOICVUrcVb5v8//PLt02NHQqkTHKZtf6iXI51rowYfBgcT5/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715500400; c=relaxed/simple;
	bh=G32PthKcIMwHOlkSEv+ql7S5hSRmLbPeS6AmqWGaEG8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VVIWQd2i3DhxsP3g7bBA8gr+tRmBqPDCoJhGfL2FtnzmJ7guBT1YxSJj9EPFijVDJdue//kXIVATtwUHC9xfVIZQIM3EumLLKjStpsnsh02Afju2e5Dbxxu1Cf/PveoJvh/EOuWj6bRN0NRnQfnOyu+LJ+3JJZRvvO4c2AtMR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IWHYpZkF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R528yBLu; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id CDF5C1C00195;
	Sun, 12 May 2024 03:53:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 12 May 2024 03:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715500396;
	 x=1715586796; bh=qkvLE2hnnj9QTESFKiTg5ShrclNoU8nl5K0MOg/ShQU=; b=
	IWHYpZkF9MbMCtAfW8nCtmSedLJaoK/FvVEPy543lIE81xa3hy7xqxVrDpk4sHcN
	5opFJmE0ZjexrAiz6GJbIGYufpi/nUnPZnlj0/mUkBLdo7ty5pmKjVMSwHYstcYN
	CASDsBjPuBwHQcpnGOTe3zX85DSG6AamySWPLD1h2HVGLaodFaoFoOclVriXEeNP
	Hoh0IviCD5GBkIaFFEk6xlJxZWZWg3UNrhibDQWYZY4fum9QRfGHgFm+JgAo2c1x
	zRX/xhhQpZW5+forrLnIl9Bj2ycuH/YvU2005Jo02HErXQmiB9wrabDrd1+7T5u+
	xOCBh9AwfobZ6rr+FCrfdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715500396; x=
	1715586796; bh=qkvLE2hnnj9QTESFKiTg5ShrclNoU8nl5K0MOg/ShQU=; b=R
	528yBLuuhm/CGTv8ufRb38zYxhAnYYur6J0CJB9pDiLZCbd2esi9e+l1gM5eDDWn
	ygcjdytUJgQqWfUP/PrjnpGaPpvtJ9i3La2fWyBC7vBcFwznIQFbCiavFS23mrcm
	rDvurobynOP6p8KgH3RQ+wYJTjjABFsYFLgqHiGbGt7LL1jdv9ifgFmfX9sLHUDR
	GyqX7NYxR31EIPNzT7YynWHEE59o1o/XK89UEC27r3QfbIPEBopClhWQMeC21UA3
	pqFdDPuWA90oPlFU5Q2iK6Gviy8qawBC5j5o88TS7EnDJEWWOMcHDLBaEi0GOEcI
	e+8R4sUKLDWahXYIR7OeQ==
X-ME-Sender: <xms:anVAZtgTwvuKQRm9GUStMLW5Ak-cAlj9HRki9p-c9L8rJOjlNTgF2g>
    <xme:anVAZiCfjHJBqdNwUGy1gRx4ZUZuW6EySA1P2QAomLu3wMQZP9n6j2G3qf-P-LMgd
    PDxmzA7hsEQjsQjFbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeguddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:anVAZtHYtoWzHifZAEStLM51wBHyvkDObwNmsV-jzRkXCfyTNTaZJQ>
    <xmx:anVAZiSDNZlEo75dhzu5CrNkvt-rMPy-fJLwxU0Tcu35F-ptupNw-w>
    <xmx:anVAZqzyDqn4ao1giOftgxEh_kl6x63Qb5DWJ6wZJrUEBBOTQ5Q7rw>
    <xmx:anVAZo532shZbNuo-hw9Q_cTPo25Wze8FfCU3v2DMGTqb_Qy_f5TSg>
    <xmx:bHVAZvqHBxEFTqAxp7llGHheMuEYb1ZqePt7x-EDAT7Ya6OC4z3V69xa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47EE9B6008D; Sun, 12 May 2024 03:53:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
Date: Sun, 12 May 2024 09:52:53 +0200
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

On Sun, May 12, 2024, at 05:11, Huacai Chen wrote:
> On Sat, May 11, 2024 at 11:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
>> > On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.d=
e> wrote:
>> CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
>> this is the only allowed configuration, while on others (arm32
>> or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
>> both 32-bit kernel and on 64-bit kernels with compat mode.
> I don't know too much detail, but I think riscv32 can do something
> similar to arm32 and x86-32, or we can wait for Xuerui to improve
> seccomp. But there is no much time for loongarch because the Debian
> loong64 port is coming soon.

What I meant is that the other architectures only work by
accident if COMPAT_32BIT_TIME is enabled and statx() gets
blocked, but then they truncate the timestamps to the tim32
range, which is not acceptable behavior. Actually mips64 is
in the same situation because it also only supports 32-bit
timestamps in newstatat(), despite being a 64-bit
architecture with a 64-bit time_t in all other syscalls.

      Arnd

