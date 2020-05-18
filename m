Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8700C1D7A98
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgEROCD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgEROCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2020 10:02:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CDC061A0C;
        Mon, 18 May 2020 07:02:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f4so10617698iov.11;
        Mon, 18 May 2020 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lc2ja+OHTT8sTlT4PSJZmwpduIMp6MGd9lph+7ugvPo=;
        b=qbduvMObfB4yRjE16Lk2I1jkkFlC8gyxmScE8/yONEYtl+ha6GHHDoroIcPVup9AP5
         Kkj80GO+NWP/QuDci+E6oklocfM+u5RTtsJWZN7IGRxf6UCxPDS9ESSsQE+QJrx+lf9w
         UzktJo9Gtow4lVCwDFoIxmsE092+kcszCfcXPd5zL2AT4mui2+Z54+CrueIXzrJkdy7a
         9r6TvT9azMS5JMo+MECqRncNO8mreZf9+cSNF3yjreOXzKJ20jLNMZ+X7ORrshGqIAnf
         eGEvnzgChQN/efkM2AQwHUCIoUX/uS3Nmls3gDBd90VH2MtitggtarHViNqjBZSFmN2l
         PNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lc2ja+OHTT8sTlT4PSJZmwpduIMp6MGd9lph+7ugvPo=;
        b=YatGenUe840OwYOofD1t8AvhAJBGeWj8m2GvMvuxqWOK8Mpxe7+JtAI8cpkjfiN/v2
         kCw0937RxWntO+2wL7T5DdIOviMo9R8864ywKhvo4BiTakWWlIGhNS50QdRQYxChQoJi
         eiYrQRMyxju4NeIAHLabfldq2viygQ0ZhE9I6a41Xsy6/NVAnbEqgGYzlk0mpiIIPJd2
         R6gsVt5qhYw4/744X/8T6pE3Hg7b+fkO03F+hev+IuhMWZ2jKoQvQxAEXe0Fh595X41y
         fc012AX8o6ol8A/x/eiH+QOW1NIh7FYifjk+cOajL8cOWN/KrCZEVcCXZ33N5DaOm4mu
         DYWQ==
X-Gm-Message-State: AOAM533XaKJlXfNJg+rBH0oapkcYCsudaMVmlpBKK8/6EKOb8YxbaOuu
        GtAupqfk8e6MeSv5fymdQq8O2RnhiRAwlVhEsac=
X-Google-Smtp-Source: ABdhPJy0KwF9qA66c5cVSPW/61T2gfGtnIFhPCi4pqySbjuZhe4w0mxd5IyuG79RqixXDs0tn3Wmd8RjUsi7iI36nHo=
X-Received: by 2002:a5e:d918:: with SMTP id n24mr14655993iop.28.1589810522288;
 Mon, 18 May 2020 07:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200429220732.31602-1-yu-cheng.yu@intel.com> <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com> <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com> <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com> <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
 <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com> <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
 <6f2ef0e5-d3bb-2b52-dc81-8228fec4a3f5@intel.com>
In-Reply-To: <6f2ef0e5-d3bb-2b52-dc81-8228fec4a3f5@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 18 May 2020 07:01:26 -0700
Message-ID: <CAMe9rOpX_6Zn69ZzwVt5Rdh5B9HwU7ccyoQLfyM067G8A=Eg-Q@mail.gmail.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 6:41 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/15/20 7:53 PM, Yu-cheng Yu wrote:
> > On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
> >> What's my recourse as an end user?  I want to run my app and turn off
> >> CET for that app.  How can I do that?
> >
> > GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
>
> Like I mentioned to H.J., this is something that we need to at least
> acknowledge the existence of in the changelog and probably even the
> Documentation/.
>
> >>>>  I think you're saying that the CET-enabled binary would do
> >>>> arch_setup_elf_property() when it was first exec()'d.  Later, it could
> >>>> use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
> >>>> then fork() and the child would not be using CET.  Right?
> >>>>
> >>>> What is ARCH_X86_CET_DISABLE used for, anyway?
> >>>
> >>> Both the parent and the child can do ARCH_X86_CET_DISABLE, if CET is
> >>> not locked.
> >>
> >> Could you please describe a real-world example of why
> >> ARCH_X86_CET_DISABLE exists?  What kinds of apps will use it, or *are*
> >> using it?  Why was it created in the first place?
> >
> > Currently, ld-linux turns off CET if the binary being loaded does not support
> > CET.
>
> Great!  Could this please be immortalized in the documentation for the
> prctl()?
>
> >>>>>> Does this *code* work?  Could you please indicate which JITs have been
> >>>>>> enabled to use the code in this series?  How much of the new ABI is in use?
> >>>>>
> >>>>> JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
> >>>>> frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
> >>>>> are tested and in the master branch.  Sljit fixes are in the release.
> >>>>
> >>>> Huh, so who is using the new prctl() ABIs?
> >>>
> >>> Any code can use the ABI, but JIT code CET-enabling part mostly do not use these
> >>> new prctl()'s, except, probably to get CET status.
> >>
> >> Which applications specifically are going to use the new prctl()s which
> >> this series adds?  How are they going to use them?
> >>
> >> "Any code can use them" is not a specific enough answer.
> >
> > We have four arch_ptctl() calls.  ARCH_X86_CET_DISABLE and ARCH_X86_CET_LOCK are
> > used by ld-linux.  ARCH_X86_CET_STATUS are used in many places to determine if
> > CET is on.  ARCH_X86_CET_ALLOC_SHSTK is used in ucontext related handling, but
> > it can be use by any application to switch shadow stacks.
>
> Could some of this information be added to the documentation, please?
> It would also be nice to have some more details about how apps end up
> using ARCH_X86_CET_STATUS.  Why would they care that CET is on?

CET software spec is at

https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/Intel-CET-extension

My CET presentation at 2018 LPC is at

https://www.linuxplumbersconf.org/event/2/contributions/147/attachments/72/83/CET-LPC-2018.pdf

I am working on an updated CET presentation for 2020 LPC.  Let me know
if you want to see the early draft.

-- 
H.J.
