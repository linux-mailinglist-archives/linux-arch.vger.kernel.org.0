Return-Path: <linux-arch+bounces-4441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827C8C6FB7
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 02:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4ED1F21F10
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 00:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938A522F;
	Thu, 16 May 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaNX86Q9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD54A3F;
	Thu, 16 May 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821001; cv=none; b=MvYihZ26MdYOS6lSokX/tdOczV5LYhlPKq7KZ5Nr38MF609XbME6e7rLvuCPyxehw6fsO4AOT4CJxlptcELoEvs6U26jht1EJqCrCq3NKN9HPTBgY0Lqe5lHKw5jMv1+XKFHw8fqrJ9y18XKCyxmkQ510m8Jv5UBz6N1UVOAdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821001; c=relaxed/simple;
	bh=RZqXihDKwwl6roptdsNe65gDMPagfXaqrff9GjtkDN0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fOHQsowQy78XEgjenPcJBnJgZEjNtisqpKo9wMNUTz6caXcru6x2Ov0g+hN1GjxoUmOP7xpE00BNGKz9S2yNE6An2GcmnbziKqO90H+1yO6cqL93ss/pTT8qY0QBWxJPU0lYv3+BW7FVaeXwVJ3UGdIhn55likbkH5SLAFKKzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaNX86Q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1F38C32782;
	Thu, 16 May 2024 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715821001;
	bh=RZqXihDKwwl6roptdsNe65gDMPagfXaqrff9GjtkDN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OaNX86Q90Xh1cwLFVq3NbGVTvoWYQF4CcpdTyUGihBtH9+MObm1iNSDmaDmiahyWt
	 8ijVsLiyCxk7xD15g8Ym6rRefh+mP+2wnYKRs0Glu2vABop894KhBwePA98ymqkjPa
	 o1o21CGZQhSOfdp4v+6F82xeFxFr3NF7ICk6ME2UaF9XSamXBlz6S65HaKHp3Z+wKH
	 LwUuUAJ1y2shHAwGhMfll7PknpvVnrOThV6VSVMqNlxWm1z9EDo0bI+lxhGkP3lOMy
	 kLSLN87EBeTl7xiGlMm6PASu1WYf9Uys1Gh4ygFMqmP3/2TjUUfuM8/o077tswMeBX
	 +ofYlTS6aeYaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E76C4C43332;
	Thu, 16 May 2024 00:56:40 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkMfS727s_1MQWzQ@bombadil.infradead.org>
References: <ZkMfS727s_1MQWzQ@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkMfS727s_1MQWzQ@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.10-rc1
X-PR-Tracked-Commit-Id: 2c9e5d4a008293407836d29d35dfd4353615bd2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a49468240e89628236b738b5ab9416eae8f90c15
Message-Id: <171582100094.27993.18157939993173010013.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 00:56:40 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-modules@vger.kernel.org, mcgrof@kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rppt@kernel.org, song@kernel.org, tglx@linutronix.de, bjorn@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org, philmd@linaro.org, will@kernel.org, sam@ravnborg.org, alexghiti@rivosinc.com, liviu@dudau.co.uk, justinstitt@google.com, elsk@google.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 01:22:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a49468240e89628236b738b5ab9416eae8f90c15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

