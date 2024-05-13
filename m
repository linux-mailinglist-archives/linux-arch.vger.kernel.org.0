Return-Path: <linux-arch+bounces-4368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DA8C45F8
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E009E282300
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4A224CF;
	Mon, 13 May 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5TuV1Wg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313821342;
	Mon, 13 May 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621279; cv=none; b=ew+KvlhjTxCiyj5vvBpdyzxN84nBreO/0GOlBsHXWMT7r188eHY6BPJfphIlhg4gv2px+jSHTaALIp9Y6r5tse0KOy5lF/nGUZVl7pudBBUDiGjdjfyPxOhkSf6OkUgXo0N1UeaK8wZCqZU5hFDHLeMvRo6IClvViAiDc7z9AMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621279; c=relaxed/simple;
	bh=KKVwggYsATvBHsu8ulRlwB0CKTL4W50jL5G4YmcLjco=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K2zYOo0FfVE0/ZuFkSWRxoZWv8JJvq5lxvzNjllWtAtkMAeu/bn8R3G8/esEwwIA5hj4asksDx+/30687/06xqzBgk2Ryj5RWkT2BQ3XiWaX6+G6luSLh/jVKJB0vCrNXIi6u3/lttj73L3B5USHLIJdjcK98OeV3C6ilSAm8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5TuV1Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09F1CC4AF09;
	Mon, 13 May 2024 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715621279;
	bh=KKVwggYsATvBHsu8ulRlwB0CKTL4W50jL5G4YmcLjco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e5TuV1WglXBX9PBYCmeRsWEVr/LS05/JT4L6Tk6k2w6Nzr0GXz70eU8vgcoU6t9QB
	 pMPBKkaNhfyoK8rKcDMZYf0z/t5Lq6qQz4kplGTrBCHgcDjEViaiHk4X2GZjn0a2Vd
	 lYC+HfuSGXKsBh/+ZkUWljUiVtSWFUnRx8XZvTFH8mUtuDPF02N62J5uPrbz2Co1OR
	 EaXiWbNb1Zoi7At0IAJP0aK74c8FGBV/22M31CmU4WeYLRBA3go5r2bdVzSW2+roVZ
	 fjbiLHI3QlXHgIoy5EHCxewE6zzKPOrhyJpsRm+SiGs2rsyxYvoY5eEk6c6mdKQxj9
	 ATSEAkofNWVsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3589C433F2;
	Mon, 13 May 2024 17:27:58 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <9a2178f8-a33a-4b0e-a867-30ea44761e8a@paulmck-laptop>
References: <9a2178f8-a33a-4b0e-a867-30ea44761e8a@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a2178f8-a33a-4b0e-a867-30ea44761e8a@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.05.10a
X-PR-Tracked-Commit-Id: 2ba5b4130e3d5d05c95981e1d2e660d57e613fda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee20260136095c8037d8f94f0471eb9f7e3da99f
Message-Id: <171562127899.25347.12735599908931695100.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:27:58 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, mark.rutland@arm.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 10:41:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.05.10a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee20260136095c8037d8f94f0471eb9f7e3da99f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

