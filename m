Return-Path: <linux-arch+bounces-12266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791E4AD0EF6
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 21:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206E4188FCFC
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BB1F462D;
	Sat,  7 Jun 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH3HOROg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0927701;
	Sat,  7 Jun 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749323204; cv=none; b=Paduc0piNU0FxyJKHL2wxqdtXC6OAIl8yC5yzyGY7tM4CLIlGNst5PgAmVJRzvgZo8aOZEApe6c+oQs7/sy1ABJAKCk93/KAlVUm79JY7ATSDD8grmNA5TK0m8wpHAc8MW681wy5imNEarMVQJK9N9SO0lXTnf9EyTXftMIA1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749323204; c=relaxed/simple;
	bh=B6hiwn9n4QqhTWvWABsCqEj9RUP7ArQnJmMyCxt1OXI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k8hIHit1gvWHVWLWsqFmoSmwaNUlUuAEIZryLVl4EZynsGXUsaNRdtv/JdJpOLZZ0qqfw7iYfogw4lDLXa+XSXAVP1B7ZQGRiPU2Bw3xjLP033EFJ+IAZXuarCkCiwNgcP5BmuhxEE3mFawM3vsCspVZcDprEbEBJ7LcnmY4aWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH3HOROg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55EFC4CEE4;
	Sat,  7 Jun 2025 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749323204;
	bh=B6hiwn9n4QqhTWvWABsCqEj9RUP7ArQnJmMyCxt1OXI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HH3HOROgVZdqrtNnVXKC1pbPuwhpKtVmDzxevG1UsuiMCheiI19v0rhDPWi3kwchB
	 JWltI50w+7rB7CbKbSgSAuz5kwWenC610mQSy3wUXrewQwj+UziABU+EM+/mu2Ti7Y
	 WBQgkAngx441Kp8OSnl0bMhXVyMkL7CrPu5R6lyUSIgsqR+ld03+95BGJeuy4hMhXJ
	 plYoby/WQos1Ag+sveCHLwgdaS+7/ICnDRt+62bcDyIcq7VbLPjXDNLUjFBqNYTvFx
	 ayB5fVSJVBrG3AFd05Drtq1LyPmzDl01td/L5f5dOJyj97Qf47ynqoXVO0DjFprROq
	 qukLVbXlpDjKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEA3806649;
	Sat,  7 Jun 2025 19:07:17 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250607141619.3616592-1-chenhuacai@loongson.cn>
References: <20250607141619.3616592-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250607141619.3616592-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.16
X-PR-Tracked-Commit-Id: f78fb2576f22b0ba5297412a9aa7691920666c41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7191581a973ab2fca45d2ca64416065f1660ae0
Message-Id: <174932323577.115837.11781895560877953391.pr-tracker-bot@kernel.org>
Date: Sat, 07 Jun 2025 19:07:15 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  7 Jun 2025 22:16:18 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7191581a973ab2fca45d2ca64416065f1660ae0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

