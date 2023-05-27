Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18983713560
	for <lists+linux-arch@lfdr.de>; Sat, 27 May 2023 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjE0PJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 May 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjE0PJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2023 11:09:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A55E3;
        Sat, 27 May 2023 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u50hcZSLxjXk+ZnHObIQ29gSZuYnejTLeMWOgyxvfyQ=; b=kvDbU0q2z5jUTh3d5nQNpnIto9
        5xrW767Q1PCPoDvq7cJx36GAZEG2mizda3DrQtiBOGyiytCq2OMTOEXq8TWh2LZ+xzaLqiKD9V9Eb
        EJX8E77j208rlnFcLKHX2rZvcHGssHh261tJ08qNlv2+zYnLCkftBGtSrrF/p39TJSIPJr0ITg4/l
        1g7Vh1u4qG6tN9I49LGc4DG6JUJ0KFWAYdrSkVV8XgiRrI/avMqTujLKkfiEnrTSZ/y+N3Nd9R9D8
        /OJnFeU9SGlsUclnIO5MUMB9v4WCZl1IYBNx4a3hMv/KnLwfYzmktawxgr1m6qrMuAbL8hw04B8Os
        8rYGwubA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2vXv-003tpc-6G; Sat, 27 May 2023 15:09:31 +0000
Date:   Sat, 27 May 2023 16:09:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <ZHIdK+170XoK2jVe@casper.infradead.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
 <20230525202537.GA4967@kernel.org>
 <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
 <20230527104144.GH4967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527104144.GH4967@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 27, 2023 at 01:41:44PM +0300, Mike Rapoport wrote:
> Sorry if I wasn't clear, by "page table page" I meant the page (or memory
> for that matter) for actual page table rather than struct page describing
> that memory.
> 
> So what we allocate here is the actual memory for the page tables and not
> the memory for the metadata. That's why I think the name ptdesc_alloc is
> confusing.

But that's going to be the common pattern in the Glorious Future.
You allocate a folio and that includes both the folio memory descriptor
and the 2^n pages of memory described by that folio.  Similarly for all
the other memory descriptors.
