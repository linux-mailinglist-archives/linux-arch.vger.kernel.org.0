Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EA639F89
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 03:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK1CnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 21:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK1CnF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 21:43:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCEA5581;
        Sun, 27 Nov 2022 18:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D2DB80C80;
        Mon, 28 Nov 2022 02:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A4C43154;
        Mon, 28 Nov 2022 02:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669603378;
        bh=UPQSDgWGxcv1ItSA2KA+M47orcLuzpGzEWEvHhqijXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LBbGT8KkwrtI9diEjRfrB7cSuGGG6noyHoQpaxG575hbrokbsiY+mq0mJkwgrZtVc
         8wOQp3mivKlnC2vqRfXlpMwp7HWuKkH8vDxW3bmde1vPL6RD4bF7PCwrmaz1Wldj/h
         Vv1/aogUK13Bl4oSJgMpMzpPqG57rh9+KQ5SQRTPyNgxq/vuX3WvwQmtfsR81uGoOc
         aRt2qiKZEJGAo10AeR9RCfxabk4ShMm+ynXRGU9yNVUQVEpaklPk6JLXb/+pN4Ifsb
         MAIyHqIDKLlsCp0G5Ygy20aUwAGj1nfNzOpjCtigT4LO6ZiKhWRrFqacxIHe7unleY
         aMMOP2MYaabKQ==
Received: by mail-ed1-f43.google.com with SMTP id d20so2899457edn.0;
        Sun, 27 Nov 2022 18:42:58 -0800 (PST)
X-Gm-Message-State: ANoB5plOwxZftaTLiGA92KRk2BF3NP4wf3xHFI6849nVdlkwjEseN1mw
        F/cVFzF6Q6XVdhjBC9AOSZDl8ciCRFk/531ONmM=
X-Google-Smtp-Source: AA0mqf4XRkIJT5YmIPdGI8ff1p/NWd/dQCzy+8Tqpr33A+GMOWvKu4d12lLM1m7CgiIoADHsv3MxUz4Rw9u8vMLRXPk=
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id
 r26-20020a056402019a00b0046074135d46mr45697321edv.47.1669603376771; Sun, 27
 Nov 2022 18:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20221103075047.1634923-1-guoren@kernel.org> <20221103075047.1634923-7-guoren@kernel.org>
 <a28d32c965f363ce099bd0a65e1c82b75a98128a.camel@decadent.org.uk>
In-Reply-To: <a28d32c965f363ce099bd0a65e1c82b75a98128a.camel@decadent.org.uk>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Nov 2022 10:42:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQwkPgafMxJ8YxH-kCsyT82bTr_a2hBJ1Pido7SvN+o2A@mail.gmail.com>
Message-ID: <CAJF2gTQwkPgafMxJ8YxH-kCsyT82bTr_a2hBJ1Pido7SvN+o2A@mail.gmail.com>
Subject: Re: [PATCH -next V8 06/14] riscv: convert to generic entry
To:     Ben Hutchings <ben@decadent.org.uk>
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
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 28, 2022 at 12:26 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Thu, 2022-11-03 at 03:50 -0400, guoren@kernel.org wrote:
> [...]
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> [...]
> > +asmlinkage void do_sys_ecall_u(struct pt_regs *regs)
> > +{
> > +     syscall_t syscall;
> > +     ulong nr = regs->a7;
> > +
> > +     regs->epc += 4;
> > +     regs->orig_a0 = regs->a0;
> > +     regs->a0 = -ENOSYS;
> > +
> > +     nr = syscall_enter_from_user_mode(regs, nr);
> > +#ifdef CONFIG_COMPAT
> > +     if ((regs->status & SR_UXL) == SR_UXL_32)
> > +             syscall = compat_sys_call_table[nr];
> > +     else
> > +#endif
> > +             syscall = sys_call_table[nr];
> > +
> > +     if (nr < NR_syscalls)
>
> This bounds check needs to be done before indexing the system call
> table, not after.
Yes, you are right. That would cause a wrong pointer bug. Here is the
new version:

asmlinkage void do_sys_ecall_u(struct pt_regs *regs)
{
        syscall_t syscall;
        ulong nr = regs->a7;

        regs->epc += 4;
        regs->orig_a0 = regs->a0;
        regs->a0 = -ENOSYS;

        nr = syscall_enter_from_user_mode(regs, nr);

        if (nr < NR_syscalls) {
#ifdef CONFIG_COMPAT
                if ((regs->status & SR_UXL) == SR_UXL_32)
                        syscall = compat_sys_call_table[nr];
                else
#endif
                        syscall = sys_call_table[nr];

                regs->a0 = syscall(regs->orig_a0, regs->a1, regs->a2,
                                   regs->a3, regs->a4, regs->a5, regs->a6);
        }
        syscall_exit_to_user_mode(regs);
}

>
> Ben.
>
> > +             regs->a0 = syscall(regs->orig_a0, regs->a1, regs->a2,
> > +                                regs->a3, regs->a4, regs->a5, regs->a6);
> > +     syscall_exit_to_user_mode(regs);
> > +}
> [...]
>
> --
> Ben Hutchings
> This sentence contradicts itself - no actually it doesn't.



-- 
Best Regards
 Guo Ren
