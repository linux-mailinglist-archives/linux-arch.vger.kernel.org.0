Return-Path: <linux-arch+bounces-2116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086D184D78D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 02:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7515D1F23571
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148A21DFE8;
	Thu,  8 Feb 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUggYVTw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007C1D557;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355830; cv=none; b=HSeeDCta+g6bH9H9hQkcXi0bJs7VJrj9891jserugExPm9yDa/pB34rfLsdBiCO/R3Xsug5hUUPyjCYWu/eI+PrfsITAB2Q0li9VprzAsk50Q+L6TSvFlzmvEopeo7ap0ap/kg1ASUtB9EPz/0TRrVVMyBYO8Tm8qGGUm9t836Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355830; c=relaxed/simple;
	bh=RMupFb4nJ/fs56B3Mp8NAVjkwclZL/zYoqXWz4mV58M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BQwVD9KTuTqKTGJauq1LHOG1AqP4paL28jvKmFNeUVgbTIdtRACHNJ3cjWLaelYWY7W7Kw6vTRrPTODmyOeXbOrISPVNORQfwN0MLdLXwNuu0V6okFVN9zuOqPpSU6Y9zOSJPWaupqlG8S7L1o/jVum5V4O5N+YI5SzY0yJK6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUggYVTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DB25C433B1;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707355829;
	bh=RMupFb4nJ/fs56B3Mp8NAVjkwclZL/zYoqXWz4mV58M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NUggYVTwasaK3+SnCqY9s1DQ8Rkt7whE+tlGoGXPUQQHxV3a/U/FiudlgRtJqnnyL
	 YoK0u724ZuXIkgMN43WHBgAwe8VJWRVCNGKJtogCxNKdiPByDc5gPHchg3xuPtNNKA
	 pds3VnpHYtH5Is78jCHKQJujPhHp0Rpm7sxocM5zPY5OWGtP9m5O8jv5M2BLykINi/
	 9+laroHlcorrGptWxrx5+8JomDo2K9VELemYkrrT+jqwsTxUQu+JvkV9EsIlT+Q+TL
	 N5nOmV8eSLnWHM8LeWY6cawc/BekQMMpt9wBGk4facBRozJMKBvc5XrbdTWXJSWo5N
	 tJ4Oy9c9bNaNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53514E2F2F1;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Flush the tlb when a page directory is freed
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170735582932.12826.4648361824228463635.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 01:30:29 +0000
References: <20240128120405.25876-1-alexghiti@rivosinc.com>
In-Reply-To: <20240128120405.25876-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, will@kernel.org,
 aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com,
 peterz@infradead.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, samuel.holland@sifive.com, ajones@ventanamicro.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 28 Jan 2024 13:04:05 +0100 you wrote:
> The riscv privileged specification mandates to flush the TLB whenever a
> page directory is modified, so add that to tlb_flush().
> 
> Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [-fixes] riscv: Flush the tlb when a page directory is freed
    https://git.kernel.org/riscv/c/97cf301fa42e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



