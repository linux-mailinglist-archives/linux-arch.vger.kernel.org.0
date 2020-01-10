Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BD137597
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgAJR60 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 12:58:26 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:32853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgAJR60 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 12:58:26 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N2E9Y-1joudy0sbW-013dgn; Fri, 10 Jan 2020 18:58:24 +0100
Received: by mail-qv1-f53.google.com with SMTP id dp13so1120732qvb.7;
        Fri, 10 Jan 2020 09:58:23 -0800 (PST)
X-Gm-Message-State: APjAAAWBsAKNDbbjrtK1iMwyjbXOzMPqyhjSMSTN3Qm6s+tfmA6piWGO
        wv7UZgQX8WWYa+gNsa2jtb5AaGIyUWlL2OH5b5g=
X-Google-Smtp-Source: APXvYqxsFAf1yVAO2Dx/qvHSBeVQRsjroH01bU0irbPWOuPQsB6Ct3qKAM7SNfodZricPklj3XI7bhhkUqZegVp+PYc=
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr3996286qvb.4.1578679102966;
 Fri, 10 Jan 2020 09:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org>
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 18:58:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3LAirovfV=RRqf9dT7K_WkiC8SJK9oa-amn_EkibqEsA@mail.gmail.com>
Message-ID: <CAK8P3a3LAirovfV=RRqf9dT7K_WkiC8SJK9oa-amn_EkibqEsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fFesDrmRiPZv5CTakuBTJnnmbh+2qk9JOjx6AkTc8olib1/30a8
 vbEgtrbhB8K6n/kO3j8Sv7ky5tTeSb/r6K45xbSEyTfoxCF3fx1SYsTZXrxNs1q/6uhIdRL
 o3ApwlhdomsPKvLGB7mPpPC/UbLsdC1Kn1au/2xXPXtUeMAAsplb4Fn1GyH6Wgq6H/71Czn
 YaUGoi1FMKxkTW5NR1ZzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JRHAOP3ngTI=:LD6qW0+kF0haf/pqmGmNL8
 NxnWenF5nQcmGVqwUg0fOEaJ9JndstgC3IbkKvkggYc2RLCuDEsAjsi1sOFd1q8I/fXnmcwLV
 g0cSymdfZripp3mKqBIncjuWBSW/nCLgYO47gbqQut4PqrDf+M9kaW13I8cfYpcUCaTUqMnER
 uXnCFCuHLIBRMIQ3pvSaKvoDJTnV8zKN0xDCPPAhLQH89xOUbs2LUaNFdIIa5sRYiJb29oNSy
 qdmNeeW7Uub5ZDN3zJy6jFWvzN1po5a51G0hgNLLjszYzBlr8rCYeQNq/yV5f+EfNeWVWFzl9
 W0debwx082pbIF/EtBLQI6WGSg38AyMgQICcCk04qQNMAWthqan7WN8VZE2E641X8zXxUCgsX
 m/EM+PAe+UC8aPCuvr0NeNLgZxZP+GBNvmvOpuGeateDSPPh7yS/dMI6Dh3avpRNXg7cpdpgI
 x0TavXlPmaVHURqswNSK41aTAiOPvrxNroMcuN0BckRUZBPtZ6RT3fFAlxGWnErt1KflPiABQ
 qWb6pUSAEZRBUNNio1IbitYzttz+Cd6qv79V1dyoAfkZGcO4Vb0z0O+tb7DT48TZIj5St4uq8
 tmGZ4X3bt3GGBJJPAxX1vWQC7FqJI1lchNXBwz54H/8ih1+Ig5pj6wyieW+WfhbyJ3D4ikq5c
 DItua2Ug9vTE+mSOm9yUelgZt4SdZfLfO/j+kjVosqZgdXRpFnB+3uCqS0A38OhbNkV4TM+e6
 8bTDStieD3FIh++j2QF6GkvloOsRijlcSTZhdK7B3aP4WK3mdNyPOgrtTI1e+FCTRhHogO6s0
 cjG1DLskcjkdOz/+s2PBt8GU64d5nrkau3LUY4SzOrxoAolPTrkWI+picYfS8T3oVxtpfSEyU
 FQcrp9kVVGpf8tdL3gIw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> This is a follow-up RFC to the discussions we had on the mailing list at
> the end of last year:
>
> https://lore.kernel.org/lkml/875zimp0ay.fsf@mpe.ellerman.id.au
>
> Unfortunately, we didn't get a "silver bullet" solution out of that
> long thread, but I've tried to piece together some of the bits and
> pieces we discussed and I've ended up with this series, which does at
> least solve the pressing problem with the bitops for arm64.
>
> The rough summary of the series is:
>
>   * Drop the GCC 4.8 workarounds, so that READ_ONCE() is a
>     straightforward dereference of a cast-to-volatile pointer.
>
>   * Require that the access is either 1, 2, 4 or 8 bytes in size
>     (even 32-bit architectures tend to use 8-byte accesses here).
>
>   * Introduce __READ_ONCE() for tearing operations with no size
>     restriction.
>
>   * Drop pointer qualifiers from scalar types, so that volatile scalars
>     don't generate horrible stack-spilling mess. This is pretty ugly,
>     but it's also mechanical and wrapped up in a macro.
>
>   * Convert acquire/release accessors to perform the same qualifier
>     stripping.
>
> I gave up trying to prevent READ_ONCE() on aggregates because it is
> pervasive, particularly within the mm/ layer on things like pmd_t.
> Thankfully, these don't tend to be volatile.
>
> I have more patches in this area because I'm trying to move all the
> read_barrier_depends() magic into arch/alpha/, but I'm holding off until
> we agree on this part first.

Looks very nice overall, thanks for working on this.

I've added a the series into my randconfig build setup to see
if I run into build-time regressions. Unfortunately there are some
conflicts with the kcsan patches in linux-next that I have to work
around first.

       Arnd
