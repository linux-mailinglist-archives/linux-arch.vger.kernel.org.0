Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4866755F87F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiF2HJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiF2HJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 03:09:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469ACE38;
        Wed, 29 Jun 2022 00:09:15 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MG90u-1ns5os1Tie-00GXtg; Wed, 29 Jun 2022 09:09:14 +0200
Received: by mail-yb1-f179.google.com with SMTP id i7so26262714ybe.11;
        Wed, 29 Jun 2022 00:09:14 -0700 (PDT)
X-Gm-Message-State: AJIora+Xehkji/981Hp0OYc1DdC+n9DioimAnhofWjtP9n/5HDPYzWIe
        67ebnbMPeLWBuSIRciAYSDzWDGZ6vaArXKrTCx4=
X-Google-Smtp-Source: AGRyM1vwFx+KUXwvbgg/ASvRBxEdL/JjOQ3Jx1tv8VOFIFQwJBGUiZKdd3oyAVRe8CZHrAKOLM6aLE6JRIBVMMOSe+E=
X-Received: by 2002:a25:760e:0:b0:66c:95eb:6c69 with SMTP id
 r14-20020a25760e000000b0066c95eb6c69mr1899906ybc.106.1656486552981; Wed, 29
 Jun 2022 00:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com> <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
 <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com>
In-Reply-To: <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jun 2022 09:08:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
Message-ID: <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
To:     Waiman Long <longman@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yLYGSlgFf4Tbp+OluMxIlmPCxct5Gr/dLB71q2PeGr8RkvuIWk7
 sZ+jqj0IK/TtnXWK5NxcWFXFuBEsk2vQUYbx+yP+dGLRADpZhpDLy4/0owaD/5cRYlnZ7IP
 /ueZf/D3WToQe8yvsKIlSmijN5d5FHwpCJq6574qSy8sy2rSJ//IxTkLoRshchtXQbjpzHY
 ggM0JSY4IGwXI7WND8BYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/uRhtt7xI/c=:oLmicir/z9PxngyFEgNPN8
 25gBrsOvi1iVu4P5KRVkFxnR1d5AGh6ANFhXt0I48z8UNJ/lj2r5m4bWg5C4qGrm8IA7oyBt3
 Vc2sJ6lCj21h1j+wkheSl3ypy/mN3a5nouWz4vT4bOFTqPANW70+0/lJZfTY9kt+5KzR32qDk
 wPR13xOcfriU/OSthc9F7ui6wTVvWSBcfcxREpDkm1g4B7qNtSRFue0OBkQmscxBcsbnyTGct
 LP3s8Bw6Gvw25MbEDkRN7t5NkuBU2mHEU1AT+sh3riNQ3by1K2+10kg6UTF/QBuoxcjiOLJh1
 Ygu+2vvEi2tXyROw+WdOTUAypxkJKFz5FWg1ckWmzAOzzu6NNAKYxQJ7XpM5OBgFZjWZ5s4+x
 rgdz5NOhf5Roh1S9NOC2QkCua2fvdLSLUgaId5VPAppng+ha7KRu4SLkdOeA4GyyYgL3Hhv8v
 PjI/kv77Wkrb3yPsGsGMRCjXb3Nt20FL4JEZNZ0vJfgpI1NtpLbDsYgbkPPBdGcy3l4WqL6Gr
 rFX9HtbbVlw2L4xAa+Ng7TZ/6Mx8hwY1FkFJSVLcuoZq1st3t3pGzFRSvn/GQ0tugQ3XGncGD
 H5Juhk+lcBDX3uW5dSJ4VE+ekmZK7BqjNY0mqJvxaKYcNESw+J3JQtU89Lyad0Xe6toDLRSe/
 XSJ1yE6WECugNL/SPykyjI83IEGO3CLVZPiZIz2LD9hXt4/pdTCr1A1yh9J8smk1mH1UOEVqR
 QtU5HnVNviE2bvPMNQXYcBEmxJN+FfZ7KFUwvg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 29, 2022 at 3:34 AM Waiman Long <longman@redhat.com> wrote:
> On 6/28/22 21:17, Guo Ren wrote:
> > On Wed, Jun 29, 2022 at 2:13 AM Waiman Long <longman@redhat.com> wrote:
> >> On 6/28/22 04:17, guoren@kernel.org wrote:
> >>
> >> So the current config setting determines if qspinlock will be used, not
> >> some boot time parameter that user needs to specify. This patch will
> >> just add useless code to lock/unlock sites. I don't see any benefit of
> >> doing that.
> > This is a startup patch for riscv. next, we could let vendors make choices.
> > I'm not sure they like cmdline or vendor-specific errata style.
> >
> > Eventually, we would let one riscv Image support all machines, some
> > use ticket-lock, and some use qspinlock.
>
> OK. Maybe you can postpone this combo spinlock until there is a good use
> case for it. Upstream usually don't accept patches that have no good use
> case yet.

I think the usecase on risc-v is this: there are cases where the qspinlock
is preferred for performance reasons, but there are also CPU cores on
which it is not safe to use. risc-v like most modern architectures has a
strict rule about being able to build kernels that work on all machines,
so without something like this, it would not be able to use qspinlock at all.

On the other hand, I don't really like the idea of putting the static-key
wrapper into the asm-generic header. Especially the ticket spinlock
implementation should be simple and not depend on jump labels.

From looking at the header file dependencies on arm64, I know that
putting jump labels into core infrastructure like the arch_spin_lock()
makes a big mess of indirect includes and measurably slows down
the kernel build.

I think this can still be done in the riscv asm/spinlock.h header with
minimal impact on the asm-generic file if the riscv maintainers see
a significant enough advantage, but I don't want it in the common code.

        Arnd
