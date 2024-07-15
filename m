Return-Path: <linux-arch+bounces-5399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87CE931DD4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161A21C20FD6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF466143892;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frWB/PPj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C441E890;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087783; cv=none; b=VB/xP5MUEcmytOF5tbLzLAfRh1GKzDdmFR505q6TtXjSKoIEIrpfbJSXYP74+mdjc4JXjwl8R6CLWg/YkG0260V942DSFbpj1ytgpdI22l064vjUYAu8bFP/gsN5BLLnQw3cBAhfsJvzLiQfvYgUO+DiPS+h2cSJVSIn0efskr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087783; c=relaxed/simple;
	bh=7HeMkAj9hTEAk8gLx9fNHc5xHi7JveRIkn6Hdyt4iv4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mJHsVdQHwyPkdhT1ODZiLH7QWyIGcVGQlb83TaAHLClhI9eQkhF5zKdejLgmoRWy2cOx9jrEwhepwdZJ6idWC8d9UiKTK9uuh1v2ML8ORe9HSe9xP6oR7OWkCc6jZLjL4nEH4Sy7ArhkFVECyIyHxNoptealCuQe4dtjythbRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frWB/PPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F971C32782;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087783;
	bh=7HeMkAj9hTEAk8gLx9fNHc5xHi7JveRIkn6Hdyt4iv4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=frWB/PPjpx5ubJO15A3WlazEODKW02udngCjTRxWIffEOUCRYGy48WZMl/PxL+CXY
	 a1eyo17X32bngHRj1DiDEaJDXFxA2FufZGw7CjS48Yuug2ZcszMBHjsXBtA1yKaJg5
	 CT0GEfvASKu+oIoDS+1IKBmSxvsHTXeqzQRDorY7ccEpNkHccB/GlTFEVU1CcL0gMU
	 R/3pXCgZupbo/4GQyNVVMtZmYmUeMSgV5skGx780g6/jsTLx4XLSZqwUbnxOOALdZa
	 gVY2hLBs2JW2/5nnUtDCBrSBGiRy3mH+bxMtKVY4fnXpBHgbIL25OzeVW2Yq11qooO
	 cIn0WXK5GKgWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65A75C433E9;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Subject: Re: [GIT PULL] Emulated one-byte cmpxchg() for ARM
From: pr-tracker-bot@kernel.org
In-Reply-To: <52c8725d-7fdd-4fd5-a773-9a347a8837b2@paulmck-laptop>
References: <52c8725d-7fdd-4fd5-a773-9a347a8837b2@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <52c8725d-7fdd-4fd5-a773-9a347a8837b2@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.07.12a
X-PR-Tracked-Commit-Id: f1b5644862c5b594f48ad01d7880a96b95d83a2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4b729b0fac2d1b336df6d3e8c3fdb67ee9fff82
Message-Id: <172108778340.25181.12181251202970108692.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:23 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, arnd@arndb.de, broonie@kernel.org, naresh.kamboju@linaro.org, nathan@kernel.org, linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, afd@ti.com, eric.devolder@oracle.com, robh@kernel.org, mark.rutland@arm.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 09:21:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.07.12a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4b729b0fac2d1b336df6d3e8c3fdb67ee9fff82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

