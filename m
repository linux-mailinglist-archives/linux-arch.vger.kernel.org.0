Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84E6A11D9
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBWVUb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 16:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBWVUb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 16:20:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E851F99
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 13:20:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x10so46454458edd.13
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGNK+81UETaPn0jcsEtslOWqhVdogFDF7Oyic4eRMC0=;
        b=dZ0PmdnqNzzjl4gyodTo7Zb17UgRMZptHwXLBomZ/AvWARR5ZPd6XaTkwjBxJFuGaT
         H0F3qnuxv3chDjD33jmtByO/Il4zihwWqNRj/EEYnB9Er7lIZ8MGu+au2KIEm8IkqdMt
         WfEamdrk6xp1+wq8oDc1jQF3iNhV3+/x/+qKI21/MbCuhRW6FiaAU6cN2nBTZzvkDg9m
         J0h8xSdbeOsGBxBQoM5VmCu+Xj2Pn3BiMhr9jxIsxQrgeI9plEFpVFpjTVHQqDV2PQ9P
         IGrsG1Wtc/Y6sEBGu7yxprbHh6Ygufryb07uAYG0eTFXjd75azPNJX+kgrT9eVceeION
         FccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGNK+81UETaPn0jcsEtslOWqhVdogFDF7Oyic4eRMC0=;
        b=KRy9dpZ4M4ECZx2Fcpo1bai2KLltNJylFAWXO/AMgsgevBzYNLf7OU4Neb/vFqUaMa
         YAoZ2LP5Z7IRexIne/4C4OBNXXTuWe/mmrqMM50fLz1rt+dd5zDYuRAxctZsH42j/PyO
         sbIVF3ymLPe9eoqPsJ5XFCVM1Mhipz7j4uCkYGsaXTE8uuebufmWqcEsjm4wR5AO5Jp5
         Zz7vEYWutHUrcIQTcVVxjhxLPKF2i3rUrw3VQ1dFr1Q8CaKLsFUNJwJAYoQ+eoYUPzXu
         l4sDe2Ms7SIYB/vTHBWUDQCXvwK2Mn1uuxv/KBBFrHREyAkBIsXK/G9ovOqlkQFr+Js8
         vOvg==
X-Gm-Message-State: AO0yUKWjNm9bn5NaIUPyM0g0fCUeoEYwS+u/PACMayJ7fjVy3PhNoWJS
        gbXiDlON9Z1Af1QzWeRHarwjLvYwWeRB7ZN1UzEX+Q==
X-Google-Smtp-Source: AK7set+KUUdbnyo5JRRHrV1ozmg6AbjBaYX0SdvoC+Bros6cRT/lBPSqwRJvMri7bJe/UlGznB+3heSzYzD8bnfAmKI=
X-Received: by 2002:a17:907:2b09:b0:8b1:cd2e:177a with SMTP id
 gc9-20020a1709072b0900b008b1cd2e177amr10778294ejc.6.1677187219479; Thu, 23
 Feb 2023 13:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-34-rick.p.edgecombe@intel.com> <20230223000340.GB945966@debug.ba.rivosinc.com>
 <49a151d5a704487d541e421699cf798c87a80ca5.camel@intel.com>
In-Reply-To: <49a151d5a704487d541e421699cf798c87a80ca5.camel@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Thu, 23 Feb 2023 13:20:06 -0800
Message-ID: <CAKC1njSXDY_NUxLdrbJbF6zGaP4aifAh3g1ku0E5RkAxK4tqLA@mail.gmail.com>
Subject: Re: [PATCH v6 33/41] x86/shstk: Introduce map_shadow_stack syscall
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 22, 2023 at 5:11 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2023-02-22 at 16:03 -0800, Deepak Gupta wrote:
> > On Sat, Feb 18, 2023 at 01:14:25PM -0800, Rick Edgecombe wrote:
> > > When operating with shadow stacks enabled, the kernel will
> > > automatically
> > > allocate shadow stacks for new threads, however in some cases
> > > userspace
> > > will need additional shadow stacks. The main example of this is the
> > > ucontext family of functions, which require userspace allocating
> > > and
> > > pivoting to userspace managed stacks.
> > >
> > > Unlike most other user memory permissions, shadow stacks need to be
> > > provisioned with special data in order to be useful. They need to
> > > be setup
> > > with a restore token so that userspace can pivot to them via the
> > > RSTORSSP
> > > instruction. But, the security design of shadow stack's is that
> > > they
> > > should not be written to except in limited circumstances. This
> > > presents a
> > > problem for userspace, as to how userspace can provision this
> > > special
> > > data, without allowing for the shadow stack to be generally
> > > writable.
> > >
> > > Previously, a new PROT_SHADOW_STACK was attempted, which could be
> > > mprotect()ed from RW permissions after the data was provisioned.
> > > This was
> > > found to not be secure enough, as other thread's could write to the
> > > shadow stack during the writable window.
> > >
> > > The kernel can use a special instruction, WRUSS, to write directly
> > > to
> > > userspace shadow stacks. So the solution can be that memory can be
> > > mapped
> > > as shadow stack permissions from the beginning (never generally
> > > writable
> > > in userspace), and the kernel itself can write the restore token.
> > >
> > > First, a new madvise() flag was explored, which could operate on
> > > the
> > > PROT_SHADOW_STACK memory. This had a couple downsides:
> > > 1. Extra checks were needed in mprotect() to prevent writable
> > > memory from
> > >    ever becoming PROT_SHADOW_STACK.
> > > 2. Extra checks/vma state were needed in the new madvise() to
> > > prevent
> > >    restore tokens being written into the middle of pre-used shadow
> > > stacks.
> > >    It is ideal to prevent restore tokens being added at arbitrary
> > >    locations, so the check was to make sure the shadow stack had
> > > never been
> > >    written to.
> > > 3. It stood out from the rest of the madvise flags, as more of
> > > direct
> > >    action than a hint at future desired behavior.
> > >
> > > So rather than repurpose two existing syscalls (mmap, madvise) that
> > > don't
> > > quite fit, just implement a new map_shadow_stack syscall to allow
> > > userspace to map and setup new shadow stacks in one step. While
> > > ucontext
> > > is the primary motivator, userspace may have other unforeseen
> > > reasons to
> > > setup it's own shadow stacks using the WRSS instruction. Towards
> > > this
> > > provide a flag so that stacks can be optionally setup securely for
> > > the
> > > common case of ucontext without enabling WRSS. Or potentially have
> > > the
> > > kernel set up the shadow stack in some new way.
> >
> > Was following ever attempted?
> >
> > void *shstk = mmap(0, size, PROT_SHADOWSTACK, ...);
> > - limit PROT_SHADOWSTACK protection flag to only mmap (and thus
> > mprotect can't
> >    convert memory from shadow stack to non-shadow stack type or vice
> > versa)
> > - limit PROT_SHADOWSTACK protection flag to anonymous memory only.
> > - top level mmap handler to put a token at the base using WRUSS if
> > prot == PROT_SHADOWSTACK
> >
> > You essentially would get shadow stack manufacturing with existing
> > (single) syscall.
> > Acting a bit selfish here, this allows other architectures as well to
> > re-use this and
> > do their own implementation of mapping and placing the token at the
> > base.
>
> Yes, I looked at it. You end up with a pile of checks and hooks added
> to mmap() and various other places as you outline. We also now have the
> MAP_ABOVE4G limitation for x86 shadow stack that would need checking
> for too. It's not exactly a clean fit. Then, callers would have to pass
> special x86 flags in anyway.

riscv has mechanisms using which a 32bit app can run on 64bit kernel.
So technically if there are 32bit and 64bit code in address space,
MAP_ABOVE4G could be useful.
Although I am not sure (or aware of) if there are such requirement
from app/developers yet (to guarantee address mapping above 4G)

But I see this as orthogonal to memory protection flags.

>
> It doesn't seem like the complexity of the checks is worth saving the
> tiny syscall. Is there some reason why riscv can't use the same syscall
> stub? It doesn't need to live forever in x86 code. Not sure what the
> savings are for riscv of the mmap+checks approach are either...

I don't see a lot of extra complexity here.
If `mprotect` and friends don't know about `PROT_SHADOWSTACK`, they'll
just fail by default (which is desired)

It's only `mmap` that needs to be enlightened. And it can just pass
`VMA_SHADOW_STACK` to `do_mmap` if input is `PROT_SHADOWSTACK`.

Adding a syscall just for mapping shadow stack is weird when it can be
solved with existing system calls.
As you say in your response below, it would be good to have such a
syscall which serve larger purposes (e.g. provisioning special
security-type memory)

arm64's memory tagging is one such example. Not exactly security-type
memory (but eventual application is security for this feature) .
It adds extra meaning to virtual addresses (i.e. an address has tags).
arm64 went about using a protection flag `PROT_MTE` instead of a
special system call.

Being said that since this patch has gone through multiple revisions
and I am new to the party. If others dont have issues on this special
system call,
I think it's fine then. In case of riscv I can choose to use this
mechanism or go via arm's route to define PROT_SHADOWSTACK which is
arch specific.

>
> I did wonder if there could be some sort of more general syscall for
> mapping and provisioning special security-type memory. But we probably
> need a few more non-shadow stack examples to get an idea of what that
> would look like.

As I mentioned memory tagging and thus PROT_MTE is already such a use
case which uses `mmap/mprotect` protection flags to designate special
meaning to a virtual address.
