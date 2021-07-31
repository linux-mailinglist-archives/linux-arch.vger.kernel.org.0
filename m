Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9752B3DC282
	for <lists+linux-arch@lfdr.de>; Sat, 31 Jul 2021 03:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhGaBqz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 21:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGaBqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 21:46:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2195C06175F
        for <linux-arch@vger.kernel.org>; Fri, 30 Jul 2021 18:46:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hw6so6092723ejc.10
        for <linux-arch@vger.kernel.org>; Fri, 30 Jul 2021 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqIm8Zx3pH/8PTwn/CTBJTXMqgv5eudoeGRkjwQqxtc=;
        b=L/QSVVezt0cqXjQPE9US2gRjgmtfl+TAERp/86G+EX4lbcznP8MEdi7R6VAO5BqDDm
         HaLOlczk8i7EpxboZYhJYH9Jzyi0zXfu23mXgC5uKWRAVfRlPQQq0FvePJFmBLZiMHXp
         g0QSrHDDOAgYJr6MmJeY4ZrKe97ZK3Z5M077KhjitlCDXlfkSUDRE/aX4a2TVndvU+rR
         LQCGvJu9cXXjTf3isZx+6gJMAZ+GKV8qKuJQBK+LfmbcC62C1yRF7B7JmK16qF8Cv7dO
         yFoGbLPApoel6pgaZEiqDnxkqu7qRMSQvAlR6y93l4ZQLaZPEGrawB1lt3wLN+l2foZb
         H8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqIm8Zx3pH/8PTwn/CTBJTXMqgv5eudoeGRkjwQqxtc=;
        b=IaW/ZwQ7zRzjxgANYsdfW7j65M8suSSxpAla2R1WSHBb/0wfpezrKY/MhHxeHDoboi
         wAJByKsKDgQMvBSizoo1ie+3WRU8P16YIHFMpCty9I4diNOkZ0Q63gGhpgjlp3LvCM2M
         NQ0R0sSyTjEEtC/2uOkEkqh8Y3WXJ5IUBBJA6+KkbS3BzG9NdMiIzdJkBqNJ/hVjNyNP
         imZrkh/9eMHw8OSZ6ZcRyYxxqjJegH5VFYq0WqBuho/BSd+f8p79CLZZVUFrzdBtQx4J
         RV4IVifxnq9jEydDD/Ey8fFpkcctMMDbDCOO3ej9kM8DYcjWXsJHS24uUt5jUSSaCxCP
         jyag==
X-Gm-Message-State: AOAM530iiA8t6nz5kL9EE198vISYsSWjGMKW+CyzHPmiSbJLtOTuv14M
        7neqbfMqMD6WsQ522moFComZ5SKHre0rvjZUe0RPbg==
X-Google-Smtp-Source: ABdhPJwvlrI/hzUx9/Wrzz8E2F7f0aafIG816hhuftMtSl4WLttOCjFi/OIxxz3hEv+ZiFPmUfn3pFcWzmo29ZiWthM=
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr5595441eji.177.1627696006842;
 Fri, 30 Jul 2021 18:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn> <20210729093923.GD21151@willie-the-truck>
 <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com> <7574da60-fb71-dad2-b099-a815a0a18c22@redhat.com>
In-Reply-To: <7574da60-fb71-dad2-b099-a815a0a18c22@redhat.com>
From:   hev <r@hev.cc>
Date:   Sat, 31 Jul 2021 09:46:35 +0800
Message-ID: <CAHirt9jzXZbUc5bA6X_fHNNRAeTFWcykQyZk15Gnv1n5tUwCQw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Waiman Long <llong@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

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

Yes, you are right. The memory layout is adjusted so that
locked/pending and tail do ont share bits, so normal store
instructions can be used to clear_pending and
clear_pending_set_locked. It's faster than atomic.

Regards,
Rui
