Return-Path: <linux-arch+bounces-7382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D5983D3D
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 08:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D31C226C3
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD7126C12;
	Tue, 24 Sep 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG49ejtR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B1126C05;
	Tue, 24 Sep 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160031; cv=none; b=YQtPkM9Z3vUqXBvuNhBeEKDA5p9qslJr/JqNx8jDxeMzRoNNOAAn6KaDGVRq1dKc/wJXCeW9ZsfIc6d/Kd5OoM4ETciFgdwSJWkJWsp/884pCztOP+05EXLD8byy5qHI+QPRPJ/oT+VzT+ydWYtjyOk6lTDvajBqvzjAuAXp2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160031; c=relaxed/simple;
	bh=9cTysO541iBtGr4672RE5NQ54grLu2lTYGls/lFRWo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f0G9RoOviVnykohp2fqt3sGI8R1s5z8IfYMd69IE4/X3kN1QgFGOkWfDSB1i38Yx+CUIr6A7B9AEBVS3/Z/bsIhO0Is6TMYuhK8QHu8HNn2tHM2qBJ/kpmVzY3rMn1WlJvv8CU9qz/jTk2rZk2rc5aRx27eE/7ZjQRXAfag+oWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG49ejtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3ABC4CEC4;
	Tue, 24 Sep 2024 06:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727160030;
	bh=9cTysO541iBtGr4672RE5NQ54grLu2lTYGls/lFRWo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bG49ejtR+w4iYDqQXMuFgZO0lma89Q+/ewFAisjJQWdM4nTdTjYytdmC/DGU5RYyc
	 BMvAcN0Er0U0s0vzoVWwGXKl7ML7QSjj84RkCrQDqB6wbGM6op6CSkmIBtmVGdAN+O
	 vaXdu+MyS9VJRXI7TKMBU1Zs3CI+jZJ6Cmg/0OXKcgneFpWy4TTGxaZgnfajIyP2eS
	 bdwiamgtuEOTarAmZrJfYhkc0CecsMirt1nWdskd70j0SO7uri43v8/+bgRZgs0AXP
	 wBiGsUet1gXipbccOZXa574Fv4sKB0fY2ghzoFlX9wpnI7h4DbVZ5ayOH2VLpAjx+f
	 gDf1RVDEdMTpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C093806655;
	Tue, 24 Sep 2024 06:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next v2] crash: Fix riscv64 crash memory reserve dead loop
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172716003324.3899939.3055184553837827208.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 06:40:33 +0000
References: <20240812062017.2674441-1-ruanjinjie@huawei.com>
In-Reply-To: <20240812062017.2674441-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 12 Aug 2024 14:20:17 +0800 you wrote:
> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> will cause system stall as below:
> 
> 	 Zone ranges:
> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> 	   Normal   empty
> 	 Movable zone start for each node
> 	 Early memory node ranges
> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> 	(stall here)
> 
> [...]

Here is the summary with links:
  - [-next,v2] crash: Fix riscv64 crash memory reserve dead loop
    https://git.kernel.org/riscv/c/b3f835cd7339

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



