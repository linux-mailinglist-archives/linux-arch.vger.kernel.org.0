Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A34AA925
	for <lists+linux-arch@lfdr.de>; Sat,  5 Feb 2022 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379978AbiBENad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Feb 2022 08:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379977AbiBENad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Feb 2022 08:30:33 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514FEC061346;
        Sat,  5 Feb 2022 05:30:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i65so7562540pfc.9;
        Sat, 05 Feb 2022 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kydsOHNHODshkDxPY7KvU0T0IWce/j+hWlmL4kU26hI=;
        b=RKaNDuRkyI2bk8AGGSwckT9GYuOeNpXNRbewTWqagxKeEQQCi+l7Ec9Qj/N1DNO7md
         VFz2Plibf/8/YpjBb5V7C1g+xCf+UaNYZdw6ivLxmQSMWJ3QyZynQjR2G/dHkkIAbce8
         R3+Cwa4/UHYWr/iiRQXbTeiQpMJ1l8fT9cBYPDIaCzToTFeL3xP/1bUNMnOn9sOc7013
         tnyo4DnivzwYVatgawIoo5IgFry9EOQRXHtMniidsmmzittuV2ldYObiu9EuX6Ih2Z2w
         YsMCG6UvfVv/J2ZKkR7fRppR12p90ArFdzB+fMMOSqdVnTtxUtH1gQeVmAUJe8oRp3c/
         X7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kydsOHNHODshkDxPY7KvU0T0IWce/j+hWlmL4kU26hI=;
        b=Xv0gYqogiF3uc2nBSI6KRahRVRlQRxiiXsCckNl3cy8zzJse1GiPOPakkQNbY8Yzbz
         b9/3TIc6qcCQDbepLbJIBWZq7xnXOV1WfhF9R4mBICgK+rAxqavX8KHfA04vpYMb6mLK
         bDjbg+iNkjVlXpSV3LxCuhp+fgBG3+9dXfAdjNvxQU3/XA0PxKaGAxaZ3VCd/LcdCzlL
         YPYuLT4CMui8w9BIGYtjngG02+z6uTf9g0xGNbdiEHpGw8tJ2Fav/pOEdE2U6RMC2vam
         fYWU/Uzl367PCML+LIxaoIYocSMVuGtlrJtVDIR//HMAxTtYxIK2HestF1TX85a5ql31
         ExAA==
X-Gm-Message-State: AOAM533r9UN6e9FkSqNUYr2xGqU4noEj+VKtDmRiQa7kslZvX4q1XBEg
        ZHdB7K/Entju8eQsznMQ6WmGyGwr09gpOaYwntQ=
X-Google-Smtp-Source: ABdhPJyUTAk4OgpIaaZWXAtlcw4ZBvWQBeU1t9V5Qf8CMIAguE7Ql+OB2GPB1vX3j9em0xP40euVrtxAZQCOIjfRI1s=
X-Received: by 2002:aa7:888b:: with SMTP id z11mr7863984pfe.76.1644067831456;
 Sat, 05 Feb 2022 05:30:31 -0800 (PST)
MIME-Version: 1.0
References: <87fsozek0j.ffs@tglx> <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
 <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
In-Reply-To: <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sat, 5 Feb 2022 05:29:55 -0800
Message-ID: <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     David Laight <David.Laight@aculab.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 5, 2022 at 5:27 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Edgecombe, Rick P
> > Sent: 04 February 2022 01:08
> > Hi Thomas,
> >
> > Thanks for feedback on the plan.
> >
> > On Thu, 2022-02-03 at 22:07 +0100, Thomas Gleixner wrote:
> > > > Until now, the enabling effort was trying to support both Shadow
> > > > Stack and IBT.
> > > > This history will focus on a few areas of the shadow stack
> > > > development history
> > > > that I thought stood out.
> > > >
> > > >        Signals
> > > >        -------
> > > >        Originally signals placed the location of the shadow stack
> > > > restore
> > > >        token inside the saved state on the stack. This was
> > > > problematic from a
> > > >        past ABI promises perspective. So the restore location was
> > > > instead just
> > > >        assumed from the shadow stack pointer. This works because in
> > > > normal
> > > >        allowed cases of calling sigreturn, the shadow stack pointer
> > > > should be
> > > >        right at the restore token at that time. There is no
> > > > alternate shadow
> > > >        stack support. If an alt shadow stack is added later we
> > > > would
> > > >        need to
> > >
> > > So how is that going to work? altstack is not an esoteric corner
> > > case.
> >
> > My understanding is that the main usages for the signal stack were
> > handling stack overflows and corruption. Since the shadow stack only
> > contains return addresses rather than large stack allocations, and is
> > not generally writable or pivotable, I thought there was a good
> > possibility an alt shadow stack would not end up being especially
> > useful. Does it seem like reasonable guesswork?
>
> The other 'problem' is that it is valid to longjump out of a signal handler.
> These days you have to use siglongjmp() not longjmp() but it is still used.
>
> It is probably also valid to use siglongjmp() to jump from a nested
> signal handler into the outer handler.
> Given both signal handlers can have their own stack, there can be three
> stacks involved.
>
> I think the shadow stack pointer has to be in ucontext - which also
> means the application can change it before returning from a signal.
> In much the same way as all the segment registers can be changed
> leading to all the nasty bugs when the final 'return to user' code
> traps in kernel when loading invalid segment registers or executing iret.
>
> Hmmm... do shadow stacks mean that longjmp() has to be a system call?

No.  setjmp/longjmp save and restore shadow stack pointer.

--
H.J.
