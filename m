Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743B4DC277
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiCQJS0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 05:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiCQJSZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 05:18:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29215124C32;
        Thu, 17 Mar 2022 02:17:08 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MtfRp-1oONmW22Jz-00v6tb; Thu, 17 Mar 2022 10:17:07 +0100
Received: by mail-wr1-f42.google.com with SMTP id r10so6444443wrp.3;
        Thu, 17 Mar 2022 02:17:07 -0700 (PDT)
X-Gm-Message-State: AOAM533aOR4+cyrobtkfyRj1oDMGMwF63p3OjAuP3F0IbfwWZTM5ZtbY
        mhZKKjjY94Gsh9lcxdYiegB9PoN8ACf5kJmgXh4=
X-Google-Smtp-Source: ABdhPJzHxRGEWXDlBot3JUsd9DgwDJ6ivxcLghivZobZjz3wwreUXbJML8BPLrLgeRbd4dSRRrBLY4hc87aaQUXL1EU=
X-Received: by 2002:a05:6000:1e0d:b0:203:e950:7b74 with SMTP id
 bj13-20020a0560001e0d00b00203e9507b74mr1946333wrb.219.1647508627012; Thu, 17
 Mar 2022 02:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232600.20419-1-palmer@rivosinc.com>
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Mar 2022 10:16:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0J3ViDWserQew2wt95Hnu6AHT5gmSxtUz0x5W2fWdxBA@mail.gmail.com>
Message-ID: <CAK8P3a0J3ViDWserQew2wt95Hnu6AHT5gmSxtUz0x5W2fWdxBA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Generic Ticket Spinlocks
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:A8t+JNQ6hnfKWa5ZvcXXjImC9GHMIrJRw1UUen1iqsyraxUR3B2
 IoPgjisorvwAoB+Zyb1Vr6LscrQ0ft+lf6/vlyMhxuoK7BmeSDmEfycB7T36OFb1hGh9Qjh
 cDYXU1F9M9OvcpV6EIrlccH1mqZmjOQiC7DCeLZI7NV+dzj0Buh6H6DhTJ4aBxWvmkWVd5R
 cHSLUKq3tcy7AUApZ2BUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0maHK8ZCjz8=:RcAArPyC15KFEFlLUXqXie
 +YrGxC300capN6HgP2eEXhvAFuBurqss1Eff1jBdCv0spP460aIftn0ii1An5MWa9l7w0Mp7g
 mdFQIWlsHiWqAo6Bm4gifactIrEo7L9vkUHNCZJL4kPfpJ2aue+zPQ2/d2e+nnbJASbRNYctP
 20INB5uJaIZfSVai1jzWAZs8fpq6NrM1ZC+EY+Fgb8Gh3iMc15lT7UJ5gmblObQgE/g5TMP8t
 PqHQspg9xo6EizCocgwjAQ6KQ2yEe6BCVWIHdIe8HiTgfidi4a5bcuhrkQ2kQF+z0c301GGjp
 MYYBse3vxbsWCds2Rt0Pp3gN48ionkcU124WFMRkbvjx64S3CmKkcfQRDr0P69vWeapUzLZPh
 U/QSE93IHG8Z4ji92VouT8ReNq8GJjuGpwXNFqFBjmaW54JtwZzyJ4HIXxeqfsWXVGxBvQ3ij
 h34AGJalj9gLMDYiE0K2eV9L8gCjVMds9aD0LrLMeY3zYsO3jU0a16T3LeMh/MrFYbQPYOOEL
 GIIjxbY/cXk3JorOmN4lYslu7rPDMcylHOR7nj9HPHIHAEJpbt+s8ivcwQpl1887oV7OLx2J+
 fZpr+EkAjQGdctMA2QHCaxI+ywzVguFc9S9oTqc8otEJclm5kbn5V69QEQvQj7cinoesPwhkV
 z3FvNv2nQnijBabHLw7YZ9BI1XfAArtDu2crLLA+g1fsWv/+CRSqvl38JViBBcGO+wSfEjG+4
 DsPJxC3kD9Vbad+TgjE0xaJiAeHLXnVJuPPzDu7XppI6+EVkOzvievc9AFyanPYPesKmJK6B/
 KXfve/WAFlTd1v/rWUVdhAq4AaM2OIWslIssKe6YgBXEOCjSJM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 17, 2022 at 12:25 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Peter sent an RFC out about a year ago
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
> but after a spirited discussion it looks like we lost track of things.
> IIRC there was broad consensus on this being the way to go, but there
> was a lot of discussion so I wasn't sure.  Given that it's been a year,
> I figured it'd be best to just send this out again formatted a bit more
> explicitly as a patch.
>
> This has had almost no testing (just a build test on RISC-V defconfig),
> but I wanted to send it out largely as-is because I didn't have a SOB
> from Peter on the code.  I had sent around something sort of similar in
> spirit, but this looks completely re-written.  Just to play it safe I
> wanted to send out almost exactly as it was posted.  I'd probably rename
> this tspinlock and tspinlock_types, as the mis-match kind of makes my
> eyes go funny, but I don't really care that much.  I'll also go through
> the other ports and see if there's any more candidates, I seem to
> remember there having been more than just OpenRISC but it's been a
> while.
>
> I'm in no big rush for this and given the complex HW dependencies I
> think it's best to target it for 5.19, that'd give us a full merge
> window for folks to test/benchmark it on their systems to make sure it's
> OK.  RISC-V has a forward progress guarantee so we should be safe, but
> these can always trip things up.

This all looks good to me, feel free to merge the asm-generic
bits through the riscv tree.

Regarding the naming, my preference would be to just use
this version in place of the (currently useless) asm-generic/spinlock.h,
and just naming it arch_spin_lock() etc.

This way, converting an architecture to the generic ticket lock can
be done simply by removing its custom asm/spinlock.h. Or it
could stay with the current name, but then have a new
asm-generic/spinlock.h that just includes both asm/ticket_lock.h
and asm/qrwlock.h.

      Arnd
