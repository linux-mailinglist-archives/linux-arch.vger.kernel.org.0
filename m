Return-Path: <linux-arch+bounces-4657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8A8D875C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F2289CD3
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19271136663;
	Mon,  3 Jun 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9prRXjT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14177E8;
	Mon,  3 Jun 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432595; cv=none; b=R9V+f3QqgLiTFt9D9H1vrgg2QX/qLHgojIf7BQ94bKFXnlyQ71fBmVfPNCq+4+AUzZ1Qu/bjfD/ndmprrqQjof6NhDxe4gpR2BJnPL1lSbC6DRgfYJ3d8H8DkUI9AMz4GAMvpxnu4V2wvZ8cUKL2TCiR+J5CteGJMFtTqTXIYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432595; c=relaxed/simple;
	bh=cN/du6aSTMzl08k/VN4ACbbSNT3SAGtqX9W9ddPQnOA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JPQghilZiRMLo+hu0tA6rEeTqp5IQhzqxLE29oyzCEjlqjciB1YOwWKpU7+ZUZ7vXeD4ij1CvYjo6rIti1/tR8HxQqTF3jGj5SjFdsZBDgPnMYmoLDIzIZTbp4VT/cWZ1D069WpJ32bTybX3hTy9mI8vWM6dGWW3+gffRy9c0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9prRXjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5CB0C2BD10;
	Mon,  3 Jun 2024 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717432594;
	bh=cN/du6aSTMzl08k/VN4ACbbSNT3SAGtqX9W9ddPQnOA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H9prRXjTwRB4t0rTRXWtNQ/LJYad5Il01DSQ/k+r+DbW+sD7jk/Rse/PR79q2X+c+
	 9WpAcb8MdSA8xDpoZcdD2kq0sAfqchOi0TmChTzXKYbMNapCs8uku0Bwy/Sgffgsl9
	 sVGr130KH0Pi72SXrrcFICxFmDRcRCg862rKCLzEBaWerrTKHu92tEiN2tuGU4Roo6
	 CMpWMiNN+fpvhSjK/I0arMboAXMjDzO97rUnwr9a9iSj/5qSeuLOO5vDkFLD/Z1ndk
	 uJMMmN2aMYC7KDjehLO8CCmswy+35gko4XFNQ7d0R0o8FaUxwxC+Q+h/KZLOfdDiGu
	 2FYsuoJaSajWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC8B8C4361C;
	Mon,  3 Jun 2024 16:36:34 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240603143158.2625704-1-chenhuacai@loongson.cn>
References: <20240603143158.2625704-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240603143158.2625704-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.10-1
X-PR-Tracked-Commit-Id: eb36e520f4f1b690fd776f15cbac452f82ff7bfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f06ce441457d4abc4d76be7acba26868a2d02b1c
Message-Id: <171743259469.18580.3203876992620951432.pr-tracker-bot@kernel.org>
Date: Mon, 03 Jun 2024 16:36:34 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  3 Jun 2024 22:31:57 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f06ce441457d4abc4d76be7acba26868a2d02b1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

