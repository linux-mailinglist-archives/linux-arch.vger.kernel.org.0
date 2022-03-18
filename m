Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249924DD530
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 08:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiCRH0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiCRH0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 03:26:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6AA2B2B4D;
        Fri, 18 Mar 2022 00:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20BD4B820FD;
        Fri, 18 Mar 2022 07:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1627C340E8;
        Fri, 18 Mar 2022 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647588280;
        bh=BfoKZy6B91Hiu61I3JtTMYU0kjXTJYatxUR/A7w6QKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jv4I9aWN18i+RpqiME4Tu16flA6GoS6NLvmm/rNpSUqgBduuIeqZ2+pWXdTdYDwuI
         MMFgDm88yex0Z8yQM2j7KzSgDND1ghEGYNcrMVnJlJn09bXbYqMBTxOgCsgraYwoUO
         FDJI/2gyqslJ4kbaPmHeBXwwMyUnXWnM2+/jZa9TV6ClUSPE+gwvvvcrVkmNU+JO3Z
         JMJbkYS3nWEK6D1Ekc/6TnAa/B8yGusd/JCQLi7xmixU0Mmy7N6PMHmNUrloD+jfmf
         IbkiUGYs02aiK9trOw5xilOKxsf3seeCPa9WDFB6my5qrI2dY3X4bjuEinemMCR1sz
         hOHWkId8ryfxg==
Received: by mail-ua1-f48.google.com with SMTP id z10so2947430uaa.3;
        Fri, 18 Mar 2022 00:24:40 -0700 (PDT)
X-Gm-Message-State: AOAM530x0G6z+OJ1fni5PYaDFOEbVTQSx/U9MK567XOY69amjT9mUKIP
        fdsBF+1bxzWxGEEXNWIwx0S2RqFSPOhqQk1WQWY=
X-Google-Smtp-Source: ABdhPJxZF9Z+ZVoAdhpq0HZjK1nqC+y82LR7GvGRglz1nfW3jIhfJECm+nlETFHFF9JTp4BwdsUYrSjxCtoHTQhykoQ=
X-Received: by 2002:ab0:26d9:0:b0:34c:609d:c23 with SMTP id
 b25-20020ab026d9000000b0034c609d0c23mr2889947uap.84.1647588279723; Fri, 18
 Mar 2022 00:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232600.20419-1-palmer@rivosinc.com> <11364105.8ZH9dyz9j6@diego>
In-Reply-To: <11364105.8ZH9dyz9j6@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 18 Mar 2022 15:24:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS3C_GHvLnrep_V3pz4bUOBMO-Tc5v5BpEt7V1EQxF0jw@mail.gmail.com>
Message-ID: <CAJF2gTS3C_GHvLnrep_V3pz4bUOBMO-Tc5v5BpEt7V1EQxF0jw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Generic Ticket Spinlocks
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, peterz@infradead.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tested-by: Guo Ren <guoren@kernel.org>

On Thu, Mar 17, 2022 at 8:58 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 17. M=C3=A4rz 2022, 00:25:55 CET schrieb Palmer Dabbelt:
> > Peter sent an RFC out about a year ago
> > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-=
ass.net/>,
> > but after a spirited discussion it looks like we lost track of things.
> > IIRC there was broad consensus on this being the way to go, but there
> > was a lot of discussion so I wasn't sure.  Given that it's been a year,
> > I figured it'd be best to just send this out again formatted a bit more
> > explicitly as a patch.
> >
> > This has had almost no testing (just a build test on RISC-V defconfig),
> > but I wanted to send it out largely as-is because I didn't have a SOB
> > from Peter on the code.  I had sent around something sort of similar in
> > spirit, but this looks completely re-written.  Just to play it safe I
> > wanted to send out almost exactly as it was posted.  I'd probably renam=
e
> > this tspinlock and tspinlock_types, as the mis-match kind of makes my
> > eyes go funny, but I don't really care that much.  I'll also go through
> > the other ports and see if there's any more candidates, I seem to
> > remember there having been more than just OpenRISC but it's been a
> > while.
> >
> > I'm in no big rush for this and given the complex HW dependencies I
> > think it's best to target it for 5.19, that'd give us a full merge
> > window for folks to test/benchmark it on their systems to make sure it'=
s
> > OK.  RISC-V has a forward progress guarantee so we should be safe, but
> > these can always trip things up.
>
> I've tested this on both the Qemu-Virt machine as well as the
> Allwinner Nezha board (with a D1 SoC).
>
> Both of those are of course not necessarily the best platforms
> for benchmarks I guess, as from what I gathered before I'd need
> need multiple cores to actually get interesting measurements when
> comparing different implementations. But at least everything that
> worked before still works with this series ;-)
>
>
> So, Series
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
>
> Heiko
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
