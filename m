Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A47D9A24
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 21:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbfJPTeT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 15:34:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42922 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389303AbfJPTeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 15:34:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so21218174otd.9
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXr4UV4kEHsq0yeWfqjzxiqcNiJQEejUfsbyhCIH4rQ=;
        b=U7NFsQMFohcPs28AZ7A+6GhhiEGUKgu+5pnJk2F9HrfSIYZCF5qXVKvKhW5L+RoOHB
         jqP0typxYPq6W5WuAp2s6t9gy8ue0IU9qaNy4j1gM5uq+Qeq1W1+L+X+MHRTfN2uCOcV
         uYAeJEYyAMziJ0JNWN0sw/aeCFN1uSv0dzQ7r0bIHjXvNLjLLlaipqpEUWVxI908shfo
         s0snQyTNsaYOQ06/yoSQNXPmDX4JhRWOBTdrA4MJAs0i/4AGDjE7OzTnwubKSQUdOlty
         scrRf9IM2XIfHvmJqZAaKmV46KAR/82a8OhMDL3dHf6x5PKKodh18mYX/2rhl3tYtP+s
         cfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXr4UV4kEHsq0yeWfqjzxiqcNiJQEejUfsbyhCIH4rQ=;
        b=Vr2N47L+CQYl1L+DwzWKILFyVRBbgu9JcTOZ0Z13Gpn5VhZ3I8kZayrVoqaVdowwWb
         wkcjkzEZpUnQnUpNuM5hm3ItkDwbCADePN2oI80m6k6l6KEVz8DRwzLud0lRaKC+Ci4j
         JYG5aDJwG36ufTP9JizhT1f1nqv8YHRfDquulzrLiq0KEzPeBDSckFkOHDN5OzZ2/Ubm
         JLaFQBLsZABUu4ZlAWhla1DSQu0peEQl3pKVhNtffLmdcp2hB3CibVzPeqQL0Em/XtmH
         EIQrC6ysdoTjNAkW4+k8LD1yspxzF4qIK8GrcijYOvRO0MKmoRhpTfMOKj9Zhs4RBinT
         6vqg==
X-Gm-Message-State: APjAAAWw5yPP6LbM+dihvlNBpwq3tCiKZQTPmkdVE4W2e1RS+yhz4EEu
        BJlq2QaaHbIS9+m6UR6ybK+2N8C1KY46pc0brR5sjg==
X-Google-Smtp-Source: APXvYqyqs6Tx0r7D3LhzsgcxEVO4XgI1nK8AQjvDBJBM9adnKIKx1Vz8ue7z1QVFQNbxwHJobnt3PfeMbB8stLkt8vM=
X-Received: by 2002:a9d:6d89:: with SMTP id x9mr31120620otp.17.1571254457140;
 Wed, 16 Oct 2019 12:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-2-elver@google.com>
 <20191016184346.GT2328@hirez.programming.kicks-ass.net>
In-Reply-To: <20191016184346.GT2328@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Oct 2019 21:34:05 +0200
Message-ID: <CANpmjNP4b9Eo3ZKE6maBs4ANS7K7sLiVB2CbebQnCH09TB+hZQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Peter Zijlstra <peterz@infradead.org>
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
        dave.hansen@linux.intel.com, David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
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

On Wed, 16 Oct 2019 at 20:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
>
> > +bool __kcsan_check_watchpoint(const volatile void *ptr, size_t size,
> > +                           bool is_write)
> > +{
> > +     atomic_long_t *watchpoint;
> > +     long encoded_watchpoint;
> > +     unsigned long flags;
> > +     enum kcsan_report_type report_type;
> > +
> > +     if (unlikely(!is_enabled()))
> > +             return false;
> > +
> > +     watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
> > +                                  &encoded_watchpoint);
> > +     if (watchpoint == NULL)
> > +             return true;
> > +
> > +     flags = user_access_save();
>
> Could use a comment on why find_watchpoint() is save to call without
> user_access_save() on.

Thanks, will add a comment for v2.

> > +     if (!try_consume_watchpoint(watchpoint, encoded_watchpoint)) {
> > +             /*
> > +              * The other thread may not print any diagnostics, as it has
> > +              * already removed the watchpoint, or another thread consumed
> > +              * the watchpoint before this thread.
> > +              */
> > +             kcsan_counter_inc(kcsan_counter_report_races);
> > +             report_type = kcsan_report_race_check_race;
> > +     } else {
> > +             report_type = kcsan_report_race_check;
> > +     }
> > +
> > +     /* Encountered a data-race. */
> > +     kcsan_counter_inc(kcsan_counter_data_races);
> > +     kcsan_report(ptr, size, is_write, raw_smp_processor_id(), report_type);
> > +
> > +     user_access_restore(flags);
> > +     return false;
> > +}
> > +EXPORT_SYMBOL(__kcsan_check_watchpoint);
> > +
> > +void __kcsan_setup_watchpoint(const volatile void *ptr, size_t size,
> > +                           bool is_write)
> > +{
> > +     atomic_long_t *watchpoint;
> > +     union {
> > +             u8 _1;
> > +             u16 _2;
> > +             u32 _4;
> > +             u64 _8;
> > +     } expect_value;
> > +     bool is_expected = true;
> > +     unsigned long ua_flags = user_access_save();
> > +     unsigned long irq_flags;
> > +
> > +     if (!should_watch(ptr))
> > +             goto out;
> > +
> > +     if (!check_encodable((unsigned long)ptr, size)) {
> > +             kcsan_counter_inc(kcsan_counter_unencodable_accesses);
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Disable interrupts & preemptions, to ignore races due to accesses in
> > +      * threads running on the same CPU.
> > +      */
> > +     local_irq_save(irq_flags);
> > +     preempt_disable();
>
> Is there a point to that preempt_disable() here?

We want to avoid being preempted while the watchpoint is set up;
otherwise, we would report data-races for CPU-local data, which is
incorrect. An alternative would be adding the source CPU to the
watchpoint, and checking that the CPU != this_cpu. There are several
problems with that alternative:
1. We do not want to steal more bits from the watchpoint encoding for
things other than read/write, size, and address, as not only does it
affect accuracy, it would also increase performance overhead in the
fast-path.
2. As a consequence, if we get a preemption and run a task on the same
CPU, and there *is* a genuine data-race, we would *not* report it; and
since this is the common case (and not accesses to CPU-local data), it
makes more sense (from a data-race detection PoV) to simply disable
preemptions and ensure that all tasks are run on other CPUs as well as
avoid the problem of point (1).

I can add a comment to that effect here for v2.

Thanks,
-- Marco
