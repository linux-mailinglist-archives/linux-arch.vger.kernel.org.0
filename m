Return-Path: <linux-arch+bounces-1408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C0833638
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jan 2024 22:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9337282075
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jan 2024 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4A156F9;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXYLo9oz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25413AC5;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784996; cv=none; b=n6BQX7kmD7uQSmwEP6QtG7SEQeqjQS+NEzk7ssfM3VPCsg6lnyfCfhwDrxfVpb+nBGv56hD1Ds6RXfE4CMk0g0gZadFJFds1CSfC/s02eX6fxvb9F+iyOm08v1Q50Zt3dRrkBHS4OGd7QqKTdEPf9BmflnEjv40Bm2hLyUFaBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784996; c=relaxed/simple;
	bh=qZBgpjmamHDPlUItPHrxc2aKEFdUoPHs1VKKC2XaTaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CJAd0eKp8OakkxjcvuhRiOgKja5pBnICP2lOzPlq3Gi+kQbfWrAHCEBl8PfKY1XU8J7Ux2X0fwMf0N455zohJuKBif4A17e4KLJQ+ACbMXf0y8bAZyD68rJ+8xvB4kvGisYLvhfxSvCoxocFabGRulSsfFiTNjUgnAtCgsryTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXYLo9oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 098DAC43390;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784996;
	bh=qZBgpjmamHDPlUItPHrxc2aKEFdUoPHs1VKKC2XaTaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SXYLo9ozrMquXpBfJoj1/Fs+vjzeiQrrXgPsDPUGXT8HpTVE/E4ogJ0naAYMt0InN
	 eP4oQudM7Q3SfBvRFciS19wkPyDwGmXsaNDdtWuJNHF06nLzRP+5qRZUH8WSa9HjIR
	 n6jw8P5mTSGyEphttSS8GaO/Mb78eBPddpcv3lPpH5+ZBzLoSZtScupta/RDyUeRQA
	 yIF/ixVC+YFLDDminA2G1U9uKox4v3PC2YscQMPsSFQvXlDV8J1DuIbiwsrcY9W9I9
	 nnD3pPKFP0WL/ypKIx7kanlTcoaqxQHKpNgnBfSMgLNEYD/lLXYwXu04l6KdNZ1Shg
	 02yYR7mVijaMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC2CBD8C970;
	Sat, 20 Jan 2024 21:09:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v15 0/5] riscv: Add fine-tuned checksum functions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499596.24348.11397809768578424439.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:55 +0000
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
In-Reply-To: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, conor@kernel.org,
 samuel.holland@sifive.com, David.Laight@aculab.com, xiao.w.wang@intel.com,
 evan@rivosinc.com, guoren@kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, david.laight@aculab.com, conor.dooley@microchip.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 08 Jan 2024 15:57:01 -0800 you wrote:
> Each architecture generally implements fine-tuned checksum functions to
> leverage the instruction set. This patch adds the main checksum
> functions that are used in networking. Tested on QEMU, this series
> allows the CHECKSUM_KUNIT tests to complete an average of 50.9% faster.
> 
> This patch takes heavy use of the Zbb extension using alternatives
> patching.
> 
> [...]

Here is the summary with links:
  - [v15,1/5] asm-generic: Improve csum_fold
    https://git.kernel.org/riscv/c/1e7196fa5b03
  - [v15,2/5] riscv: Add static key for misaligned accesses
    https://git.kernel.org/riscv/c/2ce5729fce8f
  - [v15,3/5] riscv: Add checksum header
    https://git.kernel.org/riscv/c/e11e367e9fe5
  - [v15,4/5] riscv: Add checksum library
    https://git.kernel.org/riscv/c/a04c192eabfb
  - [v15,5/5] kunit: Add tests for csum_ipv6_magic and ip_fast_csum
    https://git.kernel.org/riscv/c/6f4c45cbcb00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



