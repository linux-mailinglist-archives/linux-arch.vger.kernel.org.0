Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6636EC93
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 16:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhD2OpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 10:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234473AbhD2OpD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Apr 2021 10:45:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8E5A61450
        for <linux-arch@vger.kernel.org>; Thu, 29 Apr 2021 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619707456;
        bh=P0/WSeSHefJ1bFNBptJX0+j0jR1O8Fl8GSgrXOuL6UM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HNOLQGobI3RtLIJxIjDYdC+Rc56LQ+LcDta43PhlMw4pvrvCAd6oDZdcDFq1aMsUn
         NqGo2bBrs2GXUBvQcmvw5W9a7ICDkPQpjwKwxkatZBpscZAR6QMwyezNhwlratC2AC
         HShLp2A2WH1iLV2bezvSqIfPB5ljN+DyuTwt+5cKclA6eQGRRlXCP2tBtDyWp7UHYV
         rzi69lzzLpic6g2srl8pNk30+4yfQiRbGWXnZ8AEDxoXKNUpg5qYNs/qdQZhSoUw89
         weSBuM6qdu5GzciV7kpS+lU5ilqo0dpvjgMoNi1w10g/OzPi6n0k79zC8kzgZbAjWm
         4Z19sufXKr++g==
Received: by mail-lj1-f179.google.com with SMTP id b21so4241417ljf.11
        for <linux-arch@vger.kernel.org>; Thu, 29 Apr 2021 07:44:16 -0700 (PDT)
X-Gm-Message-State: AOAM532G818IxixuafKbZZntO/ZM99gU0R6764GG41Z2zxcB4UDUVuGL
        /E+bsr8/2wBQlP5xeTCUSSjcS0GKzaGxMNaUud81kg==
X-Google-Smtp-Source: ABdhPJx/nfYwEVo/0GHr3ytGoD4WhwvcC+R8fWV2IU0rcQQ4zXcZJMTsPbWIXC8AnlOwG3/0j0MKVIk3zL0pCGkD5y8=
X-Received: by 2002:a2e:9bc7:: with SMTP id w7mr25176951ljj.170.1619707454776;
 Thu, 29 Apr 2021 07:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204315.24153-1-yu-cheng.yu@intel.com> <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com> <YIpgB5HbnNPWX4FP@grain>
In-Reply-To: <YIpgB5HbnNPWX4FP@grain>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Apr 2021 07:44:03 -0700
X-Gmail-Original-Message-ID: <CALCETrW27rTeaymtuJYJCyNgHfuCqA90KinvzNzwBg_vCnZLTw@mail.gmail.com>
Message-ID: <CALCETrW27rTeaymtuJYJCyNgHfuCqA90KinvzNzwBg_vCnZLTw@mail.gmail.com>
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 29, 2021 at 12:28 AM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Wed, Apr 28, 2021 at 04:03:55PM -0700, Andy Lutomirski wrote:
> > On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > >
> > > When shadow stack is enabled, a task's shadow stack states must be saved
> > > along with the signal context and later restored in sigreturn.  However,
> > > currently there is no systematic facility for extending a signal context.
> > > There is some space left in the ucontext, but changing ucontext is likely
> > > to create compatibility issues and there is not enough space for further
> > > extensions.
> > >
> > > Introduce a signal context extension struct 'sc_ext', which is used to save
> > > shadow stack restore token address.  The extension is located above the fpu
> > > states, plus alignment.  The struct can be extended (such as the ibt's
> > > wait_endbr status to be introduced later), and sc_ext.total_size field
> > > keeps track of total size.
> >
> > I still don't like this.
> >
> > Here's how the signal layout works, for better or for worse:
> >
> > The kernel has:
> >
> > struct rt_sigframe {
> >     char __user *pretcode;
> >     struct ucontext uc;
> >     struct siginfo info;
> >     /* fp state follows here */
> > };
> >
> > This is roughly the actual signal frame.  But userspace does not have
> > this struct declared, and user code does not know the sizes of the
> > fields.  So it's accessed in a nonsensical way.  The signal handler
>
> Well, not really. While indeed this is not declared as a part of API
> the structure is widely used for rt_sigreturn syscall (and we're using
> it inside criu thus any change here will simply break the restore
> procedure). Sorry out of time right now, I'll read your mail more
> carefully once time permit.

I skimmed the CRIU code.  You appear to declare struct rt_sigframe,
and you use the offset from the start of rt_sigframe to uc.  You also
use the offset to the /* fp state follows here */ part, but that's
unnecessary -- you could just as easily have put the fp state at any
other address -- the kernel will happily follow the pointer you supply
regardless of where it points.  So the only issues I can see are if
you write the fp state on top of something else or if you
inadvertently fill in the proposed extension part of uc_flags.  Right
now you seem to be ignoring uc_flags, which I presume means that you
are filling it in as zero.  Even if the offset of the fp state in the
kernel rt_sigframe changes, the kernel should still successfully parse
the signal frame you generate.

I suppose there is another potential issue: would CRIU have issues if
the *save* runs on a kernel that uses this proposed extension
mechanism?  Are you doing something with the saved state that would
get confused?

--Andy
