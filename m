Return-Path: <linux-arch+bounces-9260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A59E5DE5
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 19:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68601885AA0
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A3322578C;
	Thu,  5 Dec 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMl3rzoO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B98225772;
	Thu,  5 Dec 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421868; cv=none; b=tyxyokIQMm7PKvz7MMTptdkksO7IzTbBWvDSFLXOgTFhX8X4Givht2CWacb/MkYxyb0Pp9IRw8sTHT3E+mOuVw7PmuM4Lf3jRg/3yKi36REyshKCi7E4kZkTP5YWinonEJmVGPORIUfp3FdYUZz/xeH5aFjwfgiQJCVndn0Jtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421868; c=relaxed/simple;
	bh=cqTQJsqIDntHz9ubpEhHjYIZ/DxpDB5vielwTC3wsVs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HGEHHadbWCmGcOQRduBOnQM8UBQoBnppAPEfuxTJp7ZAyfRmZfmOiddquTNm6X14XpuDipnNotsYvzCsxIzMRUq8ZhgLvqDngBQA5KYwDyxz/JouzhYdzsoC6ASVRuHK54tzmN27DrZ+NrRK5u6HxX0MraN8iZ1zjiPy/fZZm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMl3rzoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78870C4CED1;
	Thu,  5 Dec 2024 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733421865;
	bh=cqTQJsqIDntHz9ubpEhHjYIZ/DxpDB5vielwTC3wsVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BMl3rzoO0xq+PCQvGptSbFfI5SZtwcaSI2C9H3t1lt6b1OjAAqMkiRBQaIOc8uODD
	 OSmzrInNRJBHSPnVHncD2L+Qd576NrA9jTtO72PoKZqzJk9BdFTCnB6odRI52kf2d7
	 y+yRwSrayL1jtkKuNQBfeyB1rB+jjVT2ozEjr/kt8CCBzMO/+UPPHcVhJ6g6Dz8Ash
	 TR6rW3I7yofaRhwrFWrh9TwJb4j1sX31E7v4GeZQxT6SHV8J/Xz07WwkvptgHCdUvN
	 mYsrPdv6lSJVL4LCzPoGQ0lyPfRQtnRf5lf3EpDEiFRLtec7nqgN1S4ko3Ycibhf5P
	 lDG/1YYUlIa8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E11380A951;
	Thu,  5 Dec 2024 18:04:41 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241204141818.2091423-1-chenhuacai@loongson.cn>
References: <20241204141818.2091423-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241204141818.2091423-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.13-1
X-PR-Tracked-Commit-Id: 7f71507851fc7764b36a3221839607d3a45c2025
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5076001689e4f8b6b178c40d268ed2ecd2eac29d
Message-Id: <173342188008.2011200.16588416920794919491.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 18:04:40 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Dec 2024 22:18:18 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5076001689e4f8b6b178c40d268ed2ecd2eac29d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

