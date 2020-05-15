Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39451D5031
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOORs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgEOORr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:17:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B39C061A0C;
        Fri, 15 May 2020 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v1b+koX9aKkCpLP5KsbA1c0ns2JdCdDM2wQyt2wy9Nw=; b=UCgyVCrLlY2GcbgEUFlxjexZvP
        X13+Bvt5Sm10QJmbkpFC1yqWZ0sAV93SeLj9hIHCPrBJQhtGifoVVqLXkkVmVR3ggXKvb3yAGxjMl
        cJenei+aE7tY8vixRd8femgEShi1xghEBxzR5PnP0aNnzxrm/qBS7/C5tk8efpIKAP0/35Uem6tvP
        yKztd0CBKbKSMlO3SPXagJeQHb+dNEy0Xel0VZ27ymdl+WB7dLEyZVxy+E6Wyy2T+k2ep7iX4TiKz
        jO0oNVtpNCynaAzhjtqe67zFmBtDHJngqrSzyLpQ2iRu5OOVAVER+2AwqMGnR79ZDIu2rGKIcVQnz
        /7E2PLGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZb92-0002JY-HL; Fri, 15 May 2020 14:17:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5CB40300455;
        Fri, 15 May 2020 16:16:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47D1320267E67; Fri, 15 May 2020 16:16:57 +0200 (CEST)
Date:   Fri, 15 May 2020 16:16:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200515141657.GF2940@hirez.programming.kicks-ass.net>
References: <20200515140023.25469-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515140023.25469-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 04:00:16PM +0200, Joerg Roedel wrote:
> Joerg Roedel (7):
>   mm: Add functions to track page directory modifications
>   mm/vmalloc: Track which page-table levels were modified
>   mm/ioremap: Track which page-table levels were modified
>   x86/mm/64: Implement arch_sync_kernel_mappings()
>   x86/mm/32: Implement arch_sync_kernel_mappings()
>   mm: Remove vmalloc_sync_(un)mappings()
>   x86/mm: Remove vmalloc faulting
> 
>  arch/x86/include/asm/pgtable-2level_types.h |   2 +
>  arch/x86/include/asm/pgtable-3level_types.h |   2 +
>  arch/x86/include/asm/pgtable_64_types.h     |   2 +
>  arch/x86/include/asm/switch_to.h            |  23 ---
>  arch/x86/kernel/setup_percpu.c              |   6 +-
>  arch/x86/mm/fault.c                         | 176 +-------------------
>  arch/x86/mm/init_64.c                       |   5 +
>  arch/x86/mm/pti.c                           |   8 +-
>  arch/x86/mm/tlb.c                           |  37 ----
>  drivers/acpi/apei/ghes.c                    |   6 -
>  include/asm-generic/5level-fixup.h          |   5 +-
>  include/asm-generic/pgtable.h               |  23 +++
>  include/linux/mm.h                          |  46 +++++
>  include/linux/vmalloc.h                     |  18 +-
>  kernel/notifier.c                           |   1 -
>  kernel/trace/trace.c                        |  12 --
>  lib/ioremap.c                               |  46 +++--
>  mm/nommu.c                                  |  12 --
>  mm/vmalloc.c                                | 109 +++++++-----
>  19 files changed, 204 insertions(+), 335 deletions(-)

I'm thinking this improves the status-quo, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Like Andy, I think I'd like x86_64 to pre-populate, but that can easily
be done on top and should not hold this back.
