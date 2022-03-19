Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118644DE828
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbiCSN2I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiCSN2I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 09:28:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF98BF3A;
        Sat, 19 Mar 2022 06:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 415AFCE0F08;
        Sat, 19 Mar 2022 13:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7985BC340EE;
        Sat, 19 Mar 2022 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647696403;
        bh=/cegirEsmDFTjrf/jcxsGyePYHoVLLLJoW1NFjz4T5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UmxrhwNaCnUWbJzDElDW7iWolt4CGGYJhefwhRmFTmzo2j87XTi4xTuJVs36kD5JG
         69RQ0mQCebSeuQ4AhaJApoX6VwElGf7V4BC8rfUkwWuvgpiaaPa3jGb3o+snOuTb2k
         NOW79cQNRqST7BAGRYUWAORXaDzvmSAg2B6w248PC3R6nvaui/SHW8FJ2hedBRDgYo
         coYR2xN+VaEyBa5EG9Wai4ohwlKADQhwfahLv5/R367rf9RlJFSK9pU+2Fz8mcgQcd
         RVyhLuTavC+pBjRe+rn71qGpXmglQXXvufsvxt9fTW+IlNYvFfJGdI4qYf+k3jbdu9
         86UD75gQwZlKg==
Received: by mail-vk1-f174.google.com with SMTP id 6so2674029vkc.10;
        Sat, 19 Mar 2022 06:26:43 -0700 (PDT)
X-Gm-Message-State: AOAM530s6MDiQsg7xEctm4OZYypobALtrS0WGMDh/QERgpyC9wcqNSRy
        X75QhuCwBE3gy4XQreoYWNTFwaOm8IVhBRentLU=
X-Google-Smtp-Source: ABdhPJxG6qrxPivDMuPuCDhlEL9zUSIkjTquHlcXEinKt2wIvI4so3PHrSQEnmjVSdhEdSsEmEbGCrUxLkOxGgBZ5z8=
X-Received: by 2002:a1f:7f17:0:b0:336:cede:7f97 with SMTP id
 o23-20020a1f7f17000000b00336cede7f97mr5353580vki.8.1647696402468; Sat, 19 Mar
 2022 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220319035457.2214979-1-guoren@kernel.org> <20220319035457.2214979-2-guoren@kernel.org>
 <CAK8P3a3wMJv6-fGo_i4DnFMigj=ko4DN1XTe8oa1HzWLiX50yw@mail.gmail.com>
In-Reply-To: <CAK8P3a3wMJv6-fGo_i4DnFMigj=ko4DN1XTe8oa1HzWLiX50yw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 19 Mar 2022 21:26:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRvOLZPP_PYOEPMkr0S3vTSiPZOCFOmiVRXxi2QRu-vMA@mail.gmail.com>
Message-ID: <CAJF2gTRvOLZPP_PYOEPMkr0S3vTSiPZOCFOmiVRXxi2QRu-vMA@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] asm-generic: ticket-lock: New generic ticket-based spinlock
To:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 7:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 4:54 AM <guoren@kernel.org> wrote:
> >  /*
> > - * You need to implement asm/spinlock.h for SMP support. The generic
> > - * version does not handle SMP.
> > + * Using ticket-spinlock.h as generic for SMP support.
> >   */
> >  #ifdef CONFIG_SMP
> > -#error need an architecture specific asm/spinlock.h
> > +#include <asm-generic/ticket-lock.h>
> > +#ifdef CONFIG_QUEUED_RWLOCKS
> > +#include <asm-generic/qrwlock.h>
> > +#else
> > +#error Please select ARCH_USE_QUEUED_RWLOCKS in architecture Kconfig
> > +#endif
> >  #endif
>
> There is no need for the !CONFIG_SMP case, as asm/spinlock.h only ever
> gets included for SMP builds in the first place. This was already a mistake
> in the existing code, but your change would be the time to fix it.
>
> I would also drop the !CONFIG_QUEUED_RWLOCKS case, just include
> it unconditionally. If any architecture wants the ticket spinlock in
> combination with a custom rwlock, they can simply include the
> asm-generic/ticket-lock.h from their asm/spinlock.h, but more
> likely any architecture that can use the ticket spinlock will also
> want the qrwlock anyway.
I agree, !CONFIG_SMP & !CONFIG_QUEUED_RWLOCKS are unnecessary.

@Palmer, you could pick back the series, thx.

>
>      Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
