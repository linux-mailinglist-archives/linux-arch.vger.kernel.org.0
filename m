Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE5313B3DF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 21:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgANU6B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 15:58:01 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:43061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANU6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 15:58:00 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpDa5-1jRbhI13iJ-00qlZL; Tue, 14 Jan 2020 21:57:59 +0100
Received: by mail-qk1-f174.google.com with SMTP id j9so13607771qkk.1;
        Tue, 14 Jan 2020 12:57:58 -0800 (PST)
X-Gm-Message-State: APjAAAXcv/58nsBItD6xmmsBSbFGrgcAhJ2ogCVxYy6v/J+/treDGYjy
        zFL33cjSTSOG0tHMx7z47onwA5LDgup/Ci5Go3o=
X-Google-Smtp-Source: APXvYqwhg5lxdDG9hw24GdeXieaQIzqGf7tcgGAhb/t/luGZu0DMMqM2FGkeCDHJm3CEiDORiqOll/dN1rxk4xKyAcY=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr19031507qke.394.1579035478013;
 Tue, 14 Jan 2020 12:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-2-vgupta@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 21:57:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
Message-ID: <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kDnJNAh/DNMBSqFPq6pLI1Nlr9B0G9P4obBew/8vuXY0oVgXmJw
 Nv/q1RAtYWHD7iaYn6uj3/GYEEUDxyIzlxtWfs3swS+9vrwM3Eh7taZQFUCI2mVelJDhCAE
 wtNEg0QlQWgsWNv36ps92xCvtka8T7kKwUn3F5UcFCwdTahhU4Z6+pxS+X2fuB53MKKXo+j
 rzj+G8gQMcz7vn066OrPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S9alnY7jl0w=:QIO67bfjC+c2E4/f6+vfNp
 sJ83S1el6CRwhZ7PhMdRGEQKcFOtDl5Y8+W9V7P8KOOz9VgGezLClXFxuaSS+bvKFBdVNPEg/
 kPPr/qd2n3NlndzoFcyvs4MWwuNXWMXbrSFMig0xQFJy4caFeId5wlvbsK7BZoT23/BS6KK2R
 s1LyXTw/NVTJ5qtsvci9u26OVjoZkWyXchDOJ5ZaC+qu1LWF8oZH16Y1x6mDvX4vwWqluSl2M
 s80MQGJi+gZZgSU0T4nDXLhdUIlLrxbHzN6NHDhoGjeERHb4MvLwBjraNl+c2KZl5Mr7kijYa
 qg05/GoIAohm41IKuCYpICH+rLpAmOJ9Qw5JLS63qdZ5jJGoSTwz4VaE1DmOuGbL0UVuEKYO8
 WUiHKdqE5SfHz+qCdXuAi4Z3GLpbFoYrS+6n+mYQuRM4YGw/rV2ZVBmpHrRwyKyP/sWpaXtxL
 PBsTzOsJEcYDGadFblz0vFkbrRRnFoLS8rDQAoNEWhL01lUgMMZXHWlAZ54k8dte4a7c7guTu
 4w1BtCUZDvB3HFhYG8cmrJAbJPjxSf5KRUwwsSZOi/wnS+wO4suzZ3BZNhfVVtvRheUtqmo9b
 eNWQ/WvubyGsgJ7beGXOHWaZUrdxrCfur5ZekQer5UK9ttmZaSFAnDHJ9A6+Bfc6ffPtB+UO2
 0i3SLIHqs3OO1dSe1POh130jngV3WZny0LnDRnBALEtIcBugqY3vTu2FOJsQ7mfyJ2uxqSJj+
 OlBA6QA/Nl046q4hXHZVjKM9HKtCfnAwZ2Ui0Cil1yw2FicMvQmH+CB5jT3NBp7mzxbxyEbXO
 KjgSpY/RGYVGEeRdlEQ9SNfvLsmPUSELJRt0K5Xdu0aaWQWi3EpDDp/8DPewXZzzZ2FKOWaYb
 WVk3Mc5AlfvNp5qwBhng==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 9:08 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> There are 2 generic varaints of strncpy_from_user() / strnlen_user()
>  (1). inline version in asm-generic/uaccess.h
>  (2). optimized word-at-a-time version in lib/*
>
> This patch disables #1 if #2 selected. This allows arches to continue
> reusing asm-generic/uaccess.h for rest of code
>
> This came up when switching ARC to generic word-at-a-time interface
>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

This looks like a useful change, but I think we can do even better: It
seems that
there are no  callers of __strnlen_user or __strncpy_from_user  in the
kernel today, so these should not be defined either when the Kconfig symbols
are set. Also, I would suggest moving the 'extern' declaration for the two
functions into the #else branch of the conditional so it does not need to be
duplicated.

      Arnd
