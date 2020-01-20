Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CE142D46
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATOXg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:23:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37195 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATOXf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:23:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so28847988otn.4
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnn4KKkHt1EljhMT9CxicHtKv9oSHz/LL7W2XJ6R4BE=;
        b=Z/QAqXKhkQnUrpb+hI+53DRu6kDqnE+w9xmmPN4YoUerubfVB2WR6JMzQ3mJz9cQbH
         LideBY2IOx+BJVlFZUsnma1lZQJfcr6Kg+pLY/xZf4eISp/1ylSzHEMsPYWd/KcFWQ3S
         wrHfZj6dbCU/c8MXu9eAa8fN+oW6CmHUsX4TGeodRCUVzA/7DT/GK9w7uSCOl04hnC12
         HOs16UTTPfptMBrB8nPXLjCJs1ntcYAhUFc2mbsqbtzpbSAryYC4l/159I4ga/7cczhc
         A/BS2UZS1V2fnFDMRJ02FK+54ZMb/p/Kk8WM2MWKtEKxJpe30SIxauSjIwE57zSFTpnE
         Iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnn4KKkHt1EljhMT9CxicHtKv9oSHz/LL7W2XJ6R4BE=;
        b=EocQV++Ew97ecs/ZE83nzSgiEtACLTw/UYsrwe9azpxIo2DpeN0E6867KJriWUE40H
         Py5s4uqaZkrUhXBCvxL3EcLRDCrZt6nliz1QBBa+fJP2F0M0WJQFnjbNYhfPCpUolEPC
         tLBJ2HZzmJ//FglBiah7RHkgdGaOy0nAQkqfKg+02iqrBgaBD9CLJq5GJ/Bsw2LbdKPj
         TtgGGxuuK1eKicPvgFcbxhXsEb4eZY5MBwfb2vs9rt5x8xkLJUA/QDpfPlmGRtA9M0o9
         05q+wroQqxvQhNoCwzP+5yzm9pFojGs5m8L63r5WxBy5972cMweuF2ZUbVOKOKO0RFgo
         e+5g==
X-Gm-Message-State: APjAAAW0DH/Jg+s6Dy6DGdqhzW97eHI9ZUACtLNX/OTgFF/ghIKEvNy4
        yowbLt8KgC5YtEwilC9/TMmkEOcPeFv5Y5U79aNblw==
X-Google-Smtp-Source: APXvYqxOOKWrDtxXbMNrSjzwDWgHr5x/Rbu/3eVl2qJzSvBh1Z3fza5fTtePRCaaRAiuXUv6TT88BF1UAwh9j96+taE=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr16933059otq.17.1579530214919;
 Mon, 20 Jan 2020 06:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
 <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com> <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
In-Reply-To: <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jan 2020 15:23:23 +0100
Message-ID: <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com>
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

On Fri, 17 Jan 2020 at 14:14, Marco Elver <elver@google.com> wrote:
>
> On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
> > > On Wed, 15 Jan 2020 at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Wed, Jan 15, 2020 at 8:51 PM Marco Elver <elver@google.com> wrote:
> > > > > On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > Are there any that really just want kasan_check_write() but not one
> > > > of the kcsan checks?
> > >
> > > If I understood correctly, this suggestion would amount to introducing
> > > a new header, e.g. 'ksan-checks.h', that provides unified generic
> > > checks. For completeness, we will also need to consider reads. Since
> > > KCSAN provides 4 check variants ({read,write} x {plain,atomic}), we
> > > will need 4 generic check variants.
> >
> > Yes, that was the idea.
> >
> > > I certainly do not feel comfortable blindly introducing kcsan_checks
> > > in all places where we have kasan_checks, but it may be worthwhile
> > > adding this infrastructure and starting with atomic-instrumented and
> > > bitops-instrumented wrappers. The other locations you list above would
> > > need to be evaluated on a case-by-case basis to check if we want to
> > > report data races for those accesses.
> >
> > I think the main question to answer is whether it is more likely to go
> > wrong because we are missing checks when one caller accidentally
> > only has one but not the other, or whether they go wrong because
> > we accidentally check both when we should only be checking one.
> >
> > My guess would be that the first one is more likely to happen, but
> > the second one is more likely to cause problems when it happens.
>
> Right, I guess both have trade-offs.
>
> > > As a minor data point, {READ,WRITE}_ONCE in compiler.h currently only
> > > has kcsan_checks and not kasan_checks.
> >
> > Right. This is because we want an explicit "atomic" check for kcsan
> > but we want to have the function inlined for kasan, right?
>
> Yes, correct.
>
> > > My personal preference would be to keep the various checks explicit,
> > > clearly opting into either KCSAN and/or KASAN. Since I do not think
> > > it's obvious if we want both for the existing and potentially new
> > > locations (in future), the potential for error by blindly using a
> > > generic 'ksan_check' appears worse than potentially adding a dozen
> > > lines or so.
> > >
> > > Let me know if you'd like to proceed with 'ksan-checks.h'.
> >
> > Could you have a look at the files I listed and see if there are any
> > other examples that probably a different set of checks between the
> > two, besides the READ_ONCE() example?
>
> All the user-copy related code should probably have kcsan_checks as well.
>
> > If you can't find any, I would prefer having the simpler interface
> > with just one set of annotations.
>
> That's fair enough. I'll prepare a v2 series that first introduces the
> new header, and then applies it to the locations that seem obvious
> candidates for having both checks.

I've sent a new patch series which introduces instrumented.h:
   http://lkml.kernel.org/r/20200120141927.114373-1-elver@google.com

Thanks,
-- Marco
