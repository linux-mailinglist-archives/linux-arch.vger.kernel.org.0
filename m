Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75051B694
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiEEDeG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbiEEDeD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68012634;
        Wed,  4 May 2022 20:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F4B61949;
        Thu,  5 May 2022 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1BAC385B5;
        Thu,  5 May 2022 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651721423;
        bh=vOH0kAdmR1eNZn7dq7qeSAVj/s+a8/0GdFuCXLUW/CU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g+9CtdtO3/zzV1+bZ2QmOejc7pc6dzZz5V0iTRIcx1bdlYXlMHrs9nQqg10r/BeYs
         +PmvWnmGptI78zUdjkwjx425vxkvJixLXLplrhuBg86OnLbNCrvh/M64SOvKglEE7s
         0EjNWcc7pr28auxz3kD64IaTwkSpy2qGJiCIvsSSsgdLp6NiCzjf1gNecbuBIFY5tR
         OM5TFGUGGcWe4m9ktlTyOKeRL1GmMjEVGuX31mfWrJbyYnZVyp1slkTqDDEDsRonTS
         p54NUkVH61i1VhOaYPi3pWgpqZoPBA/yCGJdCl1YnaYAHSCWgzgfOKzyePzU9CTlQA
         ur4WWGWOtmk9w==
Received: by mail-ua1-f44.google.com with SMTP id x5so1217211uap.8;
        Wed, 04 May 2022 20:30:22 -0700 (PDT)
X-Gm-Message-State: AOAM531D15dGflb6pDmuh3LQhtWqTwXqWARYZmuBL1Y9A+T2oxA+8HSh
        mfvze6cQ0IPGBiVnmruIYh0yjMmKm7F441DD7zs=
X-Google-Smtp-Source: ABdhPJzbU/iPzb/jLBOfTd8HLatPunLFi+iu4xyj0d3kkgDuJ1vstUU5IUyh/crnvfi60C0KDYx5aW4fbp9tD6SDpKg=
X-Received: by 2002:ab0:2a87:0:b0:362:9cdb:8b64 with SMTP id
 h7-20020ab02a87000000b003629cdb8b64mr7496584uar.83.1651721421926; Wed, 04 May
 2022 20:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-2-palmer@rivosinc.com>
 <2180881.iZASKD2KPV@diego>
In-Reply-To: <2180881.iZASKD2KPV@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 5 May 2022 11:30:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSjwu3-SLfXAh=UrqSq28mq_7nxbFNQ9j9kqY32EiXcJw@mail.gmail.com>
Message-ID: <CAJF2gTSjwu3-SLfXAh=UrqSq28mq_7nxbFNQ9j9kqY32EiXcJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] asm-generic: ticket-lock: New generic ticket-based spinlock
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

On Wed, May 4, 2022 at 7:57 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Samstag, 30. April 2022, 17:36:20 CEST schrieb Palmer Dabbelt:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > This is a simple, fair spinlock.  Specifically it doesn't have all the
> > subtle memory model dependencies that qspinlock has, which makes it mor=
e
> > suitable for simple systems as it is more likely to be correct.  It is
> > implemented entirely in terms of standard atomics and thus works fine
> > without any arch-specific code.
> >
> > This replaces the existing asm-generic/spinlock.h, which just errored
> > out on SMP systems.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
