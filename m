Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B62142DC9
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATOko (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:40:44 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:48971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:40:43 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MtwIW-1jlNEj1lTI-00uJVG; Mon, 20 Jan 2020 15:40:41 +0100
Received: by mail-qt1-f169.google.com with SMTP id j5so27789296qtq.9;
        Mon, 20 Jan 2020 06:40:41 -0800 (PST)
X-Gm-Message-State: APjAAAWWUVkvHT5TfZgy52jq18mGWJidgpkgXO8XYKDc1PwZsNlzwDuU
        18tTSXq324HgXJIBJotCKHCSk4/WZQHuBN8OX1o=
X-Google-Smtp-Source: APXvYqwlJD70ajHpB5Hah/6j7f+OlCjqmONfTPtRbJ4dpF1nsMv085cDc0EQwsp/ZRY/JU1VKqkOA190gl56WM/HXj0=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr20880033qto.304.1579531240224;
 Mon, 20 Jan 2020 06:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
 <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
 <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com> <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com>
In-Reply-To: <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jan 2020 15:40:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com>
Message-ID: <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com>
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
X-Provags-ID: V03:K1:PtJv3kaT6WeF8q47kRkJGHyTOmhr/ZA6iNqmXick9+yEcmYcF6o
 1K5RtCoZ1qawiPjEgEKA8Pj28VueEwQp/mWQRT1hd/fgBS55lJkdu6hRN17llosEwVYd5Qh
 ncOQAQXQ+BZDg5ehmF5RTm5k5vVB9XkmVYlI18yFv/5IToCHTcTQ8k4EAVQaEXJZOo/mbac
 i0AMsiTFj6Edx8/bw1gtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X7jY2ZKncM8=:eWcXadgB+KBESQgs1iA7Ja
 0Po822eZ56ugoG1YILUf1MCwkdWT3rTqwM9wvolRj2R2G6b7AeibEZ7GTZvaGpj1daqkbouad
 mToZozQE+Qy7IzjsH7bvBPjHHZWIaG915AIFcgr5Mnz5XVEG0SafLJgLCIwBCLfKeKZHZj/jn
 S+1xzjNgr/wmWqoemMemTW2e0ObuG2jyRW3cUQQ+0hEgVQyfezftpauWsypJ3cqftRA3TZGbX
 od4vmTDrtMkHFGwek881jnrc1vXUY7B3nVy/+VeKvXbJ0xHc+ebpJ8m1yt+dwJeAd0WgcTVi0
 jBu7Gp9ZS2aIg1W9hs7q9a/cjt81T8GGbJDx0tj5E83O7W/VbAuGXYSlC0XQUrrDwfII+kwgI
 Mh4X0U7D8O4ZzLgFPDqws9tp5R2lNAqdjmaVeuVfaArFxJXMXqCcElRXHIIl7XazxJr/Y4wmz
 zpEWKMfcrAYB7HNIonb6vqegzQn+FWTJBsxOF9ug0SUPMkf5U+4gg6fef26XoIyimCUvxLPw8
 mmyiPOGsSi/karTyXbTwc9woz6pFvE6upBp6X3v1iOZLFAUVz/HdXo9I6alN3lBWZz26Gh1A/
 bQagIwaxUj79gIVXTommcmGMon/hWYAMHfTYQCCF1Bl5IwmHiu0814k+UIwgj4+NrxKCoAtFY
 brTM9Qx2tI6vVKKaR81wmr7LwjjISdhHkdDe1gMrlshEyZjwAo8wESJyHJ+JXMgiuoZ9Cf/mq
 ub0pmb6V6zGJUwmh9IW3KrWBevwm9gTLSB9sDmjCoPZ0+6NjlUJxk315I3Sk3RViCdtLxXOBl
 zfbOuqy6n8IL0Y55ygvLeGZe5irRsboHSDuw/MbPQpZwPnSDt46w/z6xKJOhILbmxv97RCwrw
 Oh906AwY6p5DF6xJdAVA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 3:23 PM Marco Elver <elver@google.com> wrote:
> On Fri, 17 Jan 2020 at 14:14, Marco Elver <elver@google.com> wrote:
> > On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:

> > > If you can't find any, I would prefer having the simpler interface
> > > with just one set of annotations.
> >
> > That's fair enough. I'll prepare a v2 series that first introduces the
> > new header, and then applies it to the locations that seem obvious
> > candidates for having both checks.
>
> I've sent a new patch series which introduces instrumented.h:
>    http://lkml.kernel.org/r/20200120141927.114373-1-elver@google.com

Looks good to me, feel free to add

Acked-by: Arnd Bergmann <arnd@arndb.de>

if you are merging this through your own tree or someone else's,
or let me know if I should put it into the asm-generic git tree.

     Arnd
