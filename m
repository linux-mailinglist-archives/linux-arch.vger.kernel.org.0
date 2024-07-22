Return-Path: <linux-arch+bounces-5556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAB939534
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 23:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F46D281FCC
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B23CF73;
	Mon, 22 Jul 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbAL60hR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431D3BBEA;
	Mon, 22 Jul 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682531; cv=none; b=Xjw0JiC6MrCJ2y+AOlAYeUlb0RcmLo0GxHuAKieaJpuPSrk4OjUA+yytzNCi83nVpYlqcQH64EWA++mXNseHI45c94lnj83shQ9yMgR/vFDo3z4I8QbhM7fldnAyL57iADwHv8FTcJgDNM4qMvHFh8c58Si/0/AXSr5Gb3Y4RCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682531; c=relaxed/simple;
	bh=rE7aEKCzbwZUHlk8fbrMvxLRweJfCQHGkYdYVlezAKc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hdA4HfxhfnW2DiM5jn9KClOFFkCYepJbWZG0TFpLx1LupB/nnxufWp4E7FkuhlXmityFqy+sgJTOCA9CCN2tsQ4126QaphIaTtHXAvu+iTXfwZ0VYJP9rixks/YjAUUL6Hz6igdsa1nUOOiAyAKS0aB9P7oWuiJXEh/m0Tw+xL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbAL60hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19CC1C116B1;
	Mon, 22 Jul 2024 21:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721682531;
	bh=rE7aEKCzbwZUHlk8fbrMvxLRweJfCQHGkYdYVlezAKc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RbAL60hRpraqUoWNDk4vtOSIeOm8WIKb1U1fJxpm/NlJzoGY9w9wd7P3qJR02kYj1
	 XX16GPaOwRdIZ0k9DKWXY5TSCbHmUEwQqBah2NQofrbwiz9usDq6ek5Tpg7CkKOaVt
	 zf8l0dHHw268LvXT7Ude3yce2B5p0BsmW6AzaXrlNspSbjFueoAguTCXcvWF3+fPqT
	 6YDcUhZ+LwGc7Oxaj1A3Q123lEj84FzO0SyoG1LI9rHMrut8ZnNYWHe5Yhl+ckI9Dz
	 kFYBMYPhMA6U7hWy5u5kSJnx751WDX2bSoF6vMtsoHLQ8DXghXeTx7gbCE+HghaNbN
	 8CrgbtzXsMB+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08ABAC43443;
	Mon, 22 Jul 2024 21:08:50 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240722144822.4040791-1-chenhuacai@loongson.cn>
References: <20240722144822.4040791-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240722144822.4040791-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.11
X-PR-Tracked-Commit-Id: 998b17d4440b8559a8bf4926e86f493101995519
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a362ade892e3e4de69296cddb1a23a1efe701428
Message-Id: <172168253099.16066.4016457939625454607.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 21:08:50 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 22:48:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a362ade892e3e4de69296cddb1a23a1efe701428

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

