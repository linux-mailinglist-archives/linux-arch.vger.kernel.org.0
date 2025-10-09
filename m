Return-Path: <linux-arch+bounces-13981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54556BC70CD
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 03:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2618119E252C
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAE13B58C;
	Thu,  9 Oct 2025 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z85MDq7b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C697082D;
	Thu,  9 Oct 2025 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972028; cv=none; b=D84JNm438dyr9ZH9mBrdve6x2rw+Kh1q7L3QWthJ9GcsdSiIPot62PWAJe2H8uyq5B9+MUJqwphe7kDaPctcl2XXN1GLmPRMCD2/wstfvc5x2haBK34Pto7VM2w0pxq5wDa3ccmZfOIBVp93jB5krrpC2CZKJj+wIZU1v7PYYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972028; c=relaxed/simple;
	bh=VISjCl3028ZdolLBlNDZGd4lu4o1butuKMV03AtZBlw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BNUU0AANUHqccrRIptTrY9gZjtGJEozA74zp58XfSB9qOwfrBpucQQB47KmDptEOE/XZoNqgfL74FPmHKPHJK3rxyCkzsyCWbYBSjjFGUy9oDP8fVuaJ/pJ4v6/sjN3ALQdagnbr/R8acTRTr1Ehb3jgPMk6RvRoNMW5OpiyG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z85MDq7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE42C4CEF8;
	Thu,  9 Oct 2025 01:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972027;
	bh=VISjCl3028ZdolLBlNDZGd4lu4o1butuKMV03AtZBlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z85MDq7bFHAVb7Rv7QvW4jT9Y15cPiI0WVlhCJV3Hb8KzH2ZYtKDIugmNBfAaGySd
	 z5ewF5rNJ+Eg/0lDf4iQ7eqlYgIW0QFXYttqFueGd0EyH0q3YxGVMid01GmetPjhLw
	 CLKH4BhiZk2QE9ZHGNcP1R+Uu7twuBVmXVU7JX+WU6Qkgezekw/tfTay9IqLn/03qv
	 fGM0puNNPNlEwlNS8diIH3zKif6A6uWsftAXlyDWexxIsHVq/Ua4/nh1U3nC4uYics
	 +WuF25l1nNqeg2I6RnH6RhbrrEuRMwXBeUzGy3elVssgawfAsHG1eRRK1qPPGapFZ4
	 MDqB4RaRlBhng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00C3A41017;
	Thu,  9 Oct 2025 01:06:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11] vdso: Various cleanups
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997201575.3661959.11378704835584004005.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:06:55 +0000
References: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
In-Reply-To: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, luto@kernel.org, tglx@linutronix.de,
 vincenzo.frascino@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, namcao@linutronix.de,
 linux@armlinux.org.uk, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, tsbogend@alpha.franken.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, arnd@arndb.de,
 brauner@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux@rasmusvillemoes.dk

Hello:

This series was applied to riscv/linux.git (for-next)
by Thomas Gleixner <tglx@linutronix.de>:

On Tue, 26 Aug 2025 08:17:03 +0200 you wrote:
> Various cleanups to the generic vDSO infrastructure and a patch for ARM
> which was never applied.
> 
> This series has one trivial syntactic conflict with "dso/datastore: Allow
> prefaulting by mlockall()" [0] and a semantic one with "sparc64: vdso:
> Switch to generic vDSO library" [1], which still uses the removed
> GENERIC_VDSO_DATA_STORE.
> 
> [...]

Here is the summary with links:
  - [01/11] vdso/datastore: Gate time data behind CONFIG_GENERIC_GETTIMEOFDAY
    https://git.kernel.org/riscv/c/7c0c01a216e6
  - [02/11] ARM: VDSO: remove cntvct_ok global variable
    https://git.kernel.org/riscv/c/39f1ee1299c9
  - [03/11] vdso: Move ENABLE_COMPAT_VDSO from core to arm64
    https://git.kernel.org/riscv/c/7d298d25ce81
  - [04/11] vdso/gettimeofday: Remove !CONFIG_TIME_NS stubs
    https://git.kernel.org/riscv/c/f145d6bf8d59
  - [05/11] time: Build generic update_vsyscall() only with generic time vDSO
    https://git.kernel.org/riscv/c/ea1a1fa919a5
  - [06/11] riscv: vdso: Untangle kconfig logic
    https://git.kernel.org/riscv/c/eb3b66aab72c
  - [07/11] vdso: Drop kconfig GENERIC_VDSO_32
    https://git.kernel.org/riscv/c/278f1c933c3f
  - [08/11] vdso: Drop kconfig GENERIC_COMPAT_VDSO
    https://git.kernel.org/riscv/c/bb5bc7bfab06
  - [09/11] vdso: Drop kconfig GENERIC_VDSO_DATA_STORE
    https://git.kernel.org/riscv/c/7b338f6d4e3d
  - [10/11] vdso: Drop kconfig GENERIC_VDSO_TIME_NS
    https://git.kernel.org/riscv/c/bad53ae2dc42
  - [11/11] vdso: Gate VDSO_GETRANDOM behind HAVE_GENERIC_VDSO
    https://git.kernel.org/riscv/c/258b37c6e626

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



