Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13B8321778
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBVMtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 07:49:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:39944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhBVMrY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 07:47:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613997998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSoQkwih8ksFFRXBnQ2uGYGVyAUL6YhMR0u+WuJWwqg=;
        b=XqMjnMB7820VC1A4vgfme9m2Hi31qX2p6kBGzOO6c/eIdI+pfkp1/RDkL+7WgOIBXaVB6M
        HOScBSKlqCkR9P1qVM1CvzxtuNwVi1OLvpl4xp6M9Y4rZW9Hntb22y0lB+L15WhsWbIx28
        j7Yi6MpOwdivG/IyiOW/jl6Vfd2KeY4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0C5AAD2B;
        Mon, 22 Feb 2021 12:46:37 +0000 (UTC)
Date:   Mon, 22 Feb 2021 13:46:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <YDOnq9Nliopj9kQL@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
 <20210218225904.GB6669@xz-x1>
 <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I am slowly catching up with this thread.

On Fri 19-02-21 09:20:16, David Hildenbrand wrote:
[...]
> So if we have zero, we write zero. We'll COW pages, triggering a write fault
> - and that's the only good thing about it. For example, similar to
> MADV_POPULATE, nothing stops KSM from merging anonymous pages again. So for
> anonymous memory the actual write is not helpful at all. Similarly for
> hugetlbfs, the actual write is not necessary - but there is no other way to
> really achieve the goal.

I really do not see why you care about KSM so much. Isn't KSM an
explicit opt-in with a fine grained interface to control which memory to
KSM or not?
-- 
Michal Hocko
SUSE Labs
