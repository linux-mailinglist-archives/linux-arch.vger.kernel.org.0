Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A774E55A995
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jun 2022 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiFYLtK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jun 2022 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFYLtJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2022 07:49:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F627165AC
        for <linux-arch@vger.kernel.org>; Sat, 25 Jun 2022 04:49:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mleo0-1nMLb61qio-00ijy8 for <linux-arch@vger.kernel.org>; Sat, 25 Jun
 2022 13:49:06 +0200
Received: by mail-yb1-f175.google.com with SMTP id r3so8821228ybr.6
        for <linux-arch@vger.kernel.org>; Sat, 25 Jun 2022 04:49:06 -0700 (PDT)
X-Gm-Message-State: AJIora9bUiiGl/PB97AFp7pJCWl1UsDimE7dBepcXz+g3ykKtWVVs9SY
        zUx3hYZwpMNnCs/0dOGcGlMF/s48DZJWAax9Xjg=
X-Google-Smtp-Source: AGRyM1sq3xoiQgqkY5WineUzVfA54tp5SawyuzEtHHo8lJfL4JIZ800JdhSAtmcUnMOMvSs/DTwf6CTFQAaV2JX0QQc=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr3817339ybq.472.1656157745315; Sat, 25
 Jun 2022 04:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
 <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
 <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com>
 <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com> <CAAhV-H7nLJ4q_raDbWH+EP+TFRbkrXOzB8bUkUiDnNBa2ai_+A@mail.gmail.com>
In-Reply-To: <CAAhV-H7nLJ4q_raDbWH+EP+TFRbkrXOzB8bUkUiDnNBa2ai_+A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Jun 2022 13:48:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YT_gWNk1v99KgYPf3KhmAOeLyMBeLxsr_th9C59Deyg@mail.gmail.com>
Message-ID: <CAK8P3a0YT_gWNk1v99KgYPf3KhmAOeLyMBeLxsr_th9C59Deyg@mail.gmail.com>
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
X-Provags-ID: V03:K1:3A5ERAP0CS1fYYyT+tpAsIry40fmWEHFZLlgGdfMf6eQ2s9/emR
 1N6I4yMgFN8eB3h8zynEuaBLjfAUZ85ARCx9Hype1fk567Ev75suw5aZhn4J0wlvCF/TaO1
 lW21PBe1vMjDUFjIJX/EozVdT9qInc6pWNAAwynk8JY37zZfCWXXDLHlCuH6U88cVf1c0U8
 ZfBvz/l2Apim7+xCx0plQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tIBC5b3eV2M=:u0aKB1hZrV5dHOnu6QqVDM
 ECgCNHvJ7nUK3SHwP9pS/ZLa1cplEtkYmD4FeuZkhNZir7zM+BpnRj/ZQJcr81SbAc5ppmpKI
 QOR40cGjjeqCPJN2+1TcAEhiYgr/dAh+KtZOIv/JIBtay4YWcKdVzx7AZtOvB7R03FX8rfo1V
 P07QVBABBxi8P5ba6yM6CU/zFNB+GyYkC0pfE/6qVo2UC6l/f6VaAKoBwMw6sR/WzxO6nkS+8
 Sv5SxmGErPcWT/VJVqjBn3/0Le9Nf1eiJVurX9NQSEWAJHmkJp2xmSA2S/4ef6Tf3144+FIDU
 FVX3LSNUDJrVsYqFFx5kAylhgeACnNw/aov8VYXsie8a3m8g162jxHUlgSA+GdGC2VK8uictc
 4rPZgkSmYX9bj9iBSkClNdS+2NJrTZV3b7VTOKPFbAuiUoQrnZvDcBouSsOopkoiLQlVzPm5G
 Pu3ZR1y81GqMeqMb/eron9Uk5fkue5LxVTSR54MaA4dh3BQclSU0Vr8CbXMIcVMG7Hp0IK3Yl
 m9minXWQMFMwwN1SrIYLBYQ5n5KgWVIGGznsxuCCfPIBFLSdievMjdHzOAIFKVU0KV9oN3WE7
 MTvY44eSDOR9tz50VQw6ebls5/Xpn5xZiB7JYBRnWA2KxvOjtrcnUV2gZQO8tpBoTkbjNiGCK
 pB3QF4UnIkt5psqkW3a359gkMEtrbw54jtZAvA6xm5zHf4OXMqNEYfRSs96Tu+jbuuuZ0G6Ye
 2PGHpREvdeEYkLDkAEAOIjyi/p0NFRS6rU5SbA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 25, 2022 at 8:54 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Thu, Jun 23, 2022 at 10:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jun 23, 2022 at 3:05 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > If there is an architected feature bit for the delay, does that mean that there
> > is a chance of CPUs getting released that set this to zero?
> I had an offline discussion with hardware engineers, they told me that
> it is a mandatory requirement for LoongArch to implement "exclusive
> access of ll" and "random delay of sc" for multi-core chips. Only
> single-core and dual-core processors (and not support multi-chip
> interconnection) are allowed to have no such features.

Ok, I see. I suppose the reason is that the dual-core version is safe
without the random backoff because all uses cases for qspinlock only
involve one CPU waiting for a lock, right?

Please put the explanation into the changelog text for the next version. It
might be helpful to also document this in the source code itself, maybe
with a boot-time assertion that checks for this guarantee to be held up,
and an explanation that this is required for using qspinlock.

Regardless of this, I think it still makes sense to use the same compile-time
logic that Guo Ren suggested for the risc-v version, offering a choice between
ticket spinlock and qspinlock when both make sense, possibly depending
on CONFIG_NR_CPUS and CONFIG_NUMA.

           Arnd
