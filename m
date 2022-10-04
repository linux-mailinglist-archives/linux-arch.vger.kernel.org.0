Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D55F4C93
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 01:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJDXRI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 19:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDXRG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 19:17:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A22A735;
        Tue,  4 Oct 2022 16:17:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g2so9338145qkk.1;
        Tue, 04 Oct 2022 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zSufA2BleX6KW+Heb1fzbCfbakErWjyYXp3z/uacu+I=;
        b=MMg3u1+s+231ITnh092QPi56B1YNS5CXal+weHc2Gl1NpCIkIZ3tdGsu6gqG6+NgH1
         HsDy5GTb3SMo3n1bUlC5Fsn2r/PbI/CZmnR3ppB+GQmU+xRHBCczAOlMfvUGjhCOX6mN
         scf1NFBcYHyVs8zMY6dj74/wc5Dm8TyJkMOsdEAhnOviveUQj21l9K1Jtu9wGYiRN1Xn
         xrubb9IZVXCsW8dGan2jPjTwo7MqEQg+/klk5dEWIPZRE2WMPOl/A2o13gzNbhB+blGu
         gU4CA812ZTE5rjSZFomkZ+sgAw1JzIhtscUP3vztlKzROHA340jmlzzYJ8ZK9STed1mX
         gkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zSufA2BleX6KW+Heb1fzbCfbakErWjyYXp3z/uacu+I=;
        b=lUzECeTvQ/LXyDF7eaDtqhXoabb+cUR97F69SPFs74bhe3KVOSfd2+kOGdZlc4ntO8
         jpVzrFISWieWaLbmWYdonBUZjgPIrGqx0mMUFhGfAAqQm3zqMsawSqc0u9vOupa2TDyB
         iZhJsm2E7CorU1S+SwqPLgbyURbMDWTmbfEoQvp4/Iwpj0oBi+rsYHtZ4PuFzKM96XMw
         fnNG4e99mr+rr/so5h9MqTSGexgwpBXQF06SfNMqhOvE6o+mGlMeCpIbYTjtheW6dior
         /B4xhkErdBlm9ZI4juD/VHHTXc+D+h1Ip0P+rzH20c/AafvrjWnUIgiFtvm6go5fasxp
         jMtw==
X-Gm-Message-State: ACrzQf2eDaNlGIENbIyKa51RFxZQNAFieU/RECkTgXmWK/eU5Mf2KUHb
        7nZVVk8a3nh78JhD+gBRjT8BR5MVnITo6UEm2MM=
X-Google-Smtp-Source: AMsMyM53PakVoR8R2PIBC98o88+P7qUZY44ZI0/EscGu86qlGmjTuTg/e/ORY2Q7BrAqElyypw1bVcqqZ44Oh6ilgpQ=
X-Received: by 2002:a05:620a:2683:b0:6cf:3768:8e4b with SMTP id
 c3-20020a05620a268300b006cf37688e4bmr18121144qkp.768.1664925424245; Tue, 04
 Oct 2022 16:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-29-rick.p.edgecombe@intel.com> <202210031446.E4AD9EE66@keescook>
 <fd227d72e0c2251f97ff3fd0ed50fd5f8d19c8b8.camel@intel.com>
In-Reply-To: <fd227d72e0c2251f97ff3fd0ed50fd5f8d19c8b8.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 4 Oct 2022 16:16:28 -0700
Message-ID: <CAMe9rOruJJu6B9oLjpu5NYH5fVQZ5MPPCKc5hf3k6uYDCyOGBw@mail.gmail.com>
Subject: Re: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack syscall
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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

On Tue, Oct 4, 2022 at 3:56 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-10-03 at 15:23 -0700, Kees Cook wrote:
> > On Thu, Sep 29, 2022 at 03:29:25PM -0700, Rick Edgecombe wrote:
> > > [...]
> > > The following example demonstrates how to create a new shadow stack
> > > with
> > > map_shadow_stack:
> > > void *shstk = map_shadow_stack(adrr, stack_size,
> > > SHADOW_STACK_SET_TOKEN);
> >
> > typo: addr
>
> Yep, thanks.
>
>
> >
> > > [...]
> > > +451        common  map_shadow_stack        sys_map_shadow_stac
> > > k
> >
> > Isn't this "64", not "common"?
>
> Yes, this should have been changed after dropping 32 bit.

We don't support ia32.  But this is used for x32 which is supported.

> >
> > > [...]
> > > +#define SHADOW_STACK_SET_TOKEN     0x1     /* Set up a restore token
> > > in the shadow stack */
> >
> > I think this should get an intro comment, like:
> >
> > /* Flags for map_shadow_stack(2) */
> >
> > Also, as with the other UAPI fields, please use "(1ULL << 0)" here.
>
> Ok.
>
> >
> > > @@ -62,24 +63,34 @@ static int create_rstor_token(unsigned long
> > > ssp, unsigned long *token_addr)
> > >     if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
> > >             return -EFAULT;
> > >
> > > -   *token_addr = addr;
> > > +   if (token_addr)
> > > +           *token_addr = addr;
> > >
> > >     return 0;
> > >  }
> > >
> >
> > Can this just be collapsed into the patch that introduces
> > create_rstor_token()?
>
> I mean, yea, that would be simpler. Breaking the changes apart was left
> over from when the signals placed a token, but didn't need this extra
> bit of functionality.
>
> >
> > > -static unsigned long alloc_shstk(unsigned long size)
> > > +static unsigned long alloc_shstk(unsigned long addr, unsigned long
> > > size,
> > > +                            unsigned long token_offset, bool
> > > set_res_tok)
> > >  {
> > >     int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> > >     struct mm_struct *mm = current->mm;
> > > -   unsigned long addr, unused;
> > > +   unsigned long mapped_addr, unused;
> > >
> > >     mmap_write_lock(mm);
> > > -   addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> >
> > Oops, I missed in the other patch that "addr" was being passed here.
> > (uninitialized?)
>
> Argh, yes. I'll initialize in that patch and remove it here.
>
> >
> > > -                  VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
> > > -
> > > +   mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> > > +                         VM_SHADOW_STACK | VM_WRITE, 0, &unused,
> > > NULL);
> >
> > I don't see do_mmap() doing anything here to avoid remapping a prior
> > vma
> > as shstk. Is the intention to allow userspace to convert existing
> > VMAs?
> > This has caused pain in the past, perhaps force MAP_FIXED_NOREPLACE ?
>
> No that is not the intention. It should fail and MAP_FIXED_NOREPLACE
> looks like it will fit the bill. Thanks!
>
> >
> > > [...]
> > > @@ -174,6 +185,7 @@ int shstk_alloc_thread_stack(struct task_struct
> > > *tsk, unsigned long clone_flags,
> > >
> > >
> > >     stack_size = PAGE_ALIGN(stack_size);
> > > +   addr = alloc_shstk(0, stack_size, 0, false);
> > >     if (IS_ERR_VALUE(addr))
> > >             return PTR_ERR((void *)addr);
> > >
> >
> > As mentioned earlier, I was expecting this patch to replace a
> > (missing)
> > call to alloc_shstk. i.e. expecting:
> >
> > -     addr = alloc_shstk(stack_size);
> >
> > > @@ -395,6 +407,26 @@ int shstk_disable(void)
> > >     return 0;
> > >  }
> > >
> > > +
> > > +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned
> > > long, size, unsigned int, flags)
> >
> > Please add kern-doc for this, with some notes. E.g. at least one
> > thing isn't immediately
> > obvious, maybe more: "addr" must be a multiple of 8.
>
> Ok.
>
> >
> > > +{
> > > +   unsigned long aligned_size;
> > > +
> > > +   if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > > +           return -ENOSYS;
> >
> > This needs to explicitly reject unknown flags[1], or expanding them
> > in the
> > future becomes very painful:
> >
> >       if (flags & ~(SHADOW_STACK_SET_TOKEN))
> >               return -EINVAL;
> >
> >
> > [1]
> > https://docs.kernel.org/process/adding-syscalls.html#designing-the-api-planning-for-extension
> >
>
> Ok, good idea.
>
> > > +
> > > +   /*
> > > +    * An overflow would result in attempting to write the restore
> > > token
> > > +    * to the wrong location. Not catastrophic, but just return the
> > > right
> > > +    * error code and block it.
> > > +    */
> > > +   aligned_size = PAGE_ALIGN(size);
> > > +   if (aligned_size < size)
> > > +           return -EOVERFLOW;
> >
> > The intention here is to allow userspace to ask for _less_ than a
> > page
> > size multiple, and to put the restore token there?
> >
> > Is it worth adding a check for size >= 8 here? Or, I guess it would
> > just
> > immediately crash on the next call?
>
> Funny you should ask... The glibc changes were doing this and then
> looking for the token at the end of the length that it passed (not the
> page aligned length). I had changed the kernel at one point to be page
> aligned and then had the fun of debugging the results. I thought, glibc
>  is just wasting shadow stack. It should ask for page aligned shadow
> stacks. But HJ argued that the kernel shouldn't second guess what
> userspace is asking for based on HW page size details that don't have
> to do with the software interface. I was convinced by that argument,
> even though glibc is still wasting space.
>
> I could still be convinced the other way though. Glibc still has time
> to (and should) change. But yea, that was actually the intention.

Glibc requests a shadow stack of a given size and expects the restore
token at the specific location.  This is how glibc uses the restore token
to switch to the new shadow stack.

> >
> > > +
> > > +   return alloc_shstk(addr, aligned_size, size, flags &
> > > SHADOW_STACK_SET_TOKEN);
> > > +}
> >
> >



-- 
H.J.
