Return-Path: <linux-arch+bounces-5590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0E93A0AD
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 14:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334D71F227A8
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E81527AF;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4wIy8Pi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DAB152504;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739517; cv=none; b=rLysHj5MuSSpKKMlHFEGyZExHFmP/OD9ckO3xCUv26mRO7MY4OGD8RmROv8qYaJqtzZ7Rtl7WDhtvRUdyskSdOc/KRT3aN4ArEXUBzsE14qQo1nVbUoG41CLOl/RkBdUG/ScG+3Os/8lKBJlOid/WQkRMawIgvcP7mIs/XT2t24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739517; c=relaxed/simple;
	bh=XnGab5Oc0HUWROXuLXNSpwek1pYBFbd7tB6YAr94S9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lMO62rTDNUm0nTwvh7WvUPTrbrti3Hsxj7Q7oUXalm/mPFGqtu0tQzJlgrzG4WBg/zyyPj5eJpGi6nCZQp+6cxrSU8x8tpjnDlXVcgb9IOB2v9R7o2n5pApKuNTMZsey5LoPMnrJ4bXLsiRxSezLIN7EIE7k1ML2Xu7rB8mEMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4wIy8Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F9CBC4AF13;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721739516;
	bh=XnGab5Oc0HUWROXuLXNSpwek1pYBFbd7tB6YAr94S9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z4wIy8PilVKD3upkFv7+8P0M3fwFN6M6m/FwfRjPy6dPwZxV+9DBMeCXJMf+3QWdx
	 f0AHw6mTOo6SdlNe5QdV20d2GgdCMeJKIelmOKvSs76KAumtkEA1iqioW709/M+rG1
	 zsFnJgWmmen+Tc2yEgIoz68D4zyUf4KrQgocLTKt2aXenfPk7Ya6eSesUQ5jFTvtVP
	 BKoYUnAs5eiduQnkXmUT4v1Pyh4n8ewZvKgDNyJacJXOZWy7mVvfArBbzbIZIOwMZK
	 lBFMZMGIaHBpm/RjCQc5uZxWAcsHZhBnFlcj7VBc+U0BF5QumfxtMkh80xnp9w6Efn
	 CbbcIL1FkoRmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E34BC4332C;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/17] arch: convert everything to syscall.tbl
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172173951638.10883.11414221741425402977.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 12:58:36 +0000
References: <20240704143611.2979589-1-arnd@kernel.org>
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 arnd@arndb.de, masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 vgupta@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
 kernel@xen0n.name, dinguyen@kernel.org, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net,
 andreas@gaisler.com, brauner@kernel.org, mark.rutland@arm.com,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-openrisc@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Arnd Bergmann <arnd@arndb.de>:

On Thu,  4 Jul 2024 16:35:54 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are eight architectures using include/uapi/asm-generic/unistd.h,
> which is still in an old format and not easily parsed by scripts.
> In addition, arm64 uses the old format for the 32-bit arm compat syscalls,
> despite them using the modern syscall.tbl format for the native calls.
> 
> [...]

Here is the summary with links:
  - [01/17] syscalls: add generic scripts/syscall.tbl
    https://git.kernel.org/riscv/c/4fe53bf2ba0a
  - [02/17] csky: drop asm/gpio.h wrapper
    https://git.kernel.org/riscv/c/ed8023ae9d79
  - [03/17] um: don't generate asm/bpf_perf_event.h
    (no matching commit)
  - [04/17] loongarch: avoid generating extra header files
    https://git.kernel.org/riscv/c/ff96f5c6971c
  - [05/17] kbuild: verify asm-generic header list
    https://git.kernel.org/riscv/c/b70f12e962bc
  - [06/17] kbuild: add syscall table generation to scripts/Makefile.asm-headers
    https://git.kernel.org/riscv/c/fbb5c0606fa4
  - [07/17] clone3: drop __ARCH_WANT_SYS_CLONE3 macro
    https://git.kernel.org/riscv/c/505d66d1abfb
  - [08/17] arc: convert to generic syscall table
    https://git.kernel.org/riscv/c/4414ad8eb4c2
  - [09/17] arm64: convert unistd_32.h to syscall.tbl format
    https://git.kernel.org/riscv/c/7fe33e9f662c
  - [10/17] arm64: generate 64-bit syscall.tbl
    (no matching commit)
  - [11/17] arm64: rework compat syscall macros
    (no matching commit)
  - [12/17] csky: convert to generic syscall table
    (no matching commit)
  - [13/17] hexagon: use new system call table
    (no matching commit)
  - [14/17] loongarch: convert to generic syscall table
    https://git.kernel.org/riscv/c/26a3b85bac08
  - [15/17] nios2: convert to generic syscall table
    https://git.kernel.org/riscv/c/ef608c5767f9
  - [16/17] openrisc: convert to generic syscall table
    https://git.kernel.org/riscv/c/77122bf9e3df
  - [17/17] riscv: convert to generic syscall table
    https://git.kernel.org/riscv/c/3db80c999deb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



