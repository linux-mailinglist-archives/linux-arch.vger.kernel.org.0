Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3403C207BB3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406023AbgFXSmY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSmX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:42:23 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2C82081A;
        Wed, 24 Jun 2020 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593024143;
        bh=u4JBs8C6V4svn3BBUSJRfnUdlpVv3TzQ17cAHggPQyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bbh8Vk0J1NwDe1qT04cjnHwjTEsB1bkzIlZe8jYFbuOdDpMMxH3zDnOYpI/GyFq6V
         zG172rUV1mMn/U2qBeJxHQWlPN4VmEhCg/2Cce4D3U3asE5VHoWJRlCV/reWm70aYv
         ZwP80rsntfjnvMxxX0HsdHyLAx+02IlWU4jrTABM=
Date:   Wed, 24 Jun 2020 11:42:22 -0700
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
Subject: Re: [PATCH v5 15/25] mm: Allow arm64 mmap(PROT_MTE) on RAM-based
 files
Message-Id: <20200624114222.64b0a50cb0497c5bc524b7d5@linux-foundation.org>
In-Reply-To: <20200624175244.25837-16-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-16-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 18:52:34 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Since arm64 memory (allocation) tags can only be stored in RAM, mapping
> files with PROT_MTE is not allowed by default. RAM-based files like
> those in a tmpfs mount or memfd_create() can support memory tagging, so
> update the vm_flags accordingly in shmem_mmap().
> 
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2206,6 +2206,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  			vma->vm_flags &= ~(VM_MAYWRITE);
>  	}
>  
> +	/* arm64 - allow memory tagging on RAM-based files */
> +	vma->vm_flags |= VM_MTE_ALLOWED;
> +
>  	file_accessed(file);
>  	vma->vm_ops = &shmem_vm_ops;
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&

Acked-by: Andrew Morton <akpm@linux-foundation.org>
