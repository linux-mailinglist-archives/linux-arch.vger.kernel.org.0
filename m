Return-Path: <linux-arch+bounces-5400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA44931DD6
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 01:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19D21C21412
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6408143895;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRqj5Gdq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4E143866;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087783; cv=none; b=L8UiGGbQMgalMVgoFxqiDsRVQaBDgBtUsla2ZvIpi4QaJj13d+PxmoJETfIRgesmJZIdCCjVzV2kmcotGuLtVSvUw4nfETfqCOZ+oHmNvVjlQtqZG1m/xCkgyswlRhFcqVV+5ge09U2daAzkGXn4G1dd0Iv9e4ov4BbT2g5faIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087783; c=relaxed/simple;
	bh=rQolAbacHYxjtHZ9yIGki1B+OWpVzHM0zNUy4nDb0K4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jM+GzSKCs/fgaKn4kfZW7T0g2xq5esgjlZ8yx54rYOKoeq12TDyHJ8uf+Yw6sQvMoFwGEIuq1QVxNYNSCX1EoILZyE9aKBBQb2TFXp3SSs0s5k4rbNV9E+k9/saM/CSaKUxEYPmJUXg74EoZ6piQ/yab6Qr1Eqdm/9SoQoLYEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRqj5Gdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 927CEC4AF0B;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087783;
	bh=rQolAbacHYxjtHZ9yIGki1B+OWpVzHM0zNUy4nDb0K4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gRqj5GdqxAOFWOd5hE6CkIy+nW8GltJ9CBlK4UmCsAA+sGf7TNt4kUmUPDZPgS5LX
	 x0VqCKcJmsOl6k5EQqkAJN3I7XS/6lzcLx9jD0oSzOpeQy2gAINo6lxwee/jy3Gspp
	 2ZCITCfdvEOBd5/ecPP6zmV+9SBUHm2JYpafDk2g1yFI5cVbdFWRPWRfGK16UOKiaL
	 Eu4sZATh8Gy0TTyz5eQpjmD1ET3eyAumiAKeyDNSIM96PaEuNhShSXr8sHSi9O8NB6
	 bBmcHI82yEEyUiObdLhLPvy3yutuum9lZuJdsgYyC70w6zismtIMZgdoB7nGP097tJ
	 8Ex6AZl4O0FBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8635CC43443;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <583d22d2-a123-4131-b4ac-20980357592b@paulmck-laptop>
References: <583d22d2-a123-4131-b4ac-20980357592b@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <583d22d2-a123-4131-b4ac-20980357592b@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.07.12a
X-PR-Tracked-Commit-Id: ea6ee1bac6034cb4e91bcc229ed1354ca1a024d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 253e1e98180a124475327f2ce7b6f15f2e4d0d45
Message-Id: <172108778354.25181.260564105341418366.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:23 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, lkmm@lists.linux.dev, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 09:28:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.07.12a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/253e1e98180a124475327f2ce7b6f15f2e4d0d45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

