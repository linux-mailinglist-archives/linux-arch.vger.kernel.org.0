Return-Path: <linux-arch+bounces-6122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625194C54F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C727C1C230A3
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5634158D72;
	Thu,  8 Aug 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfOXzW2t"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77419158853;
	Thu,  8 Aug 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145372; cv=none; b=c8Nabn178mcIdWDPTXa2v7zwNWITxQYzZ8z3SfxeNugaWvGu2O2aI8GovEs1Zsp75pzj78iqlFdXB4s3SXoWG5RnMbeGONvRW5C249/HqmNE3EPocT3oRzk4qpJIM2DWbtf9Un6RHV1ddJrAV5LLZrZXt56gCm5XjS8WfG2p6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145372; c=relaxed/simple;
	bh=qYkiQuZv/NpL1u57sIqJFlSmXlTx7BykftLgqvra72Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SKo2mpr1tutUSZwHZHOnpw3HnJK021qvv9DxHSbSdUf1jt1sqP0siiAvyjxc5DpfKU/ut/jWBvZxPti+XNyk2JIGUBTLC53k5QQ3mDHI5QZsBkDyUOXjwjB2q45GbBsQ8STzDpC8grrQR2jw9x7/uflaRWVsd1FBF/eZgKqKGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfOXzW2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BC5C32782;
	Thu,  8 Aug 2024 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723145372;
	bh=qYkiQuZv/NpL1u57sIqJFlSmXlTx7BykftLgqvra72Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hfOXzW2ttGsYJgUN7mEp0Dmb5MQhKC7V8zQj3fB/cAZbwqbpnFhiGNR8YJjU50k4E
	 SqwpJoy6TSVNJDwWtZP5rQJ8abhVbJJ4IwrcXZmNZLZf8D/YWluvohOEimv7+25AhL
	 ++62vq0J3Kq/zU13FJoRT2LrgeKvuej+7rIZcXxM9frgMOIV93zftn1BX4gtxxcoNb
	 2m+BOW2q3DFg++zL9EFrdefHcLr9ks+LZn2SYytSH9pHj3l0dpIzXNT0OrA4yScXHo
	 dvPM2ZYVQh0mVV/DTupQZR6zjfhegnK//bxnVPxU6nW7XBzW/zg7dmNq0B8MGIH3k4
	 2MMB56EFtBV2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342603810938;
	Thu,  8 Aug 2024 19:29:32 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240808112437.1538513-1-chenhuacai@loongson.cn>
References: <20240808112437.1538513-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240808112437.1538513-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.11-1
X-PR-Tracked-Commit-Id: 494b0792d962e8efac72b3a5b6d9bcd4e6fa8cf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf6d429eb6563185919322205a320c3b12d1c255
Message-Id: <172314537076.3277467.11174892077016952522.pr-tracker-bot@kernel.org>
Date: Thu, 08 Aug 2024 19:29:30 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 Aug 2024 19:24:37 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf6d429eb6563185919322205a320c3b12d1c255

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

