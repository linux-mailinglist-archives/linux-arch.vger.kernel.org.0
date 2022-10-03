Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA75F38FC
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJCW1i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJCW1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:27:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290D5D0CC
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 15:23:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so10912270plo.3
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z1/2plwrXjBAn1kAQlG8HZaZ4O1cAMi4uWpIyecb3WY=;
        b=fL7uVv5uocG4gFvRiRzu57UBR+Y+hOjSt1rMC9dMipp0dZgJYkPj5efzAvlOD26mpe
         f++eXumz+X91j0ZagKBWZTHo8Kl7b3zELSamfhfgQ+F7k426k2hwkZHBxmeLHXs8rtPR
         aGOXykeUS0F0d6SIzP4G+ZZ+bPrCLDt8t7s+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z1/2plwrXjBAn1kAQlG8HZaZ4O1cAMi4uWpIyecb3WY=;
        b=N91gTj3LUkhXZuV6nei8LScQ8LwIVRFuX/vBY2HC7VxUxdVt+e0/I8yL22rvwglcrJ
         1ZbwkGtcxYIvG39XIN212ivFY8UH6IYaTUyVfgE4fSbJOs5RFR+ZwkSXZ6FNX4MCFl8h
         7zwHsKjRCd9l9QGu5AttnCthsANMQETGu/nXVa2cn6Y9f6jo8zJ0RnWTRNBVwhpoCXm7
         AJJKYd2sJdYwzYX4cJ7WQCZQLE5TUaIdWPGTpau7Ains6S1spKVScDFIEkwmXUbM3fyF
         S2yVRwqTq/trGlvgibog0SchebsUok+kwk1Wq4MMaxCXfv+0YiaCZqL8WyA6aFBigTlG
         wI9Q==
X-Gm-Message-State: ACrzQf1LWwdQoj6DQrNR4cAPkjGJXPUdqYwlFHT8s32kAYOXrr0fwis1
        bOjQFSlAzybcLf8CB5ZbpzolHYKM0xUMzg==
X-Google-Smtp-Source: AMsMyM5T8uqzbmlhDwK2iJakHiD/I/rnTl7wYc9IoQSun+00KcqIfUGmuustAbFdNeZC1kbM95GA+A==
X-Received: by 2002:a17:90b:3852:b0:203:a68c:9a7c with SMTP id nl18-20020a17090b385200b00203a68c9a7cmr14529200pjb.119.1664835834467;
        Mon, 03 Oct 2022 15:23:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00174f61a7d09sm7713150plf.247.2022.10.03.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:23:53 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:23:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
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
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <202210031446.E4AD9EE66@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-29-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-29-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:25PM -0700, Rick Edgecombe wrote:
> [...]
> The following example demonstrates how to create a new shadow stack with
> map_shadow_stack:
> void *shstk = map_shadow_stack(adrr, stack_size, SHADOW_STACK_SET_TOKEN);

typo: addr

> [...]
> +451	common	map_shadow_stack	sys_map_shadow_stack

Isn't this "64", not "common"?

> [...]
> +#define SHADOW_STACK_SET_TOKEN	0x1	/* Set up a restore token in the shadow stack */

I think this should get an intro comment, like:

/* Flags for map_shadow_stack(2) */

Also, as with the other UAPI fields, please use "(1ULL << 0)" here.

> @@ -62,24 +63,34 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>  	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
>  		return -EFAULT;
>  
> -	*token_addr = addr;
> +	if (token_addr)
> +		*token_addr = addr;
>  
>  	return 0;
>  }
>  

Can this just be collapsed into the patch that introduces create_rstor_token()?

> -static unsigned long alloc_shstk(unsigned long size)
> +static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
> +				 unsigned long token_offset, bool set_res_tok)
>  {
>  	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>  	struct mm_struct *mm = current->mm;
> -	unsigned long addr, unused;
> +	unsigned long mapped_addr, unused;
>  
>  	mmap_write_lock(mm);
> -	addr = do_mmap(NULL, addr, size, PROT_READ, flags,

Oops, I missed in the other patch that "addr" was being passed here.
(uninitialized?)

> -		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
> -
> +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> +			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);

I don't see do_mmap() doing anything here to avoid remapping a prior vma
as shstk. Is the intention to allow userspace to convert existing VMAs?
This has caused pain in the past, perhaps force MAP_FIXED_NOREPLACE ?

> [...]
> @@ -174,6 +185,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>  
>  
>  	stack_size = PAGE_ALIGN(stack_size);
> +	addr = alloc_shstk(0, stack_size, 0, false);
>  	if (IS_ERR_VALUE(addr))
>  		return PTR_ERR((void *)addr);
>  

As mentioned earlier, I was expecting this patch to replace a (missing)
call to alloc_shstk. i.e. expecting:

-	addr = alloc_shstk(stack_size);

> @@ -395,6 +407,26 @@ int shstk_disable(void)
>  	return 0;
>  }
>  
> +
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)

Please add kern-doc for this, with some notes. E.g. at least one thing isn't immediately
obvious, maybe more: "addr" must be a multiple of 8.

> +{
> +	unsigned long aligned_size;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return -ENOSYS;

This needs to explicitly reject unknown flags[1], or expanding them in the
future becomes very painful:

	if (flags & ~(SHADOW_STACK_SET_TOKEN))
		return -EINVAL;


[1] https://docs.kernel.org/process/adding-syscalls.html#designing-the-api-planning-for-extension

> +
> +	/*
> +	 * An overflow would result in attempting to write the restore token
> +	 * to the wrong location. Not catastrophic, but just return the right
> +	 * error code and block it.
> +	 */
> +	aligned_size = PAGE_ALIGN(size);
> +	if (aligned_size < size)
> +		return -EOVERFLOW;

The intention here is to allow userspace to ask for _less_ than a page
size multiple, and to put the restore token there?

Is it worth adding a check for size >= 8 here? Or, I guess it would just
immediately crash on the next call?

> +
> +	return alloc_shstk(addr, aligned_size, size, flags & SHADOW_STACK_SET_TOKEN);
> +}

-- 
Kees Cook
