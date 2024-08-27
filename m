Return-Path: <linux-arch+bounces-6655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68D9605A2
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D3E1F24430
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1279119CD17;
	Tue, 27 Aug 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DxHa9hxJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA41714B8;
	Tue, 27 Aug 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751118; cv=none; b=jS7VOEKwk+TGbQNfgPssDUo+BdADNEbu1l2/WtO87+XVA0eby24E39OkZHiu9EUHS7tofcht9VrJfcLKK8iTOWss6Gw2W3TCQG/0xN7E8ZpPPSPxhL2htpfXSdK9Gv1ARM4RtzEQ0rrEsRVQ+kHPhyNJ4SVHJV76eNngkOjdXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751118; c=relaxed/simple;
	bh=v5la12xuZlpJAHBwKesqG3ct7vbuw4Dwscy40oiBezU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXZXHBKbFxio7amxifvsto4gD/RExVzGPVwdoVERrJ/jsknJUx24GeM0Ukx4+/QZ89JetBZt+/B3RiFEGhS9VsWpGb5hJvIdZzcVvDfmtN4/OYqf6BpHIri2vHfGbRGKL2sBbX2K7ibnkX1acthQf48BAPwSOxekvEgpZLBhnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DxHa9hxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94408C8B7CD;
	Tue, 27 Aug 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DxHa9hxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724751112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdIowXx5hArmXp0irpZ89oIJDLeZuVLuZPGcLtq5hgU=;
	b=DxHa9hxJdBbjx/iowG23VxSZyG/CGmRspd62YsjFHqw0za1fqkq/Nd7+a80kDZL2Tm7peD
	o/We6F+5fwEzQZMoosma4XFBPFOH2qWxrLQ/P73o66d8kChstBj6lF3d8wi2fZxcpqCXkw
	uIFnWdSd9qKW1JqXm2PC/smuCa0IZ5c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ecb5f7c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 09:31:50 +0000 (UTC)
Date: Tue, 27 Aug 2024 11:31:43 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
	Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev
Subject: getrandom() vDSO archs (arm64, ppc, loongarch) for 6.12 [Was: Re:
 [PATCH v2 00/17] Wire up getrandom() vDSO implementation on powerpc]
Message-ID: <Zs2c_9Z6sFMNJs1O@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswsennpw6fvigVh@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zswsennpw6fvigVh@zx2c4.com>

Hey again,

On Mon, Aug 26, 2024 at 09:19:22AM +0200, Jason A. Donenfeld wrote:
> Thanks for this series. There are quite a few preliminary patches in it,
> before you get to the PPC part, which fix up general build system or test
> harness correctness issues. Since some of those affect all architectures
> that are adding vDSO getrandom() support for 6.12, I'm going to take
> those into my random.git tree as a fix for 6.11 now, in hopes that the
> new archs can mostly go into arch trees without too many tree
> interdependencies.
> 
> So I'll reply to individual patches for that, mentioning which ones I
> extract.

Seeing the volume of these and the amount of ground they touch, I'm now
having second thoughts about rushing this into 6.11. Particularly with
the header changes, I think it might be smart to let it cook in
linux-next for a bit before sending it to Linus.

  $ git --no-pager diff --name-only linus/master
  arch/x86/entry/vdso/vma.c
  arch/x86/include/asm/pvclock.h
  arch/x86/include/asm/vdso/vsyscall.h
  drivers/char/random.c
  include/asm-generic/unaligned.h
  include/vdso/helpers.h
  include/vdso/unaligned.h
  lib/vdso/Makefile
  lib/vdso/getrandom.c
  tools/arch/x86/vdso
  tools/include/linux/linkage.h
  tools/testing/selftests/vDSO/Makefile
  tools/testing/selftests/vDSO/vdso_config.h
  tools/testing/selftests/vDSO/vdso_test_getrandom.c

So I think what I'll do is, for 6.11-rc6, send in the real bug fixes,
which right now amount to:

  - random: vDSO: reject unknown getrandom() flags
  - random: vDSO: don't use 64-bit atomics on 32-bit architectures

  $ git --no-pager diff --name-only linus/master..a90592ab7cad
  drivers/char/random.c
  lib/vdso/getrandom.c

And then for the pending aarm64, ppc64(/32?), and loongarch enablement
patches for 6.12, I'll just take those through my random.git tree, which
have all of these build-system preliminaries. And then we'll obviously
require acks from the maintainers of the archs for each of those arch
enablement patches.

If that sounds like an acceptable plan, you might want to mention in the
cover letter that you're basing your arch-specific patches on
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/ and
want an ack from the arch maintainer, etc.

Jason

