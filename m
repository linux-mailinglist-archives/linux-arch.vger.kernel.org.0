Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41C113CD83
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 20:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAOTzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 14:55:19 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:36717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgAOTzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 14:55:18 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMGZS-1j7gwt0pQk-00JKd2; Wed, 15 Jan 2020 20:55:17 +0100
Received: by mail-qk1-f174.google.com with SMTP id j9so16912917qkk.1;
        Wed, 15 Jan 2020 11:55:16 -0800 (PST)
X-Gm-Message-State: APjAAAWzTVwB+8LeCo1oUefiWbdXJ8vV7Y2R5UEOdPHA57TyfJhhhKIU
        DUHxK09GMUxiBriMcP2og8zcI4aG6ttI+uB7oW0=
X-Google-Smtp-Source: APXvYqwNXRuvxZtfyWD4Lv1+kexNUrgZsyRd8ZZkl5luzpZ9rX5jw6Lgbl//5M6HLTFI7FRTaqwXbcTtc0FbbBxmVyQ=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr28707027qkh.3.1579118115977;
 Wed, 15 Jan 2020 11:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
In-Reply-To: <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 20:54:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
Message-ID: <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:EIYVO01nH7dXMlyB7brsVXLeqn6IhJaCYfKy1Ln59kM8u/zX+UK
 dJ4Jb/bHKfByxszZMnBADsGxJRbCdC2w01imj/jme4hZ5IWtWATtFAm9K9yp/XPXclbKqzD
 BPgdDclRh9rNoHTMkC6jx4kA6HEb60IbIm7UhoHYY3Zo59DICObFWCpf5Kj1dipHZJZfwTT
 jaflKNUMlPX1NsSXRbHeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0wvOG99EVkQ=:Sn2dM/xvzKyl+7WeaJkLTn
 KrbZS7+ZWIOXihof8HHwRXZv5S89Lpu1GK9cCPyi4gPO7uRUWcOmFxNSRFA1UP24KYXLpMS1i
 2xoHRIKmbQxjbFFaT/x4v5ug2XoIvzsO0ERFkBMDUGDXRgDpMA/ksceYpE5ZeHoOhzVNAelzG
 0g4bOenER1FH+7GBhuOXzu+n0MaYmcustsZhEW9BF/jexMmzOYHEMLOg3dZ3riTL2Uua58593
 Ymvnblach8YU4N2r6VF5Yi/oRpAJxGc8EawhiX7Ho2gE7RYrWd50ypHMb/sS8tNoc/+jFwT0p
 SuEzWCnHbhY159ON70Kp6TQCwnMgAbKgr7OneZHkx6s2GoeA3v+hQojrqST7+fGwbVaLhY3h5
 epu3OIo48se86+rfHvHb+puTnGp78BbusduSk4YRntCjoouJHK5XqKN3FxAdV45fmdXat/AU1
 lDTUoJfdSFmaQDmBp3PeIsGDifZKXj462tXnRjOXnfk/VYKpTIY6KeR/ubYthwUPkNiMX95Eg
 m5dspPq4thd8+P1xiZqDwJJFoGK59YbF/WaCvjaIpRiA6pDuq2NqGUj3+7QPh4sEmGSA6ubRU
 GJPgqtohPhHGZ0y+XWqB5izk1pd7jBukuJNxxv5mS5uOF3SRA4bkNrw70QDtVwp9Hn/L0sZJ3
 Tg166NvLQEVh3D35CTho4AZVsPZgwJhO02IfGnjuDEg2TQpcTXTbuSULlY9VJV5gJ67eL99d+
 YlqgHItInGwDPoqWsUttaqEsVzvep6NAY25z7u1kxY/vGMcXqV2tKTJYWn+LoF+TFDyYxNnZj
 aHxAmx31zOzQNQI60F1YCipVUFplnfgqKB55IzpclgmNHzyZFGikyKAjPJOJ2le9V4PnS3tuT
 TFypN9j9G8XSyUTK4tHA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 15, 2020 at 8:51 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
> > >   * set_bit - Atomically set a bit in memory
> > > @@ -26,6 +27,7 @@
> > >  static inline void set_bit(long nr, volatile unsigned long *addr)
> > >  {
> > >         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> > > +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> > >         arch_set_bit(nr, addr);
> > >  }
> >
> > It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
> > next to almost any instance of kasan_check_write().
> >
> > Are there any cases where we actually just need one of the two but not the
> > other? If not, maybe it's better to rename the macro and have it do both things
> > as needed?
>
> Do you mean adding an inline helper at the top of each bitops header
> here, similar to what we did for atomic-instrumented?  Happy to do
> that if it improves readability.

I was thinking of treewide wrappers, given that there are only a couple of files
calling kasan_check_write():

$ git grep -wl kasan_check_write
arch/arm64/include/asm/barrier.h
arch/arm64/include/asm/uaccess.h
arch/x86/include/asm/uaccess_64.h
include/asm-generic/atomic-instrumented.h
include/asm-generic/bitops/instrumented-atomic.h
include/asm-generic/bitops/instrumented-lock.h
include/asm-generic/bitops/instrumented-non-atomic.h
include/linux/kasan-checks.h
include/linux/uaccess.h
lib/iov_iter.c
lib/strncpy_from_user.c
lib/usercopy.c
scripts/atomic/gen-atomic-instrumented.sh

Are there any that really just want kasan_check_write() but not one
of the kcsan checks?

      Arnd
