Return-Path: <linux-arch+bounces-2114-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363E84D0EB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F111F285DA
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211712B175;
	Wed,  7 Feb 2024 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDADnC07"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621012B15D;
	Wed,  7 Feb 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329331; cv=none; b=mLnazkxXPYiCG/MjjVkq6pLiO1nQlfhVOmYWa0dRfSdR7xr2zMyGaGN8CgV52VvpVGJF0ZLXj+j8Ci9sHz+35oTMd4XNjRlz4nAh+Ag9KzgbLiZKZ6Ib+JMpHMekpqZSluobEJ0OFwQGKNP7H0bVo9P39dCUinlRiHR1E5nTWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329331; c=relaxed/simple;
	bh=YVGw57OtAK5zBdIGrEi7tz/VsEgsPoy2IrSnNQ2b0aI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uwgdVk6KMw/QR8To5uG8fg0+ejNGi+iZZ9Hxa/ixm6IkHz1NGYUfg4V+KyrF+eAdUD25amVQ6uHDUXwwhpp0DLH5C6zrJ+m+G5xGTvg0I5g3Gl7Yrqm4QB+x5q/+x0OjTGzfgFWTzkERza2CAOnCZy4vJYP229TtvLCBk/eR3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDADnC07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A053C433F1;
	Wed,  7 Feb 2024 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329330;
	bh=YVGw57OtAK5zBdIGrEi7tz/VsEgsPoy2IrSnNQ2b0aI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pDADnC07xA8I6szpY3WSwXLnAYhtam9rUJRgcRLHFxcBrLtMfa9v3h7r+2Ea8fR9x
	 Yijzo9/lrUToctR9gIdOM/AMtDQzN1Yl2MBGw7VuacoO6jm1povJnUUbsA51w+mUKj
	 5DSD5wHRqGccWGoFnRyzyVtcRJ5+16jNKKs909lLFMTxxhOMdkC+2qw1bdsTUQ1kxg
	 NVsnmxMtK84V3syc3Rv0fAFqO80NjsG4zwETxTvoXrQNxHXuKdPm7jWIxzN98Jzhgh
	 TysJdK3DyQj7Rn2yKDDNjhVF5jDLdUR3sRtgBcolivu/CnYcV9TzS+Nf/e/zq08Tkp
	 FdTBzNLj4IgDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 737C7E2F2F1;
	Wed,  7 Feb 2024 18:08:50 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240207121436.3845425-1-chenhuacai@loongson.cn>
References: <20240207121436.3845425-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240207121436.3845425-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-2
X-PR-Tracked-Commit-Id: cca5efe77a6a2d02b3da4960f799fa233e460ab1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
Message-Id: <170732933046.14404.13301953236605274396.pr-tracker-bot@kernel.org>
Date: Wed, 07 Feb 2024 18:08:50 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  7 Feb 2024 20:14:36 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

