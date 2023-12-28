Return-Path: <linux-arch+bounces-1195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8E81F457
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 04:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBC1F22135
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC01106;
	Thu, 28 Dec 2023 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nfF7UQxS"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9010F2;
	Thu, 28 Dec 2023 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1703733552;
	bh=EfJurZriD67cDIIwfiSM+kPHFvEVVHjMJmp7iWbFTLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nfF7UQxSvEFaj4zjVVDZFGc/PuImmuvaZ3mEKMBJyLZm//iqAnLT0yisJQwrCU7S0
	 bVxB5akL39HmDbuq/jT4FGLf0kG7kMimzsxsXVIQl/mVEy6wniHoOa3HjFqSvwg89c
	 FwIVvXQps64q92tRsf80IoYSQySfoqSCVs6siW9OBv42MMkw4ViUAtXCJbfNsKG6jA
	 JedpVqkGyrM26BxsJG65GhzLbngP100uf6zRb8p8DvCR1wTRoUbRUvXTe88wX+1nMn
	 fbLyXQTIPhHG72UC0XCwCWZ6EhuHxg/PdFGez6CnLQRSkY31By3C1FxLqqZHNiIIU8
	 bOMIA4nGmREWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T0tyk6hCKz4wxx;
	Thu, 28 Dec 2023 14:19:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Holland <samuel.holland@sifive.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org, Christoph Hellwig
 <hch@lst.de>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org, Samuel Holland
 <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 08/14] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <20231228014220.3562640-9-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-9-samuel.holland@sifive.com>
Date: Thu, 28 Dec 2023 14:19:08 +1100
Message-ID: <87wmszj9oz.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Holland <samuel.holland@sifive.com> writes:
> PowerPC provides an equivalent to the common kernel-mode FPU API, but in
> a different header and using different function names. The PowerPC API
> also requires a non-preemptible context. Add a wrapper header, and
> export the CFLAGS adjustments.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/powerpc/Kconfig           |  1 +
>  arch/powerpc/Makefile          |  5 ++++-
>  arch/powerpc/include/asm/fpu.h | 28 ++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/include/asm/fpu.h

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

