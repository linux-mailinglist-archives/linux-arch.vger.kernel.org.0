Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B203E2A34
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbhHFL7s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 07:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhHFL7s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Aug 2021 07:59:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E754610FF;
        Fri,  6 Aug 2021 11:59:30 +0000 (UTC)
Date:   Fri, 6 Aug 2021 12:59:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: mm: Fix TLBI vs ASID rollover
Message-ID: <20210806115927.GJ6719@arm.com>
References: <20210806113109.2475-1-will@kernel.org>
 <20210806113109.2475-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806113109.2475-2-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 06, 2021 at 12:31:04PM +0100, Will Deacon wrote:
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 75beffe2ee8a..e9c30859f80c 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -27,11 +27,32 @@ typedef struct {
>  } mm_context_t;
>  
>  /*
> - * This macro is only used by the TLBI and low-level switch_mm() code,
> - * neither of which can race with an ASID change. We therefore don't
> - * need to reload the counter using atomic64_read().
> + * We use atomic64_read() here because the ASID for an 'mm_struct' can
> + * be reallocated when scheduling one of its threads following a
> + * rollover event (see new_context() and flush_context()). In this case,
> + * a concurrent TLBI (e.g. via try_to_unmap_one() and ptep_clear_flush())
> + * may use a stale ASID. This is fine in principle as the new ASID is
> + * guaranteed to be clean in the TLB, but the TLBI routines have to take
> + * care to handle the following race:
> + *
> + *    CPU 0                    CPU 1                          CPU 2
> + *
> + *    // ptep_clear_flush(mm)
> + *    xchg_relaxed(pte, 0)
> + *    DSB ISHST
> + *    old = ASID(mm)

We'd need specs clarified (ARM ARM, cat model) that the DSB ISHST is
sufficient to order the pte write with the subsequent ASID read.
Otherwise the patch looks fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
