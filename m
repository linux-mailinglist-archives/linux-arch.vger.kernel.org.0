Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758F1648F99
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 17:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLJQFw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 11:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLJQFv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 11:05:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A79626D;
        Sat, 10 Dec 2022 08:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F72C60C4F;
        Sat, 10 Dec 2022 16:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E582C433EF;
        Sat, 10 Dec 2022 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670688350;
        bh=RTJa209H796yp48LMbJyK45Y+jsR3vTqUZTkkFiVhKY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LO020q6nj+vKqmCbERgmxVz5Bxpb/uwwTIJDccRXXdpwh2DXAPGdpG78c8DkKInt8
         6a7QTdj3gNDP+5XZ5oPXG6sxxez/+oDZUA1DX9I2pdtbiQr4UqyUPVZZgYz57BCscP
         /KlXfaOZw90Fb0ht4FWkISACxBbJQm8xpc9GpQ7uG4rLSNug4Ao+9oyIA+RvmLr4Ob
         B+8idd2c0TcOTqXSWfr2sMj4BQ/CwNd6xt8FTs/q3gR8uAIMdfvdL0Pp4TXYwU8oGy
         WfWZ9Jo2Hh0YfjDtoMTTf5CrSoPxnxLMMVfvkf/UtYvkrN3VHS1OlaS9Jp4OPEO/kF
         V/Qi2bph9VB+w==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V10 04/10] riscv: entry: Convert to generic entry
In-Reply-To: <CAJF2gTTE_ZtKR6YTDEpF5uXHxUkuZ1PsZoL2Nf3NXpJWca9W7Q@mail.gmail.com>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-5-guoren@kernel.org>
 <87tu26w6gn.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTTE_ZtKR6YTDEpF5uXHxUkuZ1PsZoL2Nf3NXpJWca9W7Q@mail.gmail.com>
Date:   Sat, 10 Dec 2022 17:05:47 +0100
Message-ID: <871qp7tfac.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

>> >  - Little modification on ret_from_fork & ret_from_kernel_thread
>>
>> What changes?
>  ENTRY(ret_from_fork)
> +       call schedule_tail
> +       move a0, sp /* pt_regs */
>         la ra, ret_from_exception
> -       tail schedule_tail
> +       tail syscall_exit_to_user_mode
>  ENDPROC(ret_from_fork)
>
>  ENTRY(ret_from_kernel_thread)
>         call schedule_tail
>         /* Call fn(arg) */
> -       la ra, ret_from_exception
>         move a0, s1
> -       jr s0
> +       jalr s0
> +       move a0, sp /* pt_regs */
> +       la ra, ret_from_exception
> +       tail syscall_exit_to_user_mode
>  ENDPROC(ret_from_kernel_thread)

Thanks for clearing that up! It's more useful to have a descriptive
text, than just "these functions were changed". (Why instead of what)


Cheers,
Bj=C3=B6rn
