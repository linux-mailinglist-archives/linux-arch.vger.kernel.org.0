Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E73745E37
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGCOLG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCOLG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 10:11:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B569E58;
        Mon,  3 Jul 2023 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHgmW4jYFfefymgeKSK963KNOIaZu3e0HaLSnjpA4qM=; b=NYx3tbzkHNtzymbdVxK26tzRKE
        y0U7bussB88S4hawbqgi2OXu/Ixc+msp825EhkTymOzlJky3Gk/RlnBAehXzBvS1sq955fAUKa/v2
        QQBlUMEJ/QRVaeHZAtkbH8ySND/v6mkmXm5uQ4FF10C11cZe2Sntk1huT1PSd8iZgXW0UKui5Q3hN
        JtrAvZIp0VCWHgN068CLdTXLcDz2LG7D7aXqVSieR9/PQ1X06rFtnKlBi46GPzz3iI6rv7f+giIk5
        +Y+GTc0g+aOregoiGO/nItUYI4TiikK0ofkhQUtESUDqXpgz8RK+yOtDEDZEKulMxxnY3PExB5JTN
        7z9m/yyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGKFT-008Ifc-M6; Mon, 03 Jul 2023 14:09:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7282730005E;
        Mon,  3 Jul 2023 16:09:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59B5E2028FBD3; Mon,  3 Jul 2023 16:09:50 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:09:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, ppandit@redhat.com,
        david@redhat.com, linux@armlinux.org.uk, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, frederic@kernel.org,
        will@kernel.org, ardb@kernel.org, samitolvanen@google.com,
        juerg.haefliger@canonical.com, arnd@arndb.de,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] send tlb_remove_table_smp_sync IPI only to
 necessary CPUs
Message-ID: <20230703140950.GL4253@hirez.programming.kicks-ass.net>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
 <20230621074337.GF2046280@hirez.programming.kicks-ass.net>
 <ZJRC2s4sIuJ9V3A0@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRC2s4sIuJ9V3A0@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023 at 09:47:22AM -0300, Marcelo Tosatti wrote:

> > there's patches that cure the thp abuse of this.
> 
> The other case where the IPI can happen is:
> 
> CPU-0                                   CPU-1
> 
> tlb_remove_table
> tlb_remove_table_sync_one
> IPI
>                                         local_irq_disable
>                                         gup_fast
>                                         local_irq_enable
> 
> 
> So its not only the THP case.

(your CPU-1 thing is wholly irrelevant)

Well, I know, but this case *should* be exceedingly rare. Last time
around I asked why you all were tripping this, you pointed at the THP
case.

The THP case should be fixed along the lines of Jann's original patches.

If you can trip this at any significant rate, then we should probably
look at a better allocation scheme. It means you're really low on
memory.
