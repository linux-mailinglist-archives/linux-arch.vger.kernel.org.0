Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF776BDB6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 21:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHAT2H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjHAT2G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 15:28:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3F10E;
        Tue,  1 Aug 2023 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gaut94wtJvcD0zi3q7k4JYT7+QEi/Ua5L41+y8I+W9A=; b=FWrX0z28U3EqiQJrIFfM/btNnD
        h0r6Q0OJ3rp5KMXJorNilcAfp8f3kEIhltT8RjmJWCxZ+EUksczMNZPOLsVqYa8HvYCGAKxjvRc6Z
        ZHXdgNjBBXysu78uR2VE4uvd/UnmJTUo3BNeWLgbqgStaLTfK4lAPj83qDQEU85kHEyUSozuXFVlJ
        y1i8KQOzRWSaUDKfxEWBhsPHwkBEDJQPlrogyIqDoeihbK6N8zE1PqhZkxC3zwUdvdzanaPkJK5nq
        VdvR8Yc4tHO6vQgiV2CjJtdAth0lqVMHIYcwyP+9RxH1FNA2UhNOA8i99+Whl9iPkLdc/nlZ850V3
        puAflRfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQv2I-00AacX-ID; Tue, 01 Aug 2023 19:28:02 +0000
Date:   Tue, 1 Aug 2023 20:28:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Message-ID: <ZMlcwrCMdZIBWT90@casper.infradead.org>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
 <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
 <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
 <ZMfjmhaqVZyZNNMW@casper.infradead.org>
 <dcf5dbff-df95-0b5e-964e-6e55c843d977@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf5dbff-df95-0b5e-964e-6e55c843d977@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 01, 2023 at 02:53:02PM +0800, Rongwei Wang wrote:
> 
> On 2023/8/1 00:38, Matthew Wilcox wrote:
> > On Mon, Jul 31, 2023 at 06:30:22PM +0200, David Hildenbrand wrote:
> > > Assume we do do the page table sharing at mmap time, if the flags are right.
> > > Let's focus on the most common:
> > > 
> > > mmap(memfd, PROT_READ | PROT_WRITE, MAP_SHARED)
> > > 
> > > And doing the same in each and every process.
> > That may be the most common in your usage, but for a database, you're
> > looking at two usage scenarios.  Postgres calls mmap() on the database
> > file itself so that all processes share the kernel page cache.
> > Some Commercial Databases call mmap() on a hugetlbfs file so that all
> > processes share the same userspace buffer cache.  Other Commecial
> > Databases call shmget() / shmat() with SHM_HUGETLB for the exact
> > same reason.
> > 
> > This is why I proposed mshare().  Anyone can use it for anything.
> 
> Hi Matthew
> 
> I'm a little confused about this mshare(). Which one is the mshare() you
> refer to here, previous mshare() based on filesystem or this RFC v2 posted
> by Khalid?
> 
> IMHO, they have much difference between previously mshare() and
> MAP_SHARED_PT now.

I haven't read this version of the patchset.  I'm describing the original
idea, not what it may have turned into.  As far as I'm concerned, we're
still trying to decide what functionality we actually want, not arguing
about whether this exact patchset has the correct number of tab indents
to be merged.
