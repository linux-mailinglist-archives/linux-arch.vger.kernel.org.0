Return-Path: <linux-arch+bounces-3536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32D89FA04
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67941B34B20
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F631607BB;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRiK+DwV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC091607AF;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758229; cv=none; b=mfkTnZTIqZBZXc/lFq4NDMrMItzBqZ/jUZlqZ/HJpPY8OBH+G91lYCarZkMIs7D4J2KxoN2dnBcbUUBS6sqpFlo+7BFoww4LOECeXTtRtXNZFeCWey4/ptAU89v8vMmt2x9H4uPsemyjpRDrkD/9KMejCp689QqK0gPvU/t4AhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758229; c=relaxed/simple;
	bh=eD02rCIxp2Gn2KKb+4Vh9Qm0xtxbnnnXHsw4g744NdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USbuIGAT1Kn1F7YzNuzeEZFjQ2MUV+PlasiPpcQ5AjD6sJ9QC4Zots5/I7liymE9JsZ6UN5gzJ4ZXyVHiciD870JwBTfxO4gke4f+P7hirtVq4nE9olUGn4dkwnR3a+Ihy3M4U43v7MkUkqi4vTYtC7AUYY5cb+BnRE4xdCecJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRiK+DwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 634B6C43390;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758229;
	bh=eD02rCIxp2Gn2KKb+4Vh9Qm0xtxbnnnXHsw4g744NdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NRiK+DwV1z0am3phlRQoAFhCw5HhWVbiWsidi3BkPso0RvZBvLnX0Z/TkURuS4Ha9
	 slcneo2VT2MuwT72bDEqUKcGtl1A+CDCoM3mOOKKwi24fs9Epfh1M+HDI+Yl2fpOiz
	 cRVIJR8Dp7qIdH/eDgUgf11qUzPa2DlattHTimB6butNK0JkTM1EuSWfOaA78BaNPz
	 RRvVQrCm3xSFt1/mtCOsfMEN8PzflM3N//hkbfNyYfbPGD0ElcpTMFSrWLTTMVkIbB
	 Kn+Dlt/8aywnuSU4k1q7iFjOAANHFMH1D4EzRG8nRYj5ey4hnHryoT2xbvfpJWY0gd
	 eF9yPlvFhTeoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A6DCF21C6;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] export.h: remove include/asm-generic/export.h
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275822934.12683.6255352556602510987.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:29 +0000
References: <20240323090615.1244904-1-masahiroy@kernel.org>
In-Reply-To: <20240323090615.1244904-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, arnd@arndb.de,
 palmer@dabbelt.com, paul.walmsley@sifive.com, linux-arch@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 23 Mar 2024 18:06:15 +0900 you wrote:
> Commit 3a6dd5f614a1 ("riscv: remove unneeded #include
> <asm-generic/export.h>") removed the last use of
> include/asm-generic/export.h.
> 
> This deprecated header can go away.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> [...]

Here is the summary with links:
  - export.h: remove include/asm-generic/export.h
    https://git.kernel.org/riscv/c/36d37f11f555

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



