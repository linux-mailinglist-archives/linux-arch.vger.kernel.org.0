Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F77DBF12
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfJRH4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 03:56:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41379 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfJRH4V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 03:56:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id c17so4826880qtn.8;
        Fri, 18 Oct 2019 00:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY1G0/yn16ArZBtqvQScBpBfrsscfyVlVeCKpk0ztE0=;
        b=ppMS4EgkbQCu4Ftg+H2sTl8/oJeBmtMV/mKEyFimjtyYY/jWHxL4RXi21IsvceWzM7
         a+ggl0Cn/F23owlpY4yC4mHYAjRbdncvszhs2OCH0zQs4B30P+LhSyNZ520Uhzy3DW/N
         yRkDOxQ63nkRRZE1b7oNIgpbpqqjug81r+bAvzpgLhox7KWGoPgg+wv7U5zLQr2LDQXX
         ARaixkEHh/uoJBJOAW3VR2cgCs6KWScJHmfwTDBQyRJvfACCh8XIVcvRSi9CE0XdphzS
         2GYdZPF8ogE/NmLc/j9hnmc07NBWstegSLBrkAuBg+ZoxCoJbGPQizHplwZQovWJ2CAL
         bsEg==
X-Gm-Message-State: APjAAAXM/KB44Z7aUX2QmweGjeban65t7saOpHSUgdNMQeI/uicdYXpw
        iCFH6qaF1uXoVx8/9+ri707IeJ/RGUDJwxZQMRM=
X-Google-Smtp-Source: APXvYqzuTHL+lWB7kNHWKCYHrIEqA6OGdUaJieGajzMblwm7UOwQmR7aBZ7i31ZG776CwBptw054wM34wOteHd+PfxQ=
X-Received: by 2002:ac8:38e3:: with SMTP id g32mr8557662qtc.304.1571385379824;
 Fri, 18 Oct 2019 00:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de> <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
 <20191017153755.jh6iherf2ywmwbss@box> <CAK8P3a1TrOippPUh6Fc_McHcp2LOerdD6ifmcieuy0bAFPvs8g@mail.gmail.com>
 <CAHk-=wh8MsquobFL5TC0yUkG-9yFUZZnikMPA8QHLc7fcyND6w@mail.gmail.com> <20191017161617.zj7u6p642mytpzts@box>
In-Reply-To: <20191017161617.zj7u6p642mytpzts@box>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Oct 2019 09:56:01 +0200
Message-ID: <CAK8P3a0YLeqm71TNzTwJ0FwQKW4Ji0etA+6U=08Exk7fibyBQw@mail.gmail.com>
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Pinski <apinski@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 6:16 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Thu, Oct 17, 2019 at 08:56:50AM -0700, Linus Torvalds wrote:
> > Yeah, that's certainly less than wonderful.
> >
> > That said, there's no way in hell we'll support gcc-4 for another 7
> > years (eg Suse 12-sp4), so at _some_ point the EOL dates aren't even
> > relevant any more.
> >
> > But it does look like we can't just say "gcc-5.1 is ok". Darn.
>
> I don't read the picture the same way. All distributions have at least one
> major release with GCC >= 5.
>
> The first release with gcc >= 5:
>
> - Debian 9 stretch has 6.3.0, released 2017-06-18;
>
> - Ubuntu 15.10 wily has 5.2.1, released 2015-10-22;
>
> - Fedora 24 has 6.1.1, released 2016-06-21;
>
> - OpenSUSE 15 has 7.4.1, released 2018-05-25;
>
> - RHEL 8.0 has 8.2.1, released 2019-05-06;
>
> - SUSE 15 has 7.3.1, released 2018-06-25;
>
> - Oracle 7.6.4 has 7.6.4, release 2019-07-18;
               ^^^ Oracle 8
>
> - Slackware 14.2 has 5.3.0, released 2016-07-01;

For /most/ of these I see no problem, but RHEL 7 / Centos 7 /
Oracle 7 and (to a lesser degree) SUSE 12 must have users
that want to build new kernels for some reason without a trivial
way to install new compilers.

OTOH, I agree that requiring a much more recent compiler has
some advantages that may outweigh these troubles. glibc has
moved to requiring a 3 (!) year old compiler or newer, which gives
them a reasonable time frame to make changes to gcc and then
build on requiring these changes.

      Arnd
