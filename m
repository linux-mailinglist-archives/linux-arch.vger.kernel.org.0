Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3601B57C9
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgDWJJ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 05:09:29 -0400
Received: from foss.arm.com ([217.140.110.172]:35476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDWJJ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 05:09:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5716D31B;
        Thu, 23 Apr 2020 02:09:28 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E58E43F73D;
        Thu, 23 Apr 2020 02:09:26 -0700 (PDT)
Date:   Thu, 23 Apr 2020 10:09:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/4] mm: Add arch hooks for saving/restoring tags
Message-ID: <20200423090919.GA4963@gaia>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-3-steven.price@arm.com>
 <edd132f8-c39b-9586-1714-19a335ccea5c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd132f8-c39b-9586-1714-19a335ccea5c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 11:08:10AM -0700, Dave Hansen wrote:
> On 4/22/20 7:25 AM, Steven Price wrote:
> > Three new hooks are added to the swap code:
> >  * arch_prepare_to_swap() and
> >  * arch_swap_invalidate_page() / arch_swap_invalidate_area().
> > One new hook is added to shmem:
> >  * arch_swap_restore_tags()
> 
> How do the tags get restored outside of the shmem path?  I was expecting
> to see more arch_swap_restore_tags() sites.

The restoring is done via set_pte_at() -> mte_sync_tags() ->
mte_restore_tags() in the arch code (see patch 3).
arch_swap_restore_tags() just calls mte_restore_tags() directly.

shmem is slightly problematic as it moves the page from the swap cache
to the shmem one and I think arch_swap_invalidate_page() would have
already been called by the time we get to set_pte_at() (Steven can
correct me if I got this wrong).

-- 
Catalin
