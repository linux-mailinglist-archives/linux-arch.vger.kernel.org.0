Return-Path: <linux-arch+bounces-3108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C188725F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 18:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8DA1C237B9
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD1A60ED7;
	Fri, 22 Mar 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAZdFlKI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FC60EC9;
	Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130289; cv=none; b=rHgU395DKdxqZe54ZVs/p1bjAZ3eS0eilEoFM0hTIZqo+1ljeaYzg1vxPESU+Nr5B5cKja19nx0wLqMcbZ2c6ggLixoj6aOTYfehNuPdjJgHLiEaP4kKSyREKyMIQDoNMm43E8pqHqxiv3XNTKxEe7v7bdC0sV9peIDtaSYuwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130289; c=relaxed/simple;
	bh=Xd35sZTHKSyW1UdMmJMAmppQmB7EyY5U8777yvGvzn8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BwDbsdU8Gx2JLRN8WPkgNOR/xH5dlfljONI/9h6fZU9Sq46TVaoTlVWpg6GvVFMDkNn76bu778AjeGP5ky+bA0FUT+MiYK6+Whwm+HylIroPMCHJjbRWrPEowlU5IXf2mmVmsi6WmHHTc2J8ht9F/wf1XvYJHxRmjsrrn5yrivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAZdFlKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4BD2C43390;
	Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130288;
	bh=Xd35sZTHKSyW1UdMmJMAmppQmB7EyY5U8777yvGvzn8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eAZdFlKIZ+K12i2bNA0CZLfmbeAMQIWOqGN7a2G5voPLf+TLqZKwtMlB1Zx1V0pfD
	 MIfwh6UY0H4841hDgsiC6z/N+7qwX6jD2KeChZROM0vCBHskXNG+xwRdkk5NlJeuFJ
	 KMF+pvRtP0mQq00Vi6I4wkN/Cw2fqavlOuK7StGIyfrp8CzkhmwUKkJpCY7CJmG5Qe
	 pan82gcS01MCS9T4s09oMF7a9e+NcXghNsIiCdy0YV6jdKufiP4Uc3RgnQ0FWBMHaE
	 UGWj911S7cGw7ZuRhx5/ztDOWMgcLRtgIPGkU/ppuwiS/WCWioXe5RqU60ZoF+YyXR
	 P/cnsGA47GisQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC043D95058;
	Fri, 22 Mar 2024 17:58:08 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240322135619.1423490-1-chenhuacai@loongson.cn>
References: <20240322135619.1423490-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240322135619.1423490-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.9
X-PR-Tracked-Commit-Id: fea1c949f6ca5059e12de00d0483645debc5b206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e3cd03c54b76b4cbc8b31256dc3f18c417a6876
Message-Id: <171113028870.2552.15726906786160766507.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 17:58:08 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 21:56:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e3cd03c54b76b4cbc8b31256dc3f18c417a6876

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

