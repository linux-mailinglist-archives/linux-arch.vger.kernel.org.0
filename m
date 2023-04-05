Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833A6D8768
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDETxx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 15:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDETxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 15:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC10C18F;
        Wed,  5 Apr 2023 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xfugB8gwxIrdC2R107Iwf3RGbPJjSDOcowvFi/5tZ98=; b=RQLyy2B2a56aLhk92w1zockLYu
        GyxtlcJv3uVkzVuUAbS+vCfQAByO61u7M3A1OPrBog1K7cUo2unN2+IR18kVFW97eBVtrxu6XXJX/
        wafQIo6qPTFiithrwoY3bfzt/wxMPxkLE+Mo9B/tHJ/QuLXN9WsqxXQU94wawQvs2+OmKXFu0eSg8
        tdTc+xbXAue/v07k/Ctw5B3ctOuWZ7G+pkHjz/FpgoMyVKuL/951PBtsipQ+36I0uMAUwH0IYKihE
        PBio4xNYHmMDQPU7AiJUKS1W/VYoSP2mqzTOp+RckMuOuXKpd+tSf9MLnaF6hFLQ8Vhb2wwZu77pq
        +ZM5SYhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk9BM-00Ghqu-7z; Wed, 05 Apr 2023 19:52:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2292300194;
        Wed,  5 Apr 2023 21:52:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 886E2200B42A8; Wed,  5 Apr 2023 21:52:26 +0200 (CEST)
Date:   Wed, 5 Apr 2023 21:52:26 +0200
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
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230405195226.GB365912@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC3P3Ds/BIcpRNGr@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 04:45:32PM -0300, Marcelo Tosatti wrote:
> On Wed, Apr 05, 2023 at 01:10:07PM +0200, Frederic Weisbecker wrote:
> > On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
> > > On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> > > > +	int state = atomic_read(&ct->state);
> > > > +	/* will return true only for cpus in kernel space */
> > > > +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> > > > +}
> > > 
> > > Also note that this doesn't stricly prevent userspace from being interrupted.
> > > You may well observe the CPU in kernel but it may receive the IPI later after
> > > switching to userspace.
> > > 
> > > We could arrange for avoiding that with marking ct->state with a pending work bit
> > > to flush upon user entry/exit but that's a bit more overhead so I first need to
> > > know about your expectations here, ie: can you tolerate such an occasional
> > > interruption or not?
> > 
> > Bah, actually what can we do to prevent from that racy IPI? Not much I fear...
> 
> Use a different mechanism other than an IPI to ensure in progress
> __get_free_pages_fast() has finished execution.
> 
> Isnt this codepath slow path enough that it can use
> synchronize_rcu_expedited?

To actually hit this path you're doing something really dodgy.
