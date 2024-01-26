Return-Path: <linux-arch+bounces-1737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BD83E48C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 23:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5591F21C92
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78738388;
	Fri, 26 Jan 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaXC1eVg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FC24A09;
	Fri, 26 Jan 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306726; cv=none; b=lKMOhvphHE4b+IfkH7WhyPjlM8MnAt1TyJH0MHj+XiyB6LpUiNQKLgBwCz5h8vS+14xlWUXBA5tdY40JSwpbOrz/GsIRrx0iMokKaMn/NKYHcmisxotawIbA4YlUdZjucd/JdSJ2LFV5Z9RLMWulPy+gKvy/PsWDt/AI4rd03YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306726; c=relaxed/simple;
	bh=OPfuw5Xo8gy+jEFdIT/ASgonT/8DqO+qsDFlym7rIoU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OktmwbPT+gUQLkFH/cIbEo1NUZsI1lcGOxKd5i5BlQyMOp5Pv/hK2jLTI2lXOgJh5Z+iuRmjgYs1LnWdl6hQVod3CR7cYBg/t/S1rTaALs83V7T2GD44vhTnhhxqrTLQiuKi7KIF4OF05zSRc/xQVyo1+cCG8DDRaCvvTSbcTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaXC1eVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEF8BC433F1;
	Fri, 26 Jan 2024 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306725;
	bh=OPfuw5Xo8gy+jEFdIT/ASgonT/8DqO+qsDFlym7rIoU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VaXC1eVgaytFrrFaEeCj6+XsMUwbus0OUBirvBPxNhwNgx228nern64v3P0Mjt+hz
	 Dr2xO3PSmAkTcljsbAYfSCfrLsaZuuYpQCMZEXB9FpTu7ZFaGSaUSdmm74XJ5VP6LV
	 UTCgnaQknMKKrQNxQDDLWSn5EICFJR0vayXL2WVgpe666F/QaK+ulAbpuxNDTOU4cy
	 U3g0pC0du5gO10TJxX0VnZ9UII7QOlxHJ4PbUCdAw1X+oxQCJOiKMQeQeZfNonEJ4B
	 /gWGDBhBpUlc2RiIdsX3srPMENvNB06yDPKpMxaF8GWB6xHDzIg4CtWmRFD4o/Ua8F
	 adRq+X6olw0MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD2ACDFF765;
	Fri, 26 Jan 2024 22:05:25 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.8, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a9bd787f-7750-4277-8e85-783c9715ff96@app.fastmail.com>
References: <a9bd787f-7750-4277-8e85-783c9715ff96@app.fastmail.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <a9bd787f-7750-4277-8e85-783c9715ff96@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.8-2
X-PR-Tracked-Commit-Id: 61f61c89fa5d9925e0b874854fb62e51948a6de1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2047b0b2750855a8a5b489915b203b4a8b5ec56e
Message-Id: <170630672576.20742.12528412812145810653.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 22:05:25 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Andreas Larsson <andreas@gaisler.com>, "David S . Miller" <davem@davemloft.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 19:21:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2047b0b2750855a8a5b489915b203b4a8b5ec56e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

