Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6775E557670
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiFWJR6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWJR5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 05:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7827270D;
        Thu, 23 Jun 2022 02:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4261A61D9A;
        Thu, 23 Jun 2022 09:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A128BC341C0;
        Thu, 23 Jun 2022 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655975873;
        bh=U8j5P0qtBZIDNBnCMPBu0upIuqsJV+Rdn2D6qm/fQeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NtJ3Zr13mthb3BDCLbM39D2dq7T07zfd88Rhronw3t2GgWJdMTh5TzfHiFmSGDOwS
         7EtsaQMNvrjA3NDtR+BnDeRTBb2N0wenD0R6Co5vP9meSLo8hpP0tDmNxS4TcSgtI+
         rVzpEHUWoiS5UajU2zeJGjVXQRDehoCeEg4XJQTddGDOlTf4GXqlqg20zTqv5TC6pH
         BugmY/ITKB1sS4tyYnN+EarvAlERWRFZrWlzq4DTegD8A5rv/4L2gRTemknuLyhjdf
         aSOTuZEpDzMQreTcbsTIfNYCqZviWaFXXNcjQ1656vAzIwi6KyubK1KPd0w3uszi9x
         74sXg+nUqfUsw==
Received: by mail-vs1-f49.google.com with SMTP id j1so9926703vsj.12;
        Thu, 23 Jun 2022 02:17:53 -0700 (PDT)
X-Gm-Message-State: AJIora/KXXJ8Z7dRmBGqXxUqraX7obMts5PzOTSrJAuOygjx/MvmGhw2
        tIFFCdq5xnxtc3xvjyJ5H2/5+xzISBUnQnNI974=
X-Google-Smtp-Source: AGRyM1vRxDL3RZ5DSRydCo8VPaFKP8w64JSpP9HmeCA1/VJQQp5/RZMHA6dneZ6BrymmJh8xDJhiM4APQg/4l0bZllc=
X-Received: by 2002:a05:6102:3e93:b0:353:a8fb:e922 with SMTP id
 m19-20020a0561023e9300b00353a8fbe922mr11614815vsv.51.1655975872663; Thu, 23
 Jun 2022 02:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220621144920.2945595-1-guoren@kernel.org> <20220621144920.2945595-2-guoren@kernel.org>
 <CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Jun 2022 17:17:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTagygiQmNnxFG01ZbVKoHNc0rSbaPAjNFxxf7D7te3uQ@mail.gmail.com>
Message-ID: <CAJF2gTTagygiQmNnxFG01ZbVKoHNc0rSbaPAjNFxxf7D7te3uQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] asm-generic: spinlock: Move qspinlock &
 ticket-lock into generic spinlock.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, Rui Wang <r@hev.cc>,
        Stafford Horne <shorne@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 23, 2022 at 4:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 21, 2022 at 4:49 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Separate ticket-lock into tspinlock.h and let generic spinlock support
> > qspinlock or ticket-lock selected by CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > config.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/asm-generic/spinlock.h        | 90 ++------------------------
> >  include/asm-generic/spinlock_types.h  | 14 ++--
> >  include/asm-generic/tspinlock.h       | 92 +++++++++++++++++++++++++++
> >  include/asm-generic/tspinlock_types.h | 17 +++++
>
> Unless someone has a very good argument for the "tspinlock" name, I would
> prefer naming the new file ticket_spinlock.h. While the 'qspinlock' name has
> an established meaning already, this is not the case for 'tspinlock', and
> the longer name would be less confusing in my opinion.
Okay. ticket_spinlock is also good to me.

>
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +#include <asm/qspinlock.h>
> >  #include <asm/qrwlock.h>
> > +#else
> > +#include <asm-generic/tspinlock.h>
> > +#endif
>
> As Huacai Chen suggested in the other thread, the asm/qrwlock.h include should
> be outside of the #ifdef here.
Okay


>
> > diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
> > index 8962bb730945..9875c1d058b3 100644
> > --- a/include/asm-generic/spinlock_types.h
> > +++ b/include/asm-generic/spinlock_types.h
> > @@ -3,15 +3,11 @@
> >  #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
> >  #define __ASM_GENERIC_SPINLOCK_TYPES_H
> >
> > -#include <linux/types.h>
> > -typedef atomic_t arch_spinlock_t;
> > -
> > -/*
> > - * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
> > - * include.
> > - */
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +#include <asm-generic/qspinlock_types.h>
> >  #include <asm/qrwlock_types.h>
> > -
> > -#define __ARCH_SPIN_LOCK_UNLOCKED      ATOMIC_INIT(0)
> > +#else
> > +#include <asm-generic/tspinlock_types.h>
> > +#endif
>
> I don't think this file warrants the extra indirection, since both
> versions have only a
> few lines. Just put it all into one file, and change the files that include
> asm-generic/qspinlock_types.h to use asm-generic/spinlock_types.h instead.

Okay, I'll try that.


>
>       Arnd



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
