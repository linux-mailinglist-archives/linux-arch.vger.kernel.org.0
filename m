Return-Path: <linux-arch+bounces-4367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9956C8C45F7
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39368B22A9D
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416420DFF;
	Mon, 13 May 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY1FxsKe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0720DCB;
	Mon, 13 May 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621278; cv=none; b=FkY+2YQTfza394g4GdPRuVfl7ydWb5eieSFWQ22w1ikYU6iFTM8xbrVWU2K5Uh2z22J4wvBMqxTpr7ZZd3Q3C4kkDfM0z3lxS1hNHbVdZDLMxM1SYMkAGdP6R9JNfvlyDvUxrJsd2h/l27CunqZHTobyCjItIIV99SgRUNE+J9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621278; c=relaxed/simple;
	bh=3vLG1AxGuz9w5zzq4IK8ywypYzXBuUefpce5tWGp1HY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oRmiROGE7LSK7Bh0uKyz9AZrk/5MCM3KmHUW1W89dlQ3Gd36GRUPidmcowPVeVi3an7S1qa+/cuhHAvTJCdO+taqSxrISH8Ms2JzWXzRqe2Hz1Sc556ooJanSpqFmNReLSCW/9cVUgjJ0sqB/TmF8cMz1QtqxTlxrMPjUoEAWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY1FxsKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EF42C113CC;
	Mon, 13 May 2024 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715621278;
	bh=3vLG1AxGuz9w5zzq4IK8ywypYzXBuUefpce5tWGp1HY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eY1FxsKeRISgoVGl7oIIPjkned/19RaUeyFfScw919l3RlXX1gtLXGHe/+flUdGCo
	 jVz33L36j7AaQhS43r6bXQBco33oVvsIpvqFTUjgDl6dNbIU9H3DCVb8UeK0Tc/cHP
	 lkv+FrSNM81K6iwbVSL6Cuo2Yf6hd3z+tzYwd0kDtIzuflF/MTcBAnpWxOCuwQFHVC
	 3GhCNWf9csw74hjjNMto3njTP0MNvgnQ3BGdkdf2iShne1lIvaCrhKLRjK4jDJfLit
	 9o0hOpbeJ32WF7qg0eptbbLsAaZwFvjTkevbgPE2RxawbBld0n63qKi/4sReIWmvzQ
	 GjFhmRCX9AESw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93AA6C433F2;
	Mon, 13 May 2024 17:27:58 +0000 (UTC)
Subject: Re: [GIT PULL] Native and emulated one-byte cmpxcha()g for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <a03cbcce-ac01-46e7-9fd5-c4f0b782c8df@paulmck-laptop>
References: <a03cbcce-ac01-46e7-9fd5-c4f0b782c8df@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a03cbcce-ac01-46e7-9fd5-c4f0b782c8df@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.05.11a
X-PR-Tracked-Commit-Id: 5800e77d88c0cd98bc10460df148631afa7b5e4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e57d1d6062af11420bc329ca004ebe3f3f6f0ee
Message-Id: <171562127859.25347.11248305611726382716.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:27:58 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, kernel-team@meta.com, viro@zeniv.linux.org.uk, elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, pmladek@suse.com, arnd@arndb.de, yujie.liu@intel.com, guoren@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 10:28:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.05.11a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e57d1d6062af11420bc329ca004ebe3f3f6f0ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

