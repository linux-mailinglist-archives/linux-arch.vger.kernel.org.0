Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123441409B0
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 13:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgAQMZ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 07:25:28 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQMZ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jan 2020 07:25:28 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MWzbr-1j7c350Z3p-00XJui; Fri, 17 Jan 2020 13:25:26 +0100
Received: by mail-qt1-f179.google.com with SMTP id c24so10803933qtp.5;
        Fri, 17 Jan 2020 04:25:25 -0800 (PST)
X-Gm-Message-State: APjAAAWyaVFUwC5jlUfW53w8lKga2KoOlHdbgK8Uvhppn6zesp0lu21m
        rN8GSRZgEuAZaL6v1gOCjlUa1M3Hh+a8jYb9sBc=
X-Google-Smtp-Source: APXvYqwqCzWv/ekQUEFKtBDinI/LcXB9oWkR28qFdPoljphngkJVa3HxtAlT8kKFFOKWjYiGgHg5a4mRNSgW5hf1vUA=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr7117054qtr.142.1579263924900;
 Fri, 17 Jan 2020 04:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com> <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
In-Reply-To: <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jan 2020 13:25:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
Message-ID: <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Marco Elver <elver@google.com>
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
X-Provags-ID: V03:K1:BjvcfnJXNixwEFNEYwkAPuoYZO1yKIZ6+zO3O5pD8DBedJuN2zp
 2SCMTsFDi2yWr5pRYLEWvYCQ1qlmM2GEVld4rFlruaRYyoo1uV+ojxGtMsSaF7iDAZxfeZC
 gz4O3ryNAyywBE9gdeobFaEa8Q94oiplOzJKO9y8uVokMW3ERhRDut3U7O21Sy1a0vgaBOe
 uCrCZkfAF6+Xiz79dqXfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PaLNvZoTouE=:9XtH0rnAaNZeZK2j1cP5BF
 kjDaDm4S6x9OHMSZkOkJ379ncvmgEIlKnThnpd5m3b71AVJkhn7hRjpco7eMO7E4FYv875C2M
 AWsRjzhfx9UvWLbcgi5DTUU1iGxQEB4Jpgw02n8yD7/TQYFtqwUiLNE/ec9zTHnAjHn1FWSQK
 TWmOqaxhQ0vOcMOCxvCUyBu1CGdAMmF43xLK/rIvcIY7Rx4Pp5uJWoNp27bdgiAQObo/xrcH3
 gPItH+kdOg031rzeLVK0dZwtju8C0ZpYoo51pSAb00GjdW/ESWZMAQ91xewQZPNUXyHeEBAAy
 WIx2288bvNqGETXTqNHO6tOGmR90wRww4ohrZkCnD+mLs7MQ08kqRBTuFtJdkzvouig/VIE8i
 oNs6gIoLpVmsvHfloKe6KhITdgiJgLiwvcb3PhE7DnEoxxpTiiOMcMvfmu1Ubw1hSxNW7BRI7
 VqIqQywbA1GCikYWh1NV77aRckpEWmeRa0EhJha3nlkdzChOtDEi2EYQ8kLfxKvGcOBdiWuCK
 EtL3KWG9emdLNyFhUGAxC/WfuoLklQ0ocCDvs2UPXmzIseWwfYhdcnRwR3q9yXNHEYIgN6mky
 gydikyoVbacD6Dd+pgJCf9KP7TYYyq/xQhEwXPs+WG6dyFvx6FeIYx2eVDZdurkaa0GztCX91
 Qt8WsM5V76UJ3oDeSOPhu2SSJQ/KhP8JcKtmOOaooUxneXCz/xcl7EOIn5iS8lo6h7pxpCHL3
 8KgC0P+P21zS/RSgdG6vM+IOEVpMQ0ibrQIwGwd0FKoCmulgvShxSw/LfoEpBKwTPdFXTOuzH
 T7RNVORRjaWU6vVuUBFKhh1Bv8sHHONKFE4DNdjCpZU6lEN15+hMTunekVBQ2t/WjFBaOO6b+
 hr45UtFhNiw3AbKQ83ag==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
> On Wed, 15 Jan 2020 at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Jan 15, 2020 at 8:51 PM Marco Elver <elver@google.com> wrote:
> > > On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > Are there any that really just want kasan_check_write() but not one
> > of the kcsan checks?
>
> If I understood correctly, this suggestion would amount to introducing
> a new header, e.g. 'ksan-checks.h', that provides unified generic
> checks. For completeness, we will also need to consider reads. Since
> KCSAN provides 4 check variants ({read,write} x {plain,atomic}), we
> will need 4 generic check variants.

Yes, that was the idea.

> I certainly do not feel comfortable blindly introducing kcsan_checks
> in all places where we have kasan_checks, but it may be worthwhile
> adding this infrastructure and starting with atomic-instrumented and
> bitops-instrumented wrappers. The other locations you list above would
> need to be evaluated on a case-by-case basis to check if we want to
> report data races for those accesses.

I think the main question to answer is whether it is more likely to go
wrong because we are missing checks when one caller accidentally
only has one but not the other, or whether they go wrong because
we accidentally check both when we should only be checking one.

My guess would be that the first one is more likely to happen, but
the second one is more likely to cause problems when it happens.

> As a minor data point, {READ,WRITE}_ONCE in compiler.h currently only
> has kcsan_checks and not kasan_checks.

Right. This is because we want an explicit "atomic" check for kcsan
but we want to have the function inlined for kasan, right?

> My personal preference would be to keep the various checks explicit,
> clearly opting into either KCSAN and/or KASAN. Since I do not think
> it's obvious if we want both for the existing and potentially new
> locations (in future), the potential for error by blindly using a
> generic 'ksan_check' appears worse than potentially adding a dozen
> lines or so.
>
> Let me know if you'd like to proceed with 'ksan-checks.h'.

Could you have a look at the files I listed and see if there are any
other examples that probably a different set of checks between the
two, besides the READ_ONCE() example?

If you can't find any, I would prefer having the simpler interface
with just one set of annotations.

     Arnd
