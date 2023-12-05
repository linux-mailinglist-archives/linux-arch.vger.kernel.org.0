Return-Path: <linux-arch+bounces-697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E228380585D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC31C210DB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267368E8A;
	Tue,  5 Dec 2023 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVPxDDVU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AA68E9C
	for <linux-arch@vger.kernel.org>; Tue,  5 Dec 2023 15:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB449C433CC;
	Tue,  5 Dec 2023 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701789426;
	bh=u0cVlqpFIgozphn0YtMmI9Rg2WyYQkpa6+1c55rCtGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVPxDDVUw6LLgBi39Y8flaTz8ZCCZ7QiPkWL3GRS6G/voXLm0rD7sJ8VIvOS3vaMV
	 trQ6MvyyFlxMkhuxNY6udO6XIaCsg/X6RdvejTiUklrlEqtuf1HCQFjs5xtbP+Ggtq
	 z8SU7ZMiyWwaUzlUEIkmNZrLASsszr/HpnTLhNH+g8K7xU0shXpttOeOltkGgRUlyD
	 u2GKJK9TfFohG2zhefeHtrQ7DZ3KId6CoDvrn6oAuOLx8hDsKUCH+kNpzplTsXUo37
	 hcGZghH52jZ7uVNST4ugKEOrTDrYZyfU2MJfQI4cgtefy8cRLRrT0vc1Vg5+rlcfP4
	 d4FZKjIXEORfA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	rafael@kernel.org,
	linux-arch@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: irq: set the correct node for VMAP stack
Date: Tue,  5 Dec 2023 15:16:36 +0000
Message-Id: <170178641072.13754.15163791015207648414.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231124031513.81548-1-shijie@os.amperecomputing.com>
References: <ZV-EA46rBJ9WK4UH@arm.com> <20231124031513.81548-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 24 Nov 2023 11:15:13 +0800, Huang Shijie wrote:
> In current code, init_irq_stacks() will call cpu_to_node().
> The cpu_to_node() depends on percpu "numa_node" which is initialized in:
>      arch_call_rest_init() --> rest_init() -- kernel_init()
> 	--> kernel_init_freeable() --> smp_prepare_cpus()
> 
> But init_irq_stacks() is called in init_IRQ() which is before
> arch_call_rest_init().
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: irq: set the correct node for VMAP stack
      https://git.kernel.org/arm64/c/75b5e0bf90bf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

