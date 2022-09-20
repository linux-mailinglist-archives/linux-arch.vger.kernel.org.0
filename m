Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE9E5BDCE5
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiITGJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 02:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITGJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 02:09:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A65E5FEE;
        Mon, 19 Sep 2022 23:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B252B824A7;
        Tue, 20 Sep 2022 06:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1E8C43146;
        Tue, 20 Sep 2022 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663654148;
        bh=zfzusDb14FFN7gQb0UhtuJazqWZoNGqu03mLfuxOeXs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YbI2CTg3AVEHucpqvxxaOBdV2hkT2IvObY2/2uiRAZl4LPc9txSPdOupykJxFAVMc
         //M1Mzrw51exNgGidLKPFzwB2m4s2KkxAWKM+gxkfmmzAs92T6BvEnuxAhOnjET2Uy
         guixZF8zkN6jDCP9wBE0CW4uzx10LCsB/Zw0QyfLPL3S5HHfhxe4N3QfiwWQxLXUlv
         VS93azSDm5Zu3A5wdiUUcSxH0RC8wBu68DtFdUPG12joDbj1/sfdHWx7rHO3ntTRUI
         3Nqsk16We6SY3LXy2sKztSn5Aif3XmkpHd4e7siFVjY6My6yOF56ojfwtJ69uSEZQ2
         xVkCfLpwCUSlw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-127ba06d03fso2795999fac.3;
        Mon, 19 Sep 2022 23:09:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf15jnapojjA9H2dUaLEtHyEEjmUPGhmNhR61zssylhfaEziAXiA
        g+uK6H7PPILI84Cv9pP/b3bQ2bmZFMnLlhsYPiI=
X-Google-Smtp-Source: AMsMyM5/BTTDa5v+eF4g4y/fFcD46UVeV81LVzz0xqS4N4SXQrDzkSWMO2JEIpuBTgQQr/IPW3RpNyik4vHqQmdADDU=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr1079696oap.19.1663654147825; Mon, 19 Sep
 2022 23:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-9-guoren@kernel.org>
 <Yyhyap+Xi3UtV+T0@hirez.programming.kicks-ass.net>
In-Reply-To: <Yyhyap+Xi3UtV+T0@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Sep 2022 14:08:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS9rFTndZXvDG+XNOOEwZYC_Hbu9TOO_F+4gQo1mRF2bQ@mail.gmail.com>
Message-ID: <CAJF2gTS9rFTndZXvDG+XNOOEwZYC_Hbu9TOO_F+4gQo1mRF2bQ@mail.gmail.com>
Subject: Re: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 19, 2022 at 9:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Sep 18, 2022 at 11:52:43AM -0400, guoren@kernel.org wrote:
>
> > +ENTRY(call_on_stack)
> > +     /* Create a frame record to save our ra and fp */
> > +     addi    sp, sp, -RISCV_SZPTR
> > +     REG_S   ra, (sp)
> > +     addi    sp, sp, -RISCV_SZPTR
> > +     REG_S   fp, (sp)
> > +
> > +     /* Save sp in fp */
> > +     move    fp, sp
> > +
> > +     /* Move to the new stack and call the function there */
> > +     li      a3, IRQ_STACK_SIZE
> > +     add     sp, a1, a3
> > +     jalr    a2
> > +
> > +     /*
> > +      * Restore sp from prev fp, and fp, ra from the frame
> > +      */
> > +     move    sp, fp
> > +     REG_L   fp, (sp)
> > +     addi    sp, sp, RISCV_SZPTR
> > +     REG_L   ra, (sp)
> > +     addi    sp, sp, RISCV_SZPTR
> > +     ret
> > +ENDPROC(call_on_stack)
>
> IIRC x86_64 moved away from a stack-switch function like this because it
> presents a convenient exploit gadget.
I found:
https://lore.kernel.org/all/20210204204903.350275743@linutronix.de/

  - The fact that the stack switching code ended up being an easy to find
    exploit gadget.

What's the exploit gadget? Do you have a ref link? Thx.

>
> I'm not much of an exploit writer and I've no idea how effective our
> inline stategy is, perhaps other can comment.
It seems that I should move to an inline flavor. a0cfc74d0b00
("x86/irq: Provide macro for inlining irq stack switching")

-- 
Best Regards
 Guo Ren
