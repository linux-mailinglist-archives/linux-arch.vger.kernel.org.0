Return-Path: <linux-arch+bounces-5173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0A91AEE8
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B652EB229C3
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9A19A2AD;
	Thu, 27 Jun 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ3hLBE4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F819A288;
	Thu, 27 Jun 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512413; cv=none; b=DsicI6g06sJjWYMeB1npKPIfYyhNPhiHOFMxEXajHxHaeOsc4SfOXasTHQ2QlWqYrD8kU/KDAAjUIlWL/1bWQaDGLVG+5plyJsdNBQT+woSxNg2PebtN67s1LdCJMrm4vYPVOn/+CgietAXQUlIF07HHc7EfqcdM9uYQ67cwjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512413; c=relaxed/simple;
	bh=oiPLXzyBuB/9ABl9lmBjuJm8GlkGX7OhOnDxu/PW4cM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZNMBxnwFKSxOQO8Ug+KIHF/qKzbxiJnqUE97R/Vk+0Lg15n/efDrpsWUztFCbs3HSpAolHM5Tvq3fr2SlY73wy8SNV2mboNCvRfFOMReL3EEo6eCUrhQVrcAGxYSlLQf5bYNXc6t9UV9orln4QCo4elJNvhC1IYYMcWwiXa5e1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ3hLBE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CFB2C2BBFC;
	Thu, 27 Jun 2024 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512412;
	bh=oiPLXzyBuB/9ABl9lmBjuJm8GlkGX7OhOnDxu/PW4cM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eQ3hLBE4ZIv3kxnVmcUfnalo9hyE+XuAYFCvOLDz7g8rhBzo0gRyeR2YgvplCloEW
	 +sny0G2JXgR79PF0yoCHN3E5AAw1GiPoApP2cU1+zAZlH0T6gewT/OpEhcV3byB2gS
	 +XGxCzIatPS56CrrcfrxNZt2ce8Lm2q60mUXjnsU1pzTHlJnmY52B3aDzxnxc8sBXj
	 VIuIAb5eCQkVkgaDxd8C6kH+Wi2yoTVC5vZpt55GblTRwO4OZ8xapsGCblKOyRKUug
	 LNGXP7tZqYghFj4zfqpsDlSoU6hAx1Fmi3PkIxBN9bSn7MALps/btowr9O9KFM10G4
	 9LaP1dOHcI+2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B34EC433A2;
	Thu, 27 Jun 2024 18:20:12 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <cdf46f76-ee89-4c20-afd8-94a629d06e70@app.fastmail.com>
References: <cdf46f76-ee89-4c20-afd8-94a629d06e70@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdf46f76-ee89-4c20-afd8-94a629d06e70@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.10
X-PR-Tracked-Commit-Id: 7e1f4eb9a60d40dd17a97d9b76818682a024a127
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adfbe3640b5299e062af0b64ab8eb48eb7874832
Message-Id: <171951241243.26151.9086294172682659351.pr-tracker-bot@kernel.org>
Date: Thu, 27 Jun 2024 18:20:12 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 17:47:32 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adfbe3640b5299e062af0b64ab8eb48eb7874832

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

