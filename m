Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2851B689
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiEEDZT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbiEEDZS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:25:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DC51A07E;
        Wed,  4 May 2022 20:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F06B4B82794;
        Thu,  5 May 2022 03:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A08C385A4;
        Thu,  5 May 2022 03:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651720897;
        bh=WI76IzBl5E+DVGCHLZoWTBt/u6JBPeoGf/8qPZFcVao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dD8GAhv1JedQ8m+DwFkBY7KL0AYcMUyju8/h+Wd1qK/l8GGy/ThsplwdZRal1beO0
         FWmDAzketLrU8KsCO7XLtzf4ghKg5Kl5rsFUVgmWp0aSWrk0IXL6n7iolctNNr86Ym
         wlYxAx02eGzHs4u6aTi0pTLuG5UhDWuaPgdu5TWBE+vspZ3iW4niDtqADKKTENHeYx
         PSWLz/H/FyqKeOB/rxN5Y9L4CqXxsUSU7iTc1QBNsjUrpPubrh++9Oohta/OxF2g/s
         dfRCn0NOviMP3K90DhKmWPIEURG0G/JD5K2bGRTf5T+5Ynf4cgcVOZRStTvPxWhvnx
         TfVnA4bXUlCLg==
Received: by mail-ua1-f41.google.com with SMTP id p1so1218292uak.1;
        Wed, 04 May 2022 20:21:37 -0700 (PDT)
X-Gm-Message-State: AOAM531gOcgttq9RtQC48Vo7CygRsFtDNGnQq2qVvVTBMK8Zc1sID6gY
        lyEKOW3fkmUm03tvVmtyOtrpzQ1NiMAIJV8emmg=
X-Google-Smtp-Source: ABdhPJz7HX2dmfOkhWZMgS9lfnbrZYrBU9XtWlH/KZSbKdZYqPn9l6+QzwX4PKswK0JznE1x6+YJtNZui3FYrsicNLI=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr7073593uao.114.1651720896690; Wed, 04
 May 2022 20:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-6-palmer@rivosinc.com>
 <3428595.iIbC2pHGDl@diego>
In-Reply-To: <3428595.iIbC2pHGDl@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 5 May 2022 11:21:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSAbjTOjG+BhR-NW4i=Zqtb4eJ=5dTfxU1bU2Oc8V=2Wg@mail.gmail.com>
Message-ID: <CAJF2gTSAbjTOjG+BhR-NW4i=Zqtb4eJ=5dTfxU1bU2Oc8V=2Wg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] RISC-V: Move to generic spinlocks
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, May 4, 2022 at 8:02 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Samstag, 30. April 2022, 17:36:24 CEST schrieb Palmer Dabbelt:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > Our existing spinlocks aren't fair and replacing them has been on the
> > TODO list for a long time.  This moves to the recently-introduced ticke=
t
> > spinlocks, which are simple enough that they are likely to be correct
> > and fast on the vast majority of extant implementations.
> >
> > This introduces a horrible hack that allows us to split out the spinloc=
k
> > conversion from the rwlock conversion.  We have to do the spinlocks
> > first because qrwlock needs fair spinlocks, but we don't want to pollut=
e
> > the asm-generic code to support the generic spinlocks without qrwlocks.
> > Thus we pollute the RISC-V code, but just until the next commit as it's
> > all going away.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> on riscv64+riscv32 qemu, beaglev and d1-nezha
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
