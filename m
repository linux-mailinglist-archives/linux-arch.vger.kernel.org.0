Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607BF400389
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbhICQjp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhICQjo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2021 12:39:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007DC061575
        for <linux-arch@vger.kernel.org>; Fri,  3 Sep 2021 09:38:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e7so3620408plh.8
        for <linux-arch@vger.kernel.org>; Fri, 03 Sep 2021 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfOt3SEZ0/w/EILHgIhc/sI685lMnBLBscfmUVoWBxM=;
        b=U3zD7zTVZnXyaVHVcepE2ZnBhIVi+C+briI5/GPmfUYXdkLyFmxljAvwjJ2Y/T6FN7
         JEKgVwTx7TIQEk8iONrflQBgQEuu9wPi6w1QPNdCALwa6JGDNl9ILIHqvd26pArQ3XuF
         FBhHN4XJSFB6INWrh3p2QndF/YNVVDAe55YSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfOt3SEZ0/w/EILHgIhc/sI685lMnBLBscfmUVoWBxM=;
        b=kQrrQhb4dae/nemFQDEvTj4LpfClKrialhJjaUiLP2lYE/xifN5t1aXn8peQRkmB4F
         KLdxRh1wz87SNB3WeMas9iE1J9QtiGs39/rBGZaJd9wG+9MpM51b50v0QqIarfhx9WzV
         +0qL7RvQjUW6KTvnYZI4AZ2TrFismOdJ/YC77mKlMfDxMXAWwQkQ1B1+a0J44wLH7Yyv
         uIYx3H+ufcINjAVwYC5nJgz4uy4xbat/IxnwsYyNbYPMwRJ5oK4eKAuAbqmbglCNU6E1
         j40hDFmrqqhUJeI5ZkHvT09mAMt7w/F3PaSzY1Jb+JjH0FL3IgVII0FcDQQz6FwtIq2H
         xBLQ==
X-Gm-Message-State: AOAM5319fyFFGmCFnXdoTTMuycNmdwsMXpDnPGNTaYl11F6NuErwl9k2
        ZZ76XayjGWKZJ4QUGRla43WLbA==
X-Google-Smtp-Source: ABdhPJy/x5blIx3Lk+xBJRMgzA9HJvA8GilrLG2XXL2QHa1y/6WGYsNlTmOkpxYQfB+u+t83J6O6NQ==
X-Received: by 2002:a17:90b:2212:: with SMTP id kw18mr1653921pjb.59.1630687124160;
        Fri, 03 Sep 2021 09:38:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s31sm5894049pfw.23.2021.09.03.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:38:43 -0700 (PDT)
Date:   Fri, 3 Sep 2021 09:38:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] module: Use a list of strings for ro_after_init
 sections
Message-ID: <202109030932.1358C4093@keescook>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-4-keescook@chromium.org>
 <20210903064951.to4dhiu7zua7s6dn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903064951.to4dhiu7zua7s6dn@treble>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 02, 2021 at 11:49:51PM -0700, Josh Poimboeuf wrote:
> On Wed, Sep 01, 2021 at 04:37:56PM -0700, Kees Cook wrote:
> > Instead of open-coding the section names, use a list for the sections that
> > need to be marked read-only after init. Unfortunately, it seems we can't
> > do normal section merging with scripts/module.lds.S as ld.bfd doesn't
> > correctly update symbol tables. For more details, see commit 6a3193cdd5e5
> > ("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG
> > is enabled").
> 
> I'm missing what this has to do with section merging.  Can you connect
> the dots here, i.e. what sections would we want to merge and how would
> that help here?

Right, sorry, if ld.bfd didn't have this issue, we could use section
merging in the module.lds.S file the way we do in vmlinux.lds:

#ifndef RO_AFTER_INIT_DATA
#define RO_AFTER_INIT_DATA                                              \
        . = ALIGN(8);                                                   \
        __start_ro_after_init = .;                                      \
        *(.data..ro_after_init)                                         \
        JUMP_TABLE_DATA                                                 \
        STATIC_CALL_DATA                                                \
        __end_ro_after_init = .;
#endif
...
        . = ALIGN((align));                                             \
        .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
                __start_rodata = .;                                     \
                *(.rodata) *(.rodata.*)                                 \
                SCHED_DATA                                              \
                RO_AFTER_INIT_DATA      /* Read only after init */      \
                . = ALIGN(8);                                           \
                __start___tracepoints_ptrs = .;                         \
                KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
                __stop___tracepoints_ptrs = .;                          \
                *(__tracepoints_strings)/* Tracepoints: strings */      \
        }                                                               \

Then jump_table and static_call sections could be collected into a
new section, as the module loader would only need to look for that
single name.

> Instead of hard-coding section names in module.c, I'm wondering if we
> can do something like the following to set SHF_RO_AFTER_INIT when first
> creating the sections.  Completely untested...
> 
> 
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 0449b125d27f..d4ff34c6199c 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -13,7 +13,7 @@
>  #include <linux/types.h>
>  
>  #define JUMP_TABLE_ENTRY				\
> -	".pushsection __jump_table,  \"aw\" \n\t"	\
> +	".pushsection __jump_table, \"0x00200003\" \n\t"\
>  	_ASM_ALIGN "\n\t"				\
>  	".long 1b - . \n\t"				\
>  	".long %l[l_yes] - . \n\t"			\
> diff --git a/kernel/module.c b/kernel/module.c
> index 40ec9a030eec..1dda33c9ae49 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3549,15 +3549,6 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
>  	 */
>  	ndx = find_sec(info, ".data..ro_after_init");
> -	if (ndx)
> -		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> -	/*
> -	 * Mark the __jump_table section as ro_after_init as well: these data
> -	 * structures are never modified, with the exception of entries that
> -	 * refer to code in the __init section, which are annotated as such
> -	 * at module load time.
> -	 */
> -	ndx = find_sec(info, "__jump_table");
>  	if (ndx)
>  		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>  
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e5947fbb9e7a..b25ca38179ea 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -20,6 +20,9 @@
>  #include <linux/kernel.h>
>  #include <linux/static_call_types.h>
>  
> +/* cribbed from include/uapi/linux/elf.h */
> +#define SHF_RO_AFTER_INIT	0x00200000
> +
>  struct alternative {
>  	struct list_head list;
>  	struct instruction *insn;
> @@ -466,7 +469,8 @@ static int create_static_call_sections(struct objtool_file *file)
>  	list_for_each_entry(insn, &file->static_call_list, call_node)
>  		idx++;
>  
> -	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
> +	sec = elf_create_section(file->elf, ".static_call_sites",
> +				 SHF_WRITE | SHF_RO_AFTER_INIT,
>  				 sizeof(struct static_call_site), idx);
>  	if (!sec)
>  		return -1;

Interesting! I got the impression from the module code that this wasn't
possible since it'd be exposing an internal set of flags to the external
linker, and would break the vmlinux section merging (since it _is_
supposed to live in the .rodata section ultimately). The modules handle
permissions slightly differently (i.e. more exact temporal), than the
kernel though. (Most of the architecture's vmlinux logic starts with
everything writable, and only does the read-only-ness after __init,
though I think s390 does it "correctly" and as such has a separate area
for the ro-after-init section.)

-- 
Kees Cook
