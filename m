Return-Path: <linux-arch+bounces-12164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CAFAC9B82
	for <lists+linux-arch@lfdr.de>; Sat, 31 May 2025 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3204A3FA1
	for <lists+linux-arch@lfdr.de>; Sat, 31 May 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD272D600;
	Sat, 31 May 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVF4UGyj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D079D0;
	Sat, 31 May 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705386; cv=none; b=ZGwaCDQTNt3LW42QrmzDviXjJMI1rz3OpKFW9zSZfbIK5zSh2Ut7nYTyS9XvqngwZyIvTN7W+vEHoWWIWEKNUgU0Fnn+LQm3uoQjjT3QHKgMrmDJOMDwrmXadKpqAjj8WK2PgvpFZ3gFn2wY0SaBDljj+8ZDzKPNCf7af6wtqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705386; c=relaxed/simple;
	bh=faSEr/ZDlFC0XgCH0YCQ45nbWzlbbpXlLkx4FVTW9ow=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AjsCOlgrEySlZuGEyUnpIS5d+e3Z9iWNsqLYHYU1xgn+TynkY/6ZwJ+wB5ThrLkoHQSOxCwlgVyZDwag8FD/avYD5HPJqLRZpiyI7AmplR9z4D/s+HwJR+gf7dUvpPZcExg7WdHKItFvVu93sdhHapae6nSH/bozW4EoLBzDQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVF4UGyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474D2C4CEE3;
	Sat, 31 May 2025 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748705386;
	bh=faSEr/ZDlFC0XgCH0YCQ45nbWzlbbpXlLkx4FVTW9ow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IVF4UGyjqp38xG73gTpKgMsAM0G+XV0xRgm9aflQKAULcw8EEQvLGdwteSBlNasDk
	 E0DIC3YVvveVp1q07UWoIpgEk6ZW4GmcD3Pt/3I7YvBgjbcF1Tyw6f2FUfmQaOrLi1
	 O4J4Jz8K0HsFTy/T+k2R8nOu4SgBrlUUDh0xhvNRiPMin/2pwfzAQSv0Pw1p12gtYr
	 ET6dPdHl/QTJz9tnhSt+PDCDB0oAjpXnj11qRUIUsgolJ7TwJCiJbxN8DGJFDtvD6v
	 dH0pNTXVUh6JLdWl9tiofV/SIeQBj+kv7SssnEtT8cmXtIUkzCxS6aOcWRnMAloTGi
	 Dfbl96mgzChsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE38C380AA70;
	Sat, 31 May 2025 15:30:20 +0000 (UTC)
Subject: Re: [GIT PULL] require gcc-8 and binutils-2.30
From: pr-tracker-bot@kernel.org
In-Reply-To: <feab370a-3857-4ae9-a22d-1ab6d992c73c@app.fastmail.com>
References: <feab370a-3857-4ae9-a22d-1ab6d992c73c@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <feab370a-3857-4ae9-a22d-1ab6d992c73c@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/gcc-minimum-version-6.16
X-PR-Tracked-Commit-Id: 582847f9702461b0a1cba3efdb2b8135bf940d53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dee264c16a6334dcdbea5c186f5ff35f98b1df42
Message-Id: <174870541922.163157.8980112873932103512.pr-tracker-bot@kernel.org>
Date: Sat, 31 May 2025 15:30:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild@vger.kernel.org, Kees Cook <kees@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 May 2025 11:09:53 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/gcc-minimum-version-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dee264c16a6334dcdbea5c186f5ff35f98b1df42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

