Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4DE5F9D5A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiJJLNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiJJLNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 07:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97E46D91
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2022 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665400401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cjfm8RmJkrxBn+xSALMff74eWGCgI/d+h1W88CDZ86U=;
        b=W+JL2E1sO5U+3HHOKuqY9zuca2G5THtorYaADHSBGEbJM2D//vBYrc/DnL6bQJ3FYuyshI
        G585SqKhD5VTKix78MrOF/0Ns3e6EJPyfDbrNJte7Nxgf50zdVjE8RNB23YBghj3ocKAiN
        +bU+hKG3QmfUa3n4z5JBYsi5iPg2KLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-utO26pQtPQSNb1oVWV2XLg-1; Mon, 10 Oct 2022 07:13:16 -0400
X-MC-Unique: utO26pQtPQSNb1oVWV2XLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CCC585A583;
        Mon, 10 Oct 2022 11:13:14 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 656F2B279E;
        Mon, 10 Oct 2022 11:13:07 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack syscall
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
        <20220929222936.14584-29-rick.p.edgecombe@intel.com>
Date:   Mon, 10 Oct 2022 13:13:05 +0200
In-Reply-To: <20220929222936.14584-29-rick.p.edgecombe@intel.com> (Rick
        Edgecombe's message of "Thu, 29 Sep 2022 15:29:25 -0700")
Message-ID: <87r0zg0w5a.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick Edgecombe:

> When operating with shadow stacks enabled, the kernel will automatically
> allocate shadow stacks for new threads, however in some cases userspace
> will need additional shadow stacks. The main example of this is the
> ucontext family of functions, which require userspace allocating and
> pivoting to userspace managed stacks.
>
> Unlike most other user memory permissions, shadow stacks need to be
> provisioned with special data in order to be useful. They need to be setup
> with a restore token so that userspace can pivot to them via the RSTORSSP
> instruction. But, the security design of shadow stack's is that they
> should not be written to except in limited circumstances. This presents a
> problem for userspace, as to how userspace can provision this special
> data, without allowing for the shadow stack to be generally writable.
>
> Previously, a new PROT_SHADOW_STACK was attempted, which could be
> mprotect()ed from RW permissions after the data was provisioned. This was
> found to not be secure enough, as other thread's could write to the
> shadow stack during the writable window.
>
> The kernel can use a special instruction, WRUSS, to write directly to
> userspace shadow stacks. So the solution can be that memory can be mapped
> as shadow stack permissions from the beginning (never generally writable
> in userspace), and the kernel itself can write the restore token.
>
> First, a new madvise() flag was explored, which could operate on the
> PROT_SHADOW_STACK memory. This had a couple downsides:
> 1. Extra checks were needed in mprotect() to prevent writable memory from
>    ever becoming PROT_SHADOW_STACK.
> 2. Extra checks/vma state were needed in the new madvise() to prevent
>    restore tokens being written into the middle of pre-used shadow stacks.
>    It is ideal to prevent restore tokens being added at arbitrary
>    locations, so the check was to make sure the shadow stack had never been
>    written to.
> 3. It stood out from the rest of the madvise flags, as more of direct
>    action than a hint at future desired behavior.
>
> So rather than repurpose two existing syscalls (mmap, madvise) that don't
> quite fit, just implement a new map_shadow_stack syscall to allow
> userspace to map and setup new shadow stacks in one step. While ucontext
> is the primary motivator, userspace may have other unforeseen reasons to
> setup it's own shadow stacks using the WRSS instruction. Towards this
> provide a flag so that stacks can be optionally setup securely for the
> common case of ucontext without enabling WRSS. Or potentially have the
> kernel set up the shadow stack in some new way.
>
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(adrr, stack_size, SHADOW_STACK_SET_TOKEN);

Jason has recently been working on vDSO-based getrandom acceleration.
It needs a way for a userspace thread to allocate userspace memory in a
specific way.  Jason proposed to use a vDSO call as the interface, not a
system call.

Maybe this approach is applicable here as well?  Or we can come up with
a more general interface for such per-thread allocations?

Thanks,
Florian

