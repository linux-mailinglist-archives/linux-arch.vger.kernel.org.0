Return-Path: <linux-arch+bounces-382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6317F5072
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 20:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86C22814E4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920115C91A;
	Wed, 22 Nov 2023 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZj9WW0e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF05C902;
	Wed, 22 Nov 2023 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4577DC433CA;
	Wed, 22 Nov 2023 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700680618;
	bh=V+bcEHuaoT0QO1L4PpY2MsEghTUZNEpjix34EZdyApg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rZj9WW0ex44DdDLUe4dtr+cE5Zc8RXL/V/i0eiQRdwCJH61zVPY0GkGkO/6GeBgY7
	 s+jwiE5TjVU11PFWqdxGrvs/7Th7T7BLul83EqutTQLAih22EF1o2e+YVZdpo8StdL
	 F4RcudE22Lbx8/Cyg4vHSSBAEPHND6a39QQI7ysM5m8PQG8uL8qoRtwdPK+hry3c7x
	 ov92VwKJOp0esc7vFWwUh+/h4x9y93acAyl0JyiZdgQ2ez2jhiQuVfd6kOnU+CDbSl
	 QaBUtxGnDZPTtftZKtFQLS1bOHBp0a1Qd36iiMIKfC6kzOj1j7Z8UgpO5BZOYd4eBN
	 dOPUJLXyn5RDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 311AEEAA958;
	Wed, 22 Nov 2023 19:16:58 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231122151245.1730120-1-chenhuacai@loongson.cn>
References: <20231122151245.1730120-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231122151245.1730120-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-1
X-PR-Tracked-Commit-Id: c517fd2738f472eb0d1db60a70d91629349a9bf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b6de136b5f0158c60844f85286a593cb70fb364
Message-Id: <170068061818.6718.7703537633390907893.pr-tracker-bot@kernel.org>
Date: Wed, 22 Nov 2023 19:16:58 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Nov 2023 23:12:45 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b6de136b5f0158c60844f85286a593cb70fb364

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

