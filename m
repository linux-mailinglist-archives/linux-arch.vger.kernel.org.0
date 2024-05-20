Return-Path: <linux-arch+bounces-4474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B68CA47E
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 00:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02AE1F22266
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51664487B0;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3hT55eE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D763FBB2;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244519; cv=none; b=egrCqcXo9KwjJ2vdPI14Iq9mdU9maXdjBv/t5NnoSlq8NYyKshH3Ft3u1ajf1dYU5dtDC+/YJ1hD1r5rR4K9xHq6doNOHw+DARcimdmoRb/kH9ek/PR1TU7VClSZHCgFnN4AfOSON0tHpb7KPYvM/s8DjoG0/h1RSGgoxXfXPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244519; c=relaxed/simple;
	bh=0DwPmabtpMH/Fz85CSMeMhzQTvLQzVgPV9DmaNNWnew=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FPCwjUHkiE54Vfkw+ZXavBSouLwUFE0ypehywKzjMaxf0xSyngMRuqSENjQYA7x3BsR0wmKbJtEyRdQ/Rq8IZ899NCcg09T6vfHhAQl13upIpRy74kcaZQ7lCpyyL3elLvyNoTRAocLmG9oG8SFPztYYkocYEDb2w6ROxiSV0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3hT55eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07667C2BD10;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716244519;
	bh=0DwPmabtpMH/Fz85CSMeMhzQTvLQzVgPV9DmaNNWnew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B3hT55eEyHf+HH51ICWkUAvwl1cfXAQgyzBwqNiAp/iIxpBnp2ITLhJT7Q5nWCAh5
	 uCkP7Nei2SEcz+QnClE2k7jnA9Ju++5rGJiWKr/rRgmvGs4q1gYR9fEsw6ooi9bToo
	 +gEXNWWHo+e/h+f9MFwMSTlp1TNLBTtCh7+JpkHv8MBhOU3vQ+XeOtimnNKQ0G3HmS
	 HW44+DB+muGH7HT6JRiPLZgNrt46Y+7cQVA1A8GwJhD6NBtuqpggl5cQEkG+UX7dwg
	 WEEYanbo8ZF3FsBQ8lmpBav//6WaLK0Dl/PVIpK+AoQyuGA5YO6Aqvpn5lCgfsqJNF
	 XGIuzCkkXZUhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF53CC54BB0;
	Mon, 20 May 2024 22:35:18 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic cleanups for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-6.10
X-PR-Tracked-Commit-Id: e7cda7fe37ff1ece39bd2bf35ea68b1175395d95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34cda5ab89d4f30bc8d8f8d28980a7b8c68db6ec
Message-Id: <171624451897.22728.2848745474385924149.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 22:35:18 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Thorsten Blum <thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 23:17:01 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34cda5ab89d4f30bc8d8f8d28980a7b8c68db6ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

