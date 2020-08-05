Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E923C436
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 05:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgHED7D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 23:59:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbgHED7C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 23:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596599941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYHMWO+/kd/xb1BEqnZIo41jyaK7ZhQvyZqkmGc35KI=;
        b=JGV8WEMSwL2McCw5HQCd/QQflWHcws9XR6xRTwHTc8QI5eslB1SC6ucyai5PLZJe9E37CK
        OxC8OfghmwaYJDJnZyJjZ4e8jFQXm6lS9CDM5Zv057YFRpix4Torr/+qdPOfUSLLteJQ1v
        0Kju2tNq94oDRX6lT+DLWXOZW126ALg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-qwjgBZnQPM-_Txp2UuCA1g-1; Tue, 04 Aug 2020 23:57:25 -0400
X-MC-Unique: qwjgBZnQPM-_Txp2UuCA1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FD12800138;
        Wed,  5 Aug 2020 03:57:20 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B719C87B38;
        Wed,  5 Aug 2020 03:57:18 +0000 (UTC)
Date:   Wed, 5 Aug 2020 11:57:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH v2 11/17] arch, mm: replace for_each_memblock() with
 for_each_mem_pfn_range()
Message-ID: <20200805035715.GS10792@MiWiFi-R3L-srv>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-12-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-12-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are several occurrences of the following pattern:
> 
> 	for_each_memblock(memory, reg) {
> 		start_pfn = memblock_region_memory_base_pfn(reg);
> 		end_pfn = memblock_region_memory_end_pfn(reg);
> 
> 		/* do something with start_pfn and end_pfn */
> 	}
> 
> Rather than iterate over all memblock.memory regions and each time query
> for their start and end PFNs, use for_each_mem_pfn_range() iterator to get
> simpler and clearer code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/init.c           | 11 ++++-------
>  arch/arm64/mm/init.c         | 11 ++++-------
>  arch/powerpc/kernel/fadump.c | 11 ++++++-----
>  arch/powerpc/mm/mem.c        | 15 ++++++++-------
>  arch/powerpc/mm/numa.c       |  7 ++-----
>  arch/s390/mm/page-states.c   |  6 ++----
>  arch/sh/mm/init.c            |  9 +++------
>  mm/memblock.c                |  6 ++----
>  mm/sparse.c                  | 10 ++++------
>  9 files changed, 35 insertions(+), 51 deletions(-)
> 

Reviewed-by: Baoquan He <bhe@redhat.com>

