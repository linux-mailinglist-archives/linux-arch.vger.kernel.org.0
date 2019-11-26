Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0829A109FDF
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 15:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZOGg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 09:06:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37952 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfKZOGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 09:06:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id z25so15967797oti.5
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPOiBiMl69XGQDBmycxuawKOxsJQrxoI/O+sj/Y0vXA=;
        b=Dw4HY62q40JV7BWYlZLIGz6S96Cm9bMj0Wo2km15nIQqLH4Zz1BRw3dQ/buGO6/QKT
         VAbL+EQPXdreE9r3cyH9Y7aYzcgZf8ZuiXYYqVpXYxvEyEh5NLsVoyP8FArwOm09+epk
         gbIh/Fl1NfFWge9SfqKz7ndd/sLU9KZJcMEDZBGdVCuoZ8nCvXWlEOrKEWAOYcYqri93
         wqwjrAwg+1XtW+uHIGzIdS77RKa+gCzdoD0D8cJRnlKqu+6hVW+bkhPk8k8nNsZhxRqs
         F1wa6fQYMHOJd5trEjadiYOAr2PEXZpG4NiGuCyL7x8vnRQYbV8O9/sUvVNCWtyunhXH
         BBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPOiBiMl69XGQDBmycxuawKOxsJQrxoI/O+sj/Y0vXA=;
        b=YIxlviGSiQznfzyNK0WQLNZeCTYLmivI2auPvTKFQwTbkthqGmQJmqgBI4eAH8vKuc
         YqMATaH6bZ6vLDGvTL647DqaSIwV/+YoFaWHbe7tbv2zddj9BwzwZqe+GHHSsL9e1MBw
         H/6IE8GBklji0Dhq4feW3V0/+rUuVnP3d8qeJf5nyDp7rRuxJUUCYAhgbOIXnF2+iu17
         9Dq+BIDBhF/jXnD7ExrQso99ukpwcJ1MiO9ymcZGdwsc+pUt4zhQ7UNnOhbM8PdHt9hV
         TifTxkDiMCP6SzhH35rIgKg4+DeYpFAVFUaEH0eE1t5GqsuLVqVOzd/wfa1J5we13FNu
         JEYA==
X-Gm-Message-State: APjAAAVrr25P2DSzX3Pafnffzc7E6E/jTBsrJ+b9oETnYaEktOq6MfFf
        kGH8KjnbBQBcW6tcDK6YXmsIt8wtmhNtwe5yvDbqWQ==
X-Google-Smtp-Source: APXvYqxQUDki0G777xbpVnHTwhAQtWrn/BxMVnfhOt5W+/tfF//ioxeA1d3s8ro9+Sm8jQrl5lXWfhJFgjrYUCro9ZI=
X-Received: by 2002:a9d:8d2:: with SMTP id 76mr25447839otf.17.1574777192640;
 Tue, 26 Nov 2019 06:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20191126114121.85552-1-elver@google.com> <20191126122917.GA37833@lakrids.cambridge.arm.com>
In-Reply-To: <20191126122917.GA37833@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 Nov 2019 15:06:21 +0100
Message-ID: <CANpmjNNcWujm-Q8WD2Lgf2ww5aG-kfmFca7YC96BdcFOkwgxXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] asm-generic/atomic: Use __always_inline for pure wrappers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 26 Nov 2019 at 13:29, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Nov 26, 2019 at 12:41:19PM +0100, Marco Elver wrote:
> > Prefer __always_inline for atomic wrappers. When building for size
> > (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> > inline even relatively small static inline functions that are assumed to
> > be inlinable such as atomic ops. This can cause problems, for example in
> > UACCESS regions.
> >
> > By using __always_inline, we let the real implementation and not the
> > wrapper determine the final inlining preference.
> >
> > For x86 tinyconfig we observe:
> > - vmlinux baseline: 1316204
> > - vmlinux with patch: 1315988 (-216 bytes)
> >
> > This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> > in the KCSAN runtime:
> > http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Add missing '#include <linux/compiler.h>'
> > * Add size diff to commit message.
> >
> > v1: http://lkml.kernel.org/r/20191122154221.247680-1-elver@google.com
> > ---
> >  include/asm-generic/atomic-instrumented.h | 335 +++++++++++-----------
> >  include/asm-generic/atomic-long.h         | 331 ++++++++++-----------
> >  scripts/atomic/gen-atomic-instrumented.sh |   7 +-
> >  scripts/atomic/gen-atomic-long.sh         |   3 +-
> >  4 files changed, 340 insertions(+), 336 deletions(-)
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index 8b8b2a6f8d68..86d27252b988 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -84,7 +84,7 @@ gen_proto_order_variant()
> >       [ ! -z "${guard}" ] && printf "#if ${guard}\n"
> >
> >  cat <<EOF
> > -static inline ${ret}
> > +static __always_inline ${ret}
> >  ${atomicname}(${params})
> >  {
> >  ${checks}
> > @@ -146,17 +146,18 @@ cat << EOF
> >  #ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
> >  #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
> >
> > +#include <linux/compiler.h>
> >  #include <linux/build_bug.h>
>
> Sorry for the (super) trivial nit, but could you please re-order these
> two alphabetically, i.e.
>
> #include <linux/build_bug.h>
> #include <linux/compiler.h>
>
> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Done, thanks for the acks!

v3: http://lkml.kernel.org/r/20191126140406.164870-1-elver@google.com

> [...]
>
> > @@ -64,6 +64,7 @@ cat << EOF
> >  #ifndef _ASM_GENERIC_ATOMIC_LONG_H
> >  #define _ASM_GENERIC_ATOMIC_LONG_H
> >
> > +#include <linux/compiler.h>
> >  #include <asm/types.h>
>
> Unlike the above, this doesn't need to be re-ordered; for whatever
> reason, linux/* includes typically come before asm/* includes.
>
> Thanks,
> Mark.
