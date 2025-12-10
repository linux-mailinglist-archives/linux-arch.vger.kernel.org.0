Return-Path: <linux-arch+bounces-15319-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F107CB2598
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 09:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B71D3018429
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8012FE079;
	Wed, 10 Dec 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi4OeY6v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922711F872D;
	Wed, 10 Dec 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353861; cv=none; b=J3t8A8v+9GvzE+h+EqZtG89+pdogf79YViUcyHqywnjDKgp6aDpWRR0uU1vo6qzrkDnGQkKSn3EOKiTfWptugSzyIWmrzZx9e8e8TMP21Jf3tSc7z/+v7joROaNwlZoahnyv5D4qIPa04n/5kI5Xs36wsI1CoTL4YYWEuXOOXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353861; c=relaxed/simple;
	bh=hkoUkofK8W/Q4Fi9ex0vJ5VYhcoXf5KYKI1mh45VxlI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ID7Zt6WTpWSJd/1k5ykoQwPHJSmFDyVpMrnRgBrAarzL2MUAZmog3qh15HcWNMcIKDpnp3Y1xGeHOHny8eKIif3//IuY1VE19R6Z/iFG5uAnuSAopb2yGPnvJdVBiRV0uwv/o6VNfLk2PFmkTbIhYPRIao06lKitSG229bmu6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi4OeY6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F0BC16AAE;
	Wed, 10 Dec 2025 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765353861;
	bh=hkoUkofK8W/Q4Fi9ex0vJ5VYhcoXf5KYKI1mh45VxlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oi4OeY6vZ7yecCkBJG2n/mezdYemMNcvWuaXGeqsAU17Rwnx6lwvjjvpmwL+QmDE0
	 M3E2cKvAq4Is3IFluWO62eGGe0ZaX2WB206XCCYbfcQldy7uCRcUJOuOrsy99ax54i
	 agIcLXiGNU4mCEZOUTHPVUmm+NOrAR19Ngg/kwQFyYrPVwxYbrGl1DXtGxE6Nj38tm
	 aWjk91vXhQDJghNZDv1foFmmmP+paPAzxcAZQPpJjqxVD7p2wz2IcautxLCuWiTTVr
	 FLehwQPpmXBSnjd6I1w2Sd3OYVaNnXulyr6q0j98Kkgq/x15lAGbg2aK71/jK4Bzuc
	 4xfDcwCEZsuwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BEA53809A19;
	Wed, 10 Dec 2025 08:01:17 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251210015523.14737-1-guoren@kernel.org>
References: <20251210015523.14737-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251210015523.14737-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.19
X-PR-Tracked-Commit-Id: 817d21578d51e801df58ab012654486a71073074
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 565848bb3bcdf166fd3ff982376b30806eec0180
Message-Id: <176535367578.496531.8508836035457449254.pr-tracker-bot@kernel.org>
Date: Wed, 10 Dec 2025 08:01:15 +0000
To: guoren@kernel.org
Cc: torvalds@linux-foundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  9 Dec 2025 20:55:23 -0500:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/565848bb3bcdf166fd3ff982376b30806eec0180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

