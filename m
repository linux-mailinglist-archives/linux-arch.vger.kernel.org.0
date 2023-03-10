Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628D6B33ED
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 03:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCJCEc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 21:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJCEb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 21:04:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F3E4D85;
        Thu,  9 Mar 2023 18:04:26 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id i6so3927203ybu.8;
        Thu, 09 Mar 2023 18:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678413865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpXYGsa+/tLjP2Tn48cDkgbawf4lLCTFCHOzj/xyJow=;
        b=FreEnRmtxv7vK9X3Rz/OCq/dHqlNMrviZmmMz1IGFTWD6t8sMLyD74Pbo98t47bXJs
         rUGmdXXtxCX/eMlIQzuuaz2loEi/Kezj/jl5qo3Lcv1wag3bJuoTXHVviKnqHG9Sa2KO
         jedNffaFMguCPPyO7TV4kui3NNLz9arc1RCSiE0aEgfEoXNjiHG1PSt0ST2mf6pXzKNQ
         8Qn063W5CnNMyPeu6PqNMTOucwKveWLeW7euOt+JFc8LTLyBVa2GBss9F0mv/1yigN80
         dWwlHvx5z+cRpRGErVKu4atXdyQv5H7KeVdtcQ7jRoctW7BX73smfk7SqKTUK3dLeyVN
         W6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678413865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpXYGsa+/tLjP2Tn48cDkgbawf4lLCTFCHOzj/xyJow=;
        b=G+Al40Kv7Qpl3XxBiOIag2R0LL2ELK5n2N9HPYvuSdR9F2jfQCclzhaFVH43mZwNTP
         vy69KIxLgPdHqHLeYS/r0Ke/n9JtkG5mgIhtYNvbxLf0xI44hgcJ2zOE/FlJAjDBbx6x
         aQVPV1iYtGLUZiWx8ihun1Ehv2aKTFdN5hVe2I79w0oHaX34xfNgeT1uAL6jDRjR84Jl
         /HrZ2qg57/x5BRWixcKw6ClwMVOCjDTMFrarq6KYbIbXbR89zYbqnQQIHZPMdkhdp/eB
         9uK1cAWu2qda/0731elh0ICsZjCEKdbU4Z5m/qqfkNDuUAavzRi12ETISeWqNkRLENUZ
         KyXQ==
X-Gm-Message-State: AO0yUKVHoHQdW8WL2ogUAGlWCSF9RvUAlBQ5GkDq71S5rH36bH39/pWc
        jxY4i+zxaeQpLXYg/BlaDB6y+rYycgxx+5UNaaA=
X-Google-Smtp-Source: AK7set+BzG4Y5/Y1p12HS5COJNsg/gn4zCEjqL4Y9+Nj5gQFEqZabeD0GfIzWLBeO2AJRdvi92kIprvewGSCAgfoB0s=
X-Received: by 2002:a5b:38a:0:b0:ac9:cb97:bd0e with SMTP id
 k10-20020a5b038a000000b00ac9cb97bd0emr11690269ybp.5.1678413865512; Thu, 09
 Mar 2023 18:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com> <ZAhjLAIm91rJ2Lpr@zn.tnic>
 <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
 <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local> <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
 <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local> <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
In-Reply-To: <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 9 Mar 2023 18:03:49 -0800
Message-ID: <CAMe9rOrK2d6+Y_Xb+NUW4i+GWRbX+mGx+mJLwnEAB4hvsQ_eiw@mail.gmail.com>
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

On Thu, Mar 9, 2023 at 5:13 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> +Joao regarding mixed mode designs
>
> On Fri, 2023-03-10 at 00:51 +0100, Borislav Petkov wrote:
> > On Thu, Mar 09, 2023 at 04:56:37PM +0000, Edgecombe, Rick P wrote:
> > > There is a proc that shows if shadow stack is enabled in a thread.
> > > It
> > > does indeed come later in the series.
> >
> > Not good enough:
> >
> > 1. buried somewhere in proc where no one knows about it
> >
> > 2. it is per thread so user needs to grep *all*
>
> See "x86: Expose thread features in /proc/$PID/status" for the patch.
> We could emit something in dmesg I guess? The logic would be:
>  - Record the presence of elf SHSTK bit on exec
>  - On shadow stack disable, if it had the elf bit, pr_info("bad!")
>
> >
> > >   ... We previously tried to add some batch operations to improve
> > > the
> > >   performance, but tglx had suggested to start with something
> > > simple.
> > >   So we end up with this simple composable API.
> >
> > I agree with starting simple and thanks for explaining this in
> > detail.
> >
> > TBH, though, it already sounds like a mess to me. I guess a mess
> > we'll
> > have to deal with because there will always be this case of some
> > shared object/lib not being enabled for shstk because of raisins.
>
> The compatibility problems are totally the mess in this whole thing.
> When you try to look at a "permissive" mode that actually works it gets
> even more complex. Joao and I have been banging our heads on that
> problem for months.
>
> But there are some expected users of this that say: we compile and
> check our known set of binaries, we won't get any surprises. So it's
> more of a distro problem.
>
> >
> > And TBH #2, I would've done it even simpler: if some shared object
> > can't
> > do shadow stack, we disable it for the whole process. I mean, what's
> > the
> > point?
>
> You mean a late loaded dlopen()ed DSO? The enabling logic can't know
> this will happen ahead of time.
>
> If you mean if the shared objects in the elf all support shadow stack,
> then this is what happens. The complication is that the loader wants to
> enable shadow stack before it has checked the elf libs so it doesn't
> underflow the shadow stack when it returns from the function that does
> this checking.
>
> So it does:
> 1. Enable shadow stack
> 2. Call elf libs checking functions
> 3. If all good, lock shadow stack. Else, disable shadow stack.
> 4. Return from elf checking functions and if shstk is enabled, don't
> underflow because it was enabled in step 1 and we have return addresses
> from 2 on the shadow stack
>
> I'm wondering if this can't be improved in glibc to look like:
> 1. Check elf libs, and record it somewhere
> 2. Wait until just the right spot
> 3. If all good, enable and lock shadow stack.

I will try it out.

> But it depends on the loader code design which I don't know well
> enough.
>
> > Only some of the stack is shadowed so an attacker could find
> > a way to keep the process perhaps run this shstk-unsupporting shared
> > object more/longer and ROP its way around the system.
>
> I hope non-permissive mode is the standard usage eventually.
>
> >
> > But I tend to oversimplify things sometimes so...
> >
> > What I'd like to have, though, is a kernel cmdline param which
> > disables
> > permissive mode and userspace can't do anything about it. So that
> > once
> > you boot your kernel, you can know that everything that runs on the
> > machine has shstk and is properly protected.
>
> Szabolcs Nagy was commenting something similar in another thread, for
> supporting kernel enforced security policies. I think the way to do it
> would have the kernel detect the the elf bit itself (like it used to)
> and enable shadow stack on exec. If you can't rely on userspace to call
> in to enable it, it's not clear at what point the kernel should check
> that it did.
>
> But then if you trigger off of the elf bit in the kernel, you get all
> the regression issues of the old glibcs at that point. But it is
> already an "I don't care if I crash" mode, so...
>
> I think if you trust your libc, glibc could implement this in userspace
> too. It would be useful even as as testing override.
>
> >
> > Also, it'll allow for faster fixing of all those shared objects to
> > use
> > shstk by way of political pressure.



-- 
H.J.
