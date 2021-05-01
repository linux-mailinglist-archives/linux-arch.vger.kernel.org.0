Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2D3707DF
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEAQ1V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhEAQ1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 12:27:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92210C06138C
        for <linux-arch@vger.kernel.org>; Sat,  1 May 2021 09:26:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v24so1254439oiv.9
        for <linux-arch@vger.kernel.org>; Sat, 01 May 2021 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64NGINXN7ynqOlzs0BXPYhgqQOU3tvwvuitkM9gE7fk=;
        b=ZOy4ilx8G6e/EJLATpOC/TY/fj94iX8L+cJ9hsNgXo2Fwdw1iGCYFuJEtRcc8/4UsI
         3MDk5B6mxWDQuvRwmUkpVPa36usLK7yRP0rwQ25RDhqsA016eNkML3Uf92soKyMHPpK5
         HvbnVIEPJ339ufd7qHJbUdQWNgYAoUnaRNJBREhUkPl0m0wqrFS+U6A+Wf5OFWlACIen
         CiPQ7B/FlCGlplOU708S9fT01eLuThQFIsksO8AMlFq+nBhn8YcEpPCQU7Ooqg550ROE
         44vcQnb7GJK3P8in+Cb6BbsdwDrG62T2Yw3LbRiUDeaTrxe4/StG3eL4Trd+iWfdBUKc
         Ffow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64NGINXN7ynqOlzs0BXPYhgqQOU3tvwvuitkM9gE7fk=;
        b=NPfzUbcWgEC+SuAiIAMwsfisqfGr7DRGo3ZJvpJp9y64uimT20HkTDABZ36CRPLTCS
         Iil9K7hzKt/a5JKLshGSsFXwER9u3efouUFl81bVoTS5aZhtIPvOF1sZxJC1kQ8XC2xk
         3T5XeDgAwldf7ApSOvVEt6xk4Z9O8eoNcsio+4GrpskbXOtN9JMBNeeBNSOL2hZvP/Sx
         kIM6Nb+aXPn9+ApWhpCEM4iwku1Uq9DCyuD9jTk3Ol2ybLIXtHcYQ8xp8f2hbjABfYum
         ZLqW5vLTlg0oO4ACHRPIGnW6mj6ZmBIj8VxVHKgybRmMOR/dXayXS0l737s9DeA4bC2C
         L/PA==
X-Gm-Message-State: AOAM533UHB60X2aohFcQ00Xlcq86SRuNUB5kEc829UmPx2QiJ0WoQ9Te
        9Vbdu/ImDtviKtnc5Evs8T3UrjTuxYW8QizszLa2fQ==
X-Google-Smtp-Source: ABdhPJwK3vxrHpc74PcP54SlShb5rcBnkDMbWtN/Ywx+yZThHR0NVpaPVicFg1bqnl0bVxyrrx7FOb+J1Ci4wM4Z36I=
X-Received: by 2002:aca:408a:: with SMTP id n132mr8271992oia.70.1619886388654;
 Sat, 01 May 2021 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org> <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
In-Reply-To: <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 18:26:17 +0200
Message-ID: <CANpmjNMtM7JyxTiA-QpEmqd0MuQ+uZTjfZ3+_r4D=rrGpFU8RA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] signal: Move si_trapno into the _si_fault union
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 1 May 2021 at 02:37, Marco Elver <elver@google.com> wrote:
> On Sat, 1 May 2021 at 01:48, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Well with 7 patches instead of 3 that was a little more than I thought
> > I was going to send.
> >
> > However that does demonstrate what I am thinking, and I think most of
> > the changes are reasonable at this point.
> >
> > I am very curious how synchronous this all is, because if this code
> > is truly synchronous updating signalfd to handle this class of signal
> > doesn't really make sense.

Just a note on this: the reason for adding signalfd support was based
on the comment at SIL_FAULT_PKUERR:

>                 /*
>                   * Fall through to the SIL_FAULT case.  Both SIL_FAULT_BNDERR
>                   * and SIL_FAULT_PKUERR are only generated by faults that
>                   * deliver them synchronously to userspace.  In case someone
>                   * injects one of these signals and signalfd catches it treat
>                   * it as SIL_FAULT.
>                   */

The same would hold for SIL_FAULT_PERF_EVENT, where somebody injects
(re-injects perhaps?) such an event. But otherwise, yes,
non-synchronous handling of SIGTRAP/TRAP_PERF is pretty useless for
almost all usecases I can think of.

Thanks,
-- Marco
