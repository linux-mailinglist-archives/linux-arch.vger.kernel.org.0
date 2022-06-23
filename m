Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD1557D77
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiFWOEe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFWOEe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 10:04:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1316A3617E
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 07:04:32 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5lvf-1nccyq0Ry7-017Ha9 for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022
 16:04:31 +0200
Received: by mail-yb1-f172.google.com with SMTP id i15so31178033ybp.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 07:04:30 -0700 (PDT)
X-Gm-Message-State: AJIora9182+a9crVZuHQA+7TzNfbui8aeMwnLkOQBOXG6zjiiJThEkIJ
        hmqF1rSS/vcy4gIocA0b3i9cTm3KIrrOhrQQiUE=
X-Google-Smtp-Source: AGRyM1tw/ZrdY5RwWUm1pztJEAHWQ1L6KKYYxboRYaYgMVmltY4YiYheBN1gwVLXj/BpJFxHyTJ+EjL3M88UtE0HXJA=
X-Received: by 2002:a25:e808:0:b0:669:7fcf:5f82 with SMTP id
 k8-20020a25e808000000b006697fcf5f82mr9236133ybd.550.1655993069914; Thu, 23
 Jun 2022 07:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
 <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com> <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com>
In-Reply-To: <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 16:04:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com>
Message-ID: <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add qspinlock support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DNWrzOVsuCmXQ/OaSR4tVquy8QXSedlwqVa/hU8PzD1GlAOT0l9
 cgyNZaEyzOZeb/SMhMJSWkuHJrQTwsLF0PxmQhlpnRf9795NZXTbmjmhg+gnufffLAWxqN5
 3u4xPMinu/JIXhmgLsfkMyVcePehX3b1R0PPjM3xVUScRWPU3BrJ9kOtGSokof0P2TsGBeC
 4ts5KV6WslMK0ePxJj0uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50UwbmsLXVo=:8yvRyT2Acsz2CLW/PWPFhG
 8n+4x6zA/6iOzbsDHyXmoHtBBQ1nPFHBBN57TKx6Ba6LNvlp5jtnqE+yl1TRDhH8jntRDglMa
 NANMtajo6U7PGXdJgRwyYTTwo40j2Wm4Ql7yEVpmgtGiOZhCkeKeBZYgA/oBD+SuqhSLNtpac
 gC3yT4gO7uANj46bAEfnejt/PwgW3SAVhk3dfGlaEovfXZ0BMDWAISRn73v3BTl2CjLHs0QXd
 Mniy5QrTl85+zOq7eWosQ8XzsS2ZmoXslXSElcKgOVg1b5NWgrxnWUrz8HOYf39I2NYoL6l0M
 hw+PnUVotogEdP1frgbLztg4n2sj9NF5Bje4mxJad7ElUkRjFCQaENtzOsX31QE8lQxsD3D6e
 QjVMHoGu4SBrmrvBnycNa76d55olBCTji4ZFYF8IZz7Su4TTpwmank/IihGqFKoyLtQEAx3wi
 OhLgI7Fi9YE7ud4DmKVgxleUvdhb715ogMZlmCN/GObT0yYrEDPDqO33+cdmLxjLqcEYt6ffM
 ewSEQPQcHJXEAdk9793X/yhKRIWdnE1iaRFhnlpY3IpB3jbgIperUlXyyYDznD9+Uq8c6I07H
 +ifEalcj2Hc7mV+ks2SuGoYJuahSSsTY1/5ZdMIInIWZWOG/9U4zjOvSx5adyC9OyblNOL2JR
 axKZrKgQ6BVEaGdnPw+i2e03U9jDvowWimhUAkK3WeguFk+LEUiPZMx707MeBFkMEnmFCzBwB
 3ZwTuLhpjYSNJHun9gCfnsQrEPIWDPTncXQg2Evswgesg4w/Bnfo/OoV952iVtcMo1VvZhbBd
 5Yki9vm700R7aNI2JRMjg4E7nX7UFoJbbcwMTkjKxhrMcsmrC/rJy5tedYRs41WSkPVrGBub/
 Aj/v2gdqi46nxS1J2rEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 23, 2022 at 3:05 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Thu, Jun 23, 2022 at 4:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Jun 23, 2022 at 9:56 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > On Thu, Jun 23, 2022 at 1:45 PM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > >
> > > > > On NUMA system, the performance of qspinlock is better than generic
> > > > > spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> > > > > per node, 32 cores in total) machine.
> >
> > You are still missing an explanation here about why this is safe to
> > do. Is there are
> > architectural guarantee for forward progress, or do you rely on
> > specific microarchitectural
> > behavior?
> In my understanding, "guarantee for forward progress" means to avoid
> many ll/sc happening at the same time and no one succeeds.
> LoongArch uses "exclusive access (with timeout) of ll" to avoid
> simultaneous ll (it also blocks other memory load/store on the same
> address), and uses "random delay of sc" to avoid simultaneous sc
> (introduced in CPUCFG3, bit 3 and bit 4 [1]). This mechanism can
> guarantee forward progress in practice.
>
> [1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg

If there is an architected feature bit for the delay, does that mean that there
is a chance of CPUs getting released that set this to zero?

In that case, you probably need a boot-time check for this feature bit
to refuse booting a kernel with qspinlock enabled when it has more than
one active CPU but does not support the random backoff, and you need
to make the choice user-visible, so users are able to configure their
kernels using the ticket spinlock. The ticket lock may also be the best
choice for smaller configurations such as a single-socket 3A5000 with
four cores and no NUMA.

       Arnd
