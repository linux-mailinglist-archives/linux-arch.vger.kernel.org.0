Return-Path: <linux-arch+bounces-6731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C69630D8
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 21:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077D11F2288D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED65C15821A;
	Wed, 28 Aug 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkwL2AGL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23BF2868B;
	Wed, 28 Aug 2024 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872707; cv=none; b=LubixWMjOxYbe/Z5fP2j/GujgZwxcEKmJuJDdZkpkPNJw2s9T3ANZoUQ0gWEG+X1AFEwZxuk71a5BeCQJp+62txevMvBNmaiUP+x2P7+P8XzAyeqjEgxNnyrq4rrkjvf46vqPL/nHhjuo03ng7WyyjhKf8eDtvbBn42TppstG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872707; c=relaxed/simple;
	bh=zGUaLfjyNhVscAoZoq99+/cK/SGu4jhpsn9v6C6i5UA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=md0ldCD94A5j0OutNiw/buXcRZRb/3QZtMFz8fObBt6L6QUiDL4Snap1892HO3QMVpEpg98iuyl5sYNmu1Fwrd5TX09L6R7DfwHiXRENoyejXRNgbRVoFHdmnfAXyQsGcYnXwZfV9Uew9mFnAN/5ycf0WDiYPO1P6OG4By+4ocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkwL2AGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462A1C4CEC2;
	Wed, 28 Aug 2024 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724872706;
	bh=zGUaLfjyNhVscAoZoq99+/cK/SGu4jhpsn9v6C6i5UA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PkwL2AGLmZRS7yfuNfVoDu09vm+r4ab+xuelU3EFeCb+R/BtYTWD1B82hU3UFUVj6
	 +1BGjSAArakFEeRrgNPIFExrTGUCgzdtSzK5kXA48DVUK1vfFHT+viKUfzLAB3sI3p
	 W+l2nMramEb2r1g+j/Z1d+PRjgR0uiilF0bgM2f3ZL22wquLFzAKDrENTSC7Lx1GoO
	 MtP2yw2Tg6zd/EGtpeVTIQ0sA6GvNls7oAU9lC+32/h5GESAIDxSETX5fZD0Y5TbqH
	 62hKChTKDHhu+q1i1xX5LAdSkcUAgE5y/CtnFC7/uFBMDCuk/pjhlwY2pLY/1890re
	 j+NLhfEqkBAHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2D83809A80;
	Wed, 28 Aug 2024 19:18:27 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240828134408.3231389-1-chenhuacai@loongson.cn>
References: <20240828134408.3231389-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240828134408.3231389-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.11-2
X-PR-Tracked-Commit-Id: 4956e07f05e239b274d042618a250c9fa3e92629
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 928f79a188aacc057ba36c85b36b6d1e99c8f595
Message-Id: <172487270626.1401757.15704898692520776590.pr-tracker-bot@kernel.org>
Date: Wed, 28 Aug 2024 19:18:26 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Aug 2024 21:44:08 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/928f79a188aacc057ba36c85b36b6d1e99c8f595

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

