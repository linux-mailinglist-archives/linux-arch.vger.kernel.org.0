Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA3769FF7
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 20:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGaSDi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaSDh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 14:03:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC9E4E;
        Mon, 31 Jul 2023 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b6B0HYLtewPCtZDDCJN1W60jRqsHU7Vz+hikYlsFepk=; b=LDp2D+a/MfR8lAfnFHyEg+mUr/
        xb62Gcg8pWH0vgh9mpgWeSx5CU331hvlCcVOaPnUFxDYwOvYdStT2E6Yt5YSdDGdIL5l5kJOBcwxF
        6/7KvPdY9qjKUlIV8B7y2z8MUWHAMT9km+Pw8vRvB5OxmFwNnCXxCqlMcQFTKN9eJhPDAvYuSknBq
        GrisXn87vqQcxfQ1Oj0kjXT5xa1f/LD1UtlEhydVDEZd39dtqKIN7U2/3jt7cypLEvUjFQ3nv1XEl
        slZBt7y/iPYk3x/+mBXzVWQrhI31I8FXkI1DwYq1xnMWbmX+X8lFFK47ptN74E3L5sIZsySQsDbXn
        KDGjf81w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQXEn-00CzRm-0i;
        Mon, 31 Jul 2023 18:03:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4E333002CE;
        Mon, 31 Jul 2023 20:03:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88956203C242E; Mon, 31 Jul 2023 20:03:20 +0200 (CEST)
Date:   Mon, 31 Jul 2023 20:03:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
Message-ID: <20230731180320.GR29590@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.434742902@infradead.org>
 <87pm48m19m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm48m19m.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 07:36:21PM +0200, Thomas Gleixner wrote:
> On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> >  struct futex_hash_bucket *futex_hash(union futex_key *key)
> >  {
> > -	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
> > +	u32 hash = jhash2((u32 *)key,
> > +			  offsetof(typeof(*key), both.offset) / sizeof(u32),
> >  			  key->both.offset);
> > +	int node = key->both.node;
> >  
> > -	return &futex_queues[hash & (futex_hashsize - 1)];
> > +	if (node == -1) {
> > +		/*
> > +		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
> > +		 * node -- this ensures regular futexes are interleaved across
> > +		 * the nodes and avoids having to allocate multiple
> > +		 * hash-tables.
> > +		 *
> > +		 * NOTE: this isn't perfectly uniform, but it is fast and
> > +		 * handles sparse node masks.
> > +		 */
> > +		node = (hash >> futex_hashshift) % nr_node_ids;
> 
> Is nr_node_ids guaranteed to be stable after init? It's marked
> __read_mostly, but not __ro_after_init.

AFAICT it is only ever written to in setup_nr_node_ids() and that is all
__init code. So I'm thinking this could/should indeed be
__ro_after_init. Esp. so since it is an exported variable.

Mike?

> > +		if (!node_possible(node)) {
> > +			node = find_next_bit_wrap(node_possible_map.bits,
> > +						  nr_node_ids, node);
> > +		}
> > +	}
> > +
> > +	return &futex_queues[node][hash & (futex_hashsize - 1)];
> >  }
> >  	fshared = flags & FLAGS_SHARED;
> > +	size = futex_size(flags);
> >  
> >  	/*
> >  	 * The futex address must be "naturally" aligned.
> >  	 */
> >  	key->both.offset = address % PAGE_SIZE;
> > -	if (unlikely((address % sizeof(u32)) != 0))
> > +	if (unlikely((address % size) != 0))
> >  		return -EINVAL;
> 
> Hmm. Shouldn't that have changed with the allowance of the 1 and 2 byte
> futexes?

That patches comes after this.. :-)

But I do have an open question here; do we want FUTEX2_NUMA futexes
aligned at futex_size or double that? That is, what do we want the
alignment of:

struct futex_numa_32 {
	u32 val;
	u32 node;
};

to be? Having that u64 aligned will guarantee these two values end up in
the same page, having them u32 aligned (as per this patch) allows for
them to be split.

The current paths don't care, we don't hold locks, but perhaps it makes
sense to be conservative.

> >  	address -= key->both.offset;
> >  
> > -	if (unlikely(!access_ok(uaddr, sizeof(u32))))
> > +	if (flags & FLAGS_NUMA)
> > +		size *= 2;
> > +
> > +	if (unlikely(!access_ok(uaddr, size)))
> >  		return -EFAULT;
> >  
> >  	if (unlikely(should_fail_futex(fshared)))
> >  		return -EFAULT;
> >  
> > +	key->both.node = -1;
> 
> Please put this into an else path.

Can do, but I figured the compiler could figure it out through dead
store elimitation or somesuch pass.

> > +	if (flags & FLAGS_NUMA) {
> > +		void __user *naddr = uaddr + size/2;
> 
> size / 2;
> 
> > +
> > +		if (futex_get_value(&node, naddr, flags))
> > +			return -EFAULT;
> > +
> > +		if (node == -1) {
> > +			node = numa_node_id();
> > +			if (futex_put_value(node, naddr, flags))
> > +				return -EFAULT;
> > +		}
> > +
> > +		if (node >= MAX_NUMNODES || !node_possible(node))
> > +			return -EINVAL;
> 
> That's clearly an else path too. No point in checking whether
> numa_node_id() is valid.

No, this also checks if the value we read from userspace is valid.

Only when the value we read from userspace is -1 do we set
numa_node_id(), otherwise we take the value as read, which then must be
a valid value.

> > +		key->both.node = node;
> > +	}
> >  
> > +static inline unsigned int futex_size(unsigned int flags)
> > +{
> > +	unsigned int size = flags & FLAGS_SIZE_MASK;
> > +	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
> > +}
> > +
> >  static inline bool futex_flags_valid(unsigned int flags)
> >  {
> >  	/* Only 64bit futexes for 64bit code */
> > @@ -77,13 +83,19 @@ static inline bool futex_flags_valid(uns
> >  	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
> >  		return false;
> >  
> > -	return true;
> > -}
> > +	/*
> > +	 * Must be able to represent both NUMA_NO_NODE and every valid nodeid
> > +	 * in a futex word.
> > +	 */
> > +	if (flags & FLAGS_NUMA) {
> > +		int bits = 8 * futex_size(flags);
> > +		u64 max = ~0ULL;
> > +		max >>= 64 - bits;
> Your newline key is broken, right?





Yes :-)

> > +		if (nr_node_ids >= max)
> > +			return false;
> > +	}
