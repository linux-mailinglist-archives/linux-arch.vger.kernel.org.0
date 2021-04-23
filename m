Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886F4368F36
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhDWJKq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 05:10:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhDWJKp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 05:10:45 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MowT0-1lGW6A2OII-00qRVk; Fri, 23 Apr 2021 11:10:08 +0200
Received: by mail-wm1-f52.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so791858wmd.3;
        Fri, 23 Apr 2021 02:10:08 -0700 (PDT)
X-Gm-Message-State: AOAM532chMh6sJsAcm+oUrzm8Ae8Az9gpXb/2TuiZs5DFqp38z8D7FPK
        bElUy7UyBdp2bgZ3qWQBfxq0I+HXzYCqnPsHpoI=
X-Google-Smtp-Source: ABdhPJwG4iISCun3SMeBT+lGNcPYknZCmZ8DGhKtLsTvEtKKUMDsbx2MeJ/NM+0B7i+dYTrSWag9p/pB+JkKtkFk9/E=
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr4574759wmf.84.1619169008193;
 Fri, 23 Apr 2021 02:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210423025545.313965-1-palmer@dabbelt.com>
In-Reply-To: <20210423025545.313965-1-palmer@dabbelt.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 23 Apr 2021 11:09:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+yCYm22g-r7aWE4RT7ZLcZn89aiWGcDhgFh_ZU3fSfQ@mail.gmail.com>
Message-ID: <CAK8P3a2+yCYm22g-r7aWE4RT7ZLcZn89aiWGcDhgFh_ZU3fSfQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: Remove asm/setup.h from the UABI.
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v5dXW3kRmXrqrQDdVtMA5jZn00BZqD+wIKeyF2uVwTkYnhHl22m
 wZoZtbrL9Do5qpR8fzXf0DeyQPAd/nIxdVsOw5fggNDxWgQxXePgIdHmTJXDWchW/h0mzbf
 Nl7JPwSKbtLGMAUiSAzF9Mzg4NRP8qWPEmI6DZXvvgKql44UkuTR7jPYblJi2Sp+tEt4b4i
 HZT+KFxt+/tHmu7BjRaqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LCMt4R5q5Es=:5e9FOZecZpffL9T4kLM+DJ
 7cDMldASflKRsXrwTJIkA40KhvPmRyckowRnJD3m6QYePZFfgneSrLSS3pxPPTk4Pxid8nx4O
 gm0furu3T/9UXlhf7COkuJhQ472LQ10vthcgqGIqmpso02j51A2wtbGIdR41Qy8KZejo+TJZd
 8VhYVemxU3IyQBeJWwazBxUujLsYnNcmg3EXMmqAE0SUVPNsUQ9X10ecwvYFcdTiT1Zd3cFCZ
 LDkblgF+bThVr7JlQSg+Elx/34ut7Au/OhHg8kxZtqvq0Q859o7ytmpzgpE/VpI+VRy6bHTFq
 1H2GMrf/bUy2bGUNq8kwKW32T7G9mmZMt7ZOj46Oh2bV2xZr/xqeOPLL5VeFccoDVJPwevDWF
 3tDCIcyz7VaBT8uqzAxIykuVX97uKQKeh2l+No5/+HPXoAdH+nJVs7PStENPiHtsKlIOMukBa
 9+D5bg5v8D90hgEGfTGz4S//nJ4He+sC3sabELmEBmlD27ULAHlF4ou+kxVmqcyO9Ch4RCKij
 8uYbdRJf3nksi5wzPqN48g=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 23, 2021 at 4:57 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> I honestly have no idea if this is sane.
>
> This all came up in the context of increasing COMMAND_LINE_SIZE in the
> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
> maximum length of /proc/cmdline and userspace could staticly rely on
> that to be correct.
>
> Usually I wouldn't mess around with changing this sort of thing, but
> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
> increasing, but they're from before the UAPI split so I'm not quite sure
> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
> asm-generic/setup.h.").
>
> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
> part of the UABI to begin with, and userspace should be able to handle
> /proc/cmdline of whatever length it turns out to be.  I don't see any
> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
> search, but that's not really enough to consider it unused on my end.
>
> I couldn't think of a better way to ask about this then just sending the
> patch.

I think removing asm/setup.h from the uapi headers makes sense,
but then we should do it consistently for all architectures as far
as possible.

Most architectures either use the generic file or they provide their
own one-line version, so if we move them back, I would do it
for all.

The architectures that have additional contents in this file
are alpha, arm, and ia64. We I would leave those unchanged
in that case.

        Arnd
