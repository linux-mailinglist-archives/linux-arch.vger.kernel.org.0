Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C115BFBC1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIUJyb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiIUJyI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 05:54:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54246A18D;
        Wed, 21 Sep 2022 02:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4612B82F38;
        Wed, 21 Sep 2022 09:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717FBC43148;
        Wed, 21 Sep 2022 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663754033;
        bh=M7t6IiqXpQGB9XaRaXvCXP2eKsC0VvYqKrHAX2BqmOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HFF9B8PKG4sjnwYn/qRsqkY5pL/Avw/xcwxmQNH3bGXcYw0XgvT/7vdbeMgPt0L+y
         ZtidYy6WjfWnnASa18lptSACPl9vGw452nq1nd4+wt6EOS/gfIEduAXmd2gZcbc0x8
         VwqHMXTOE1Tb7RAgR5ghqNuqYbgTli5nEXvmsUw9uXhlIIBcOBdEqRweGeJ9/ETyZD
         7FT1xJeLiEwsB8KcV0Et3Hy5hN1SAcZE6UJyR1qEghkydOQJoPuapbTnNxM4Wki8YZ
         rTdejngZAzw7IwT+03z6g0QZWTGISoeTnCYeuDzhEr+V/eiX5hSmycbKwmu5oYt+l4
         QgZmEJo51EK/g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1280590722dso8307874fac.1;
        Wed, 21 Sep 2022 02:53:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf330Wc6qUXeqb+xu9FB8NUVHBw2lypqmiq/Wqji2csGVDO1LMp/
        vlZh/lhd2PLZKC3sWqSGx3TJGJ6D1Qkf6Eb7p8w=
X-Google-Smtp-Source: AMsMyM491vQRywb4wDvkWp07dXKdsU6sntPmf24mps+H/A/7DIMj4uinS1kC9vZIpoBWnuepOdlaOPlfaWKaVAl63Ik=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr4555356oao.112.1663754032361; Wed, 21
 Sep 2022 02:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-9-guoren@kernel.org>
 <afa17bdd-2d11-4015-6e2a-7a39db931d09@huawei.com>
In-Reply-To: <afa17bdd-2d11-4015-6e2a-7a39db931d09@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 17:53:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRMt4zDQcvBOxge-4+6o1mqhWds_AiFKamdCzKJZfoKPw@mail.gmail.com>
Message-ID: <CAJF2gTRMt4zDQcvBOxge-4+6o1mqhWds_AiFKamdCzKJZfoKPw@mail.gmail.com>
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

On Wed, Sep 21, 2022 at 4:34 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> Hi,
>
> On 2022/9/18 23:52, guoren@kernel.org wrote:
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 5f49517cd3a2..426529b84db0 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -332,6 +332,33 @@ ENTRY(ret_from_kernel_thread)
> >       tail syscall_exit_to_user_mode
> >   ENDPROC(ret_from_kernel_thread)
> >
> > +#ifdef CONFIG_IRQ_STACKS
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
> > +#endif
>
> Seems my compiler (riscv64-linux-gnu-gcc 8.4.0, cross compiling from
> x86) cannot recognize the register `fp`.
The whole entry.S uses s0 instead of fp, so I approve of your advice. Thx.

>
> After I changed it to `s0` this can pass compiling.
>
>
> Seems there is nowhere else using `fp`, can this just using `s0` instead?
>
> Best,
>
> Chen
>


-- 
Best Regards
 Guo Ren
