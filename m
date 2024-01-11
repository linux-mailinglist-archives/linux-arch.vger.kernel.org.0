Return-Path: <linux-arch+bounces-1332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B1F82A5EB
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 03:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B8F1F25F9A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD046AAB;
	Thu, 11 Jan 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Razy2B1Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197463D8;
	Thu, 11 Jan 2024 02:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A9C4C43394;
	Thu, 11 Jan 2024 02:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939840;
	bh=m4ePGwez/Rm3jwS8CBPhvLAB+3xKQad5VeF+ddl+iec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Razy2B1QfF37nax4XcaA+2g8qMuicPLVv0Sl07RnrxG9rO1lUXrK7+5IaDUH+Jki9
	 iQ5+IFvjxRxOSwI8PmWrBJTPgG6D2n9yV4tG+YAfPcLrwxrDG6X2ztJdWDlXUheinR
	 r5vliwY7F4W8sxJ9ypUnbG3Ea1lDKXwTbaf707lWOP0EXjxPx3AnWcCndt1EFXykYP
	 fJKAFTNbxnJwDC7VU0w/EZ1Wfm+H+wyTXq9AVyeLbv7dnIOUMSiVtjxHBz+8R6zlSR
	 ZSpTlX8lgTln5vXlDzL7Ihws7HSrCuT8jL0Gr5k/ir4jj+n7FVN7cdeGMNDxCoN9Tf
	 S6jLlbgdYXK8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89DADD8C96F;
	Thu, 11 Jan 2024 02:24:00 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic cleanups for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <8d87c3da-fe7e-4b2d-9078-4421e4ca7727@app.fastmail.com>
References: <8d87c3da-fe7e-4b2d-9078-4421e4ca7727@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d87c3da-fe7e-4b2d-9078-4421e4ca7727@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.8
X-PR-Tracked-Commit-Id: d93cca2f3109f88c94a32d3322ec8b2854a9c339
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c29901006179c4c87f9335771e50814ec5707239
Message-Id: <170493984056.10151.13225226632633075297.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:00 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 11:18:36 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c29901006179c4c87f9335771e50814ec5707239

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

