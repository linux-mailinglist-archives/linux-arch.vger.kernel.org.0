Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D21D5DF4
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPChi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 22:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgEPChh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 22:37:37 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73229C061A0C;
        Fri, 15 May 2020 19:37:37 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 17so4506660ilj.3;
        Fri, 15 May 2020 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+Om/GsyDrpyV1h+nZkU0dBuPGFU3TkzcVyywQUT9C8=;
        b=YlSSCiFz7D2P0SHo/hB1dOKbVDBgwqB3bbFXiseSa4VR0BMjp+xU3hiKpTRCWg4Duc
         rGklV2WRDYVYENVj9vnH8RDWSgOIT1CP4nshdYJLzGA8vZiFvKDToDDux9xoEVtGYSRS
         Hzz6+zJxYI7P8tgWP5eJte4FmLpUssj/zf56zH4/DHKqC9dnssp3LvPczqvzzgMrIi8k
         B/PWF5fN6n4FhTIvD+xq7OcclfTByKkkPRozO05tJM2Mty0z7vscexgQNIYk69lFIwF8
         6TQYYLwb+KuF0bsj7FviLEwcDz/gonYP1l05OhpE/zjvwGFiA0cWYC6UhdFgibA9pUo6
         dwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+Om/GsyDrpyV1h+nZkU0dBuPGFU3TkzcVyywQUT9C8=;
        b=ErwlvQ0apG3ol+IS5FfBA1WJjDpN7N6p+KKPFqGVbkgoTMPTHJrPp9+RQKhDw7szQ/
         UDu7cIEbM8Ndo94Xu1u+rGBaJNV5RdRefnmyvTz46LYjIVUW/WvxARsYHr51VKVYf2+Q
         sJPdbVn9BGHNRttT+iabuAaMfWnnBwPIK9daFMjDO3TcTitEDWPwfvGOTX9kHZy2zR60
         7/HdzvADeIHMHUi6wLLWOuVaOvbwO84VjkX2WZsOwrH0vm78wGxHUS44m3jExH2W3XYD
         RiOh0dusXh6TxDjR8kv7VNez0RXGDWOOnueQsT7Yu9yIMETiDmvTHFbdtuqNs8a1p3hk
         br/A==
X-Gm-Message-State: AOAM532sM5pmo68AjkHtlorWdUDZKhhbSFpmBTEMZ5KHYGIVFWp1pDyi
        FUSUjawQ3RfWLJY0dcAc3RvCGx1SjaTYVAR+GfY=
X-Google-Smtp-Source: ABdhPJyKYz5daI9cmrjW68tb2H0AL4TkpkC9K+/kUc+NPMYXsmvpI501KTEnTEZ8WuCkY1yzNxl3lsEo40cmEDc1z5Y=
X-Received: by 2002:a92:9f4b:: with SMTP id u72mr4727883ili.273.1589596656775;
 Fri, 15 May 2020 19:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200429220732.31602-1-yu-cheng.yu@intel.com> <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com> <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com> <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com> <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
In-Reply-To: <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 15 May 2020 19:37:00 -0700
Message-ID: <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
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

On Fri, May 15, 2020 at 5:13 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 15/05/2020 23:43, Dave Hansen wrote:
> > On 5/15/20 2:33 PM, Yu-cheng Yu wrote:
> >> On Fri, 2020-05-15 at 11:39 -0700, Dave Hansen wrote:
> >>> On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
> >>> Can a binary compiled with CET run without CET?
> >> Yes, but a few details:
> >>
> >> - The shadow stack is transparent to the application.  A CET application does
> >> not have anything different from a non-CET application.  However, if a CET
> >> application uses any CET instructions (e.g. INCSSP), it must first check if CET
> >> is turned on.
> >> - If an application is compiled for IBT, the compiler inserts ENDBRs at branch
> >> targets.  These are nops if IBT is not on.
> > I appreciate the detailed response, but it wasn't quite what I was
> > asking.  Let's ignore IBT for now and just talk about shadow stacks.
> >
> > An app compiled with the new ELF flags and running on a CET-enabled
> > kernel and CPU will start off with shadow stacks allocated and enabled,
> > right?  It can turn its shadow stack off per-thread with the new prctl.
> >  But, otherwise, it's stuck, the only way to turn shadow stacks off at
> > startup would be editing the binary.
> >
> > Basically, if there ends up being a bug in an app that violates the
> > shadow stack rules, the app is broken, period.  The only recourse is to
> > have the kernel disable CET and reboot.
> >
> > Is that right?
>
> If I may interject with the experience of having got supervisor shadow
> stacks working for Xen.
>
> Turning shadow stacks off is quite easy - clear MSR_U_CET.SHSTK_EN and
> the shadow stack will stay in whatever state it was in, and you can
> largely forget about it.  (Of course, in a sandbox scenario, it would be
> prudent to prevent the ability to disable shadow stacks.)
>
> Turning shadow stacks on is much more tricky.  You cannot enable it in
> any function you intend to return from, as the divergence between the
> stack and shadow stack will constitute a control flow violation.
>
>
> When it comes to binaries,  you can reasonably arrange for clone() to
> start a thread on a new stack/shstk, as you can prepare both stacks
> suitably before execution starts.
>
> You cannot reasonably implement a system call for "turn shadow stacks on
> for me", because you'll crash on the ret out of the VDSO from the system
> call.  It would be possible to conceive of an exec()-like system call
> which is "discard my current stack, turn on shstk, and start me on this
> new stack/shstk".
>
> In principle, with a pair of system calls to atomically manage the ststk
> settings and stack switching, it might possible to construct a
> `run_with_shstk_enabled(func, stack, shstk)` API which executes in the
> current threads context and doesn't explode.
>
> Fork() is a problem when shadow stacks are disabled in the parent.  The
> moment shadow stacks are disabled, the regular stack diverges from the
> shadow stack.  A CET-enabled app which turns off shstk and then fork()'s
> must have the child inherit the shstk-off property.  If the child were
> to start with shstk enabled, it would explode almost immediately due to
> the parent's stack divergence which it inherited.
>
>
> Finally seeing as the question was asked but not answered, it is
> actually quite easy to figure out whether shadow stacks are enabled in
> the current thread.
>
>     mov     $1, %eax
>     rdsspd  %eax

This is for 32-bit mode.  I use

        /* Check if shadow stack is in use.  */
        xorl    %esi, %esi
        rdsspq  %rsi
        testq   %rsi, %rsi
        /* Normal return if shadow stack isn't in use.  */
        je      L(no_shstk)

>     cmp     $1, %eax
>     je      no_shstk
>             ...
> no_shsk:
>
> rdssp is allocated from the hint nop encoding space, and the minimum
> alignment of the shadow stack pointer is 4.  On older parts, or with
> shstk disabled (either at the system level, or for the thread), the $1
> will be preserved in %eax, while if CET is active, it will be clobbered
> with something that has the bottom two bits clear.
>
> It turns out this is a lifesaver for codepaths (e.g. the NMI handler)
> which need to use other CET instructions which aren't from the hint nop
> space, and run before the BSP can set everything up.
>
> ~Andrew



-- 
H.J.
