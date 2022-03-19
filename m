Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803AE4DE7BB
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiCSLxu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiCSLxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 07:53:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F112D089;
        Sat, 19 Mar 2022 04:52:27 -0700 (PDT)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2w8Y-1nWecn2kYe-003K7R; Sat, 19 Mar 2022 12:52:25 +0100
Received: by mail-wr1-f44.google.com with SMTP id u16so13882106wru.4;
        Sat, 19 Mar 2022 04:52:25 -0700 (PDT)
X-Gm-Message-State: AOAM531ByU0sI/2bn02vqTKHhWKY2/aN2hS1cbGMHLi8jqiaus+87QMj
        8uqM99uifWEG/WZdmneUqK9bYUC5Jfz5c/aLTiM=
X-Google-Smtp-Source: ABdhPJzOqE/Bj2845oGYA9I/vUafx6lRNFhtD7eJ9j8Ek6fjOIipAB1M/2KUUME6tL7BmWOlQ180nTuXODQbbfNP21U=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr4299612wrw.12.1647690745320; Sat, 19
 Mar 2022 04:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220319035457.2214979-1-guoren@kernel.org> <20220319035457.2214979-2-guoren@kernel.org>
In-Reply-To: <20220319035457.2214979-2-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 19 Mar 2022 12:52:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wMJv6-fGo_i4DnFMigj=ko4DN1XTe8oa1HzWLiX50yw@mail.gmail.com>
Message-ID: <CAK8P3a3wMJv6-fGo_i4DnFMigj=ko4DN1XTe8oa1HzWLiX50yw@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] asm-generic: ticket-lock: New generic ticket-based spinlock
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:APP0UyWRzlhnr75oWsg0uoVpzBK/G2ciPVAgJcz8CFm2q4U4blu
 oycPpDGtzuOjc/IjPSKzsZGFh+CFjeZo5qAvi+yGMXfXvy1aN5vMI349A51yK5Lan6giQEy
 UREnUpyEN+869DJBLv9oJh10bjeNr3HG50cv4seBCAyUyT6DD8h/4s71e2y8aGMhqzZKfD5
 eyJ2fcDHZCkQBYJBDWjGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j/j6WPhVZew=:bygOB6UYLCSHtvhqmC7FjX
 /5/QFLivE/I0SvGGxvYSnUNa7jP3Aob8JcfouP01ylqCUjW4sg3o1pledeuKjMhaGXuQDfRgB
 4y1x3kFaEmZ9x7xNt+mHG/056V8WsdoG3of8yn6mEh8GKx5i4Y+hyShyIENAm9/Ml7ht8O5Sh
 GPWOVzloOj0uWFpkYDYoeJfDpBFms0a8PwjO5fn3Dgc+IkWTtO5zdh9j/z2cD9NtyKQcmQk9r
 ADtNnoaWy5V9luG5k38Fxk2R8aETf1N+UhyFMtdby16yXr3DhnvMy6dFMGmMugaV1T9nPWYrh
 zlMT2939rarZPKIUac3kx7lPaF+Oc8KbaVsXpW55piCR8nZmwCJa1+0rC9P0Dx2i0BCaqWlxv
 cs+d1WjPcCOULRG+MfzYN95Q6Dv2fngHKZYpFniw0EnY83OZb6Lz5ePscvA+4+HEymn5XXdOm
 0oTXv23o9VYrg7+YvHzwjqzmfgE8Aqteca12lyBOaUExFiQIYuNEbcsVOYFlbtiTRQXlZgfvy
 MGp9Nxe2+uy0FyJNIMGv83ebFqhIdfRLEc4oGHhxNpRGoamsW7Qmqe/Z00UACO7M4x72TrOAv
 Y7BpzS0mPgUUDpqvWxBneCGk20DnOsTcwwrmNEequnXvvGFK0rmrwsZtVLRV4YFUbt729DGTu
 xjZaNx7A29vldO+n9PzscFBNEOV69YMEAi/nhnpWNYnHvHv8Y5fqU3N5WXKPoyqMMn0U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 4:54 AM <guoren@kernel.org> wrote:
>  /*
> - * You need to implement asm/spinlock.h for SMP support. The generic
> - * version does not handle SMP.
> + * Using ticket-spinlock.h as generic for SMP support.
>   */
>  #ifdef CONFIG_SMP
> -#error need an architecture specific asm/spinlock.h
> +#include <asm-generic/ticket-lock.h>
> +#ifdef CONFIG_QUEUED_RWLOCKS
> +#include <asm-generic/qrwlock.h>
> +#else
> +#error Please select ARCH_USE_QUEUED_RWLOCKS in architecture Kconfig
> +#endif
>  #endif

There is no need for the !CONFIG_SMP case, as asm/spinlock.h only ever
gets included for SMP builds in the first place. This was already a mistake
in the existing code, but your change would be the time to fix it.

I would also drop the !CONFIG_QUEUED_RWLOCKS case, just include
it unconditionally. If any architecture wants the ticket spinlock in
combination with a custom rwlock, they can simply include the
asm-generic/ticket-lock.h from their asm/spinlock.h, but more
likely any architecture that can use the ticket spinlock will also
want the qrwlock anyway.

     Arnd
