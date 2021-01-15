Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80762F7856
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbhAOMJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 07:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbhAOMJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 07:09:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB9C061757
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 04:09:02 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l0NuV-006dVM-7U; Fri, 15 Jan 2021 13:08:59 +0100
Message-ID: <9e989a0274d7e55038b37ab1b9e6ab7553bb3488.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] um: remove process stub VMA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:08:58 +0100
In-Reply-To: <20210113220944.ba020fe73c75.Ia71e6fe697af9b196278084a9f730c30e20773c9@changeid>
References: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
         <20210113220944.ba020fe73c75.Ia71e6fe697af9b196278084a9f730c30e20773c9@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-13 at 22:09 +0100, Johannes Berg wrote:
> 
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -9,34 +9,9 @@
>  #include <linux/sched.h>
>  #include <linux/mm_types.h>
>  #include <linux/mmap_lock.h>
> -
> +#include <asm/mm_hooks.h>
>  #include <asm/mmu.h>
>  
> -extern void uml_setup_stubs(struct mm_struct *mm);
> -/*
> - * Needed since we do not use the asm-generic/mm_hooks.h:
> - */
> -static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
> -{
> -	uml_setup_stubs(mm);
> -	return 0;
> -}
> -extern void arch_exit_mmap(struct mm_struct *mm);
> -static inline void arch_unmap(struct mm_struct *mm,
> -			unsigned long start, unsigned long end)
> -{
> -}
> -static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> -		bool write, bool execute, bool foreign)
> -{
> -	/* by default, allow everything */
> -	return true;
> -}
> -
> -/*
> - * end asm-generic/mm_hooks.h functions
> - */
> -
>  #define deactivate_mm(tsk,mm)	do { } while (0)


Just saw there's a small conflict since in the meantime, deactivate_mm()
has been removed. Just take neither code.

johannes

