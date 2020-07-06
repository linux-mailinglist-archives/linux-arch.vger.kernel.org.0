Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A25215BD0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgGFQaR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 12:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgGFQaR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 12:30:17 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26DD20702;
        Mon,  6 Jul 2020 16:30:14 +0000 (UTC)
Date:   Mon, 6 Jul 2020 17:30:12 +0100
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 07/26] mm: Preserve the PG_arch_* flags in
 __split_huge_page_tail()
Message-ID: <20200706163012.GH28170@gaia>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-8-catalin.marinas@arm.com>
 <16aeea8c-b5c4-0d19-2fde-f95ef8dfddc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16aeea8c-b5c4-0d19-2fde-f95ef8dfddc6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 04:16:13PM +0200, David Hildenbrand wrote:
> On 03.07.20 17:36, Catalin Marinas wrote:
> > When a huge page is split into normal pages, part of the head page flags
> > are transferred to the tail pages. However, the PG_arch_* flags are not
> > part of the preserved set.
> > 
> > PG_arch_1 is currently used by the arch code to handle cache maintenance
> > for user space (either for I-D cache coherency or for D-cache aliases
> > consistent with the kernel mapping). Since splitting a huge page does
> > not change the physical or virtual address of a mapping, additional
> > cache maintenance for the tail pages is unnecessary. Preserving the
> > PG_arch_1 flag from the head page in the tail pages would not break the
> > current use-cases.
> 
> ^ is fairly arm64 specific, no? (I remember that the semantics are
> different e.g., on s390x).

Not entirely arm64 specific. Apart from s390 and x86, I think all the
other architectures use this flag for cache maintenance (I guess they
followed the cachetlb.rst suggestion). My understanding of the s390 and
x86 is that transferring this flag from the head of a compound page to
the tail pages should not cause any issue. We don't even document
anywhere that this flag is meant to disappear on huge page splitting. I
guess no-one noticed because clearing it is relatively benign.

But if there are concerns, I'm happy to guard it with something like
__ARCH_WANT_PG_ARCH_HEAD_TAIL (I need to think of a more suggestive
name).

> > have valid tags. The absence of such flag causes the arm64 set_pte_at()
> > to clear the tags in order to avoid stale tags exposed to user or the
> > swapping out hooks to ignore the tags. Not preserving PG_arch_2 on huge
> > page splitting leads to tag corruption in the tail pages.
> 
> "currently"? I don't think so - isn't it follow-up patches in this series?

True. It used to be correct before reordering the patches prior to
posting.

-- 
Catalin
