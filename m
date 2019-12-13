Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40611ECED
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 22:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMVdH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 16:33:07 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 16:33:07 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0X4e-1hjoHt3CJY-00wTtK; Fri, 13 Dec 2019 22:33:05 +0100
Received: by mail-qv1-f52.google.com with SMTP id t9so319741qvh.13;
        Fri, 13 Dec 2019 13:33:05 -0800 (PST)
X-Gm-Message-State: APjAAAXfCTEfs5zqNZffgfa1NTymJUN9kz81+abqorsqbAZ/peGOEhlJ
        ZCFaiBPpDezIK6BB2EGiG9cXKAgXUH0JKBTwxzI=
X-Google-Smtp-Source: APXvYqwCzGhbymffr0MJ0HPN+piVHm6ukpyasxZTu0jrENW0TrLwxdmw8hoOi0tCS69BkfRXSZvzHOqSymJ6CdsWGV8=
X-Received: by 2002:a0c:aca2:: with SMTP id m31mr15739114qvc.222.1576272784583;
 Fri, 13 Dec 2019 13:33:04 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
In-Reply-To: <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Dec 2019 22:32:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
Message-ID: <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
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
X-Provags-ID: V03:K1:FdXVnilKksLQLV1wzuAn1Esf8CicNBfi5v9XB/3emD6G0GJG4+S
 ft0zSdL6XWPzgsIkHJp8BODgVJjytSWWLaBQ0a582j9cc8nVGuzjH2v0vBReXWD88GPddI8
 FjhWmFChZ/vy8YWpbHbf1M1JWgEdPiaSz4x7KkcoBdUbrgVcU4FylFPFPqDOz4NcxddXJ1W
 ltEsARmVTm/Y6yHckFRRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YFAe+6A9cTM=:Zvky+XzJsJ322S4cP0pg6i
 86yBNT9R+qQvN1z0XLu1qYzbYWamXOzhuIETZG4TzscrcO/j8IZUgEh1udCOYE+Q6g8vKCGY4
 WuZJlFDAlZG/u7YTV+g8Sh5n6xb+6DQUIaCkfbClcxgG/7oAiXZXur9/PGObWszYPHdHvzMiP
 4HVO3PyLsexxLM9aGHC1qeAMU7wFUKCoYkWgpV9AsMSZq36pWH8Tn8+zEVFhr5WmN5luNmiy8
 wYjuqhmZmGgJt+GldlWvCfTC1OL2ggGDnP+IrmtPXh5UcMaStp5rdtgyxlp/KTv2ab/PspqZ3
 nFeYhu9fpPSv2/xJoAcAG03zA0+fVKzyiODG8rWOYqNzrWuNNImfzvn9LxW6JzNhEecZh8yX3
 C98KdPgUYQK9tRxSnV03jBTmfTTms8uHboe3aQmOIEfFIcQj7pYux/6jcq+jFaBpGkNILxG9p
 8AMb8fDbwdaYS1H2Is6fmcOTS59DsBR5612mlApK4nDAqip/JemqF0JhuDyQXkKdcfX2aS2up
 e3iv2rLXuHQuqKgnRQ/fooZnPHazphhiW72Dogh8fWTpMc5pk5Juu1JLgNRn1iBrPbmGVWZCC
 2o6wbaFn3RTiPS55IBpWNjlkFJBJ07Mq9DuwcHmTDpbsxw6nqtWbTKD0JlKbO+L0Pb5BOj7ZA
 qI4iFcj6IWnZxj4SxiIfaezNAWKHMXGXHWtjnt/MGo4/csM61RySWPAHqMA/TY74uW3aPPTGc
 AAbWcTlOUpGzO0i7axqsYTWdjabheBfwXK3oJvwrrlumL7j1Oc4oc/UrNAFPphJxfXlEFMNul
 iYgbe2K8SG0hoLqUCmwUC8WLgbf4d9uskXmUXylCcwxy8uK29tY7wYb+o6IaKq4K596GoDRbd
 Qlm2tyxlshG50wIqkNGQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 13, 2019 at 2:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 12, 2019 at 9:50 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> I'll have my randconfig builder look for instances, so far I found one,
> see below. My feeling is that it would be better to enforce at least
> the size being a 1/2/4/8, to avoid cases where someone thinks
> the access is atomic, but it falls back on a memcpy.
>
>       Arnd
>
> diff --git a/drivers/xen/time.c b/drivers/xen/time.c
> index 0968859c29d0..adb492c0aa34 100644
> --- a/drivers/xen/time.c
> +++ b/drivers/xen/time.c
> @@ -64,7 +64,7 @@ static void xen_get_runstate_snapshot_cpu_delta(
>         do {
>                 state_time = get64(&state->state_entry_time);
>                 rmb();  /* Hypervisor might update data. */
> -               *res = READ_ONCE(*state);
> +               memcpy(res, state, sizeof(*res));
>                 rmb();  /* Hypervisor might update data. */
>         } while (get64(&state->state_entry_time) != state_time ||
>                  (state_time & XEN_RUNSTATE_UPDATE));


A few hundred randconfig (x86, arm32 and arm64) builds later I
still only found one other instance:

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index eddae4688862..1c1f33447e96 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -304,7 +304,9 @@ static inline struct xdp_desc
*xskq_validate_desc(struct xsk_queue *q,
                struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
                unsigned int idx = q->cons_tail & q->ring_mask;

-               *desc = READ_ONCE(ring->desc[idx]);
+               barrier();
+               memcpy(desc, &ring->desc[idx], sizeof(*desc));
+               barrier();
                if (xskq_is_valid_desc(q, desc, umem))
                        return desc;

       Arnd
