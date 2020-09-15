Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7026AC9D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgIOSyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgIORXk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 13:23:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786FFC061352
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 10:14:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j2so4920790ioj.7
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jT9s1JAVx2W5cNkDMrd7bWYf1jbIzkRTHh6c6VRDMuY=;
        b=gdIp7xtBO/MSpEb9o8jN2IyQr26hmZe4Y1Inos4WGDR9JaBIQIi1PU3JIQChI0g3d7
         LNCuIXI9NjrLEa4Z7VzoHoYibkJTvYYNe4XMxYvI8Key8Lz+Dn5TOJoG3OirB4lNf/0v
         CZwnoRL2aTjSfXTMe2vCnRhhGcF5/px2guqwjtyoY+pY4/WqMrRsa3daDkNGpvajy3Os
         F5adkpgafrtJqtA1mdt1vlIxNc/cvIEHgPvBIGAHbOJRmRqdTTGQSyxSLDdT0bWH+lVs
         aoX0hyxrh/WWLqV3qXKOZbrIk4oQpUdoGJ5imOxIC9ur6GCE2cmivVAVgws5orQ0743v
         GgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jT9s1JAVx2W5cNkDMrd7bWYf1jbIzkRTHh6c6VRDMuY=;
        b=olpPi+Ee0b+z7+6Qp6gt+OaQqbMaoSgCiXAZmd6Pyi/qBY799358sPAiCk7pm70Fup
         LnX4oosbwAdsgH1uIUSsghfN9J420VC1mygLPTuZ3a0VzI0otQx1ZHnFs45/mJR3tPNt
         KITIeXujGc0nR4wGVvHVneHk8L8AqJuSY8mrNtBXWcUx3LtdNiBKS7okbWR2kWQ1uStY
         UoEd7IAZ/tgrD3feTGist8X5G/PPinanJgOMxw+Zs7BK7tshcEh2GWMgQqx5rT0gx5z4
         9N0beY5km4ofd6poKmOTfyvDT8ez2vNMUJ0KQMymqtNjvjsgIJm8RYn9smI02o2gRZe0
         Fh9w==
X-Gm-Message-State: AOAM533kdF5t1/GfMeXcu0MbwkLg6Ahy1MUFabI2m5nJ9rAZ8qPDH0oE
        oOVD4OKKiqRpX/b0qUgMKpKrNBOvNBXddzdP
X-Google-Smtp-Source: ABdhPJzPmldAEg1RI32WpLRYJaop5kMVcEE7x7cIiRQrPffUZq0WsPOosFaK5gGj43Fd4thLTpOr6w==
X-Received: by 2002:a5e:9916:: with SMTP id t22mr16004622ioj.163.1600190061826;
        Tue, 15 Sep 2020 10:14:21 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id z2sm4640548ilz.37.2020.09.15.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:14:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIEX6-006Vzt-2h; Tue, 15 Sep 2020 14:14:20 -0300
Date:   Tue, 15 Sep 2020 14:14:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <20200915171420.GK1221970@ziepe.ca>
References: <20200911200511.GC1221970@ziepe.ca>
 <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 11, 2020 at 10:36:43PM +0200, Vasily Gorbik wrote:
> Currently to make sure that every page table entry is read just once
> gup_fast walks perform READ_ONCE and pass pXd value down to the next
> gup_pXd_range function by value e.g.:
> 
> static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>                          unsigned int flags, struct page **pages, int *nr)
> ...
>         pudp = pud_offset(&p4d, addr);
> 
> This function passes a reference on that local value copy to pXd_offset,
> and might get the very same pointer in return. This happens when the
> level is folded (on most arches), and that pointer should not be iterated.
> 
> On s390 due to the fact that each task might have different 5,4 or
> 3-level address translation and hence different levels folded the logic
> is more complex and non-iteratable pointer to a local copy leads to
> severe problems.
> 
> Here is an example of what happens with gup_fast on s390, for a task
> with 3-levels paging, crossing a 2 GB pud boundary:
> 
> // addr = 0x1007ffff000, end = 0x10080001000
> static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>                          unsigned int flags, struct page **pages, int *nr)
> {
>         unsigned long next;
>         pud_t *pudp;
> 
>         // pud_offset returns &p4d itself (a pointer to a value on stack)
>         pudp = pud_offset(&p4d, addr);
>         do {
>                 // on second iteratation reading "random" stack value
>                 pud_t pud = READ_ONCE(*pudp);
> 
>                 // next = 0x10080000000, due to PUD_SIZE/MASK != PGDIR_SIZE/MASK on s390
>                 next = pud_addr_end(addr, end);
>                 ...
>         } while (pudp++, addr = next, addr != end); // pudp++ iterating over stack
> 
>         return 1;
> }
> 
> This happens since s390 moved to common gup code with
> commit d1874a0c2805 ("s390/mm: make the pxd_offset functions more robust")
> and commit 1a42010cdc26 ("s390/mm: convert to the generic
> get_user_pages_fast code"). s390 tried to mimic static level folding by
> changing pXd_offset primitives to always calculate top level page table
> offset in pgd_offset and just return the value passed when pXd_offset
> has to act as folded.
> 
> What is crucial for gup_fast and what has been overlooked is
> that PxD_SIZE/MASK and thus pXd_addr_end should also change
> correspondingly. And the latter is not possible with dynamic folding.
> 
> To fix the issue in addition to pXd values pass original
> pXdp pointers down to gup_pXd_range functions. And introduce
> pXd_offset_lockless helpers, which take an additional pXd
> entry value parameter. This has already been discussed in
> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
> 
> Cc: <stable@vger.kernel.org> # 5.2+
> Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
> v2: added brackets &pgd -> &(pgd)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Regards,
Jason
