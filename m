Return-Path: <linux-arch+bounces-7476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE939889A8
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 19:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B641C2133D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F271C1756;
	Fri, 27 Sep 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irmwQ0ZA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A31714B8;
	Fri, 27 Sep 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457897; cv=none; b=jYihs+2tPaOKoLdVyyFHI6elDstfezT5GmaOsPTxPlSWdiuix2iDI0XWi8wQzzZNp+ld8hlaKMmflPRpQsnIh0S8uHF7VIQH+K7gjYrKLEQtTm0xDDkHUuIk12wqDw4J6BeNJqWI8szXpi3oa27OhIFTnB5+osZ6rSjykAZRCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457897; c=relaxed/simple;
	bh=CIOcRkI5PSg0AJNUdw+NMCW2SFvCLDXu5df8u0Jeg4k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KWCyM0ZOp18+vKnalhaNwh/nVljAAOQaTp6o0vF+VpAgfDW6BGWHm5wR183xhI8LfPUp2i9dzF0kYgOEeYtHL0W3nGe5Gm624VnyUML0fCZ94h6BMogWFWcHTNk2H8KSLXNoiY4nnAoj5MXAOfkcobp7oN7HsR24B+ytx4Kd84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irmwQ0ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DAC4CEC4;
	Fri, 27 Sep 2024 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457897;
	bh=CIOcRkI5PSg0AJNUdw+NMCW2SFvCLDXu5df8u0Jeg4k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=irmwQ0ZAm0iJtnH/Rg7sYzOAn4A/JsOE+Z7aX0OGkXtxcs5chJgRAdArwySyzmsjD
	 KRB4d9MwuqPUeQ5exUbISfLOP/1koAHqQrVgtiHXS8RkdBaTY+oMK7p5F7dCsiEamC
	 hVwsYgDOcT5BgEYVz4RDm2ID2vF/X2IHP5OWF71Sg9jcgMSyqtqZyhG2L+LAenKVx1
	 BUgpH2lMBZZmgi+udKy4O9o6i06kZvIGY1PjEDeHGFIJ/Bd69DMEL1dslMO55TDthh
	 bHkj3YKaCjthSPPQLPxTiPcS9z3QCNvPQ70GruM9GS4lJJ5XrSBG1A6ffJZVGNwOTH
	 h7axmotxVmbfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9E3809A80;
	Fri, 27 Sep 2024 17:25:01 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240927142320.2144898-1-chenhuacai@loongson.cn>
References: <20240927142320.2144898-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240927142320.2144898-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.12
X-PR-Tracked-Commit-Id: f339bd3b51dac675fbbc08b861d2371ae3df0c0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3630400697a3d334a391c1dba1b601d852145f2c
Message-Id: <172745789970.2030610.6201608111296713701.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 17:24:59 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 22:23:20 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3630400697a3d334a391c1dba1b601d852145f2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

