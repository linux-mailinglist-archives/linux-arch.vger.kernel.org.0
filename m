Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0576A2E7
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGaVez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaVey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 17:34:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77625130;
        Mon, 31 Jul 2023 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wgnR5bAqL2xpttjtPlBIH4TwsFtkouzs/SF7LfIw4XQ=; b=cGwctQdtUKzHZtGCTBUljHHpAF
        Gyl9ukMe9e3MBczirXiF1/uR4DvnO/D84pT8HNnCnkT48x4TW4nczA9lFALEOxUwLo1oq/1o5CQO7
        QzRi715jiHWfqwdsYA3zmCyzUpBStsy4ATFsOl82DLdq7xbzyIPfxy6pOI8Kf5LPeFPrqpQnROW5H
        9LGnhvTkARlC1P44faAzLBGpnIUTvTd2GQbmU/KCD4zVa+ziRperTNnNINfcDtk3UIhe8AbjsHAkq
        tsTTNwTojYd2oIL3msBz2uFrPDNJR0kIOX7yFddyHevyYN4Zt56jZB27bAs6E7Gw/zy0cqgm94lUX
        Vf7M7X6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQaWM-00D5kz-0W;
        Mon, 31 Jul 2023 21:33:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50B143002CE;
        Mon, 31 Jul 2023 23:33:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F5EB213D004E; Mon, 31 Jul 2023 23:33:41 +0200 (CEST)
Date:   Mon, 31 Jul 2023 23:33:41 +0200
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
Message-ID: <20230731213341.GB51835@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
 <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
 <20230731192012.GA11704@hirez.programming.kicks-ass.net>
 <87a5vbn5r0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5vbn5r0.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 11:14:11PM +0200, Thomas Gleixner wrote:
> On Mon, Jul 31 2023 at 21:20, Peter Zijlstra wrote:
> > -#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
> > +#define FUTEX2_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
> 
> Along with some comment which documents that the size "flags" constitute
> a number field and not flags in the sense of binary flags.
> 
> And please name these size constants so it really becomes obvious:
> 
> #define FUTEX2_SIZE_U32		2

So you want them named:

#define FUTEX2_SIZE_U8		0x00
#define FUTEX2_SIZE_U16		0x01
#define FUTEX2_SIZE_U32		0x02
#define FUTEX2_SIZE_U64		0x03

#define FUTEX2_SIZE_MASK	0x03

Sure, can do.

> >  /**
> >   * futex_parse_waitv - Parse a waitv array from userspace
> > @@ -208,11 +208,11 @@ static int futex_parse_waitv(struct fute
> >  			return -EINVAL;
> >  
> >  		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> > -			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
> > +			if ((aux.flags & FUTEX2_SIZE_MASK) == FUTEX2_64)
> >  				return -EINVAL;
> >  		}
> 
> That should be part of the actual 64bit futex enablement, no?

The 'unsigned long' thing is part of the syscalls, which is why I had it
now.

>   
> > -		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
> > +		if ((aux.flags & FUTEX2_SIZE_MASK) != FUTEX2_32)
> >  			return -EINVAL;
> 
> In hindsight I think it was as mistake just to have this __u32 flags
> field in the new interface. Soemthing like the incomplete below might be
> retrofittable, no?
> 
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -74,7 +74,12 @@
>  struct futex_waitv {
>  	__u64 val;
>  	__u64 uaddr;
> -	__u32 flags;
> +	union {
> +		__u32	flags;
> +		__u32	size	: 2,
> +				: 5,
> +			private	: 1;
> +	};
>  	__u32 __reserved;
>  };

Durr, I'm not sure I remember if that does the right thing across
architectures -- might just work. But I'm fairly sure this isn't the
only case of a field in a flags thing in our APIs. Although obviously I
can't find another case in a hurry :/

Also, sys_futex_{wake,wait}() have this thing as a syscall argument,
surely you don't want to put this union there as well?

I'd much prefer to just keep the 'unsigned int flags' thing and perhaps
put a comment on-top of the '#define FUTEX2_*' thingies. Note that
having it a field instead of a bunch of flags makes sense, since you can
only have a single size, not a combination of sizes.


