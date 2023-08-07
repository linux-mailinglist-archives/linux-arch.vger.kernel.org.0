Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E737730EA
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 23:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHGVLI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGVLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 17:11:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB7E5B;
        Mon,  7 Aug 2023 14:11:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691442664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aftKb27pM5tJulfOGPsmsFua08eUVg+LfRzeaWEUurY=;
        b=zPB+YRQ9l7XgX0zdA4BtF3llHrC3biczwyGskGKJdiqzkgZLxWshbAW47s97HF2pLnh9b3
        z4MyAzJ8l+i4qBIkOYif2UCfTdoMp0/KDDbRBSV+lNOoBbE5uY9YNZm83X9RerFwMag8iZ
        xXNeZWGmvgTMGOHp2NpYuWYoFcrj5lRd+r198ecXxYtvCakUgtEZk5ROPTEiMvrZcEwVpx
        o/eDyRcHljbAp/bD04TggVEI5sSL667RuWFPxYDm3uPDkq7ezoqYWSWJNwo3E9plOSAZhl
        oh50k6C5VGerDjI3g42B9F7thMeOV9M+7n93pdUQI1LJE1iaWvprH36DQp6n8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691442664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aftKb27pM5tJulfOGPsmsFua08eUVg+LfRzeaWEUurY=;
        b=DGXhuQ8cNuQ5DS01SQIJ7A7DgvihZXcdIY6FEB4XnsTizUnVcq8XSHE8FYozz7HCRqDBPo
        4QUt3edzqA3XwGAA==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20230807123323.504975124@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.504975124@infradead.org>
Date:   Mon, 07 Aug 2023 23:11:04 +0200
Message-ID: <87fs4utv6f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:
>  /**
>   * futex_hash - Return the hash bucket in the global hash
>   * @key:	Pointer to the futex key for which the hash is calculated
> @@ -114,10 +137,29 @@ late_initcall(fail_futex_debugfs);
>   */
>  struct futex_hash_bucket *futex_hash(union futex_key *key)
>  {
> -	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
> +	u32 hash = jhash2((u32 *)key,
> +			  offsetof(typeof(*key), both.offset) / sizeof(u32),
>  			  key->both.offset);
> +	int node = key->both.node;
> +
> +	if (node == -1) {

NUMA_NO_NODE please all over the place.

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
> +		if (!node_possible(node)) {
> +			node = find_next_bit_wrap(node_possible_map.bits,
> +						  nr_node_ids, node);
> +		}

Smart.

>  
> +static inline unsigned int futex_size(unsigned int flags)
> +{
> +	return 1 << (flags & FLAGS_SIZE_MASK);
> +}
> +
>  static inline bool futex_flags_valid(unsigned int flags)

If you reorder these two functions in the patch which introduces them,
this diff gets readable :)

Aside of that this thing is really hard to review :)
