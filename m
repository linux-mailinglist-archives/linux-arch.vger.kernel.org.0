Return-Path: <linux-arch+bounces-1407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5674833630
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jan 2024 22:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E6DB21B10
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jan 2024 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBFD14F8D;
	Sat, 20 Jan 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3JVAx1d"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB414F85;
	Sat, 20 Jan 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784990; cv=none; b=c0p7UrWgn0v9N98kDZaac3LnNRl3qrNyeuafK8hHOwaNtAhAiH6AjSauDRxlI+sapxyO0E8MIvA/B3664t7JdTaCEasp/7S/shjl3w3X2GTCPK3Qfja6gIJURejoF+lGvT18nBei7SaBpXVB2/mmul0hMc1/FvpU9tjL3bTeMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784990; c=relaxed/simple;
	bh=4qgLOd9+lbH3Kbu84onZLztZgw4zMTuXW5joJu6tgV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgY4opEr881FYFl1Iif/ByeGmSXePy5MCYzEzTexq4jJ8oAL1bdmyc4yoT9Q7KPjT5sffxUQ5YsJgvLUtarah2WCI7UGtBNX4ayPiodAk7Iz6G0JqFnCyowf4jq5WhI73BbJbRKDYF9d5ggFphMPqc0Bs+0rNkHcachMZlpDyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3JVAx1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C3EAC43390;
	Sat, 20 Jan 2024 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784990;
	bh=4qgLOd9+lbH3Kbu84onZLztZgw4zMTuXW5joJu6tgV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q3JVAx1dr7/DmuB+/yI2CdLuXSn2QhR/aAQsiCxHJoxNdYGJDZykTy8bfepNkBaWC
	 fyrri6bdqzeQ7JkDfdfxcHZdfEFlwFairsw2Flzvuou8t1LDne0Yjsb/jFYXKrD8qd
	 fRFsB5YSc58MfEM4BTbPV6zDBq1wttUmrNXmKceU3SaOdzA6o5mx33c4k6D8hy4v6T
	 0R8TUFHsfTiG7CU9C8W7DrYp8C0gFCMRH9ZdRCeZheSYagCxzekxmi+RhRgGQ3RlQG
	 cWbmoTuSY2dzUSm68ko6YI4j9IdFiX07VyiaaPj4fvfc3IRzZVSYqatO4Z8qlJDRBO
	 7UMRKyo0B4Msw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09F97D8C970;
	Sat, 20 Jan 2024 21:09:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: Enable percpu page first chunk allocator
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499003.24348.2691177844867923598.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:50 +0000
References: <20231212213457.132605-1-alexghiti@rivosinc.com>
In-Reply-To: <20231212213457.132605-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, arnd@arndb.de, dennis@kernel.org, tj@kernel.org,
 cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-mm@kvack.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Dennis Zhou <dennis@kernel.org>:

On Tue, 12 Dec 2023 22:34:55 +0100 you wrote:
> While working with pcpu variables, I noticed that riscv did not support
> first chunk allocation in the vmalloc area which may be needed as a fallback
> in case of a sparse NUMA configuration.
> 
> patch 1 starts by introducing a new function flush_cache_vmap_early() which
> is needed since a new vmalloc mapping is established and directly accessed:
> on riscv, this would likely fail in case of a reordered access or if the
> uarch caches invalid entries in TLB.
> Note that most architectures do not include asm-generic/cacheflush.h so to
> avoid build failures, this patch implements the new function on each of
> those architectures. For all architectures except riscv, this new function
> is implemented as a no-op to keep the existing behaviour but it likely
> needs another implementation.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] mm: Introduce flush_cache_vmap_early()
    https://git.kernel.org/riscv/c/7a92fc8b4d20
  - [v2,2/2] riscv: Enable pcpu page first chunk allocator
    https://git.kernel.org/riscv/c/6b9f29b81b15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



