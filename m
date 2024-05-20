Return-Path: <linux-arch+bounces-4475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C298CA481
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62DA1C20E3B
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D313956C;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXGI+AAk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97111386CC;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244519; cv=none; b=NFZtdQZjaOlq8OH0VLST0pNZ/g2ePV0ArAXc9TlOmIwwZtwIPGeUGongsPTaW0o6aue0j/93okI1V/1o9umtCxskKVbtO5RiZoNLI6Fw2KAvVPqGlFmjWYDHhdtZxVjSgAfHW5mQ2VKslG16lwd/SwtrEYsyssIXq9kKMyqfkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244519; c=relaxed/simple;
	bh=6GpFThWU90lVTYGUBf5fCvKh1g6j+5JsQa0f1onbvhk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jO5IJJOVX1iu2RDQm4NY/b1QrM9a5yLPMmxMELaew9aNmQt+pbWGrCS/Xdj0xtZPLO5v8cFj7P+qjk6Lytp+TEFulJ/KTDeOgFp27jaNxhqxx+q/qJ7UuQjK9VJCBh4Bkp6j6EMVIVHji1XIq4EeS3SNtZTLhMeTZOyRZRy/4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXGI+AAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99E86C4AF0A;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716244519;
	bh=6GpFThWU90lVTYGUBf5fCvKh1g6j+5JsQa0f1onbvhk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FXGI+AAkDPWiiB6tbHLmSBccnsndC3Fm4vQpF5otsZAsBxtGf9+YwIaHdI9T2JILW
	 MSo9drNkTUZVkUC50ZddM7uKJxfDIhxTTqyOMmI2V9QNrHuo0v9K5+K8O8PdW7Q3Va
	 6BY+252KBk0R7WyAkB5tqSYY2FNuQS5VN58UTBU6lTEssKCoJAMz+9ugAAX9h1Y9YB
	 6fHjd/Z9jjLyVs+I+vpgSt0R5VMwpmbzGvEtSSUwjlnqTnhp2TliUUIcOPZMhNLc21
	 tfyxSKUR/h7MD9w/0DSidt6OUQocyKTh4v8CC+t9M74AFs8IlaVRXzTkIV0CvK7uAM
	 WseS9aDY+rw3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F3C8C43332;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
Subject: Re: [GIT PULL v2] asm-generic cleanups for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <53adc3c6-9d79-405b-ae34-7a4c957a7bda@app.fastmail.com>
References: <53adc3c6-9d79-405b-ae34-7a4c957a7bda@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <53adc3c6-9d79-405b-ae34-7a4c957a7bda@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.10
X-PR-Tracked-Commit-Id: 34cda5ab89d4f30bc8d8f8d28980a7b8c68db6ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3eb3c33c1d87029a3832e205eebd59cfb56ba3a4
Message-Id: <171624451958.22728.8053445995249042669.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 22:35:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Thorsten Blum <thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 21:50:04 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3eb3c33c1d87029a3832e205eebd59cfb56ba3a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

