Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C866DCB95D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2019 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfJDLnP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Oct 2019 07:43:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJDLnP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Oct 2019 07:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WIvDWFtv2p/WZ58W6pXljHGiVfYoXqP27Nes4L6u4OM=; b=Kebviybu4eI80VBS6jZGt8Kia9
        v/roRs8L242mCUK4xtYI4O+imHzI2lAOI39SuiNHc8S1fwlKmGAMn8npPxn94N7HECIm3tu0JvSGx
        nnjeGrRUnp9ZN7PEdoSSPhCKMrn8ZVUbD9DzYRsy8RBMQFSoHerrtdvSbrFn0e3z/FcPuFXr3iqgO
        rWeTgJXWD3+/H1p214aM+GJbVD9m8HWYXEpVOPHvcZcKAwzz5JgD4dGD6fgM6LIP2wG9480tfvcq/
        SS3KO8+/ivJaZezrOFqCYQnpx4FpJvD5/0BGyKhYzhdklY+XRNHXlY3/Ru9gJfbdZKdvuDDm0Ppeg
        mr/QvjXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGLyp-0006q5-RM; Fri, 04 Oct 2019 11:42:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57BA030034F;
        Fri,  4 Oct 2019 13:41:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05D67203E50D2; Fri,  4 Oct 2019 13:42:37 +0200 (CEST)
Date:   Fri, 4 Oct 2019 13:42:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        Christoph Lameter <cl@linux.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Reza Arbab <arbab@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
Message-ID: <20191004114236.GD19463@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003072952.GN4536@hirez.programming.kicks-ass.net>
 <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 03, 2019 at 05:36:31PM -0300, Leonardo Bras wrote:

> > Also, I'm not sure I understand things properly.
> >=20
> > So serialize_against_pte_lookup() wants to wait for all currently
> > out-standing __find_linux_pte() instances (which are very similar to
> > gup_fast).
> >=20
> > It seems to want to do this before flushing the THP TLB for some reason;
> > why? Should not THP observe the normal page table freeing rules which
> > includes a RCU-like grace period like this already.
> >=20
> > Why is THP special here? This doesn't seem adequately explained.
>=20
> "It's necessary to monitor lockless pagetable walks, in order to avoid
> doing THP splitting/collapsing during them."
>=20
> If a there is a THP split/collapse during the lockless pagetable walk,
> the returned ptep can be a pointing to an invalid pte.=20

So the whole premise of lockless page-table walks (gup_fast) is that it
can work on in-flux page-tables. Specifically gup_fast() never returns
PTEs, only struct page *, and only if it can increment the page
refcount.

In order to enable this, page-table pages are RCU(-like) freed, such
that even if we access page-tables that have (concurrently) been
unlinked, we'll not UaF (see asm-generic/tlb.h, the comment at
HAVE_RCU_TABLE_FREE). IOW, the worst case if not getting a struct page
*.

I really don't see how THP splitting/collapsing is special here, either
we see the PMD and find a struct page * or we see a PTE and find the
same struct page * (compound page head).

The only thing that needs to be guaranteed is that both PTEs and PMD
page-tables are valid. Is this not so?

> To avoid that, the pmd is updated, then serialize_against_pte_lookup is
> ran. Serialize runs a do_nothing in all cpu in cpu_mask.=20
>=20
> So, after all cpus finish running do_nothing(), there is a guarantee
> that if there is any 'lockless pagetable walk' it is running on top of
> a updated version of this pmd, and so, collapsing/splitting THP is
> safe.

But why would it matter?! It would find the same struct page * through
either version of the page-tables. *confused*

> > Also, specifically to munmap(), this seems entirely superfluous,
> > munmap() uses the normal page-table freeing code and should be entirely
> > fine without additional waiting.
>=20
> To be honest, I remember it being needed in munmap case, but I really
> don't remember the details. I will take a deeper look and come back
> with this answer.=20

munmap does normal mmu_gather page-table teardown, the THP PMD should be
RCU-like freed just like any other PMD. Which should be perfectly safe
vs lockless page-table walks.

If you can find anything there that isn't right, please explain that in
detail and we'll need to look hard at fixing _that_.

> > Furthermore, Power never accurately tracks mm_cpumask(), so using that
> > makes the whole thing more expensive than it needs to be. Also, I
> > suppose that is buggered vs file backed THP.
>=20
> That accuracy of mm_cpumask is above my knowledge right now. =3D)

Basically PowerPC only ever sets bits in there, unlike x86 that also
clears bits (at expense, but it's worth it for us).

