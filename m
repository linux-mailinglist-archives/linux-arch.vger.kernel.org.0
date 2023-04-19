Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A077E6E78CC
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjDSLnC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSLnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 07:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F213FAB
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2023 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681904506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+ljsW3KAuErNDeeE9uh+f3S5vccVtwLnf4UBEcIcgs=;
        b=aV0nZ0rOPpKxA53CETPSTeR4QDO1q87aYwDQiHgv1z1WGcFZAshbciI0n+UENVZZjNrZ4f
        gcUt2zOi1qT5w9TheUE3rNg5G9/U7zzOGhobtspCyoKurx9Xx7hsIG30gbTmsFaiwQnB09
        TWoETCMq4TYG3AokynnYgI2vQnroauQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-WCYnVo6lNP6ZqvgcTniNgw-1; Wed, 19 Apr 2023 07:41:43 -0400
X-MC-Unique: WCYnVo6lNP6ZqvgcTniNgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9F1A810BD4;
        Wed, 19 Apr 2023 11:41:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48B721121315;
        Wed, 19 Apr 2023 11:41:40 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7E64240512CCB; Wed, 19 Apr 2023 08:39:48 -0300 (-03)
Date:   Wed, 19 Apr 2023 08:39:48 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZD/TBN5doEex3iag@tpad>
References: <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
 <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
 <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
 <20230406182749.GA405948@hirez.programming.kicks-ass.net>
 <914e826e-3fab-4540-d3a1-24ca39b1cf0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914e826e-3fab-4540-d3a1-24ca39b1cf0a@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 19, 2023 at 01:30:57PM +0200, David Hildenbrand wrote:
> On 06.04.23 20:27, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 05:51:52PM +0200, David Hildenbrand wrote:
> > > On 06.04.23 17:02, Peter Zijlstra wrote:
> > 
> > > > DavidH, what do you thikn about reviving Jann's patches here:
> > > > 
> > > >     https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1
> > > > 
> > > > Those are far more invasive, but afaict they seem to do the right thing.
> > > > 
> > > 
> > > I recall seeing those while discussed on security@kernel.org. What we
> > > currently have was (IMHO for good reasons) deemed better to fix the issue,
> > > especially when caring about backports and getting it right.
> > 
> > Yes, and I think that was the right call. However, we can now revisit
> > without having the pressure of a known defect and backport
> > considerations.
> > 
> > > The alternative that was discussed in that context IIRC was to simply
> > > allocate a fresh page table, place the fresh page table into the list
> > > instead, and simply free the old page table (then using common machinery).
> > > 
> > > TBH, I'd wish (and recently raised) that we could just stop wasting memory
> > > on page tables for THPs that are maybe never going to get PTE-mapped ... and
> > > eventually just allocate on demand (with some caching?) and handle the
> > > places where we're OOM and cannot PTE-map a THP in some descend way.
> > > 
> > > ... instead of trying to figure out how to deal with these page tables we
> > > cannot free but have to special-case simply because of GUP-fast.
> > 
> > Not keeping them around sounds good to me, but I'm not *that* familiar
> > with the THP code, most of that happened after I stopped tracking mm. So
> > I'm not sure how feasible is it.
> > 
> > But it does look entirely feasible to rework this page-table freeing
> > along the lines Jann did.
> 
> It's most probably more feasible, although the easiest would be to just
> allocate a fresh page table to deposit and free the old one using the mmu
> gatherer.
> 
> This way we can avoid the khugepaged of tlb_remove_table_smp_sync(), but not
> the tlb_remove_table_one() usage. I suspect khugepaged isn't really relevant
> in RT kernels (IIRC, most of RT setups disable THP completely).

People will disable khugepaged because it causes IPIs (and the fact one
has to disable khugepaged is a configuration overhead, and a source of
headache for configuring the realtime system, since one can forget of
doing that, etc).

But people do want to run non-RT applications along with RT applications
(in case you have a single box on a priviledged location, for example).

> 
> tlb_remove_table_one() only triggers if __get_free_page(GFP_NOWAIT |
> __GFP_NOWARN); fails. IIUC, that can happen easily under memory pressure
> because it doesn't wait for direct reclaim.
> 
> I don't know much about RT workloads (so I'd appreciate some feedback), but
> I guess we can run int memory pressure as well due to some !rt housekeeping
> task on the system?

Yes, exactly (memory for -RT app will be mlocked).

