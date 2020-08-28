Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F96255CF5
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgH1OrS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:47:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49850 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727997AbgH1OrI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 10:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598626027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yquFv2yqai6ihVfcrAy9lCsY5CSLZWt8RXJdzk2IKIU=;
        b=CS5SBrTt12HeCI6ecxF/OCx4X1VeO9X22vNn07Rnqsu2O24Iqchacp7vTF57BhQuMCzzx2
        tmBLTNV5FhfY8O58r2p7N+nGSO/yw63wMaC2kdqGtwN2ByaCNH9J0dEC07w52tYM2i6kN0
        a8q4VHrtRSPLkKW4eUyn6vZvNGnRGko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-W2fevorKPdWPX7Px-cRH0w-1; Fri, 28 Aug 2020 10:47:02 -0400
X-MC-Unique: W2fevorKPdWPX7Px-cRH0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2E2A100CF7D;
        Fri, 28 Aug 2020 14:47:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4766F6716C;
        Fri, 28 Aug 2020 14:46:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 28 Aug 2020 16:47:00 +0200 (CEST)
Date:   Fri, 28 Aug 2020 16:46:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
Message-ID: <20200828144650.GF28468@redhat.com>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.535381269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827161754.535381269@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/27, Peter Zijlstra wrote:
>
>  1 file changed, 129 insertions(+)

129 lines! And I spent more than 2 hours trying to understand these
129 lines ;) looks correct...

However, I still can't understand the usage of _acquire/release ops
in this code.

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

OK, these 2 _release above look understandable, they pair with
atomic_try_cmpxchg_acquire/try_cmpxchg_acquire in freelist_try_get().

> +			/*
> +			 * Hmm, the add failed, but we can only try again when
> +			 * the refcount goes back to zero.
> +			 */
> +			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
> +				continue;

Do we really need _release ? Why can't atomic_fetch_add_relaxed() work?

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

Do we the barriers implied by _fetch_? Why can't atomic_sub(2, refs) work?

> +		/*
> +		 * OK, the head must have changed on us, but we still need to decrement
> +		 * the refcount we increased.
> +		 */
> +		refs = atomic_fetch_add(-1, &prev->refs);

Cosmetic, but why not atomic_fetch_dec() ?

Oleg.

