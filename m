Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41536341054
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 23:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCRWa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhCRW36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 18:29:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A1C06174A;
        Thu, 18 Mar 2021 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cn4bXM9HxhAlrOZ3Mbplt0GOUw7Lo+j1yUk2kct+Irs=; b=tNw6kldUBrU7pqrjsLTuiJ45wH
        J5nqlqtTWC4KIeNEZkXHhn7telPcGKx2sM6vLzM9FRRkkUjUnUh7ci/PfRjLF2U5J7BdGzfEagJ3i
        re9fr2El7gw5HNl6tyYb7sz+jXmRJBfRlNTC6ruofJxKCVB91r/5bx3e/1voUzC8pyuUOdDvigLyA
        1SfSXKG5C4RyzVgUyV+QTy+3a4aTLA/8LFQ1+bpSQlPbIYwiAcHsl/wyBGaqmz7EFiYPA3a/Oot43
        XhLv2bRb9esgYJZp1Yp2glHHmY/vLgmxgE2id4a3WqU/Aqeyd6bOcjDD2JjmIBiZLdMGLnY7M7Uml
        09ZyGx3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lN18i-003Z72-Lm; Thu, 18 Mar 2021 22:29:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A1EF3006E0;
        Thu, 18 Mar 2021 23:29:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 353FC23D18406; Thu, 18 Mar 2021 23:29:11 +0100 (CET)
Date:   Thu, 18 Mar 2021 23:29:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] add support for Clang CFI
Message-ID: <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318171111.706303-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 10:10:55AM -0700, Sami Tolvanen wrote:
> +static void update_shadow(struct module *mod, unsigned long base_addr,
> +		update_shadow_fn fn)
> +{
> +	struct cfi_shadow *prev;
> +	struct cfi_shadow *next;
> +	unsigned long min_addr, max_addr;
> +
> +	next = vmalloc(SHADOW_SIZE);
> +
> +	mutex_lock(&shadow_update_lock);
> +	prev = rcu_dereference_protected(cfi_shadow,
> +					 mutex_is_locked(&shadow_update_lock));
> +
> +	if (next) {
> +		next->base = base_addr >> PAGE_SHIFT;
> +		prepare_next_shadow(prev, next);
> +
> +		min_addr = (unsigned long)mod->core_layout.base;
> +		max_addr = min_addr + mod->core_layout.text_size;
> +		fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
> +
> +		set_memory_ro((unsigned long)next, SHADOW_PAGES);
> +	}
> +
> +	rcu_assign_pointer(cfi_shadow, next);
> +	mutex_unlock(&shadow_update_lock);
> +	synchronize_rcu_expedited();

expedited is BAD(tm), why is it required and why doesn't it have a
comment?

> +
> +	if (prev) {
> +		set_memory_rw((unsigned long)prev, SHADOW_PAGES);
> +		vfree(prev);
> +	}
> +}
