Return-Path: <linux-arch+bounces-2955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270B9879B38
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 19:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73DF28509B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0013A86C;
	Tue, 12 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzn5TmRE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DD13A275;
	Tue, 12 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267610; cv=none; b=ZzkaW2XpeASaZZpS8imhjHCsfljO5bI659mlowa/BY74nRox5nv0CHqLJPxJSnEeDSXjZCHgYZ6In78JC8syvUH2Vu1VTeRo7wq6ati8SkSG1B/YOXcGnjMpAPsMpKMCQqRf9E30S/goq89FLmWMJdpze0kvUIraoiI6WqEtmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267610; c=relaxed/simple;
	bh=7+DhpNpC0bpBdrNiQeTiBUwa6f0kbLZDJkTkoSiCmcE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BeiXIAo/jHFSuTLwAc23CzHxdQ53kP/8S/Q0eBllbzdWKiTpr9f8O+ENVq+4pfg1nxPTxLq5EycsnG+RXLw28AwP2Alaew5mCLUxYEvIOCGXgXI7irBitmZVGSM5nHKSFSHbCFov3jgTU6B6pV46RzC8JYZ4BIy8dWNJR6Lg/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzn5TmRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC6AC43330;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267610;
	bh=7+DhpNpC0bpBdrNiQeTiBUwa6f0kbLZDJkTkoSiCmcE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hzn5TmREa11aTgmIZyKJIyV+GDCFV/mhCLrlsv2axCekkpjfHVp7BBT/M6hDWj7c5
	 q8Tjm9jK6jXwVXJW2KNGUOkLkjh5UOjW6aR8bW+YBeEwcK08PlL0pvxDmK8ThLjM94
	 eOmzR2eQppufPpfB0xZQAuSHh6MbfPazSCuxbZoxfnXlKkzNURr/nyrT2eGDX63C/y
	 SY9DhQCWKvdCkeEh3Ld8p8mQmdp7lQXL3Ka/chDFaOJqWK2Y+JH5cMrAbaI8IHadz6
	 MZanPh7nzlSdp0kgkuqVAaGHvf7fGa5HsVMlME0+JoKcBk4UjqJdpiJF2DxwXZZvXY
	 oNRNwIA1mBArQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D59D95057;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <84ad750e-7234-429f-b43c-17464fbfc58b@app.fastmail.com>
References: <84ad750e-7234-429f-b43c-17464fbfc58b@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <84ad750e-7234-429f-b43c-17464fbfc58b@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.9
X-PR-Tracked-Commit-Id: 5394f1e9b687bcf26595cabf83483e568676128d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65d287c7eb1d14e0f4d56f19cec30d97fc7e8f66
Message-Id: <171026760985.25732.13139831534467589938.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:09 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Yan Zhao <yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:50:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65d287c7eb1d14e0f4d56f19cec30d97fc7e8f66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

