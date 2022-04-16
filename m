Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8DE5037A0
	for <lists+linux-arch@lfdr.de>; Sat, 16 Apr 2022 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiDPQwd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Apr 2022 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiDPQwc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Apr 2022 12:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EE2DA92;
        Sat, 16 Apr 2022 09:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F6CB8068A;
        Sat, 16 Apr 2022 16:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A1C385AE;
        Sat, 16 Apr 2022 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650127796;
        bh=qmUgUDofYI1jD2rLu9hnpnW6IkiX3GQmx1xSkVNgS3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hyzfAeUwY+XIxJY5TXKlmUfb1LddqrE1CWOExDZ4k/u4Km7jCOzQGL+5eKyRUSHLL
         qdVuT8DUIiznLBzVkMSCdi9b1QkLnq4BcA4gelELChGLbl5ZBVDr4DVvvP58MdyZ2w
         pAod1nOAXuEdfDThbO+6LwNZS0mvBJOX4dTWfaC80vKoAhtZGyUXL9QKDpCWKXXGNq
         2SlPOHTs9VepSoe07bcpRyrti5Cua7hqYlzCwdxQJg4rGgNLHG/wcwOdyPB6DfcbrI
         ZTJW+qkkNRvqVSjDazlkn3yQoHFHWJ4KvWrcy+/iC9qdR9iiix4o3Lj+JoElAHOSZA
         EiKFldU2Leysw==
Received: by mail-vs1-f47.google.com with SMTP id i34so8373917vsv.6;
        Sat, 16 Apr 2022 09:49:56 -0700 (PDT)
X-Gm-Message-State: AOAM530542UotODzB76lRDPjHnwOPc4GP5eBxb7ftf9yWX7NZ7bu/6kg
        wu0Kw3NzR96sNW9zVGjPhaW6IrZzVKnRFYIStJc=
X-Google-Smtp-Source: ABdhPJwipWUHJGVYg3G9YqlCYWyULpwS8q2oCbq6rdTlaCM+02oXS/mNA7AoQvfY8ATUS0Y3Fps/fH6ZLKhSWSYgb9Y=
X-Received: by 2002:a67:ec04:0:b0:32a:4a53:172f with SMTP id
 d4-20020a67ec04000000b0032a4a53172fmr463677vso.59.1650127795835; Sat, 16 Apr
 2022 09:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220412034957.1481088-1-guoren@kernel.org> <YlbwOG46mCR8Q5tJ@tardis>
In-Reply-To: <YlbwOG46mCR8Q5tJ@tardis>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Apr 2022 00:49:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
Message-ID: <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
To:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Boqun,

On Wed, Apr 13, 2022 at 11:46 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> [Cc Andrea]
>
> On Tue, Apr 12, 2022 at 11:49:54AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These patch series contain one cleanup and some optimizations for
> > atomic operations.
> >
>
> Seems to me that you are basically reverting 5ce6c1f3535f
> ("riscv/atomic: Strengthen implementations with fences"). That commit
> fixed an memory ordering issue, could you explain why the issue no
> longer needs a fix?

I'm not reverting the prior patch, just optimizing it.

In RISC-V =E2=80=9CA=E2=80=9D Standard Extension for Atomic Instructions sp=
ec, it said:
If only the aq bit is set, the atomic memory operation is treated as
an acquire access, i.e., no following memory operations on this RISC-V
hart can be observed to take place before the acquire memory
operation.
-                       "       amoswap.w %0, %2, %1\n"                 \
-                       RISCV_ACQUIRE_BARRIER                           \
+                       "       amoswap.w.aq %0, %2, %1\n"              \
So RISCV_ACQUIRE_BARRIER is "fence r, rw" and "fence r" is over
constraints to protect amoswap.w. Here using amoswap.w.aq is more
proper.

If only the rl bit is set, the atomic memory operation is treated as a
release access, i.e., the release memory operation cannot be observed
to take place before any earlier memory operations on this RISC-V
hart.
-                       RISCV_RELEASE_BARRIER                           \
-                       "       amoswap.w %0, %2, %1\n"                 \
+                       "       amoswap.w.rl %0, %2, %1\n"              \
So RISCV_RELEASE_BARRIER is "fence rw, w" and "fence ,w" is over
constraints to protect amoswap.w. Here using amoswap.w.rl is more
proper.

If both the aq and rl bits are set, the atomic memory operation is
sequentially consistent and cannot be observed to happen before any
earlier memory operations or after any later memory operations in the
same RISC-V hart and to the same address domain.
                "0:     lr.w     %[p],  %[c]\n"
                "       sub      %[rc], %[p], %[o]\n"
                "       bltz     %[rc], 1f\n".
-               "       sc.w.rl  %[rc], %[rc], %[c]\n"
+               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
                "       bnez     %[rc], 0b\n"
-               "       fence    rw, rw\n"
                "1:\n"
So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more pro=
per.

>
> Regards,
> Boqun
>
> > Changes in V2:
> >  - Fixup LR/SC memory barrier semantic problems which pointed by
> >    Rutland
> >  - Combine patches into one patchset series
> >  - Separate AMO optimization & LRSC optimization for convenience
> >    patch review
> >
> > Guo Ren (3):
> >   riscv: atomic: Cleanup unnecessary definition
> >   riscv: atomic: Optimize acquire and release for AMO operations
> >   riscv: atomic: Optimize memory barrier semantics of LRSC-pairs
> >
> >  arch/riscv/include/asm/atomic.h  | 70 ++++++++++++++++++++++++++++++--
> >  arch/riscv/include/asm/cmpxchg.h | 42 +++++--------------
> >  2 files changed, 76 insertions(+), 36 deletions(-)
> >
> > --
> > 2.25.1
> >



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
