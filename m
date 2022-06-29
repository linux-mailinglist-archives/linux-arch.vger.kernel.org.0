Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970655FA8A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiF2I37 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiF2I36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 04:29:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1AEF59C;
        Wed, 29 Jun 2022 01:29:57 -0700 (PDT)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXXZf-1o8VBM1Jsd-00Z2jt; Wed, 29 Jun 2022 10:29:55 +0200
Received: by mail-yb1-f169.google.com with SMTP id d5so26638252yba.5;
        Wed, 29 Jun 2022 01:29:55 -0700 (PDT)
X-Gm-Message-State: AJIora8A75f59M/K0j+nJBVBH4NCK1OqyzJa/yQcAQM1CkenBjQDYWCz
        vrKmThaczcsqW1yjrhFDwIpCZDEPXBho/AD8H8A=
X-Google-Smtp-Source: AGRyM1s+0Vdgu6k29DCyj5luRoc2GU/O+zNZO7vZnJQkpulyhuYloGJMkGI6qdeLOKZPe+Xqib0p73hV9hsIc7OQwVE=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr2039004ybl.394.1656491393923; Wed, 29
 Jun 2022 01:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com> <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
 <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com> <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
 <CAJF2gTTtKiMZJLWBEcRz-4CmNojH0cOgpUYGupLyCXXFjQD_FQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTtKiMZJLWBEcRz-4CmNojH0cOgpUYGupLyCXXFjQD_FQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jun 2022 10:29:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3GiMgEJdBg5QQHHD0bDnpR0XwPkAw7=zT7ETzf6-sCmg@mail.gmail.com>
Message-ID: <CAK8P3a3GiMgEJdBg5QQHHD0bDnpR0XwPkAw7=zT7ETzf6-sCmg@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EvcXF/YPtxhEo6ZQIN24NwoJVIM8u0DcYlhjQoAS7Z9YOHzI6GY
 BnI0vZd5alKCc2Uq46bjM5eX7Px0ly1Kds7ETYJoNI1t+cbhKL/+gQAzJBOzrVoN2fT8SL2
 GsI0zI5gSjOW/1m8Nyz+h48HoInMnbINXPF4uVbmCeLQTequ1zDSE+hEMcH5EZXllk1aiS4
 A/BN5q8m2ui42sNQbZiMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c875qPA3kBI=:oc0VeV3s6SB4C7TwtGiC59
 saFt9JUU38TgdUowu9dTsSWiiAD+oqRAMQ4zrP7vOJz7TBts8bIo7pHf9dJ80EEW5iSDfEPFz
 8Fcg3I71eZ3R1rWEVWeymi4z253O4CAhhR2YbldPVeYperP1bUsXQAVjSUo5TNFEFypTPSIye
 78SrgKUNvxSGocb4aQhtYzNFE3TsF0dDwZAL0Kc55/Ls003MHP2e6ce61he+W6w/8m2f2/+Ce
 6MEx0Xi+Y8d2P+ZB67xwzSLlOiAzk6eNGIcs/4Ps+gT4nSg2DllsRkJ4s8KQuBZFwVMJvrkML
 VYQqsKY3U7CrVd1Hg93GQvHsLW0A79WmcseQ5xPfgOx7ZKbjg4QGKykDW2aeCz/h/Ww8Xtvru
 6jY5UhOIya8PyezlW0epmKP/FS6hl79Wlt3Fgt7NnKzyDU63F09YgSS3jGgRzZYU8iswmO6kj
 0IxZ+4IzgYNKDcWfHnCgOBDwCZD2d+NG1SLNf3fZXFr+PQjusNyMBM8VyrNrRc2sPvmdjkyL9
 +sfG8z/wib+TfxJXXK7TdfRQA2rzHM94vJJl44TwBKDDw3MGtPzgixnqosBdGMngzVGZHlx3e
 ookpZQJ+oMzpzSKAq1r5lRbB5Rzow7W6OP5mHCai9POZCQp8P3sIvCOxaBYI28hsbi+2IwO7k
 CAH5E0b8bgqS9wpvpCTbkL7zzXw+/yT13nT8k+Cm1sYVVE+IuQXD6gT6313dWqW4jMyHZtfRZ
 8xkEDKpf0giDqWgd+7M25WCTtgU6fphkLet/zg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 29, 2022 at 10:24 AM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Jun 29, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Jun 29, 2022 at 3:34 AM Waiman Long <longman@redhat.com> wrote:
> >
> > From looking at the header file dependencies on arm64, I know that
> > putting jump labels into core infrastructure like the arch_spin_lock()
> > makes a big mess of indirect includes and measurably slows down
> > the kernel build.
> arm64 needn't combo spinlock, it could use pure qspinlock with keeping
> current header files included.

arm64 has a different problem: there are two separate sets of atomic
instructions, and the decision between those is similarly done using
jump labels. I definitely like the ability to choose between qspinlock
and ticket spinlock on arm64 as well. This can be done as a
compile-time choice, but both of them still depend on jump labels.

        Arnd
