Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE964DD653
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 09:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiCRIlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCRIlv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 04:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37796143C64;
        Fri, 18 Mar 2022 01:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFAD0B82198;
        Fri, 18 Mar 2022 08:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC77C340F9;
        Fri, 18 Mar 2022 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647592830;
        bh=iUr5tRvZTo9rXrhUfHmBDsVjXAUzfQvdrJ4GOirMD1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NKX3SMHtB+o8znU/U2KTE369qFnc8hXvVsOukLKqhwmETmkyjpUMSdrLeFv1xNn5T
         MJyJTjAckKX4mKT6/mtDwr9pYbdnc45y8ZNx3Dj3mleoMjB1yGVBx0EYNhpPnsUf2v
         3zXX1EklCxZTKWVyMKQh+verzBUIX40X5errq26vokUMTonsuiXmsRMIovokF6ph9U
         iR+iVF6nab3JbFln6eZYgbeZVdLXTWM1VRCBH5Ek+cz3ZmE34EcjEwOcsYeAp524cO
         QFOPXbBldio8bBwJyc+oP0i0sCY8H7FE2TmOSfw1OXmyjL/Qwg51p6EjEh1RW5O3i5
         FvzQRJ1LQv1Uw==
Received: by mail-vs1-f47.google.com with SMTP id k184so3345069vsc.2;
        Fri, 18 Mar 2022 01:40:30 -0700 (PDT)
X-Gm-Message-State: AOAM532kWteunkyYkQwcgg+5okmarNl8zJIkuLVUmwsMJQNwZCmWeBZh
        xIgbL+Lvn0ZWMwsMymG1dmABhTLZBO5Or2Uw5HA=
X-Google-Smtp-Source: ABdhPJyKftDFP/Db0LP/WpQBiK7L2dYAjVWhbklLPdx+VCrE7mm4BHhLc/G2CUjhluQs1dFX90+mXlVVyzM9CXgkfOk=
X-Received: by 2002:a05:6102:311b:b0:324:e48a:75bc with SMTP id
 e27-20020a056102311b00b00324e48a75bcmr265902vsh.2.1647592829461; Fri, 18 Mar
 2022 01:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232600.20419-1-palmer@rivosinc.com>
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 18 Mar 2022 16:40:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQdhnxJ3gaJDCnd7-boz83GMxaW7tTNaA9hSHs92L_Zig@mail.gmail.com>
Message-ID: <CAJF2gTQdhnxJ3gaJDCnd7-boz83GMxaW7tTNaA9hSHs92L_Zig@mail.gmail.com>
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
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        openrisc@lists.librecores.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

Tested-by: Guo Ren <guoren@kernel.org>

Could help involve the below patch in your series?

https://lore.kernel.org/linux-arch/20220318083421.2062259-1-guoren@kernel.org/T/#u

On Thu, Mar 17, 2022 at 1:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
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



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
