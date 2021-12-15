Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCF475D63
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbhLOQ27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244776AbhLOQ27 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Dec 2021 11:28:59 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B32C06173E
        for <linux-arch@vger.kernel.org>; Wed, 15 Dec 2021 08:28:58 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v22so22338809qtx.8
        for <linux-arch@vger.kernel.org>; Wed, 15 Dec 2021 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcP01/b9cBNlxBc/sDfkZgSKlphIrcjvX4JKV4TqS64=;
        b=sV8QbRxgoANmSNSGI0aYUKfO0q1jF/TCKDrGYTsSoT725dNGZRJ6Y4+Y6u3NlgNqGi
         DES/osX7c856H4zuQ7HkFveyRa1UItoQoC5eryCtl47qkP/L/y0D0+60BiQ1fIzHtuIj
         H9D+u0GM6+mJyswvExYAeIiKNkrZg4gyu3Cc7kTol7eEjV3vC4prJSoi1+RojXRa2UFy
         XlORyhY6TIOkoo9sU7znKuU3MShaxLJ6lyQYdl8G4hcyZpr6L97oLr95thnG/62cgr1c
         GnM7SwwMWMj3b1YC69uIBfyw57jaJ+I3Xow6jLB49fyCCrkXrFj/P0bhBzMitLTlRJtY
         EowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcP01/b9cBNlxBc/sDfkZgSKlphIrcjvX4JKV4TqS64=;
        b=xNYHCNnIqT6R0dpD0m1BGfPRNK3UfX89i7qUpn5mnSi8xzlEX1aLxufw5o0wIrbuHw
         SeycpNnXJ0VqEQvdJZ7QgSrgJECG2CWJQyxlmpbHGQ0P3a9ZlBbbDDINAwMwGLYaAyHx
         yEFeaED4DD+FVy40RR1nXyx9Pf0L2QSnrufj9aHW/MkCjRfrPkLZvDNqKQ1ZK+8PXnF0
         zr71QRmktkSEh4IeNF7Xgjym901+4103+ESpGhvhu23WCtqlCJGw10g94vNNEE33KpYc
         XAx3Jnqyz7aGKJd8oFWT1bCyxg2hLvMYRZ8jFVrs8O9g2Lt//i7egcKBEhUErp22n2Mg
         HU1A==
X-Gm-Message-State: AOAM532mmeszhaf1AkDUl4iw20E8MWvASTd02SXWkhUGJkPO/WC05Y0q
        Pit0C/yatNo/D2p+PLASRLRs7J5hB6JNrjV2ZcWE7w==
X-Google-Smtp-Source: ABdhPJy7M0jihSRz6oU87lAajvH4Pb+IxBTZVxkdRp+wYdU4GaQRaMhYcrjUkzXa+GnU9D7a8BF9WhM5llb3k31ruW0=
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr12971191qtw.72.1639585737678;
 Wed, 15 Dec 2021 08:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-26-glider@google.com>
 <Ybn39Z5dwcbrbs0O@FVFF77S0Q05N>
In-Reply-To: <Ybn39Z5dwcbrbs0O@FVFF77S0Q05N>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 15 Dec 2021 17:28:21 +0100
Message-ID: <CAG_fn=XOOoCQhEkN1oeOXUX99P+AQ+ApPiUQXPFxR6yeT-Tf=w@mail.gmail.com>
Subject: Re: [PATCH 25/43] kmsan: skip shadow checks in files doing context switches
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 15, 2021 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:32PM +0100, Alexander Potapenko wrote:
> > When instrumenting functions, KMSAN obtains the per-task state (mostly
> > pointers to metadata for function arguments and return values) once per
> > function at its beginning.
>
> How does KMSAN instrumentation acquire the per-task state? What's used as the
> base for that?
>

To preserve kernel ABI (so that instrumented functions can call
non-instrumented ones and vice versa) KMSAN uses a per-task struct
that keeps shadow values of function call parameters and return
values:

struct kmsan_context_state {
  char param_tls[...];
  char retval_tls[...];
  char va_arg_tls[...];
  char va_arg_origin_tls[...];
  u64 va_arg_overflow_size_tls;
  depot_stack_handle_t param_origin_tls[...];
  depot_stack_handle_t retval_origin_tls;
};

It is mostly dealt with by the compiler, so its layout isn't really important.
The compiler inserts a call to __msan_get_context_state() at the
beginning of every instrumented function to obtain a pointer to that
struct.
Then, every time a function pointer is used, a value is returned, or
another function is called, the compiler adds code that updates the
shadow values in this struct.

E.g. the following function:

int sum(int a, int b) {
...
  result = a + b;
  return result;
}

will now look as follows:

int sum(int a, int b) {
  struct kmsan_context_state *kcs = __msan_get_context_state();
  int s_a = ((int)kcs->param_tls)[0];  // shadow of a
  int s_b = ((int)kcs->param_tls)[1];  // shadow of b
...
  result = a + b;
  s_result = s_a | s_b;
  ((int)kcs->retval_tls)[0] = s_result;  // returned shadow
  return result;
}

> >
> > To deal with that, we need to apply __no_kmsan_checks to the functions
> > performing context switching - this will result in skipping all KMSAN
> > shadow checks and marking newly created values as initialized,
> > preventing all false positive reports in those functions. False negatives
> > are still possible, but we expect them to be rare and impersistent.
> >
> > To improve maintainability, we choose to apply __no_kmsan_checks not
> > just to a handful of functions, but to the whole files that may perform
> > context switching - this is done via KMSAN_ENABLE_CHECKS:=n.
> > This decision can be reconsidered in the future, when KMSAN won't need
> > so much attention.
>
> I worry this might be the wrong approach (and I've given some rationale below),
> but it's not clear to me exactly how this goes wrong. Could you give an example
> flow where stale data gets used?

The scheme I described above works well until a context switch occurs.
Then, IIUC, at some point `current` changes, so that the previously
fetched KMSAN context state becomes stale:

void foo(...) {
baz(...);
// context switch here changes `current`
baz(...);
}

In this case we'll have foo() setting up kmsan_context_state for the
old task when calling bar(), but bar() taking shadow for its arguments
from the new task's kmsan_context_state.

Does this make sense?

> As above, the actual context-switch occurs in arch code --I assume the
> out-of-line call *must* act as a clobber from the instrumentation's PoV or we'd
> have many more problems.

Treating a function call as a clobber of kmsan_context_state() is
actually an interesting idea.
Adding yet another call to __msan_get_context_state() after every
function call may sound harsh, but we already instrument every memory
access anyway.
What remains unclear is handling the return value of the innermost
function that performed the switch: it will be saved to the old task's
state, but taken from that of the new task.

> I also didn't spot any *explciit* state switching
> being added there that would seem to affect KMSAN.
>
> ... so I don't understand why checks need to be inhibited for the core sched code.

In fact for a long time there were only three functions annotated with
__no_kmsan_checks right in arch/x86/kernel/process_64.c and
kernel/sched/core.c
We decided to apply this attribute to every function in both files,
just to make sure nothing breaks too early while upstreaming KMSAN.
