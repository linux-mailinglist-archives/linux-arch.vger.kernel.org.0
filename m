Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5006D7BB8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjDELnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjDELnQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 07:43:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD0D3AA9;
        Wed,  5 Apr 2023 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DQKKqvngu6XrRzj+GHyns7zyGuc6jnX9ARbttsuRzGk=; b=idnRPt7gzQIUPNNaD/IneFbHZm
        Hm/M7lAn3X4M4YAYJsQgsjTurXZhVLP+iiZ9DLmmlDgK6Ty2FAY7CRFNNpqMni4zQbFYv3FtAENxu
        rNPAKqNkSHWeLDWiAjKwNyv5my/aHd3mnPLCSOHTHa9T7oJzr+m9d08KJcsOsdQQx5jQUsB9UhhSb
        RLcTiqExcEOHERblZmxKkZC4oD4bnhiuRkWSqwuebLcFLkMDvh1IOWxDvijroXsSnIf9/EcuRxJFg
        DXJ4LPSdwxCbUqwIBrua3JDo72zyVBMFh6D4PI6IsCPV+XocyHo3f1L25Z3MBwKSoBQ7MBQZtcEmr
        6DcJWnTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pk1WT-009tua-07;
        Wed, 05 Apr 2023 11:41:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3173300274;
        Wed,  5 Apr 2023 13:41:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9417320B6A7D6; Wed,  5 Apr 2023 13:41:48 +0200 (CEST)
Date:   Wed, 5 Apr 2023 13:41:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20230405114148.GA351571@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1XD/sEJY+zRujE@lothringen>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 01:10:07PM +0200, Frederic Weisbecker wrote:
> On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
> > On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> > > +	int state = atomic_read(&ct->state);
> > > +	/* will return true only for cpus in kernel space */
> > > +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> > > +}
> > 
> > Also note that this doesn't stricly prevent userspace from being interrupted.
> > You may well observe the CPU in kernel but it may receive the IPI later after
> > switching to userspace.
> > 
> > We could arrange for avoiding that with marking ct->state with a pending work bit
> > to flush upon user entry/exit but that's a bit more overhead so I first need to
> > know about your expectations here, ie: can you tolerate such an occasional
> > interruption or not?
> 
> Bah, actually what can we do to prevent from that racy IPI? Not much I fear...

Yeah, so I don't think that's actually a problem. The premise is that
*IFF* NOHZ_FULL stays in userspace, then it will never observe the IPI.

If it violates this by doing syscalls or other kernel entries; it gets
to keep the pieces.


