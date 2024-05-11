Return-Path: <linux-arch+bounces-4326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604A8C3138
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 14:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02971C20B13
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9E755C36;
	Sat, 11 May 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PSDrpsSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUgEcDBM"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC941C60;
	Sat, 11 May 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715429854; cv=none; b=MxNpsiKS9nuPr9p5IzRe1elJ77Tu+yeKorRGtO37jHzXNgIcSlybavtivykh7R6LEfYLIt5Yix+hraoRRTOxSiZ6Ru2mVx7knCQVlDw6W3UnagYosdQBxziumVPzdcaKCcLZplO5suG3+sBULOivZBD7+1x2esf+GAfXEoOfwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715429854; c=relaxed/simple;
	bh=46W3fTICTGrthJr7L6elr6OVRTQPMvqGMm/y2zppHdY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LzqkL6BGjUdyew5iwQp6l9cfNucp36Eyt8IJmE+mfQ1PvpyTiq7+WTnrkR3sljfn+419uO6m/W6wOgKzQjeMG4JcMEg77PjP8nzJ6YjOqDjLqt6n8I7cGJq1VW0wIej8a9BZoJcXQfeSF0O1VEg5+urUNt1WGFGPQe5EPqjfNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PSDrpsSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUgEcDBM; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1F58C18000B8;
	Sat, 11 May 2024 08:17:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 11 May 2024 08:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715429850; x=1715516250; bh=nQapRunCIK
	PyLoW5EHEE6WHUzqa1pjN4Xbv9f+7hyYY=; b=PSDrpsSdf3q1bBScc2cOGXW6ja
	Wf2ByElBM+jEzneUaW3JS1S0pcIM221CuViyuW4d+9kiYzhGUIa5wH+oqzjh2L1+
	O16AyfHsUdG7+uGnqaUOK8Mnk9QG1MRn9QBtjDDfWubAQX1QKi0GmvWYYttcCsOt
	V0QV3vL6EVt/0xYt9mDlZ0nysGB7e3A/A/i2dvAfgq2xp2KNzXTV7DWaU4r4wZah
	nbXRyOpUW5xgXQcO5dKaDHMblUjtd+dMkkWXkkCdEtAY08+dazGaHV/xg+lP3Ls3
	YHF7nHSelPdmcX0Zn1k4/pj18boaNgiWl0a1M4hlSVrQPUv08WNUYphtY04Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715429850; x=1715516250; bh=nQapRunCIKPyLoW5EHEE6WHUzqa1
	pjN4Xbv9f+7hyYY=; b=QUgEcDBMZzJOAiGILsGp8xooIEyCn2bXuAq7L89TPiQz
	BhATkpCOM/Z1cxkuUuyB72zvMxBJv80CYW0XUCIyk9ImN/j+6lUeYhYS2jOgWpng
	W0LNzkB0XeYTYZY1C1MNpSlXz2IxLQogum5ACVxn8BYr6xRam3g8qYbIt65TzCE1
	IDaFmW+JfOFxvqIPiDc6eNdWX273f+Q/GC4bx5fuDJsDy+yU8cdt64Eg0L6yjnOg
	/YozLWo/HvSUloV2C/0RgsCfjMq3EJSQqUTGmAUdoMLZIi4SWqhRrwEsdn5Jsmx1
	txUtEeF/D4e1o58zvs330Qn+WOONmCusW2pt+JGz9w==
X-ME-Sender: <xms:2GE_ZlgLAmfczIt-S7tCCJ5LzKQF3szTaafMt1WUKq19M9zDceH-_g>
    <xme:2GE_ZqAAJr-SyEe5oN_J8RTLntADVgxlJ3as0T018Frcz3yNptrIjguAqTc7vqCpm
    n6Loi2_ce4r9wLeZks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2GE_ZlFcntK3Gc9FYDhIqY_m2s_Xz3t4-mQcGc2LFohLTBAIUJtjZA>
    <xmx:2GE_ZqSA7ZGFv5WeIdJTd0fOq9ldA-xro7igJtX103lg9RfucKBc3g>
    <xmx:2GE_ZiziJo_ZPQK3gPeyF_KS2zihuVU-J8JmwKowsjlrUYCNaJj4yQ>
    <xmx:2GE_Zg5xOAwGqaxhFsqMp5j-eu9kANNWirGoNXWe1YQF9Is0dKBJrA>
    <xmx:2mE_ZnpX-jLEGJ6Lf_YXl8eBx-F50ZrSvPJv20wZ6_6ruKDVkEZQf-aL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9F0A8B6008D; Sat, 11 May 2024 08:17:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
In-Reply-To: <20240511100157.2334539-1-chenhuacai@loongson.cn>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
Date: Sat, 11 May 2024 14:17:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Content-Type: text/plain

On Sat, May 11, 2024, at 12:01, Huacai Chen wrote:
> Chromium sandbox apparently wants to deny statx [1] so it could properly
> inspect arguments after the sandboxed process later falls back to fstat.
> Because there's currently not a "fd-only" version of statx, so that the
> sandbox has no way to ensure the path argument is empty without being
> able to peek into the sandboxed process's memory. For architectures able
> to do newfstatat though, glibc falls back to newfstatat after getting
> -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
> inspecting the path argument, transforming allowed newfstatat's into
> fstat instead which is allowed and has the same type of return value.
>
> But, as LoongArch is the first architecture to not have fstat nor
> newfstatat, the LoongArch glibc does not attempt falling back at all
> when it gets -ENOSYS for statx -- and you see the problem there!

My main objection here is that this is inconsistent with 32-bit
architectures: we normally have newfstatat() on 64-bit
architectures but fstatat64() on 32-bit ones. While loongarch64
is the first 64-bit one that is missing newfstatat(), we have
riscv32 already without fstatat64().

Importantly, we can't just add fstatat64() on riscv32 because
there is no time64 version for it other than statx(), and I don't
want the architectures to diverge more than necessary.
I would not mind adding a variant of statx() that works for
both riscv32 and loongarch64 though, if it gets added to all
architectures.

      Arnd

