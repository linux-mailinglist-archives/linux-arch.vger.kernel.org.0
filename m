Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE436DE00
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbhD1RQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbhD1RQe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 13:16:34 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63830C061573;
        Wed, 28 Apr 2021 10:15:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d25so26240817oij.5;
        Wed, 28 Apr 2021 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDNVrff76VfRvD1j2rT05FypZOPT0Mkjjgr3q5U+VQs=;
        b=erq4vAGuJkQ8SLktjhZPoxGk6wz1+UuIbAj57Rr7KkYYOB1NZYw0zdi5NYSYpquFij
         49QBMCIkAsb3hXsHwEzPSV9O/XsH6xbDxOLEBgKaxpRFTmAxC/u0xHHQ6h8BGxojsRly
         NjkpVJn8Nlpo1eo7rFT0w9fQUHQl30Z1wrn9KtV6SoDHQ7vGuFRjuQh5qFF7TjYtPwdF
         GPGDDOqEJ9PW94EtgE/59JBvIa8nEcwn6gcXDFB8CVy0EJMpAm8cfirMN+8lXdqfg3gT
         WmgMfwHNFhSaDHGXh+cDbnNrQ5Mi1HQ+tjOBgAUDyfAgoUtDrIqjx9XNze7X0NqMz6U8
         r3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDNVrff76VfRvD1j2rT05FypZOPT0Mkjjgr3q5U+VQs=;
        b=mZhKBHwTNAE8vykHVzRchCT2l0xi0msvbjmi3Z/huKxZ5qktKc2TaK+t6sF/92Q7fZ
         bzRQ1D9q3tcmW6fX0zyYnFHMzGJci6xlwsJV7bxUFKfxqIRLmj6WE1IjOviMIH58zURO
         pYSm396ymwtzRjN95nSHHWGzkH9iF/0u8552lRLW5w9MeUlBc3GQ3n8q7zRB/eS4yije
         mDvQSI63g3DKSHIrUYE65Sf43fgEQ8GvD3vP4/uTRsMkyXHUA/bdRysrZWWwsX1HFS/4
         MxU9sC9bLYXplOQ0LbIW8Om55081xpnWV+3IJDC8tsNUXZLIzo99NTyYn+10bv5qqKXb
         2nDA==
X-Gm-Message-State: AOAM533i8teCbHAI7S+JgQpZjzmqJawO5xxRmBIUZSv1j8SeD3rSxh9R
        /rwe7Prb3MIgfEuUGyZxTZ242b60oWiioVNcAUQmkSRa/0uzDA==
X-Google-Smtp-Source: ABdhPJxQrVjvc83ofCs6l74gjRa0C0tmhbLZn53UQcZWaj4ZM/E1Um2JQFVjFgAom3TPcnepSkOm9AgiCCimYK9INrI=
X-Received: by 2002:aca:dd82:: with SMTP id u124mr3624452oig.35.1619630146460;
 Wed, 28 Apr 2021 10:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204720.25007-1-yu-cheng.yu@intel.com> <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
 <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
 <CAMe9rOp7FauoqQ0vx+ZVPGOE9+ABspheuGLc++Chj_goE5HvWA@mail.gmail.com>
 <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
 <0c6e1c922bc54326b1121194759565f5@AcuMS.aculab.com> <7d857e5d-e3d3-1182-5712-813abf48ccba@intel.com>
In-Reply-To: <7d857e5d-e3d3-1182-5712-813abf48ccba@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 28 Apr 2021 10:15:10 -0700
Message-ID: <CAMe9rOqhiBOvv4YhdHwu6Gwq+=rZ=t02Q+vQtWxqiB-uXWi2vw@mail.gmail.com>
Subject: Re: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch Tracking
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 9:25 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 4/28/2021 8:33 AM, David Laight wrote:
> > From: Andy Lutomirski
> >> Sent: 28 April 2021 16:15
> >>
> >> On Wed, Apr 28, 2021 at 7:57 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >>>
> >>> On Wed, Apr 28, 2021 at 7:52 AM Andy Lutomirski <luto@kernel.org> wrote:
> >>>>
> >>>> On Wed, Apr 28, 2021 at 7:48 AM David Laight <David.Laight@aculab.com> wrote:
> >>>>>
> >>>>> From: Yu-cheng Yu
> >>>>>> Sent: 27 April 2021 21:47
> >>>>>>
> >>>>>> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> >>>>>> return/jump-oriented programming attacks.  Details are in "Intel 64 and
> >>>>>> IA-32 Architectures Software Developer's Manual" [1].
> >>>>> ...
> >>>>>
> >>>>> Does this feature require that 'binary blobs' for out of tree drivers
> >>>>> be compiled by a version of gcc that adds the ENDBRA instructions?
> >>>>>
> >>>>> If enabled for userspace, what happens if an old .so is dynamically
> >>>>> loaded?
> >>>
> >>> CET will be disabled by ld.so in this case.
> >>
> >> What if a program starts a thread and then dlopens a legacy .so?
> >
> > Or has shadow stack enabled and opens a .so that uses retpolines?
> >
>
> When shadow stack is enabled, retpolines are not necessary.  I don't
> know if glibc has been updated for detection of this case.  H.J.?
>
> >>>>> Or do all userspace programs and libraries have to have been compiled
> >>>>> with the ENDBRA instructions?
> >>>
> >>> Correct.  ld and ld.so check this.
> >>>
> >>>> If you believe that the userspace tooling for the legacy IBT table
> >>>> actually works, then it should just work.  Yu-cheng, etc: how well
> >>>> tested is it?
> >>>>
> >>>
> >>> Legacy IBT bitmap isn't unused since it doesn't cover legacy codes
> >>> generated by legacy JITs.
> >>>
> >>
> >> How does ld.so decide whether a legacy JIT is in use?
> >
> > What if your malware just precedes its 'jump into the middle of a function'
> > with a %ds segment override?
> >
>
> Do you mean far jump?  It is not tracked by ibt, which tracks near
> indirect jump.  The details can be found in Intel SDM.
>
> > I may have a real problem here.
> > We currently release program/library binaries that run on Linux
> > distributions that go back as far as RHEL6 (2.6.32 kernel era).
> > To do this everything is compiled on a userspace of the same vintage.
> > I'm not at all sure a new enough gcc to generate the ENDBR64 instructions
> > will run on the relevant system - and may barf on the system headers
> > even if we got it to run.
> > I really don't want to have to build multiple copies of everything.
>
> This is likely OK.  We have tested many combinations.  Should you run
> into any issue, please let glibc people know.
>

If you have a Tiger Lake laptop, you can install the CET kernel on
Fedora 34 or Ubuntu 20.10/21.04.

-- 
H.J.
