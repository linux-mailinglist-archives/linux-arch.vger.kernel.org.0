Return-Path: <linux-arch+bounces-15385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C639CBA486
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 05:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE3D30AB87A
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 04:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1528C5AA;
	Sat, 13 Dec 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsA146vL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475351C84BD;
	Sat, 13 Dec 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765598937; cv=none; b=VOofmUtQdR+jMLvHwbh2dhu6XwWCXiecaNU4VDsxbyiOatyXvZ9Ez3+ES0tVP9iYn79YCtyyPz2Glda1FURz57QB4LwJuy9d1pfzz8ZwUWLv1wZwUJ1ybz6gNpkZnizTJ8mQ913hj44Al2pzzTUq7pTqsXImINWmqYhAowMcFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765598937; c=relaxed/simple;
	bh=rtDUr8kFiZ+zbBNdupsw1Y4L3Out8UQp7CgkWGoAufU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aCDbpPtdbK8+F2tnMUNToDy0XQhLRI4QZJgVCUEHyrqBvAQNDdLapfiJC+hE1SzDXwsnJDNIIrv+6/rw7YxtT6XJjMi0dFbV0snBSxiuwebi0bhnFv7nlmV3aOF36kuYBrh8mRiVTooSReaMXSgBuub12f0sy5Otet/r3bWGm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsA146vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80EAC4CEF7;
	Sat, 13 Dec 2025 04:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765598936;
	bh=rtDUr8kFiZ+zbBNdupsw1Y4L3Out8UQp7CgkWGoAufU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dsA146vLYmHgJYxoPQlzl/MeZJGXW7JU+YcVbmPtvl8qyU9A8lXjZdhmibSVrHt6f
	 thR2i2fnnwky/6CsHH2rbkaqcqZb46oNBGAjeg12YY5n/LZBK9O39k151lxsFH7KCQ
	 mYvhb/yYythQF/m8Hk+/AhSwIgW9qqtdty6oyREYxpEQEcoAljMPL4jkXLAlhngdsD
	 cINRjvJxPAYdFtywBsGmSk2n9C2fgiLP0f0yUKLF7dtycD2JW+FLTG7PkGjv+PuPkb
	 FCSYmriW8bAvN6LlAjBc/xFol85CwDcnOsGS3fr7eCvhagGugwQ2sIBNGxiXDp2CAE
	 dzI/6Qmz3PCbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A32380A954;
	Sat, 13 Dec 2025 04:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251211144219.2282231-1-chenhuacai@loongson.cn>
References: <20251211144219.2282231-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251211144219.2282231-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.19
X-PR-Tracked-Commit-Id: be77cf43d2fd6eca150594e997e40ca7df90f251
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9551a26f17d9445eed497bd7c639d48dfc3c0af4
Message-Id: <176559874944.2388135.2320307195215147125.pr-tracker-bot@kernel.org>
Date: Sat, 13 Dec 2025 04:05:49 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Dec 2025 22:42:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9551a26f17d9445eed497bd7c639d48dfc3c0af4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

