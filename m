Return-Path: <linux-arch+bounces-11050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797FA6D02C
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 18:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A1A18945C3
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D113B7AE;
	Sun, 23 Mar 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T60O6Nje"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303523595D;
	Sun, 23 Mar 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742749970; cv=none; b=ZmeKcZY/m+EIQ4ScxNZhCcdN1LTpl2A8lib7CJ79M5Tq42Q2Ki/FylfqXjGEUwe5f1oOnAzKK7qISDZlLO/ByF6KFypbhka6RqcpgSe4bjaZYMsdJpsiZ2+SHLGQhEtqiMoUtet8QkoyQg6H/RBT8azTeNsCffB2niJUN3Lb9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742749970; c=relaxed/simple;
	bh=XozAwQbTpUGYueKBZlPi1Tm0N8h4iRa1gpfz6WWgGhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/yrFxBNmfa8RtUyxCfYfLh+jx7Xqdx+GUD1MWVe62VVINFxp63+FctZCCqb5KEc6mUMd7TatMnzXhCaAS+S8f01i3XwFhhLx7gV5C8Z3GcJonC9g4sYsTCxe0xI0iTGhaXPBe7GWO84vqKr7GIu7HQX0q+RnNFrwHLaQcsRYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T60O6Nje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64CEC4CEE2;
	Sun, 23 Mar 2025 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742749970;
	bh=XozAwQbTpUGYueKBZlPi1Tm0N8h4iRa1gpfz6WWgGhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T60O6NjeFks2vJ6xoS5NBfgqWn8g0dPX15v5A0FxuX5LYy3UbxKMI4+NeCdWURWZG
	 jCHwGkV04UqT5ic3MTt8KF6h9q5JEKJIlNLRXpxt4T4ZGEYsmnIVB2NU0YbS0Ydp7T
	 ZjWpEvA56svrG5y/IEJz+CstDBwaIxEQLdRVgbcupgsUaw30FA/gSyKbg57dS4bLro
	 mMQYE0Cu741xEKT8D/20is7yPBNPEYrB86hgDgBBSjY/sJnR8FxzPSpMYCaNB8fhxw
	 5Pdo5Fk0lpKO5EIkasrZ8lsQXMV+t9w32r+13Jscjh2ISDmJcyWosyKOOnxqqRI/wn
	 9pKRZr7zW+sug==
Date: Sun, 23 Mar 2025 10:12:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 08/12] lib/crc_kunit.c: add KUnit test suite for CRC
 library functions
Message-ID: <20250323171243.GA852@quark.localdomain>
References: <20241202012056.209768-1-ebiggers@kernel.org>
 <20241202012056.209768-9-ebiggers@kernel.org>
 <389b899f-893c-4855-9e30-d8920a5d6f91@roeck-us.net>
 <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>

On Sun, Mar 23, 2025 at 04:35:29PM +0100, Ard Biesheuvel wrote:
> On Sat, 22 Mar 2025 at 15:33, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > On Sun, Dec 01, 2024 at 05:20:52PM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > Add a KUnit test suite for the crc16, crc_t10dif, crc32_le, crc32_be,
> > > crc32c, and crc64_be library functions.  It avoids code duplication by
> > > sharing most logic among all CRC variants.  The test suite includes:
> > >
> > > - Differential fuzz test of each CRC function against a simple
> > >   bit-at-a-time reference implementation.
> > > - Test for CRC combination, when implemented by a CRC variant.
> > > - Optional benchmark of each CRC function with various data lengths.
> > >
> > > This is intended as a replacement for crc32test and crc16_kunit, as well
> > > as a new test for CRC variants which didn't previously have a test.
> > >
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > ...
> > > +
> > > +             nosimd = rand32() % 8 == 0;
> > > +
> > > +             /*
> > > +              * Compute the CRC, and verify that it equals the CRC computed
> > > +              * by a simple bit-at-a-time reference implementation.
> > > +              */
> > > +             expected_crc = crc_ref(v, init_crc, &test_buffer[offset], len);
> > > +             if (nosimd)
> > > +                     local_irq_disable();
> > > +             actual_crc = v->func(init_crc, &test_buffer[offset], len);
> > > +             if (nosimd)
> > > +                     local_irq_enable();
> >
> > This triggers a traceback on some arm systems.
> >
> > [    7.810000]     ok 2 crc16_benchmark # SKIP not enabled
> > [    7.810000] ------------[ cut here ]------------
> > [    7.810000] WARNING: CPU: 0 PID: 1145 at kernel/softirq.c:369 __local_bh_enable_ip+0x118/0x194
> > [    7.810000] Modules linked in:
> > [    7.810000] CPU: 0 UID: 0 PID: 1145 Comm: kunit_try_catch Tainted: G                 N 6.14.0-rc7-00196-g88d324e69ea9 #1
> > [    7.810000] Tainted: [N]=TEST
> > [    7.810000] Hardware name: NPCM7XX Chip family
> > [    7.810000] Call trace:
> > [    7.810000]  unwind_backtrace from show_stack+0x10/0x14
> > [    7.810000]  show_stack from dump_stack_lvl+0x7c/0xac
> > [    7.810000]  dump_stack_lvl from __warn+0x7c/0x1b8
> > [    7.810000]  __warn from warn_slowpath_fmt+0x19c/0x1a4
> > [    7.810000]  warn_slowpath_fmt from __local_bh_enable_ip+0x118/0x194
> > [    7.810000]  __local_bh_enable_ip from crc_t10dif_arch+0xd4/0xe8
> > [    7.810000]  crc_t10dif_arch from crc_t10dif_wrapper+0x14/0x1c
> > [    7.810000]  crc_t10dif_wrapper from crc_main_test+0x178/0x360
> > [    7.810000]  crc_main_test from kunit_try_run_case+0x78/0x1e0
> > [    7.810000]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
> > [    7.810000]  kunit_generic_run_threadfn_adapter from kthread+0x118/0x254
> > [    7.810000]  kthread from ret_from_fork+0x14/0x28
> > [    7.810000] Exception stack(0xe3651fb0 to 0xe3651ff8)
> > [    7.810000] 1fa0:                                     00000000 00000000 00000000 00000000
> > [    7.810000] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    7.810000] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > [    7.810000] irq event stamp: 29
> > [    7.810000] hardirqs last  enabled at (27): [<c037875c>] __local_bh_enable_ip+0xb4/0x194
> > [    7.810000] hardirqs last disabled at (28): [<c0b09684>] crc_main_test+0x2e4/0x360
> > [    7.810000] softirqs last  enabled at (26): [<c032a3ac>] kernel_neon_end+0x0/0x1c
> > [    7.810000] softirqs last disabled at (29): [<c032a3c8>] kernel_neon_begin+0x0/0x70
> > [    7.810000] ---[ end trace 0000000000000000 ]---
> > [    8.050000]     # crc_t10dif_test: pass:1 fail:0 skip:0 total:1
> >
> > kernel_neon_end() calls local_bh_enable() which apparently conflicts with
> > the local_irq_disable() in above code.
> >
> 
> This seems to be an oversight on my part. Can you try the below please?
> 
> diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
> index 82191dbd7e78..56ddbd3c4997 100644
> --- a/arch/arm/include/asm/simd.h
> +++ b/arch/arm/include/asm/simd.h
> @@ -4,5 +4,6 @@
> 
>  static __must_check inline bool may_use_simd(void)
>  {
> -       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && !in_hardirq();
> +       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> +              !in_hardirq() && !irqs_disabled();
>  }

Thanks Ard, you beat me to it.  Yes, may_use_simd() needs to be consistent with
kernel_neon_begin().  On x86 there is a case where the equivalent function is
expected to work when irqs_disabled(), but if there is no such case on arm this
fix looks good.  Can you send it out as a formal patch?  Presumably for the arm
maintainer to pick up.

> However, this test code also appears to assume that SIMD is forbidden
> on any architecture when IRQs are disabled, but this not guaranteed.

Yes, to reliably test the no-SIMD code paths, I need to finish refactoring the
crypto_simd_disabled_for_test stuff to be disentangled from the crypto subsystem
so that crc_kunit.c can use it.  It's on my list of things to do, and I'm
planning to get it done in 6.16.  Disabling hardirqs is just a trick to get
there more easily on some architectures.  But as this shows it's a useful test
to have anyway, so we'll want to keep that too.  The CRC functions need to work
in any context, and any context that we can easily test we should do so.

- Eric

