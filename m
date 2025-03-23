Return-Path: <linux-arch+bounces-11051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740D1A6D08E
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 19:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AEC3A7622
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941F013CF9C;
	Sun, 23 Mar 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOA/7Nht"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C9469D;
	Sun, 23 Mar 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753848; cv=none; b=KjXr7TLaUDjq1vEFVEhtP01HivSlVlY7b83nAIjwLido7lPclkez0wAK7EEl5QPTCBGX0K7BzObp8yMZ+LCydPcogO0x7nlTw+DrBzZgjBjmn6Xfi2vEtEXhLjk38F/vRp5IEfhDKw+LwvDe2v2bkjXvtw0TmzVmkBpNdXA7puA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753848; c=relaxed/simple;
	bh=DnwlcnrmTvJn4x6Jhu4lPS5Jhc5VMN4fOZX67Zowe28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9VuviQ5XN4OKp0La0lAAssbEW8jt9lhFniTPT6KPsbIhZ4WKLjHeQoDnJOIi5pJrVa+rC3bw3vXVsGjOxXn7qrQ7Uek1pHTD+D9M1K8RgzbCJg1Mh5h8MpdFNUnYnl/4GjRekZsWpNRmiCxjK/nsrMiEoHB+jHOGJUa2RXRdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOA/7Nht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0274C4CEE2;
	Sun, 23 Mar 2025 18:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742753847;
	bh=DnwlcnrmTvJn4x6Jhu4lPS5Jhc5VMN4fOZX67Zowe28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aOA/7NhtL5afDUxB+Zhh+QBnY+LwpQJbqtjSH6/f0XKI9u9yHS8Fy6dZOGSGOBDNF
	 Yo7o8R4WnRz3l9p/NdlRFPj5rCCzvDr7BSyHE2zABYhWGBbsYGCg3fFo3QgFJxIptJ
	 qGtyvOPq+jpo8Za7Ta5jL8YhzOt+K0JyPYIICFlTcmq/Wpj09RtsURrtf5atD7v9Gs
	 SBeOElN9wucBbLZI2M2JpI2QYkbM4EUeFPaE3LBQm54IPWgvKnLJ1jSVoWX+aMelBf
	 g/YJzRe3VkQ9c+cbty53T19yVHaBjH61CmhXB+p0Wf9DE7+gClaACxKKt0cwGXIX2p
	 lE9e5dA4IxG/Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549b116321aso3853042e87.3;
        Sun, 23 Mar 2025 11:17:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5L//ZSu3Lx0ETkPEVner35g3akM0O3RU7es3Qdwz7fOS7h8eJNe9FuIyiOOo4EKQJycHc5d6zIaVi@vger.kernel.org, AJvYcCVg7x5jQegATEqVRA496PMLxqj2PHKnwN1kEzyBWI8TCuaCmIjBaIerFVfd5qM4RpUBihKcvE9IakJ5pIBv@vger.kernel.org, AJvYcCXZF5l9O0MjHXpUqZxP+0WQxzL/fRxZg+rdW5mUK1SxRo/GL9Y3ERJWDdAR10vYfhbeIkvK6c7r6q1UGJ41@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgYlLYeOC8pRyLgLD/Mgt2tZ5eRIyz80YdxbN/gbw9UlSBh1g
	z8H0gJBP5VAgec3R05amK0D/FzNdsGob0XgCXyvtLHJeDls8IOuL/SGFyH0nf9gIhycMXLUJLxB
	nXzxofNp1rGJEWy2RF4oJ3HDs2BY=
X-Google-Smtp-Source: AGHT+IETHfg8ib2tQB5DP02LtHyjTXmPdsydvih0XDlfjgyQtoziDZQMtCctILBs1DwoARqUA+qqI6epKDqy+wlyiFE=
X-Received: by 2002:a05:6512:1598:b0:549:5769:6ad8 with SMTP id
 2adb3069b0e04-54ad6470a7dmr3513782e87.4.1742753846190; Sun, 23 Mar 2025
 11:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202012056.209768-1-ebiggers@kernel.org> <20241202012056.209768-9-ebiggers@kernel.org>
 <389b899f-893c-4855-9e30-d8920a5d6f91@roeck-us.net> <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>
 <20250323171243.GA852@quark.localdomain>
In-Reply-To: <20250323171243.GA852@quark.localdomain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Mar 2025 19:17:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGMtpMuiJqwWVuWDhRrb-dXC30Fj0vu0vU=O6-gGR0FWg@mail.gmail.com>
X-Gm-Features: AQ5f1Jq9h71nypQ2vOBZhli703EaGsNLFv7huy-pmiN-c5U6P8ctOyu2HMEj9rU
Message-ID: <CAMj1kXGMtpMuiJqwWVuWDhRrb-dXC30Fj0vu0vU=O6-gGR0FWg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] lib/crc_kunit.c: add KUnit test suite for CRC
 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, 
	Zhihang Shao <zhihang.shao.iscas@gmail.com>, Vinicius Peixoto <vpeixoto@lkcamp.dev>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Mar 2025 at 18:12, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Mar 23, 2025 at 04:35:29PM +0100, Ard Biesheuvel wrote:
> > On Sat, 22 Mar 2025 at 15:33, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Dec 01, 2024 at 05:20:52PM -0800, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > >
> > > > Add a KUnit test suite for the crc16, crc_t10dif, crc32_le, crc32_be,
> > > > crc32c, and crc64_be library functions.  It avoids code duplication by
> > > > sharing most logic among all CRC variants.  The test suite includes:
> > > >
> > > > - Differential fuzz test of each CRC function against a simple
> > > >   bit-at-a-time reference implementation.
> > > > - Test for CRC combination, when implemented by a CRC variant.
> > > > - Optional benchmark of each CRC function with various data lengths.
> > > >
> > > > This is intended as a replacement for crc32test and crc16_kunit, as well
> > > > as a new test for CRC variants which didn't previously have a test.
> > > >
> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > > Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > ...
> > > > +
> > > > +             nosimd = rand32() % 8 == 0;
> > > > +
> > > > +             /*
> > > > +              * Compute the CRC, and verify that it equals the CRC computed
> > > > +              * by a simple bit-at-a-time reference implementation.
> > > > +              */
> > > > +             expected_crc = crc_ref(v, init_crc, &test_buffer[offset], len);
> > > > +             if (nosimd)
> > > > +                     local_irq_disable();
> > > > +             actual_crc = v->func(init_crc, &test_buffer[offset], len);
> > > > +             if (nosimd)
> > > > +                     local_irq_enable();
> > >
> > > This triggers a traceback on some arm systems.
> > >
> > > [    7.810000]     ok 2 crc16_benchmark # SKIP not enabled
> > > [    7.810000] ------------[ cut here ]------------
> > > [    7.810000] WARNING: CPU: 0 PID: 1145 at kernel/softirq.c:369 __local_bh_enable_ip+0x118/0x194
> > > [    7.810000] Modules linked in:
> > > [    7.810000] CPU: 0 UID: 0 PID: 1145 Comm: kunit_try_catch Tainted: G                 N 6.14.0-rc7-00196-g88d324e69ea9 #1
> > > [    7.810000] Tainted: [N]=TEST
> > > [    7.810000] Hardware name: NPCM7XX Chip family
> > > [    7.810000] Call trace:
> > > [    7.810000]  unwind_backtrace from show_stack+0x10/0x14
> > > [    7.810000]  show_stack from dump_stack_lvl+0x7c/0xac
> > > [    7.810000]  dump_stack_lvl from __warn+0x7c/0x1b8
> > > [    7.810000]  __warn from warn_slowpath_fmt+0x19c/0x1a4
> > > [    7.810000]  warn_slowpath_fmt from __local_bh_enable_ip+0x118/0x194
> > > [    7.810000]  __local_bh_enable_ip from crc_t10dif_arch+0xd4/0xe8
> > > [    7.810000]  crc_t10dif_arch from crc_t10dif_wrapper+0x14/0x1c
> > > [    7.810000]  crc_t10dif_wrapper from crc_main_test+0x178/0x360
> > > [    7.810000]  crc_main_test from kunit_try_run_case+0x78/0x1e0
> > > [    7.810000]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
> > > [    7.810000]  kunit_generic_run_threadfn_adapter from kthread+0x118/0x254
> > > [    7.810000]  kthread from ret_from_fork+0x14/0x28
> > > [    7.810000] Exception stack(0xe3651fb0 to 0xe3651ff8)
> > > [    7.810000] 1fa0:                                     00000000 00000000 00000000 00000000
> > > [    7.810000] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > [    7.810000] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > [    7.810000] irq event stamp: 29
> > > [    7.810000] hardirqs last  enabled at (27): [<c037875c>] __local_bh_enable_ip+0xb4/0x194
> > > [    7.810000] hardirqs last disabled at (28): [<c0b09684>] crc_main_test+0x2e4/0x360
> > > [    7.810000] softirqs last  enabled at (26): [<c032a3ac>] kernel_neon_end+0x0/0x1c
> > > [    7.810000] softirqs last disabled at (29): [<c032a3c8>] kernel_neon_begin+0x0/0x70
> > > [    7.810000] ---[ end trace 0000000000000000 ]---
> > > [    8.050000]     # crc_t10dif_test: pass:1 fail:0 skip:0 total:1
> > >
> > > kernel_neon_end() calls local_bh_enable() which apparently conflicts with
> > > the local_irq_disable() in above code.
> > >
> >
> > This seems to be an oversight on my part. Can you try the below please?
> >
> > diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
> > index 82191dbd7e78..56ddbd3c4997 100644
> > --- a/arch/arm/include/asm/simd.h
> > +++ b/arch/arm/include/asm/simd.h
> > @@ -4,5 +4,6 @@
> >
> >  static __must_check inline bool may_use_simd(void)
> >  {
> > -       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && !in_hardirq();
> > +       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> > +              !in_hardirq() && !irqs_disabled();
> >  }
>
> Thanks Ard, you beat me to it.  Yes, may_use_simd() needs to be consistent with
> kernel_neon_begin().  On x86 there is a case where the equivalent function is
> expected to work when irqs_disabled(), but if there is no such case on arm this
> fix looks good.  Can you send it out as a formal patch?  Presumably for the arm
> maintainer to pick up.
>

Sure.

On other architectures, we might just turn this logic around, and only
disable softirqs when IRQs are enabled, as otherwise, there is no
need: we don't care about whether or not IRQs are disabled, only the
softirq plumbing that we need to call into does, and no softirqs can
be delivered over the back of a hard IRQ when those are disabled to
begin with.

> > However, this test code also appears to assume that SIMD is forbidden
> > on any architecture when IRQs are disabled, but this not guaranteed.
>
> Yes, to reliably test the no-SIMD code paths, I need to finish refactoring the
> crypto_simd_disabled_for_test stuff to be disentangled from the crypto subsystem
> so that crc_kunit.c can use it.  It's on my list of things to do, and I'm
> planning to get it done in 6.16.  Disabling hardirqs is just a trick to get
> there more easily on some architectures.  But as this shows it's a useful test
> to have anyway, so we'll want to keep that too.  The CRC functions need to work
> in any context, and any context that we can easily test we should do so.
>

Sounds good.

