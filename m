Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2485D11E46B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMNR2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 08:17:28 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMNR2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 08:17:28 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mt7Pt-1hqnvg3JyD-00tW4K; Fri, 13 Dec 2019 14:17:26 +0100
Received: by mail-qv1-f46.google.com with SMTP id b18so798382qvo.8;
        Fri, 13 Dec 2019 05:17:25 -0800 (PST)
X-Gm-Message-State: APjAAAWW3Mm3QToWBZ/0Vdbe9InKkbH9DjSDuKTQHO6AkwUNEADOSbzv
        25atTTrrtlpJcuW+d9cszDQ3pmLe0OCb2w66Bdk=
X-Google-Smtp-Source: APXvYqzFwFcYikxJ28kBoN0UCn5sg1VzXwQF4a8L8BwcmPohvWspCPfGhWeuKWhSDV04mg28v6cq323o0FLTlhBpJL4=
X-Received: by 2002:ad4:4021:: with SMTP id q1mr12702039qvp.211.1576243044500;
 Fri, 13 Dec 2019 05:17:24 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Dec 2019 14:17:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
Message-ID: <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rKN2YCHFewC72uW1MuYrJQgq362ZdK+azijNTr40IS4PW0mQwGw
 6Hv3OGBR3PZf1U7KKq4k7sELVY+a8lsl8aYXG7Dpi2m7SO+Kc3rQRKaCS4My/kJiw5diCT5
 kBLt85YUujGlzFgpPPu/Lc0w/Govbp+qXkxXiM53nrKJo/GxWgQBoHByZSwXp45yqFAmTvu
 ilw28pPKIxLz+c/blFIWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iRczoI831SQ=:sxHfHnTKiRDof+yqXbP6fE
 n3Q/VMgbTf4KFQw6U2dBtyda3gi/sKX5gDDoLKIFVvxZY0Q33f/ocqn/dZqUtCFkshIsG20nB
 /SvD+MLAlXZ8dpSVI32w4BQMUHvOVPpZScAhXrDk7s9UbnRsPoGrpR366x9AuMeM/eUnt2LWU
 LP0O2V8QBEXSqMsO+AMGh3PMjL9HhlJAvW6qae4/WzqxBTCyfiUS+3W9cm2H2J7nirjZiKK2u
 n2TyFrUEUAeotrV6ikwA0ko3tr0EhK63p/yc3R26QY77jd9aC9HBL3a+7Es/WYalB/rmHOwbc
 sI40uKS+qIIUB+3pvPKAOI4AODLZcOHFqyTTjxma5V/d0oRONPDUaJBQu22k6fzrNA8whkhga
 ISozDYB7Csi/N89NjrkfCVqLPSbjH01/xizGauLzNRbXFBYrEkLS8oQqqnjmOKcevop1wEQF2
 +lRTJi337t5VyolTO9GcW1eDYjWPdW7XWTHKImL3QKOfeI/xrABWd2cEDKhL6o1V+jMj2/Mjz
 qgj9f6SphUKIut/bJaWhiVAFRbb+dvENDKSirj+/w25iWDecuj4JMeXBA4RVdhTW6N8J4bFnK
 6STlT+OwHFeKT0LP1Y7M2/iL0lU2skTkmFtTkRXrjuZ9IhacRbTXWzmz6uPqQGZTfFsOpyInq
 uPoixNhc/tYJWwzSZNm2BuvWJcHh9c62gJPgsZMMjCoRU8/kZoOBDKDoipZEUoOozIpXGF7mG
 gWZXkFcF9uv4JpBL08M6twyk+2ALCzhKJrfmzthJ6e2moEUzncuPRf22Px74+/4sUEqpKSGie
 TG2pgG6Qmc1XXWnPQt9b2lEKxkmVLi/qUM6ZaCkLit7tmesFM3DEsP1CAPw6MbWqHi9xDfoog
 dCOOD2y9anONsweWXPJw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 9:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> > The root of my concern in all of this, and what started me looking at it in
> > the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> > for a pointer means that local variables in macros declared using typeof()
> > suddenly start generating *hideous* code, particularly when pointless stack
> > spills get stackprotector all excited.
>
> Yeah, removing volatile can be a bit annoying.
>
> For the particular case of the bitops, though, it's not an issue.
> Since you know the type there, you can just cast it.
>
> And if we had the rule that READ_ONCE() was an arithmetic type, you could do
>
>     typeof(0+(*p)) __var;
>
> since you might as well get the integer promotion anyway (on the
> non-volatile result).
>
> But that doesn't work with structures or unions, of course.
>
> I'm not entirely sure we have READ_ONCE() with a struct. I do know we
> have it with 64-bit entities on 32-bit machines, but that's ok with
> the "0+" trick.

I'll have my randconfig builder look for instances, so far I found one,
see below. My feeling is that it would be better to enforce at least
the size being a 1/2/4/8, to avoid cases where someone thinks
the access is atomic, but it falls back on a memcpy.

      Arnd

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 0968859c29d0..adb492c0aa34 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -64,7 +64,7 @@ static void xen_get_runstate_snapshot_cpu_delta(
        do {
                state_time = get64(&state->state_entry_time);
                rmb();  /* Hypervisor might update data. */
-               *res = READ_ONCE(*state);
+               memcpy(res, state, sizeof(*res));
                rmb();  /* Hypervisor might update data. */
        } while (get64(&state->state_entry_time) != state_time ||
                 (state_time & XEN_RUNSTATE_UPDATE));
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e88e7e33abe..f4ae360efdba 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -179,6 +179,8 @@ void ftrace_likely_update(struct
ftrace_likely_data *f, int val,

 #include <uapi/linux/types.h>

+extern void __broken_access_once(void *, const void *, unsigned long);
+
 #define __READ_ONCE_SIZE                                               \
 ({                                                                     \
        switch (size) {                                                 \
@@ -187,9 +189,7 @@ void ftrace_likely_update(struct
ftrace_likely_data *f, int val,
        case 4: *(__u32 *)res = *(volatile __u32 *)p; break;            \
        case 8: *(__u64 *)res = *(volatile __u64 *)p; break;            \
        default:                                                        \
-               barrier();                                              \
-               __builtin_memcpy((void *)res, (const void *)p, size);   \
-               barrier();                                              \
+               __broken_access_once((void *)res, (const void *)p,
size);       \
        }                                                               \
 })

@@ -225,9 +225,7 @@ static __always_inline void
__write_once_size(volatile void *p, void *res, int s
        case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
        case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
        default:
-               barrier();
-               __builtin_memcpy((void *)p, (const void *)res, size);
-               barrier();
+               __broken_access_once((void *)p, (const void *)res, size);
        }
 }
