Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007FB220A55
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgGOKmy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 06:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgGOKmx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 06:42:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56018C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 03:42:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so2089258wrp.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RMoJg0iwHXCKzoaQm24OqDN7mm5uxvqFCCrIZxIcI3U=;
        b=CxgsK7z+UwYBgoJlF//D64fKl2zoYe1rLiBIWxaKmUFy6RR3XQqNvhT2PPTmpSDLU+
         wu8zhlU5PIpyzNKrhGEdLkdDlOTZXumAbJ2pGwHo6UqmKmB9S6qXaKnpUbPZuZrEL8UI
         P0EZbWGs+O2PFGuJkrZzAopZnPeD4KspNsq0f4tys3ZnSGk+lG9PhCmBkmc0wPtHSlH9
         SXe3KDATj8a00yL/cuMS/R1gCdyQ3Olh+SATMIo0RmJFaYQlV2bQgXpwNG9CnOVrny7t
         bYe9qGTGP+jWT60tebE98NkVlqY9H1YVOEhhlAlK7WUIVdx6y/JGXoZigcFG6ctR8Axo
         qhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RMoJg0iwHXCKzoaQm24OqDN7mm5uxvqFCCrIZxIcI3U=;
        b=nXKkYmPGoV3hfLfr73v2Jn41pmkQtUNP5xc1r4RPazOIjmKYOBsKWlIezXdZzudHl3
         jezIav+nig8jVCGTe9AVwcSYk13IOh1wuG9g3K2DLtaE61GId86ps9l/ssACDS+cn+Tq
         KNjCOqtm4eqYCeGI7+2KaXUUhk+xceuNf2C1yhujLgpHON0CBNo173RJ71gMeabkJzm9
         sO1yEEuL3pWcUY18FTg/wTdKcTwP0QeWJLEkPgKJao2PXBvglYqzmStYbyWVOjq13zeb
         httA0CA/nJy+6KX4gRKhyAhv407TX4AGxPqGLdgIRMrPjVWL+DKIhSWpigMBTR+F8Pd7
         jFdQ==
X-Gm-Message-State: AOAM533vBlq9JcmSWlqOUZEIB0STlClGSdpPtXYl8XAAOXvMfj417X2K
        4Z2Te6tHbmsEEaxxQcTkU+VHug==
X-Google-Smtp-Source: ABdhPJxv0l68wRCEYAeGzveZKt/xu+hM6J2CDy20/QEAv04ewqEXjQi8ZDiNAKNZHoje3x1NrQvkMQ==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr10126799wru.22.1594809771755;
        Wed, 15 Jul 2020 03:42:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a833])
        by smtp.gmail.com with ESMTPSA id n16sm2890572wrq.39.2020.07.15.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:42:51 -0700 (PDT)
Date:   Wed, 15 Jul 2020 11:42:46 +0100
From:   Will Deacon <willdeacon@google.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     kernel@esmil.dk, guoren@kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
Message-ID: <20200715104246.GA3143299@google.com>
References: <CANBLGcw8nVvshaOxiBO3zSpjE2oEmWE7C4vuvDXYheRdFVLK0A@mail.gmail.com>
 <mhng-09237735-4773-4f28-bfb6-b619f1dd4e09@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-09237735-4773-4f28-bfb6-b619f1dd4e09@palmerdabbelt-glaptop1>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 14, 2020 at 11:45:11PM -0700, Palmer Dabbelt wrote:
> > > > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > > > > > > > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
> > > > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > > > > > > > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
> > > > > > > > [<ffffffe0004715c4>] regmap_write+0x28/0x48
> > > > > > > > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
> > > > > > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
> > > > > > > > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
> > > > > > > > [<ffffffe000467e16>] really_probe+0x92/0x21a
> > > > > > > > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
> > > > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > > > > > > > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
> > > > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > > > > > > > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
> > > > > > > > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
> > > > > > > > [<ffffffe00046889a>] driver_register+0x32/0xc6
> > > > > > > > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
> > > > > > > > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
> > > >
> > > > Hmm.. the problem is that preemption is *not* disabled when
> > > > smp_processor_id is called, right?
> > > 
> > > Yes!
> > > 
> > > smp_processor_id is defined as:
> > > 
> > >  * This is the normal accessor to the CPU id and should be used
> > >  * whenever possible.
> > >  *
> > >  * The CPU id is stable when:
> > >  *
> > >  *  - IRQs are disabled;
> > >  *  - preemption is disabled;
> > >  *  - the task is CPU affine.
> > >  *
> > >  * When CONFIG_DEBUG_PREEMPT; we verify these assumption and WARN
> > >  * when smp_processor_id() is used when the CPU id is not stable.
> > > 
> > > So regmap_write->regmap_mmio_write should be PREEMPT disabled in
> > > sifive_gpio_probe().
> > 
> > Ah! Sorry, now I think I understand. So you're saying that the real
> > problem is that the driver framework should have disabled preemption
> > before calling any .probe functions, but for some reason that doesn't
> > happen on RISC-V?
> 
> I think it's actually an issue with the generic mmiowb stuff and that we should
> just elide the check.  I'm adding Will, for context.  I'll send out a patch.

Hmm. Although I _think_ something like the diff below ought to work, are you
sure you want to be doing MMIO writes in preemptible context? Setting
'.disable_locking = true' in 'sifive_gpio_regmap_config' implies to me that
you should be handling the locking within the driver itself, and all the
other regmap writes are protected by '&gc->bgpio_lock'.

Given that riscv is one of the few architectures needing an implementation
of mmiowb(), doing MMIO in a preemptible section seems especially dangerous
as you have no way to ensure completion of the writes without adding an
mmiowb() to the CPU migration path (i.e. context switch).

Will

--->8

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
index 9439ff037b2d..5698fca3bf56 100644
--- a/include/asm-generic/mmiowb.h
+++ b/include/asm-generic/mmiowb.h
@@ -27,7 +27,7 @@
 #include <asm/smp.h>
 
 DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
-#define __mmiowb_state()       this_cpu_ptr(&__mmiowb_state)
+#define __mmiowb_state()       raw_cpu_ptr(&__mmiowb_state)
 #else
 #define __mmiowb_state()       arch_mmiowb_state()
 #endif /* arch_mmiowb_state */
@@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
 static inline void mmiowb_set_pending(void)
 {
        struct mmiowb_state *ms = __mmiowb_state();
-       ms->mmiowb_pending = ms->nesting_count;
+
+       if (likely(ms->nesting_count))
+               ms->mmiowb_pending = ms->nesting_count;
 }
 
 static inline void mmiowb_spin_lock(void)

