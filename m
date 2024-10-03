Return-Path: <linux-arch+bounces-7646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4998E781
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 02:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012B2282AA6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A5338C;
	Thu,  3 Oct 2024 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djer0Tku"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFD38B;
	Thu,  3 Oct 2024 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913841; cv=none; b=kjyU6cbCyDZp0NYIE4jrk0B1LUEbmaRWRSIpN9HocnMdxm4wSVPV/0y+82VT1wrKhrVhb7SmL7koBVBgez6W1pPjOz+JBvOY1H1Z0rzknjWJIaGsjHKGHmpGYkI2OWaPQ+mY1SohhEm07tpCuAfYeXgtZqduTQy2Pml+fMWzBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913841; c=relaxed/simple;
	bh=Xd2Em9aHIaQKl/IJuQ/w9cObYjS32+8TtCuPblP+Xzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RFPha4uPPRHLCes/AjkFBHEwyz/HMYXscWeZg4M6vvOHMhnnPYN87MftUb5WnqMhkjPMlF75qeXb9op6WlCKX5amfepMPxFunBHN/L9nC7WX3sL0bGCA2RISot8hM6qyijmDuRhjLKmQvRYmfF5TnFfmf6Xq1qwUb+0foFnDWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djer0Tku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9FCC4CEC2;
	Thu,  3 Oct 2024 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727913841;
	bh=Xd2Em9aHIaQKl/IJuQ/w9cObYjS32+8TtCuPblP+Xzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=djer0TkupW/XKIcd0jtJlByCCcTizxTGOhI6zqxl+5TQzEa7gAI6Ag7Pi+vLsWGlL
	 fqEvl/VjSxWyFaLK1k5VOFUsDY+e2ffzp9RWBFkORNPWmdjXK4IOrfhee9CrS2+26H
	 RiJRuMp9Er7iaCMLJhpjpaczKszRo94RYSXLB+Pospi1V2+OHaB9oMcQTpy9PrXKA+
	 N4y2+KE02rZ9fYeRkP+LZwTNrcJbjqbwkb/k3lmzJqCRJ9DqMvfX77D6nc/r/SGiUS
	 kto1wBewG633yd9kPOQTdpmAWcYwJXjzEk5OoJiXXIrhwQtM7m62WtjFsKbEncVi+y
	 QHwMlixs0Tj2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6BF380DBD1;
	Thu,  3 Oct 2024 00:04:05 +0000 (UTC)
Subject: Re: [git pull] asm/unaligned.h removal
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241002233614.GA81817@ZenIV>
References: <20241001195107.GA4017910@ZenIV>
 <CAHk-=wj7f32w8p1OrN4fahaF+44zWfTAD+3ucd=XETM_Pt-=6A@mail.gmail.com>
 <20241002221749.GI4017910@ZenIV> <20241002233614.GA81817@ZenIV>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241002233614.GA81817@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.unaligned
X-PR-Tracked-Commit-Id: 5f60d5f6bbc12e782fac78110b0ee62698f3b576
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ec462100ef9142344ddbf86f2c3008b97acddbe
Message-Id: <172791384429.1378867.422607401398764392.pr-tracker-bot@kernel.org>
Date: Thu, 03 Oct 2024 00:04:04 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 3 Oct 2024 00:36:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.unaligned

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ec462100ef9142344ddbf86f2c3008b97acddbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

