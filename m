Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0355548B204
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 17:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349933AbiAKQXd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 11:23:33 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40775 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbiAKQXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 11:23:32 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N8GAQ-1mKq3f1A7U-014AiZ; Tue, 11 Jan 2022 17:23:31 +0100
Received: by mail-wm1-f44.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so2166361wme.0;
        Tue, 11 Jan 2022 08:23:31 -0800 (PST)
X-Gm-Message-State: AOAM531EX7OV+ZT9+XgBi/0mNa6tt+MVjeu/ArIxWxO+8mAXm8HWyI29
        7EB7dlR+qmJfOr0b4z5l91ylwMIIBVUDbyF0VTU=
X-Google-Smtp-Source: ABdhPJzKtxNqKm+vG6V1ehFI4c3bK1Wgo74RA/PdiobgMvxAcMaDuP+73KtKQoyrDgpsA4itI+LD4GtzQJ+F3zb+CuU=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr3073002wmf.173.1641918210809;
 Tue, 11 Jan 2022 08:23:30 -0800 (PST)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
In-Reply-To: <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Jan 2022 17:23:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
Message-ID: <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EnBgWDcDmBzH4QR7GnmfUZhbV/aKIZAL8YaJr0POgGVaIBo/u1U
 hCdHBMbOJxElEhY5dOWJmAmLnLYgmgYFU8s7m+bgDy/HhTg1M2nxUUNykkwmZY94skdmu3R
 xAJRn/33/Vd+5UdHuOvjPsO1A3VkDyawEkCpAHYOEytNAtBykV9OM1mD/L0n4ZFx6IGNDhC
 G7L0uxZY8j2C1nBCrWU4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jkhsrUAxyyg=:mG7d/cwbbYZWnL6L0a45Xt
 05lhxAFcb6Xzw+2A7O1bY1r0ZYJJmZMBManAnYiA9f8k5Ssf3HVPKWCkjP2p3EYafV7d4KhGA
 yDS7V8Fk7OGy8g5dSpF7xmpZxvTaWD/3yFL9hvqzk7j43oWjxsXhdzGyZUf9v2eOykL/7i6FY
 2608Jy8BBDNFyFMiRXx9QNT7iy3QBTgDJTF4SZbKunFlgQdgtj9Yny3ZLfPHkZ2NoISZVQpD0
 0xf/cwDPAGWz2v+FlyWK1kvZiLXBvl/KeFSInFYIESoerAJ33esHgTr2C950nNOUKNsT8Ttrl
 HlpM8771EVbDAWYrdaZfVmTmpdHjPnYQsJEwrLd2+yhBiRAPLwf+wu8+d8DJp+2Cz/ncPHC4G
 +kA4CvyLhaIRaIXRzYIhvUQmjVJRcIgu0replIsKlLY3D5zVRViZBnGccrGpsiF9CCvYKDDL5
 4QUkjvLH1Qb8PlSz6+rEf8CEcBRCMgn/Dd2JQMH08LRkQ7EDYb37ThW9NNRBdtzcg+7/s8m2V
 tcXXPiUeZcVJ99UAIym1hSGfz7nFxSB/PygWwy6gdrsMtLeo/E8ehgsQCgXf5KBqHmBIABZ7t
 X+LeT5YaIRJbQDm5S78c7l2SU7WPQLnuJpMjWCwQ8CsSYBXusDc/L17shOJ48RMrdjSteZMYg
 EMWpNgVZdl28C4fC4kDvBSoL1n0PJgSoKDgRhdCq8tWvZvpPu03kyBGMWRp7QHs9u19E5s9gE
 SXoq5N7ndo3NVTxnwF3X5+VClbLHjri9A0p7eXMM/AZoEpTamv7OTvJ/R/q5Gl7dH6z0kNbKQ
 XsaLDyGM9EcXDEQ3nh+6UXaLeoYYjNSxDqE9OqBkb5A5gkM6Oo=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 11:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Jan 8, 2022 at 5:26 PM Ingo Molnar <mingo@kernel.org> wrote:
> I've started building randconfig kernels for arm64 and x86, and fixing
> up things that come up, a few things I have noticed out so far:

I have run into a couple more specific issues:

* net/smc/smc_ib.c:824:26: error: implicit declaration of function
'cache_line_size' [-Werror=implicit-function-declaration]
cache_line_size is generally provided by linux/cache.h, which includes
asm/cache.h.
This works on arm64, but not on x86, where asm/cache.h would have to include
asm/cpufeature.h, and but it would be good to avoid that because of the implicit
linux/percpu.h and linux/bitops.h inclusions. Also, if I add the
include, I get this
build failure instead: include/linux/smp_types.h:88:33: error:
requested alignment '20'
is not a positive power of 2

* arm64 has a couple of issues around asm/memory.h, linux/mm_types.h
and asm/page.h
that can cause loops. I think my latest version has it figured out,
but there is probably
room for optimization.

* There is no general way to get the get_order() definition, other
than including
asm/page.h from .c files. On arm64, this shows up in a couple of files after the
cleanup. Only xtensa and ia64 define their own version of get_order(),
and I think
we should just remove those and move the generic version to linux/getorder.h,
where any file using it can pick it up. For randconfig builds, I had
to add asm/page.h
to net/xdp/xsk_queue.c, mm/memtest.c and
drivers/target/iscsi/iscsi_target_nego.c,
after I removed the indirect include from arch/arm64/include/asm/mmu.h
in the previous step.

         Arnd
