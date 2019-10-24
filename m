Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345FEE2FB9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbfJXLCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 07:02:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34675 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390019AbfJXLCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 07:02:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so20291453otp.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wp7j55fCu8VBbV3w6xxbpPhvOdRSu/ha8VU4hcpzHdY=;
        b=GSxZTUgn5T2HRAlKrADzvv53PhUqCr6HGwWIfZ+q0bFeBI/8il22Kv3vpugrhHlUKc
         JSd3yXOh4TDUfIqO8JPYXGilp4Vg98FIe9l+pL6F5FO2iW7zWgkU28rHfnrJDKC/RUhT
         9y7xvvCroceLV28G/DNxI6s3sI/MSBb0LxVcLxj5vL25ilXRyhqWJ+AnuTdwWYD+wKpX
         O5vqsk+9Nvl/sUnYEZWYKKkmZRx3M69w2mSa0T0GYjtT0TBikdjdIHl9bdIy1avJXFGR
         mVT16n7Jv0qZPjTSiWzuZVrSqaZmV1oEhg+iVLOxp3SXxbxsxWpuo8R2VJIKx8+2qGRR
         M+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wp7j55fCu8VBbV3w6xxbpPhvOdRSu/ha8VU4hcpzHdY=;
        b=Oi5PfUi3uyv4LlS44jm8zMiIgzUMqk6Qu3BdHPdT0xZ45Cxo8BwlJ64Wb2A43vA0Br
         NaGWAtAt3R33lRwZM8T8UCH6UdIbNmlWJZr2Z9sWQWwSqdV//K4SVBx/GZN7JfqWZbDg
         vGp8ZYbRZmUN2TSQP7aA7Eb9a8qxCEMSISU6MlwbiDfqaVcd4sx4gedSC4B2JAEfxK3J
         RsN0JfM7Q6XLMJoyVjXfF9iOiz2DoisC7ziJqUlFVGhFi07Q+rzFdYkI5vLTprbH+2bj
         4qLrIGB3q+7VhMs9ypNB+/WB7BCzp9ICfxfa/vtiPX7TIU2qJ6v9KD5Fr4bS4mI9fNbS
         AyyA==
X-Gm-Message-State: APjAAAX2wNbYpM2dlL9YfeJnaehRpqK/SQg9/PIdjVw2tOUP7GTQBquR
        fLcOLhMY49uIrn9YpQJ369DnrZo5n5Kq8O8ewptQRw==
X-Google-Smtp-Source: APXvYqzzXJwi5QeAS4Gnmcn5kNWx1bB+mxOrVbyaL3mIhkaZR6F+nFKJsdPfH9bNhx4bqmlmQAfh3F8piEDK6aQ6BY4=
X-Received: by 2002:a9d:82e:: with SMTP id 43mr8537524oty.23.1571914935893;
 Thu, 24 Oct 2019 04:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-2-elver@google.com>
 <20191022154858.GA13700@redhat.com> <CANpmjNPUT2B3rWaa=5Ee2Xs3HHDaUiBGpG09Q4h9Gemhsp9KFw@mail.gmail.com>
 <20191023162432.GC14327@redhat.com>
In-Reply-To: <20191023162432.GC14327@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Oct 2019 13:02:03 +0200
Message-ID: <CANpmjNOOT+KR7m8KpETk1czyJLr3TeHsvvejwyuY3JXKr=eajg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Oleg Nesterov <oleg@redhat.com>
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
        Mark Rutland <mark.rutland@arm.com>,
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

On Wed, 23 Oct 2019 at 18:24, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/22, Marco Elver wrote:
> >
> > On Tue, 22 Oct 2019 at 17:49, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > Just for example. Suppose that task->state = TASK_UNINTERRUPTIBLE, this task
> > > does __set_current_state(TASK_RUNNING), another CPU does wake_up_process(task)
> > > which does the same UNINTERRUPTIBLE -> RUNNING transition.
> > >
> > > Looks like, this is the "data race" according to kcsan?
> >
> > Yes, they are "data races". They are probably not "race conditions" though.
> >
> > This is a fair distinction to make, and we never claimed to find "race
> > conditions" only
>
> I see, thanks, just wanted to be sure...
>
> > KCSAN's goal is to find *data races* according to the LKMM.  Some data
> > races are race conditions (usually the more interesting bugs) -- but
> > not *all* data races are race conditions. Those are what are usually
> > referred to as "benign", but they can still become bugs on the wrong
> > arch/compiler combination. Hence, the need to annotate these accesses
> > with READ_ONCE, WRITE_ONCE or use atomic_t:
>
> Well, if I see READ_ONCE() in the code I want to understand why it was
> used. Is it really needed for correctness or we want to shut up kcsan?
> Say, why should wait_event(wq, *ptr) use READ_ONCE()? Nevermind, please
> forget.
>
> Btw, why __kcsan_check_watchpoint() does user_access_save() before
> try_consume_watchpoint() ?

Instrumentation is added in UACCESS regions. Since we do not access
user-memory, we do user_access_save to ensure everything is safe
(otherwise objtool complains that we do calls to non-whitelisted
functions). I will try to optimize this a bit, but we can't avoid it.

> Oleg.
>
