Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C246D9B97
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbjDFPDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbjDFPDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 11:03:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23D1BCB;
        Thu,  6 Apr 2023 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NvfDt1wEQmP4GbrgT80G40At21xJRS6EHasfhbcOMOE=; b=g9HMgChByDEcqwPRnMmPkqIWgT
        E9Jo8wK8pTfqUwNGF3RulzK1C+eAF5o0HLXxTCm1aNFPSyeLIz7NBcYvhiL3fWMksBf4GfvKV1nBp
        R1ktgGzkQffGLNq0EdKUX3JVOd/BZXRVD1HVj5FYNpwkWKn6UfKWr7lyfGZ57eHCE1Ap9OwCdXmRU
        QFECUvV14SnLI6zo7b+CEQjzYLN1FnZJGuTV5debvwUmU0/EFkTbbdBnK2iYw/w24I6u5ORsR1OjP
        NvQL1vw1dn0PsW8XZzYt7vrZuKd41B4X/0udSmxG7Wik20e3HITuLf+kHlTq/SOVx9kb+3BucjXbv
        rrreJmIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkR7v-00AYJQ-0d;
        Thu, 06 Apr 2023 15:02:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 184893000DC;
        Thu,  6 Apr 2023 17:02:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2B1E212E36AA; Thu,  6 Apr 2023 17:02:13 +0200 (CEST)
Date:   Thu, 6 Apr 2023 17:02:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
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
        alougovs@redhat.com, jannh@google.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406140423.GA386634@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 04:04:23PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 03:29:28PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 09:38:50AM -0300, Marcelo Tosatti wrote:
> > 
> > > > To actually hit this path you're doing something really dodgy.
> > > 
> > > Apparently khugepaged is using the same infrastructure:
> > > 
> > > $ grep tlb_remove_table khugepaged.c 
> > > 	tlb_remove_table_sync_one();
> > > 	tlb_remove_table_sync_one();
> > > 
> > > So just enabling khugepaged will hit that path.
> > 
> > Urgh, WTF..
> > 
> > Let me go read that stuff :/
> 
> At the very least the one on collapse_and_free_pmd() could easily become
> a call_rcu() based free.
> 
> I'm not sure I'm following what collapse_huge_page() does just yet.

DavidH, what do you thikn about reviving Jann's patches here:

  https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1

Those are far more invasive, but afaict they seem to do the right thing.
