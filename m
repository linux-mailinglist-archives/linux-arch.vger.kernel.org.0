Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3C74225BB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhJELwp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhJELwo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:52:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE602C061753
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:50:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s24so25826716oij.8
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXyHYhWprLF6VOTKKbJ9elBPTHHvHE5sqZFrMqC4ukc=;
        b=AdpPxdZ9CqU5FBxAA98Y3fzXjRIpzwI+jLyQpXlS0B2Zag9lwe0Tm/W8yG54SJ9A9u
         ZloN1JllYx08BhPRvTu5lLeMVb90zvrbUzw51Q/oTdDElg8798X7vT7CKO7GyYUcONLE
         k9O1RUB4qxTUoeLEVIq3Grm6ll7KDg+JufpDII0qJIcg/GKTG35cmkQ5XWHVutEWOyV9
         afmn3IVBAGabm9Ko1S1/pP/T924r2z5QRlfubG528dYb2KvZAfCV+7dPjVhxdNnppO46
         HYvS1v3YPsVAuU8KqDjulvXw2WkI0lv0lSxJUhzjPCzS4XqZ3dFKVW9ScGGE+fi2AxGF
         NvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXyHYhWprLF6VOTKKbJ9elBPTHHvHE5sqZFrMqC4ukc=;
        b=EpURmk+lekSb7pc4RAVJDRkXdfKwEUhG1E12rTLLPRwTszARaCPTaZ0adC6Xa7fJvl
         JB6hbuJc9g7BPHbrYc/5k0vwJmtu9/+RbABrRNBaOdD1xvSxYSe9Xzep76GXkX7nDsYz
         uacGDwPPUrYt/5IGKEz55nZrYFu1VsD+mqTkN91A6iPdA5ojG5Ro8oPfnz6/TPhj9QMT
         5SxxIHAQq2b0CTrQcwuouV+q2An18LFIBwch1FB/bHau1agK3+ij2fOhWVUEhSrF7376
         oOc/RYuVZ7Vx0et2b9/2+Xd4vvoL/i6X6VXFdwIc8BzCIAn1Fk+aXhfAfu3S3I31K7+P
         lvMA==
X-Gm-Message-State: AOAM532syGWAL0KuRw/7a2agjSei/aJnhGKIrq94VFpfno7DY/yOGSFK
        IhXAITrtiwgYdHISuU7NBFvzkukgDvYtJCUnEoXUVg==
X-Google-Smtp-Source: ABdhPJxU3FVSA1SHRlaHXINF41V/Q42Bl2cBP1TOm69/Ej2eU70kaiasNkoR/CPckzvekLYzclXnlPHunaY5s8EHghQ=
X-Received: by 2002:a54:4618:: with SMTP id p24mr2068916oip.134.1633434652953;
 Tue, 05 Oct 2021 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com> <20211005105905.1994700-6-elver@google.com>
 <YVw53mP3VkWyCzxn@hirez.programming.kicks-ass.net> <YVw63tqctCMm+d7M@hirez.programming.kicks-ass.net>
In-Reply-To: <YVw63tqctCMm+d7M@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 Oct 2021 13:50:41 +0200
Message-ID: <CANpmjNOXWtUg9qsLJ6m9n3GYZf-AHE_21=zLnFnUMDBHMP2umg@mail.gmail.com>
Subject: Re: [PATCH -rcu/kcsan 05/23] kcsan: Add core memory barrier
 instrumentation functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 5 Oct 2021 at 13:45, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 05, 2021 at 01:41:18PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 05, 2021 at 12:58:47PM +0200, Marco Elver wrote:
> > > +static __always_inline void kcsan_atomic_release(int memorder)
> > > +{
> > > +   if (memorder == __ATOMIC_RELEASE ||
> > > +       memorder == __ATOMIC_SEQ_CST ||
> > > +       memorder == __ATOMIC_ACQ_REL)
> > > +           __kcsan_release();
> > > +}
> > > +
[...]
> > > +   kcsan_atomic_release(memorder);
> > >     __atomic_thread_fence(memorder);
> > >  }
> > >  EXPORT_SYMBOL(__tsan_atomic_thread_fence);
> >
> > I find that very hard to read.. kcsan_atomic_release() it not in fact a
> > release. It might be a release if @memorder implies one.

You're right, this name can be improved.
`kcsan_atomic_builtin_memorder(..)` is probably better

> Also, what's the atomic part signify? Is that because you're modeling
> the difference in acquire/release semantics between
> smp_load_{acquire,release}() and atomic*_{acquire,release}() ?

Sorry, just a bad name. It's about the builtins. The above suggested
name should hopefully be clearer.
