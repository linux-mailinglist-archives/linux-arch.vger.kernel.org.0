Return-Path: <linux-arch+bounces-3603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6A8A1F24
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D965288122
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AD205E32;
	Thu, 11 Apr 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRJlputN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF92205E0F;
	Thu, 11 Apr 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862557; cv=none; b=ZDuBJDB09DXrMacOZr54QvQzaYbZcyq5jw7QWYYFn7fYjq/rRTXjrDNaMmufWpHJzuRI6D3cTSEDzU1U/HepgaZWGpwTEIoBp5gK6+fAUK9L4U8SrPYAviLsXiCgi2XeHRUeBCzFQOolDJ6RJGIQrExHgCsDSy6ZlV0gyujtbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862557; c=relaxed/simple;
	bh=o/vERn/Lqy6nxmA/9K/85rxUcdFZJtcDnyCuzV4t3a4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I2tQlimDNgC9jIZQ0Hz6YwO6pcdpSaGXGeLNcC6slzbnq9qHJea9xj25DD8FgZtRUx7aCEczY9IqKq+ZduwaELDFlMkKa9+NBAAJTVynXzA497gGSOVnW9N9Hl+l2BuGq/WUEACm/aeYkR0Ee+DhlM97CM9FejQ1KAFPjMx/fOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRJlputN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29FB5C072AA;
	Thu, 11 Apr 2024 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862557;
	bh=o/vERn/Lqy6nxmA/9K/85rxUcdFZJtcDnyCuzV4t3a4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qRJlputNo+yp7j+V6btSNc6bgM0rycjFCGSJKkUTFc1/ZU5cOhrio3zlA0ugjf8YQ
	 FvkkZ3oOjDNBNILc63yIcLJIX2c8BOnFYDYClTqhvzgSicSOmp2fuBI02qGNm4nYOo
	 tUHMVGUlYQ2Gf291hnU2wtvGY4jUXDUwUv6cJp0fu9fuYqE11p8R3qli5deOwzzG4J
	 EM5biQKnZD8YJwQjmifUmXYo12vaI6P25Sb2eSvMdRZAyYt+I9lc/xcmJbsahG/9m7
	 6hPrbD58ET129gLKwzFJ+OsyYApCZ9NVLyiZXr9TOcWJ58Jn9XX/FkHHZi0pqeQ53l
	 rUxUk1eGR4ivg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F429C433F2;
	Thu, 11 Apr 2024 19:09:17 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240411103000.2655846-1-chenhuacai@loongson.cn>
References: <20240411103000.2655846-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240411103000.2655846-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.9-1
X-PR-Tracked-Commit-Id: a07c772fa658645887119184de48b255bf19a46e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5de6b467992286d3bd2a7512036de99b3e483932
Message-Id: <171286255711.2172.4725182096046349159.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:17 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 18:30:00 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5de6b467992286d3bd2a7512036de99b3e483932

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

