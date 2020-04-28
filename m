Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583BA1BC47A
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgD1QFW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 12:05:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgD1QFW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 12:05:22 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mqal4-1iq1KL0via-00mXI4; Tue, 28 Apr 2020 18:05:21 +0200
Received: by mail-lf1-f41.google.com with SMTP id y3so1734911lfy.1;
        Tue, 28 Apr 2020 09:05:21 -0700 (PDT)
X-Gm-Message-State: AGi0Pua4VbAhm36z1vDTJi/ZBPM9rfrNid34H3ekg8u3XA6iyzBCvNdw
        5ByqYXHWxNKgrVC2R+34zFEmysEZw7raUklJEwQ=
X-Google-Smtp-Source: APiQypLrh7goUYFCcrHRyRyMKDsyAveCKs6dCpTFYxufTmhSFxrioTA6Q8bARt9FHX/ytYSEYl2HA7MOF3TO7A8k8/I=
X-Received: by 2002:a19:40d0:: with SMTP id n199mr19399076lfa.161.1588089920707;
 Tue, 28 Apr 2020 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
In-Reply-To: <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Apr 2020 18:05:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2aXJRWjxWO8oMRX2AJkfeVeeoYbOPbpd9-UTgjqM4B7g@mail.gmail.com>
Message-ID: <CAK8P3a2aXJRWjxWO8oMRX2AJkfeVeeoYbOPbpd9-UTgjqM4B7g@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] powerpc/vdso: Provide __kernel_clock_gettime64()
 on vdso32
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KXW1vp4IRKpuGN24fAWiEMrLgVx6g1nnuyzT/+lteK2DmgDCz5A
 H3dK4oQYzrosbDrxY9whDSudBmPFIA251jhXDxPUv7a1c+zTZ4FSO9ENoBuX09O/pTvnXHk
 GUYmNivqqhhvDiemzYqK5YYB4ZWi5QPVS+qnD2tFYXZfNrW2442Tr0prPeYFD5TLMYToAcs
 JAFw70fU8A5C26OTpdYNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J3v//L4+2dE=:XtMZ0duPJdOdCkk+fjNIUH
 BoLHWrHDymzaPvMYmasOMjLO4zdgnqGlPf8kyhhNb8Lwb0sHffLdExpbBp3ww6JXul8Ir3Bw6
 dNe7rmzQsKOcZGTAR46eacLlafFCivO8b/xJGKiCboc5MqmTsneYsz6ZznH0V41DAEzo9Shb2
 R9mENcYu2nsGIPGmURP9tPMryWZQvTXnmUfftZ14C7bvIt8WXO4JWbLjHWvGv61srTDICdPS+
 Yjy/KLqELBu/VBRMVbcpvlyO/ljBSbfkvesJG3gyBLVRQCqaGdp1SFWTlRQfVZg4aUdzTxd2Y
 HWP89XUcXkRgpQpvZmBd+9fPBQvd3CtqG6YopSq0QFBNLPYos/9HYXD0AhHkTRBRgXnQ23lVo
 P5Z3RVg6Os5rVWkzlJPzEvZqgAwOyG0OCGfDL1AgoCmZkNsu9scDgls6EOZes+23454CYiFFF
 zgSXdKXd5SK7hy406i/ghO9mFc/cHH+zEYgblFIJmSEnAGjFODkB157tF0rkRcLTvBiTr5fBf
 uOA1oJP3JCue09DEpEMGvCnMWzp205gg3FqcYN7cVxNoQTfEwRZ1cn+ksmC4lj9XqkRA6n1tG
 kriwSzq4G+FQISxdwCE0xdA9MaH7Cz6vMqN+MWE5pC2RZ3C/x/qq5RASZrzZPSbbvUYRxAh0t
 qJBhrQOFov78VutJAU3f0tF6lQSgZnHKgQioQ4RQ8/oL3LGGMOW3XwyleRTAiBK7Oxe/Z3Iqj
 ehygLE6MqnkkHpRA6b1VleGT2GTimiWr/TYDAXG5lHDrRqOPjbUyI/HnrchfWDl9IjN5KVSW3
 Q++gBNh+yi9oXIben5eq1Haf+AD4vd/8tZlUJTqbWKQV/Z6Wk4=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 28, 2020 at 3:16 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Provides __kernel_clock_gettime64() on vdso32. This is the
> 64 bits version of __kernel_clock_gettime() which is
> y2038 compliant.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Looks good to me

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

There was a bug on ARM for the corresponding function, so far it is unclear
if this was a problem related to particular hardware, the 32-bit kernel code,
or the common implementation of clock_gettime64 in the vdso library,
see https://github.com/richfelker/musl-cross-make/issues/96

Just to be sure that powerpc is not affected by the same issue, can you
confirm that repeatedly calling clock_gettime64 on powerpc32, alternating
between vdso and syscall, results in monotically increasing times?

       Arnd
