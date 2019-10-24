Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519B1E355E
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405890AbfJXOR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 10:17:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40145 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405906AbfJXOR0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 10:17:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id d8so9598274otc.7
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8i+kPsaZWRIBXyQ2g5/YSOuQEjiriODMzIUUPGICqQ=;
        b=rjhd/M55ZS2DHpPVEyvmw+51VqoZKT+aKpBMcndrlavHNG5q2vOXiJVQS+s8EXv9Dd
         iCsoOVhsJ+G7gYkpFkn14zYdOpz0vSBpUzDsDu0PBCQ6NzT8xUq5cmrA4xocXCdFwB2z
         OY76EBmbTCadlVIzDU0S3rEb6LzKAsP2pySsCW8pNgaKuG8yg1KYKhaeOwpjz6pjIre3
         ZEktUEMMOiAjH3feXIg6+YO0mzPvWpCriPh+vEPfhR6gnJPhxdJyw0QnglSg76VNRtTS
         8IVxVkGqkZRoWCHuKSqjF3oWPtlHkYAoqyjWFNbEZcdU6FuP7HsXigSzaREmQGaHV4Ln
         7pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8i+kPsaZWRIBXyQ2g5/YSOuQEjiriODMzIUUPGICqQ=;
        b=da/WavTfZmAE7SQajDTegBBH1kXR1wgxuUvyY+yd6SyP4OmhiqkmgA6+DpipE4KEdj
         BSUP2qs+lz/Va9PHArCo8FlZRAMWQPVD1pI/YlY88tqH0vDMZ+glGTSp/ttW9TwwefFO
         P6DTYHQ5Et5x45pUk/jlc4UF7O6zKtm9LLMsEWz0yt/GpWuVX8lT3ohT5SSbneQcLT4f
         dGVe5ew23ebvanKV1yFl4NhAisXUyKW3IpBqqbwqkklU+kXM5vKB7nOVFKH30bAXXxIE
         nrCyidj9E2XwKSM8huTfv9cAZ2KWohpGJ5cIPKh5+VYMRuVysE86KFYnEl2cbG+S9cHD
         4BLA==
X-Gm-Message-State: APjAAAVViGbtZNCj17kZKLjIWCMieHzMAFPxy2PFq7T6HaIXBWdQCmwi
        9IntPy1DGR2vpHutTTec/AfZOTAkKmN3TzKa80g4bw==
X-Google-Smtp-Source: APXvYqzNSa3dJF91Ue/oxJ5CO5LETslsoJo48bQPunzQ1TmiLszytnOsFp8RpLz63hx9k13on0dq1OrbCD1kyNZI6S8=
X-Received: by 2002:a9d:5f0f:: with SMTP id f15mr11239283oti.251.1571926644575;
 Thu, 24 Oct 2019 07:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-5-elver@google.com>
 <20191024122801.GD4300@lakrids.cambridge.arm.com>
In-Reply-To: <20191024122801.GD4300@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Oct 2019 16:17:11 +0200
Message-ID: <CANpmjNPFkqOSEcEP475-NeeJnY5pZ44m+bEhtOs8E_xkRKr-TQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] seqlock, kcsan: Add annotations for KCSAN
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

On Thu, 24 Oct 2019 at 14:28, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 17, 2019 at 04:13:01PM +0200, Marco Elver wrote:
> > Since seqlocks in the Linux kernel do not require the use of marked
> > atomic accesses in critical sections, we teach KCSAN to assume such
> > accesses are atomic. KCSAN currently also pretends that writes to
> > `sequence` are atomic, although currently plain writes are used (their
> > corresponding reads are READ_ONCE).
> >
> > Further, to avoid false positives in the absence of clear ending of a
> > seqlock reader critical section (only when using the raw interface),
> > KCSAN assumes a fixed number of accesses after start of a seqlock
> > critical section are atomic.
>
> Do we have many examples where there's not a clear end to a seqlock
> sequence? Or are there just a handful?
>
> If there aren't that many, I wonder if we can make it mandatory to have
> an explicit end, or to add some helper for those patterns so that we can
> reliably hook them.

In an ideal world, all usage of seqlocks would be via seqlock_t, which
follows a somewhat saner usage, where we already do normal begin/end
markings -- with subtle exception to readers needing to be flat atomic
regions, e.g. because usage like this:
- fs/namespace.c:__legitimize_mnt - unbalanced read_seqretry
- fs/dcache.c:d_walk - unbalanced need_seqretry

But anything directly accessing seqcount_t seems to be unpredictable.
Filtering for usage of read_seqcount_retry not following 'do { .. }
while (read_seqcount_retry(..));' (although even the ones in while
loops aren't necessarily predictable):

$ git grep 'read_seqcount_retry' | grep -Ev 'seqlock.h|Doc|\* ' | grep
-v 'while ('
=> about 1/3 of the total read_seqcount_retry usage.

Just looking at fs/namei.c, I would conclude that it'd be a pretty
daunting task to prescribe and migrate to an interface that forces
clear begin/end.

Which is why I concluded that for now, it is probably better to make
KCSAN play well with the existing code.

Thanks,
-- Marco

> Thanks,
> Mark.
>
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/seqlock.h | 44 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index bcf4cf26b8c8..1e425831a7ed 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -37,8 +37,24 @@
> >  #include <linux/preempt.h>
> >  #include <linux/lockdep.h>
> >  #include <linux/compiler.h>
> > +#include <linux/kcsan.h>
> >  #include <asm/processor.h>
> >
> > +/*
> > + * The seqlock interface does not prescribe a precise sequence of read
> > + * begin/retry/end. For readers, typically there is a call to
> > + * read_seqcount_begin() and read_seqcount_retry(), however, there are more
> > + * esoteric cases which do not follow this pattern.
> > + *
> > + * As a consequence, we take the following best-effort approach for *raw* usage
> > + * of seqlocks under KCSAN: upon beginning a seq-reader critical section,
> > + * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
> > + * atomics; if there is a matching read_seqcount_retry() call, no following
> > + * memory operations are considered atomic. Non-raw usage of seqlocks is not
> > + * affected.
> > + */
> > +#define KCSAN_SEQLOCK_REGION_MAX 1000
> > +
> >  /*
> >   * Version using sequence counter only.
> >   * This can be used when code has its own mutex protecting the
> > @@ -115,6 +131,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
> >               cpu_relax();
> >               goto repeat;
> >       }
> > +     kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> >       return ret;
> >  }
> >
> > @@ -131,6 +148,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
> >  {
> >       unsigned ret = READ_ONCE(s->sequence);
> >       smp_rmb();
> > +     kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> >       return ret;
> >  }
> >
> > @@ -183,6 +201,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
> >  {
> >       unsigned ret = READ_ONCE(s->sequence);
> >       smp_rmb();
> > +     kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> >       return ret & ~1;
> >  }
> >
> > @@ -202,7 +221,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
> >   */
> >  static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
> >  {
> > -     return unlikely(s->sequence != start);
> > +     kcsan_atomic_next(0);
> > +     return unlikely(READ_ONCE(s->sequence) != start);
> >  }
> >
> >  /**
> > @@ -225,6 +245,7 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
> >
> >  static inline void raw_write_seqcount_begin(seqcount_t *s)
> >  {
> > +     kcsan_begin_atomic(true);
> >       s->sequence++;
> >       smp_wmb();
> >  }
> > @@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
> >  {
> >       smp_wmb();
> >       s->sequence++;
> > +     kcsan_end_atomic(true);
> >  }
> >
> >  /**
> > @@ -262,18 +284,20 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
> >   *
> >   *      void write(void)
> >   *      {
> > - *              Y = true;
> > + *              WRITE_ONCE(Y, true);
> >   *
> >   *              raw_write_seqcount_barrier(seq);
> >   *
> > - *              X = false;
> > + *              WRITE_ONCE(X, false);
> >   *      }
> >   */
> >  static inline void raw_write_seqcount_barrier(seqcount_t *s)
> >  {
> > +     kcsan_begin_atomic(true);
> >       s->sequence++;
> >       smp_wmb();
> >       s->sequence++;
> > +     kcsan_end_atomic(true);
> >  }
> >
> >  static inline int raw_read_seqcount_latch(seqcount_t *s)
> > @@ -398,7 +422,9 @@ static inline void write_seqcount_end(seqcount_t *s)
> >  static inline void write_seqcount_invalidate(seqcount_t *s)
> >  {
> >       smp_wmb();
> > +     kcsan_begin_atomic(true);
> >       s->sequence+=2;
> > +     kcsan_end_atomic(true);
> >  }
> >
> >  typedef struct {
> > @@ -430,11 +456,21 @@ typedef struct {
> >   */
> >  static inline unsigned read_seqbegin(const seqlock_t *sl)
> >  {
> > -     return read_seqcount_begin(&sl->seqcount);
> > +     unsigned ret = read_seqcount_begin(&sl->seqcount);
> > +
> > +     kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry */
> > +     kcsan_begin_atomic(false);
> > +     return ret;
> >  }
> >
> >  static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
> >  {
> > +     /*
> > +      * Assume not nested: read_seqretry may be called multiple times when
> > +      * completing read critical section.
> > +      */
> > +     kcsan_end_atomic(false);
> > +
> >       return read_seqcount_retry(&sl->seqcount, start);
> >  }
> >
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
