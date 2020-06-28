Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794A20C6A9
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jun 2020 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgF1HK5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Jun 2020 03:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgF1HK4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Jun 2020 03:10:56 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D65920775;
        Sun, 28 Jun 2020 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593328255;
        bh=yK/mmEcayAp4K1SoJVYgv0KctiM5CGqsdRXbo6D8DTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyijhxBtiPImkMHKkSGIyXWOBHqIqoPqHi03HWzaGBbmBhYKOSRUunGTmaRWc4Gjn
         2TMA+ldpEEnMFu0kFYBgT1B2G/Iqyrdp18UacvMYdOXnb2Y4yh/FSazt4w3nUe/3UB
         VKf4vf+8Dah0/sxlNf+Z75XPskzsJ/8NsyHkTS2A=
Date:   Sun, 28 Jun 2020 10:10:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20200628071044.GC576120@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-5-rppt@kernel.org>
 <20200627190304.GG25039@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627190304.GG25039@casper.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 08:03:04PM +0100, Matthew Wilcox wrote:
> On Sat, Jun 27, 2020 at 05:34:49PM +0300, Mike Rapoport wrote:
> > More elaborate versions on arm64 and x86 account memory for the user page
> > tables and call to pgtable_pmd_page_ctor() as the part of PMD page
> > initialization.
> > 
> > Move the arm64 version to include/asm-generic/pgalloc.h and use the generic
> > version on several architectures.
> > 
> > The pgtable_pmd_page_ctor() is a NOP when ARCH_ENABLE_SPLIT_PMD_PTLOCK is
> > not enabled, so there is no functional change for most architectures except
> > of the addition of __GFP_ACCOUNT for allocation of user page tables.
> 
> Thanks for including this line; it reminded me that we're not setting
> the PageTable flag on the page, nor accounting it to the zone page stats.
> Hope you don't mind me tagging a patch to do that on as 9/8.
> 
> We could also do with a pud_page_[cd]tor and maybe even p4d/pgd versions.
> But that brings me to the next question -- could/should some of this
> be moved over to asm-generic/pgalloc.h?  The ctor/dtor aren't called
> from anywhere else, and there's value to reducing the total amount of
> code in mm.h, but then there's also value to keeping all the ifdef
> ARCH_ENABLE_SPLIT_PMD_PTLOCK code together too.  So I'm a bit torn.
> What do you think?

There are arhcitectures that don't use asm-generic/pgalloc.h but rather
have their own, sometimes completely different, versoins of these
funcitons.

I've tried adding linux/pgalloc.h, but I've ended up with contradicting
need to include asm/pgalloc.h before the generic code for some
architecures or after the generic code for others :)

I think let's leave it in mm.h for now, maybe after several more cleaups
we could do better.

-- 
Sincerely yours,
Mike.
