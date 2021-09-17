Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44E40F405
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbhIQIZq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 04:25:46 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhIQIZq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 04:25:46 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Md6V3-1n1JGW1SwF-00aI2c; Fri, 17 Sep 2021 10:24:23 +0200
Received: by mail-wr1-f42.google.com with SMTP id t18so13863932wrb.0;
        Fri, 17 Sep 2021 01:24:23 -0700 (PDT)
X-Gm-Message-State: AOAM533PAzr8zQK7VjOS3rUWivgV4hBA1ekdwD9fmWHEzdc2SZqdHTUD
        9RFsNGBGn3Ss9VAN+t9kJGMvGNArCXO4KKMGQQE=
X-Google-Smtp-Source: ABdhPJyxKDbnAit0P8RlxwEKdj8mySHy/6gXPGZ8bIgKVMovkoL7/o6abv6tjsBL6nj2VlsV6u7V/UNuV8R2g2vUC1k=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr1229158wrz.369.1631867062981;
 Fri, 17 Sep 2021 01:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn> <20210917035736.3934017-14-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-14-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 10:24:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Ce0bsyrhEK1SZHtUPEnX-rvQcKLT-TPRGptNdmiJaqQ@mail.gmail.com>
Message-ID: <CAK8P3a3Ce0bsyrhEK1SZHtUPEnX-rvQcKLT-TPRGptNdmiJaqQ@mail.gmail.com>
Subject: Re: [PATCH V3 13/22] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:neJGTFHkscc1NAv6hwO1FuUBai5vvMKqfmhPIrXLcKuYH5LcNRn
 zgfyX6Ed4AE7kT7+Gi0AseizMEv7Su0CnQDb9AKDdkJjn62qVynhQb3w12JTQAqOBec/ZMY
 nBnSSL7C6cqy0cLnQxfTy2FSeKGdDvjYyJl011xUAGMqDe5Zbhg/rjko79sbzbMFB0dc8JY
 fu5u7YgaU+fD5qoCdAeiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzKiGr89jSo=:Kg/SDXl28Q9f0IxfdiBMQI
 wyAU2NJbnHMcAgyplrdfMTbKGqMtYGLXung9GJOyEeshgfuGweIIYHNQI+8iEdVigudvNueN4
 ZudexgROqDHMAkfCn46R/85nYQmwHXI1E3sBC8s+Nm92zguUdkRJp0A16ni2GinzJGRCnB2c8
 bci56JQYrwcmHNXc1kPHwFnGdyQ9QhH0/3U/XHi3s0M8ydqOJfblzG31Pec4dIL/OuvvwhQIP
 IFce7fAZdgwSFrHMvovyRkeZWWmRTBuhnnFKoWHjuOyH8Z+fuTG47vnz5ECcXaU8/Br6SONGa
 UOgfIBHoFJOy4Bqq9NUos5GymBiLwF/4hAe5ex8slK6zjZvuOwW5ekThsdGUk5RkeuWjxtbTO
 R6kw7/zXf+neKnMNkR6f9BZZDb3Jjdnfsl95qYWPAncjgDvI503jXa8pfFQkpsjoiFp8Bei2U
 2AR/8wbJEVEVKSXQsb6CEg3YiGE/xljJkk6M5wrmoylzeptKStDZ1AB2yykZowwX3OSfl54w2
 DySMbhzpe24eQnADjQ6aFTozZDojZ0SePY9/e9/OvUO5kx8JGDEj0hHgtGfewbFEr0eN7p1cf
 Ah61J4I+MLJUu5ofEs/SISu0AIAGnCStGDocAan6Y4zLTfnptm5/fT64MOEeXImNb+dUfCcT/
 loBZf8MjVQu6OZkC/AGLneGJz8QMO0jXI10GPF1pHjcaYkqK6gnPhX+DKoQ+vIQn9COUO3xDL
 vExphipCtrWHdOD8BTFVokpExUaIjOoXGemf0zZmTdtJta6/b/lGTHN8BhGlX+RSrmgZj533V
 5+s/hJ3IfI9WmpvYU1Awxac3yjwKPe2fVOpAzQ8PVXiy1R3REkiSo/JDMj8KlsIhXXW7a9Oox
 fGxJW48iMYo4olfKd96g==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> +#define NR_syscalls (__NR_syscalls)
> diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> new file mode 100644
> index 000000000000..b344b1f91715
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/unistd.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#define __ARCH_WANT_NEW_STAT
> +#define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_CLONE3

I still think you need to remove __ARCH_WANT_NEW_STAT and
__ARCH_WANT_SYS_CLONE here.

I understand that those are needed for the transitional period when you
still need to support your existing glibc library files, but you likely still
have other kernel patches that are not part of this series, so I suggest
you add those two lines as a custom patch there until you are ready to
drop support for old libc.

> +
> +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> +       unsigned long, prot, unsigned long, flags, unsigned long,
> +       fd, off_t, offset)
> +{
> +       if (offset & ~PAGE_MASK)
> +               return -EINVAL;
> +       return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> +                              offset >> PAGE_SHIFT);
> +}
> +
> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> +       unsigned long, prot, unsigned long, flags, unsigned long, fd,
> +       unsigned long, pgoff)
> +{
> +       if (pgoff & (~PAGE_MASK >> 12))
> +               return -EINVAL;
> +
> +       return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> +                              pgoff >> (PAGE_SHIFT - 12));
> +}

sys_mmap2() is only used on 32-bit architectures, you only need
sys_mmap() here.

Ideally we'd just move those two definitions you have here into
mm/mmap.c and remove all the duplicate definitions. Maybe
you can come up with a patch to do this?

Note that some architectures use either nonstandard names,
or shift value other than 12, so those need to keep their own
versions.

      Arnd
