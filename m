Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701DC5A2704
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHZLqV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 07:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiHZLqU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 07:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1983B2CE7
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661514378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHGinpi7lqtAkMwygFoIPaEx54TEBffoywenxaeAscc=;
        b=Rit1P5cnaIZNxSAM15tx41oPwrQkoX5usOlJI/IV+fuFJ/eDC2rizuxVvTurCkMUi+F9e4
        vO5etDexIgXpyLoHlSZfbxAbODQCzi/fncwYr7Dje0LwLYded+XplUJpD+Wvnlm/JPWHZf
        kJxNgN2ay6QcXSI13Nzducn10PWg0Gk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-twmuZMTTO26HbL7tcjyqYA-1; Fri, 26 Aug 2022 07:46:15 -0400
X-MC-Unique: twmuZMTTO26HbL7tcjyqYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5BC6804191;
        Fri, 26 Aug 2022 11:46:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AB6040B40C8;
        Fri, 26 Aug 2022 11:46:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27QBkE6h018375;
        Fri, 26 Aug 2022 07:46:14 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27QBkDlA018371;
        Fri, 26 Aug 2022 07:46:13 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Aug 2022 07:46:13 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Will Deacon <will@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
In-Reply-To: <20220826112327.GA19774@willie-the-truck>
Message-ID: <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <20220826112327.GA19774@willie-the-truck>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, 26 Aug 2022, Will Deacon wrote:

> On Thu, Aug 25, 2022 at 05:03:40PM -0400, Mikulas Patocka wrote:
> > Here I reworked your patch, so that test_bit_acquire is defined just like 
> > test_bit. There's some code duplication (in 
> > include/asm-generic/bitops/generic-non-atomic.h and in 
> > arch/x86/include/asm/bitops.h), but that duplication exists in the 
> > test_bit function too.
> > 
> > I tested it on x86-64 and arm64. On x86-64 it generates the "bt" 
> > instruction for variable-bit test and "shr; and $1" for constant bit test. 
> > On arm64 it generates the "ldar" instruction for both constant and 
> > variable bit test.
> > 
> > For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all 
> > (with or without this patch), so I only compile-tested it on arm64. I have 
> > to bisect it.
> 
> It's working fine for me and I haven't had any other reports that it's not
> booting. Please could you share some more details about your setup so we
> can try to reproduce the problem?

I'm bisecting it now. I'll post the offending commit when I'm done.

It gets stuck without printing anything at this point:
Loading Linux 6.0.0-rc2 ...
Loading initial ramdisk ...
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...

I uploaded my .config here: 
https://people.redhat.com/~mpatocka/testcases/arm64-config/config-6.0.0-rc2 
so you can try it on your own.

The host system is MacchiatoBIN board with Debian 10.12.

> This looks good to me, thanks for doing it! Just one thing that jumped out
> at me:
> 
> > Index: linux-2.6/include/linux/buffer_head.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/buffer_head.h
> > +++ linux-2.6/include/linux/buffer_head.h
> > @@ -156,7 +156,7 @@ static __always_inline int buffer_uptoda
> >  	 * make it consistent with folio_test_uptodate
> >  	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
> >  	 */
> > -	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
> > +	return test_bit_acquire(BH_Uptodate, &bh->b_state);
> 
> Do you think it would be worth adding set_bit_release() and then relaxing
> set_buffer_uptodate() to use that rather than the smp_mb__before_atomic()?
> 
> Will

Yes, we could add this (but it would be better to add it in a separate 
patch, so that backporting of the origianal patch to -stable is easier).

Mikulas

