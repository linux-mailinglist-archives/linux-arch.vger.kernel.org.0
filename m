Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D471C1CD31A
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKHnE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKHnD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2020 03:43:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15CC061A0C;
        Mon, 11 May 2020 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DAesUFHs3+q5GtlegIPJlfeGWtX+Y+hxDiwu9e6F0sY=; b=kVWkXI+hLMTACOSwPqCaOyS2We
        VFyTICdLnsGOW4GySQeVAHxa/bnE/VB27ScJS0+ibDJVEy3tQvZoSwSNXToYYtW+aLUcLjOiXW9pU
        f41QUPV25MliC0FCocYSJnQ37unthzZT17mmsih8cG+znSLkJJzOF+BGfz25pBJEbMiyUwJhrXhjR
        x33YDWAcnzViVhSZQb0c3gKT7+qtWLTufIlevJdS0sXlTBfbTyBpC9QPBrs7ZIX3f3A2At227q3fP
        5k51WwJAmlHUvyM5f7JFs0pu1Tcaww4yZFrCp/ZdhnsKGAy+xCihTerrfmBqFVehwvniM7PydMxpy
        Cc97eILA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY35J-0007Gl-US; Mon, 11 May 2020 07:42:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 386CB303DA0;
        Mon, 11 May 2020 09:42:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D4392870C6C3; Mon, 11 May 2020 09:42:43 +0200 (CEST)
Date:   Mon, 11 May 2020 09:42:43 +0200
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
Message-ID: <20200511074243.GE2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
 <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 09, 2020 at 12:05:29PM -0700, Andy Lutomirski wrote:

> On x86_64, the only real advantage is that the handful of corner cases
> that make vmalloc faults unpleasant (mostly relating to vmap stacks)
> go away.  On x86_32, a bunch of mind-bending stuff (everything your
> series deletes but also almost everything your series *adds*) goes
> away.  There may be a genuine tiny performance hit on 2-level systems
> due to the loss of huge pages in vmalloc space, but I'm not sure I
> care or that we use them anyway on these systems.  And PeterZ can stop
> even thinking about RCU.
> 
> Am I making sense?

I think it'll work for x86_64 and that is really all I care about :-)
