Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA21CB82A
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHTUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbgEHTUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2020 15:20:35 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795AC061A0C;
        Fri,  8 May 2020 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=upXo7mgkwAOf/eUIM3KQuITq3Q/9aprUu48rF1lVzVs=; b=tVM+IhN1wAQ8C2HlyZ6b8bWI6I
        luoSvNyk/9q0V4U6VY/sscaPpXXhK6qOgSOj7PiKzV+M9Yc9B0kTsTfoBbn/MmNgMeClPwTqjCYd0
        uCST2t9d60e85oDEN8Ds8Y+fBnKuOC5qFrrxKD0U9oKh28fsXltE3YYVI8bY2CsKrX7dkuSDoHaX2
        LxNlvYPJfaY/3Kf/6WplEdnKedqcqmNkCwj+PUHEZU9qtSMxO2Sk7NoCJtY9CBxLpHcXjaFvNl0kN
        r+mIM4zfAoWMSKtbapiGL9nF0GGUf+DCtF5hPPLr1PPCp6epaCyEmvy8wlMfO+lU7jlZqrkK/8Nms
        YWmDJksQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX8XT-000615-6B; Fri, 08 May 2020 19:20:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B7233012DC;
        Fri,  8 May 2020 21:20:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15AFA203CB697; Fri,  8 May 2020 21:20:00 +0200 (CEST)
Date:   Fri, 8 May 2020 21:20:00 +0200
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
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200508192000.GB2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 04:40:36PM +0200, Joerg Roedel wrote:

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
>  drivers/acpi/apei/ghes.c                    |   6 -
>  include/asm-generic/5level-fixup.h          |   5 +-
>  include/asm-generic/pgtable.h               |  23 +++
>  include/linux/mm.h                          |  46 +++++
>  include/linux/vmalloc.h                     |  13 +-
>  kernel/notifier.c                           |   1 -
>  lib/ioremap.c                               |  46 +++--
>  mm/nommu.c                                  |  12 --
>  mm/vmalloc.c                                | 109 +++++++-----
>  17 files changed, 199 insertions(+), 286 deletions(-)

The only concern I have is the pgd_lock lock hold times.

By not doing on-demand faults anymore, and consistently calling
sync_global_*(), we iterate that pgd_list thing much more often than
before if I'm not mistaken.


