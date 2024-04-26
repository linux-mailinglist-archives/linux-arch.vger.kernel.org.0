Return-Path: <linux-arch+bounces-4022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA38B3EE6
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 20:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72311C227E5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7416DEA3;
	Fri, 26 Apr 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAEaN3WU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3516D9D7;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155000; cv=none; b=qzp9rFXSQSAU4qqUNQcUk+zLY0kRx7n2/7eOXrDbeXRlKmEwQ4ipA8dgEDMxLDIW1c1rFnQ9Zz7vF7KSc/MiS1jCDhvfLmXMG9zQH5f9oxQUvdHLjoN4A3XDG7TGkdsIySti4ACbgeJS8oSmaO4Z0OR7eWarTNj4VCMe566tWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155000; c=relaxed/simple;
	bh=ZoBifVMjOnUKbCOJ1kqSvmdPAaF3rkn5/l/7a8TCUhA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s+fZ/8sTAtEvr8zyclFUbOhGSi60msYUUzRs7EhKJ9YtCQVndJNHjY3KcgzMaB0T8lr0/oMIzaPiFDOTpcABn2SbAfaLcqkEt9NuYB3W0PGXpCMg1/jwVMXT/RYI4Ahxdd9Ks1xT0t98GMzt85Up47Y6FITvxsHxxiKHUn8Nd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAEaN3WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB518C2BD10;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714154999;
	bh=ZoBifVMjOnUKbCOJ1kqSvmdPAaF3rkn5/l/7a8TCUhA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vAEaN3WUFbPBcaosWy9bVQVrUrKy/qr4geb/X0ytcp4RPdY1zdIlgONKLckjO0Kkn
	 3lO5GFpUXI8Jw19YzX/mlLF3ZvmisEqqw99cauQndOY03ZzjjZnWKEkKBUSFGWbUrt
	 laWuenO52LRsA0klVXPKCG7TfhMLusqEJUenUBx24jFHW4SkngwmB0TYOWMBVlU0UZ
	 i9cLAw30vIwyxU10SdagHY40ls0fAEdRiLwrC0DVcyGus2SPBB194OJPl2jm/6X4Hj
	 TUNlU7kJTfRveHOSAQlKjVdJhjMc8tYki8EbUILdCpZKd9E7tCDJE6pG22HBK/guA9
	 rsWPzIJPPNW3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7986DF3C9B;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240426145606.981607-1-chenhuacai@loongson.cn>
References: <20240426145606.981607-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240426145606.981607-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.9-2
X-PR-Tracked-Commit-Id: f3334ebb8a2a1841c2824594dd992e66de19deb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09ef2957170db78429acb10b606636f798cbd3cc
Message-Id: <171415499974.9216.10694196759580679338.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 18:09:59 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 22:56:06 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09ef2957170db78429acb10b606636f798cbd3cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

