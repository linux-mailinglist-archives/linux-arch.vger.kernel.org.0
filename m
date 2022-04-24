Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358D50D07E
	for <lists+linux-arch@lfdr.de>; Sun, 24 Apr 2022 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiDXIhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiDXIhI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 04:37:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD7289B0;
        Sun, 24 Apr 2022 01:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AB6EB80E02;
        Sun, 24 Apr 2022 08:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9C5C385AD;
        Sun, 24 Apr 2022 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650789245;
        bh=VBSF6OfCXyq/qFgIFmHw1LXm8G8dn5Qpf0kuDkNzkoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VyrGb7RmjZ/m3PrgRGTO4hkq23FmuPb4mOhueAxqIIP8Wg8Z2sP1Uv9CiJY4xbpH/
         6dYTbbNkWsvEcSZ/ykCzh/qglPIyGQs8moONruVra4MA/ayS2U6DX8ty+FsLqiEiQG
         xg9XsAR+hzW94aZYPptxWnu7aP9/6WDWCxhS0iGv2aCxWWFZThvbWJYDhlDLVyDRCw
         T+ivvFRsd/FzcKqIrKy71VF+mw55d5rEo0p4xUf/njFTLH3loeLSMwYr9mNWRWUb4t
         OclbAYqcdo3g3mAtn6wzI00pF/UgBB5dMGqEfrCul8PNcajRCd6X+lLPzqGKZ8MBAz
         sWfZNA6sIrzPw==
Received: by mail-vs1-f52.google.com with SMTP id w124so2919595vsb.8;
        Sun, 24 Apr 2022 01:34:05 -0700 (PDT)
X-Gm-Message-State: AOAM533y/Z968soLITJ0gmPW2+gD7ekDnXrGDSHIK5GO+gjqR+z7Fp+/
        RnJVMjs6ikSnocCq9iHDnGKgedMw1mJH1t7YMFk=
X-Google-Smtp-Source: ABdhPJwVCdLHAdmPAHqMT9jcEXMpjHlkGiSxCuK7cYlVO2V1eSnQq6vhZMsZjwSaOylGwPAKFZtH+DwvJizy3g0PNn0=
X-Received: by 2002:a67:10c7:0:b0:32c:c621:7d27 with SMTP id
 190-20020a6710c7000000b0032cc6217d27mr228483vsq.59.1650789244202; Sun, 24 Apr
 2022 01:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220412034957.1481088-1-guoren@kernel.org> <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com> <20220418234137.GA444607@anparri>
In-Reply-To: <20220418234137.GA444607@anparri>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 24 Apr 2022 16:33:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSmVa9iKzojvrrQghkzBZao4eQwKBTKQfSPFqSR667bTg@mail.gmail.com>
Message-ID: <CAJF2gTSmVa9iKzojvrrQghkzBZao4eQwKBTKQfSPFqSR667bTg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 19, 2022 at 7:41 AM Andrea Parri <parri.andrea@gmail.com> wrote=
:
>
> > > Seems to me that you are basically reverting 5ce6c1f3535f
> > > ("riscv/atomic: Strengthen implementations with fences"). That commit
> > > fixed an memory ordering issue, could you explain why the issue no
> > > longer needs a fix?
> >
> > I'm not reverting the prior patch, just optimizing it.
> >
> > In RISC-V =E2=80=9CA=E2=80=9D Standard Extension for Atomic Instruction=
s spec, it said:
>
> With reference to the RISC-V herd specification at:
>
>   https://github.com/riscv/riscv-isa-manual.git
>
> the issue, better, lr-sc-aqrl-pair-vs-full-barrier seems to _no longer_
> need a fix since commit:
                        "0:     lr.w %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w.rl %1, %z4, %2\n"                  \
                        "       bnez %1, 0b\n"                          \
                        "       fence rw, rw\n"                         \
Above is the current implementation, and the logic is in conflict. If
we want full-barrier, we should implement like below:
                        fence rw, w
                        "0:     lr.w %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w %1, %z4, %2\n"                  \
                        "       bnez %1, 0b\n"                          \
                        "       fence rw, rw\n"                         \
Above we could let lr.w & sc.w executed fastest. If we think .aq/.rl
won't affect forward guarantee, we should implement like below:
                        "0:     lr.w %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w.aqrl %1, %z4, %2\n"                  \
                        "       bnez %1, 0b\n"                          \

Using .aqrl is better than sc.w.rl + fence rw, rw, because lr/sc.rl
pair forward guarantee is the same with lr/sw.aqrl and only sc.rl part
would affect the speed of lr/sc speed. Second, it could reduce one
fence rw, rw overhead. So for riscv, we needn't put a full-barrier
after sc like arm64 and use .aqrl instead.

>
>   03a5e722fc0f ("Updates to the memory consistency model spec")
>
> (here a template, to double check:
>
>   https://github.com/litmus-tests/litmus-tests-riscv/blob/master/tests/no=
n-mixed-size/HAND/LR-SC-NOT-FENCE.litmus )
>
> I defer to Daniel/others for a "bi-section" of the prose specification.
> ;-)
>
>   Andrea



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
