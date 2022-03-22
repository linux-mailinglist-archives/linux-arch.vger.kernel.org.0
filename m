Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEC4E3BB3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiCVJZl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiCVJZj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 05:25:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D423337D;
        Tue, 22 Mar 2022 02:24:12 -0700 (PDT)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2Nm2-1nW32y3IzO-003vD9; Tue, 22 Mar 2022 10:24:10 +0100
Received: by mail-wm1-f54.google.com with SMTP id r7so9991344wmq.2;
        Tue, 22 Mar 2022 02:24:10 -0700 (PDT)
X-Gm-Message-State: AOAM5319y3xG6KE30cXZa02tZk5szEol9jGRNrauJbCyUcQNUwIXEKW5
        D3bVOk3lTl+dzBtV+8d82q9cjcLJBNBS2iGz450=
X-Google-Smtp-Source: ABdhPJwsixCYKczxHEkB8tnxWnn7WcRL3uS0+upLMvgBna2t7w8kHg6YLFFU+Drbavx3w8/MLHV5750XhIVVex2zZF0=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr2957769wmj.20.1647941050207; Tue, 22
 Mar 2022 02:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143130.1026432-1-chenhuacai@loongson.cn> <20220319143130.1026432-7-chenhuacai@loongson.cn>
 <CAK8P3a0wVKWFASv6cVDOZmX=1h7EeAVyrxLFXmoH5REVaAoNhQ@mail.gmail.com> <CAAhV-H6zddef+ezmXhK+K3eZtvVECqq-nujyr9H2RjS1iJndrg@mail.gmail.com>
In-Reply-To: <CAAhV-H6zddef+ezmXhK+K3eZtvVECqq-nujyr9H2RjS1iJndrg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 10:23:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0rJi35Bx+_Joq1NH79Pvd-+hNV8apDv5othr0_7_SqcQ@mail.gmail.com>
Message-ID: <CAK8P3a0rJi35Bx+_Joq1NH79Pvd-+hNV8apDv5othr0_7_SqcQ@mail.gmail.com>
Subject: Re: [PATCH V8 07/22] LoongArch: Add atomic/locking headers
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GsZZXVIyiFWAil3OKfUQDeR3PG8Hyp4LfdjBL4/0CGCIX9DyTBw
 79WB2ES2iqdZNU3UkmpzmCAhKwBmVSmz8qtKMqHUA5Eo7HFh74XAdGStqFhe6lEtv+bw18Q
 +r998ajs2qP4kwCrIauh1scQXo4DcG1SfJczz1a2hIaMkDDIeBJSMRP8BjGrz9Sf4+2iAv+
 kqoHgKzvs5XoOdjgjpzUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0cUHH2aJ6Tw=:7C5yPvboapmwLvnOrfGXe/
 IDOct5/8Rnu68+uGrbNLpYTdu6Rlr/RAoalDiNAXAHBfHRvP/wPwgcFCHBENJfX6dJcx7a0hy
 4fmgDIR0J9P/MESv2PxehvkicPb/3usvpJ3pCe2RYkhJmETYa+4JT9x2JEZ1Rkwu/2ISAEPys
 +Iw6jQSSlWKKb5iqJ0KYW1zTOC4fu5+/Rjca259fDNT4WmTm7A0qPnFRsDBiTgZfdzis6h/wv
 jEgegu+aHR+ejR8QBIasddGA6YMFqcnyHrBeLxLcUaT7IFIoIQCwiEhfIQZXvDsvX2TkjXsFQ
 tkMbD8n+rolnk5yc01u3y7qfsBT46xdw0wfow/LGABLMnvFeSIe6uo39aI6e9TEsGrB9XnyDW
 eMM1RqV0Lr8zpMdqqyc/tvrWda5IZNwHyRkW7s8c+lhTJ4FbQgTdr8qmW9pcVizad7qmiM+l0
 el7ESCr1duVvmquTRQ5EwHNx9DJ5nDkKFZx5yT+JQ90JgGmuh5OG+dIyiujRXk7/U/zn8HZ/o
 LdiTh4neRito/mq9hcxA1rnI6ozzT7J1+mGZrRItgfvw5TszFqNzAgCDuO6kuSVkXVAfO0WWj
 6JtLQEgR7ECRjP1oAzh09q/HhiWU27QYn2cN8zJcqokM7GPNBd/6e74afj0MHFVhq/i+Qh46Q
 4wcL+Z3acwAAtkFH6brvW0myBt/AalGCM6f39FOORqPHWsnivCyQukH7lzGls2q8EEBG+o/qd
 lc49B2EvJ4+4qYd03FF+lGDbMuWKQUMdbkNljO29eSAvZEoHYAmLkvMBdy8bEwanvhB8nxyGN
 0MCrmjbm4FyHaxqwuGkGOPsjRrHvF8pCycDNmkKfbyaSvU+4T0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 4:03 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Mon, Mar 21, 2022 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Mar 19, 2022 at 3:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:

> > Please coordinate the inclusion of the patches with them and use that
> > spinlock implementation for the initial merge, to avoid further discussion
> > on the topic. If at a later point you are able to come up with a qspinlock
> > implementation that has convincing forward-progress guarantees and
> > can be shown to be better, we can revisit this.
>
> In my opinion, forward-progress is solved in V2, since we have
> reworked __xchg_small()/__cmpxchg_small(), and qspinlock is needed by
> NUMA.
> However, if the generic ticket lock is merged later, I will try to use
> it at present.

Yes, please do. If I merge both the ticket spinlock code and your architecture
code through the asm-generic tree for 5.19, this should work out nicely.

I'd good to hear that you have a solution for the forward-progress
issue with qspinlock, We should discuss that when the architecture
is merged then, and see what this means for the other architectures
that currently use the qspinlock code, to decide which ones of those
should be converted to ticket lock, which can use the same approach
that you have, and which are already safe.

        Arnd
