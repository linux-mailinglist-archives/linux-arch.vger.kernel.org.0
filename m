Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9568EFE0
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBHNf0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 08:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHNfZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 08:35:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455F35AB;
        Wed,  8 Feb 2023 05:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PMp0gXsVfVTqwcUhaqwEjQxmo111+Dr+n4G2THRRgz4=; b=nv1U4Cs2toJAUKTbNLnEh3GkOY
        7TafoARROVHQSw9xJfz56g9qot5qCf4w6m4SWQjlNps1Oe5T2sHs3KDsj7DDyHZsEule4Fc1EDsFi
        1ot7N3tXnfTdb0UAUOhw7OBfMJkQv96CLrRBbzSzT9W9CzOllOmN6OP7nihODAjH1GrmhpTSrxXbw
        +FQ3rTbD5HBPPVYU6nfEd7rZEnlmQKhiACj6Chvr3AVC+hWz7Ee5CIY899SSczPizMsfNgyHKXZEr
        J+yG9hswiuu8WG3XCLcbAsJkbqGmrnhF93OGExxTKKUafWDJ+5Nvu8CB5rz+/ij9RclHTGYLDqeqN
        r07kkj+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPkbR-001F0R-Gf; Wed, 08 Feb 2023 13:35:13 +0000
Date:   Wed, 8 Feb 2023 13:35:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: API for setting multiple PTEs at once
Message-ID: <Y+OlEUqJotSN3tLV@casper.infradead.org>
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
 <Y+K0O35jNNzxiXE6@casper.infradead.org>
 <ba99ed28-61e4-4acd-ce17-338f5a49ef26@ghiti.fr>
 <b44d5dc7-ee7a-80e0-5401-829bf5740de5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b44d5dc7-ee7a-80e0-5401-829bf5740de5@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 08, 2023 at 08:09:00PM +0800, Yin, Fengwei wrote:
> 
> 
> On 2/8/2023 7:23 PM, Alexandre Ghiti wrote:
> > Hi Matthew,
> > 
> > On 2/7/23 21:27, Matthew Wilcox wrote:
> >> On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
> >>> For those of you not subscribed, linux-mm is currently discussing
> >>> how best to handle page faults on large folios.  I simply made it work
> >>> when adding large folio support.  Now Yin Fengwei is working on
> >>> making it fast.
> >> OK, here's an actual implementation:
> >>
> >> https://lore.kernel.org/linux-mm/20230207194937.122543-3-willy@infradead.org/
> >>
> >> It survives a run of xfstests.  If your architecture doesn't store its
> >> PFNs at PAGE_SHIFT, you're going to want to implement your own set_ptes(),
> > 
> > 
> > riscv stores its pfn at PAGE_PFN_SHIFT instead of PAGE_SHIFT, se we need to reimplement set_ptes. But I have been playing with your patchset and we never fall into the case where set_ptes is called with nr > 1, any idea why? I booted a large ubuntu defconfig and launched will_it_scale.page_fault4.
> Need to use xfs filesystem to get large folio for file mapping.
> Other filesystem may be also OK. But I just tried xfs. Thanks.

XFS is certainly the flagship filesystem to support large folios, but
others have added support, AFS and EROFS.  You can also get large folios
in tmpfs (which is slightly different as it focuses on THPs rather than
generic large folios).

You also have to have CONFIG_TRANSPARENT_HUGEPAGE selected, which riscv
can do.  That restriction will be lifted at some point, but for now
large folios depends on the THP infrastructure.
