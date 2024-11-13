Return-Path: <linux-arch+bounces-9075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996259C79C9
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5107D1F24E51
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2758202655;
	Wed, 13 Nov 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQEYWRlu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD4202647;
	Wed, 13 Nov 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518345; cv=none; b=hO4aSDtAMBvbpPMsa0ymS74HiXxtcjfLlLKDPA/w/3dlbAaldIPwiL5Q6+kMTtszAf6KNlLnqDtXMWyWzFF1WUdEOqhv94SbMBeKR6ZtECAm3PdYwDbRSuMh9ibNId/ZaZiFO1iYMeRdBFbjDm7DHgXnbGhtWfwT/uT2SWSH3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518345; c=relaxed/simple;
	bh=Yms/Ur63xAavBrcDddpPwMUsz8LqhH0YS5gil59YL2U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kohe0Cy8+noTR1wPPQimmChAXiemJZKMNgA0TVFXisj6ZeTWRsepEzg/+g9bISC5qC3jtv49HyeDjIK/imzrp1N5GPRuMtAZrlNh98T///B9LFEVebTkkZ3AeasqsHfRifCvVVyjvs5eiSqjlp4JEikwWiqw8hL77IK+Hhruhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQEYWRlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15667C4CEF1;
	Wed, 13 Nov 2024 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731518345;
	bh=Yms/Ur63xAavBrcDddpPwMUsz8LqhH0YS5gil59YL2U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CQEYWRlurtGVSy0yZSOIQsixC32jXKt+UvGr7fPkLHZZeC1/f87BMqmhDZLKy52zT
	 q4Kn/7xTp/70OugzMaQaOzS1mvDeNZ6u7MV7eBeeAMWjsOREBXUvCru5LRX72h1bnk
	 q+9Rc45iTqiFhoMv4wJUih6XWtpICyzP31x+prRa9BjxZILerpCffMtlHfETWqbzW1
	 UnKXBY9lzQ69upVBlH/jbxuD556mfgHQpiKKrNr8mQxktobilw9pbu7K4eh7s32dE5
	 vpppPRug13mKgTPi4l3NAkl2mIdN1ukUFJDRIhp2ttSWVxc5XZFlOoimdSKh5ozqYI
	 kyVbTrxyVZrmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C583809A80;
	Wed, 13 Nov 2024 17:19:16 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241113124857.1959435-1-chenhuacai@loongson.cn>
References: <20241113124857.1959435-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241113124857.1959435-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.12-2
X-PR-Tracked-Commit-Id: 6ce031e5d6f475d476bab55ab7d8ea168fedc4c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f404511890d75c90e4ec06c54f06bd397d96f5
Message-Id: <173151835529.1293865.8549829368830012392.pr-tracker-bot@kernel.org>
Date: Wed, 13 Nov 2024 17:19:15 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Nov 2024 20:48:57 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f404511890d75c90e4ec06c54f06bd397d96f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

