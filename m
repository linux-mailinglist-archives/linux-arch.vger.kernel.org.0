Return-Path: <linux-arch+bounces-11167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F946A73E64
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 20:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B15173F9F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F11E505;
	Thu, 27 Mar 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH8/fbPY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523202FB2;
	Thu, 27 Mar 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102650; cv=none; b=efC9hKSCN2yBwGJAfFLEzqJ0za3sR3W0NlMnvmiaOLCRy6IX24kYROenwQQYd5rBb2Ih7TPfy0IrK/2+tzYpeR7F75DgE1Q71S3wPgT1TxUE7FireSG6KVl4hrGyl2eQeY3I199J4oalNnzkVq9L/NPIwN1zqhpPJC1fwwXQcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102650; c=relaxed/simple;
	bh=F7DdziDiag8V5MsWup5Xr5Slw4xfyna6XkFoCcmwLTk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IhbnyDV/wcQTU6vDXpDTQNMooc6wD+lLo8XegOGSQ+GaCmZ06nerc8++wfAcIf36H2jApkFrV847i0aqYJCD5IrATCI0JOe2Mv51aMtYn7ByPeWG9tdiAWzbNzBA9xsdXHll4fw4ZlXjRMc6FivNsjm6nEXn9RteTnTc67m8LAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH8/fbPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C403C4CEDD;
	Thu, 27 Mar 2025 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102650;
	bh=F7DdziDiag8V5MsWup5Xr5Slw4xfyna6XkFoCcmwLTk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TH8/fbPY7u2wRBXM0X649jazGOzd8GLGu1MF7DjHkfqfyLhG0U7P9O89P23swibrV
	 ZivbhUiD0+fM8RCRWdpz80y5hOjKnt+LmOYOuc2RmmpKMKbV4/4v7VGyo0lS60oMju
	 sNmUGvJnw2iUX8x8jZYQZ5q2dhTG+xF++UhebfUOfNOWQefQamJyuCxj27tPwWjkF1
	 zVQKjfg46VQIo7DfDTXhxW/0H59V6iBY5E90PmaFo9MuHDhTq5s5Zm15uYgWQrorFq
	 u4X7b17fIOcpooq3XkQ5SpvTIK20G/KNO7c49cMhgEq/DZjKZ/Yr65gWJ22mFoR4a3
	 tNyLln1g9/0fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE947380AAFD;
	Thu, 27 Mar 2025 19:11:27 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic changes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
References: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15
X-PR-Tracked-Commit-Id: ece69af2ede103e190ffdfccd9f9ec850606ab5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47a60391ae0ed04ffbb9bd8dcd94ad9d08b41288
Message-Id: <174310268628.2179020.11984549296225964286.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 19:11:26 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 20:43:17 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47a60391ae0ed04ffbb9bd8dcd94ad9d08b41288

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

