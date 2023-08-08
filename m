Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F4773F85
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjHHQtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHHQsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 12:48:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D5316AFC;
        Tue,  8 Aug 2023 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g8FIh3x2zNUP0yYP7PB1u90fbVokcWFuUWdhtukLqsk=; b=RH6PXCq/xfGf7RhCXgKdGsbR4X
        e3Fja+sKYDNhIrFIXlx80hY5riayoG7Sluxx5F9phC+DfSgnYp1ZWYAdSTnGe2VtXky6T38nhySLN
        sueBnp9LTVvPh4+sD2kJSvC61885sATFW5M7vgFxFElL2+B/Z0pU6e0BgH4xNCOCgCWmvQsyLjdA+
        gOlv8XnyEtNo3tA5/u3x6GjRCKKJi9eGpDwHs4HgyDFPEsoRrG5YSbZwDLtwrkziFcge98gbUGZ6W
        UJMenmKClJd1IwB9QsXyIfQWM3cVV+RVhJku/nZtgKTesO98Vt5OYfvhhS05C9Jiho1mWtHnFudP4
        TnFOQyMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTITg-004exJ-0B;
        Tue, 08 Aug 2023 08:54:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDCC230003A;
        Tue,  8 Aug 2023 10:54:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ACF820299019; Tue,  8 Aug 2023 10:54:06 +0200 (CEST)
Date:   Tue, 8 Aug 2023 10:54:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 11/14] futex: Implement FUTEX2_NUMA
Message-ID: <20230808085406.GU212435@hirez.programming.kicks-ass.net>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.504975124@infradead.org>
 <87fs4utv6f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs4utv6f.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07, 2023 at 11:11:04PM +0200, Thomas Gleixner wrote:
> On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:
> >  /**
> >   * futex_hash - Return the hash bucket in the global hash
> >   * @key:	Pointer to the futex key for which the hash is calculated
> > @@ -114,10 +137,29 @@ late_initcall(fail_futex_debugfs);
> >   */
> >  struct futex_hash_bucket *futex_hash(union futex_key *key)
> >  {
> > -	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
> > +	u32 hash = jhash2((u32 *)key,
> > +			  offsetof(typeof(*key), both.offset) / sizeof(u32),
> >  			  key->both.offset);
> > +	int node = key->both.node;
> > +
> > +	if (node == -1) {
> 
> NUMA_NO_NODE please all over the place.

Ah, so our (futex2) ABI states this needs to be -1, but in theory
someone could come along and change the kernel internal NUMA_NO_NODE to
something else.

That is, I explicitly chose not to use it. I can of course, because as
of now these values do match.

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
> > +		if (!node_possible(node)) {
> > +			node = find_next_bit_wrap(node_possible_map.bits,
> > +						  nr_node_ids, node);
> > +		}
> 
> Smart.

Thanks :-)

> >  
> > +static inline unsigned int futex_size(unsigned int flags)
> > +{
> > +	return 1 << (flags & FLAGS_SIZE_MASK);
> > +}
> > +
> >  static inline bool futex_flags_valid(unsigned int flags)
> 
> If you reorder these two functions in the patch which introduces them,
> this diff gets readable :)

Durr, I knew I was forgetting something, will do.
