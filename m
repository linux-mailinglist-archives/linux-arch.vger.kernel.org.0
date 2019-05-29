Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2780C2D95A
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 11:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfE2JqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 05:46:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43089 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2JqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 05:46:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so1356692oth.10
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAjjxbCt4+5cgrjM01YSZfWgmJp/G0TutPxW6NVwEDU=;
        b=WQaepMq9EUAZlBGja8x+6V2uZFtIQk3PNlb6V0omGbOscHfRltBYF1H4Sz4MgglHTr
         H1HdGO5gNzCww1LCKLX4yPTpXByz8a35WWSD7LpTu2YiHF0MHykRR2b+zDM7yITrzjqm
         gRcrGXb7qp9VaKtASl++u8hHIu4bZa61zyGrpEYuwvmtUEOb6rFMTYBid7k+DfkGRQ/m
         8+QYU3zYSg8TNsBgk67wuDSftmNvLVzhA1qRv/B113ggurbfWKEeJigFqKqSBiJXGkMk
         HzCxVyQYFPqPWBj01lKkBb5SH89GoRLV8PCkmiEv7qEuHSidudmbvhbk3lbyySBFo5KJ
         pU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAjjxbCt4+5cgrjM01YSZfWgmJp/G0TutPxW6NVwEDU=;
        b=sTtsM4l3cU9hi9dp/zSeGgshvTlSzC+axn/aUSQpFmh2GUtZ+MdE4UDAyVOEFLx3D0
         s2/h0AjDOY5QXkFdBhXAw6cUP5I2Ni5Gq+tOw+3KKB+y/6c/GLuAPdB4ntaNUxqpDzOo
         MzoTdvxpBS8ZdcEv0PYtBaGhD6YbbD1GSq2dbH9TiIkjJNURvwojtwc0rxc7lTXzl1UG
         znWBjfu56Ox/JlQ9RfQ48VCJtC6EBPJjyKYKXBwXGR4L2gKuQiajudixWhOfNOdmoDpm
         s4UCuIECzoPcAFQxzzfaRSJKnmCuLKd2i8lJxa+RBqSO+yERAR59KlNWy490Z4MT4TiN
         6fPg==
X-Gm-Message-State: APjAAAUtffUxfRORPyFS6rx+QkiaBuu/X6nPHNLDerUjLB6NRcjFkzqa
        /1paJDO25gj1OavH9O3W5yApqcIyMXYUzvmH/yeGgw==
X-Google-Smtp-Source: APXvYqyLP4MZKeZUKtaWWXhxl83UK6QddmJ7w7xbwzhKkP69jfLbidndYG/yefEQZQ6LO2DO7d5bpShx7K/ubAx01C4=
X-Received: by 2002:a9d:62cd:: with SMTP id z13mr2621053otk.251.1559123182136;
 Wed, 29 May 2019 02:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-2-elver@google.com>
 <20190528171942.GV2623@hirez.programming.kicks-ass.net> <CACT4Y+ZK5i0r0GSZUOBGGOE0bzumNor1d89W8fvphF6EDqKqHg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZK5i0r0GSZUOBGGOE0bzumNor1d89W8fvphF6EDqKqHg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 May 2019 11:46:10 +0200
Message-ID: <CANpmjNP7nNO36p03_1fksx1O2-MNevHzF7revUwQ3b7+RR0y+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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

On Wed, 29 May 2019 at 10:55, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, May 28, 2019 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 28, 2019 at 06:32:57PM +0200, Marco Elver wrote:
> > > This is a pre-requisite for enabling bitops instrumentation. Some bitops
> > > may safely be used with instrumentation in uaccess regions.
> > >
> > > For example, on x86, `test_bit` is used to test a CPU-feature in a
> > > uaccess region:   arch/x86/ia32/ia32_signal.c:361
> >
> > That one can easily be moved out of the uaccess region. Any else?
>
> Marco, try to update config with "make allyesconfig" and then build
> the kernel without this change.
>

Done. The only instance of the uaccess warning is still in
arch/x86/ia32/ia32_signal.c.

Change the patch to move this access instead? Let me know what you prefer.

Thanks,
-- Marco
