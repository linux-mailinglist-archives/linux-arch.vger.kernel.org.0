Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE162207BA7
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406147AbgFXShs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405914AbgFXShr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:37:47 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F204C20724;
        Wed, 24 Jun 2020 18:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593023867;
        bh=N33U5QaNc/HrhztgGmlLrw0Lcvv3sVffeuhLVRirZ5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8wIYR6mKQWXAtMhWWdVubpavMoyGBwOsJpZO1R4v/xzEueX9mj0ObtigPlPv+kyh
         vTuKYFXjEZXz+HYP0Vu7VnF0JZnAB9gHZGRLo4S9EEgyCb56fsHuP0vmG3DSiBQBkB
         kJas+9InzzomFGeVndN82lMzixZN6KP3tYTzsi94=
Date:   Wed, 24 Jun 2020 11:37:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v5 13/25] mm: Introduce arch_validate_flags()
Message-Id: <20200624113746.589b6af7779f39eee846ea74@linux-foundation.org>
In-Reply-To: <20200624175244.25837-14-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-14-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 18:52:32 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Similarly to arch_validate_prot() called from do_mprotect_pkey(), an
> architecture may need to sanity-check the new vm_flags.
> 
> Define a dummy function always returning true. In addition to
> do_mprotect_pkey(), also invoke it from mmap_region() prior to updating
> vma->vm_page_prot to allow the architecture code to veto potentially
> inconsistent vm_flags.
> 
> ...
>
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -103,6 +103,19 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>  #define arch_validate_prot arch_validate_prot
>  #endif
>  
> +#ifndef arch_validate_flags
> +/*
> + * This is called from mmap() and mprotect() with the updated vma->vm_flags.
> + *
> + * Returns true if the VM_* flags are valid.
> + */
> +static inline bool arch_validate_flags(unsigned long flags)
> +{
> +	return true;
> +}
> +#define arch_validate_flags arch_validate_flags
> +#endif

Again, please let's nail down where the arch should define this.

Otherwise, Acked-by: Andrew Morton <akpm@linux-foundation.org>
