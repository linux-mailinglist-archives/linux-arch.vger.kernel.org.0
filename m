Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2546D7C9E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjDEMbh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjDEMbg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 08:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037EB1BE9;
        Wed,  5 Apr 2023 05:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0DD627D5;
        Wed,  5 Apr 2023 12:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD75C433EF;
        Wed,  5 Apr 2023 12:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680697893;
        bh=KFVTrjAz+H5bySuyR2Bq1Khen5yOd1Qtme1Bb1mppYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AG+EZgJ3qAQfgY0+ZZZgyJXsxmcSCxUGOlyF3yG6GA/pNNdu3cJbKH2/4xeHtapHU
         8KITD4pBhsc5TvHW50iExblXmcjY2LFFYtY2vLuaXrD78Xnny8GPdwCBy3/l3GEDA2
         0PcemdB5uk8CF+tIK2n9GOoxJ4g0SiK4BeLKqvDqZngUI+LayhU+0ydmUGOrgi4PTg
         g7V2GuESOAJHvh1fLlqU24sPxnckxmjiUEpUAkqPBtJKKYTc+VIwvkkgr4DiAlOo/x
         wtvmjO3VUP13kxL3k0XI7AZyB4y5ZlMS6zceunb6lXJLe9kn6iYpT27bIMlvkR+NyU
         VDRnFwdwjQlcA==
Date:   Wed, 5 Apr 2023 14:31:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
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
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <ZC1qInkK7jt/YJXc@lothringen>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1j8ivE/kK7+Gd5@lothringen>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 02:05:13PM +0200, Frederic Weisbecker wrote:
> On Wed, Apr 05, 2023 at 01:41:48PM +0200, Peter Zijlstra wrote:
> 1) It has the advantage to check context tracking _after_ the llist_add(), so
>    it really can't be misused ordering-wise.
> 
> 2) The IPI callback is always enqueued and then executed upon return
>    from userland. The ordering makes sure it will either IPI or execute
>    upon return to userspace.

*from userspace
