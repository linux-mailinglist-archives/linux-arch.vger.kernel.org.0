Return-Path: <linux-arch+bounces-4363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549738C45A3
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F051C21C93
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2FD1CAAE;
	Mon, 13 May 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIDVf8tu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D0224CE;
	Mon, 13 May 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619957; cv=none; b=tdwWRw1in916Q15UepDtYq+kb5WwS3FH1qnDU53rj1WM6OTc0erphs4RUzHxiP/FlpwsAJ5eT8qI41FUmTNH1uxLOknP4r8dplFygfRBedJ9n1zgRoY51v01GChjAhZQ3uIVmgg44PPp50FzeHaRGOoY0K2hAkDw+nGqIlVexCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619957; c=relaxed/simple;
	bh=8bb7Cxrgw9uF7S2/7MJAxwk3N+w8Yw+IlliZbcd7F3Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oX3lBHwwmoaamhiB1gVlKfL4ZxfFhJuGfZLiYWUWxe7WnwhnuyW30dzrDG/49hl1sSeXHsJ6+s3zPZduE/L7EZ1Q+xOUzZv285rIFz68uTnyVUa8PGCoHYpoMj0OzP8EYz+RQsZOM/vXNESq/srKO6Jqf7J/dMLRKTXWyggYJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIDVf8tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 180B5C113CC;
	Mon, 13 May 2024 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619957;
	bh=8bb7Cxrgw9uF7S2/7MJAxwk3N+w8Yw+IlliZbcd7F3Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lIDVf8tuj5KYTZskU7fpeTDE6DD70KDLYKIBV2Iq/0r5sQxLVqTs6V9heR49i3ca+
	 39gAfvBuhgg0lacUxOpch/jP0mHbGmwOz7xyeJzX5dmF9gdNxV9HDtfRqEE8UocB7O
	 eUUqCcBnRqY6ALAJP0d99UaxB9UyRKRhIN/+Z40u12ayUBGcm21F9Tbp2G/ktd+3QO
	 4iOcZwXglCuGV49PbAj5TghLhpsLP+iZ9Ro3gdieEnQ9nhXMzDQfFETbc4QmApchiA
	 jNJkTSRN+pMyhKiJAnLn4O1VczNrtxz+OkaOZ0JPu+rGPOa9v/8oqfYdGMBuJHBfzx
	 w5kiX3EI9JFhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 107F9C433E9;
	Mon, 13 May 2024 17:05:57 +0000 (UTC)
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com> <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-alpha.vger.kernel.org>
X-PR-Tracked-Message-Id: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-alpha
X-PR-Tracked-Commit-Id: a4184174be36369c3af8d937e165f28a43ef1e02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 736676f5c3abd1fc01c41813a95246e892937f6d
Message-Id: <171561995705.9638.8286642138765117973.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:05:57 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, linux-alpha@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 23:19:56 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-alpha

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/736676f5c3abd1fc01c41813a95246e892937f6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

