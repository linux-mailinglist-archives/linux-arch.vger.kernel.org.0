Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6576C80CC
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjCXPL0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjCXPLX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 11:11:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6119F2E;
        Fri, 24 Mar 2023 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8uJj6EPj+UD3O21Pqn1G98WWv3xWLtmqX4YnUhEP8NU=; b=Vxu4i84z/vDjsISB7zvMxaSSV1
        8WTOiUyzkFfe/IdsRmYVRN6SrMDc28w3mFzpErB0JvqAPcQkE7vnbdqRgYKwRp6cXso/CB5l74w3P
        yh/F0fCWSJJXiX3Bq5RgOwLJDaPppVluv+iaA9hhWNXUB3GXE6XpDsrxJH/FmYcdprayJndYczTj6
        9lYJtnWQ64h6iy7c2DDgwV/oskwOf1JGM7p15GDfMPfl1NW1VnTTcWb5h1sNFLYptK1FiUg1+X34w
        2LdbPU8lhk9VF14ZoX8dZHIKVVG2so24Q0xN41XUNJ5HUowKSNGFxccxygZ4Ieu+mgWwlpCVjtAjv
        C06NTeqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfj4G-0050pI-MU; Fri, 24 Mar 2023 15:11:00 +0000
Date:   Fri, 24 Mar 2023 15:11:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Message-ID: <ZB29hND1tt37dNUX@casper.infradead.org>
References: <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
 <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
 <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
 <20230324145828.GB27199@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324145828.GB27199@willie-the-truck>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 02:58:29PM +0000, Will Deacon wrote:
> Yes, please don't fault everything in as young as it has caused horrible
> vmscan behaviour leading to app-startup slowdown in the past:
> 
> https://lore.kernel.org/all/20210111140149.GB7642@willie-the-truck/
> 
> If we have to use the same value for all the ptes, then just base them
> all on arch_wants_old_prefaulted_pte() as iirc hardware AF was pretty
> cheap in practice for us.

I think that's wrong, because this is a different scenario.

Before:

We faulted in N single-page folios.  Each page/folio is tracked
independently.  That's N entries on whatever LRU list it ends up on.
The prefaulted ones _should_ be marked old -- they haven't been
accessed; we've just decided to put them in the page tables to
speed up faultaround.  The unaccessed pages need to fall off the LRU
list as quickly as possible; keeping them around only hurts if the
workload has no locality of reference.

After:

We fault in N folios, some possibly consisting of multiple pages.
Each folio is tracked separately, but individual pages in the folio
are not tracked; they belong to their folio.  In this scenario, if
the other PTEs for pages in the same folio are marked as young or old
doesn't matter; the entire folio will be tracked as young, because we
referenced one of the pages in this folio.  Marking the other PTEs as
young actually helps because we don't take pagefaults on them (whether
we have a HW or SW accessed bit).

(can i just say that i dislike how we mix up our old/young accessed/not
terminology here?)

We should still mark the PTEs referencing unaccessed folios as old.
No argument there, and this patch does that.  But it's fine for all the
PTEs referencing the accessed folio to have the young bit, at least as
far as I can tell.
