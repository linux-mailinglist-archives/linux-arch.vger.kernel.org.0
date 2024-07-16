Return-Path: <linux-arch+bounces-5427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3129331CA
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687611F266C4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951691A0AE5;
	Tue, 16 Jul 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNxKgeY+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C31A0710;
	Tue, 16 Jul 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157937; cv=none; b=SNChq7os4vAKr4Bp5lm4WwbBiR1o9EQVpIgd4zqqQV5IKAOPc2WU/qmGKyfeizLrYtjtcrNRXKLiguzeWD/6iVB+aa7ix4gIYx43mmLKRogw8bkH7YxwMgvgi9H6tMgjzsN0OhbEPfcJXHJYBKh7xzAHr1mGlkQivoSvPUnkfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157937; c=relaxed/simple;
	bh=ApR1CztnHPC86gcOL01YiStqVHhkte0QJGg8q7SbYBU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=stAo5Av3/zhi2AwNSdofrfvuWQle6Jdy5mo4EP72AbwhCJkG/pmRmYtzR0bPqpvXVdcS9jTuQHnZDFcoONlZZ5IJbvzqSpHnTilNseJeHgmfzerGm6Dju3LgAg2W2HkQKB591ET62zakJ/8XANon5RTezsKVAce53RehcJo9rxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNxKgeY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B295C116B1;
	Tue, 16 Jul 2024 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721157937;
	bh=ApR1CztnHPC86gcOL01YiStqVHhkte0QJGg8q7SbYBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QNxKgeY+29k8AhHmVqI0QWtTnJah5XwsjyLLzlbXcnHLpYmcAQ72y+wn4H/caMIE3
	 J7E2pGObxLEPLVPEa/IMMbr6Omf8k20Ie75kiv92Rh1RzbVs4IXtUkPG7AE/kpP7vs
	 P0D8R2++e4WUoxCn6QcMPWWvm0l+uhvI+1p6zPdcXqkx+c0rJ7elTRQaBw+ojcr47M
	 sBoyPtFDorqTf0zwCOR0iIWI3u9/IgME84C3HghlM860WKFGdlul/srP+bOgfZuOTG
	 Zb66hbsT0LZLAr5XPR5OCVvSA81XHi2JJ2274PjetXdxsoXkksxKio043bK8KcCxFx
	 1LCl3hlQEcMJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4233FC43443;
	Tue, 16 Jul 2024 19:25:37 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.11
X-PR-Tracked-Commit-Id: 1a7b7326d587c9a5e8ff067e70d6aaf0333f4bb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d80f2996b8502779c39221a9e7c9ea7e361c0ae4
Message-Id: <172115793726.10577.15898736537891799499.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:25:37 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 23:14:27 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d80f2996b8502779c39221a9e7c9ea7e361c0ae4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

