Return-Path: <linux-arch+bounces-9176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0299DADF3
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2024 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4468163E52
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A77202F7B;
	Wed, 27 Nov 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5yGKro3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E8201029;
	Wed, 27 Nov 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736223; cv=none; b=nIPlgEJDtcgXBbpC1XjGUuOT+uMq+4zQwJgZa5XV20nB32rbwdto9TJ9hpDXZ81lMQpu0FKoS0ONzfnAJWIAwiJcmxd6nLxXFobmxPXobVjVw/Uer+3n2j9r3mPl7OQ8L4m9KPmKp8IQOrLIl9w41ceOwR5lRhXI3WrVmL+MpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736223; c=relaxed/simple;
	bh=NSbbL+eFbaJtHNhA52M5bNNDnqJQckVkfLNcJVSpnIQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W+tLQ8lDVFpL5ygTzE2XhxbcdtKUuyAR958JJDpyS3esfEbzizSTyfLkEcY/sO+JgYBQUc3vibZqQi5hK8zN/tN4iKwmHURGscB46bh8+8BzZoaXxAF1XTezg+WNbMQiIcz87fqYhsiQv2sjijp3vcPsQB+cbxKvcHeDLqOwpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5yGKro3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E05C4CED2;
	Wed, 27 Nov 2024 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732736223;
	bh=NSbbL+eFbaJtHNhA52M5bNNDnqJQckVkfLNcJVSpnIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c5yGKro3SaI75AlgdtTeLojAoSnNF7TyLGhNrObp01xi1chNv2IhT9F4MYK9rLhkA
	 gcoXpvVQcaRjxPrj4YhlYSjAdf2BDlaglAIjBffzWZUGrBEGkN3ExGdMlQdX2klHhB
	 oEO786o2e56AgXXaZyjz0c3Jjn/vOk0GnP9Hy/37dQqFMCzt/WC5DIgvq/WOCsYmtL
	 NXGkWGenK/D1UPeXKlBbr+UnyxZQvqYQxZLtoZ9eqqaACJKaJY01TvkHEwXb0ZnLtT
	 mB6e/LbQXQQ4EBVyAcw6mQnC5AYh8b+U+FVBuCDdCA0iGtt3MTNL/2zEz8DlxrG3FL
	 vCZ/JEQaxyV0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4B380A944;
	Wed, 27 Nov 2024 19:37:17 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241127091825.421126-1-chenhuacai@loongson.cn>
References: <20241127091825.421126-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241127091825.421126-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.13
X-PR-Tracked-Commit-Id: 3c272a7551af1c10f6dbba0e71add7dccc7733fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c94696977527f69cbb41aa6a9af9d1991895d002
Message-Id: <173273623570.1191875.7861842418694019565.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 19:37:15 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 17:18:25 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c94696977527f69cbb41aa6a9af9d1991895d002

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

