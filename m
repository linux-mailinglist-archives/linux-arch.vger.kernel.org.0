Return-Path: <linux-arch+bounces-11048-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF0A6CFE3
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D0716E829
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CF7F7FC;
	Sun, 23 Mar 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzmqxlQZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F261FFE;
	Sun, 23 Mar 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742744143; cv=none; b=M9Eok4dVyttSD0iGCDFqLWJpGzzKAKOosKPGTry5gmCLTCK0Tc/Hn0+ozoj333Y/7GJ0xYgfMybtFF7GvlKeRXjy7k6thuDY4A88sjcHnxCkmiG83VB8arANuTTy4pPoDgLAzyEkCo7Ihozpmaq7wfEyinJjoAqtxkyxBMAysPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742744143; c=relaxed/simple;
	bh=2N2/cZq9PK/1OD9D7rI0owgZtoMseqZwZPwvsoNCvXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KV+TAANwadQ2Cga9xv9jzHqxJD2z53gLCFLo+eHYzgoGbWIzG1JbX85dVn+3ZbKUgxnd29512JSkmDVvbC2pn4S5Z51yl3BNVMruXJfFKs+825mVObOf0sjQ+S+MLQvQJb+mOnC3LPQBH+IjZrxg62l2cOuXssHTC30jXuq49+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzmqxlQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F99AC4CEF2;
	Sun, 23 Mar 2025 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742744142;
	bh=2N2/cZq9PK/1OD9D7rI0owgZtoMseqZwZPwvsoNCvXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YzmqxlQZ/kTC9/X6Nbi0GB4G6dV1X5hxISwkHmhgwt+ADGF1rsm2my+JKh4mm7gTO
	 +Wi+rZl6qtd7joIEhSO4JjncVE0ybEAvVK7JCS4uu6Boqvk1pR24pn6AMMZ15HCWIh
	 rKE/PGJWjn9J9RMSeQa2SpYcm0g9hTT/wjdQG2e/2NDeKmx1GP1KD2uen16RiKiwFV
	 JozAfd8P1mxnh01D1tCnXGKy3+fJZSk8nD3yn9ulQ4y6XbpS33orG9bW0i6oV4A5Vr
	 Pf23igPbAiWHiFXd2YZjJAiwLavwGSqTFn703gDMtMv/2QePdOgR+mET98nJCNPmOG
	 uweKQUDjq2hMA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so37223961fa.2;
        Sun, 23 Mar 2025 08:35:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4A9JLK5BKBGO+NX6gBqpkqcCc4ySgIDPZhmoKfajMHl+h/vawlz9jxUEwCkv2DuWRk6Z5FUyY0EIkYL4d@vger.kernel.org, AJvYcCVuqtYRtoj/75WoMB20XAsBkb5Ry803mS9lb8IcEpOBq7IE3d3uQ5yQobCILbdldIsDYrZxnw80Fj/NcJuN@vger.kernel.org, AJvYcCXiisoQWOf1B1QoY7+acVOO2U+kI/+jIJS/kRStvvBIF3UyyPCyoVyYs28cpnBeJa3W1BUPCRZUCwfe@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZOjxySx4yp/nuu980N2ZxL9jbxaxp7VUJ1EJ4iBRWm/NIATL
	lblHJ+UDY2AhArPikC0zgxmQx0zCiEhNUqdKw4AkHHuTHAHMnZmuQYJaNrASuf0yX2BYpUTc89l
	jwj1L1I8LxFKgAjcR7vMTVyASYzM=
X-Google-Smtp-Source: AGHT+IFLcZeXGkTxlRz0UlNugKaJuCUYhZIJxwtZuNGOXiFAM7FV0N99brYUCnXNyXzlAo8JVSr/VCRroadSoUTiddY=
X-Received: by 2002:a2e:be85:0:b0:30b:a187:44ad with SMTP id
 38308e7fff4ca-30d7e2ba306mr36637601fa.26.1742744140424; Sun, 23 Mar 2025
 08:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202012056.209768-1-ebiggers@kernel.org> <20241202012056.209768-9-ebiggers@kernel.org>
 <389b899f-893c-4855-9e30-d8920a5d6f91@roeck-us.net>
In-Reply-To: <389b899f-893c-4855-9e30-d8920a5d6f91@roeck-us.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Mar 2025 16:35:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>
X-Gm-Features: AQ5f1JoDr3TNnxKgMP4guUoXVQFse2BD4z6mD7wYVwiWtnHwnC7PDo4J2TBYgEQ
Message-ID: <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] lib/crc_kunit.c: add KUnit test suite for CRC
 library functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, 
	Zhihang Shao <zhihang.shao.iscas@gmail.com>, Vinicius Peixoto <vpeixoto@lkcamp.dev>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Mar 2025 at 15:33, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Sun, Dec 01, 2024 at 05:20:52PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Add a KUnit test suite for the crc16, crc_t10dif, crc32_le, crc32_be,
> > crc32c, and crc64_be library functions.  It avoids code duplication by
> > sharing most logic among all CRC variants.  The test suite includes:
> >
> > - Differential fuzz test of each CRC function against a simple
> >   bit-at-a-time reference implementation.
> > - Test for CRC combination, when implemented by a CRC variant.
> > - Optional benchmark of each CRC function with various data lengths.
> >
> > This is intended as a replacement for crc32test and crc16_kunit, as well
> > as a new test for CRC variants which didn't previously have a test.
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> ...
> > +
> > +             nosimd = rand32() % 8 == 0;
> > +
> > +             /*
> > +              * Compute the CRC, and verify that it equals the CRC computed
> > +              * by a simple bit-at-a-time reference implementation.
> > +              */
> > +             expected_crc = crc_ref(v, init_crc, &test_buffer[offset], len);
> > +             if (nosimd)
> > +                     local_irq_disable();
> > +             actual_crc = v->func(init_crc, &test_buffer[offset], len);
> > +             if (nosimd)
> > +                     local_irq_enable();
>
> This triggers a traceback on some arm systems.
>
> [    7.810000]     ok 2 crc16_benchmark # SKIP not enabled
> [    7.810000] ------------[ cut here ]------------
> [    7.810000] WARNING: CPU: 0 PID: 1145 at kernel/softirq.c:369 __local_bh_enable_ip+0x118/0x194
> [    7.810000] Modules linked in:
> [    7.810000] CPU: 0 UID: 0 PID: 1145 Comm: kunit_try_catch Tainted: G                 N 6.14.0-rc7-00196-g88d324e69ea9 #1
> [    7.810000] Tainted: [N]=TEST
> [    7.810000] Hardware name: NPCM7XX Chip family
> [    7.810000] Call trace:
> [    7.810000]  unwind_backtrace from show_stack+0x10/0x14
> [    7.810000]  show_stack from dump_stack_lvl+0x7c/0xac
> [    7.810000]  dump_stack_lvl from __warn+0x7c/0x1b8
> [    7.810000]  __warn from warn_slowpath_fmt+0x19c/0x1a4
> [    7.810000]  warn_slowpath_fmt from __local_bh_enable_ip+0x118/0x194
> [    7.810000]  __local_bh_enable_ip from crc_t10dif_arch+0xd4/0xe8
> [    7.810000]  crc_t10dif_arch from crc_t10dif_wrapper+0x14/0x1c
> [    7.810000]  crc_t10dif_wrapper from crc_main_test+0x178/0x360
> [    7.810000]  crc_main_test from kunit_try_run_case+0x78/0x1e0
> [    7.810000]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
> [    7.810000]  kunit_generic_run_threadfn_adapter from kthread+0x118/0x254
> [    7.810000]  kthread from ret_from_fork+0x14/0x28
> [    7.810000] Exception stack(0xe3651fb0 to 0xe3651ff8)
> [    7.810000] 1fa0:                                     00000000 00000000 00000000 00000000
> [    7.810000] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    7.810000] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    7.810000] irq event stamp: 29
> [    7.810000] hardirqs last  enabled at (27): [<c037875c>] __local_bh_enable_ip+0xb4/0x194
> [    7.810000] hardirqs last disabled at (28): [<c0b09684>] crc_main_test+0x2e4/0x360
> [    7.810000] softirqs last  enabled at (26): [<c032a3ac>] kernel_neon_end+0x0/0x1c
> [    7.810000] softirqs last disabled at (29): [<c032a3c8>] kernel_neon_begin+0x0/0x70
> [    7.810000] ---[ end trace 0000000000000000 ]---
> [    8.050000]     # crc_t10dif_test: pass:1 fail:0 skip:0 total:1
>
> kernel_neon_end() calls local_bh_enable() which apparently conflicts with
> the local_irq_disable() in above code.
>

This seems to be an oversight on my part. Can you try the below please?

diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
index 82191dbd7e78..56ddbd3c4997 100644
--- a/arch/arm/include/asm/simd.h
+++ b/arch/arm/include/asm/simd.h
@@ -4,5 +4,6 @@

 static __must_check inline bool may_use_simd(void)
 {
-       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && !in_hardirq();
+       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+              !in_hardirq() && !irqs_disabled();
 }

However, this test code also appears to assume that SIMD is forbidden
on any architecture when IRQs are disabled, but this not guaranteed.

