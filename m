Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A902044EE52
	for <lists+linux-arch@lfdr.de>; Fri, 12 Nov 2021 22:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhKLVHj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Nov 2021 16:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235678AbhKLVHi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Nov 2021 16:07:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E791961073;
        Fri, 12 Nov 2021 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636751087;
        bh=2qqkfvtrJGfj9ZmJlWd38i/WX7gF70C3dBf8RQ5wumo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nWKXnUDGWsUMLljZWwy6cLNXVB7K6pvM4TVC63shKrCJ5ntl7jiI7TyjgjN/DaUgG
         1tszX3FTcILOCU+Nzwm1U1DTeeCfmc/WUEkmjj0f2OPtZuWxsclChON1UpBvydc0VV
         4NhNTvosABJqwc7rr070zxyPklpS/MA+wM61TaEwbyFSLKlpKflfSgfjzebN7VrtDp
         Olj/uhTTwVazAwg4w2O8yXqbf3mnsbcd++WIU1H6g9zf7z2EhgQoVCfrBTIgSNHU4X
         Tzyg3w+4BNBZsfP4xd3pLcCvxFOtB5vPBNK2VyW4vLOnAv9iFTU+8bLAw0Zw0cp0A5
         kWvXSr6aG3QmA==
Message-ID: <d7c27a98-a2da-17c8-22c3-e13fadbb9a8c@kernel.org>
Date:   Fri, 12 Nov 2021 13:04:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] Nuke PAGE_KERNEL_IO
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20211021181511.1533377-1-lucas.demarchi@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20211021181511.1533377-1-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/21 11:15, Lucas De Marchi wrote:
> Last user of PAGE_KERNEL_IO is the i915 driver. While removing it from
> there as we seek to bring the driver to other architectures, Daniel
> suggested that we could finish the cleanup and remove it altogether,
> through the tip tree. So here I'm sending both commits needed for that.
> 
> Lucas De Marchi (2):
>    drm/i915/gem: stop using PAGE_KERNEL_IO
>    x86/mm: nuke PAGE_KERNEL_IO
> 
>   arch/x86/include/asm/fixmap.h             | 2 +-
>   arch/x86/include/asm/pgtable_types.h      | 7 -------
>   arch/x86/mm/ioremap.c                     | 2 +-
>   arch/x86/xen/setup.c                      | 2 +-
>   drivers/gpu/drm/i915/gem/i915_gem_pages.c | 4 ++--
>   include/asm-generic/fixmap.h              | 2 +-
>   6 files changed, 6 insertions(+), 13 deletions(-)
> 

Acked-by: Andy Lutomirski <luto@kernel.org>
