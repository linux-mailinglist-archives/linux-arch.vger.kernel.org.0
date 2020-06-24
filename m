Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCF207BA0
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405914AbgFXSgQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSgQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:36:16 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5297720724;
        Wed, 24 Jun 2020 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593023772;
        bh=zAbzYru4IJFdsh6i/w0jgIRKlV0+glNcrScr56cweUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FIZjTg4xAP6gEpo+5IWjKs1ow+z2InHOF9UTIBNoPSzTzUfUFAIaiwUfJkpzYl+aO
         6PtyELdCLPPtvzhPLRlyIOSj34pSKn6In4jxiceWXZcvDamteov8bkke9ulDMUnm9Y
         SIhx3UTboYA83kFYZHVSplO4gwHp8a2NZcgxIxc4=
Date:   Wed, 24 Jun 2020 11:36:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>
Subject: Re: [PATCH v5 11/25] mm: Introduce arch_calc_vm_flag_bits()
Message-Id: <20200624113611.2cf12da3a325d03a862c0adf@linux-foundation.org>
In-Reply-To: <20200624175244.25837-12-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-12-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 18:52:30 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Kevin Brodsky <Kevin.Brodsky@arm.com>
> 
> Similarly to arch_calc_vm_prot_bits(), introduce a dummy
> arch_calc_vm_flag_bits() invoked from calc_vm_flag_bits(). This macro
> can be overridden by architectures to insert specific VM_* flags derived
> from the mmap() MAP_* flags.
> 
> ...
>
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -74,13 +74,17 @@ static inline void vm_unacct_memory(long pages)
>  }
>  
>  /*
> - * Allow architectures to handle additional protection bits
> + * Allow architectures to handle additional protection and flag bits
>   */
>  
>  #ifndef arch_calc_vm_prot_bits
>  #define arch_calc_vm_prot_bits(prot, pkey) 0
>  #endif
>  
> +#ifndef arch_calc_vm_flag_bits
> +#define arch_calc_vm_flag_bits(flags) 0
> +#endif

It would be helpful to add a comment specifying which arch header file
is responsible for defining arch_calc_vm_flag_bits.  Because in the
past we've messed this sort of thing up and had different architectures
define things in different header files, resulting in build issues as
code evolves.

>  #ifndef arch_vm_get_page_prot
>  #define arch_vm_get_page_prot(vm_flags) __pgprot(0)
>  #endif
> @@ -131,7 +135,8 @@ calc_vm_flag_bits(unsigned long flags)
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> -	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
> +	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       arch_calc_vm_flag_bits(flags);
>  }
>  
>  unsigned long vm_commit_limit(void);
