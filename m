Return-Path: <linux-arch+bounces-11878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A5AB1B8D
	for <lists+linux-arch@lfdr.de>; Fri,  9 May 2025 19:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE0217965E
	for <lists+linux-arch@lfdr.de>; Fri,  9 May 2025 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950A23C517;
	Fri,  9 May 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Vzq6pk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E223C4FD;
	Fri,  9 May 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811800; cv=none; b=ixVCT2PcESVuWiDyvH/kIDcoZDZBzNxCwxpVKKN2sXl4Aqj0qvLT/HuefIkfq7SJqQCZrSUvroJ1Eu6FOQZF3tEwmww8nN5mMVDWJ42uv2JfRKgkY0MrDGhR/4391VE+VXmwo5i3C2qV2CdCIdhMrZfwluqVVeS9NhZb3e10mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811800; c=relaxed/simple;
	bh=cPhjasTwI2UlEzhggO3BfP5IeHfjz55rUCtySA1MPZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KpeRlmGyS+qFkEKXcv2YLGF0Df8J5TV0vkca1MQIdfTC2fifZd+S9nDeDL43cwNRdHJJdw+Kpa0m+2mncmnxeA+nLpsqqeV11qlwYbumQWtPrSGc310voICfZ6xiyp9mEoS8zZMcxmHrvbxwruKKqYrW8WFCQCuUUE6UlzzDk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Vzq6pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B86C4CEE9;
	Fri,  9 May 2025 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746811799;
	bh=cPhjasTwI2UlEzhggO3BfP5IeHfjz55rUCtySA1MPZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S1Vzq6pkJKMtybevOYaVo+IXvGH9iHyt73kURGEzn0tBT7dMlc+WGknIq8ZFywpB/
	 qXYXmoq0TCaXPzQq6itNVVd3AYUhdZ6RcydeNgRW8raQp/uH/ImxtqUEThp3T6OZPF
	 3y7ixjn93OgRSmT+QpjQ+pqm9PUFm9evikv6r+mv7q/PXaXOaWYY/n8OqfXWUOvCSO
	 BRu/6hQTYrWgPOFizXnYvp4jceTcFUn7uVqOZISdsMcKbaIi/b9clf5uH7Eg4O/I8D
	 RakzsEDIsD7jxW8jgm3Pa7u9Pnb25q19Sfs0Bi4DK/0cgElUkTRjXgeAERyfw+D9M2
	 MEdKkuCHPBnOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4D380DBCB;
	Fri,  9 May 2025 17:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Drop explicit --hash-style= setting for new
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174681183698.3697320.7074504502229425253.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 17:30:36 +0000
References: <20250224112042.60282-1-xry111@xry111.site>
In-Reply-To: <20250224112042.60282-1-xry111@xry111.site>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-riscv@lists.infradead.org, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, palmer@dabbelt.com, i@maskray.me, yangtiezhu@loongson.cn,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Feb 2025 19:20:39 +0800 you wrote:
> For riscv, csky, and LoongArch, GNU hash had already become the de-facto
> standard when they borned, so there's no Glibc/Musl releases for them
> without GNU hash support, and the traditional SysV hash is just wasting
> space for them.
> 
> Remove those settings and follow the distro toolchain default, which is
> likely --hash-style=gnu.  In the past it could break vDSO self tests,
> but now the issue has been addressed by commit
> e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH").
> 
> [...]

Here is the summary with links:
  - [1/3] riscv: vDSO: Remove --hash-style=both
    https://git.kernel.org/riscv/c/2940954c1ac5
  - [2/3] csky: vDSO: Remove --hash-style=both
    (no matching commit)
  - [3/3] LoongArch: vDSO: Remove --hash-style=sysv
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



