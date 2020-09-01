Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C03259D86
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgIARqJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgIARqH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 13:46:07 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC30214D8
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598982366;
        bh=XFZ88HewQoEjX2uJ9z8eaQBKTvSmcqHdw3MZB06++UA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xxq4jGgC3FP6E6gs/q13XQfdoEec6OPL6DZe2AMlX8NETGLlw5cCIhOa+6nXyzLUX
         uoPktWkJN7ohYD0ZUWHIzNAtWE+iimV6ZSWTLQ9YxeYXOo2wb1XfqVUBSE/b9QQaOs
         Mu+RS9g2Aa3YatA3A8fs18faklWbaNh4F1BXA5bo=
Received: by mail-wm1-f53.google.com with SMTP id b79so2018583wmb.4
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 10:46:06 -0700 (PDT)
X-Gm-Message-State: AOAM531apDtHl0Kkdje7XAIB7ahTa+eIP8auT6v3UHF5BKv+pyM0Mrh7
        TBZaL1JXT53xo3IcNVQyt1OeS3+wVz40oiJVFYVS2Q==
X-Google-Smtp-Source: ABdhPJzgN/ki/QOy8VBTjEfkf88yPgVKoMbt/LBzptwfMiUASf1g/B5786/uD6CW1kC9N6DS/YCeDyVeKhyIJxbKQ58=
X-Received: by 2002:a1c:2983:: with SMTP id p125mr2831445wmp.21.1598982364949;
 Tue, 01 Sep 2020 10:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com> <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com> <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com> <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
In-Reply-To: <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Sep 2020 10:45:53 -0700
X-Gmail-Original-Message-ID: <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
Message-ID: <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 1, 2020 at 10:23 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 9/1/2020 3:28 AM, Dave Martin wrote:
> > On Thu, Aug 27, 2020 at 06:26:11AM -0700, H.J. Lu wrote:
> >> On Wed, Aug 26, 2020 at 12:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >>>
> >>> On 8/26/20 11:49 AM, Yu, Yu-cheng wrote:
> >>>>> I would expect things like Go and various JITs to call it directly.
> >>>>>
> >>>>> If we wanted to be fancy and add a potentially more widely useful
> >>>>> syscall, how about:
> >>>>>
> >>>>> mmap_special(void *addr, size_t length, int prot, int flags, int type);
> >>>>>
> >>>>> Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
> >>>>> this is really just mmap() except that we want to map something a bit
> >>>>> magical, and we don't want to require opening a device node to do it.
> >>>>
> >>>> One benefit of MMAP_SPECIAL_* is there are more free bits than MAP_*.
> >>>> Does ARM have similar needs for memory mapping, Dave?
> >>>
> >>> No idea.
> >>>
> >>> But, mmap_special() is *basically* mmap2() with extra-big flags space.
> >>> I suspect it will grow some more uses on top of shadow stacks.  It could
> >>> have, for instance, been used to allocate MPX bounds tables.
> >>
> >> There is no reason we can't use
> >>
> >> long arch_prctl (int, unsigned long, unsigned long, unsigned long, ..);
> >>
> >> for ARCH_X86_CET_MMAP_SHSTK.   We just need to use
> >>
> >> syscall (SYS_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, ...);
> >
> >
> > For arm64 (and sparc etc.) we continue to use the regular mmap/mprotect
> > family of calls.  One or two additional arch-specific mmap flags are
> > sufficient for now.
> >
> > Is x86 definitely not going to fit within those calls?
>
> That can work for x86.  Andy, what if we create PROT_SHSTK, which can
> been seen only from the user.  Once in kernel, it is translated to
> VM_SHSTK.  One question for mremap/mprotect is, do we allow a normal
> data area to become shadow stack?

I'm unconvinced that we want to use a somewhat precious PROT_ or VM_
bit for this.  Using a flag bit makes sense if we expect anyone to
ever map an fd or similar as a shadow stack, but that seems a bit odd
in the first place.  To me, it seems more logical for a shadow stack
to be a special sort of mapping with a special vm_ops, not a normal
mapping with a special flag set.  Although I realize that we want
shadow stacks to work like anonymous memory with respect to fork().
Dave?

--Andy
