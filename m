Return-Path: <linux-arch+bounces-1740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDEE83EF2F
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D81C21EEA
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA42D052;
	Sat, 27 Jan 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho7zQpRj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E42D04B;
	Sat, 27 Jan 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377933; cv=none; b=uxV9a3BrMhKa/gsC6Ht/U8x3hIFzLc/mk2e4WfpDub+yFuZx6SjZUvq8xJLAAPJyAic0POzEoHH5X4NSw9B4KyQa1/DVUmtj0bjPXoeaHYA/iWXrmpt+qXh4YUcHusiT70Q90I1KcvOKsf5AJNuMcT+qlPI2egU+pbMGbuCQXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377933; c=relaxed/simple;
	bh=cHUMv9BxHgjuTEkUZtkOw43yclWbhFewLbNmc9L9s/4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YabZDrGG4Z8JnniryjyzgdJCuz5BKXuPSoVaUNf9IqFXWcn391ofIiOb0fhyleS3Ed9nM1/A09AykxnRbs9sJBWBF9bM4aETIrbe53JvFEY6P16ymSnpD/WEEt02nGd7P+WgM0AevfUBwQrpmYCV5i8agvtZNOoa6f0ddEt2hBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho7zQpRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1825CC433F1;
	Sat, 27 Jan 2024 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706377933;
	bh=cHUMv9BxHgjuTEkUZtkOw43yclWbhFewLbNmc9L9s/4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ho7zQpRjTX0gyri29QJKmbqX4TPUzRrHZQwfONV6aJe2zW3ikbnY6WM0+icfQE0zj
	 782rtegjHCm0p3qwOsuOZWbTi5qAN2W6HD3qQgKBtU/wWsKE03HJ2YlmbGl9Dl3Jkj
	 0gbkeVxoLCq8T4KyxQAF7m1nNv2sH/+fZHOcJNPaTE8dBm4RYnN6E7AFO7wkcxnwWt
	 Un3ibMNcxvK4iAiUlUJ1HG7PWKmy+I9FVbuYUdSIplxfUo+ACZy8iLULfROA2XIMn9
	 NQsGYpaiuW4DDwLYDPsgiO4T+R+L9XP4DluZIbOEcu5D3B1JisbWxihnGEKseGZxEQ
	 MwcMX/lGRafXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04344DFF762;
	Sat, 27 Jan 2024 17:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240127081412.810197-1-chenhuacai@loongson.cn>
References: <20240127081412.810197-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240127081412.810197-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-1
X-PR-Tracked-Commit-Id: 48ef9e87b407f89f230f804815af7ac2031ec17a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 955340433a7926ab80838e904814461598adcd8c
Message-Id: <170637793300.20657.2907853438443954078.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jan 2024 17:52:13 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jan 2024 16:14:12 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/955340433a7926ab80838e904814461598adcd8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

