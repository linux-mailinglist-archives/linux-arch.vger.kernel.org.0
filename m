Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC421563F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgGFLVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 07:21:22 -0400
Received: from foss.arm.com ([217.140.110.172]:59046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbgGFLVV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 07:21:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A2EC0A;
        Mon,  6 Jul 2020 04:21:21 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7420D3F68F;
        Mon,  6 Jul 2020 04:21:19 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:21:13 +0100
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
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v6 06/26] mm: Add PG_arch_2 page flag
Message-ID: <20200706112057.GA6432@gaia>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-7-catalin.marinas@arm.com>
 <27fe044a-8315-5394-575e-8f763696b0cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27fe044a-8315-5394-575e-8f763696b0cd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 10:24:04AM +0200, David Hildenbrand wrote:
> On 03.07.20 17:36, Catalin Marinas wrote:
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 6be1aa559b1e..276140c94f4a 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -135,6 +135,9 @@ enum pageflags {
> >  #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
> >  	PG_young,
> >  	PG_idle,
> > +#endif
> > +#ifdef CONFIG_64BIT
> > +	PG_arch_2,
> >  #endif
> >  	__NR_PAGEFLAGS,
> 
> People are usually *very* picky when it comes to new page flags. It
> somewhat concerns me that we bump up __NR_PAGEFLAGS for any 64bit arch.
> That feels wrong.

It was guarded by a specific config option initially but the comments
suggested that it could be dropped for 64-bit architectures:

https://lore.kernel.org/linux-arm-kernel/20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org/

The page flags is indeed a pretty limited resource as it also includes
the sparsemem section, node and zone fields. However, on 64-bit this
should be fine (the sparsemem section is gone with vmemmap support).

-- 
Catalin
