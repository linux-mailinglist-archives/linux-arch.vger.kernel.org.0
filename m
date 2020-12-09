Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB5D2D4236
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbgLIMgw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 07:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbgLIMgw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Dec 2020 07:36:52 -0500
X-Gm-Message-State: AOAM531lcvJWszY8TeZExBsZo9FNXNZjC7fe3OwVODTwKPeXk2KM7BRZ
        jiCx7zUz/SzbObX35GEbKAI08Z9QnJzCQoIHG+Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607517371;
        bh=dVBkGQUoTPNqVA5YcFV16WWbYR7ZgobhVlfqccPyMMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QMe8TgyKwG5RwbJWODTsjgFzwi7is/hUW972TN+CJAC8OlmQTclwY4t4o3NpXBDen
         G0FZuP+wTgQyvKgL79TEeCn1xOpdP8R8eG9kiwnhftkhAUWq2DeAENsJ/WJCalSLmX
         6cYxEmgX1SFU23nljhFb8v34P9oCzJdB7O0pfYlFcNm09dy3tMYMu5b+nJNemYg5Sz
         N7hPMfIRDgpX2Vf/yRRJs7pwXzkUocC+4s1HqFvwpZN6Pp6qIDvgykV8o5KmXOZbzW
         jmOKI+zRp3XRk3yA4qFqD3H9SW9YHyARfxSDwYAuQREW1ncN6x1r02319tc+Dk+0gL
         A9YLQ1OTuXCgg==
X-Google-Smtp-Source: ABdhPJxvu8VJ4GLgSxlL8PXYZCRvk4pfoOrnmTaMOFmBWsnewmHehKYFMo7e2TQQj/VWUA2w/j4fFIk9/YjD+eZwBUs=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr1530396oth.210.1607517370870;
 Wed, 09 Dec 2020 04:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com> <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
In-Reply-To: <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Dec 2020 13:35:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2DYDCjkqf7oqWFfBT_=rjyJGgnh6kBzUkR8GyvxsB6uQ@mail.gmail.com>
Message-ID: <CAK8P3a2DYDCjkqf7oqWFfBT_=rjyJGgnh6kBzUkR8GyvxsB6uQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 8, 2020 at 1:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> - one build seems to have dropped all symbols the string operations
> from vmlinux,
>   so while the link goes through, modules cannot be loaded:
>  ERROR: modpost: "memmove" [drivers/media/rc/rc-core.ko] undefined!
>  ERROR: modpost: "memcpy" [net/wireless/cfg80211.ko] undefined!
>  ERROR: modpost: "memcpy" [net/8021q/8021q.ko] undefined!
>  ERROR: modpost: "memset" [net/8021q/8021q.ko] undefined!
>  ERROR: modpost: "memcpy" [net/unix/unix.ko] undefined!
>  ERROR: modpost: "memset" [net/sched/cls_u32.ko] undefined!
>  ERROR: modpost: "memcpy" [net/sched/cls_u32.ko] undefined!
>  ERROR: modpost: "memset" [net/sched/sch_skbprio.ko] undefined!
>  ERROR: modpost: "memcpy" [net/802/garp.ko] undefined!
>  I first thought this was related to a clang-12 bug I saw the other day, but
>  this also happens with clang-11

It seems to happen because of CONFIG_TRIM_UNUSED_KSYMS,
which is a shame, since I think that is an option we'd always want to
have enabled with LTO, to allow more dead code to be eliminated.

       Arnd
