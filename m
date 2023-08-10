Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D607777F2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjHJMOH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjHJMOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 08:14:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3887CE;
        Thu, 10 Aug 2023 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Pa93SQq8YxZvrEKsoU75557vrKrxyHId0AZ4PcwSo4Y=; b=dwo7Y9o31EfEU/bYIBl9bXJKLH
        torAPvffwW+hDI0Lcp8R3NjEiR1GkUBebEqf/qPL4X/6K9LRK9nE1sJKF9bAVzXMsAz1fIGTdHTvs
        sc+sjSVxeXNaze3hFt/+dmVeGd819Zz7EWhgiIYSzEgotI3Ku+JK/w8gVffaAGz/7R1JmNEsuQI0E
        NqBf3UdiCPxEh34gd12aMDA/Epr4AwFcIF/SxnDvUmNj8Ry9tzIZe+JZIVhZEHLhTHfijHm2iQqOD
        +SyvFViybrcsDO7dDzEUuu/0ih8LEqBJE1XZOqrm7pzQ/9VfzAEvm5eW7J7fepkjuxlGOXvfICjpN
        liX8T4vw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qU4Xu-006U7N-1l;
        Thu, 10 Aug 2023 12:13:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F4BB30003A;
        Thu, 10 Aug 2023 14:13:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46ED420AC8AF1; Thu, 10 Aug 2023 14:13:41 +0200 (CEST)
Date:   Thu, 10 Aug 2023 14:13:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, tglx@linutronix.de,
        axboe@kernel.dk, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 05/14] futex: Add sys_futex_wake()
Message-ID: <20230810121341.GX212435@hirez.programming.kicks-ass.net>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.090897260@infradead.org>
 <071c02ae-a74d-46d8-990b-262264b62caf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <071c02ae-a74d-46d8-990b-262264b62caf@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 09, 2023 at 07:25:19PM -0300, André Almeida wrote:
> Hi Peter,
> 
> Em 07/08/2023 09:18, Peter Zijlstra escreveu:
> > To complement sys_futex_waitv() add sys_futex_wake(). This syscall
> > implements what was previously known as FUTEX_WAKE_BITSET except it
> > uses 'unsigned long' for the bitmask and takes FUTEX2 flags.
> > 
> > The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> 
> [...]
> 
> > +/*
> > + * sys_futex_wake - Wake a number of futexes
> > + * @uaddr:	Address of the futex(es) to wake
> > + * @mask:	bitmask
> > + * @nr:		Number of the futexes to wake
> > + * @flags:	FUTEX2 flags
> > + *
> > + * Identical to the traditional FUTEX_WAKE_BITSET op, except it is part of the
> > + * futex2 family of calls.
> > + */
> > +
> > +SYSCALL_DEFINE4(futex_wake,
> > +		void __user *, uaddr,
> > +		unsigned long, mask,
> > +		int, nr,
> > +		unsigned int, flags)
> > +{
> 
> Do you think we could have a
> 
> 	if (!nr)
> 		return 0;
> 
> here? Otherwise, calling futex_wake(&f, 0, flags) will wake 1 futex (if
> available), which is a strange undocumented behavior in my opinion.

Oh 'cute' that.. yeah, but how about I put it ...

> > +	if (flags & ~FUTEX2_VALID_MASK)
> > +		return -EINVAL;
> > +
> > +	flags = futex2_to_flags(flags);
> > +	if (!futex_flags_valid(flags))
> > +		return -EINVAL;
> > +
> > +	if (!futex_validate_input(flags, mask))
> > +		return -EINVAL;

here, because otherwise we get:

	sys_futex_wake(&f, 0xFFFF, 0, FUTEX2_SIZE_U8)

to return 0, even though that is 'obviously' nonsensical and should
return -EINVAL. Or even garbage flags would be 'accepted'.

(because 0xFFFF is larger than U8 can accomodate)

> > +
> > +	return futex_wake(uaddr, flags, nr, mask);
> > +}
