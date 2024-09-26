Return-Path: <linux-arch+bounces-7460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C05987702
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656101C247F3
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321114D71D;
	Thu, 26 Sep 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oZbewdzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4XWuc41"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15712157E61;
	Thu, 26 Sep 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366099; cv=none; b=keO33JJK6mKhDWjWAS9k7hffSxwUr5d3f/jVZ/V+5oql66S+fi1ZllKcULq0iktM4pXyUHJWmVU0TQG1GOVwsCc/KMN3Ep2DVtwlsW2qYO2oPuI1IF8UOC6rPSUlToAe+TCaZfIPII5Dt5pTdFv2sDauqkjUpdCfbZLQvs05kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366099; c=relaxed/simple;
	bh=twA2+SALUOhyeFR9FN0cgNWVIJqUtSMvTyk2zz/BjTA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=eTVROl17VGyV4XWHs9dVqjzQ/B8KxULPmA87nz5CJ2JoUTqAyi6453cOsMaqt/LE89TWsjWulFFHr1Egh5SSEpJ2lPin69HPc43UZ7SdVXT1giyp1i90TpCYW8SObxz7ADgLi7Tb62yf4K7ds2GGxEg9tG79omiIs68Mh9Ug4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oZbewdzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4XWuc41; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC3C1114013D;
	Thu, 26 Sep 2024 11:54:53 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1727366093; x=1727452493; bh=8K
	TBLfdNCi0vrYhuGw+swyskUGnKNV0IGv5DVWRAyno=; b=oZbewdzy9OmcpwkwWI
	d/bVgYWIWB4sU+yUdXCye/I2eSS78FkbuJL+p5vSuaMdO75ow3Y2yMyvS327BUGj
	6tFTSxxX9m+ZX09A8VRjQRs85pJ+qssN+9iscyYKzXxYLMaSi784w/WB3qqS+Sec
	2btMB4OFb7iL38EDl7bvKdbf+kidmdgBXdHr9cf+kgRnm8MQhDIngdyI3ph0u5St
	audDN2bX61GWhzTfOZy7AbANADmwJQbdFZQgvV5SFDcUdNZiOk8A7InEHMmDoAvA
	xttAkSxwynqpFik2AY9NMlJkedSDEk1GnLhvj52GLda1XHEQs0O8u/5/2GpQHMbY
	pnfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727366093; x=1727452493; bh=8KTBLfdNCi0vr
	YhuGw+swyskUGnKNV0IGv5DVWRAyno=; b=i4XWuc41xNu7EyVIruLtWB2DAKNUs
	SWO+pKMXDzGOVItle4FkWgBkPTQF/8u5fyWuwJMtZqe0anvUEJPqiOV414L5EEDc
	yCL54jFCTgSWuRl555v74le/Ilc3ZHLYhYpFgitqbmsb7GazDKg9QoaYeL+obSE5
	BeG0DaXSsOXh6YRcEbct0pRQDpADK5i3V2a7R5FeRoGhak1kvbdlAGhlr5kWmMHO
	caEMZ7gHEA0PdTORR7rQwRSxTq8yXIGV0PvYoV2nxmHwHLYB7MIbU73SigYGMY7r
	ycuAEIljnMXmPSzh9fVTZkVBxQPNoRqtCM4ePp6IFeMZ7CPGnrD2+aIyA==
X-ME-Sender: <xms:zYP1ZpMpscEGEHVo8LdRu3G2tjHQyQTJ5-mxURMCrPs_Y_jbGfXdeA>
    <xme:zYP1Zr_hQrlw7NUgXxKIFQKNTBY9P2u6S-Gf8QIsdlVN__Aawo_HFwkl3y0QS47Qt
    iD2MvUaaiV2O5SyTEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddtnecu
    hfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvg
    eqnecuggftrfgrthhtvghrnhepudelieegkeevueegtedtjedttdelgeehhfdvhfeuheet
    hfduleffuddvueelveetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtohhrvhgrlhgushes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrg
    hrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivg
    hnihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:zYP1ZoQQwK3MIcYcBK9_NYKst0JqhuiN6rzpv-rRdVRLdOSJverxzg>
    <xmx:zYP1ZlsMMYCXvRar3A8UDSP8PrU_o8NuDwoVQKCljsGEH_GeBR9nOg>
    <xmx:zYP1ZhfJIzA0-9tdjvl44WXIWBB77E9EY6gqxAnmw686hqG4R9RgGA>
    <xmx:zYP1Zh3lAXq4qT1995BHjvqwU-cQETBUANFsvknVgqIQeAQFUbwN7Q>
    <xmx:zYP1Zo7YEKTUPe18ltRUyniC0JZnL__znnZRcS6q6TEqUBFXFltQG0j5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8AF3A2220071; Thu, 26 Sep 2024 11:54:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 15:54:33 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Jann Horn" <jannh@google.com>, "Al Viro" <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <3ae425d4-1cc5-43f8-84f0-501d31938a6f@app.fastmail.com>
Subject: [GIT PULL] asm-generic updates for 6.12
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.12

for you to fetch changes up to 92a10d3861491d09e73b35db7113dd049659f588:

  runtime constants: move list of constants to vmlinux.lds.h (2024-08-19 09:48:14 +0200)

----------------------------------------------------------------
asm-generic updates for 6.12

These are only two small patches, one cleanup for arch/alpha
and a preparation patch cleaning up the handling of runtime
constants in the linker scripts.

----------------------------------------------------------------
Al Viro (1):
      alpha: no need to include asm/xchg.h twice

Jann Horn (1):
      runtime constants: move list of constants to vmlinux.lds.h

 arch/alpha/include/asm/cmpxchg.h  | 239 +++++++++++++++++++++++++++++++++---
 arch/alpha/include/asm/xchg.h     | 246 --------------------------------------
 arch/arm64/kernel/vmlinux.lds.S   |   3 +-
 arch/s390/kernel/vmlinux.lds.S    |   3 +-
 arch/x86/kernel/vmlinux.lds.S     |   3 +-
 include/asm-generic/vmlinux.lds.h |   4 +
 6 files changed, 230 insertions(+), 268 deletions(-)
 delete mode 100644 arch/alpha/include/asm/xchg.h

