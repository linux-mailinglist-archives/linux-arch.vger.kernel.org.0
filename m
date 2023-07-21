Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520C875C6BC
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGUMRG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjGUMRF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 08:17:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61D30C7;
        Fri, 21 Jul 2023 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5PS40R3k/WtSAiwAETN7aeanCVo4MyLNg3uSnAAedI8=; b=TxOHpAHGpLJBGmu1TgPgQJ9djs
        tkakXwliMQBgD/Q/rGnbZliHw3eGXj5g93St8GOHjJ31j01BaRvXkzFgqwWV6/zUoXNE3CqSeFIVc
        DrPQSnG1YaZFPs5Nb3wNJK/c0X2PuwDaMB71nsTM5oUCXPdGeQsLtRArqGumtJ6/TCCnH2ei7M11o
        T2TXNRrKfFsKkE1th0kXHKusb8xABSQQTw83t0cBa8z7DKfTA97nPw1lbOlXbjKMUedAPULZ4UNok
        y5jsWckcBkqN8wfJ6yyelWqsMnJtUZRIxecbV2jCkSZhbnLuULmlp8MoHSFgKjdr8fsCIOG7+4J7W
        GZhqVS6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMp3o-0016AW-Oi; Fri, 21 Jul 2023 12:16:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF9E73001E7;
        Fri, 21 Jul 2023 14:16:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B4C0264557F8; Fri, 21 Jul 2023 14:16:38 +0200 (CEST)
Date:   Fri, 21 Jul 2023 14:16:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
Message-ID: <20230721121638.GH3630545@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.434742902@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721105744.434742902@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 12:22:48PM +0200, Peter Zijlstra wrote:
> @@ -217,32 +259,55 @@ static u64 get_inode_sequence_number(str
>   *
>   * lock_page() might sleep, the caller should not hold a spinlock.
>   */
> -int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
> +int get_futex_key(void __user *uaddr, unsigned int flags, union futex_key *key,
>  		  enum futex_access rw)
>  {
>  	unsigned long address = (unsigned long)uaddr;
>  	struct mm_struct *mm = current->mm;
>  	struct page *page, *tail;
>  	struct address_space *mapping;
> +	int node, err, size, ro = 0;
>  	bool fshared;
>  
>  	fshared = flags & FLAGS_SHARED;
> +	size = futex_size(flags);
>  
>  	/*
>  	 * The futex address must be "naturally" aligned.
>  	 */
>  	key->both.offset = address % PAGE_SIZE;
> +	if (unlikely((address % size) != 0))
>  		return -EINVAL;

This enforces u32 alignment for:

struct futex_numa_32 {
	u32 val;
	u32 node;
};

Or do we want to enfore u64 alignment for that?

>  	address -= key->both.offset;
>  
> +	if (flags & FLAGS_NUMA)
> +		size *= 2;
> +
> +	if (unlikely(!access_ok(uaddr, size)))
>  		return -EFAULT;
