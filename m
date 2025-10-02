Return-Path: <linux-arch+bounces-13829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307DBB23B9
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB16B4A27A3
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 01:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5131CDFCA;
	Thu,  2 Oct 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSgpB8WF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569631CBEAA;
	Thu,  2 Oct 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367462; cv=none; b=uyCvdYA3Ols53BJa7k8faBXdCTw2Ur/0WyLFJxIuaxJlC8jnfuJ2m1bMGV29/OYvEq22htfe5+ovbb36lMfXWCla1vZQsCwp6gxQA0Y+7oN5WXdSDk6bsYO4iXTLuXsR2SkvDKI4OWVJON0rTut9Vc8QSRlBynqzvHIzanMnKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367462; c=relaxed/simple;
	bh=uVDyCERNUjOod9Whu8MaQQGgrpgB/6cwPaHpJGQjG8I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fhf+OcWk1UnEjxg+GohWLiAvoH6er6F2OaIXBeLKRIgriNGeBr7GAcH+fuUjkMv5uVEHngiiTXu5p1Dh4VuEs6rtV9QW1h1ZVyir3ZwZt8UJPH6HjIw1/gjxSdoHuPxOmdfyJyItcJcZehetEwbIUTW3PZ741EZ+BYoj23LSrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSgpB8WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39835C4CEF5;
	Thu,  2 Oct 2025 01:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367462;
	bh=uVDyCERNUjOod9Whu8MaQQGgrpgB/6cwPaHpJGQjG8I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hSgpB8WFomdioOQKe5Zy2DkiCcEGjoqrLfavcFE8rvtz5xb7S2Q9w3PjZeqJWfNCi
	 fsN700NPOVwGHD3jjd5VIUgjrQ3LwWhRuu4bc4824WNeC/vB1YNeLLkdKIcRWVdQlt
	 2c6LweK9n8f7XdKG8qijsbCoL4Fx8S9ypaMcqCfLmoFxDvz8wFcW1n/2v9R0Q88/pJ
	 pjCkeuKfWmNlKzlzKuoQ/gEQeeUbmpPSAltwWYU6gsjRQmw0+F+RIZbwlX/mTaijcv
	 z26QL1yP0dN/0F9B9rB0gTgdZ18vLrZ035I+jWQNpTykOVnnevKgA+h0X0bS/h1qhO
	 jBSYS7lhZXfRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F239EF947;
	Thu,  2 Oct 2025 01:10:55 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <7617c200-a7a1-4957-bf5b-c1cc36487563@app.fastmail.com>
References: <7617c200-a7a1-4957-bf5b-c1cc36487563@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7617c200-a7a1-4957-bf5b-c1cc36487563@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.18
X-PR-Tracked-Commit-Id: edcc8a38b5ac1a3dbd05e113a38a25b937ebefe5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2b2fea3503e5e12b2e28784152937e48bcca6ff
Message-Id: <175936745462.2689671.6313874170065271211.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:54 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Qi Xi <xiqi2@huawei.com>, Varad Gautam <varadgautam@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 02 Oct 2025 00:34:49 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2b2fea3503e5e12b2e28784152937e48bcca6ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

