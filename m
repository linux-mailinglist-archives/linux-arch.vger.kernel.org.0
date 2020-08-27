Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB137254E00
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 21:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgH0TIM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0TIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 15:08:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D44AC061264;
        Thu, 27 Aug 2020 12:08:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z3so7026508qkz.7;
        Thu, 27 Aug 2020 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jIU7OM2BcXNMnaD5vUeqWWGQL1ghDrdUrZFcP2UE+vE=;
        b=ajwrQItSJSicaIy2VcdbUObEh6K8UYKqPTrzmbxNy/upUTCF4vUbY2u+jDjyF/y/rc
         4zjqoQCgtBofLHjdr2qTdWvl9yL4F5A/H+9JpLiexkvSg6rikEbRADST1uHe4ZWo5qaD
         t4Mdu8jW4yR2Bl52NN0Awv2JfFdBll/TuaTOtbk9lyxee4OArTJZjN5TtsNLlm2j+Bf1
         mpd+i7j63pztYO6F//fJhh8DYbH6H0TUDXOS8e/t+j0z8jDBcPai9No+7POOa1BXT4Lt
         ketM8+iGaFmeZOZKXHa8drCDnxDKBVKvqR5/entBAbF+RS132/jksiZw1cCdnnhje4tX
         zXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jIU7OM2BcXNMnaD5vUeqWWGQL1ghDrdUrZFcP2UE+vE=;
        b=jFH8LNzSo5DXXOQlu+A3cU9lytCQQRilTsy0ogp1WxOMPcD05DnEaLIQWt2Z34tC/K
         79h0dCKjKRE3bTVQx+YuetweASzO6HsRt5OsHAIjcMimnQK7FUxeT1MsOvNiNbsbwMnS
         UbpEQBy+Nv3UrkejLWVCOk5+yOHqHw8cAFyDc63CWV70F6yO/Ju+bICjL0zwyCcYzqHE
         j6vo66mXCXpIbZuYUdBIOkpgi81fPQV0hcsMS+oTRmfvDrUoiEctKun3XfN9e5R1gBUo
         LNDrYeVr4cW1MZS1pJRzfhZK4DOvMLBnJMFEnEWRIIM/X7ELz6VBUgce9S6OC05eXHwg
         baHg==
X-Gm-Message-State: AOAM530SBPNZufCZguIRglWHxUCtzncqBB+nDvKucGyV9wEKgtw1Co9W
        Z9DBJh5IvYhKF8drGugY3EooFCRee54=
X-Google-Smtp-Source: ABdhPJwHs2sSdB2X3yeD6W286PihtFGchMft9n3QjgiOnCbqH6IoN0hX09BcQ1CS3HkuTTD30Vq7fA==
X-Received: by 2002:a37:b204:: with SMTP id b4mr20200766qkf.50.1598555289679;
        Thu, 27 Aug 2020 12:08:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k3sm2464720qkb.95.2020.08.27.12.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:08:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3F92E27C0054;
        Thu, 27 Aug 2020 15:08:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 27 Aug 2020 15:08:08 -0400
X-ME-Sender: <xms:lgRIX6WCnBLl-JEHYhSC3J5RofasYQ_wRugTrjo9HcYenlb1M40gcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvhedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgfehgeejueeffeelheelgeeivdeihfdtledtieduleeufffhlefhjeffgfdv
    heffnecuffhomhgrihhnpehmohhougihtggrmhgvlhdrtghomhenucfkphephedvrdduhe
    ehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lgRIX2n6FVj-KFvoV8oFTG5PxfHCN1OxWMv5uVaLj1XYNgEWVOn_Hg>
    <xmx:lgRIX-ZMgh5mhAM0oWw9imdp2lcA6x3GgDpADukx5GdFyKkO-iYW_w>
    <xmx:lgRIXxXOfKsucBA3CsHsHimF-RKm5oyuGvntE6DBYMG1rAA8gIkegA>
    <xmx:mARIX-cYTOk8EU2VYqnH1HLKcJ7edUBaaev0CpNqJpE4rmycLqHZ-tqqysU>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 842BF30600B2;
        Thu, 27 Aug 2020 15:08:06 -0400 (EDT)
Date:   Fri, 28 Aug 2020 03:08:04 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
Message-ID: <20200827190804.GA128237@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.535381269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827161754.535381269@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 06:12:43PM +0200, Peter Zijlstra wrote:
> 
> 
> Cc: cameron@moodycamel.com
> Cc: oleg@redhat.com
> Cc: will@kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/freelist.h |  129 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> --- /dev/null
> +++ b/include/linux/freelist.h
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +#ifndef FREELIST_H
> +#define FREELIST_H
> +
> +#include <linux/atomic.h>
> +
> +/*
> + * Copyright: cameron@moodycamel.com
> + *
> + * A simple CAS-based lock-free free list. Not the fastest thing in the world
> + * under heavy contention, but simple and correct (assuming nodes are never
> + * freed until after the free list is destroyed), and fairly speedy under low
> + * contention.
> + *
> + * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
> + */
> +
> +struct freelist_node {
> +	atomic_t		refs;
> +	struct freelist_node	*next;
> +};
> +
> +struct freelist_head {
> +	struct freelist_node	*head;
> +};
> +
> +#define REFS_ON_FREELIST 0x80000000
> +#define REFS_MASK	 0x7FFFFFFF
> +
> +static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
> +{
> +	/*
> +	 * Since the refcount is zero, and nobody can increase it once it's
> +	 * zero (except us, and we run only one copy of this method per node at
> +	 * a time, i.e. the single thread case), then we know we can safely
> +	 * change the next pointer of the node; however, once the refcount is
> +	 * back above zero, then other threads could increase it (happens under
> +	 * heavy contention, when the refcount goes to zero in between a load
> +	 * and a refcount increment of a node in try_get, then back up to
> +	 * something non-zero, then the refcount increment is done by the other
> +	 * thread) -- so if the CAS to add the node to the actual list fails,
> +	 * decrese the refcount and leave the add operation to the next thread
> +	 * who puts the refcount back to zero (which could be us, hence the
> +	 * loop).
> +	 */
> +	struct freelist_node *head = READ_ONCE(list->head);
> +
> +	for (;;) {
> +		WRITE_ONCE(node->next, head);
> +		atomic_set_release(&node->refs, 1);
> +
> +		if (!try_cmpxchg_release(&list->head, &head, node)) {
> +			/*
> +			 * Hmm, the add failed, but we can only try again when
> +			 * the refcount goes back to zero.
> +			 */
> +			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
> +				continue;
> +		}
> +		return;
> +	}
> +}
> +
> +static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
> +{
> +	/*
> +	 * We know that the should-be-on-freelist bit is 0 at this point, so
> +	 * it's safe to set it using a fetch_add.
> +	 */
> +	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
> +		/*
> +		 * Oh look! We were the last ones referencing this node, and we
> +		 * know we want to add it to the free list, so let's do it!
> +		 */
> +		__freelist_add(node, list);
> +	}
> +}
> +
> +static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
> +{
> +	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
> +	unsigned int refs;
> +
> +	while (head) {
> +		prev = head;
> +		refs = atomic_read(&head->refs);
> +		if ((refs & REFS_MASK) == 0 ||
> +		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
> +			head = smp_load_acquire(&list->head);
> +			continue;
> +		}
> +
> +		/*
> +		 * Good, reference count has been incremented (it wasn't at
> +		 * zero), which means we can read the next and not worry about
> +		 * it changing between now and the time we do the CAS.
> +		 */
> +		next = READ_ONCE(head->next);
> +		if (try_cmpxchg_acquire(&list->head, &head, next)) {

So if try_cmpxchg_acquire() fails, we don't have ACQUIRE semantics on
read of the new list->head, right? Then probably a
smp_mb__after_atomic() is needed in that case?

Regards,
Boqun

> +			/*
> +			 * Yay, got the node. This means it was on the list,
> +			 * which means should-be-on-freelist must be false no
> +			 * matter the refcount (because nobody else knows it's
> +			 * been taken off yet, it can't have been put back on).
> +			 */
> +			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
> +
> +			/*
> +			 * Decrease refcount twice, once for our ref, and once
> +			 * for the list's ref.
> +			 */
> +			atomic_fetch_add(-2, &head->refs);
> +
> +			return head;
> +		}
> +
> +		/*
> +		 * OK, the head must have changed on us, but we still need to decrement
> +		 * the refcount we increased.
> +		 */
> +		refs = atomic_fetch_add(-1, &prev->refs);
> +		if (refs == REFS_ON_FREELIST + 1)
> +			__freelist_add(prev, list);
> +	}
> +
> +	return NULL;
> +}
> +
> +#endif /* FREELIST_H */
> 
> 
