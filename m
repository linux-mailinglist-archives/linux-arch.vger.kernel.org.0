Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590011CE13B
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 19:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgEKRHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgEKRHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2020 13:07:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92009C061A0C;
        Mon, 11 May 2020 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bXc6/TC/fZd2A0tKIOuFHMPLNl2BdCBVGsE8fSj7QXY=; b=28Ffg6ORBIyHGTftSfOhouhHMk
        Tf6ecTJhdIajQ7tRRE5NmP+qKfDtEpdZqHsg1bIEjirRoF04iCG8I8WLGSm1Gw9pmxsrPQ2IdIFpY
        VKbR0W/fH6z41vCLkx8zhHyHRWCJOsavPXoNvuHkJnV4yc7HdLXSQ2ODzRIjk6cPZb4/BzPp9tNQs
        QWtW1PJTDA1PJFTLBCTPGXUkNSk8AxJtjyijDCBoKVBmyxwwmKP00bSlhHnUnSydU0IEKovGUGlvO
        zJ3qYS/6jVxeMgQas8m1UMDn8FODT5RlJejjWdTV4esB8mYPiId7Zv94MjBPSXjRltpaNDKSyMpyE
        4YST0k2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYBtB-00043D-UG; Mon, 11 May 2020 17:06:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0CA4301A66;
        Mon, 11 May 2020 19:06:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCF2B29DA4B49; Mon, 11 May 2020 19:06:46 +0200 (CEST)
Date:   Mon, 11 May 2020 19:06:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200511170646.GJ2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
 <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
 <20200511074243.GE2957@hirez.programming.kicks-ass.net>
 <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 11, 2020 at 08:36:31AM -0700, Andy Lutomirski wrote:
> On Mon, May 11, 2020 at 12:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, May 09, 2020 at 12:05:29PM -0700, Andy Lutomirski wrote:
> >
> > > On x86_64, the only real advantage is that the handful of corner cases
> > > that make vmalloc faults unpleasant (mostly relating to vmap stacks)
> > > go away.  On x86_32, a bunch of mind-bending stuff (everything your
> > > series deletes but also almost everything your series *adds*) goes
> > > away.  There may be a genuine tiny performance hit on 2-level systems
> > > due to the loss of huge pages in vmalloc space, but I'm not sure I
> > > care or that we use them anyway on these systems.  And PeterZ can stop
> > > even thinking about RCU.
> > >
> > > Am I making sense?
> >
> > I think it'll work for x86_64 and that is really all I care about :-)
> 
> Sadly, I think that Joerg has convinced my that this doesn't really
> work for 32-bit unless we rework the LDT code or drop support for
> something that we might not want to drop support for.

I was thinking keep these patches for 32bit and fix 64bit 'proper'. But
sure, if we can get rid of it all by stripping 32bit features I'm not
going to object either.
