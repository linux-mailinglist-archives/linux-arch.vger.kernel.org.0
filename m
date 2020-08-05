Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386E123C8C1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHEJLw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 05:11:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32833 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgHEJLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2020 05:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596618680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ozBDa1/xPHY8DQkaA9JqUMmSyVVQ14zD1Crd0znMso=;
        b=PKa1vVZ2ktwBbfJkH7uBUaodNzgQ70N4m/jCCX7g/UIAZUY8lbCvw7c9g+fCCXqVyht8ex
        9nC4o/YKAN4lSfzxNsQjmVN66prsFkDwEUcJYUhezxiXCa9yG0tA9vq0Ik9tc6LfFXIAx8
        0LsaCfLZyY43EVbe7qQasoabcd3WOxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-yG35Dv0sMVyPaqKEAb-z_A-1; Wed, 05 Aug 2020 05:11:16 -0400
X-MC-Unique: yG35Dv0sMVyPaqKEAb-z_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB37818C63C1;
        Wed,  5 Aug 2020 09:11:11 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2D2772E4F;
        Wed,  5 Aug 2020 09:11:07 +0000 (UTC)
Date:   Wed, 5 Aug 2020 17:11:05 +0800
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
Subject: Re: [PATCH v2 16/17] memblock: implement
 for_each_reserved_mem_region() using __next_mem_region()
Message-ID: <20200805091105.GW10792@MiWiFi-R3L-srv>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-17-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-17-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/02/20 at 07:36pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Iteration over memblock.reserved with for_each_reserved_mem_region() used
> __next_reserved_mem_region() that implemented a subset of
> __next_mem_region().
> 
> Use __for_each_mem_range() and, essentially, __next_mem_region() with
> appropriate parameters to reduce code duplication.
> 
> While on it, rename for_each_reserved_mem_region() to
> for_each_reserved_mem_range() for consistency.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .clang-format                    |  2 +-
>  arch/arm64/kernel/setup.c        |  2 +-
>  drivers/irqchip/irq-gic-v3-its.c |  2 +-
>  include/linux/memblock.h         | 12 +++------
>  mm/memblock.c                    | 46 +++++++-------------------------
>  5 files changed, 17 insertions(+), 47 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

