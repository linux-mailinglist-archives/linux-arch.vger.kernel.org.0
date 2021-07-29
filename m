Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF63DA0F9
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhG2KSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhG2KSn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 06:18:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F4C061757
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 03:18:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id da26so7496018edb.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q21ODLUfYfZZXaZYE2CyrU4oAp6N6kYf6Hk6ch9e6pg=;
        b=2DJDMZo2Du/7RDlLbS/NWmQc2EYY2+27oCV5mpGVUwJ4bG25ANinbQ27msqIe9hXqC
         uJ8Dt2tbTOt5AvHKiShD0deKlVeVcuz6dj3yegP4d7smysyVHHHfJOHsrOuAyCC71T3a
         /YimQIjFZTPhVXo3wgS6KZfTE8MLRb77V5ZhAlbYFkdn6GpY0vIJ9Q++Cnlfb5KO/cq6
         oTeApCo9+WCLAaO99K65hw5Fru0Mto+CMo9KbolzPv+zwLAR76ksssbEtwKx4KAMjkSj
         xloTNRZYd45tI2lIzKlhR9l0LbK2X4x3g47UKB9twooKp8sgZxTYa5DGYrf50XSXAncA
         b+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q21ODLUfYfZZXaZYE2CyrU4oAp6N6kYf6Hk6ch9e6pg=;
        b=eadATvXncyZG59EqAegCA67I2NtKSQGWTxS9hDkoGw9MqKNLWPsad0GR+Hy1G+d+nM
         m4Nu1ZscruieYMX9u+edxYUxjjyymEr5xqltk/BdoIV3d/JiB23zajFY9rAfpyjTPWXF
         pThio93u9GUC20E0Z/4AXBDhijWfF8k0e9f/SGvyqgjc8btsjICGXirV9n/wMKgsCovu
         VFjLx3nojwCDzn4ywyhtLgPz9KCeypOAKaIXt3shBHHsBTd/V4F7C3/Umok5RZ25NuGy
         oIJgP413wslo6h8jdROw2dH3HbD8X/l/EUi4v6NO/YT1uwg893Ar8nY9fiJy3DA6oVn1
         vT4w==
X-Gm-Message-State: AOAM530FnmIazGQnKYVhnvgvcUMgTM7VmT55jSrYbVjesbOFBpe9vC8O
        DkQjPsd8w9f3IvzyLml1HteRJKxrNuf6Zz4QlvXcEYAdSRzRcilnhx7L4HquGK4=
X-Google-Smtp-Source: ABdhPJxR0w/F9MlQ94qW1H+ySICs1OGm38uhnc7DUHpMxm8EPLQ6KUE2iTG9bqZ8POfoNzUuk+DUwaUsgT7XPNITOVw=
X-Received: by 2002:a50:954c:: with SMTP id v12mr5106042eda.313.1627553919549;
 Thu, 29 Jul 2021 03:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn> <20210729093923.GD21151@willie-the-truck>
In-Reply-To: <20210729093923.GD21151@willie-the-truck>
From:   hev <r@hev.cc>
Date:   Thu, 29 Jul 2021 18:18:28 +0800
Message-ID: <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Will Deacon <will@kernel.org>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Will,

On Thu, Jul 29, 2021 at 5:39 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
> > From: wangrui <wangrui@loongson.cn>
> >
> > This patch introduce a new atomic primitive 'and_or', It may be have three
> > types of implemeations:
> >
> >  * The generic implementation is based on arch_cmpxchg.
> >  * The hardware supports atomic 'and_or' of single instruction.
>
> Do any architectures actually support this instruction?
No, I'm not sure now.

>
> On arm64, we can clear arbitrary bits and we can set arbitrary bits, but we
> can't combine the two in a fashion which provides atomicity and
> forward-progress guarantees.
>
> Please can you explain how this new primitive will be used, in case there's
> an alternative way of doing it which maps better to what CPUs can actually
> do?
I think we can easily exchange arbitrary bits of a machine word with atomic
andnot_or/and_or. Otherwise, we can only use xchg8/16 to do it. It depends on
hardware support, and the key point is that the bits to be exchanged
must be in the
same sub-word. qspinlock adjusted memory layout for this reason, and waste some
bits(_Q_PENDING_BITS == 8).

In the case of qspinlock xchg_tail, I think there is no change in the
assembly code
after switching to atomic andnot_or, for the architecture that
supports CAS instructions.
But for LL/SC style architectures, We can implement xchg for sub-word
better with new
primitive and clear[1]. And in fact, it reduces the number of retries
when the two memory
load values are not equal.

If the hardware supports this atomic semantics, we will get better
performance and flexibility.
I think the hardware is easy to support.

[1] https://github.com/heiher/linux/commit/f77e1c6e4e579543177010bef2b394479c50b6cf

Regards
Rui

>
> Cheers,
>
> Will
