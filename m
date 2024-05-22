Return-Path: <linux-arch+bounces-4492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F058CC600
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592771C212FE
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B86145B02;
	Wed, 22 May 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpjtqO6x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCF8003B;
	Wed, 22 May 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401113; cv=none; b=ZA629MMJrKsfdI/cAPjykl+URUjZwS66RVYSQRuCCK/X8hVaqpVkg7UJ7Q+uTolTUOKm+vt3zrZvP3yFdoDQVznRk4+yG+c6kwTqxIVCw95ZSHfeXwXiMEPau/ErGnZVirj4bgvSjL0w/OYjGA2TbCnUw2zvk4WPsBeWyvezpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401113; c=relaxed/simple;
	bh=CeI2EzAoofDaKVhhYpNbdJogVjReiPBySX4uY/BCtN8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oUCFQtyF/tNcOJa0poHcJO+MQa76x/Ehez3DbXBpot5I5zaQCaiuQwHdAYEe7Of6MOUmUCt2xfYkTHyeJ2yNvGuL2iui9nseZyWaQ09rSx2NrV2wwu10ZUDLzV7EJJJ+gHTnnHSxOrRTGSpxxk0CnIGW2EEaJIxLSGrqa9n1/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpjtqO6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA179C2BBFC;
	Wed, 22 May 2024 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401112;
	bh=CeI2EzAoofDaKVhhYpNbdJogVjReiPBySX4uY/BCtN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dpjtqO6x6XYXFWJvUnrmxuXu+AANuWcCt10senHjUYhZ5CLS7NHXI9KViGXJCy66i
	 SeBj5PHys5BTwP7k3isqPwPCur9TpMgUuYphI/pl0O0/9JbbamJPH2AqLCyv0Oa81o
	 Pd2VsYyF5YAPI3LTnWSho8UQDDiJQtOP6a3tRNkvji7U6XFo16FdSFXimmEj/IgnYC
	 ynG/lG9npfodMEzusLPKXqhsHBTvriKq77J8pf6PJoTqSGtyzZ2cs6k2HUlvcrOcoU
	 +t2chzxRsNLaK/h13eN8mW7fM0tlpfr/D4Z2oY0ZRVcFH9sp99ZRXWwdUQFcrGVXbs
	 zbtl9k0UI15iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0FE1C43619;
	Wed, 22 May 2024 18:05:12 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240522140504.4071402-1-chenhuacai@loongson.cn>
References: <20240522140504.4071402-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240522140504.4071402-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.10
X-PR-Tracked-Commit-Id: 9cc1df421f00453afdcaf78b105d8e7fd03cce78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f05e82003d1c20da29fa593420b8d92e2c8d4e6
Message-Id: <171640111284.25247.7584430807190924004.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:12 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 22:05:04 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f05e82003d1c20da29fa593420b8d92e2c8d4e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

