Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369BA769C63
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjGaQ0d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjGaQ02 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:26:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2110E4;
        Mon, 31 Jul 2023 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MjS3rbs97pcRqmVTM4Ntvkn5tG97L9HJKbZqV2SijdA=; b=niqvBOYZHOXE+q73f6SrdABTZ4
        fZF5s6RZfVGQvPiG3mFm10Bo/YzgdCgZeT9nAsXkmbQlEUpJ81BzQ/C2Rae2mo3y/ax5ubkKzVnPH
        FxTf+IGC6MO3OJiff45Jr/SBmTsSLXu1TL/RrC+TAU1nmw7Hmo7ihKY//N7dvQsGnFdyxrIT3sKhN
        XDe41iSWEvv4P2xFIYl1Xj4kZM06WleapB9notMo/ccxEWK4GssPIItQdDhvgd9zfFsYBroTMZzi5
        7tRbyMK6qIsNlQST+Qf5fQDGFFUbZ5CrzKSYULOKg04mTpkAaLqozLTjX+2+u+3Ck7xs1ydQM5sC6
        UX9EwdMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQViP-002cvL-7X; Mon, 31 Jul 2023 16:25:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8404C300134;
        Mon, 31 Jul 2023 18:25:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D19F203C783E; Mon, 31 Jul 2023 18:25:48 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:25:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Message-ID: <20230731162548.GN29590@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
 <87edkonjrk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edkonjrk.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 06:11:27PM +0200, Thomas Gleixner wrote:
> On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> > +#define FUTEX2_8		0x00
> > +#define FUTEX2_16		0x01
> >  #define FUTEX2_32		0x02
> > -			/*	0x04 */
> > +#define FUTEX2_64		0x03
> > +#define FUTEX2_NUMA		0x04
> >  			/*	0x08 */
> >  			/*	0x10 */
> >  			/*	0x20 */
> > --- a/kernel/futex/syscalls.c
> > +++ b/kernel/futex/syscalls.c
> > @@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
> >  	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
> >  }
> >  
> > -#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
> > +#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
> >  
> >  /**
> >   * futex_parse_waitv - Parse a waitv array from userspace
> > @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
> >  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
> >  			return -EINVAL;
> 
> With the above aux.flags with FUTEX2_32 set will result in -EINVAL. I
> don't think that's intentional.

FUTEX2_8     0
FUTEX2_16    1
FUTEX2_32    2
FUTEX2_64    3

Therefore FUTEX2_64, when used as a mask, includes then all.

Arnd suggested adding FUTEX2_SIZE_MASK or something. And I initially had
something like that, but pulled it for not wanting to pullute the uabi.

Can easily add back.
