Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9E13CE42
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAOUuV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 15:50:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39490 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgAOUuU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 15:50:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so17351599oty.6
        for <linux-arch@vger.kernel.org>; Wed, 15 Jan 2020 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0hOUZCXUZrxkCJ9AqKR7AVN+IgQDsfD1fDkF1X5WSk=;
        b=RME5cH1b7bsbFi/neSvu8LJzKmtkFaTqf4Tzy85FaxdPmfqxVx2MGdQO/KT+oReYK0
         W1wJnWv9txH8tg0T0f7d/HbMkylVjDoxHHcb8RGZSVagfQrSWy4TeiawcuJGTX3LswJr
         hNCIwU+5VxiZ7vnuwA+kd6NOyAXHqh72zwZZF4jhZf18q6YXGjvuc7BzrDhKKW9re81C
         4uI799CZWFqEQ9Wd2GS2RQrc//9QjgVAR4eIDkNm7HBgp9gt0dJHUuI/gjrr3gkgsFun
         Bg+4FeITtAJOnln+cmzvDEuS8Q2ttNqL/cgTdeTaGNTzjVyiGGBs1GlemC3mMAX8ohIH
         e5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0hOUZCXUZrxkCJ9AqKR7AVN+IgQDsfD1fDkF1X5WSk=;
        b=IzdJbnCvWMAttnR+0+QoBdRDaFVATfkE85pzj/WEPaaCyzllB5utYtjGmA3QezpSEO
         2O8R1Uaqb8ejdE8Q7kdMUp6twX8hb3ygXyd78n4QcYks4rlgBk4BU/LcoZud45GONa7w
         bBmZLctNl2DZrNY5Hpg+zYHgKqIfwhSNQiYLm42CKZK7dh7aAhNHIVb/pMm/ekhcoX8y
         2i94wQEt/GFII4p0cvZakgPncp9KQF67bCOSQiO/DcguiQRu3osCkAGPfLZf7i48hf5k
         2dO2XAPSFX5aTOx+fBUZDZXv+HLMs2B0CB2o7q9Nl0YYIYZw/+Axl9VQvm4sWMD5y2kp
         UigQ==
X-Gm-Message-State: APjAAAVbo466cYfPbOS1WsIns/Un7X+dB7aoSQ53FXbqEJJKlpGAOvGP
        G+BkHzDEuYqJB0fFToIM39M+ixzAms2pAgoM43Z7/g==
X-Google-Smtp-Source: APXvYqxC0L7ZaNfNvnujgl/KIkaCRoeeVX3a1EoLRfdO+405XepvJRRvoSAQTn+F+u2JtO7XJn7acrwUQNpnaIGKr54=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr4203681otk.23.1579121419529;
 Wed, 15 Jan 2020 12:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com> <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Jan 2020 21:50:08 +0100
Message-ID: <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 15 Jan 2020 at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 15, 2020 at 8:51 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
> > > >   * set_bit - Atomically set a bit in memory
> > > > @@ -26,6 +27,7 @@
> > > >  static inline void set_bit(long nr, volatile unsigned long *addr)
> > > >  {
> > > >         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> > > > +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> > > >         arch_set_bit(nr, addr);
> > > >  }
> > >
> > > It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
> > > next to almost any instance of kasan_check_write().
> > >
> > > Are there any cases where we actually just need one of the two but not the
> > > other? If not, maybe it's better to rename the macro and have it do both things
> > > as needed?
> >
> > Do you mean adding an inline helper at the top of each bitops header
> > here, similar to what we did for atomic-instrumented?  Happy to do
> > that if it improves readability.
>
> I was thinking of treewide wrappers, given that there are only a couple of files
> calling kasan_check_write():
>
> $ git grep -wl kasan_check_write
> arch/arm64/include/asm/barrier.h
> arch/arm64/include/asm/uaccess.h
> arch/x86/include/asm/uaccess_64.h
> include/asm-generic/atomic-instrumented.h
> include/asm-generic/bitops/instrumented-atomic.h
> include/asm-generic/bitops/instrumented-lock.h
> include/asm-generic/bitops/instrumented-non-atomic.h
> include/linux/kasan-checks.h
> include/linux/uaccess.h
> lib/iov_iter.c
> lib/strncpy_from_user.c
> lib/usercopy.c
> scripts/atomic/gen-atomic-instrumented.sh
>
> Are there any that really just want kasan_check_write() but not one
> of the kcsan checks?

If I understood correctly, this suggestion would amount to introducing
a new header, e.g. 'ksan-checks.h', that provides unified generic
checks. For completeness, we will also need to consider reads. Since
KCSAN provides 4 check variants ({read,write} x {plain,atomic}), we
will need 4 generic check variants.

I certainly do not feel comfortable blindly introducing kcsan_checks
in all places where we have kasan_checks, but it may be worthwhile
adding this infrastructure and starting with atomic-instrumented and
bitops-instrumented wrappers. The other locations you list above would
need to be evaluated on a case-by-case basis to check if we want to
report data races for those accesses.

As a minor data point, {READ,WRITE}_ONCE in compiler.h currently only
has kcsan_checks and not kasan_checks.

My personal preference would be to keep the various checks explicit,
clearly opting into either KCSAN and/or KASAN. Since I do not think
it's obvious if we want both for the existing and potentially new
locations (in future), the potential for error by blindly using a
generic 'ksan_check' appears worse than potentially adding a dozen
lines or so.

Let me know if you'd like to proceed with 'ksan-checks.h'.

Thanks,
-- Marco
