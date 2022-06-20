Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA45525E9
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiFTUmj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiFTUmi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 16:42:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2AF1AF19;
        Mon, 20 Jun 2022 13:42:37 -0700 (PDT)
Received: from mail-yw1-f169.google.com ([209.85.128.169]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5gAG-1o1iCH2DCE-007EMd; Mon, 20 Jun 2022 22:42:35 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3176b6ed923so111566467b3.11;
        Mon, 20 Jun 2022 13:42:35 -0700 (PDT)
X-Gm-Message-State: AJIora8fJDX1Y+b353Ldet4S3M6lPp/lybJXoTzyQynK9C8rZrj1T5ar
        W5Gp55HvfvqWacWsr3cccVGaKjHABb/lXLf8THk=
X-Google-Smtp-Source: AGRyM1sIFEAcARCpUAqHrTpOeRmkN9ZFqetDdPpULBWhN1/m9GTMKCzSuXlUzIGbL4Fwbk9/rb6lbI4rEuazL0L0JVg=
X-Received: by 2002:a0d:ca0f:0:b0:317:a2cc:aa2 with SMTP id
 m15-20020a0dca0f000000b00317a2cc0aa2mr14210907ywd.347.1655757754247; Mon, 20
 Jun 2022 13:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220620155404.1968739-1-guoren@kernel.org>
In-Reply-To: <20220620155404.1968739-1-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jun 2022 22:42:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
Message-ID: <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
Subject: Re: [PATCH V5] riscv: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cNRTLBlusI5o3hJigIRUBOKbHBBzbpLiMf/7bboIhJOi/yCQkXG
 CL8v8iO55GV0hoIGLPBfw2kuk+hsSRNnZgjhTmxnXAKEO+PnKjlfi0/46PtuafHErprubac
 lG6twU4EI1M8wTF/5qs5P37wJQ4T7enQEwWlxxNLP3zczGTB5MoNQlao6BQHGFb87aKzeXD
 tynOjF/xHeIu29FG61WHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HiUZtfdPacM=:iUp9emvvjjwa+9NndJLwdv
 FLpt6Jx1mGZbecYfdUjQSSVmjRzZqBaeM53ZGXQ3w7fsW14p4TNXhU3f28ewqwnq+GAopW/Os
 kQl81rM5IQfUqtkT32OCFh92xV5jEz/fKZHcTt7q5xPCuyvwMu4oeyeXa29DuQfwyWzCt4h1S
 VEpjA6xzW8d7Dl5NaLWfc5VDWAKqcZVG6/UgR79EUwLbbOPQdqZFkFPgm0b8oJGHQA+QFs9xZ
 5QjPytwUIz1hA2Ez6bfVAEq3nKQRT/kHtaL2wj2cur+kq//+OItJZ+JEGKLminF219a0hVluN
 uc5qiV5t1vGU4dma8vsKKv8h2v/vNgGUPJNwCAodo2e7xdyrkv0vOeAdtv1s4w0z7WVulzcyY
 OcLUuCz+e6Oogb+xkKYIurzm0WeuQwUVLprZcryH2RQeLu8HWXTjxwMP3MPxw7BYKjMlqbAkj
 bNBPt5R8rZPEXFX+WI54KtzIICTsthDfqJvheu0MDlSA1AgYd788eI61lStzPctOMM88uRhuP
 9OjWChbpXQf9xfJFQYh1Ki+QCDZqb/Jl0kcspOlkhwoV31RxU9Phzt1o1csgPZEO+WDeP2B61
 qzp8+m7W66X9vDIryygYi6bC9/Soq6atF1h+7EinZzooadPRBIVbnic7ONrkDndixtHyAejDR
 P824LPnMM1c9SmNWheQ5UoGrGm9RQIBwi5/6KGdKIz7VbfnCqbmiCFa1q5jYlP7L54ea4yrUz
 D4rM0jZc7v9lySMQqnt49YR+dfjdH/9ldeb+2d5jCKGYdg9ek1TknqXTeeANyHlbOXO216EH2
 6uu6jx109vLay7ypETsny2wjuV7SfWyaSTRJfG6dSgpiXVp6lvFBNs9B06kot8ofzhqRK83Br
 WweKDOX8ywI/menqbZpQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 20, 2022 at 5:54 PM <guoren@kernel.org> wrote:
> >+config RISCV_USE_QUEUED_SPINLOCKS
> +       bool "Using queued spinlock instead of ticket-lock"

Maybe we can just make ARCH_USE_QUEUED_SPINLOCKS
user visible and give users the choice between the two generic
implementations across all architectures that support the qspinlock
variant.

In arch/riscv, you'd then just have a

        select ARCH_HAVE_QUEUED_SPINLOCKS

diff --git a/arch/riscv/include/asm/spinlock.h
b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..fd3fd09cff52
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_SPINLOCK_H
> +#define __ASM_SPINLOCK_H
> +
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +#else
> +#include <asm-generic/spinlock.h>
> +#endif
> +

Along the same lines:

I think I'd prefer the header changes to be done in the asm-generic
version of this file, so this can be shared across all architectures
that want to give the choice between ticket and queued spinlock.

        Arnd
