Return-Path: <linux-arch+bounces-863-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7A80B640
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB41F2102A
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F5882B;
	Sat,  9 Dec 2023 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWtbGn3q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A241C6AA;
	Sat,  9 Dec 2023 20:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 436BBC433C7;
	Sat,  9 Dec 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702154055;
	bh=TYueBuMxe1Cd7Vs7fS2FZ4S5BtxUKU1puYqavvmzD7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qWtbGn3qPTLbfzylBWGgxR1VNxadp6dsxfPtJkx/OIrvuDo+rij6/9ve9D7EDBh+W
	 kR9cLMj/p9PlZwDoyXi+Ulwns0ZmD3AnbTcV6NMTiDUaYPc9cwomgjOnIeUynjKS6P
	 QUUx3O5oZzpIMZtr432Igt8ARFWXJ0FVKha3eXLwgom7fX3h+BSJYcoX3SH5erPhSW
	 Z5npHfmQSdogOfNQ2Kwm61VnIU9Ler0J4zFb2J6kcvRjHiQ1kcPdY0o8DcJeX+Kk/C
	 TcRk6cvEWXDqVRzVFGOcKi/OJVrXH295bpF6yWOoSicEP+s885n32vrAtdqc3O9SDX
	 SfR7k+Govk93w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3187FC41677;
	Sat,  9 Dec 2023 20:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231209112317.1542046-1-chenhuacai@loongson.cn>
References: <20231209112317.1542046-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20231209112317.1542046-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-2
X-PR-Tracked-Commit-Id: e2f7b3d8b4b300956a77fa1ab084c931ba1c7421
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b10a3ccaf6e39f6290ca29d7c24604082eacaea0
Message-Id: <170215405519.1707.5261207253564127214.pr-tracker-bot@kernel.org>
Date: Sat, 09 Dec 2023 20:34:15 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  9 Dec 2023 19:23:17 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b10a3ccaf6e39f6290ca29d7c24604082eacaea0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

