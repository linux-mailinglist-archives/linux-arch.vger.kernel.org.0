Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF636BD9D6
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 21:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCPUH3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCPUH1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 16:07:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7374C3D08F
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 13:07:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p203so3307692ybb.13
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 13:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678997239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rShOXnkwmcluUFnoOiiTG/JZOx+YqWy4f7pfFSQut3M=;
        b=EWv/pzQzMkLOqKsEe+DvegvGPL3CTzsvKl/2EAKCFVLAGv4EUycgjoSMH5X/RVmVOv
         bXzQGrPvuhygzyJJaNwq7vYsS+zxRqKnusQ101koPFo4RQ6NZA7YZ6wY9UTORy5GMgWf
         N7L4KjKTRcPRYKwYuifr+zeLrU25M9RprAB5yXzjQJtKF/ZeiapIJKHFJyK2EeTZq1bS
         t7rgvgW2jTy79fQbJaAayqsVC4NXCqaedQ/hJAkApu+oL94bimY0J6jX7e7jljzFaskt
         /GP6JpLoFqFfdHgk/tic8IHykbmrpYguhxGnIXqRrbJnQumjCgWJb1t6BGcJrd0IQaeL
         KnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rShOXnkwmcluUFnoOiiTG/JZOx+YqWy4f7pfFSQut3M=;
        b=3o2jReWDwHgR7UXKDBAZ8XDWmSWtrapByNYgW611IOnbsPAcKhsKbgCy+NjPve1sxA
         EChjK9klhrdsldzcbhOANtubz2r8wwQiVMZj6RkiNDsbY4tRWmwRlXtQ6gT/JxwiPAgk
         6LU6+qE/m10HLPyWE5KeUo+lqdSRd94VekjHUYPohARvgyJQf8tqwfxL/nVfw/h3a0OM
         G/A96482vgsyHOdcZwQ23jnvoJItpbbgv27q8tWTB9JqbxWghQW4efx6CQMc2X2EGiCM
         2aPGKRdoE6BP8p8ucV9Vh0WJ5lWGgcxhse74yhGNnG/OE69kT8ZEgbGPKF7gxs2pxvZA
         n0Ig==
X-Gm-Message-State: AO0yUKXFYjmk/KOphZxI0btUYOPAdJNN0/QL7WtZJWru79ryLcx5Nmf0
        Rscv5AhtRaG0bDR8njMhi74whK0WSwYTM/Sx98S5vA==
X-Google-Smtp-Source: AK7set94/P+4dZkTurIWH4VJ5w4f1b+xab/AUWUURaE+NfoC2IQzgasYwNoomso2jtTnW0+FZdL2Xa6q/5b5SdrJzRA=
X-Received: by 2002:a05:6902:188:b0:a99:de9d:d504 with SMTP id
 t8-20020a056902018800b00a99de9dd504mr28724318ybh.12.1678997239350; Thu, 16
 Mar 2023 13:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com> <ZADbP7HvyPHuwUY9@arm.com>
 <20230309185511.GA1964069@debug.ba.rivosinc.com> <aaf918de8585204fb0785ac1fc0f686a8fd88bb0.camel@intel.com>
 <20230309210817.GB1964069@debug.ba.rivosinc.com> <a3c951fee51cc05e291d3a570ed485eaec1963cf.camel@intel.com>
 <20230310210054.GA2286507@debug.ba.rivosinc.com> <fb12a7efba525bbae26113666fc4418a10ee5adf.camel@intel.com>
In-Reply-To: <fb12a7efba525bbae26113666fc4418a10ee5adf.camel@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Thu, 16 Mar 2023 13:07:08 -0700
Message-ID: <CAKC1njQX+mS-64dAR9AMbNNec7WGOMJW1wfcx-dOf-HRx2Re9Q@mail.gmail.com>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "al.grant@arm.com" <al.grant@arm.com>, "nd@arm.com" <nd@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 10, 2023 at 1:43=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2023-03-10 at 13:00 -0800, Deepak Gupta wrote:
> > On Fri, Mar 10, 2023 at 12:14:01AM +0000, Edgecombe, Rick P wrote:
> > > On Thu, 2023-03-09 at 13:08 -0800, Deepak Gupta wrote:
> > > > On Thu, Mar 09, 2023 at 07:39:41PM +0000, Edgecombe, Rick P
> > > > wrote:
> > > > > On Thu, 2023-03-09 at 10:55 -0800, Deepak Gupta wrote:
> > > > > > On Thu, Mar 02, 2023 at 05:22:07PM +0000, Szabolcs Nagy
> > > > > > wrote:
> > > > > > > The 02/27/2023 14:29, Rick Edgecombe wrote:
> > > > > > > > Previously, a new PROT_SHADOW_STACK was attempted,
> > > > > > >
> > > > > > > ...
> > > > > > > > So rather than repurpose two existing syscalls (mmap,
> > > > > > > > madvise)
> > > > > > > > that don't
> > > > > > > > quite fit, just implement a new map_shadow_stack syscall
> > > > > > > > to
> > > > > > > > allow
> > > > > > > > userspace to map and setup new shadow stacks in one step.
> > > > > > > > While
> > > > > > > > ucontext
> > > > > > > > is the primary motivator, userspace may have other
> > > > > > > > unforeseen
> > > > > > > > reasons to
> > > > > > > > setup it's own shadow stacks using the WRSS instruction.
> > > > > > > > Towards
> > > > > > > > this
> > > > > > > > provide a flag so that stacks can be optionally setup
> > > > > > > > securely
> > > > > > > > for the
> > > > > > > > common case of ucontext without enabling WRSS. Or
> > > > > > > > potentially
> > > > > > > > have the
> > > > > > > > kernel set up the shadow stack in some new way.
> > > > > > >
> > > > > > > ...
> > > > > > > > The following example demonstrates how to create a new
> > > > > > > > shadow
> > > > > > > > stack with
> > > > > > > > map_shadow_stack:
> > > > > > > > void *shstk =3D map_shadow_stack(addr, stack_size,
> > > > > > > > SHADOW_STACK_SET_TOKEN);
> > > > > > >
> > > > > > > i think
> > > > > > >
> > > > > > > mmap(addr, size, PROT_READ, MAP_ANON|MAP_SHADOW_STACK, -1,
> > > > > > > 0);
> > > > > > >
> > > > > > > could do the same with less disruption to users (new
> > > > > > > syscalls
> > > > > > > are harder to deal with than new flags). it would do the
> > > > > > > guard page and initial token setup too (there is no flag
> > > > > > > for
> > > > > > > it but could be squeezed in).
> > > > > >
> > > > > > Discussion on this topic in v6
> > > > > >
> > > > >
> > > > >
> > >
> > >
> https://lore.kernel.org/all/20230223000340.GB945966@debug.ba.rivosinc.com=
/
> > > > > >
> > > > > > Again I know earlier CET patches had protection flag and
> > > > > > somehow
> > > > > > due
> > > > > > to pushback
> > > > > > on mailing list,
> > > > > >  it was adopted to go for special syscall because no one else
> > > > > > had shadow stack.
> > > > > >
> > > > > > Seeing a response from Szabolcs, I am assuming arm4 would
> > > > > > also
> > > > > > want
> > > > > > to follow
> > > > > > using mmap to manufacture shadow stack. For reference RFC
> > > > > > patches
> > > > > > for
> > > > > > risc-v shadow stack,
> > > > > > use a new protection flag =3D PROT_SHADOWSTACK.
> > > > > >
> > > > >
> > > > >
> > >
> > >
> https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
> > > > > >
> > > > > > I know earlier discussion had been that we let this go and do
> > > > > > a
> > > > > > re-
> > > > > > factor later as other
> > > > > > arch support trickle in. But as I thought more on this and I
> > > > > > think it
> > > > > > may just be
> > > > > > messy from user mode point of view as well to have cognition
> > > > > > of
> > > > > > two
> > > > > > different ways of
> > > > > > creating shadow stack. One would be special syscall (in
> > > > > > current
> > > > > > libc)
> > > > > > and another `mmap`
> > > > > > (whenever future re-factor happens)
> > > > > >
> > > > > > If it's not too late, it would be more wise to take `mmap`
> > > > > > approach rather than special `syscall` approach.
> > > > >
> > > > > There is sort of two things intermixed here when we talk about
> > > > > a
> > > > > PROT_SHADOW_STACK.
> > > > >
> > > > > One is: what is the interface for specifying how the shadow
> > > > > stack
> > > > > should be provisioned with data? Right now there are two ways
> > > > > supported, all zero or with an X86 shadow stack restore token
> > > > > at
> > > > > the
> > > > > end. Then there was already some conversation about a third
> > > > > type.
> > > > > In
> > > > > which case the question would be is using mmap MAP_ flags the
> > > > > right
> > > > > place for this? How many types of initialization will be needed
> > > > > in
> > > > > the
> > > > > end and what is the overlap between the architectures?
> > > >
> > > > First of all, arches can choose to have token at the bottom or
> > > > not.
> > > >
> > > > Token serve following purposes
> > > >   - It allows one to put desired value in shadow stack pointer in
> > > > safe/secure manner.
> > > >     Note: x86 doesn't provide any opcode encoding to value in SSP
> > > > register. So having
> > > >     a token is kind of a necessity because x86 doesn't easily
> > > > allow
> > > > writing shadow stack.
> > > >
> > > >   - A token at the bottom acts marker / barrier and can be useful
> > > > in
> > > > debugging
> > > >
> > > >   - If (and a big *if*) we ever reach a point in future where
> > > > return
> > > > address is only pushed
> > > >     on shadow stack (x86 should have motivation to do this
> > > > because
> > > > less uops on call/ret),
> > > >     a token at the bottom (bottom means lower address) is
> > > > ensuring
> > > > sure shot way of getting
> > > >     a fault when exhausted.
> > > >
> > > > Current RISCV zisslpcfi proposal doesn't define CPU based tokens
> > > > because it's RISC.
> > > > It allows mechanisms using which software can define formatting
> > > > of
> > > > token for itself.
> > > > Not sure of what ARM is doing.
> > >
> > > Ok, so riscv doesn't need to have the kernel write the token, but
> > > x86
> > > does.
> > >
> > > >
> > > > Now coming to the point of all zero v/s shadow stack token.
> > > > Why not always have token at the bottom?
> > >
> > > With WRSS you can setup the shadow stack however you want. So the
> > > user
> > > would then have to take care to erase the token if they didn't want
> > > it.
> > > Not the end of the world, but kind of clunky if there is no reason
> > > for
> > > it.
> >
> > Yes but kernel always assumes the user is going to use the token. It'
> > upto the user
> > to decide whether they want to use the restore token or not. If
> > they've WRSS capability
> > security posture is anyways diluted. An attacker who would be clever
> > enough to
> > re-use `RSTORSSP` present in address space to restore using kernel
> > prepared token, should
> > anyways can be clever enough to use WRSS as well.
> >
> > It kind of makes shadow stack creation simpler for kernel to always
> > place the token.
> > This point is irrespective of whether to use system call or mmap.
>
> Think about like CRIU restoring the shadow stack, or other special
> cases like that. Userspace can always overwrite the token, but this
> involves some amount of extra work (extra writes, earlier faulting in
> the page, etc). It is clunky and very negligibly worse.

Earlier faulting in the page because the kernel is writing the token at bas=
e?

>
> >
> > >
> > > >
> > > > In case of x86, Why need for two ways and why not always have a
> > > > token
> > > > at the bottom.
> > > > The way x86 is going, user mode is responsible for establishing
> > > > shadow stack and thus
> > > > whenever shadow stack is created then if x86 kernel
> > > > implementation
> > > > always place a token
> > > > at the base/bottom.
> > >
> > > There was also some discussion recently of adding a token AND an
> > > end of
> > > stack marker, as a potential solution for backtracing in ucontext
> > > stacks. In this case it could cause an ABI break to just start
> > > adding
> > > the end of stack marker where the token was, and so would require a
> > > new
> > > map_shadow_stack flag.
> >
> > Was this discussed why restore token itself can't be used as marker
> > for
> > end of stack (if we assume there is always going to be one at the
> > bottom).
> > It's a unique value. An address pointing to itself.
>
> I thought the same thing at first, but it gets clobbered during the
> pivot and push.

aah I remember. It was changed from savessp/rstorssp pair to
rstorssp/saveprevssp to follow the `make before break` model.

>
> >
> > >
> > > >
> > > > Now user mode can do following:--
> > > >   - If it has access to WRSS, it can sure go ahead and create a
> > > > token
> > > > of its choosing and
> > > >     overwrite kernel created token. and then do RSTORSSP on it's
> > > > own
> > > > created token.
> > > >
> > > >   - If it doesn't have access to WRSS (and dont need to create
> > > > its
> > > > own token), it can do
> > > >     RSTORSSP on this. As soon as it does, no other thread in
> > > > process
> > > > can restore to it.
> > > >     On `fork`, you get the same un-restorable token.
> > > >
> > > > So why not always have a token at the bottom.
> > > > This is my plan for riscv implementation as well (to have a token
> > > > at
> > > > the bottom)
> > > >
> > > > >
> > > > > The other thing is: should shadow stack memory creation be
> > > > > tightly
> > > > > controlled? For example in x86 we limit this to anonymous
> > > > > memory,
> > > > > etc.
> > > > > Some reasons for this are x86 specific, but some are not. So if
> > > > > we
> > > > > disallow most of the options why allow the interface to take
> > > > > them?
> > > > > And
> > > > > then you are in the position of carefully maintaining a list of
> > > > > not-
> > > > > allowed options instead letting a list of allowed options sit
> > > > > there.
> > > >
> > > > I am new to linux kernel and thus may be not able to follow the
> > > > argument of
> > > > limiting to anonymous memory.
> > > >
> > > > Why is limiting it to anonymous memory a problem. IIRC, ARM's
> > > > PROT_MTE is applicable
> > > > only to anonymous memory. I can probably find few more examples.
> > >
> > > Oh I see, they have a special arch VMA flag VM_MTE_ALLOWED that
> > > only
> > > gets set if all the rules are followed. Then PROT_MTE can only be
> > > set
> > > on that to set VM_MTE. That is kind of nice because certain other
> > > special situations can choose to support it.
> >
> > That's because MTE is different. It allows to assign tags to existing
> > virtual memory. So one need to know whether a memory can have tags
> > assigned.
> >
> > >
> > > It does take another arch vma flag though. For x86 I guess I would
> > > need
> > > to figure out how to squeeze VM_SHADOW_STACK into other flags to
> > > have a
> > > free flag to use the same method. It also only supports mprotect()
> > > and
> > > shadow stack would only want to support mmap(). And you still have
> > > the
> > > initialization stuff to plumb through. Yea, I think the PROT_MTE is
> > > a
> > > good thing to consider, but it's not super obvious to me how
> > > similar
> > > the logic would be for shadow stack.
> >
> > I dont think you need another VMA flag. Memory tagging allows adding
> > tags
> > to existing virtual memory.
>
> ...need another VMA flag to use the existing mmap arch breakouts in the
> same way as VM_MTE. Of course changing mmap makes other solutions
> possible.
>
> >  That's why having `mprotect` makes sense for MTE.
> > In shadow stack case, there is no requirement of changing a shadow
> > stack
> > to regular memory or vice-versa.
>
> uffd needs mprotect internals. You might take a look at it in regards
> to your VM_WRITE/mprotect blocking approach for riscv. I was imagining,
> even if mmap was the syscall, mprotect() would not be blocked in the
> x86 case at least. The mprotect() blocking is a separate thing than the
> syscall, right?

Yes, mprotect blocking is a different thing.
VM_XXX flags are not exposed to mprotect (or any memory mapping API).
PROT_XXX flags are. On riscv, in my current plan if mprotect or mmap
specifies PROT_WRITE (no PROT_READ),
It'll be mapped to `VM_READ | VM_WRITE` on vma flags (this is to make
sure we don't break compat with existing user code which has
been using only PROT_WRITE)

If PROT_SHADOWSTACK (new protection flag) is specified, it'll be
mapped to `VM_WRITE` on the vma_flag.

Yes I am aware of uffd. I intend to handle it the same way I am
handling the fork of riscv shadow stack.
core-mm write protect checks if VM_WRiTE is specified it'll convert
PTE encodings to read-only.
uffd for regular memory should work as it is. In case if someone was
monitoring shadow stack memory, following could occur

1) A write happens on shadow stack memory, a store page fault would occur.
2) A read happens, this would be allowed.
3) A shadow stack load / store happens, a store access fault would occur.

Case 1 and 3 are reported to the kernel and it can make sure the uffd
monitor is reported about it.

Was there a specific concern here with respect to uffd and x86 shadow stack=
?

>
> >
> > All that's needed to change is `mmap`. `mprotect` should fail.
> > Syscall
> > approach gives that benefit by default because there is no protection
> > flag
> > for shadow stack.
> >
> > I was giving example that any feature which gives new meaning to
> > virtual memory
> > has been able to work with existing memory mapping APIs without the
> > need of new
> > system call (including whether you're dealing with anonymous memory).
> >
> > >
> > > The question I'm asking though is, not "can mmap code and rules be
> > > changed to enforce the required limitations?". I think it is yes.
> > > But
> > > the question is "why is that plumbing better than a new syscall?".
> > > I
> > > guess to get a better idea, the mmap solution would need to get
> > > POCed.
> > > I had half done this at one point, but abandoned the approach.
> > >
> > > For your question about why limit it, the special x86 case is the
> > > Dirty=3D1,Write=3D0 PTE bit combination for shadow stacks. So for
> > > shadow
> > > stack you could have some confusion about whether a PTE is actually
> > > dirty for writeback, etc. I wouldn't say it's known to be
> > > impossible to
> > > do MAP_SHARED, but it has not been fully analyzed enough to know
> > > what
> > > the changes would be. There were some solvable concrete issues that
> > > tipped the scale as well. It was also not expected to be a common
> > > usage, if at all.
> >
> > I am not sure how confusion of D=3D1,W=3D0 is not completely taken away
> > by
> > syscall approach. It'll always be there. One can only do things to
> > minimize
> > the chances.
> >
> > In case of syscall approach, syscall makes sure that
> >
> > `flags =3D MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G`
> >
> > This can be easily checked in arch specific landing function for
> > mmap.
>
> Right, this is why I listed two types of things in the mix here. The
> memory features supported, and what the syscall is. You asked why limit
> the memory features, so that is the explanation.
>
> >
> >
> > Additionally, If you always have the token at base, you don't need
> > that ABI
> > between user and kernel.
> >
> >
> > >
> > > The non-x86, general reasons for it, are for a smaller benefit. It
> > > blocks a lot of ways shadow stack memory could be written to. Like
> > > say
> > > you have a memory mapped writable file, and you also map it shadow
> > > stack. So it has better security properties depending on what your
> > > threat model is.
> >
> > I wouldn't say any architecture should allow such primitives. It kind
> > of defeats
> > the purpose for shadow stack. Yes if some sort of secure memory is
> > needed, there may
> > be new ISA extensions for that.
>
> Yea, seems reasonable to prevent this regardless of the extra x86
> reasons, if that is what you are saying. It depends on people's threat
> models (as always in security).
>
> >
> > >
> > > >
> > > > Eventually syscall will also go ahead and use memory management
> > > > code
> > > > to
> > > > perform mapping. So I didn't understand the reasoning here. The
> > > > way
> > > > syscall
> > > > can limit it to anonymous memory, why mmap can't do the same if
> > > > it
> > > > sees
> > > > PROT_SHADOWSTACK.
> > > >
> > > > >
> > > > > The only benefit I've heard is that it saves creating a new
> > > > > syscall,
> > > > > but it also saves several MAP_ flags. That, and that the RFC
> > > > > for
> > > > > riscv
> > > > > did a PROT_SHADOW_STACK to start. So, yes, two people asked the
> > > > > same
> > > > > question, but I'm still not seeing any benefits. Can you give
> > > > > the
> > > > > pros
> > > > > and cons please?
> > > >
> > > > Again the way syscall will limit it to anonymous memory, Why mmap
> > > > can't do same?
> > > > There is precedence for it (like PROT_MTE is applicable only to
> > > > anonymous memory)
> > > >
> > > > So if it can be done, then why introduce a new syscall?
> > > >
> > > > >
> > > > > BTW, in glibc map_shadow_stack is called from arch code. So I
> > > > > think
> > > > > userspace wise, for this to affect other architectures there
> > > > > would
> > > > > need
> > > > > to be some code that could do things generically, with somehow
> > > > > the
> > > > > shadow stack pivot abstracted but the shadow stack allocation
> > > > > not.
> > > >
> > > > Agreed, yes it can be done in a way where it won't put tax on
> > > > other
> > > > architectures.
> > > >
> > > > But what about fragmentation within x86. Will x86 always choose
> > > > to
> > > > use system call
> > > > method map shadow stack. If future re-factor results in x86 also
> > > > use
> > > > `mmap` method.
> > > > Isn't it a mess for x86 glibc to figure out what to do; whether
> > > > to
> > > > use system call
> > > > or `mmap`?
> > > >
> > >
> > > Ok, so this is the downside I guess. What happens if we want to
> > > support
> > > the other types of memory in the future and end up using mmap for
> > > this?
> > > Then we have 15-20 lines of extra syscall wrapping code to maintain
> > > to
> > > support legacy.
> > >
> > > For the mmap solution, we have the downside of using extra MAP_
> > > flags,
> > > and *some* amount of currently unknown vm_flag and address range
> > > logic,
> > > plus mmap arch breakouts to add to core MM. Like I said earlier,
> > > you
> > > would need to POC it out to see how bad that looks and get some
> > > core MM
> > > feedback on the new type of MAP flag usage. But, syscalls being
> > > pretty
> > > straightforward, it would probably be *some* amount of added
> > > complexity
> > > _now_ to support something that might happen in the future. I'm not
> > > seeing either one as a landslide win.
> > >
> > > It's kind of an eternal software design philosophical question,
> > > isn't
> > > it? How much work should you do to prepare for things that might be
> > > needed in the future? From what I've seen the balance in the kernel
> > > seems to be to try not to paint yourself in to an ABI corner, but
> > > otherwise let the kernel evolve naturally in response to real
> > > usages.
> > > If anyone wants to correct this, please do. But otherwise I think
> > > the
> > > new syscall is aligned with that.
> > >
> > > TBH, you are making me wonder if I'm missing something. It seems
> > > you
> > > strongly don't prefer this approach, but I'm not hearing any huge
> > > potential negative impacts. And you also say it won't tax the riscv
> > > implementation. Is this just something just smells bad here? Or it
> > > would shrink the riscv series?
> >
> > No you're not missing anything. It's just wierdness of adding a
> > system call
> > which enforces certain MAP_XX flags and pretty much mapping API.
> > And difference between architectures on how they will create shadow
> > stack. +
> > if x86 chooses to use `mmap` in future, then there is ugliness in
> > user mode to
> > decide which method to choose.
>
> Ok, I think I will leave it given it's entirely in arch/x86. It just
> got some special error codes in the other thread today too.
>
> >
> > And yes you got it right, to some extent there is my own selfishness
> > playing out
> > as well here to reduce riscv patches.
> >
>
> Feel free to join the map_shadow_stack party. :)


I am warming up to it :-)
