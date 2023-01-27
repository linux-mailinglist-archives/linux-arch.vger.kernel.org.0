Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF167E30E
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 12:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjA0LT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 06:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjA0LTH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 06:19:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4017B41C;
        Fri, 27 Jan 2023 03:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+vh2VCOMQNZi5YUjJBtgo0UKA0B0k44FLMIWCTzBJkI=; b=GvGYAFqFQ4xpLntxwky6t8qGA7
        fkAoXny1HmpY8vi1avgaoBv4Or6zGF/bu8iI/wuT/mIZ0swdbHpPiFXu/scKmbJUaW1eZSCxCYYsU
        hMVsXd3acAQBmbBMwIzaLi7y8Gjxz/bacJXvzxekBmNj+s3JgJ2pTtaGqyPdMnfpcKIKlOVesTQtk
        gftQH4KKaE/VtxNf3qSishDhyxPwgvkOEveZp7p6/jLAFWLvYniLhcn091QPm352PO3gifANtMyBF
        dAucGgtXEOD6Ja3vIDztOAI2SAQtBgQSGLfbohwQfU0qQ/MWXQfMQNWuEMFVrwy2GhJzRsyJsSj7o
        Adq/14Ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pLMjo-002lGU-0g;
        Fri, 27 Jan 2023 11:17:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9948300388;
        Fri, 27 Jan 2023 12:18:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8811720F454FF; Fri, 27 Jan 2023 12:18:13 +0100 (CET)
Date:   Fri, 27 Jan 2023 12:18:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
Message-ID: <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126173354.13250-1-jmaselbas@kalray.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 06:33:54PM +0100, Jules Maselbas wrote:

> @@ -58,9 +61,11 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
>  static inline void generic_atomic_##op(int i, atomic_t *v)		\
>  {									\
>  	unsigned long flags;						\
> +	int c;								\
>  									\
>  	raw_local_irq_save(flags);					\
> -	v->counter = v->counter c_op i;					\
> +	c = arch_atomic_read(v);					\
> +	arch_atomic_set(v, c c_op i);					\
>  	raw_local_irq_restore(flags);					\
>  }

This and the others like it are a bit sad, it explicitly dis-allows the
compiler from using memops and forces a load-store.

The alternative is writing it like:

	*(volatile int *)&v->counter c_op i;

but that's pretty shit too I suppose.


