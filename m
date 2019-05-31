Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE63B31103
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEaPMQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 11:12:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43259 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaPMQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 11:12:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so7927435oie.10
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Qecf3R/ylaKOMr7DmXC4K+hYJVpsjs/jTI03UY5jdQ=;
        b=nXGiYMKOLA7YGgplBCRIJzpPWLDIZmGlt9K/TwWZDoSmIE/xQoxoZfIXKz4vHURMoI
         rFjo5oJuFv90ZQpZy3iSNNRnvbwKqzrNOjUdM8MNHpP0eyrAEsLzQZFxd91a4t0d7szi
         7b2+8Hk3lvVFDPLYe3C6Lt4GXeBISmr+cs40tDKOsMU893Q4nDV6nDyx87nsOvsgrQ9V
         dT4HOBylvnvTVmlbms02uM9BzQvQi0k20BIF+ujGx31brk+Y2rsuPdrauCAV5FdqxiJ2
         8FCKq83x/1gThxBVLdDMSuRRQC6vxWyrz+OcdkOjkNiDLZXADVqgAd5kfmIXdOtPqvuY
         CMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Qecf3R/ylaKOMr7DmXC4K+hYJVpsjs/jTI03UY5jdQ=;
        b=JxF1bj/SGo1pKiH99rSc8x1kz0hE5XejDhPRIZcDFfzGVdiZxHpBSMUGxaZ9ve+EJQ
         ttjZkKbyrEIJ7zadlJKSR43VJ6YGY6CNWMkzeBPb+OCtZWuz6Wr29Ys6Ua17LwRENGMl
         OEKzBz3/5g+mHNFAVACo0rFsZG+fZ4/o6cByIO/BT4f54HHJAt2kXLc9tfOFbhaTkmpz
         wSx3tNTViZRUsOJzAYjmgL9CwGAsN7e2TA8SyoJLpFNleAUSUSM9alz2S6Wlpkml8g1J
         87xbmP7MJGiVPrK0D1VudyfeNrLCWCuYgF6p5kZiFtQDOgXAAe9uiayV26FjW6LSjyDo
         f+jw==
X-Gm-Message-State: APjAAAWb/VLXiWkPTWaITh9+qiXXag86FiRP/bQZqD9mHh7lHOI3H3op
        93ctpf93yU5tJJwWrUQhATDEtB4uWTVmhXlEzCMmPw==
X-Google-Smtp-Source: APXvYqz2u/BFQpedb+wPDZ0V+HO0iENm7b7iW0qYSXm5W7S4qdLUCWpDFuo2g4YKBqRxd03ZFgRnvyjAy0IrgDzGoZs=
X-Received: by 2002:aca:e044:: with SMTP id x65mr6446367oig.70.1559315535037;
 Fri, 31 May 2019 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190529141500.193390-1-elver@google.com>
In-Reply-To: <20190529141500.193390-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 31 May 2019 17:12:03 +0200
Message-ID: <CANpmjNNH2e5YpxKymXE0sTgcrrW0z0EP+dEsPJOfTQJ19yS_Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bitops instrumentation for KASAN
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Addressed comments, and sent v3:
http://lkml.kernel.org/r/20190531150828.157832-1-elver@google.com

Many thanks!

-- Marco

On Wed, 29 May 2019 at 16:23, Marco Elver <elver@google.com> wrote:
>
> The previous version of this patch series and discussion can be found
> here:  https://lkml.org/lkml/2019/5/28/769
>
> The most significant change is the change of the instrumented access
> size to cover the entire word of a bit.
>
> Marco Elver (3):
>   lib/test_kasan: Add bitops tests
>   x86: Move CPU feature test out of uaccess region
>   asm-generic, x86: Add bitops instrumentation for KASAN
>
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/ia32/ia32_signal.c               |   9 +-
>  arch/x86/include/asm/bitops.h             | 210 ++++----------
>  include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
>  lib/test_kasan.c                          |  75 ++++-
>  5 files changed, 450 insertions(+), 163 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
