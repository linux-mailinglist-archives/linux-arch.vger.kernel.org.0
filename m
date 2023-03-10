Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB156B5155
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 21:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCJUBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 15:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCJUBt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 15:01:49 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF51E1269A0;
        Fri, 10 Mar 2023 12:01:22 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i40so3031029ybj.6;
        Fri, 10 Mar 2023 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678478481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rMajKPlukOFScOPbRwwnHlbAAnnm+wD1XJWf/zrgo6Y=;
        b=mQ1oCuhHwwzWaWz5TsjdcGHpWv80yPDQKSmQ5S3UhuwkS3oZkFtwuWvkaVKqWxu+3n
         qduTJ2bOjxWujFIC4DPvuPMxfiAzXSfxW4oQP3CTOcnuzX8th36ghGHYLlD1yDvYwgMt
         UAGq5snA/tZ0j+BmAkFod7JGjmek5C2Y4yl8YSlXlt2xPhHXPwW6PbkFMFSgFQYs65yH
         8eFTYhXceKr8ogYdF8zn62q1o5gLeW44A2J8OEqksw0pL5uKwnj6eNB/XN9Eczdomz7a
         q2AeSAUbL2SQIUmgZRpNJrzLXnr+Kxgp7PiMMzPJQLLFGE/sART58ahCfaWvkALyFEMN
         a2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678478481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMajKPlukOFScOPbRwwnHlbAAnnm+wD1XJWf/zrgo6Y=;
        b=Zxl37a8D6JNQWQzB1mAGlCNmj8TkNo7Ollv0WlJWBSybc3lLmakIl6hxmSyGdl3uHM
         PRfJ3CbB4FZSr5Lx2xGb2ohHICGGJXP7pyc4dOWvUk/tBMs9DE+CTfkA9EkomJxnvFpw
         Bgxkgx1z5c6pA5uJGocGZF0oQ0rzIyyEdhKMnWzG/9D2H5HrKbLg/ira3O5V8ZOZ8WhA
         Q0CN3SqmRfy/yBQqDL2kSSEjyCSAP6yCo91vuhpUXXASSySwpUWGHU0UV4YbGDiXFMGP
         Qb7rVzHR4U52YR4GqjhEU3FcSBAS3WDM815aPr8oTcoylTxxAm75BKgDdiE/BEM0VLHS
         V6gg==
X-Gm-Message-State: AO0yUKWqI/k/94OxbYjglS3IEgq5DExRlcIy8YhOe3l5R8m4GD+BklcO
        L/HIUrFxT12RF/+nu226ASCWl+xQbojjWBz1FZ8=
X-Google-Smtp-Source: AK7set/olATMQ9NzmCLn15IVlrzil6NmyEBv4MIA22HBr49tKNeKL4RLrr4tKGlQ4ktzTE77/s2m7A6H3IQo02ugN/g=
X-Received: by 2002:a25:8b8f:0:b0:906:307b:1449 with SMTP id
 j15-20020a258b8f000000b00906307b1449mr16259959ybl.5.1678478480999; Fri, 10
 Mar 2023 12:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com> <ZAhjLAIm91rJ2Lpr@zn.tnic>
 <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
 <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local> <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
 <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local> <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
 <CAMe9rOrK2d6+Y_Xb+NUW4i+GWRbX+mGx+mJLwnEAB4hvsQ_eiw@mail.gmail.com>
In-Reply-To: <CAMe9rOrK2d6+Y_Xb+NUW4i+GWRbX+mGx+mJLwnEAB4hvsQ_eiw@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 10 Mar 2023 12:00:45 -0800
Message-ID: <CAMe9rOo990TPY-VDzOgGq7aN1aQUjZaWiXLRC81XTq_xqFUm9w@mail.gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 9, 2023 at 6:03 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Mar 9, 2023 at 5:13 PM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> >
> > +Joao regarding mixed mode designs
> >
> > On Fri, 2023-03-10 at 00:51 +0100, Borislav Petkov wrote:
> > > On Thu, Mar 09, 2023 at 04:56:37PM +0000, Edgecombe, Rick P wrote:
> > > > There is a proc that shows if shadow stack is enabled in a thread.
> > > > It
> > > > does indeed come later in the series.
> > >
> > > Not good enough:
> > >
> > > 1. buried somewhere in proc where no one knows about it
> > >
> > > 2. it is per thread so user needs to grep *all*
> >
> > See "x86: Expose thread features in /proc/$PID/status" for the patch.
> > We could emit something in dmesg I guess? The logic would be:
> >  - Record the presence of elf SHSTK bit on exec
> >  - On shadow stack disable, if it had the elf bit, pr_info("bad!")
> >
> > >
> > > >   ... We previously tried to add some batch operations to improve
> > > > the
> > > >   performance, but tglx had suggested to start with something
> > > > simple.
> > > >   So we end up with this simple composable API.
> > >
> > > I agree with starting simple and thanks for explaining this in
> > > detail.
> > >
> > > TBH, though, it already sounds like a mess to me. I guess a mess
> > > we'll
> > > have to deal with because there will always be this case of some
> > > shared object/lib not being enabled for shstk because of raisins.
> >
> > The compatibility problems are totally the mess in this whole thing.
> > When you try to look at a "permissive" mode that actually works it gets
> > even more complex. Joao and I have been banging our heads on that
> > problem for months.
> >
> > But there are some expected users of this that say: we compile and
> > check our known set of binaries, we won't get any surprises. So it's
> > more of a distro problem.
> >
> > >
> > > And TBH #2, I would've done it even simpler: if some shared object
> > > can't
> > > do shadow stack, we disable it for the whole process. I mean, what's
> > > the
> > > point?
> >
> > You mean a late loaded dlopen()ed DSO? The enabling logic can't know
> > this will happen ahead of time.
> >
> > If you mean if the shared objects in the elf all support shadow stack,
> > then this is what happens. The complication is that the loader wants to
> > enable shadow stack before it has checked the elf libs so it doesn't
> > underflow the shadow stack when it returns from the function that does
> > this checking.
> >
> > So it does:
> > 1. Enable shadow stack
> > 2. Call elf libs checking functions
> > 3. If all good, lock shadow stack. Else, disable shadow stack.
> > 4. Return from elf checking functions and if shstk is enabled, don't
> > underflow because it was enabled in step 1 and we have return addresses
> > from 2 on the shadow stack
> >
> > I'm wondering if this can't be improved in glibc to look like:
> > 1. Check elf libs, and record it somewhere
> > 2. Wait until just the right spot
> > 3. If all good, enable and lock shadow stack.
>
> I will try it out.
>

Currently glibc enables shadow stack as early as possible.  There
are only a few places where a function call in glibc never returns.
We can enable shadow stack just before calling main.   There are
quite some code paths without shadow stack protection.   Is this
an issue?

H.J.
