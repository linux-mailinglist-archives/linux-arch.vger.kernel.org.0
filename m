Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299834A3262
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 23:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353261AbiA2Wm2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 17:42:28 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiA2Wm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 17:42:27 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MUXh8-1mnVab0iZs-00QVLS; Sat, 29 Jan 2022 23:42:25 +0100
Received: by mail-lf1-f41.google.com with SMTP id x11so19043465lfa.2;
        Sat, 29 Jan 2022 14:42:24 -0800 (PST)
X-Gm-Message-State: AOAM531LPENl6+KXxvfJsA9tqS18HNo2D2KpIbD6R5kD8gHnUNXXe7de
        vOZK5fCmxmvo+UsqeygBjhn1hKpGAJ88W4PTRMc=
X-Google-Smtp-Source: ABdhPJzI0D41s8yrwHglCZkVEr0x+bK1CMwYgZgaz1NErnnr1PsIuPoCJo0tLrBweMwgRCKK6bnEP4/locNb0Mfr0Gg=
X-Received: by 2002:a05:6000:3c6:: with SMTP id b6mr11705793wrg.12.1643494389446;
 Sat, 29 Jan 2022 14:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-9-guoren@kernel.org>
In-Reply-To: <20220129121728.1079364-9-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Jan 2022 23:12:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3JGP6fLVOyLgdNw2YpRSmArbEX8orUhRrN=GHmcdk=1g@mail.gmail.com>
Message-ID: <CAK8P3a3JGP6fLVOyLgdNw2YpRSmArbEX8orUhRrN=GHmcdk=1g@mail.gmail.com>
Subject: Re: [PATCH V4 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0Yzxyzy2LWbvcWRmp6MeESLeJNu4HiYS0v+nd8H1Q5aXbPkaH3h
 mmZ+2CBXPSpeBCHtzPy5un72C3Yx1seV3vXVkpHT+PrN/YcMbemmvbgD0jHrvhFjno+Tg0Y
 fvqULPUJqNJz+T/rMGy3qgjmCSeLRmCbzt/mIBDRXs4LkxVEYtw0btA1HB91O2De7iHcXyM
 MWdMgVoQ1PPCsUPLhdUVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dWjG/ko0EdY=:+zw7v6BvhXjWByWelgdfw6
 Q3AejGC3+HE8YYQOMcY+giFrl8yPSdiPa7+0ivr3Ipj1oiYMIStsvLVVvOY8ckTDM8oYnur8d
 pCR0f8xgp/UegOdYGfHTcYO1rm8N8sph8OxobFJFfrpIY0lW5cjCqOiNafseRDkhQxea28LWR
 fdb1R5Eg7T0rz8rq08gAxO01DFdaRkMoZXaD5K7Bb747a6m4JjuBfNrJkseFZJm2+W7mcByxw
 nk4ZYr9oPkHqtFRo3zVrt7E8Tk/2Var7bMvnGyk6GvuP8CzOYyUEmuKFFc/7hE5k8xpN/nywi
 I+6jt2iCtD8EV0DSW4pBvAUPYib8iuLvcRS1edR+G305Zao6WGB5+a7FmA6Uw3603dpIlOgB2
 F2y8megL4+vWzqKyv6eSeu8ZxR7/f4nOxveFRfDFpEtGwjvDNGl7cHj+ix2PH1mRfCfbmOkni
 q/w2/Kq50c4OAKOWhJ9rFHymKfb1kKJ1MpHy1rrG21kXl37KVdnm7u3XnSOg4DD0J/vlO0THX
 Enhjc8wH/8kr1DNcJLIog/ku3oTnUL2PUeTF9o8tJiAahGBk++9aEueAQUrZdu+uiY3ik85CZ
 PzVkPJ3bPZzaEEJn0XakE7dWgQ/PCdY7QGhdEVIcnw5rh4U8BIehof++NqNgeaSAZU/Spe5HT
 0cGKu6qKg1XZUOjQPt7nihz+Gz7+b3pPTGlhvpYUnGJbUj8XSV5mveQs8u/f/80JOTHO9jWAG
 cE0wn/RVJklRA8VjUu2Oj7gXevld3Ox9fPQHMkkCVF1KzvVZ/TTSDT3zglwFcM3ZZPoopchfH
 d7OYU5Bhv76HpKNGmuP6lksZRTpQap8HmTAdW84KRODDXqchCk=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Implement compat sys_call_table and some system call functions:
> truncate64, ftruncate64, fallocate, pread64, pwrite64,
> sync_file_range, readahead, fadvise64_64 which need argument
> translation.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

This all looks really good, but I would change one detail:

> +#ifndef compat_arg_u64
> +#define compat_arg_u64(name)           u32  name##_lo, u32  name##_hi
> +#define compat_arg_u64_dual(name)      u32, name##_lo, u32, name##_hi
> +#define compat_arg_u64_glue(name)      (((u64)name##_hi << 32) | \
> +                                        ((u64)name##_lo & 0xffffffffUL))
> +#endif

I would make these endian-specific, and reverse them on big-endian
architectures. That way it
should be possible to share them across all compat architectures
without needing the override
option.

        Arnd
