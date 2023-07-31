Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93A76A29C
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGaV0V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaV0T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 17:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054271BC9;
        Mon, 31 Jul 2023 14:26:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690838776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOyZYQGm0MoJgeRcATNSzytWw/GODfx4yBoXl9xBt9w=;
        b=VQcvH21ri/7cJfk/ZgUC2zYyZE+Hx4attzSE9v0589Ifq+jW+nD+wFl1T/60qr3m9zkWCX
        DHQe7BreeLeAutwnpdzDa0EDjn0/rJ5E10tI0/0v48Zshmw7MiebjO/P98KPFSjGaJZQNl
        uBa5yvXG3ohh01KBZtHoNIaiRp259ax2gbCe3TUJngxgFsTFZBr0FWRONsTZDDqNnPyEuG
        OpomVeyo0Bgf4v+S8vI9glRFKST2AFyn2NyXvx+zp9SG2Az8BQh2VeSpGWOHBnvcvOOqRr
        CnV1doy/p+GLbpRp72Dg5ld1bZDsfPj9LM/HFFW7YkY3KRUOuSMKVgJ4jxzkcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690838776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOyZYQGm0MoJgeRcATNSzytWw/GODfx4yBoXl9xBt9w=;
        b=XmYoW7zSEC4HRRi4m8F7ZhuIprmQqfj2BrCLP75+CPmEHHaMZUWwuj4+xo3jB3OQCtguMF
        SIrPickUz5GdkADg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20230731180320.GR29590@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.434742902@infradead.org> <87pm48m19m.ffs@tglx>
 <20230731180320.GR29590@hirez.programming.kicks-ass.net>
Date:   Mon, 31 Jul 2023 23:26:15 +0200
Message-ID: <875y5zn56w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31 2023 at 20:03, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 07:36:21PM +0200, Thomas Gleixner wrote:
>> Hmm. Shouldn't that have changed with the allowance of the 1 and 2 byte
>> futexes?
>
> That patches comes after this.. :-)

Futexes are really cursed :)

> But I do have an open question here; do we want FUTEX2_NUMA futexes
> aligned at futex_size or double that? That is, what do we want the
> alignment of:
>
> struct futex_numa_32 {
> 	u32 val;
> 	u32 node;
> };
>
> to be? Having that u64 aligned will guarantee these two values end up in
> the same page, having them u32 aligned (as per this patch) allows for
> them to be split.

Same page and same cacheline.

> The current paths don't care, we don't hold locks, but perhaps it makes
> sense to be conservative.

I think it makes sense.

>> >  	address -= key->both.offset;
>> >  
>> > -	if (unlikely(!access_ok(uaddr, sizeof(u32))))
>> > +	if (flags & FLAGS_NUMA)
>> > +		size *= 2;
>> > +
>> > +	if (unlikely(!access_ok(uaddr, size)))
>> >  		return -EFAULT;
>> >  
>> >  	if (unlikely(should_fail_futex(fshared)))
>> >  		return -EFAULT;
>> >  
>> > +	key->both.node = -1;
>> 
>> Please put this into an else path.
>
> Can do, but I figured the compiler could figure it out through dead
> store elimitation or somesuch pass.

Sure, but taste disagrees and it simply makes the code more obvious.

>> > +	if (flags & FLAGS_NUMA) {
>> > +		void __user *naddr = uaddr + size/2;
>> 
>> size / 2;
>> 
>> > +
>> > +		if (futex_get_value(&node, naddr, flags))
>> > +			return -EFAULT;
>> > +
>> > +		if (node == -1) {
>> > +			node = numa_node_id();
>> > +			if (futex_put_value(node, naddr, flags))
>> > +				return -EFAULT;
>> > +		}
>> > +
>> > +		if (node >= MAX_NUMNODES || !node_possible(node))
>> > +			return -EINVAL;
>> 
>> That's clearly an else path too. No point in checking whether
>> numa_node_id() is valid.
>
> No, this also checks if the value we read from userspace is valid.
>
> Only when the value we read from userspace is -1 do we set
> numa_node_id(), otherwise we take the value as read, which then must be
> a valid value.

Right, but:

	if (node == -1) {
		node = numa_node_id();
		if (futex_put_value(node, naddr, flags))
			return -EFAULT;
	} else if (node >= MAX_NUMNODES || !node_possible(node)) {
		return -EINVAL;
        }

makes it clear that the path where @node read from user space is != -1
needs to be validated, while your version checks the result of

      node = numa_node_id();

too, which does not make sense to me. Yes, it works, but ...

Thanks,

        tglx

