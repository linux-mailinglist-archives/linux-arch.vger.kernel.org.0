Return-Path: <linux-arch+bounces-13982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4446DBC710C
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 03:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C23E505D
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 01:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199DB1DE3DC;
	Thu,  9 Oct 2025 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq+QIuaS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73D1DDC2C;
	Thu,  9 Oct 2025 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972037; cv=none; b=mFtXMGQj3z6s1YvnbbhAXlPrhV1gAjiHBVF8XUGP4k9mv7v+3AD749g2mO7CEzjxq4mh4vrYWJHLVrBTkzQpP4e0OBtqvEUIj21fh99GoDyZpv3yFTeeHUEDfAEAtVcciQyFhTwyytG62/pgj5WruczmzNA++zsP+hwfUvyn8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972037; c=relaxed/simple;
	bh=uICwW+7JjdNTrdwYOThDjo78WSe40MG6kD2tcS8UCr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fo7Kpe2CL+yvYEiZScBzdP4gg3L9w3+LujZctBmFPtTCIWuXxLcnFGRU5MpNhAoAFt3Rb+NPbdyvucoNz/iuFUpxkJMaONQR/fiQTAwFPEXSDi+SS7k7xkqDc/YBM5sM3JaMMzHxnFPTKcxKIQiknlmMPPOfVI//baVZyyg/OyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq+QIuaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DF0C4CEE7;
	Thu,  9 Oct 2025 01:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972036;
	bh=uICwW+7JjdNTrdwYOThDjo78WSe40MG6kD2tcS8UCr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cq+QIuaSsbZ85Bye4hA95eTz3hsHytAX1GTFc9YGto55OBTrhSQts03gyTHo2eSvn
	 rNgYrFWU2souedJNKH6yF6ZCWEwY8jrNexNaitylW4ivlHpWVjhbYCAMV/nCTZ0CtL
	 oShIr9D42WzY/SRFilbT1mqkl6x9++jWyPnFwByoyG/Cut3jUlY64GzGWuzLpebMQz
	 w6uj0kRrCETVOXtVAqrz1jAM7/GJQA5bYn5s7PAlvZCkQNO3eOD7pPdDsew6svVkaE
	 TtclXcV4dI7gawm5GYhlHGNy+cRg3zhyB0uCj+rKzY1KwQUV3/WZTj4Wp3vrhYv/Dt
	 LmzPOKnu/WrKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE73A41017;
	Thu,  9 Oct 2025 01:07:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/17] Add __attribute_const__ to ffs()-family
 implementations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997202477.3661959.16005423815156173105.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:07:04 +0000
References: <20250804163910.work.929-kees@kernel.org>
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Kees Cook <kees@kernel.org>:

On Mon,  4 Aug 2025 09:43:56 -0700 you wrote:
> Hi,
> 
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute_const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> [...]

Here is the summary with links:
  - [01/17] KUnit: Introduce ffs()-family tests
    (no matching commit)
  - [02/17] bitops: Add __attribute_const__ to generic ffs()-family implementations
    (no matching commit)
  - [03/17] csky: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [04/17] x86: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [05/17] powerpc: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [06/17] sh: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [07/17] alpha: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [08/17] hexagon: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [09/17] riscv: Add __attribute_const__ to ffs()-family implementations
    https://git.kernel.org/riscv/c/c51c26e687a6
  - [10/17] openrisc: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [11/17] m68k: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [12/17] mips: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [13/17] parisc: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [14/17] s390: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [15/17] xtensa: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [16/17] sparc: Add __attribute_const__ to ffs()-family implementations
    (no matching commit)
  - [17/17] KUnit: ffs: Validate all the __attribute_const__ annotations
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



