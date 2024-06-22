Return-Path: <linux-arch+bounces-5020-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51559134C2
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7215C284771
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9716FF4F;
	Sat, 22 Jun 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5HdS9RC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64316FF4A;
	Sat, 22 Jun 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069672; cv=none; b=lN9N6COG4YDqZyaC0FnaGRT5b8ZJUkVUOEETMY+Svrau0/o6gtLEuVri9WZIIkJIV2mElcTdAA1BA12GoVF22Lm9XojkmywGACSvddi4daPyn9hoOPz5Ezay/fOhJlh/SzAVUIWY+iP+VLzWeK4ZIMehorlRmKsVr91uIWLaQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069672; c=relaxed/simple;
	bh=ig4B8urytXNJAD4nlBpdcNFAnbL+q4t3qP1BQdXlWG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LSIeyEV2FdSoSFYIoCbkwfG0BKBJ9/OTH5889aJBEdCvifcRTiDW8vK6i/pvZeYmb9OZ+zpS9SBG8crzZsd0yciwBpOhAjKQ+uMuVm4GziicFlnJw/jPXMdD0CV557C5hF9fpJc88noENmVOlXQqWZYmFeoF/a/yCfttd68PohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5HdS9RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BC54C3277B;
	Sat, 22 Jun 2024 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719069672;
	bh=ig4B8urytXNJAD4nlBpdcNFAnbL+q4t3qP1BQdXlWG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N5HdS9RC9axy8t+gvymsbcmRH+HuFFFL9Cuid/fH0NpcIOpud7fTTjlYXRceCp3KM
	 B2L56YietEDZXYSNAwjVSXRExbUfQ7e7z94pp/vG51SSZsYY/Dt7i294lMIFQpyJiY
	 DJM5I5f1ChMvlqmFFwyoXY/NjsPJlcF8n2qWdLUEm9tkLAKjvlf1pchbn5/uLWGwNp
	 921J7iI+lDEbHEQnNfDQIGQXuGcbv1yvXY5MfKeN/T4hW28AW8NYvwv7wvKnQWluTk
	 JiBg3ORDO8lEoNUJMIyuXgSkmPyec/CQdGcZJO3ofSL0cahXcomPCauZtEiJWd7vO1
	 X0TGuBpioz22Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3E32E7C4C8;
	Sat, 22 Jun 2024 15:21:11 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240622073206.1578052-1-chenhuacai@loongson.cn>
References: <20240622073206.1578052-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240622073206.1578052-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.10-2
X-PR-Tracked-Commit-Id: d0a1c07739e1b7f74683fe061545669156d102f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4ba3313e84dfcdeb92a13434a2d02aad5e973e1
Message-Id: <171906967199.9703.9586579152126681197.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 15:21:11 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 15:32:06 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4ba3313e84dfcdeb92a13434a2d02aad5e973e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

