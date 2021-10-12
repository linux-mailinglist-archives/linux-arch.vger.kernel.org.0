Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651DD429F3E
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhJLIF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 04:05:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbhJLIE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Oct 2021 04:04:59 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N79dk-1modbE1Gyy-017XEI; Tue, 12 Oct 2021 10:02:20 +0200
Received: by mail-wr1-f51.google.com with SMTP id t2so64174143wrb.8;
        Tue, 12 Oct 2021 01:02:20 -0700 (PDT)
X-Gm-Message-State: AOAM5333NWVmRBnXyPhxCAmCQ8zqHX9PBpgvMypkJdXecIJMPCfMQk2D
        exqKrSIpzxC+3EiCg779d1v0djB2iUCmWub9t0U=
X-Google-Smtp-Source: ABdhPJwnvZ0Y6Hum+PqySTSqvTb9cKPN3NBY9WwyA3F69Xi/jCmvpemQKNAXUmqZQmtOtxFaHVKwRHP1wYX1RAaUqTk=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr29708426wrc.71.1634025739862;
 Tue, 12 Oct 2021 01:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <8ff3ec195d695033b652e9971fba2dc5528f7151.1633964380.git.christophe.leroy@csgroup.eu>
 <878ryy7m6v.fsf@mpe.ellerman.id.au>
In-Reply-To: <878ryy7m6v.fsf@mpe.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Oct 2021 10:02:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a09azJ0fshthGeOqK92uaYJ+m39Yg1=YQav=n9n_PNt5w@mail.gmail.com>
Message-ID: <CAK8P3a09azJ0fshthGeOqK92uaYJ+m39Yg1=YQav=n9n_PNt5w@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] powerpc: Move 'struct ppc64_opd_entry' back into asm/elf.h
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yWovA4xFHXCdec2vwhNwd4ed+nFne9Z96w2EX6d6THi19mSK8af
 XP8WMQqADcsOO/L8qwhfEqQFmwO1v5g50c2Newwu779BRowwrh4r45t/GLVCntJSyOD0BzD
 /AiiyMxjFww3Iq0jr04gzRYk4qmcW4tQ4sPVciim0rLJsexYhHl+ASYgaGJ8gDMAtTpMdP1
 4UU2fWf7cdojMSm61FkkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kp+0B6VJEgI=:Czud6PwGLoY1fUn+FZTsdd
 aQbxFDU5/afe/8iUfE1AJnCrROBXEXaJjzz3dYdDrFWjUVU31A0pU9AXSr4JH5l7lKs8T/L54
 Uuroo87Aqm216whhNrz10d5ra2l13zd5UfE4c9GYuykXdksRUMayX2s2TIJofaWEUk5pDNS6A
 Qqm05Tp2bqughRz5Rt1R+8ShKKj68ofHBiMnSjqaU92gsd+x2oqE8kGvy+dTm8YQfAWh2VYIH
 EwkYTpa18zTlE+W+JkTrkH3/qEcUfbGZkisHMiHHJfsKPXpB0uV9rXmr6IqdLBqcz5oXOb0JU
 CPweMZ32DxMYyCLIOcJDehvRYJ/2Dghctr673kbCYD7i8c/A/joFETg5Zv6sKPF7gCKwtMIHe
 5sG9XMbhIgpdvzjeJCaeTJiW1qIcQFWNk3RDwznONDtGiTNRtkJZiFU1n4CqAQ1MH47Q3ip4P
 PXb1A+RGYIFktOMNu4hU4YEBlhe38J/h9oIwQA9tqNqe+xH1+DeDnE68jTAoT8rC0SHaax4nT
 28cYi15qlvaNiuA4O1zSxjAfP+D1SHb+81G82BDE8JIsp5DImlWNOE7xQwu7BYPN0u+DkivKy
 i3b5fJm1U41qPQYdeOCrV0GfuNI6tCG6YBlNDkENQyb8vQcek60trcJbNlHYeLkgJ96oqMJdM
 3/pgoIJYBy54t2fXpX6jHK1ZN76eifywjAsxnjSccE/ultNEnCeXMbaraDfAemPENoHdffdRW
 9ryFNi/tEti8gWBtv9iXEUqkWBH6NW8k0lbN7uVN1H+mDt4p+yLEvA0c06+ARGwpSPT/CTAYP
 3XEYjZ4ajQBV67HOHWDnnRya902mAw45XpsGDVHy0VHT8xsWOzpBZDo84TQvzRJ5EoEv4n96U
 sS/T2X02YgjUvhgzlDFg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 12, 2021 at 9:10 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > 'struct ppc64_opd_entry' doesn't belong to uapi/asm/elf.h
> > But it was by mistake added outside of __KERNEL__ section,
> > therefore commit c3617f72036c ("UAPI: (Scripted) Disintegrate
> > arch/powerpc/include/asm") moved it to uapi/asm/elf.h
>
> ... it's been visible to userspace since the first commit moved it, ~13
> years ago in 2008, v2.6.27.
>
> > Move it back into asm/elf.h, this brings it back in line with
> > IA64 and PARISC architectures.
>
> Removing it from the uapi header risks breaking userspace, I doubt
> anything uses it, but who knows.
>
> Given how long it's been there I think it's a bit risky to remove it :/

I would not be too worried about it. While we should absolutely
never break existing binaries, changing the visibility of internal
structures in header files only breaks compiling applications
that do rely on these entries, and they really should not be using
this in the first place.

        Arnd
