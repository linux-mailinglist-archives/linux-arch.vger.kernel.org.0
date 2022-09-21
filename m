Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71555BF628
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIUGQS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 02:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIUGQR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 02:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7117FE7E;
        Tue, 20 Sep 2022 23:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FAE6237F;
        Wed, 21 Sep 2022 06:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A9C43143;
        Wed, 21 Sep 2022 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663740976;
        bh=cNqXuM4/r1oFK58tkWe1aNJ1OBze/WTcp9aFMeMbeMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rb9o1/w9KyR+0qq4bAv7Ys8e0MjLjiM6hglaayZCV1n9XdVdl71DqeurYgYuHEr7m
         llwnKslrNGyuuSxETwvf1PlnAsJpgsHutrQBlSly53VjIMroowyLF038KEInV8RsS0
         cjUfbD6+PwMrbJHfeIQQg2RkyS1RTOySgXb54zQxmko3GF56TQzqIFqM+8nXBsDrqO
         AIljj2ZKCDcF6hZzxAD6ePG0i1AEnV1y89pAy99Y5aqTeFdbvF1Wec8LjEPx8hovKH
         etpbY9XAFA2BfR+SRV6ZQWm2Rfm4BABhc7Mb5ed3i5Exa9uSPT6XzfG0BoNHhMttPz
         ylp2+gTDiPTTA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127dca21a7dso7590331fac.12;
        Tue, 20 Sep 2022 23:16:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf00tqoMbLWmkypMdxbovx/EU96VxvimeUWroBdoWrnj2XM98McI
        ciz3eIIUGXKZwUJJeVndVwhejQh5oAIaah6PtkI=
X-Google-Smtp-Source: AMsMyM7K4lu41kJXQ0pd8zcm4aW2MCuxwDMR4j5oGDnAq7EXvY5dlsWZpoSRwWsOhQij/CqlEP3XnbdNnx/lqcqf89o=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr3993282oap.19.1663740975257; Tue, 20 Sep
 2022 23:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-9-guoren@kernel.org>
 <Yyhyap+Xi3UtV+T0@hirez.programming.kicks-ass.net> <CAJF2gTS9rFTndZXvDG+XNOOEwZYC_Hbu9TOO_F+4gQo1mRF2bQ@mail.gmail.com>
 <Yylrd77Eh9v7OKLj@hirez.programming.kicks-ass.net> <Yyls+xIUsLCIa7pj@hirez.programming.kicks-ass.net>
In-Reply-To: <Yyls+xIUsLCIa7pj@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 14:16:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTFLEV47OT6hM0DwaSbm+4-Q_s+x0Wc3MFjpv1Kr4rbKQ@mail.gmail.com>
Message-ID: <CAJF2gTTFLEV47OT6hM0DwaSbm+4-Q_s+x0Wc3MFjpv1Kr4rbKQ@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 20, 2022 at 09:27:51AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 20, 2022 at 02:08:55PM +0800, Guo Ren wrote:
> > > On Mon, Sep 19, 2022 at 9:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Sun, Sep 18, 2022 at 11:52:43AM -0400, guoren@kernel.org wrote:
> > > >
> > > > > +ENTRY(call_on_stack)
> > > > > +     /* Create a frame record to save our ra and fp */
> > > > > +     addi    sp, sp, -RISCV_SZPTR
> > > > > +     REG_S   ra, (sp)
> > > > > +     addi    sp, sp, -RISCV_SZPTR
> > > > > +     REG_S   fp, (sp)
> > > > > +
> > > > > +     /* Save sp in fp */
> > > > > +     move    fp, sp
> > > > > +
> > > > > +     /* Move to the new stack and call the function there */
> > > > > +     li      a3, IRQ_STACK_SIZE
> > > > > +     add     sp, a1, a3
> > > > > +     jalr    a2
> > > > > +
> > > > > +     /*
> > > > > +      * Restore sp from prev fp, and fp, ra from the frame
> > > > > +      */
> > > > > +     move    sp, fp
> > > > > +     REG_L   fp, (sp)
> > > > > +     addi    sp, sp, RISCV_SZPTR
> > > > > +     REG_L   ra, (sp)
> > > > > +     addi    sp, sp, RISCV_SZPTR
> > > > > +     ret
> > > > > +ENDPROC(call_on_stack)
> > > >
> > > > IIRC x86_64 moved away from a stack-switch function like this because it
> > > > presents a convenient exploit gadget.
> > > I found:
> > > https://lore.kernel.org/all/20210204204903.350275743@linutronix.de/
> > >
> > >   - The fact that the stack switching code ended up being an easy to find
> > >     exploit gadget.
> > >
> > > What's the exploit gadget? Do you have a ref link? Thx.
> >
> > Sadly no, I do not. Kees might. But basically it boils down to this
> > function taking both a stack pointer and a function pointer as
> > arguments (@a1 and @a2 resp. if I'm not reading this wrong).
> >
> > If an attacker can call this with arguments of its choice then it gains
> > full control of subsequent execution.
>
> If you inline it the hope is that the function pointers go away or at
> least the encompassing function doesn't have quite such a 'convenient'
> signature to hijack control flow.
Thanks for mentioning it. I would change to an inline style.


-- 
Best Regards
 Guo Ren
