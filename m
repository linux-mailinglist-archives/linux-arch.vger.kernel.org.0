Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E36B4C89
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjCJQQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjCJQQB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 11:16:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A65F66D0F;
        Fri, 10 Mar 2023 08:11:28 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32E441EC0554;
        Fri, 10 Mar 2023 17:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678464686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SghMXOAoohlbIS9JDR4dT2QIcRHFiPilO4AsVNWRpQk=;
        b=rDzJnDqN2QVo9NC5XgnbGL49tbfsrIRwB6KlCMgIVB/xJXpoymdJuRIbvDcTTKtDGPad8G
        ZdjG8kjOEtJOoPnx9/z2HikmIFMBXy7Fb7SPLJStSCEbZ7Klr0zwVrX0cOhd8aH5s57Mfm
        a6cmZ9TNb2I9zvzGH86qQpwh5rZqHo0=
Date:   Fri, 10 Mar 2023 17:11:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <ZAtWp76svXxvQl94@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-34-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:49PM -0800, Rick Edgecombe wrote:
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

"stacks"

> should not be written to except in limited circumstances. This presents a
> problem for userspace, as to how userspace can provision this special
> data, without allowing for the shadow stack to be generally writable.
> 
> Previously, a new PROT_SHADOW_STACK was attempted, which could be
> mprotect()ed from RW permissions after the data was provisioned. This was
> found to not be secure enough, as other thread's could write to the

"threads"

> shadow stack during the writable window.
> 
> The kernel can use a special instruction, WRUSS, to write directly to
> userspace shadow stacks. So the solution can be that memory can be mapped
> as shadow stack permissions from the beginning (never generally writable
> in userspace), and the kernel itself can write the restore token.
> 
> First, a new madvise() flag was explored, which could operate on the
> PROT_SHADOW_STACK memory. This had a couple downsides:
					     ^
					     of


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

"its"

> provide a flag so that stacks can be optionally setup securely for the
> common case of ucontext without enabling WRSS. Or potentially have the
> kernel set up the shadow stack in some new way.
> 
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);

...

> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..f65c671ce3b1 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448	common	process_mrelease	sys_process_mrelease
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	64	map_shadow_stack	sys_map_shadow_stack

Yeah, this'll need a manpage too, I presume. But later.

> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> +{
> +	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
> +	unsigned long aligned_size;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	if (flags & ~SHADOW_STACK_SET_TOKEN)
> +		return -EINVAL;
> +
> +	/* If there isn't space for a token */
> +	if (set_tok && size < 8)
> +		return -EINVAL;
> +
> +	if (addr && addr <= 0xFFFFFFFF)

			< SZ_4G

> +		return -EINVAL;

Can we use distinct negative retvals in each case so that it is clear to
userspace where it fails, *if* it fails?

> +	/*
> +	 * An overflow would result in attempting to write the restore token
> +	 * to the wrong location. Not catastrophic, but just return the right
> +	 * error code and block it.
> +	 */
> +	aligned_size = PAGE_ALIGN(size);
> +	if (aligned_size < size)
> +		return -EOVERFLOW;
> +
> +	return alloc_shstk(addr, aligned_size, size, set_tok);
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
