Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8738513CD13
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAOT17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 14:27:59 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:42767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOT16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 14:27:58 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPXpS-1j4PGR0uxe-00Me1Z; Wed, 15 Jan 2020 20:27:57 +0100
Received: by mail-qt1-f175.google.com with SMTP id e25so5473224qtr.13;
        Wed, 15 Jan 2020 11:27:56 -0800 (PST)
X-Gm-Message-State: APjAAAWLEulqIx7B7tp5+7XV2CGWmtgErwP2mtdWnqHt2rTFj6gs08RK
        0CmYy3GVxeGnCk1MmY99qYP0JgiQ9iM7LNMTjHI=
X-Google-Smtp-Source: APXvYqykSB0s6rvYmQe0FsRmHzo5ilui57+/PGk4XuP/nxJe8gVx9oYHNNcpJzIIHmSXoLWDH8AZDKjyw5exXlKcGs0=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr186613qte.204.1579116476026;
 Wed, 15 Jan 2020 11:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com>
In-Reply-To: <20200115165749.145649-1-elver@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 20:27:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
Message-ID: <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:YkKUpj3xwSkFfIAXmbpuL8nE9IJtvsIKwYN1OxMqtU+EjMlrFqq
 L8y7mP1TYaLLoj5rByrBqN68arCwTunm0jSK4POSeN/EVUzbyXjFuzs8gwKjY719nBlCZAb
 4fc2vxqRO/aBN0ESQog6d9vPlA/UbncXUFbLJvncl1ojiUeXEP1E1/5PIqPse8FeBMhxYzP
 yCDsXkISzsvMFJvwmtR4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BQDfpI/qFJY=:/u/Wd4aHL4TXSOo9bePzLv
 EyfYG8rEzQpepeAXYkmV5FUyJg90tkSXgEnb8tHBQzUzxD9Mz+ouAf8Fh5qfNu+wfM8L5aQZ1
 QMKNVRONvHi+fr3KKHrCma4mrZlckaGr3mNmO3z+oh5BsbsEuxT5c6P9PGGIWGTMJtFb5Paan
 4cur8jqXT/qyslcV2JrERboJIEW5UzreBKLGmV+sIT7LuL/NJ0U7NlK1e/CJg84UKSfm+vBu7
 +8VZ1l/+LK3b0tSCu+vMe0ncBQETVlbeOugiz5FZYGGb/H9OT4LmvK5jRgg941DccBNRGKcBF
 wF2Jz4kFvcvTvhEY0IDVOGRdBVulRU/Y9Jg42rmdsrscZjtOwWq5GHzK+n/rdzMZdKYCD0ETw
 PUCodamAV7eUhqu+Fbc25fqk5Umc4uO5fHg+/AvAM8gg+/xGGTGps5HbFzCK8P78dOd/5jlTW
 z1oqhnKQwQl/dXqETFzF0/xGCqENztVuKpLjxeFik2yvnygpqlZKQSiPIHNn17+twCegvVfYd
 0pLfpStRJDRZ9D0QvEzxSTIVlSQHzR1v3vHNsYKzvmQdz54VvAwjCZzlFsMfFyzKojdwTK8YS
 yviSSHtpQtX/c6D14R+DMw1uj+FDN5q04vuJ5bcBmMLeBdOIZMHzszS0eEA584TaBwZITqhdv
 PCv/qmvj1i+Q21X8+2U5yZpPVlXy2wEjRDLfhuET1wdD1hBIpK8i2Ftm3/gR1ygqGzFANoseh
 Jg4qMdoB+X5bjwPgquStn33B1t/uLancmkn/rUK6RQA5LoArIyMy8gMTU1USeF/hBHsUYC5st
 5PkBEoWcch3856TFyEpYboSekzp2lXl34egokwicB1bmq/bGjrBqnJi++aXuImkfgqpUoWZU0
 Q/NPuz6eeLerxvIrgi4Q==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
>   * set_bit - Atomically set a bit in memory
> @@ -26,6 +27,7 @@
>  static inline void set_bit(long nr, volatile unsigned long *addr)
>  {
>         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
>         arch_set_bit(nr, addr);
>  }

It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
next to almost any instance of kasan_check_write().

Are there any cases where we actually just need one of the two but not the
other? If not, maybe it's better to rename the macro and have it do both things
as needed?

      Arnd
