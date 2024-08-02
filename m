Return-Path: <linux-arch+bounces-5943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A8946214
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 18:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174301C214FB
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141E13634C;
	Fri,  2 Aug 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJpdP40F"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421116BE0E;
	Fri,  2 Aug 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617583; cv=none; b=O4rUnyGryKoBn5qyVO0RqkeaM8MkWliGFoIzQXOHq5UdKXH5sDXidBH5C2vGKHhidMSRgKHE/JKBkjHNSIL8q2bEOe3l/rtdfg7tOApgu3Vssp3nhXxiDC5lw/hOkru1QnN8AwG/gwKbEQ7buVPeU+AVn8B51TP4n95mJlNaOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617583; c=relaxed/simple;
	bh=ksPx/nJVMGiJKRwCNbH4MWMtCx9sEzvONXFeeg4Grws=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Iq5kePJmW8VzTiuCrL2isKrXg3KuFrY+06SM+WTqyLr/RjITkp8O0t6Rxm0HxZTGhMaiRlngFusDgNs8nz0L9LB5zP1BbCzD9i61s7eGM5Pkrx8IIHuTTj51GG+XK6oyncICNqz8yUgWCbY763hfYo3PxmPrR7Mf1s6ItG6Mb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJpdP40F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F10CC32782;
	Fri,  2 Aug 2024 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617583;
	bh=ksPx/nJVMGiJKRwCNbH4MWMtCx9sEzvONXFeeg4Grws=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sJpdP40F3S7YmLRwecw1IU6GFRwnzBqNjVKyQi5aoxUgFmIQRZnLviiut6QGiFVMo
	 Yvr57OQrDeMd8hW5AcmOe0rjY4qVu+/TkevR1uMM93/pfS+PyXavrWdZVVZwOi/Iqb
	 OGJvWYknELKrVzrgmogWOqvgT439BmAT1NremOrHheCQfeIfUk1qAwpDyXWorjqZzh
	 lC+TtQLUqLgnmwKC8m1ADouyUKCN+wyFyxzDHF0F0kpMzNIlg0/aN+mJZ2TlWjv9ck
	 TfTV0u+PMnr6QOLKcYaMHW1KyE72ZeNSiQpvIDhD8RD8vZKJfd7fSpiKK8xX165dKD
	 1dKdbcFhJz2Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35A42D0C60A;
	Fri,  2 Aug 2024 16:53:03 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <9a365229-9f76-47ac-87e2-fdeafe8550ab@app.fastmail.com>
References: <9a365229-9f76-47ac-87e2-fdeafe8550ab@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a365229-9f76-47ac-87e2-fdeafe8550ab@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.11-1
X-PR-Tracked-Commit-Id: 343416f0c11c42bed07f6db03ca599f4f1771b17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29ccb40f2b543ccb1d143e54e8227b80d277bc2f
Message-Id: <172261758320.28369.9121389422290459623.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:03 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florian Weimer <fweimer@redhat.com>, Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 02 Aug 2024 15:29:25 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29ccb40f2b543ccb1d143e54e8227b80d277bc2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

