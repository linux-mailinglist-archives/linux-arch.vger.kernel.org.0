Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF4552782
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbiFTXDy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346434AbiFTXDJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 19:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B7205C2;
        Mon, 20 Jun 2022 16:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DC761423;
        Mon, 20 Jun 2022 23:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BC9C341C8;
        Mon, 20 Jun 2022 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766184;
        bh=/TZe/YP2QF337a39WuOjnChciiFdYN/X4oGHttBLylw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AoqibELdgjr34VaW8NlOKdLsMLL0zJAR+Ot62A7bBcNfSwpl3s6QRkHaQMd/Y8zOv
         sXmjPgDgKLDQpRrbRnimJcA974C7wddl0930lTu06ZwvxdNtpzZLqXGiy0J+Q0cshK
         WpXN7djRT0S/5ktJY64Qmc1N7UbPzV2DU24jXTC5MHIJPH3reQSb/94Zd5cf2pKtXT
         zp5Ji96ZTyCNsUdpaPF3SwM2N/1wGwnk3OdZwVnSAOtSuV/2+GFL8EZpN8Khnn0Bsi
         29s9g/K5REXRF5mUA5HgXLTEnMrqK82CrEHpQTBGIaoXGp4Vr1BGyc2sGqGf+1swmE
         iAt0s6Licjk3Q==
Received: by mail-vs1-f46.google.com with SMTP id l28so3957740vsb.1;
        Mon, 20 Jun 2022 16:03:03 -0700 (PDT)
X-Gm-Message-State: AJIora+mX9VpWZLz62rZWq0RFZu4yVe0UAVH57zYL/DxPkyhWiUvSSBY
        B82F/ayKgx8SAF16vdVn7Ry4ztQTD8SiMezZYMg=
X-Google-Smtp-Source: AGRyM1u/RVN5U63G9HFr68t8lzKAMpiuuVrHV89dBmegx0UQHU1v8TtMPi2UxFLK89ZVnLG11vabRaQ+NgahQlUGj7w=
X-Received: by 2002:a05:6102:5493:b0:34b:b583:f557 with SMTP id
 bk19-20020a056102549300b0034bb583f557mr10777975vsb.2.1655766182967; Mon, 20
 Jun 2022 16:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220620155404.1968739-1-guoren@kernel.org> <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Jun 2022 07:02:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT9YHgTzPaBN4ekYS7UcBOj_9k9xEcrsoXgW6PCZc8x3Q@mail.gmail.com>
Message-ID: <CAJF2gTT9YHgTzPaBN4ekYS7UcBOj_9k9xEcrsoXgW6PCZc8x3Q@mail.gmail.com>
Subject: Re: [PATCH V5] riscv: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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

On Tue, Jun 21, 2022 at 4:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jun 20, 2022 at 5:54 PM <guoren@kernel.org> wrote:
> > >+config RISCV_USE_QUEUED_SPINLOCKS
> > +       bool "Using queued spinlock instead of ticket-lock"
>
> Maybe we can just make ARCH_USE_QUEUED_SPINLOCKS
> user visible and give users the choice between the two generic
> implementations across all architectures that support the qspinlock
> variant.
>
> In arch/riscv, you'd then just have a
>
>         select ARCH_HAVE_QUEUED_SPINLOCKS
Good point, but I think it should be another cross-arch cleanup
patchset, let's put qspinlock in riscv first with the current
framework.

>
> diff --git a/arch/riscv/include/asm/spinlock.h
> b/arch/riscv/include/asm/spinlock.h
> > new file mode 100644
> > index 000000000000..fd3fd09cff52
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_SPINLOCK_H
> > +#define __ASM_SPINLOCK_H
> > +
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +#include <asm/qspinlock.h>
> > +#include <asm/qrwlock.h>
> > +#else
> > +#include <asm-generic/spinlock.h>
> > +#endif
> > +
>
> Along the same lines:
>
> I think I'd prefer the header changes to be done in the asm-generic
> version of this file, so this can be shared across all architectures
> that want to give the choice between ticket and queued spinlock.
I would put the above part in the series, but they would base on the
riscv qspinlock patch.

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
