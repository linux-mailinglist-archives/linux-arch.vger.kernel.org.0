Return-Path: <linux-arch+bounces-6130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428EF94D575
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99EC1F2210D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C1149C54;
	Fri,  9 Aug 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0skGR8I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1314883B;
	Fri,  9 Aug 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224680; cv=none; b=lR5ljoAt5if6EiY4bdFEK0FFYxQgU+HnA24xQhur+1jQ85dk2ylse7lkD8TVNXInKgn9pjGGRntMGydUL8KOJM+2B1QGdmjFVwLfqDSVFXMRmZR3vDpmK6mI+VtS/HN3hjHC/xhgZfMVh3IqbhhIMSSUsXqP8VFH5FMq3nZ6Jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224680; c=relaxed/simple;
	bh=p1gH2miTN9U8tur3s+82qPlwtUK74BZDRZUcQUopPLg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GpmmnAV8viwiWGDz3GAswc6g+3kqRI6wTx2/NhisRlFEcosD9Egyjj9Pzc7s6hzw0NMMETawgX9CVAIy8/wr9kbYknAK6FlhPVrNuMB/qpeM6UrhkHYTz11Sjunxaf+mnVhNcQJ4odvHlcvYadvGYWRxsr+egkTRwSwSNpcuIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0skGR8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49104C4AF0F;
	Fri,  9 Aug 2024 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723224680;
	bh=p1gH2miTN9U8tur3s+82qPlwtUK74BZDRZUcQUopPLg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e0skGR8ISK1YdjWDO+rh3acRjKfNbkf/CA01IH+7DBeHe9adfWPqeQK1AA8SEqylT
	 +n8oi4647/qMJOQ6cluPVipUKpPolz465Pri8I1b4JsYZpt7rP2whrpb/RTsRwgfwz
	 NHZ7u+kQutd8VpLyaIedeEZQ+r9X8Vn9MvwZfr6DMA4578A2vp7EcoOu5p6kwXMN8b
	 q3sAVliVzLhlwq8dWXTEPek4ZOh1LcqYU425wKFbA2lnWGLfFO4ashWtd6+WffxkaD
	 gayn/e1hZko26+SldFvwx+LOhhH5Qvg9jXw5J1mgXNbWVpFtPj0JUOjPvZwFQB4dXP
	 zg1bhe3e5r8Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3E382333D;
	Fri,  9 Aug 2024 17:31:20 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic fixes for 6.11, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <30fdaeb5-520b-4f41-97a1-072c035e1b1d@app.fastmail.com>
References: <30fdaeb5-520b-4f41-97a1-072c035e1b1d@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <30fdaeb5-520b-4f41-97a1-072c035e1b1d@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.11-2
X-PR-Tracked-Commit-Id: b82c1d235a30622177ce10dcb94dfd691a49922f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58d40f5f8131479a1e688828e2fa0a7836cf5358
Message-Id: <172322467896.3855220.9485258661473132487.pr-tracker-bot@kernel.org>
Date: Fri, 09 Aug 2024 17:31:18 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Rudi Heitbaum <rudi@heitbaum.com>, Jakub Jelinek <jakub@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 09 Aug 2024 17:59:35 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58d40f5f8131479a1e688828e2fa0a7836cf5358

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

