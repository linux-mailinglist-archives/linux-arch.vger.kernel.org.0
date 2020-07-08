Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB6521870B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGHMRi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 08:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgGHMRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Jul 2020 08:17:38 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D74206C3;
        Wed,  8 Jul 2020 12:17:35 +0000 (UTC)
Date:   Wed, 8 Jul 2020 13:17:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v6 07/26] mm: Preserve the PG_arch_* flags in
 __split_huge_page_tail()
Message-ID: <20200708121732.GC6308@gaia>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-8-catalin.marinas@arm.com>
 <16aeea8c-b5c4-0d19-2fde-f95ef8dfddc6@redhat.com>
 <20200706163012.GH28170@gaia>
 <bed8d086-8ed5-d72a-7a1f-327ef982d1a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed8d086-8ed5-d72a-7a1f-327ef982d1a5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 07:56:43PM +0200, David Hildenbrand wrote:
> On 06.07.20 18:30, Catalin Marinas wrote:
> > On Mon, Jul 06, 2020 at 04:16:13PM +0200, David Hildenbrand wrote:
> >> On 03.07.20 17:36, Catalin Marinas wrote:
> >>> When a huge page is split into normal pages, part of the head page flags
> >>> are transferred to the tail pages. However, the PG_arch_* flags are not
> >>> part of the preserved set.
> >>>
> >>> PG_arch_1 is currently used by the arch code to handle cache maintenance
> >>> for user space (either for I-D cache coherency or for D-cache aliases
> >>> consistent with the kernel mapping). Since splitting a huge page does
> >>> not change the physical or virtual address of a mapping, additional
> >>> cache maintenance for the tail pages is unnecessary. Preserving the
> >>> PG_arch_1 flag from the head page in the tail pages would not break the
> >>> current use-cases.
> >>
> >> ^ is fairly arm64 specific, no? (I remember that the semantics are
> >> different e.g., on s390x).
> > 
> > Not entirely arm64 specific. Apart from s390 and x86, I think all the
> > other architectures use this flag for cache maintenance (I guess they
> > followed the cachetlb.rst suggestion). My understanding of the s390 and
> > x86 is that transferring this flag from the head of a compound page to
> > the tail pages should not cause any issue. We don't even document
> > anywhere that this flag is meant to disappear on huge page splitting. I
> > guess no-one noticed because clearing it is relatively benign.
> 
> On s390x, PG_arch_1 indicates (s390/kernel/uv.c:arch_make_page_accessible())
> - kernel page tables
> - for hugetlbfs pages, that storage keys are initialized for that page
>   (IIRC KVM only)
> - a user space page might be encrypted/secure (KVM only)
> 
> The latter does not support hugetlbfs/THP. KVM does not support THP. So
> on s390x the bit should never be set in that context and, therefore,
> also won't be affected by this change.

Thanks for checking.

> > But if there are concerns, I'm happy to guard it with something like
> > __ARCH_WANT_PG_ARCH_HEAD_TAIL (I need to think of a more suggestive
> > name).
> 
> I guess we can avoid that if we properly check+document all users.
> (ignoring x86 and s390x behavior here might be dangerous, although my
> gut feeling is that it's ok for both)

I'll post an independent patch for PG_arch_1 to get consensus among
architectures. The PG_arch_2 introduced by the MTE patches can have the
new behaviour since it would only be used by arm64 initially.

-- 
Catalin
