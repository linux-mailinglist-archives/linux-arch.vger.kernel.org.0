Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE28B6D7ABF
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjDELKN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDELKM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 07:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3854EEE;
        Wed,  5 Apr 2023 04:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9918463B9B;
        Wed,  5 Apr 2023 11:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CBBC433D2;
        Wed,  5 Apr 2023 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680693010;
        bh=ooCH6+LbUpOMMrNQgOWug2YiY+jDptLepUBqEHzy38Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8LvHGP+e+G/tSvmxikKj2fPXrrk0+3vQGP+KsaklvN9YmbUCHGANHWv3q6iC5HtS
         fy9l0bjNgR3HG3KM+EASpjRNgn7dp0Q7ndpMhPFCq5T5lviAwsVYYN/imSlMEqcc7J
         Pi0w5XFSLGZbOcOsH4lPOKZHWzTs10xmPVp5WHoBvKxxjhceqhX9MI5gQG81P+MTe7
         LUV9T7LzQ/XDpFte7PNV4zDO5W1rZBSwLnn10QDPGf1MrC31gIz37yW68z2ShgDqIe
         WrsUT0GI5Rjs9+Bf9sMLDspBq0Su2t5h8EXV4hbTo1QGErDk8Mc1BEdaH+mzYziPqY
         DTUnzQSCU4SjA==
Date:   Wed, 5 Apr 2023 13:10:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, arnd@arndb.de, keescook@chromium.org,
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
Message-ID: <ZC1XD/sEJY+zRujE@lothringen>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1Q7uX4rNLg3vEg@lothringen>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
> On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> > +	int state = atomic_read(&ct->state);
> > +	/* will return true only for cpus in kernel space */
> > +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> > +}
> 
> Also note that this doesn't stricly prevent userspace from being interrupted.
> You may well observe the CPU in kernel but it may receive the IPI later after
> switching to userspace.
> 
> We could arrange for avoiding that with marking ct->state with a pending work bit
> to flush upon user entry/exit but that's a bit more overhead so I first need to
> know about your expectations here, ie: can you tolerate such an occasional
> interruption or not?

Bah, actually what can we do to prevent from that racy IPI? Not much I fear...

