Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED27137D7
	for <lists+linux-arch@lfdr.de>; Sun, 28 May 2023 07:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjE1FsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 May 2023 01:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1FsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 May 2023 01:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD4BE;
        Sat, 27 May 2023 22:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A621E60A76;
        Sun, 28 May 2023 05:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2385C433D2;
        Sun, 28 May 2023 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685252892;
        bh=bkuMHroVl9TlOSFo6p59v17X6rAsvGxb3kzfT5vZogM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/fA88QDLAPfI5+3dlnjis0mHISdgNRk033rp1tEp/+Mnh4pdPF6GyqhT2d0f44ZM
         O9W0HkIZYw4XGrrX1f3tUzE0jNE3oALs8Cn992s+EfmiHsu8hfXhu3DkQX9TcwN2oj
         7E7N3KWaDItcFkwUQzuLHOiQy27MUurhgxG80g7TkNYefeCpTsWvx1dhgZiE8imgx7
         3iInnTBsRh7R7es7uW5hUx43VvmKiGSLfYpxMoZFKFBm9CDY8XYAON1aC4gzYndzuk
         JoH7BurJumWuV7HAw5lKspfn5I/oVTTKuKbhXpKROtOf7xIXSt3aAHLO5P0Ikkt3g7
         bN8aIuRcKOvMA==
Date:   Sun, 28 May 2023 08:47:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Message-ID: <20230528054745.GI4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
 <20230525202537.GA4967@kernel.org>
 <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
 <20230527104144.GH4967@kernel.org>
 <ZHIdK+170XoK2jVe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHIdK+170XoK2jVe@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 27, 2023 at 04:09:31PM +0100, Matthew Wilcox wrote:
> On Sat, May 27, 2023 at 01:41:44PM +0300, Mike Rapoport wrote:
> > Sorry if I wasn't clear, by "page table page" I meant the page (or memory
> > for that matter) for actual page table rather than struct page describing
> > that memory.
> > 
> > So what we allocate here is the actual memory for the page tables and not
> > the memory for the metadata. That's why I think the name ptdesc_alloc is
> > confusing.
> 
> But that's going to be the common pattern in the Glorious Future.
> You allocate a folio and that includes both the folio memory descriptor
> and the 2^n pages of memory described by that folio.  Similarly for all
> the other memory descriptors.

I'm not arguing with that, I'm not happy about the naming. IMO, the name
should reflect that we allocate memory for page tables rather than for the
descriptor of that memory, say pgtable_alloc() or page_table_alloc().

-- 
Sincerely yours,
Mike.
