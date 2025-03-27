Return-Path: <linux-arch+bounces-11168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DDA73E66
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 20:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E6C3BCC43
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6651C7001;
	Thu, 27 Mar 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu83p8CR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A781A705C;
	Thu, 27 Mar 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102652; cv=none; b=pa+pE2r7tZGMl7PT02rZhodQMSBr0IGum+fW4dni8yZ8PNx1iUh033AoNdmggD2tTfS6Cmv6o9ZSgVakolXn03pj4Iqy9hAjcSmsMnCHC8lI0smk1bebLkW3afdDBrhaa49BnbgSqYPk0e5JgpCzFLQno+8ngU2U3KxrQG7B+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102652; c=relaxed/simple;
	bh=QNKdw0/krelN5SivWfyCW0yVWSg7FE5l+0A7gHoJUxM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ofh+oX52NRUfxuRK9Pu4GhqJKNVpSZn/zFbL+0LPEJ5YLvYwlnSE6mzPvb9oHgAvSACXpbhRYJFpx+BK3rlJUJa4eN2UFLqL7WVrVVgTa8tcHqH8h8JSQoataC89pnXO3vRKwlbKWkmgVLJP0nBeRN8skCiLutbH+DPzJFd25r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu83p8CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB31C4CEE5;
	Thu, 27 Mar 2025 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102652;
	bh=QNKdw0/krelN5SivWfyCW0yVWSg7FE5l+0A7gHoJUxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pu83p8CRHn68CY4zjA1R6ZTrU6aWnpFNt991L5tBFQyUmNoeVC4SD9SP+P2WJnLyK
	 PdXjWNFt786GMiTmTt1btN9X/esDIa0WrLHCUEdxCERN9UlYy+Di9XwCsUytiaoeHG
	 I/ROGC3TkKJi1LU43+RfnAegLBOA2QGX5qnE8sUrXmobLGn6ukDtYwq3xDlMGRw2OE
	 oI2sAXH39rDwV2i+94taIjmox9jm+sL6p1OFDrIwAljYhRiGdiWukwepflvnsRpcpw
	 9jj6WYg1RpOBuFAFf41iUWr5pelCPLprMXRLJ1IxLpIY1fnvHhYta674vEMWfNY39G
	 tw+8J++Ls9Nng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9B380AAFD;
	Thu, 27 Mar 2025 19:11:29 +0000 (UTC)
Subject: Re: [GIT PULL v2] asm-generic changes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <d37aac3f-8220-49ba-ac01-88dfa13ef6b9@app.fastmail.com>
References: <d37aac3f-8220-49ba-ac01-88dfa13ef6b9@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <d37aac3f-8220-49ba-ac01-88dfa13ef6b9@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15-2
X-PR-Tracked-Commit-Id: 47a60391ae0ed04ffbb9bd8dcd94ad9d08b41288
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a90a72aca0a98125f0c7350ffb7cc63665f8047
Message-Id: <174310268852.2179020.2638461971939703806.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 19:11:28 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 11:51:51 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a90a72aca0a98125f0c7350ffb7cc63665f8047

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

