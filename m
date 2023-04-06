Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC96D9AB5
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbjDFOmH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjDFOlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:41:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF602E0;
        Thu,  6 Apr 2023 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xC9liSByLfpmJoqxob1Tfe5QJtboRITHVK7L2yzhpb4=; b=rEIkwQ/wxL0jbUwKNMG+Rh2X7J
        fhszdLIzSoytlVtA4gcIUYPYI8IA1Jwh6TeTtXAh3APvzGn9QtZ/HqTywulvk4Df4PtnnO40IDaBd
        4ZvtlOBF7yGAQPzpfFAmhO5IxmOLDaNwkkrydZ3Gcgl1WF0OUojR7tF3RXOQTtWC4wGL+7WVFfYZn
        ObQcLHeCK4J039oW17+VXorH+Ez+FqxveiV0q7ZKCMtFodu4+1u0q2K1HssdvPWS4UaLP12oUmZEZ
        MU7rPLjGwsEoA0GXCU3E/wk0EU3HtN/HGsZIZbNNtQKaCbLvxGCp5vLBqHYTa8Z/UolfGFRVEzFo1
        yL+DHjGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQlu-00AY5v-2L;
        Thu, 06 Apr 2023 14:39:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BA2F300338;
        Thu,  6 Apr 2023 16:39:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FDF3212E36AE; Thu,  6 Apr 2023 16:39:26 +0200 (CEST)
Date:   Thu, 6 Apr 2023 16:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
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
        linux-mm@kvack.org, mtosatti@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230406143926.GP386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen>
 <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
 <20230406133805.GO386572@hirez.programming.kicks-ass.net>
 <xhsmh8rf59k2f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8rf59k2f.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 03:11:52PM +0100, Valentin Schneider wrote:
> On 06/04/23 15:38, Peter Zijlstra wrote:
> > On Wed, Apr 05, 2023 at 01:45:02PM +0100, Valentin Schneider wrote:
> >>
> >> I've been hacking on something like this (CSD deferral for NOHZ-full),
> >> and unfortunately this uses the CPU-local cfd_data storage thing, which
> >> means any further smp_call_function() from the same CPU to the same
> >> destination will spin on csd_lock_wait(), waiting for the target CPU to
> >> come out of userspace and flush the queue - and we've just spent extra
> >> effort into *not* disturbing it, so that'll take a while :(
> >
> > I'm not sure I buy into deferring stuff.. a NOHZ_FULL cpu might 'never'
> > come back. Queueing data just in case it does seems wasteful.
> 
> Putting those callbacks straight into the bin would make my life much
> easier!

Well, it's either they get inhibited at the source like the parent patch
does, or they go through. I really don't see a sane middle way here.

> Unfortunately, even if they really should, I don't believe all of the
> things being crammed onto NOHZ_FULL CPUs have the same definition of
> 'never' as we do :/

That's not entirely the point, the point is that there are proper
NOHZ_FULL users that won't return to the kernel until the machine shuts
down. Buffering stuff for them is more or less a direct memory leak.

