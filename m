Return-Path: <linux-arch+bounces-15025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01505C7B7C3
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 20:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A54E7851
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783902DA779;
	Fri, 21 Nov 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu0naeHY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36A2BEFFF;
	Fri, 21 Nov 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752841; cv=none; b=mGi+yNqyrTNP37Sa253s/D/UNBHx7metBLzT83R0cX1PJpOkvkFa5E/xrBsPJssweu7WwJL1W21VTFrRzyczpMNeA3a/NtR3t/JZ+fXActVEQJVAFGgFBTRmB6vZEYDMyJOs4+9BhIAqY1yxusMBZkOrBbEQ3/T1vBoyEz5hR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752841; c=relaxed/simple;
	bh=GTTs23Zs43093tENcBFIO3pFkxnkUuTH1d9p8vwfxMQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ck/ooVZdfvNhEBVZ2wpUWfJnl4LTo7bfHBfhA1wkSja1e+TACi0lm8myCon8oabJVzTHbLO0YduA7Kv0nF/EmuW2yuTAWmvub+XiKGkmOJlu45jtNeAclY/z77h7CT1KDPQ9llXVgIuougKgyb83fKYaZfnnkSDleF1NgZA05xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu0naeHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D148CC4CEF1;
	Fri, 21 Nov 2025 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763752840;
	bh=GTTs23Zs43093tENcBFIO3pFkxnkUuTH1d9p8vwfxMQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lu0naeHY6u0BTKSkKiV1HhpMgZYlcNjImmwCtwuEa7VkvyYixS9DOb4bmiS3VQVA3
	 4gdfj41J1xQpnl6XmZh7EMiIDGQIrOAk8+q0dzM0OI3Ih54lmD/p+FzuHnTnIbpvcB
	 mNc9bdUeiJ1scKZezCOOnSqYGJTBMsRCgXBX2TfUiop5iERARn7YDaffL3TERjDDfH
	 2uAeG8MK7aqedMaY/js3PHPzTAak6esewcF3rq6CHXkR8U8hazGCGkhoyWMmdNUyJT
	 4TN2rkxrOPW6NqxIOiKaYIUofMoO3+aIeJaniBwN/ulxjGKYejEwd+uLKUG8wlCMRl
	 mGacwHkOSsjDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE66D3A78A5F;
	Fri, 21 Nov 2025 19:20:06 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251121153747.3337264-1-chenhuacai@loongson.cn>
References: <20251121153747.3337264-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251121153747.3337264-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.18-2
X-PR-Tracked-Commit-Id: 677e6123e3d24adaa252697dc89740f2ac07664e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eba5e05d9bcf4cdea995ed51b0f07ba0275794a
Message-Id: <176375280524.2554600.2124837165806548787.pr-tracker-bot@kernel.org>
Date: Fri, 21 Nov 2025 19:20:05 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Nov 2025 23:37:42 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eba5e05d9bcf4cdea995ed51b0f07ba0275794a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

