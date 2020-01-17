Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442EC140A80
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAQNPB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 08:15:01 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40244 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAQNPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jan 2020 08:15:01 -0500
Received: by mail-ot1-f47.google.com with SMTP id w21so22446208otj.7
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8YqwuFYQqcgYYrogodMJhZN7j+MHKf9rIlBL0O/Le8=;
        b=phe1Ud2oxwDPz6N0qGWXhYFzGha1cekzFvcn3g626qlUYghuyTbxgeFkLbD/M/5L2u
         FDYTHp9qH37eL4oqnFRBAXta5mf/ffxwB4CRYjCptTn0qENxhEnuJ6sd/k/c5WjQtL3l
         CZK7j9ZJcq40q1mQa/jNGhIl8VicJfvINi+VTqNF9qMX85UYRNemMrGHv6Y80fNbk6dg
         S9PPuTsUhR6lSiS6eVa+Gbu3kWZBLzmYXabHgR1/Uj8EbZ/xevu89+zvdF3lhTPSyKkD
         PaFZsgRegpuHk3NdVQ+8Daz+cDXqVbLvfaHQH+1GTrWlCrdFvn5XQvguxBKRfdkeZq/s
         GNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8YqwuFYQqcgYYrogodMJhZN7j+MHKf9rIlBL0O/Le8=;
        b=Pkbh4gtgp+21/UxwgkeipWEg2eXwnKwMMhK/LtEH8xPJtZFW+zl5zvmjsaNBGWP8Qv
         VhfOl+XLMBZHJjoam/3ZAu70znVL7QFjn/dYN4D9jWz3bifssNTwvel3F0+7fKoO9EI7
         zKKpZbLlmEzg5oZSHKLzItDyWw+dxjhivJ2+ins8PCEFYntzvV+d6Dko+t2gfgytFCbM
         e9QKWykrX7w0AP7sorvsJTTVfj9TuDNn2Eg7QebcFYZ1UUFLtyHWhtPYNJw+TvTexZKG
         MrWoXlwDv0DbBy/NjFV6jwpHPFdw1PmF2rnHgeGLh7FjGudu+emAuPs+qUNkArwKYl8Z
         5p9w==
X-Gm-Message-State: APjAAAUCwXdw3OkYuAN1ao0z3tbg6z32R7RH5QqfY+pir/vKKzxzHbaQ
        kHarNxkgUrh4WYJKLwMyJAbqtVF6mnMnV/0GtgjstA==
X-Google-Smtp-Source: APXvYqynE9NXU66Nq3blnE6X5VRCzGBBlylly2otE6jy/NdZxB8n4qYZlqLeRV0gBLCzSb/O+tcyFH8cZEHX5B05W4k=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr5863094otg.2.1579266899985;
 Fri, 17 Jan 2020 05:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com> <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
In-Reply-To: <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Jan 2020 14:14:48 +0100
Message-ID: <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
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

On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
> > On Wed, 15 Jan 2020 at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Jan 15, 2020 at 8:51 PM Marco Elver <elver@google.com> wrote:
> > > > On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Are there any that really just want kasan_check_write() but not one
> > > of the kcsan checks?
> >
> > If I understood correctly, this suggestion would amount to introducing
> > a new header, e.g. 'ksan-checks.h', that provides unified generic
> > checks. For completeness, we will also need to consider reads. Since
> > KCSAN provides 4 check variants ({read,write} x {plain,atomic}), we
> > will need 4 generic check variants.
>
> Yes, that was the idea.
>
> > I certainly do not feel comfortable blindly introducing kcsan_checks
> > in all places where we have kasan_checks, but it may be worthwhile
> > adding this infrastructure and starting with atomic-instrumented and
> > bitops-instrumented wrappers. The other locations you list above would
> > need to be evaluated on a case-by-case basis to check if we want to
> > report data races for those accesses.
>
> I think the main question to answer is whether it is more likely to go
> wrong because we are missing checks when one caller accidentally
> only has one but not the other, or whether they go wrong because
> we accidentally check both when we should only be checking one.
>
> My guess would be that the first one is more likely to happen, but
> the second one is more likely to cause problems when it happens.

Right, I guess both have trade-offs.

> > As a minor data point, {READ,WRITE}_ONCE in compiler.h currently only
> > has kcsan_checks and not kasan_checks.
>
> Right. This is because we want an explicit "atomic" check for kcsan
> but we want to have the function inlined for kasan, right?

Yes, correct.

> > My personal preference would be to keep the various checks explicit,
> > clearly opting into either KCSAN and/or KASAN. Since I do not think
> > it's obvious if we want both for the existing and potentially new
> > locations (in future), the potential for error by blindly using a
> > generic 'ksan_check' appears worse than potentially adding a dozen
> > lines or so.
> >
> > Let me know if you'd like to proceed with 'ksan-checks.h'.
>
> Could you have a look at the files I listed and see if there are any
> other examples that probably a different set of checks between the
> two, besides the READ_ONCE() example?

All the user-copy related code should probably have kcsan_checks as well.

> If you can't find any, I would prefer having the simpler interface
> with just one set of annotations.

That's fair enough. I'll prepare a v2 series that first introduces the
new header, and then applies it to the locations that seem obvious
candidates for having both checks.

Thanks,
-- Marco
