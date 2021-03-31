Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF734F9C4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhCaHYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 03:24:10 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhCaHXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 03:23:44 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5mOb-1lhv8u0BBb-017Abd; Wed, 31 Mar 2021 09:23:43 +0200
Received: by mail-ot1-f47.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso18078793otq.3;
        Wed, 31 Mar 2021 00:23:42 -0700 (PDT)
X-Gm-Message-State: AOAM531yAdOB1JG91gmaoIyMfJBmSrhl+ZqRCFALPNENZfS1JGcYXG1z
        ni+fCGY+Kvu+XbyV3+YV08FiRAot9xNiYqK8X5E=
X-Google-Smtp-Source: ABdhPJyFjdlUUk3RES+tTzVVGc5T+46fputAKsVs398NkEoU5yXLryRVHwS3WvNaSwrY7g6zSpkPdUih423pRxS1uwc=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr1671217otq.251.1617175421568;
 Wed, 31 Mar 2021 00:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net> <20210330223514.GE1171117@lianli.shorne-pla.net>
In-Reply-To: <20210330223514.GE1171117@lianli.shorne-pla.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 Mar 2021 09:23:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
Message-ID: <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Stafford Horne <shorne@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rgORBRv6Zc2+Fhy5ziZhFXl5MSUQ+xe6L7zkCERsg/UNRY9rGc6
 j+Am7btMj2yIAFcp3LW6KQqlFxknIJ+66pjS0HEWEXzYN3HU76LwlI+QT0A7hjgfkE2XZaP
 uL7CeCDJKe3CbWnqBc3ouVH5qz5not6Dr+GWj4fs76tyzlhsVeGJ0OtO1UKNnAPeN82R/7z
 7noAEye+Zg9nvybQuZUIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LwahJgaG9vw=:55zRxBzHqIdy4oEn9PV/Te
 Ud1sC/gD67xxnBf/slWCgE1XdWvOCpuG6XLFD6qn2qCKThEJMgnRA0MTcu1Z6HS2rLBheJfur
 sRtJcOXyp5iPnAwREQBxVszmIcYYIVR/M4zbvt6hVI4GwsLg6ZL+WygL71hHvddQHcco0SyYZ
 QeFVgyNt1U8TRDxEZminoI/7fg5LNHNxFEoc2hPe2cyYCByJO6u35sCuV/HmPEb+StHPNW96l
 wtz584cUhxSF8KE5tt9h8sUMTAOhlfXUMC5EdrUNDZYxYyCzt8fB7a1FfvXhOGamh1j3Kyz7e
 zn4QTuC1+dPuPWC+g5eNBFYC5HlN4YtM03Tw+sgpOwvp2YPSH/TYeF5FPfom5RM8OFEYqkYy6
 VTfi2X1XH9nusI1RJ7NCCHHRpumLXfWbMBrnZlOahrg/BbNLHEzT85SjEPtzg+79ydt4lQCzt
 a7yQNj7Qxq/VtAuXvtMHGFDBXuBC97NY/uyaHTGEpWS6s7GGYfD3MZDT+33qnhUzVeHxvgdhm
 aGxpevswZ+PjRGb5Bk8QHTJIwojfWrIrNaBsBB7sLmZd8dKQ5F7nAgtPFtOH/EuGBh3TrsiMw
 6ihMVHEu3QaLMpLrPRvhIxZrWYaBwPoR2e
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
>
> I just want to chime in here, there may be a better spot in the thread to
> mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
> which I have on my todo list somwhere to replace the other generic
> implementations like that in mips.
>
>   arch/openrisc/include/asm/cmpxchg.h
>
> The idea would be that architectures just implement these methods:
>
>   long cmpxchg_u32(*ptr,old,new)
>   long xchg_u32(*ptr,val)
>
> Then the rest of the generic header would implement cmpxchg.

I like the idea of generalizing it a little further. I'd suggest staying a
little closer to the existing naming here though, as we already have
cmpxchg() for the type-agnostic version, and cmpxchg64() for the
fixed-length 64-bit version.

I think a nice interface between architecture-specific and architecture
independent code would be to have architectures provide
arch_cmpxchg32()/arch_xchg32() as the most basic version, as well
as arch_cmpxchg8()/arch_cmpxchg16()/arch_xchg8()/arch_xchg16()
if they have instructions for those.

The common code can then build cmpxchg16()/xchg16() on top of
either the 16-bit or the 32-bit primitives, and build the cmpxchg()/xchg()
wrapper around those (or alternatively we can decide to have them
only deal with fixed-32-bit and long/pointer sized atomics).

      Arnd
