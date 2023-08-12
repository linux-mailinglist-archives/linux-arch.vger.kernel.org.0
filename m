Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583E779BD2
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjHLATQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 20:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjHLATP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 20:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBBC26B6;
        Fri, 11 Aug 2023 17:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5106166433;
        Sat, 12 Aug 2023 00:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB257C4339A;
        Sat, 12 Aug 2023 00:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691799553;
        bh=ZH7R8L9H36iGum3yddu2dsyzpdsuw1sAIenikiEMZA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ay4YlKH5YOBAS9PJ9FowqgsyJw2ANhvUwCuhnSwEbJdZhlvPKQzuw8CAibvAA2gr0
         G2Mum8efPmzCKhj2iVg5XstRQELdn9DTh4UwcrgRpg+z37C2I4WFinYitJKYPoYQ7W
         /lGYlwI79qNPj/8BsId04ZaeWRo4bbLMjS3G/794FSkFYaqh5R/J/R8291T79zWm+P
         ITy4f1L8K2IiLCZ2Zf8r0RkmwJAhIPvp07qWxfuyWdABsPyzyt8c4i0Wz8Tkv9ULiv
         OrMu0agB2Z3b/Rv8W5/ssWQFwNWty0xHiKyJXiy8LntRG0Aka1gC8jDL95sn4jke+D
         f7r89GSd+vuyg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so5201306a12.0;
        Fri, 11 Aug 2023 17:19:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YzgLLUNT329wR1OyXQKk+ZeUsutp6F5KR3vT2sM16bQowqOaseC
        bwwdu37dFDzpqRw/YeE+sIWlK/wLpqy8Dr2gWmk=
X-Google-Smtp-Source: AGHT+IGykQHZkBnk0VjR3Xj0zOX9nVrUef4Ne260Er2ch8t9g/FTZHcOPiq+G7Cvcs2WlBhAQJvmDn5QazlY9Qk6qU4=
X-Received: by 2002:a05:6402:11c9:b0:51e:5bd5:fe7e with SMTP id
 j9-20020a05640211c900b0051e5bd5fe7emr8275790edw.17.1691799551836; Fri, 11 Aug
 2023 17:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230802164701.192791-1-guoren@kernel.org> <20230802164701.192791-5-guoren@kernel.org>
 <ec070d3b-80fb-b625-cde1-80ead49c6227@redhat.com>
In-Reply-To: <ec070d3b-80fb-b625-cde1-80ead49c6227@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Aug 2023 08:18:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTq2i6Bv7vq4_aV0pD-vOrNJQ=5Rfm7fCLHfNw-Zy3QMQ@mail.gmail.com>
Message-ID: <CAJF2gTTq2i6Bv7vq4_aV0pD-vOrNJQ=5Rfm7fCLHfNw-Zy3QMQ@mail.gmail.com>
Subject: Re: [PATCH V10 04/19] riscv: qspinlock: Add basic queued_spinlock support
To:     Waiman Long <longman@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 12, 2023 at 3:34=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
>
> On 8/2/23 12:46, guoren@kernel.org wrote:
> >       \
> > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm=
/spinlock.h
> > new file mode 100644
> > index 000000000000..c644a92d4548
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RISCV_SPINLOCK_H
> > +#define __ASM_RISCV_SPINLOCK_H
> > +
> > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > +#define _Q_PENDING_LOOPS     (1 << 9)
> > +#endif
> > +
> > +#ifdef CONFIG_QUEUED_SPINLOCKS
>
> You can merge the two "#ifdef CONFIG_QUEUED_SPINLOCKS" into single one
> to avoid the duplication.
Okay.

>
> Cheers,
> Longman
>
> > +#include <asm/qspinlock.h>
> > +#include <asm/qrwlock.h>
> > +#else
> > +#include <asm-generic/spinlock.h>
> > +#endif
> > +
> > +#endif /* __ASM_RISCV_SPINLOCK_H */
>


--=20
Best Regards
 Guo Ren
