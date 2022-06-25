Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB155A796
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jun 2022 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiFYGzH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jun 2022 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiFYGzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2022 02:55:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92733894
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2022 23:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14947B8221B
        for <linux-arch@vger.kernel.org>; Sat, 25 Jun 2022 06:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A536FC385A5
        for <linux-arch@vger.kernel.org>; Sat, 25 Jun 2022 06:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656140103;
        bh=qt3sJUPetBPeub2FfPXWu+9b8b/75M8N6O14srSnXVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=svrIoPOaHYgsERl1YshHVfgjTi4auGageCP++OuX7wKyqOOhx41oNOAq/q6qT4b4I
         Ji7Zrmyb8qFgCQpnSkIKGXqpVzRj7NfOK7SFno8S//SP2fajpIBXRq4I/ObSKpDMh2
         3lFSHmaZIsLLpexBKC563V9pjJ/sx9R/NmJ+ISF0BvjbMY/SWR2+ltrHg9gNarK3us
         w41knpCC4QdA3rmNG1LfaZqCnzicZngZOsBVvAWl38v93CQIP7uQM1aJN+IPCQWVUT
         AWvTLFnSQo5RTiRqfa9XC3hCk4N4gfhLdYljbdU3eaOlNnGQokg1jIrxuQsof2T52A
         OiIMjff7c/O2A==
Received: by mail-vs1-f41.google.com with SMTP id z66so4237758vsb.3
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2022 23:55:03 -0700 (PDT)
X-Gm-Message-State: AJIora+spSlvMrsl0sOoVnkv7mjOFttoBtHVojApTeK86PH1mT6/MkSc
        HgeK+VqqY9bqqiKjllUL31hAp2h6WaCHOrGSNXg=
X-Google-Smtp-Source: AGRyM1sNpDlWjNkNqBS7go7KSEAgsr1MH/WGdjQU0Z1OIm6O/14Cyj6RhsnRavlnIqWogqXzvsNCELBqIEoDTm6P4XA=
X-Received: by 2002:a67:6fc3:0:b0:356:18:32ba with SMTP id k186-20020a676fc3000000b00356001832bamr911328vsc.43.1656140102561;
 Fri, 24 Jun 2022 23:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
 <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
 <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com> <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 25 Jun 2022 14:54:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7nLJ4q_raDbWH+EP+TFRbkrXOzB8bUkUiDnNBa2ai_+A@mail.gmail.com>
Message-ID: <CAAhV-H7nLJ4q_raDbWH+EP+TFRbkrXOzB8bUkUiDnNBa2ai_+A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Thu, Jun 23, 2022 at 10:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 23, 2022 at 3:05 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Thu, Jun 23, 2022 at 4:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Thu, Jun 23, 2022 at 9:56 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > On Thu, Jun 23, 2022 at 1:45 PM Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > >
> > > > > > On NUMA system, the performance of qspinlock is better than generic
> > > > > > spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> > > > > > per node, 32 cores in total) machine.
> > >
> > > You are still missing an explanation here about why this is safe to
> > > do. Is there are
> > > architectural guarantee for forward progress, or do you rely on
> > > specific microarchitectural
> > > behavior?
> > In my understanding, "guarantee for forward progress" means to avoid
> > many ll/sc happening at the same time and no one succeeds.
> > LoongArch uses "exclusive access (with timeout) of ll" to avoid
> > simultaneous ll (it also blocks other memory load/store on the same
> > address), and uses "random delay of sc" to avoid simultaneous sc
> > (introduced in CPUCFG3, bit 3 and bit 4 [1]). This mechanism can
> > guarantee forward progress in practice.
> >
> > [1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg
>
> If there is an architected feature bit for the delay, does that mean that there
> is a chance of CPUs getting released that set this to zero?
I had an offline discussion with hardware engineers, they told me that
it is a mandatory requirement for LoongArch to implement "exclusive
access of ll" and "random delay of sc" for multi-core chips. Only
single-core and dual-core processors (and not support multi-chip
interconnection) are allowed to have no such features.

Huacai
>
> In that case, you probably need a boot-time check for this feature bit
> to refuse booting a kernel with qspinlock enabled when it has more than
> one active CPU but does not support the random backoff, and you need
> to make the choice user-visible, so users are able to configure their
> kernels using the ticket spinlock. The ticket lock may also be the best
> choice for smaller configurations such as a single-socket 3A5000 with
> four cores and no NUMA.
>
>        Arnd
