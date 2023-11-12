Return-Path: <linux-arch+bounces-176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD197E9238
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 20:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FB81C20328
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B3168C5;
	Sun, 12 Nov 2023 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F47AzYfO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB31641A;
	Sun, 12 Nov 2023 19:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63D03C433C8;
	Sun, 12 Nov 2023 19:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699816691;
	bh=YCASNaA9apHrWV6XvNG2YqzSqL/8KIldQaaqwKBZ+ro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F47AzYfOn+nHjmt3Jf95efOfK5jZ3Rw+qHtySAYGyP8aXX0NgdbBfpEmAQyuBoR+T
	 WMYwM/tZ7lwYikPZ5RZwJkQvtFec8PJHtcZnV3e77WVTh4hSgTgk5uc0BoiiZFq55V
	 aeUwqveKVScFZ6uKYDDaIEFyqZqniXYTahXwiebhtuukCOaPDFuNr1URpFSORTPTzs
	 iiX6p4Kh3Z3QktHOYI1bPdsGu3EbM5xBpFwUmvNJz4XGgTMhkQepLO4Ht3sLdO++hE
	 DHd64aG2qAhMMdulBpQaL48J5CLkYWY2/ihFY+99VqaiFd5cMznfz6vVETCycgq5vl
	 wVfw71JhLSMpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB96EAB08C;
	Sun, 12 Nov 2023 19:18:11 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231112051248.272444-1-chenhuacai@loongson.cn>
References: <20231112051248.272444-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20231112051248.272444-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.7
X-PR-Tracked-Commit-Id: 1d375d65466e5c8d7a9406826d80d475a22e8c6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eeee6636af819454d7c43702e77ec7857a63000
Message-Id: <169981669132.29349.8417024851700164619.pr-tracker-bot@kernel.org>
Date: Sun, 12 Nov 2023 19:18:11 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 Nov 2023 13:12:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eeee6636af819454d7c43702e77ec7857a63000

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

