Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5ED17E923
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 20:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCITuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 15:50:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39861 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgCITux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 15:50:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id a9so4647102otl.6;
        Mon, 09 Mar 2020 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkN/HhcaxTaMqjSPmAB4y2TrVQWh2UghCp6ed7Ymedw=;
        b=GRUVcWz8NS6GonVqLH7A8HBhMLWHO/FQrUmK2o5rILiHn267Yu/YMDls+jBXFYlQoU
         sSBf9pKseLsFO4P4HQkiLtMdyYGx5v+rBWxbsRgtg2F+BXuQ6I6vQDlqAVjwJ8/KHBNR
         BOq0GhdowdUt/dQFjA5j0PZ65C+X4OoD/KEjb1wNROmtYHkAjWzwOg1En720F6woKchZ
         ni/J3LoGiyqx+2RrYBFLY8wXJMlNphBeMahzijYvyYzk2Q/dbcuxv6PiIfYlXDhvrBwR
         bEr/fwCZE3AY6rhbz8+c4NEGZ9kShnw4A+xjp7kOroNplVej75u5I64gxC2fTfMciQh5
         lMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkN/HhcaxTaMqjSPmAB4y2TrVQWh2UghCp6ed7Ymedw=;
        b=AWXgM7yjMQwUsNPau4/KNn9Bg3WKHiqa/aGKQnIWSz9LBo/Ce74qs6bSNUP5lSM+CM
         e5EPzzy6Vlgz05NTNQIv0ImR4doxtmyA+zDKayDFq4lFLslPKwILbF5Mf1W2DHOP0Opr
         qxMRypcxKd47Ecm8ZkDXeVI1O8yrmGlz/m28aVieCvJOJhDUd2YtU/O20X7CUJU202e4
         yJu/A1yPL5X0laGw4LeDtIcTEkoUemg4+DzTdbQkyToQTLc+4I2AL7hN8gofwlmupw31
         H6T2S5ecARWrfuSy3qFlfOhI09aYhKVGaMsY2kz9y2+Y5i0DJ9QrKilZZvdkz6eDhG9n
         noaw==
X-Gm-Message-State: ANhLgQ1C0fosKlX/9neLYvyXdH08P2S7W17EZFC8O/Of3YM4MbT/NMuS
        +DWI+mxvnFOhFlq2sh6t2UrDI8DMC0R8Rmbfyqg=
X-Google-Smtp-Source: ADFU+vve+GcrqYBONvNR2/zOYFR37sq8ywR+BjHMbjrW7EG8MZXD9YH7Fm5vcljapWORsYBTgXr3IcPwh7QcWKheLL4=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr14659465otr.285.1583783451354;
 Mon, 09 Mar 2020 12:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200205181935.3712-1-yu-cheng.yu@intel.com> <20200205181935.3712-2-yu-cheng.yu@intel.com>
 <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com> <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
 <968af1c2-a5b4-fb48-dfa9-499ec37f677c@intel.com> <fed72ecc917373669ac546d4e8214793d78bd513.camel@intel.com>
 <9b7ff325-d7cd-9309-d060-ad641486d106@intel.com>
In-Reply-To: <9b7ff325-d7cd-9309-d060-ad641486d106@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 12:50:15 -0700
Message-ID: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 12:35 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/9/20 12:27 PM, Yu-cheng Yu wrote:
> > On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
> >> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
> >>> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote>>>>> +Note:
> >>>>> +  There is no CET-enabling arch_prctl function.  By design, CET is
> >>>>> +  enabled automatically if the binary and the system can support it.
> >>>>
> >>>> This is kinda interesting.  It means that a JIT couldn't choose to
> >>>> protect the code it generates and have different rules from itself?
> >>>
> >>> JIT needs to be updated for CET first.  Once that is done, it runs with CET
> >>> enabled.  It can use the NOTRACK prefix, for example.
> >>
> >> Am I missing something?
> >>
> >> What's the direct connection between shadow stacks and Indirect Branch
> >> Tracking other than Intel marketing umbrellas?
> >
> > What I meant is that JIT code needs to be updated first; if it skips RETs,
> > it needs to unwind the stack, and if it does indirect JMPs somewhere it
> > needs to fix up the branch target or use NOTRACK.
>
> I'm totally lost.  I think we have very different models of how a JIT
> might generate and run code.
>
> I can totally see a scenario where a JIT goes and generates a bunch of
> code, then forks a new thread to go run that code.  The control flow of
> the JIT thread itself *NEVER* interacts with the control flow of the
> program it writes.  They never share a stack and nothing ever jumps or
> rets between the two worlds.
>
> Does anything actually do that?  I've got no idea.  But, I can clearly
> see a world where the entirety of Chrome and Firefox and the entire rust
> runtime might not be fully recompiled and CET-enabled for a while.  But,
> we still want the JIT-generated code to be CET-protected since it has
> the most exposed attack surface.
>
> I don't think that's too far-fetched.

CET support is all or nothing.   You can mix and match, but you will get
no CET protection, similar to NX feature.

-- 
H.J.
