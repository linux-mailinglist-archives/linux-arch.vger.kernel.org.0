Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB981441C5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUQMs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 11:12:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43944 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAUQMs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 11:12:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so3028865oif.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0oGkq5Pa6BFHnIeKryyeGImhC+iJMmb3104WkR55ys=;
        b=Fk/VjSwGo6GnY3If9r3BBaqW1BeNkMxKbSCn5mjEMyVclU3rQ3/ne2lWpRcEMJgza4
         jIYmyAjNm8MrTni/EjaAfJt95jEF/+6hOhSxUbyKVnI7PffuAMOrDaeKXIMEbq40Fnno
         Bws0lgNoPJJFPANsvWWyZRRtS9BdKjOJg88OIvvyeVTMJwFu2WYMVV7jOKkt7XlyKmYX
         DhS+DaOzT2wNmQF4Z2uKwzBVpfNnpn4NkF4z21jx2FplBKqiiTTKeSP9f0dTv7mdEp2b
         d6VrVr68fT7x0jmDN1KlV4NWZUNUXqDEVhV00y7RJ7pNcGmSVoJ9oX/xMQSf5qGoEARN
         rg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0oGkq5Pa6BFHnIeKryyeGImhC+iJMmb3104WkR55ys=;
        b=MekSsyF4bxX9us9uLzta6fdKelg6qOmbs6tT0jvg2Ip+fMerPN7O6xxWgCXnAGA975
         WFHBNryKEopSxSXHGqXZMDQgnQBjQ79ksdXHEi9DjzcPxgqkJ7hBWNDKVUavS5vO1nwf
         5+GuuCvP1vCbh0h97CEq8+RZuIo7pmkrnfsMCFyjwrHN6zJq7DST7bUHDw9RFtuH8rMY
         0krkDmQhgBGfyrrz4U3pZUkVC5i+WVikcfGm7btLiPM6qtMlGa++rsQdvn/FhiRL3tyw
         7mpUsN679tDVlnqUGgSwQjfXb2IzFnxj3WG8SARXGL8lhHWSZbafLIJb8O7IMtmyZsu2
         yErg==
X-Gm-Message-State: APjAAAXDyakmquZlZBYZQbkSmI7lvrBSzjvVzGmEDNAiuh19Njfsceez
        xpt7Ti4uo/D9ACh/6btn7xWDDyZEr/NyqMXtnt/MPw==
X-Google-Smtp-Source: APXvYqwqMngfefQgGxQ3H4Pw5AafxYDK/vfOwxFn9yLaQb9nfiuyLLjnlS286+QldnFKWDZc87i2Y3UTkGFU5aPJZcI=
X-Received: by 2002:aca:b183:: with SMTP id a125mr3673714oif.83.1579623167224;
 Tue, 21 Jan 2020 08:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
 <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
 <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
 <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com>
 <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com>
 <CANpmjNOUTed6FT8X0bUSc1tGBh3jrEJ0DRpQwBfoPF5ah8Wrhw@mail.gmail.com> <CAK8P3a32sVU4umk2FLnWnMGMQxThvMHAKxVM+G4X-hMgpBsXMA@mail.gmail.com>
In-Reply-To: <CAK8P3a32sVU4umk2FLnWnMGMQxThvMHAKxVM+G4X-hMgpBsXMA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 17:12:35 +0100
Message-ID: <CANpmjNMe4a8O9ztaVCVym36au9jaaCooUorYnFd0egUQSfn7gQ@mail.gmail.com>
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

On Mon, 20 Jan 2020 at 20:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 20, 2020 at 4:11 PM Marco Elver <elver@google.com> wrote:
> > On Mon, 20 Jan 2020 at 15:40, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Jan 20, 2020 at 3:23 PM Marco Elver <elver@google.com> wrote:
> > > > On Fri, 17 Jan 2020 at 14:14, Marco Elver <elver@google.com> wrote:
> > > > > On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
> > >
> > > > > > If you can't find any, I would prefer having the simpler interface
> > > > > > with just one set of annotations.
> > > > >
> > > > > That's fair enough. I'll prepare a v2 series that first introduces the
> > > > > new header, and then applies it to the locations that seem obvious
> > > > > candidates for having both checks.
> > > >
> > > > I've sent a new patch series which introduces instrumented.h:
> > > >    http://lkml.kernel.org/r/20200120141927.114373-1-elver@google.com
> > >
> > > Looks good to me, feel free to add
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > if you are merging this through your own tree or someone else's,
> > > or let me know if I should put it into the asm-generic git tree.
> >
> > Thank you!  It seems there is still some debate around the user-copy
> > instrumentation.
> >
> > The main question we have right now is if we should add pre/post hooks
> > for them. Although in the version above I added KCSAN checks after the
> > user-copies, it seems maybe we want it before. I personally don't have
> > a strong preference, and wanted to err on the side of being more
> > conservative.
> >
> > If I send a v2, and it now turns out we do all the instrumentation
> > before the user-copies for KASAN and KCSAN, then we have a bunch of
> > empty hooks. However, for KMSAN we need the post-hook, at least for
> > copy_from_user. Do you mind a bunch of empty functions to provide
> > pre/post hooks for user-copies? Could the post-hooks be generally
> > useful for something else?
>
> I'd prefer not to add any empty hooks, let's do that once they
> are actually used.

I hope I found a solution to the various constraints:
http://lkml.kernel.org/r/20200121160512.70887-1-elver@google.com

I removed your Acks from the patches that were changed in v2. Please
have another look.

Re tree: Once people are happy with the patches, since this depends on
KCSAN it'll probably have to go through Paul's -rcu tree, since KCSAN
is not yet in mainline (currently only in -rcu, -tip, and -next).

Thanks,
-- Marco
