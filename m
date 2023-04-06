Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88096D9FD1
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 20:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbjDFS2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFS2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 14:28:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D759FA;
        Thu,  6 Apr 2023 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=krRR1rbNljM3A0v7Or9ollBea6RqbuAL/TrS9ntMbko=; b=HYwyP5557eX2aBI0hUlezid1GH
        5hoyG1Aj5dHjNeznaZOFr7Cy51rbii3Y5i3cE2woInFfeI8EAPtppz3o99BPe2GIduN6vXv6uyaw7
        R9cuTob59q/BPrQnGdBywtK77Stl8OJJpBnvpSy/YFDL7vPiYkNIMiGQPDEidGAvoA4jROBnBdVah
        jOoSwHyGjI0QMaTrXlud204St1NXsF+ujX5WasSumcwLZCeKMORJsJy5xkcpHYXjSOgsSKV186/O/
        cA0kt/u7rjhL3oPljvBtkfjk5sjNe9coia8oht3RGaO73x29c2Bi67dc2zk8arCu3QV+LNr4pLHNl
        VKwPG5qQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkUKx-00Ad17-2X;
        Thu, 06 Apr 2023 18:27:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDA6530008D;
        Thu,  6 Apr 2023 20:27:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5453212E36AA; Thu,  6 Apr 2023 20:27:49 +0200 (CEST)
Date:   Thu, 6 Apr 2023 20:27:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vschneid@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com, jannh@google.com,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230406182749.GA405948@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
 <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
 <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 05:51:52PM +0200, David Hildenbrand wrote:
> On 06.04.23 17:02, Peter Zijlstra wrote:

> > DavidH, what do you thikn about reviving Jann's patches here:
> > 
> >    https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1
> > 
> > Those are far more invasive, but afaict they seem to do the right thing.
> > 
> 
> I recall seeing those while discussed on security@kernel.org. What we
> currently have was (IMHO for good reasons) deemed better to fix the issue,
> especially when caring about backports and getting it right.

Yes, and I think that was the right call. However, we can now revisit
without having the pressure of a known defect and backport
considerations.

> The alternative that was discussed in that context IIRC was to simply
> allocate a fresh page table, place the fresh page table into the list
> instead, and simply free the old page table (then using common machinery).
> 
> TBH, I'd wish (and recently raised) that we could just stop wasting memory
> on page tables for THPs that are maybe never going to get PTE-mapped ... and
> eventually just allocate on demand (with some caching?) and handle the
> places where we're OOM and cannot PTE-map a THP in some descend way.
> 
> ... instead of trying to figure out how to deal with these page tables we
> cannot free but have to special-case simply because of GUP-fast.

Not keeping them around sounds good to me, but I'm not *that* familiar
with the THP code, most of that happened after I stopped tracking mm. So
I'm not sure how feasible is it.

But it does look entirely feasible to rework this page-table freeing
along the lines Jann did.
