Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C03E158D
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhHENU3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhHENU3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 09:20:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6EC061765
        for <linux-arch@vger.kernel.org>; Thu,  5 Aug 2021 06:20:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f11so6645963ioj.3
        for <linux-arch@vger.kernel.org>; Thu, 05 Aug 2021 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffia4FtdtbAacefvHTQ97ZwKlVqk6Tb0pwbGsu/jgT0=;
        b=Dk+HVP6iAtlBD6TYf+SGZdNdZLZtYM733nnGs/9Xhp/WXvTBEOrMDkBTQ37l4tFIU8
         amDbhpQOWl7US1QM9JURszEj8jM/UpecnNHzG/kywV6yAawHnG+K6J7RpzKLw4nwxJXP
         5aAjCwyL3GMX8LU6zhG5rByF7CzB1agYL51muy9/J9POKHaau7EQ/OdE1BlqX/oqU6mI
         u9qI7GBx/iq7gKdFRjTo/8sinb5wVmod3gZAtMtB/luJOZiYoqTsKsq6ERQy9p4EyRWN
         wdULCIoH87D0cgLLefAzyXRe8eMojJRvtGm5QghvKmoOCsJr0Dgqtgec5C4I5W1yNkXY
         xpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffia4FtdtbAacefvHTQ97ZwKlVqk6Tb0pwbGsu/jgT0=;
        b=bAimamEzC9ACIxLLmvys66ZIrCCZVhfFBFyV6cWkzc1SIbDv6Y9rAAgsphD3AwromI
         oqG4alToLOP9zIgh8a16nuzZdrfD9lwbf2dnDA3gheoSRiQ7nXKq676asIqwZsSfvdkF
         By+yoE5zhYM/wavoyDKvLjIuI7tV/FfsLRoihjrjVa0sEHM4C0i5+jHh/9S/mPXgBM7X
         +ul7b5CZjusVjMkKGeIFSQr12HjJn9aZjiyC2cMcw23CZ53OtUwOl8BTmBqMrhEWqX3M
         G3OYHCkhVZsWk0TRc0Djm03F0p5Qg2RRoIeM1bjjV9NHczF/tqY2OwTXlMsjlir74tup
         5ZKg==
X-Gm-Message-State: AOAM533Qfrox83hs0ofNOOetN0LYjHnhVOdkIxTxzrFdBbURFFzm/WUu
        20+jXmI7/kgQUSdSv1f55WFjkYXfIlgYsv9pVmk=
X-Google-Smtp-Source: ABdhPJzTuZ1SPSb+UGWPDpGriHN5vtUfocTHYaohDvmgBGBDnLtcp0xO0VAWu7H9GLc8ldmBkcQ/6tERtPphDqiDHWY=
X-Received: by 2002:a02:6983:: with SMTP id e125mr4594712jac.112.1628169614801;
 Thu, 05 Aug 2021 06:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn> <20210729093923.GD21151@willie-the-truck>
 <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com> <7574da60-fb71-dad2-b099-a815a0a18c22@redhat.com>
In-Reply-To: <7574da60-fb71-dad2-b099-a815a0a18c22@redhat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 5 Aug 2021 21:20:00 +0800
Message-ID: <CAAhV-H5no05HdLyzUr1Mhbem4_zcyRkx_4kTMpW_F5h5gfh=9A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Waiman Long <llong@redhat.com>
Cc:     hev <r@hev.cc>, Will Deacon <will@kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, all,

On Sat, Jul 31, 2021 at 2:40 AM Waiman Long <llong@redhat.com> wrote:
>
> On 7/29/21 6:18 AM, hev wrote:
> > Hi, Will,
> >
> > On Thu, Jul 29, 2021 at 5:39 PM Will Deacon <will@kernel.org> wrote:
> >> On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
> >>> From: wangrui <wangrui@loongson.cn>
> >>>
> >>> This patch introduce a new atomic primitive 'and_or', It may be have three
> >>> types of implemeations:
> >>>
> >>>   * The generic implementation is based on arch_cmpxchg.
> >>>   * The hardware supports atomic 'and_or' of single instruction.
> >> Do any architectures actually support this instruction?
> > No, I'm not sure now.
> >
> >> On arm64, we can clear arbitrary bits and we can set arbitrary bits, but we
> >> can't combine the two in a fashion which provides atomicity and
> >> forward-progress guarantees.
> >>
> >> Please can you explain how this new primitive will be used, in case there's
> >> an alternative way of doing it which maps better to what CPUs can actually
> >> do?
> > I think we can easily exchange arbitrary bits of a machine word with atomic
> > andnot_or/and_or. Otherwise, we can only use xchg8/16 to do it. It depends on
> > hardware support, and the key point is that the bits to be exchanged
> > must be in the
> > same sub-word. qspinlock adjusted memory layout for this reason, and waste some
> > bits(_Q_PENDING_BITS == 8).
>
> It is not actually a waste of bits. With _Q_PENDING_BITS==8, more
> optimized code can be used for pending bit processing. It is only in the
> rare case that NR_CPUS >= 16k - 1 that we have to fall back to
> _Q_PENDING_BITS==1. In fact, that should be the only condition that will
> make _Q_PENDING_BITS=1.
Our original goal is to let LoongArch (and CSKY, RISC-V, etc) can use
qspinlock, but these archs lack sub-word xchg/cmpxchg. Arnd suggests
we not use qspinlock, but LoongArch has large SMP (and NUMA) so we
need it. Peter suggests we implement atomic_fetch_and_or, but it seems
not agreed by everyone. So, I think we can only fix the
badly-implemented xchg_small() for MIPS and LoongArch.

Huacai
>
> Cheers,
> Longman
>
