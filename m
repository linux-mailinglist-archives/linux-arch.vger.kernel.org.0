Return-Path: <linux-arch+bounces-2715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D2862696
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14ADD1C20E4B
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705F487AE;
	Sat, 24 Feb 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2CHmWNC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56B482FF;
	Sat, 24 Feb 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798258; cv=none; b=Ay/VvB4gQ+hpANF3/DlFEtOxGo5jdsR331AZtKteswgNAORKwqy8D+zi9UYEOsABS/VYKKuK05FzOhUR8+cH/z1Qk7zm3A0ucVxuOiXWJKKLU9yxmYCo4glicgYbKOqcXzSgVhg4/X1wsnXmQ8VHH/S+tg1OAmX3APavjlRuDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798258; c=relaxed/simple;
	bh=cKLE2frE10g/jnQBOG3Q6vxi1SDyxJC2YrF/juwRXjA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fd2ieD1UiCarPDk63jjNxnh2ls5PBnocmcrMeBiHytSfl7mjVu/5BqPvmDQBl691kkduvE30Ta6FHTUvNO+FMnibXMiAle2tv1n4v23YQRAdlA6/DylvXcvociOstuwvCR5dAwD0DQVdVM6VdNIIq0DfGzUvpqMSqA3ri9CRqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2CHmWNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CDBAC433C7;
	Sat, 24 Feb 2024 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708798258;
	bh=cKLE2frE10g/jnQBOG3Q6vxi1SDyxJC2YrF/juwRXjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q2CHmWNC+eEYKIrx1HQQHnodzUfx5EMbWp6wVZ7kUxAIsgM856bB2ZRh/k4mk/qHQ
	 WJpb/6wb2Un5AQ18zlapwxlvAOqEPn0k3srbiLTeJYrbIOfNZdXQYqReGkKavddh3Y
	 5B2oLNeBByK4NAHNg79vWH5hrktaJKdXO9ADC9UQUJJ1rG94G42aNsNGOdlldEnew7
	 CR5kguAT1VW52RRbgKOqp6quWb23741FdCecAk5RL71HLtN5Pfjq98C0QZ893i6noe
	 irsICo1s9Y+Ldfa0VSsHrANMNeCnAQJTLsDfHMcdbrqkPqxgFydhol4+jizBlO+QeM
	 Yif+ABuZTCufg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5055C39563;
	Sat, 24 Feb 2024 18:10:57 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240224085353.2066777-1-chenhuacai@loongson.cn>
References: <20240224085353.2066777-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240224085353.2066777-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-3
X-PR-Tracked-Commit-Id: f0f5c4894f89bac9074b45bccc447c3659a0fa6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6a597fcc7ad7335a3ecf8f5287a0459f793a257
Message-Id: <170879825789.13456.14605436156498956205.pr-tracker-bot@kernel.org>
Date: Sat, 24 Feb 2024 18:10:57 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Feb 2024 16:53:53 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6a597fcc7ad7335a3ecf8f5287a0459f793a257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

