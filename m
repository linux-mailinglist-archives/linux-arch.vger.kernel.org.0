Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED820C3A1
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 21:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgF0TDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgF0TDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jun 2020 15:03:24 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675ADC061794;
        Sat, 27 Jun 2020 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OR7OBaJyU20QVLaZTPXddMLTo5rxOsqU6iEIJEupuWE=; b=rq00ouSxMdTmSFa28hDOUKTHBg
        3dXyfPXkTUDZyQHTetqsyMna5fwntHa6QKcic/h71IwcUCnGNbErGyqkiwiLcgU2nYHZh16/QaPeb
        b5zkBVG9gFL5QSc/VNDuNclsIuluvuMI/LYza+5r2JW/cLhLN6jZ5ik5eKIuodERFMabxSNfOI2Bi
        +dL26IWnzvmxsRx2Z0NmVql7PiiPOtRewW4aUiQeNyCevs8ZZkzP0faCH2uqSnyC23QLvVtj1Wi9z
        Fo+73sfYzK5rnUfqtXfFwYUwyfilRDtoIcUUPTCSGsmVmOCF5BvgZD7yS/O5QwZNMhirY3o8KlkeY
        6JIFEkYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpG6S-0005fe-2n; Sat, 27 Jun 2020 19:03:04 +0000
Date:   Sat, 27 Jun 2020 20:03:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 4/8] asm-generic: pgalloc: provide generic
 pmd_alloc_one() and pmd_free_one()
Message-ID: <20200627190304.GG25039@casper.infradead.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627143453.31835-5-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 05:34:49PM +0300, Mike Rapoport wrote:
> More elaborate versions on arm64 and x86 account memory for the user page
> tables and call to pgtable_pmd_page_ctor() as the part of PMD page
> initialization.
> 
> Move the arm64 version to include/asm-generic/pgalloc.h and use the generic
> version on several architectures.
> 
> The pgtable_pmd_page_ctor() is a NOP when ARCH_ENABLE_SPLIT_PMD_PTLOCK is
> not enabled, so there is no functional change for most architectures except
> of the addition of __GFP_ACCOUNT for allocation of user page tables.

Thanks for including this line; it reminded me that we're not setting
the PageTable flag on the page, nor accounting it to the zone page stats.
Hope you don't mind me tagging a patch to do that on as 9/8.

We could also do with a pud_page_[cd]tor and maybe even p4d/pgd versions.
But that brings me to the next question -- could/should some of this
be moved over to asm-generic/pgalloc.h?  The ctor/dtor aren't called
from anywhere else, and there's value to reducing the total amount of
code in mm.h, but then there's also value to keeping all the ifdef
ARCH_ENABLE_SPLIT_PMD_PTLOCK code together too.  So I'm a bit torn.
What do you think?
