Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E8370254
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhD3Uoj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 16:44:39 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhD3Uoj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 16:44:39 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPGJf-1lvUSH3dvB-00PeWe; Fri, 30 Apr 2021 22:43:48 +0200
Received: by mail-wr1-f47.google.com with SMTP id x5so21688547wrv.13;
        Fri, 30 Apr 2021 13:43:48 -0700 (PDT)
X-Gm-Message-State: AOAM532Fd+80CDAQiJ4dOI5oYtlGRKoV1X6wNkWhf9P0klr/OCIMcsPU
        mQxAr2GNWF6OKzcgxXkglDhw8V1ReNniXhYMa/I=
X-Google-Smtp-Source: ABdhPJxA6TybANagJ0qyIQ6FUChGGFgSMR1TlFRyQOZs01sNXca04Touthsa7NzRGXFDTEGZCWPvtHhkVKpp9VirFF4=
X-Received: by 2002:a05:6000:1843:: with SMTP id c3mr9808647wri.361.1619815428535;
 Fri, 30 Apr 2021 13:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com> <m15z031z0a.fsf@fess.ebiederm.org>
In-Reply-To: <m15z031z0a.fsf@fess.ebiederm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Apr 2021 22:43:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mb6X4+4Q1WBQp22O2Bvc3w-Q=L25jh+WPvp2kJFwHiQ@mail.gmail.com>
Message-ID: <CAK8P3a3mb6X4+4Q1WBQp22O2Bvc3w-Q=L25jh+WPvp2kJFwHiQ@mail.gmail.com>
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Marco Elver <elver@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1T39EDIEGbC+K2EWO8vif5PitZfwh83eNXC5FhSEd6gpm6wI/mg
 0LsG6tKV2Wbj1GzC2XsrKRG/oSKE85phpvLwKPkcyh5KLDaOBzIsM52bwsO8uSACBGsYFX+
 PzRDHD5mjgShUF7QVg6NwyzXadfx+3T7hAgSIr/cGcEKL6vqK/cIlbp4au1xdWJa74NG9Lw
 vWkkVu41JAR1YOI6ToAVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bD7bHAN+nZg=:nbPLcZgrKRCeaw9/+G+s4P
 6vCC3nyX46/35Fso9jkovVD1ok6BDjyqpM1cJtPfYGNbfl4kNZ8w50HaCWWtjoD+YD94sC38b
 69F+/x5Vyx0FzCaFh8CQTdyKRNAhHV6KWA3AVMeYvA0UzrGJyGb9mprWPbPblC2XNPMts4i8+
 loDDg/qQRc3KMrtDDn5KnBG+g2X7e6Z17zSyVmjd/Cy4Ygg/zPuM3X7RP7J04WpkQkC019exW
 A6HeWvSvI/4/3BXGx8xsgcGYEwDs6vFrK9lWHnlxzSVjWwmOwXhoG5Sm6gpMP5nkjMbP0inwo
 n+TQhS6i9Cxl8VLAL7gP1qFTuR4uBoL0iMeVRKb8Ej1KpFOmImiB04cORNmIOLMlIZwl3sLjZ
 9T3u738ZckAnS0cE7yALGh6uif/D10BOo4WGBMa4vxfVZ2PxyDgdUjdmDU0OzyFf66W2LS7SB
 bVNdtUQkMufFwZBsP/7t/uz0xc+deDtLPrvZBSYO7GyU82DY+NCrzfxv5vZky4s4WsoWPUyi6
 2p0pzDkSUvQTXZJTFg3Rc8=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 30, 2021 at 7:08 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The code is only safe if the analysis that says we can move si_trapno
> and perhaps the ia64 fields into the union is correct.  It looks like
> ia64 much more actively uses it's signal extension fields including for
> SIGTRAP, so I am not at all certain the generic definition of
> perf_sigtrap is safe on ia64.
>
> > I suppose in theory sparc64 or alpha might start using the other
> > fields in the future, and an application might be compiled against
> > mismatched headers, but that is unlikely and is already broken
> > with the current headers.
>
> If we localize the use of si_trapno to just a few special cases on alpha
> and sparc I think we don't even need to worry about breaking userspace
> on any architecture.  It will complicate siginfo_layout, but it is a
> complication that reflects reality.

Ok.

> I don't have a clue how any of this affects ia64.  Does perf work on
> ia64?  Does perf work on sparc, and alpha?
>
> If perf works on ia64 we need to take a hard look at what is going on
> there as well.

ia64 never had perf support. It had oprofile until very recently, and it
had a custom thing before that. My feeling is that it's increasingly
unlikely to ever gain perf support in the future, given that oprofile
(in user space) has required kernel perf support (in kernel) for a
long time and nobody cared about that being broken either.

sparc64 has perf support for Sun UltraSPARC 3/3+/3i/4+/T1/T2/T3
and Oracle SPARC T4/T5/M7 but lacks support for most CPUs from
Oracle, Fujitsu and the rest, in particular anything from the last
ten years.
Alpha has perf support for EV67, EV68, EV7, EV79, and EV69, i.e.
anything from 1996 to the end in 2004.

      Arnd
