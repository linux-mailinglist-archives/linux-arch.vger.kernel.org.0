Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADC717ED20
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 01:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgCJAJM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 20:09:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39728 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCJAJL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 20:09:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id f10so12092324ljn.6;
        Mon, 09 Mar 2020 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOkimidvyE/85zDjV2EvZo2MwwHSxFziV1SbX9R/ibI=;
        b=GmWZ2zNy3pBOaZKriqQ+ELzUA3ZkISmORCjefwTdN4b6GxnT8oDZNXtKGfqGeLb0xN
         IiiTUGNMcYuPt78bzuCu2JseD2cKOcG2BKIbBv1nrDraA4IiFTuiOIGeLR9XtJWTSHSU
         o5Y/SCO0xHIPL/s3Pnm9NltrhNpdm7orHHx5Ul5VHu3SlrFWDRkRvpCRJoKDfkv8aok4
         7gSVUyGypCeG5yDuly7tpN0rQT+gi/PCLpHd+t/JsrbziukkSxb5v8o0NeMAsDbF2NF7
         CYyb5DSfuCPlfnZdjg8XkFrrco44Kf7YR9qedQo6F6nt1XP0LKndiRnpRysETF81WdNy
         m3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOkimidvyE/85zDjV2EvZo2MwwHSxFziV1SbX9R/ibI=;
        b=EtgbDLQ7rNknyA+IkoYfcGZlC8R+faRu7iOL8ZH+I5Qqv1Q+7x5huVL1C1ww3ZQXXw
         1Dca9XjpXBMZBSEfp5xpuabMacoDwDjhNVWxc2vKANY1N7+sh089LDR0PMONd1jiEbvv
         s8W6VqmHZb7X1CZXX3ttH2LVbkVTHm5N+Qx8oAJuC/t3BJS7qFtYtVHxZgLOnlLx86yi
         58RohfCdgXRKMEMtDU4AMRk4RLqNXxiiyKde7DIOR7YonFjH4w6dpyOc6bcpRS27WFmC
         pqysuDFBbTsN3UbEXWtY1Syf3xCNa6ziDkD2Ox7jiW7QkI3aDHpp53rttlBBHKWUquBE
         HMwA==
X-Gm-Message-State: ANhLgQ1m1HLFXEX8tlwsWha2lbXqHYTuVmrrKr/65MVGEBB6ulBOo5Hr
        72cmSVlWMKEl3N0wzNYBMc6gv2VmzANzrFmcIJY=
X-Google-Smtp-Source: ADFU+vvjCYjVO/XFpatNgn8tZurmWdaqMzx7frshrS7TT94YxiCF5e8FcMU3eOUTCYMk5SHGalsvUcqmR8ytYRc9NOc=
X-Received: by 2002:a2e:9b90:: with SMTP id z16mr11153242lji.254.1583798948111;
 Mon, 09 Mar 2020 17:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com> <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com> <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
 <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com> <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
 <CALCETrWF1NQeGXy0GXRwW71Bc3oSN=vsXMsBqnaqs7Us7RYebQ@mail.gmail.com>
In-Reply-To: <CALCETrWF1NQeGXy0GXRwW71Bc3oSN=vsXMsBqnaqs7Us7RYebQ@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 17:08:29 -0700
Message-ID: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Andy Lutomirski <luto@amacapital.net>
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 4:59 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Mon, Mar 9, 2020 at 4:52 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Mon, Mar 9, 2020 at 4:21 PM Dave Hansen <dave.hansen@intel.com> wrote:
> > >
> > > On 3/9/20 4:11 PM, H.J. Lu wrote:
> > > > A threaded application is loaded from disk.  The object file on disk is
> > > > either CET enabled or not CET enabled.
> > >
> > > Huh.  Are you saying that all instructions executed on userspace on
> > > Linux come off of object files on the disk?  That's an interesting
> > > assertion.  You might want to go take a look at the processes on your
> > > systems.  Here's my browser for example:
> > >
> > > # for p in $(ps aux | grep chromium | awk '{print $2}' ); do cat
> > > /proc/$p/maps; done | grep ' r-xp 00000000 00:00 0'
> > > ...
> > > 202f00082000-202f000bf000 r-xp 00000000 00:00 0
> > > 202f000c2000-202f000c3000 r-xp 00000000 00:00 0
> > > 202f00102000-202f00103000 r-xp 00000000 00:00 0
> > > 202f00142000-202f00143000 r-xp 00000000 00:00 0
> > > 202f00182000-202f001bf000 r-xp 00000000 00:00 0
> > >
> > > Lots of funny looking memory areas which are anonymous and executable!
> > > Those didn't come off the disk.  Same thing in firefox.  Weird.  Any
> > > idea what those are?
> > >
> > > One guess: https://en.wikipedia.org/wiki/Just-in-time_compilation
> >
> > jitted code belongs to a process loaded from disk.  Enable CET in
> > an application which uses JIT engine means to also enable CET in
> > JIT engine.  Take git as an example, "git grep" crashed for me on Tiger
> > Lake.   It turned out that git itself was compiled with -fcf-protection and
> > git was linked against libpcre2-8.so.0 also compiled with -fcf-protection,
> > which has a JIT, sljit, which was not CET enabled.  git crashed in the
> > jitted codes due to missing ENDBR.  I had to enable CET in sljit to make
> > git working on CET enabled Tiger Lake.  So we need to enable CET in
> > JIT engine before enabling CET in applications which use JIT engine.
>
> This could presumably have been fixed by having libpcre or sljit
> disable IBT before calling into JIT code or by running the JIT code in
> another thread.  In the other direction, a non-CET libpcre build could
> build IBT-capable JITted code and enable JIT (by syscall if we allow
> that or by creating a thread?) when calling it.  And IBT has this

This is not how thread in user space works.

> fancy legacy bitmap to allow non-instrumented code to run with IBT on,
> although SHSTK doesn't have hardware support for a similar feature.

All these changes are called CET enabing.

> So, sure, the glibc-linked ELF ecosystem needs some degree of CET
> coordination, but it is absolutely not the case that a process MUST
> have all CET or no CET.  Let's please support the complicated cases in
> the kernel and the ABI too.  If glibc wants to make it annoying to do
> complicated things, so be it.  People work behind glibc's back all the
> time.

CET is no different from NX in this regard.


-- 
H.J.
