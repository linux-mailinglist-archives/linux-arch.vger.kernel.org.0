Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27166ACC11
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFSK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCFSKL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:10:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547E328227;
        Mon,  6 Mar 2023 10:09:46 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 239611EC0662;
        Mon,  6 Mar 2023 19:09:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678126175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bf81Sg91gg34dWGuLdg6vAArqivsg00/7Notto21iJk=;
        b=aVFGQa3SFxNOfHTNMNQ3+eYs7r3YgnqLXguwCpOySzjhXgWoBHMeoEaVsXMqZlauy6rxP4
        h/cVyGnfwEOMqa1wC0bGMzhPcm7ZbkJKa40I4McX8KXtPCklAnlm++BhxseEjZ1OxzMIRD
        1MUsglZCKjnVqaAKRmVkaN7PfHEpgn0=
Date:   Mon, 6 Mar 2023 19:09:29 +0100
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
Subject: Re: [PATCH v7 25/41] x86/mm: Introduce MAP_ABOVE4G
Message-ID: <ZAYsWadAkdZBUGDb@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-26-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-26-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:41PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which require some core mm changes to function
> properly.
> 
> One of the properties is that the shadow stack pointer (SSP), which is a
> CPU register that points to the shadow stack like the stack pointer points
> to the stack, can't be pointing outside of the 32 bit address space when
> the CPU is executing in 32 bit mode. It is desirable to prevent executing
> in 32 bit mode when shadow stack is enabled because the kernel can't easily
> support 32 bit signals.
> 
> On x86 it is possible to transition to 32 bit mode without any special
> interaction with the kernel, by doing a "far call" to a 32 bit segment.
> So the shadow stack implementation can use this address space behavior
> as a feature, by enforcing that shadow stack memory is always crated
								^^^^^^^

"created"

and I'd say "mapped" or "allocated" here. "Created" sounds weird.

> outside of the 32 bit address space. This way userspace will trigger a
> general protection fault which will in turn trigger a segfault if it
> tries to transition to 32 bit mode with shadow stack enabled.
> 
> This provides a clean error generating border for the user if they try
> attempt to do 32 bit mode shadow stack, rather than leave the kernel in a
> half working state for userspace to be surprised by.
> 
> So to allow future shadow stack enabling patches to map shadow stacks
> out of the 32 bit address space, introduce MAP_ABOVE4G. The behavior

I guess this needs to be documented in the mmap() manpage too.

> is pretty much like MAP_32BIT, except that it has the opposite address
> range. The are a few differences though.
> 
> If both MAP_32BIT and MAP_ABOVE4G are provided, the kernel will use the
> MAP_ABOVE4G behavior. Like MAP_32BIT, MAP_ABOVE4G is ignored in a 32 bit
> syscall.
> 
> Since the default search behavior is top down, the normal kaslr base can
> be used for MAP_ABOVE4G. This is unlike MAP_32BIT which has to add it's
								     ^^^^


"its"

> own randomization in the bottom up case.

...

> diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
> index 8cc653ffdccd..06378b5682c1 100644
> --- a/arch/x86/kernel/sys_x86_64.c
> +++ b/arch/x86/kernel/sys_x86_64.c
> @@ -193,7 +193,11 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	if (!in_32bit_syscall() && (flags & MAP_ABOVE4G))
> +		info.low_limit = 0x100000000;

We have a human readable define for that: SZ_4G

> +	else
> +		info.low_limit = PAGE_SIZE;
> +
>  	info.high_limit = get_mmap_base(0);
>  
>  	/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
