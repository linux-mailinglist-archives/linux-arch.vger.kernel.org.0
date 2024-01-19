Return-Path: <linux-arch+bounces-1406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94C8330E6
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 23:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E30D1C2152C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF359147;
	Fri, 19 Jan 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIqtugHR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3957888;
	Fri, 19 Jan 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704611; cv=none; b=Yx3D94HcGqCgI9RkwBjUlIICpehuSfa8odb1R6ePI1bKdWTW+BRhlQSZ2BkRleCt7cQhZ0+kMzWm8QerpvfhUQHWk/VfhHDQhA+uFor0fo3TitXOJV7wegu1soaCYyYDtpYBdfhYRGdD7EYXqQWqTA5NAQmaF+NnDjef1X/i5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704611; c=relaxed/simple;
	bh=9U6ungNWwzmVSFdxVrZ0DAY4ZU2skUCpAiaiBwTMOaA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e/a9BPiSmCKzrGai1hfj8hEQr8BtHA+jC77ksdMWMMlaNWHfVs4z7/c3NLOQSa9tMiPqStyf2ZzXd+hYjfv6onQnI2gZKXBoDwQipFxxmohZXw+IzdlkfXxYSuXiEstVz9DasJjbOH5dqWn4CBKzkgJ1aeU1+m0AdZNHulwPzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIqtugHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB3C0C43394;
	Fri, 19 Jan 2024 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705704610;
	bh=9U6ungNWwzmVSFdxVrZ0DAY4ZU2skUCpAiaiBwTMOaA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FIqtugHRbLBbM+qKZAd+f/2YrjemlVs2f613eJBtXEhDV0Gp/15KS/IJi9nlJpiID
	 sM3spS1H6TpDG72x3IN6OHI5k92EpW6MseTqaDmOsklit5iPfAuP2EdcWyJ4gXvSID
	 pCrFT/nyTm3KoDIB1rEKYsJtMGRkbGjcxOPFz/4GtA1ihPErdm+2ffVPlsN7Ot5PpJ
	 U4fF0CNYo/9b7ZIMIy+tSYdu6t42aKjBCJGjvs9fjolm//8wbJBpVQ1Q93SdIfn2TV
	 jaDAqVZYee+6ZNFtdaQ4hMiHYI9EhbMN3g9dbYgwO1BE1vaDBqeQIoOjRDFITdl6WH
	 BNglo7G0nDMfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFB44D8C97A;
	Fri, 19 Jan 2024 22:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240119110700.335741-1-chenhuacai@loongson.cn>
References: <20240119110700.335741-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240119110700.335741-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.8
X-PR-Tracked-Commit-Id: 6e441fa3ac475be73c03c9a85bd305d66ea476a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24fdd5189914b36102cb51626a890a2d84501993
Message-Id: <170570461076.3214.11103143930063535274.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 22:50:10 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 19:07:00 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24fdd5189914b36102cb51626a890a2d84501993

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

