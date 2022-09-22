Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714D05E57FA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Sep 2022 03:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIVB0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 21:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIVB0y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 21:26:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04C9DF9D;
        Wed, 21 Sep 2022 18:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD369B81E1A;
        Thu, 22 Sep 2022 01:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8772AC43145;
        Thu, 22 Sep 2022 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663810010;
        bh=6OvF45eCl5d2FjxziCWsCcjLdCsAYOFNQse2WIemCjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iDuwNAKIcR9nkcBbRDkDpjI9/guVnVBkMqVocMaBR6eZPP4O3tNIzJGYFoqk5qlOB
         T7kXk17eMshImBvw91L9+uk7kj+rNqzlZFAafvDz0lPgAJxI4PnvyGAkCr0U1+kI7X
         cMSNdQW1QOfQoi81TM2o/9/OK4IIbE1Ge3emToO0KwC3emoXcOdU81e9r7eoA+sqvd
         eJ7Illgs4SWf91dAn02emRLgcn9kI65JxSIjGn91YIKLJyxlrVkJEJ3SWPCOF+l/hU
         ySvsvLratHV3Q1BSq4xUvhUsPmRse/JUXGP+Au6rWsbk9hZbvuuBiMos6y4xkNsupp
         HXjiJUbqr3Q2g==
Received: by mail-ot1-f48.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so5206522otq.12;
        Wed, 21 Sep 2022 18:26:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf2u9YNFGyxFpUtvvLy7cS4SxudTQKys4cpjDIrLiGhm0iHkt3nc
        byIGcDZYs6gSXAXTxz+zgfKV2iENRk60NWv2Psc=
X-Google-Smtp-Source: AMsMyM7sUE7ECUkudO8TSiHPeKKpJfG4rB1Npzrr8yg2CelDFVDUFYydQ/U0cLV7L/t1G7ZtbXSsham+YdjuDi0Aqx0=
X-Received: by 2002:a05:6830:1213:b0:65a:9a2:daf3 with SMTP id
 r19-20020a056830121300b0065a09a2daf3mr483252otp.308.1663810009513; Wed, 21
 Sep 2022 18:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-9-guoren@kernel.org>
 <afa17bdd-2d11-4015-6e2a-7a39db931d09@huawei.com> <CAJF2gTRMt4zDQcvBOxge-4+6o1mqhWds_AiFKamdCzKJZfoKPw@mail.gmail.com>
 <df9590bc-1a61-28c0-55eb-9f9539d03144@huawei.com>
In-Reply-To: <df9590bc-1a61-28c0-55eb-9f9539d03144@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 22 Sep 2022 09:26:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSZmqW-KnL5oFrCMsf+FSyqn=W6GCtPs6983e26it8Qug@mail.gmail.com>
Message-ID: <CAJF2gTSZmqW-KnL5oFrCMsf+FSyqn=W6GCtPs6983e26it8Qug@mail.gmail.com>
Subject: Re: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 21, 2022 at 7:56 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> Hi,
>
> Sorry to bother again, I just finished the test with your patches on
> mine patch set.
>
> On 2022/9/21 17:53, Guo Ren wrote:
> > On Wed, Sep 21, 2022 at 4:34 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> >> Hi,
> >>
> >> On 2022/9/18 23:52, guoren@kernel.org wrote:
> >>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> >>> index 5f49517cd3a2..426529b84db0 100644
> >>> --- a/arch/riscv/kernel/entry.S
> >>> +++ b/arch/riscv/kernel/entry.S
> >>> @@ -332,6 +332,33 @@ ENTRY(ret_from_kernel_thread)
> >>>        tail syscall_exit_to_user_mode
> >>>    ENDPROC(ret_from_kernel_thread)
> >>>
> >>> +#ifdef CONFIG_IRQ_STACKS
> >>> +ENTRY(call_on_stack)
> >>> +     /* Create a frame record to save our ra and fp */
> >>> +     addi    sp, sp, -RISCV_SZPTR
> >>> +     REG_S   ra, (sp)
> >>> +     addi    sp, sp, -RISCV_SZPTR
> >>> +     REG_S   fp, (sp)
> >>> +
> >>> +     /* Save sp in fp */
> >>> +     move    fp, sp
> >>> +
>
> Considering that s0 points to previous sp normally, I think here we
> should have 'addi fp, sp, 2*RISCV_SZPTR'.
>
> An example below:
>
>      addi    sp, sp, -16
>      sd  ra, 8(sp)
>      sd  s0, 0(sp)
>      addi    s0, sp, 16    <- s0 is set to previous sp
>      ...
>
>      ld  ra,8(sp)
>      ld  s0,0(sp)
>      addi    sp,sp,16
>
> So maybe it's better to save the stack frame as below:
>
>      addi    sp, sp, -2*RISCV_SZPTR
>      REG_S   ra, RISCV_SZPTR(sp)
>      REG_S   s0, (sp)
>
>      /* Save sp in fp */
>      addi    s0, sp, 2*RISCV_SZPTR
>
>      ...
>
>      /*
>       * Restore sp from prev fp, and fp, ra from the frame
>       */
>      addi    sp, s0, -2*RISCV_SZPTR
>      REG_L   ra, RISCV_SZPTR(sp)
>      REG_L   s0, (sp)
>      addi    sp, sp, 2*RISCV_SZPTR
>
>
> Anyway, lets set fp as sp + 2 * RISCV_SZPTR, so that unwinder can
> connect two stacks same as normal function.
>
> I tested this with my patch and the unwinder works properly.
Thx, you got it. My patch broke the fp chain. I would fix it in the
next version.

>
>
> Thanks for your time!
>
> Best,
>
> Chen
>
> >>> +     /* Move to the new stack and call the function there */
> >>> +     li      a3, IRQ_STACK_SIZE
> >>> +     add     sp, a1, a3
> >>> +     jalr    a2
> >>> +
> >>> +     /*
> >>> +      * Restore sp from prev fp, and fp, ra from the frame
> >>> +      */
> >>> +     move    sp, fp
> >>> +     REG_L   fp, (sp)
> >>> +     addi    sp, sp, RISCV_SZPTR
> >>> +     REG_L   ra, (sp)
> >>> +     addi    sp, sp, RISCV_SZPTR
> >>> +     ret
> >>> +ENDPROC(call_on_stack)
> >>> +#endif
> >> Seems my compiler (riscv64-linux-gnu-gcc 8.4.0, cross compiling from
> >> x86) cannot recognize the register `fp`.
> > The whole entry.S uses s0 instead of fp, so I approve of your advice. Thx.
> >
> >> After I changed it to `s0` this can pass compiling.
> >>
> >>
> >> Seems there is nowhere else using `fp`, can this just using `s0` instead?
> >>
> >> Best,
> >>
> >> Chen
> >>
> >>



-- 
Best Regards
 Guo Ren
