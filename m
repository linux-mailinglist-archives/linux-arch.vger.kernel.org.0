Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24175BC46C
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiISIiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiISIiS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 04:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD02A1E3FB;
        Mon, 19 Sep 2022 01:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A3761519;
        Mon, 19 Sep 2022 08:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C5FC433D6;
        Mon, 19 Sep 2022 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663576695;
        bh=heo7YO9Z/Mn7auLgacdl566kMb7P9+5y2s1cnvWWhNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uTRUGIbB/a+yr6sQn5wS+gyN3Xv7qSHcczusIx9S/VcHwA5TeOBrrF+FMvoksUBR3
         Meu+wDm+BNyFMTCU0sJjW+FF6K/137aKqFQzjILAgO1SKBofcOQK7rigqkcBYbSmzS
         AjA3QmvYiO+ivlH1Fzjcqq8IgyXMaX+zMwxuFKsUrmFpiWGit83q41mSrjZzZc73g0
         d2jtyoNBgZXoHOH7M3qSD263CD4BfK4y1I/oRek25g1Ern3INBBBr+qyZFnrm/9awY
         Ix3dRl55JGnY6Zd7RpsPK7Lhk17DY1GNoc+G+PovFICRqooNDJVq+sDjzQblFcAgYs
         cDQnrzv3JgQog==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1274ec87ad5so60954978fac.0;
        Mon, 19 Sep 2022 01:38:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf0OKfinoTzx6oQMwDLwUJCJWEeC6k9Q66nb/jajpI0iB7KpALE5
        qxpoS64nLXMcdQF5IOESVs+1YG2Raux8A2FPzMw=
X-Google-Smtp-Source: AMsMyM7ABtP0qSS4TeNjY3/uJch3CvccZb+T2Wqml4QNq4ZCaawYjQENTRVHMje/Mc+dM1SGFVjGsCi0SpAccjiDCdc=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr4442166oap.19.1663576694922; Mon, 19 Sep
 2022 01:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
 <7409c92a-68df-4406-bd86-835d9a959ef5@www.fastmail.com> <CAJF2gTRxt_b2TswE6YJgmFZeRyVzV7fQdMX+7Ptrfa_k=auSjg@mail.gmail.com>
 <2b06f28d-a13d-4c86-af04-39e383aaf07b@www.fastmail.com>
In-Reply-To: <2b06f28d-a13d-4c86-af04-39e383aaf07b@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 19 Sep 2022 16:38:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRzC9ES1EK3X4tHchTZMfbGJk2QLbD8VG=5x5bWD7Er0w@mail.gmail.com>
Message-ID: <CAJF2gTRzC9ES1EK3X4tHchTZMfbGJk2QLbD8VG=5x5bWD7Er0w@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 12, 2022 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Sep 12, 2022, at 6:14 AM, Guo Ren wrote:
> > On Mon, Sep 12, 2022 at 2:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Sun, Sep 11, 2022, at 1:35 AM, Guo Ren wrote:
> >> > On Sun, Sep 11, 2022 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >> >>
> >> >> That sounds like a really bad idea, why would you want to risk
> >> >> using such a small stack without CONFIG_VMAP_STACK?
> >> >>
> >> >> Are you worried about increased memory usage or something else?
> >> > The requirement is from [1], and I think disabling CONFIG_VMAP_STACK
> >> > would be the last step after serious testing.
> >>
> >> I still don't see why you need to turn off VMAP_STACK at all
> >> if it works. The only downside I can see with using VMAP_STACK
> >> on a 64-bit system is that it may expose bugs with device
> >> drivers that do DMA to stack data. Once you have tested the
> >> system successfully, you can also assume that you have no such
> >> drivers.
> > 1st, VMAP_STACK could be enabled&disabled in arch/Kconfig. If we don't
> > force users to enable VMAP_STACK, why couldn't user adjust
> > THREAD_SIZE?
>
> Turning off VMAP_STACK is harmless and may help debug issues
> with VMAP_STACK itself. It's also required on architectures
> that don't have KASAN_VMALLOC or something else that conflicts
> with it.
>
> Changing THREAD_SIZE is also fine, as long as VMAP_STACK catches
> the inevitable overflows. I would not object to having an
> option that allows setting the stack size larger than the
> default without VMAP_STACK, as long as setting it lower requires
> using VMAP_STACK. That would however add a lot more complexity
> and probably doesn't do what you want either.
Thx for the detailed clarification, I agree with the point. I've put
an EXPERT on config.

>
> > 2nd, VMAP_STACK is not free, we still need 1KB shadow_stack.
> > The EXPERT is enough for your concern.
>
> It's actually more than the 1KB: you need both 1KB of shadow
> stack and 4KB per CPU for the actual overflow_stack. If you
> are micro-optimizing at this level, then a possible option
> may be to change the handle_kernel_stack_overflow() function
> to not preserve the task stack and just panic() without
> showing the backtrace. That way you don't see which code
> caused the issue, but at least you avoid corrupting random
> data.
Thx for the detailed explanation, the handle_kernel_stack_overflow()
is a novel idea, which I will consider later.

>
>      Arnd



--
Best Regards
 Guo Ren
