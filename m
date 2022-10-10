Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1618E5FA016
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJJOTt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJJOTs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 10:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99113CD5;
        Mon, 10 Oct 2022 07:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C0460F63;
        Mon, 10 Oct 2022 14:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EB2C433C1;
        Mon, 10 Oct 2022 14:19:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k2ZrqZe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665411580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iw2ZRUonbp01bjCTCictotIIEnbTkDhyNLUSJiCb1ng=;
        b=k2ZrqZe9Kp/93qCrQj5JRsdxaPZkhnB2j2Z7CzRqpkmKDItzE1NwYG7L3kim9tAX62/ape
        pLk+YjffGVMXAaGP1efxYOU1AAIykJC+W9cOeqj/SptcZpIAevmCu5Yxc61sIxT4bt9sn4
        NAEC47XgkJ8NXNDPEFol4xEKUcxcJH8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d87b5e13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 14:19:39 +0000 (UTC)
Date:   Mon, 10 Oct 2022 16:19:39 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack
 syscall
Message-ID: <Y0Qp+/qBUneyII8b@zx2c4.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-29-rick.p.edgecombe@intel.com>
 <87r0zg0w5a.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0zg0w5a.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 10, 2022 at 01:13:05PM +0200, Florian Weimer wrote:
> * Rick Edgecombe:
> 
> > When operating with shadow stacks enabled, the kernel will automatically
> > allocate shadow stacks for new threads, however in some cases userspace
> > will need additional shadow stacks. The main example of this is the
> > ucontext family of functions, which require userspace allocating and
> > pivoting to userspace managed stacks.
> >
> > Unlike most other user memory permissions, shadow stacks need to be
> > provisioned with special data in order to be useful. They need to be setup
> > with a restore token so that userspace can pivot to them via the RSTORSSP
> > instruction. But, the security design of shadow stack's is that they
> > should not be written to except in limited circumstances. This presents a
> > problem for userspace, as to how userspace can provision this special
> > data, without allowing for the shadow stack to be generally writable.
> >
> > Previously, a new PROT_SHADOW_STACK was attempted, which could be
> > mprotect()ed from RW permissions after the data was provisioned. This was
> > found to not be secure enough, as other thread's could write to the
> > shadow stack during the writable window.
> >
> > The kernel can use a special instruction, WRUSS, to write directly to
> > userspace shadow stacks. So the solution can be that memory can be mapped
> > as shadow stack permissions from the beginning (never generally writable
> > in userspace), and the kernel itself can write the restore token.
> >
> > First, a new madvise() flag was explored, which could operate on the
> > PROT_SHADOW_STACK memory. This had a couple downsides:
> > 1. Extra checks were needed in mprotect() to prevent writable memory from
> >    ever becoming PROT_SHADOW_STACK.
> > 2. Extra checks/vma state were needed in the new madvise() to prevent
> >    restore tokens being written into the middle of pre-used shadow stacks.
> >    It is ideal to prevent restore tokens being added at arbitrary
> >    locations, so the check was to make sure the shadow stack had never been
> >    written to.
> > 3. It stood out from the rest of the madvise flags, as more of direct
> >    action than a hint at future desired behavior.
> >
> > So rather than repurpose two existing syscalls (mmap, madvise) that don't
> > quite fit, just implement a new map_shadow_stack syscall to allow
> > userspace to map and setup new shadow stacks in one step. While ucontext
> > is the primary motivator, userspace may have other unforeseen reasons to
> > setup it's own shadow stacks using the WRSS instruction. Towards this
> > provide a flag so that stacks can be optionally setup securely for the
> > common case of ucontext without enabling WRSS. Or potentially have the
> > kernel set up the shadow stack in some new way.
> >
> > The following example demonstrates how to create a new shadow stack with
> > map_shadow_stack:
> > void *shstk = map_shadow_stack(adrr, stack_size, SHADOW_STACK_SET_TOKEN);
> 
> Jason has recently been working on vDSO-based getrandom acceleration.
> It needs a way for a userspace thread to allocate userspace memory in a
> specific way.  Jason proposed to use a vDSO call as the interface, not a
> system call.

Not quite so in the latest revision of that patch:
https://lore.kernel.org/lkml/20220916125916.652546-1-Jason@zx2c4.com/

Jason

> 
> Maybe this approach is applicable here as well?  Or we can come up with
> a more general interface for such per-thread allocations?
> 
> Thanks,
> Florian
> 
