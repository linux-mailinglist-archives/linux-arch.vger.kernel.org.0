Return-Path: <linux-arch+bounces-5434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9E93368F
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510A81F241E4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D0E574;
	Wed, 17 Jul 2024 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TxdDuVHB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iy57Shj+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997A11712;
	Wed, 17 Jul 2024 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196128; cv=none; b=mTnueleeKqnK1VoAGdf62pU82ateQr+NV6lFBgh6GweBHs2lHHoWddQ32uH+EWYuVBvyy9Om7rlfuc8nKobBzVTtdSRSkKmgx6dJonrV+7k888FdiGfrKIoIaORwmqvOgJjTXIvBCC4TIy5ijoiYyzk6A23Tvd5t3tGdglxS4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196128; c=relaxed/simple;
	bh=f+RmEIUQ9VSi19cek3Sz+RL9dW4upJpc7vO2wruJXm4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gVrXA0Ge1GI4Ac2TaXlFd16s5/07KBWNCRXCgTyILoRSCcuJU7U472ol+qMATuUrE/TBWdZQN+yrcAcmxs6Bl3m4SCgtoLyIZ8Sbq5gkhdmwkGiEcA8d4J658qQwL0h8v1qxAcJV7IWZn+YcfnB5QoUxRc0qA7qzPhFaIKTQLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TxdDuVHB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iy57Shj+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EC27B1380273;
	Wed, 17 Jul 2024 02:02:05 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 02:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721196125; x=1721282525; bh=s7KuyIqvIg
	I/k+6qXPqK6+K+0ILQ6zny5br217rA/cg=; b=TxdDuVHBA6pP2KAS6CIrwvUNlj
	eXMZnKZ+s+Gn8e+mTrnqEfd3NAq531VmO+spYY4WHFjdYiG+C0y2Cv1oulqJJRug
	McSGhGS+vxIisP70kd+QUSRlOB3S7ek2fTIWs26QCd6BMdXbSLv+ACLWaWgMuw0G
	LLGbDHxb+ODAv+sDkOn9aqHsW2iNr2Lg+ZEcGzXMoHYcKhlqYp15tK7N4Hc1WaXR
	gUIVDRnOtEp1qc7NJQGQGSR5Li0/mw5cJod3ROR2NZN0Cei1VvlkD1lENVdytYKu
	FbMTlh3kfQkKWZHXITUqcAXJJut8/x4bfsLPIQUDM4oKNeI7lRlbfHal+eDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721196125; x=1721282525; bh=s7KuyIqvIgI/k+6qXPqK6+K+0ILQ
	6zny5br217rA/cg=; b=iy57Shj+rMMq0tgL8F/b4GYe9Nu5PqrGYSCT/PbD9M5/
	0KhYhe473tb02Gs5inSJPVoB4lIH9FVQdHR1oyz4lo2upKFXmc4nYOYa4teAaq3V
	R07LkGrhuYforttrNu0XCLMZSeUNJEpz/k4KREfn6ajhuNuibkmPzv43lt8VN0fT
	i1/a+8BEL5wXsZXK+ilbEO3bXZ1UMllWfAeWH0prDPs6T94pwOc3Z0fIUcrsW9vV
	tcGWgiFRSV016P+CaygIErZsVUq2BBziw/u7gEZ+YeJzlA6fIwJf89RcGeh12UkR
	uuW2Y+5Jhls8ywPxJYPKGMpaYqjhZJXvBZsbUWZFag==
X-ME-Sender: <xms:XF6XZhASZKRtrx88hvmEqjeC4Joes9NXX9VPo9GyHKgpJNnVSx266Q>
    <xme:XF6XZvgsjLXz3zi9oGV7g2tyYzXvEQ3w8lyegGX3eEuUoarepzwpZNoCIqdAKQySy
    3eS9905O-rjWOG_Zq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XF6XZslNFrl7P2PNLVmEzkv4YrLUeV64nc8FBVEyYKCWGTO9AQBDRw>
    <xmx:XF6XZrwgkSDQ7vjyFVOvY8HBHZdrHUnFS9hU3NzLrC3z-S7q4FAgYQ>
    <xmx:XF6XZmScx7LJyMWu_IbYlUK4h8k_-ZMJQyTixDgUXprSjJv-cP9rag>
    <xmx:XF6XZuYKltr-lNPOmRWTppGpWmh6NWQqxBsewHtt7h0sujRWIzzZRg>
    <xmx:XV6XZn_oX9nmRr2w04j_4ZetEq37mOqIJ60LsUeH07ay06T4PzvAJjt_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 83D2419C005D; Wed, 17 Jul 2024 02:02:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Date: Wed, 17 Jul 2024 08:01:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Masahiro Yamada" <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

On Wed, Jul 17, 2024, at 07:08, Linus Torvalds wrote:
> On Tue, 16 Jul 2024 at 21:57, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Note, it really might be just 'allmodconfig'. We've had things that
>> depend on config entries in the past, eg the whole
>> CONFIG_HEADERS_INSTALL etc could affect things.

I had tried a partial allmodconfig build earlier to save time,
did a full build again now, still nothing:

arnd@studio:~/arm-soc/bisect$ make allmodconfig -sj20
arnd@studio:~/arm-soc/bisect$ make -sj20
arnd@studio:~/arm-soc/bisect$ touch .config
arnd@studio:~/arm-soc/bisect$ make allmodconfig -sj20
arnd@studio:~/arm-soc/bisect$ make -j20
  SYNC    include/config/auto.conf.cmd
  CALL    scripts/checksyscalls.sh
  CHK     kernel/kheaders_data.tar.xz
arnd@studio:~/arm-soc/bisect$ find . -newer .config
.
./arch/arm64/kvm
./include/config
./include/config/auto.conf.cmd
./include/config/auto.conf
./include/generated
./include/generated/uapi/linux
./include/generated/autoconf.h
./include/generated/rustc_cfg
./init
./kernel
./lib
./scripts/mod
./.missing-syscalls.d

This is in a fresh worktree, doing a native arm64 build
in the source directory. In case the problem is related to
changes in high-resolution timestamping, I am running
a slightly older kernel (still 6.8) and I'm using btrfs
with relatime for the build here. I also tried on tmpfs
now, same results. ccache is disabled.

      Arnd

