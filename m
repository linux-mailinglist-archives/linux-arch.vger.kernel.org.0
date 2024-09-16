Return-Path: <linux-arch+bounces-7332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6106979AFA
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 08:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CC31F23789
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EC130E4A;
	Mon, 16 Sep 2024 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCnpkRjO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF47813CFA3;
	Mon, 16 Sep 2024 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467141; cv=none; b=PyF36y8oz+PaSvmxJFYWRDEWoSoOCRny++9LeRU9UXKzMKyFhjPfWEN3mYMwcSul7YTtSaad8B1ga6z3pplm+8c0gtKEbjSKpCj8tJRzKVIGfFgLtXiEVD7gArdHhiYjWV8QSp05bZdOGHfrICgqQ6edxua1/jPUvKfAewcLBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467141; c=relaxed/simple;
	bh=B1Hp5Xluo87VW1BZhL0s9i5AgPSlY42Nc/7n3gIHCFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sc93KoFRlnol0UhKKjP4+3MSNyqsIXocgjyY3txeabhYwPApE0TaAR9k6rDNUGuH8YwrJ2LjlTjHx28ne2aaeftXbgLAwPx38ceULyzp2t1upWB4y67RMaPeu6CLZFfIuB2keS4lFEamVWmtVKL/EImZ0vamxeKlcDmzEkV2dN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCnpkRjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D41C4CECD;
	Mon, 16 Sep 2024 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726467140;
	bh=B1Hp5Xluo87VW1BZhL0s9i5AgPSlY42Nc/7n3gIHCFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mCnpkRjOa/QXbzBBj/8F2MBzn+kmI52jgTcLqGBVyGyMM7hd5ZdJZ351ShpgModW0
	 UXXO3iQ7FYCXf+elX80WC43/FRp3cpXcNALMe4BQnA3r21d8f9SMrviK/RU6Vd9ilH
	 eq8Ib3NQgQR9bJogiIP8Yq5uW8qgp4v4InX1xBtjwIzHa6QLNe6r8tovviodQyfvYR
	 Mw53ymIxuM+MeroTexMmevexplhRLWwGZAYCHdzxwjJ35upzeflcWwQ5sI13xjpXad
	 +4UBC629R6sZLvt1sGZD2i/CUji/dLKkoHuT9jDCApXlsYmK/oxlAoT72ZduN3Zoe+
	 oRkLJeftwpfrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3A13809A80;
	Mon, 16 Sep 2024 06:12:22 +0000 (UTC)
Subject: Re: [GIT PULL] Emulated one-byte cmpxchg() for ARC and sh
From: pr-tracker-bot@kernel.org
In-Reply-To: <c22df1ae-42b4-4a57-91f7-a02e50176ad0@paulmck-laptop>
References: <c22df1ae-42b4-4a57-91f7-a02e50176ad0@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <c22df1ae-42b4-4a57-91f7-a02e50176ad0@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.09.14a
X-PR-Tracked-Commit-Id: c81a748edefd098ea21dd35d4bba03f69412fc26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e799bef0d9c85b963938d8f31806a898385a5b09
Message-Id: <172646714126.3261404.3416020596097312091.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 06:12:21 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, arnd@arndb.de, broonie@kernel.org, naresh.kamboju@linaro.org, nathan@kernel.org, linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, afd@ti.com, eric.devolder@oracle.com, robh@kernel.org, mark.rutland@arm.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 00:30:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.09.14a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e799bef0d9c85b963938d8f31806a898385a5b09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

