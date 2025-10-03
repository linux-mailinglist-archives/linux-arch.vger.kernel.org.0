Return-Path: <linux-arch+bounces-13899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A2BB7E58
	for <lists+linux-arch@lfdr.de>; Fri, 03 Oct 2025 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6B4E751C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82072DC767;
	Fri,  3 Oct 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjM4soN0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A952DC761
	for <linux-arch@vger.kernel.org>; Fri,  3 Oct 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516905; cv=none; b=FmiQpIpspJ5jAsHpk2TsS38Qgfm2aw6/1hlIjhVNqNVWr7hjW8USzhaR61gDqgLaIqwIplM+JQpqbH73MpY4bLozOvjmMZlnED4ztnQh3N8bSLcUw0XCzLe3f/d8HsZJ51VlUugK/w+e2BvJ1ON6f9LU92sFUooNa7J8nylJKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516905; c=relaxed/simple;
	bh=qz0jXkHJaC+y9HDnYGM57iIvSi9G8aQYQoyhJat5qo4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XTQLpZ5hVIpIQ8hEDHnSllW7Q5TjZLW0D1/SUX+r0pTSQh5RPe+Di84VyJTG67GCF4/IDTd/smCZFmf2K+8Wfuj7MFVJJPRID9SySDSJdCIpfxhhIMV92nb0mxF4SdJOVDb816fb9WpiUx346i9Oo+yDTADWgNiezrl9QKZJGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjM4soN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6E1C4CEF9;
	Fri,  3 Oct 2025 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516905;
	bh=qz0jXkHJaC+y9HDnYGM57iIvSi9G8aQYQoyhJat5qo4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rjM4soN0Qn10cybJUZyG7dJ0vQGKAdDzooYQWXtu/nVLwwO0/sRUg29ywSigScydB
	 ZfKkp6/8Yk2DaW147TEMCunETtwbQe4WLQ2puLAmmSftWj+tuxjzApSVM1/2FAhQ+t
	 ceP/+LSQPNPTcIlveSH+Cf866t+AHTfm3jVhaM10ZutzVrQ8dKlswHykcnZSrgiEdi
	 UwmKQwtwWlXKnChMJ+lPjUSnyghVG+vkLHrH8t1So4ksr2Py51P9egDhC5aCZEVXJD
	 Pdj7JxzYi2D/WEn3mD65EG4DsjMOroNwSjLHTlaptQ8A9n4yXwQ29KK+0RYwJiAjRN
	 6EPImCBaH1Rdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E539D0C1A;
	Fri,  3 Oct 2025 18:41:37 +0000 (UTC)
Subject: Re: [git pull] non-vfs misc stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002061159.GL39973@ZenIV>
References: <20251002061159.GL39973@ZenIV>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002061159.GL39973@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: f037fd7fbca4d111955b5889417ddf6fb24498e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b0d551bcc05fa4786689544a2845024db1d41b6
Message-Id: <175951689638.34038.10476153248037363352.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 18:41:36 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 07:11:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b0d551bcc05fa4786689544a2845024db1d41b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

