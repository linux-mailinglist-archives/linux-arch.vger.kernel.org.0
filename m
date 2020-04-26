Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5321B8B82
	for <lists+linux-arch@lfdr.de>; Sun, 26 Apr 2020 05:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDZDB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Apr 2020 23:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgDZDB2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Apr 2020 23:01:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6969B206D4;
        Sun, 26 Apr 2020 03:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587870086;
        bh=tCSwWc8iRTvfzhr9Bpi0vaaHrDRBHLwWGG3vKGlFHqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UVpTWp7EJhgRsQXBhfo6AT4VrUdy1nNy8nOq/LfihYfu1NC4LJc05Iz8GAX1ZT5f3
         axlF830cN9T/YdFik2zo+N3qO2F4mins96Mu5bgI3K/fB5ghL5mkLmCLUuWklYIKG9
         HZl62/U2hyOlgj8km6aRA/b/nX2GmC3gaq8w7s7A=
Date:   Sat, 25 Apr 2020 20:01:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/hugetlb: Introduce
 HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
Message-Id: <20200425200124.20d0c75fcaef05d062d3667c@linux-foundation.org>
In-Reply-To: <87d37591-caa2-b82b-392a-3a29b2c7e9a6@arm.com>
References: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
        <1586864670-21799-4-git-send-email-anshuman.khandual@arm.com>
        <20200425175511.7a68efb5e2f4436fe0328c1d@linux-foundation.org>
        <87d37591-caa2-b82b-392a-3a29b2c7e9a6@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 26 Apr 2020 08:13:17 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> 
> On 04/26/2020 06:25 AM, Andrew Morton wrote:
> > On Tue, 14 Apr 2020 17:14:30 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > 
> >> There are multiple similar definitions for arch_clear_hugepage_flags() on
> >> various platforms. This introduces HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS for those
> >> platforms that need to define their own arch_clear_hugepage_flags() while
> >> also providing a generic fallback definition for others to use. This help
> >> reduce code duplication.
> >>
> >> ...
> >>
> >> --- a/include/linux/hugetlb.h
> >> +++ b/include/linux/hugetlb.h
> >> @@ -544,6 +544,10 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
> >>  }
> >>  #endif
> >>  
> >> +#ifndef HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
> >> +static inline void arch_clear_hugepage_flags(struct page *page) { }
> >> +#endif
> >> +
> >>  #ifndef arch_make_huge_pte
> >>  static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
> >>  				       struct page *page, int writable)
> > 
> > This is the rather old-school way of doing it.  The Linus-suggested way is
> > 
> > #ifndef arch_clear_hugepage_flags
> > static inline void arch_clear_hugepage_flags(struct page *page)
> > {
> > }
> > #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> 
> Do we need that above line here ? Is not that implicit.

It depends if other header files want to test whether
arch_clear_hugepage_flags is already defined.  If the header heorarchy
is well-defined and working properly, they shouldn't need to, because
we're reliably indluding the relevant arch header before (or early
within) include/linux/hugetlb.h.

It would be nice if

#define arch_clear_hugepage_flags arch_clear_hugepage_flags
#define arch_clear_hugepage_flags arch_clear_hugepage_flags

were to generate an compiler error but it doesn't.  If it did we could
detect these incorrect inclusion orders.

> > #endif
> > 
> > And the various arch headers do
> > 
> > static inline void arch_clear_hugepage_flags(struct page *page)
> > {
> > 	<some implementation>
> > }
> > #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> > 
> > It's a small difference - mainly to avoid adding two variables to the
> > overall namespace where one would do.
> 
> Understood, will change and resend.

That's OK - I've queued up that fix.
