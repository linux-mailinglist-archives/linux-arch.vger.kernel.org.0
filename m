Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2092B5B5302
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 06:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiILEOs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Sep 2022 00:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILEOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 00:14:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B664CF;
        Sun, 11 Sep 2022 21:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84431B80B21;
        Mon, 12 Sep 2022 04:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC66C43147;
        Mon, 12 Sep 2022 04:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662956084;
        bh=sZp87uk/tgN5rqc5QTzYD9Bq4Rq7LlVl4d9+OQDuWd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=USNKbjUZxSnBMZ/D0y5kLqoJzB43i+DUNol2FfakpsgKH9aC/msxLEHJSyNz4nMxQ
         1/jI+YDHOgmVh7mlrDuZH+9P3snlhQsssithFTmoBn3q2ufnS5o7qMuF21FOFqvu3D
         rz/C7hq6UzKEK44lI3PRV37jX63Yu7TRA3P/u0jSXi/ARF17vYJ/T6lvHg9shKHbH8
         eWabOWBeiOY70Zjl9OXEIOm2hdjs4WXqgTFPA5P3TutIpo2IVigeZlugfbDZN7apWc
         Idg23dp34HsG4z8B8OW5pwQro4ou66s4ijWHXkxlCTjbwsKp+ci5Iy/wybDdC+jrFo
         IDyO8fyQFzLOQ==
Received: by mail-oo1-f46.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so457147ool.3;
        Sun, 11 Sep 2022 21:14:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo30ibaqfGHa/DYwphW6nxaTRGS4BcfmQQh6P3nmWKUNTFHICM0g
        vTdBQ/Bx3RTdgATh5XKV++I531ahIVFEDkl4cQI=
X-Google-Smtp-Source: AA6agR7uDujU33x2bd2IE9CjZsZh6lUsGTAK6HB7wAtIzyneeQRmIZl02YvTJ1zW3uuOI+4PPRCPIWutLY0xxHp6Bb4=
X-Received: by 2002:a4a:d8cc:0:b0:475:5c7e:eb3e with SMTP id
 c12-20020a4ad8cc000000b004755c7eeb3emr2387976oov.48.1662956082996; Sun, 11
 Sep 2022 21:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
 <7409c92a-68df-4406-bd86-835d9a959ef5@www.fastmail.com>
In-Reply-To: <7409c92a-68df-4406-bd86-835d9a959ef5@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 12 Sep 2022 12:14:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRxt_b2TswE6YJgmFZeRyVzV7fQdMX+7Ptrfa_k=auSjg@mail.gmail.com>
Message-ID: <CAJF2gTRxt_b2TswE6YJgmFZeRyVzV7fQdMX+7Ptrfa_k=auSjg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 12, 2022 at 2:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>
>
> On Sun, Sep 11, 2022, at 1:35 AM, Guo Ren wrote:
> > On Sun, Sep 11, 2022 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Sat, Sep 10, 2022, at 2:52 PM, Guo Ren wrote:
> >> > On Thu, Sep 8, 2022 at 3:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> On Thu, Sep 8, 2022, at 4:25 AM, guoren@kernel.org wrote:
> >> >> > From: Guo Ren <guoren@linux.alibaba.com>
> >> >> - When VMAP_STACK is set, make it possible to select non-power-of-two
> >> >>   stack sizes. Most importantly, 12KB should be a really interesting
> >> >>   choice as 8KB is probably still not enough for many 64-bit workloads,
> >> >>   but 16KB is often more than what you need. You probably don't
> >> >>   want to allow 64BIT/8KB without VMAP_STACK anyway since that just
> >> >>   makes it really hard to debug, so hiding the option when VMAP_STACK
> >> >>   is disabled may also be a good idea.
> >> > I don't want this config to depend on VMAP_STACK. Some D1 chips would
> >> > run with an 8K stack size and !VMAP_STACK.
> >>
> >> That sounds like a really bad idea, why would you want to risk
> >> using such a small stack without CONFIG_VMAP_STACK?
> >>
> >> Are you worried about increased memory usage or something else?
> > The requirement is from [1], and I think disabling CONFIG_VMAP_STACK
> > would be the last step after serious testing.
>
> I still don't see why you need to turn off VMAP_STACK at all
> if it works. The only downside I can see with using VMAP_STACK
> on a 64-bit system is that it may expose bugs with device
> drivers that do DMA to stack data. Once you have tested the
> system successfully, you can also assume that you have no such
> drivers.
1st, VMAP_STACK could be enabled&disabled in arch/Kconfig. If we don't
force users to enable VMAP_STACK, why couldn't user adjust
THREAD_SIZE?
2nd, VMAP_STACK is not free, we still need 1KB shadow_stack.
The EXPERT is enough for your concern.


>
>      Arnd



--
Best Regards
 Guo Ren
