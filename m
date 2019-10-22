Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D8E0B53
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2019 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfJVSR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Oct 2019 14:17:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33860 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbfJVSRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2019 14:17:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so15069681oii.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2019 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOpu0OseuiXc08mdI69tOPOopIwWTdbk8nIc2lokKaQ=;
        b=XJgdWmt1Fb01rtimxVs7UGUgg2nNjFELzvqXbKwOR2N0+RlvYp+1STsURqwktcTbn2
         CYNMx5zkYFWeJy9Pp1crLJpMWkAa9lnFUFosfymwVkAw2Zg93wYs5IZnlIcSzzVhtZF0
         FUS8z+oUFT8cShOthSahN28+4Ofg9kOnVmr4aZbNmLi3ccowGggxISCVpdu0yGs+4dht
         HEvSGx4jDzphsM83UtxMqUGmYRC24HTm+icekjZvloyRwMHGGcP1JG6vcTt90amPncwd
         0BBPZwnc6ueQxoqkD5kc4oeuKHk0+UEm4XXoClIYHx9pYHlHK6zhE2OqzSStqn3lR46/
         b6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOpu0OseuiXc08mdI69tOPOopIwWTdbk8nIc2lokKaQ=;
        b=EAW6KydFvj4MQ94LAfr5fazAfTeQFRvkha4zoA8nAun7vz6qKWlgqJLqkjYqU26jvE
         ljuEfndsY7VzvnLkZGojYbGBNR7zNiCCa0ZnesIqhFe5NZMttwxO0ASrAJPf/MjwXXiw
         eEcA6x0G5aSGH0TWBosBZBjzVlqJxoRNutcBJB0csX/WwRzKXoaaG2W4lkLhhyByGsky
         iH9Qh+3KQwnE7DwV/C0XoPGx9ttf0snM0nrSpxj8xZo75uYOax33geib5vpRgK9sU92l
         9xzJHmMZvpqZndtzATXdRbtnGzHg343zVWJc9u9PyZ0ZgwRYOeHWOISprddd4gUh9AXi
         dLdg==
X-Gm-Message-State: APjAAAWaKoRJxj3CVLbi2JDpsqYRXiBd2dagfxgflO1Aj8SkPrl4Sq14
        iIAmTU9w9MDsiLRj8OLj4h6G2mp3QrtouBX2kxPD/g==
X-Google-Smtp-Source: APXvYqzX+UBLuSqSX7xu+0iFpX/BMy6QMySPZgTjJ3NU0aDX6ipn2ST8I/CCQJ5VPBJ/kifUvNY+rliR1JaUu8riJKw=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr4195346oic.70.1571768274619;
 Tue, 22 Oct 2019 11:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-8-elver@google.com>
 <20191022123329.GC11583@lakrids.cambridge.arm.com>
In-Reply-To: <20191022123329.GC11583@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Oct 2019 20:17:43 +0200
Message-ID: <CANpmjNOhoyDMFMUz6by3hLtX7aBFk4pXTmzjmWYiq2+z+R5fAQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] locking/atomics, kcsan: Add KCSAN instrumentation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 22 Oct 2019 at 14:33, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 17, 2019 at 04:13:04PM +0200, Marco Elver wrote:
> > This adds KCSAN instrumentation to atomic-instrumented.h.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Use kcsan_check{,_atomic}_{read,write} instead of
> >   kcsan_check_{access,atomic}.
> > * Introduce __atomic_check_{read,write} [Suggested by Mark Rutland].
> > ---
> >  include/asm-generic/atomic-instrumented.h | 393 +++++++++++-----------
> >  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
> >  2 files changed, 218 insertions(+), 192 deletions(-)
>
> The script changes and generated code look fine to me, so FWIW:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Great, thank you Mark!

> Thanks,
> Mark.
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index e09812372b17..8b8b2a6f8d68 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -20,7 +20,7 @@ gen_param_check()
> >       # We don't write to constant parameters
> >       [ ${type#c} != ${type} ] && rw="read"
> >
> > -     printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
> > +     printf "\t__atomic_check_${rw}(${name}, sizeof(*${name}));\n"
> >  }
> >
> >  #gen_param_check(arg...)
> > @@ -107,7 +107,7 @@ cat <<EOF
> >  #define ${xchg}(ptr, ...)                                            \\
> >  ({                                                                   \\
> >       typeof(ptr) __ai_ptr = (ptr);                                   \\
> > -     kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));          \\
> > +     __atomic_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));               \\
> >       arch_${xchg}(__ai_ptr, __VA_ARGS__);                            \\
> >  })
> >  EOF
> > @@ -148,6 +148,19 @@ cat << EOF
> >
> >  #include <linux/build_bug.h>
> >  #include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +
> > +static inline void __atomic_check_read(const volatile void *v, size_t size)
> > +{
> > +     kasan_check_read(v, size);
> > +     kcsan_check_atomic_read(v, size);
> > +}
> > +
> > +static inline void __atomic_check_write(const volatile void *v, size_t size)
> > +{
> > +     kasan_check_write(v, size);
> > +     kcsan_check_atomic_write(v, size);
> > +}
> >
> >  EOF
> >
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
