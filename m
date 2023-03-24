Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6FB6C80DF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjCXPNh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjCXPNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 11:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C14F13D5C;
        Fri, 24 Mar 2023 08:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE5E62B75;
        Fri, 24 Mar 2023 15:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB15CC433EF;
        Fri, 24 Mar 2023 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679670786;
        bh=2AcWw4U7YmKhyTQRefWWqoVh+t5hGac5B/I1GEORDcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zzel3ow2bRiSIP0uPoMOj3Tjki4KkCXh7YbB8eL/QTEZhbndhov4+1S/2mYlsbS8m
         luqNLI1F6hwOAv/xgkt6VRZPUwd6GyEqbGjmuKHjT4XMYEbuslKmQf97b7aRjKFnj/
         0NuMEF8wpIB1dc0gJBGzG/pt7pQTQCdhPN4/gpQGPPmjiyxioUWKzcA0TvWl6g+LLd
         mQUJV0M94I5y4IfFJU+1IOwxk/5KkeUREzRCdqf/63Z4+WmQw/lEQQOeO0O1Y305Q2
         tJuzPAzLuXsby6sl5MvGE9aD2TDimW1sXGN/IuwVeQMMTfDBtv+4Z+myCoacgasg5a
         UdxITN47UaYaQ==
Date:   Fri, 24 Mar 2023 15:13:00 +0000
From:   Will Deacon <will@kernel.org>
To:     ypodemsk@redhat.com
Cc:     Peter Zijlstra <peterz@infradead.org>, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        ppandit@redhat.com, alougovs@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only
 to MM CPUs
Message-ID: <20230324151259.GC27199@willie-the-truck>
References: <20230312080945.14171-1-ypodemsk@redhat.com>
 <20230320084902.GE2194297@hirez.programming.kicks-ass.net>
 <a6ee41b39f3f516aab0f7fb327620cb2a43eeaca.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ee41b39f3f516aab0f7fb327620cb2a43eeaca.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 04:11:44PM +0200, ypodemsk@redhat.com wrote:
> On Mon, 2023-03-20 at 09:49 +0100, Peter Zijlstra wrote:
> > On Sun, Mar 12, 2023 at 10:09:45AM +0200, Yair Podemsky wrote:
> > > Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> > > indiscriminately, this causes unnecessary work and delays notable
> > > in
> > > real-time use-cases and isolated cpus, this patch will limit this
> > > IPI to
> > > only be sent to cpus referencing the effected mm and are currently
> > > in
> > > kernel space.
> > 
> > Did you validate that all architectures for which this is relevant
> > actually set bits in mm_cpumask() ?
> > 
> Hi Peter,
> Thank you for bringing this to my attention.
> I reviewed the architectures using the MMU_GATHER_RCU_TABLE_FREE:
> arm, powerpc, s390, sparc and x86 set the bit when switching process
> in.
> for arm64 removed set/clear bit in 38d96287504a ("arm64: mm: kill
> mm_cpumask usage")
> The reason given was that mm_cpumask was not used.
> Given that we now have a use for it, I will add a patch to revert.

Maintaining the mask is also not free, so I'm not keen on adding it back
unless there's a net win.

Will
