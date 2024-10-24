Return-Path: <linux-arch+bounces-8529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D48379AF4AC
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 23:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB01F21F6B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADEC2003AA;
	Thu, 24 Oct 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCBIwF+C"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D818784C;
	Thu, 24 Oct 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805368; cv=none; b=mEd7gTPKhJXTdbJhMT9okU76auVlenEQDfC/2DiBV1/wNo/19v4HOKgOC/1WKJ/D0CNTjnERHvbUTsgd2h1vdIgF+sghuxGkCX5RUWu4lLEyQEJfb33Ht5VfWL52NuwLFWfV+S1Tln61TpDvPE1xAlbb4kBS/hRBMGK8NwUnOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805368; c=relaxed/simple;
	bh=oGxJ++nc9UR0DAtOlk9jDcvkLlastwtVUMjr5qeUJF8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hNQkfjQndLYPphRUM1+Aeh+1hoPQIPlnpbzGRNWC5rd0Syizu6wqW7Ux7/H9DTVOe6gnzWSWIfyNsf6CHTYxkk8xonZOXSUD4HSzeB72Za6cZZlBlKipQXGZQNXTFXRqIELrtiPBSXrq/ABTVKxH3ajFS342V+vu3kkEY3M06Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCBIwF+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C29DC4CEC7;
	Thu, 24 Oct 2024 21:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729805366;
	bh=oGxJ++nc9UR0DAtOlk9jDcvkLlastwtVUMjr5qeUJF8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pCBIwF+CIKRDmLxywl6kxq7Z+e8fDtNJlXnu7fDrBNH/tpAEQuq3TOQkwub/X1y63
	 rc7+om/SCYxe19QkiZtnvuFL60DAGKHS8+A5EQQKlAy5YWzHbfz5RmCL3YeFKG8hyh
	 o6GctBRaMAH+8TSJksix1j1aonetEGv/BhwZrobdpBp8J6N3sPclB4Q1vgxJyiVSLF
	 uKa/kIbfjIxdzZ1JcHug5sM67hyqkoSbnZQGj8s8XlcKljsmi9xoWYBK7luUg8Tmf1
	 PXh4dv/AQr+HnAvVgCuupgzTmgNx1hb7GnFpIKPEVGBn9zat/QBlz2Ih5Ir4W5HB01
	 HJPc4+MBClOwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A79380DBDC;
	Thu, 24 Oct 2024 21:29:34 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241023145214.2559236-1-chenhuacai@loongson.cn>
References: <20241023145214.2559236-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20241023145214.2559236-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.12-1
X-PR-Tracked-Commit-Id: 73adbd92f3223dc0c3506822b71c6b259d5d537b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3964f82a4dfc7e4bd4055fdc2a42250f71449f54
Message-Id: <172980537280.2393082.1249830047006691647.pr-tracker-bot@kernel.org>
Date: Thu, 24 Oct 2024 21:29:32 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Oct 2024 22:52:12 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3964f82a4dfc7e4bd4055fdc2a42250f71449f54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

