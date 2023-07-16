Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B4754CE2
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jul 2023 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGPASg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGPASf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 20:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645812D;
        Sat, 15 Jul 2023 17:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6850760C4E;
        Sun, 16 Jul 2023 00:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BEAC433C8;
        Sun, 16 Jul 2023 00:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689466713;
        bh=418o5psNdMRdFlKcUS6XKpTnTtdjq3bya0znIgig6+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nKRdrLu8bv5eYAJ2c5iKAM16xzr7Ue5vgO7pVwpFxT7Vms+/WnOwFUaEhqsj6db3M
         TRmxINruQbTjtN7VeyujDj3dNERtdMd1JMAFFvwdBSlgiB0o0nUg8gpe6iIgom9Vr5
         KqG/zIZyo0nXgQGNcB49jSvS5Zy1CsYvl2030kGlWnC3n/7BZ4+a4FQyr8vqv2ybMV
         naL5FxDCer9WSF9PkfqHrIU4OxW+voC5TW8S8zwkz2FjdsVHKfnf4FRxx3DmLMdldg
         gKXnakElPq1PJb83oeaTpXvy/kfpFlyUzkC9hHiLV0bjnmVcBp1QIFR0qd0hjyjqAd
         lOBzCTqElYc4g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52165886aa3so2551713a12.3;
        Sat, 15 Jul 2023 17:18:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLb22KoG7Q0bTNCAgDiWpd5Gd3zbs7RdV7YyCmaUidygO5vDYrBu
        ODX/00bZUhjc7cIrNU4jhTUX5FsgZIe95k1FEYI=
X-Google-Smtp-Source: APBJJlHzxbR/lWTU76n+iCQzgJcyerhJDEeEMmfSWflH4fXXmY1WbVAGXQc9ps6hIg7/+8l7CUvwffdlnZUJTVsGn+Y=
X-Received: by 2002:aa7:d684:0:b0:51d:e7b5:547d with SMTP id
 d4-20020aa7d684000000b0051de7b5547dmr8017511edr.34.1689466712015; Sat, 15 Jul
 2023 17:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230715134552.3437933-1-guoren@kernel.org>
In-Reply-To: <20230715134552.3437933-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 16 Jul 2023 08:18:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ3CLatagXuSE-W4yZA=8XWJcNXRo8+mJN5iofMHdct3w@mail.gmail.com>
Message-ID: <CAJF2gTQ3CLatagXuSE-W4yZA=8XWJcNXRo8+mJN5iofMHdct3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: stack: Fixup independent softirq/irq stack for CONFIG_FRAME_POINTER=n
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I'm sorry, this patch would break CONFIG_FRAME_POINTER=3Dy, so please aband=
on it.

I've updated a v2 with the stable@ver.kernel.org tag fixed:
https://lore.kernel.org/linux-riscv/20230716001506.3506041-1-guoren@kernel.=
org/


On Sat, Jul 15, 2023 at 9:46=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The independent softirq/irq stack uses s0 to save & restore sp, but s0
> would be corrupted when CONFIG_FRAME_POINTER=3Dn. So add s0 in the clobbe=
r
> list to fix the problem.
>
> <+0>:     addi    sp,sp,-32
> <+2>:     sd      s0,16(sp)
> <+4>:     sd      s1,8(sp)
> <+6>:     sd      ra,24(sp)
> <+8>:     sd      s2,0(sp)
> <+10>:    mv      s0,a0         --> compiler allocate s0 for a0 when CONF=
IG_FRAME_POINTER=3Dn
> <+12>:    jal     ra,0xffffffff800bc0ce <irqentry_enter>
> <+16>:    ld      a5,56(tp) # 0x38
> <+20>:    lui     a4,0x4
> <+22>:    mv      s1,a0
> <+24>:    xor     a5,a5,sp
> <+28>:    bgeu    a5,a4,0xffffffff800bc092 <do_irq+88>
> <+32>:    auipc   s2,0x5d
> <+36>:    ld      s2,1118(s2) # 0xffffffff801194b8 <irq_stack_ptr>
> <+40>:    add     s2,s2,a4
> <+42>:    addi    sp,sp,-8
> <+44>:    sd      ra,0(sp)
> <+46>:    addi    sp,sp,-8
> <+48>:    sd      s0,0(sp)
> <+50>:    addi    s0,sp,16      --> our code clobber the s0
> <+52>:    mv      sp,s2
> <+54>:    mv      a0,s0         --> a0 got wrong value for handle_riscv_i=
rq
> <+56>:    jal     ra,0xffffffff800bbb3a <handle_riscv_irq>
>
> Guo Ren (2):
>   riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=3Dn
>   riscv: stack: Fixup independent softirq stack for
>     CONFIG_FRAME_POINTER=3Dn
>
>  arch/riscv/kernel/irq.c   | 2 +-
>  arch/riscv/kernel/traps.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.36.1
>


--
Best Regards

 Guo Ren
