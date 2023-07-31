Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C34769F8B
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGaRg0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGaRgZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:36:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33451A7;
        Mon, 31 Jul 2023 10:36:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690824982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFf50TJmeKBJp8QFVacRBeJgY/I84fMWpugiLSkN2d0=;
        b=sniaLJjU9khAD/zHKPICJex4h/W1UTe8KR4cp/RPdiVDPzRAFxo6US8Cdk2noeDT7T75WD
        xFGgh+YZpmXu+CC6kd+8wl+oqCWe+vfe5w/f8+8RDJtb9ut+PI2ZCtSZ1VHR4ZSvMMknvb
        CABTIObaYdIIbbS8TwAZ83yTuujof1JjdtF7Q8zFdVl3Bu32mOgEmhg9xoVhXFomk54AuQ
        gEQk1K3riDtf5IYeLNtUcAHDz3djZFzJFtGf/3P7Dln4zK0+fdepJEpmreCcQ+/Po50hyy
        FwZ+im0VEcR6R1j6qTkTtkvxHF0eN7N6z+HmS6FA1Erlj15b9s+P8DOSJdyQrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690824982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFf50TJmeKBJp8QFVacRBeJgY/I84fMWpugiLSkN2d0=;
        b=Cw3umMTe1MDbI7v/AYOO9l3z7Lq/XpIXoigLOz6Wy828nDvlximePUklxfgQRXPmJMrasA
        ENUcHEe3LhopAxBg==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20230721105744.434742902@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.434742902@infradead.org>
Date:   Mon, 31 Jul 2023 19:36:21 +0200
Message-ID: <87pm48m19m.ffs@tglx>
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

On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
>  struct futex_hash_bucket *futex_hash(union futex_key *key)
>  {
> -	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
> +	u32 hash = jhash2((u32 *)key,
> +			  offsetof(typeof(*key), both.offset) / sizeof(u32),
>  			  key->both.offset);
> +	int node = key->both.node;
>  
> -	return &futex_queues[hash & (futex_hashsize - 1)];
> +	if (node == -1) {
> +		/*
> +		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
> +		 * node -- this ensures regular futexes are interleaved across
> +		 * the nodes and avoids having to allocate multiple
> +		 * hash-tables.
> +		 *
> +		 * NOTE: this isn't perfectly uniform, but it is fast and
> +		 * handles sparse node masks.
> +		 */
> +		node = (hash >> futex_hashshift) % nr_node_ids;

Is nr_node_ids guaranteed to be stable after init? It's marked
__read_mostly, but not __ro_after_init.

> +		if (!node_possible(node)) {
> +			node = find_next_bit_wrap(node_possible_map.bits,
> +						  nr_node_ids, node);
> +		}
> +	}
> +
> +	return &futex_queues[node][hash & (futex_hashsize - 1)];
>  }
>  	fshared = flags & FLAGS_SHARED;
> +	size = futex_size(flags);
>  
>  	/*
>  	 * The futex address must be "naturally" aligned.
>  	 */
>  	key->both.offset = address % PAGE_SIZE;
> -	if (unlikely((address % sizeof(u32)) != 0))
> +	if (unlikely((address % size) != 0))
>  		return -EINVAL;

Hmm. Shouldn't that have changed with the allowance of the 1 and 2 byte
futexes?

>  	address -= key->both.offset;
>  
> -	if (unlikely(!access_ok(uaddr, sizeof(u32))))
> +	if (flags & FLAGS_NUMA)
> +		size *= 2;
> +
> +	if (unlikely(!access_ok(uaddr, size)))
>  		return -EFAULT;
>  
>  	if (unlikely(should_fail_futex(fshared)))
>  		return -EFAULT;
>  
> +	key->both.node = -1;

Please put this into an else path.

> +	if (flags & FLAGS_NUMA) {
> +		void __user *naddr = uaddr + size/2;

size / 2;

> +
> +		if (futex_get_value(&node, naddr, flags))
> +			return -EFAULT;
> +
> +		if (node == -1) {
> +			node = numa_node_id();
> +			if (futex_put_value(node, naddr, flags))
> +				return -EFAULT;
> +		}
> +
> +		if (node >= MAX_NUMNODES || !node_possible(node))
> +			return -EINVAL;

That's clearly an else path too. No point in checking whether
numa_node_id() is valid. 

> +		key->both.node = node;
> +	}
>  
> +static inline unsigned int futex_size(unsigned int flags)
> +{
> +	unsigned int size = flags & FLAGS_SIZE_MASK;
> +	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
> +}
> +
>  static inline bool futex_flags_valid(unsigned int flags)
>  {
>  	/* Only 64bit futexes for 64bit code */
> @@ -77,13 +83,19 @@ static inline bool futex_flags_valid(uns
>  	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
>  		return false;
>  
> -	return true;
> -}
> +	/*
> +	 * Must be able to represent both NUMA_NO_NODE and every valid nodeid
> +	 * in a futex word.
> +	 */
> +	if (flags & FLAGS_NUMA) {
> +		int bits = 8 * futex_size(flags);
> +		u64 max = ~0ULL;
> +		max >>= 64 - bits;
Your newline key is broken, right?
> +		if (nr_node_ids >= max)
> +			return false;
> +	}

Thanks,

        tglx
