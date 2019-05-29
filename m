Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005552E80C
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2WUW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 18:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2WUW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 18:20:22 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48D123B17;
        Wed, 29 May 2019 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559168421;
        bh=tgKGsHyhZj9jiu9RU2c5+wrXXX9Bz565lESelz7BCmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RAuE9bbRQAt1gbMQ/Nfc+vCQO/WJ2/Ae1MswvuSJ8fWMdGcnkb5iN/j8uV57ReWVy
         rl/EcCMzfDJrqSvwEe0wq+sgLoF2v/3y0A3AuwGeXMBKtOq671OOXVEMyv31XW2nfg
         nMFM8ntbFY8mNYH3pRt7/yjrbs5xJiuIfVpFhQ2g=
Date:   Wed, 29 May 2019 15:20:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] elf: align AT_RANDOM bytes
Message-Id: <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
In-Reply-To: <20190529213708.GA10729@avx2>
References: <20190529213708.GA10729@avx2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 30 May 2019 00:37:08 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> AT_RANDOM content is always misaligned on x86_64:
> 
> 	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
> 	AT_RANDOM:       0x7fff02101019
> 
> glibc copies first few bytes for stack protector stuff, aligned
> access should be slightly faster.

I just don't understand the implications of this.  Is there
(badly-behaved) userspace out there which makes assumptions about the
current alignment?

How much faster, anyway?  How frequently is the AT_RANDOM record
accessed?

I often have questions such as these about your performance/space
tweaks :(.  Please try to address them as a matter of course when
preparing changelogs?

And let's Cc Kees, who wrote the thing.

> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
>  #define STACK_ALLOC(sp, len) ({ \
>  	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
>  	old_sp; })
> +#define STACK_ALIGN(sp, align)	\
> +	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))

I suspect plain old ALIGN() could be used here.

>  #else
>  #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
>  #define STACK_ROUND(sp, items) \
>  	(((unsigned long) (sp - items)) &~ 15UL)
>  #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
> +#define STACK_ALIGN(sp, align)	\
> +	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))

And maybe there's a helper which does this, dunno.

>  #endif
>  
>  #ifndef ELF_BASE_PLATFORM
> @@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  			return -EFAULT;
>  	}
>  
> +	/*
> +	 * glibc copies first bytes for stack protector purposes
> +	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
> +	 */
> +	p = STACK_ALIGN(p, sizeof(long));
> +
>  	/*
>  	 * Generate 16 random bytes for userspace PRNG seeding.
>  	 */

