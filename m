Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B65643C74
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 05:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFElX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 23:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiLFElW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 23:41:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC43BC0;
        Mon,  5 Dec 2022 20:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A9B56154D;
        Tue,  6 Dec 2022 04:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C00C43148;
        Tue,  6 Dec 2022 04:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670301680;
        bh=CDi3F0YVIiQYZgfK8bLLmzIPGqtLt6inzEmlZ6Doajc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=phdmyBu2AMK0GuM/x7DhbD6rF9+EtZ1698DONdfwzMNnBLj9CKA2M/bQSaYncOzSG
         o9MYZ2hu2fWIAuIMbQkansUR2ed8GOI4bjS4jAfSCXaURAeuBra9d6OmAvmj2gKA0b
         c2LjXI24O9vJhHBu8Fd+dsp4R9XuRBnzXtyLQNSiaU6XCIn8R3dijTmkAI/VCLAyS5
         JO43dj8jPuZ1vZe6NHxq2JY/oFSfCeDgr2w68aCrPuJPRN5BW0x2t1YogckA5xw+IA
         2z9QbypmivV9iXLYCCPWvMmg/3bjROUwOBkg9aeT70WdQ2b10BW/lPieVDFe7Jl6JZ
         CHA4vupfUkWiA==
Received: by mail-ed1-f49.google.com with SMTP id v8so18690534edi.3;
        Mon, 05 Dec 2022 20:41:20 -0800 (PST)
X-Gm-Message-State: ANoB5plEoSLG8/pVNGOq153DED0SgOf/cnozAgl7bAgvT0EI3A9wHQCO
        jLHyG2zeOZOaIQL878SL0QDMSqXa8GGKqGCaSCg=
X-Google-Smtp-Source: AA0mqf4ch/b78ULRR94neIazv0nnRnB3t7URjN2prrntaPmGs+FOXh9jatMztYw4hLNzF3ljnWjF7Mo1NzmnxKn7/zU=
X-Received: by 2002:a05:6402:289d:b0:46c:2460:cdf with SMTP id
 eg29-20020a056402289d00b0046c24600cdfmr15398312edb.103.1670301679047; Mon, 05
 Dec 2022 20:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20221103075047.1634923-1-guoren@kernel.org> <20221103075047.1634923-5-guoren@kernel.org>
 <87bkoi9otu.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87bkoi9otu.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Dec 2022 12:41:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRqnuYVHKoB_7GCK_JwvUK0gYUs9eOAzXL-CKWQ-AuO+Q@mail.gmail.com>
Message-ID: <CAJF2gTRqnuYVHKoB_7GCK_JwvUK0gYUs9eOAzXL-CKWQ-AuO+Q@mail.gmail.com>
Subject: Re: [PATCH -next V8 04/14] riscv: ptrace: Remove duplicate operation
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022 at 5:34 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The TIF_SYSCALL_TRACE is controlled by a common code, see
> > kernel/ptrace.c and include/linux/thread.h.
>
>                                     ^^^ thread_info.h
> >
> > clear_task_syscall_work(child, SYSCALL_TRACE);
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > ---
> >  arch/riscv/kernel/ptrace.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> > index 2ae8280ae475..44f4b1ca315d 100644
> > --- a/arch/riscv/kernel/ptrace.c
> > +++ b/arch/riscv/kernel/ptrace.c
> > @@ -212,7 +212,6 @@ unsigned long regs_get_kernel_stack_nth(struct pt_r=
egs *regs, unsigned int n)
> >
> >  void ptrace_disable(struct task_struct *child)
> >  {
> > -     clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> >  }
> >
> >  long arch_ptrace(struct task_struct *child, long request,
>
> This patch is also not neccesary for the series, but should be a
> separate cleanup.
Maybe I would deprecate this patch because the generic entry would
delete the whole ptrace_disable().



--=20
Best Regards
 Guo Ren
