Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2724B422593
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhJELr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhJELrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:47:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F544C061749;
        Tue,  5 Oct 2021 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ffKpkAKU6pM8rv8h0B9+33I0DIIEdsYkyFi/KKBw/n4=; b=QwhZudjTLBG5nEAkb328sCh1aC
        62/JNAedSpu4Qut6TyMZcJ898Y3DXPP4LNIj+gM7jtgaMVxBfjPGp86OmO1tc8WGBv1j9J5PlL2uX
        WojOanTqeqJreTOaVIi2Dhhb8IqdFsnG4/cWBZounxROwWtOj1PEOrpNGjDDI5XfjWjtRQhXban1z
        csGWJ7AT6EhvkR1xcCqQKhtMewKVKy4ReI6O8HC8MEkuCCdPlA7y6QN/jwBwfhh7UGtHbQXTIov1t
        xCopFaLHP5Qwm+AJh9vLQ+rSVoVqKTwFM177Yc4pe97YTC0SBJObSJm8glMXLT4ZYcm5+HjDCiD4Q
        iwQEbJ2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXiox-000MNr-Vi; Tue, 05 Oct 2021 11:41:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 622C630026F;
        Tue,  5 Oct 2021 13:41:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 452272038E207; Tue,  5 Oct 2021 13:41:18 +0200 (CEST)
Date:   Tue, 5 Oct 2021 13:41:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH -rcu/kcsan 05/23] kcsan: Add core memory barrier
 instrumentation functions
Message-ID: <YVw53mP3VkWyCzxn@hirez.programming.kicks-ass.net>
References: <20211005105905.1994700-1-elver@google.com>
 <20211005105905.1994700-6-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005105905.1994700-6-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 05, 2021 at 12:58:47PM +0200, Marco Elver wrote:
> +static __always_inline void kcsan_atomic_release(int memorder)
> +{
> +	if (memorder == __ATOMIC_RELEASE ||
> +	    memorder == __ATOMIC_SEQ_CST ||
> +	    memorder == __ATOMIC_ACQ_REL)
> +		__kcsan_release();
> +}
> +
>  #define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
>  	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
>  	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
>  	{                                                                                          \
> +		kcsan_atomic_release(memorder);                                                    \
>  		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
>  			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC, _RET_IP_);    \
>  		}                                                                                  \
> @@ -1156,6 +1187,7 @@ EXPORT_SYMBOL(__tsan_init);
>  	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
>  	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
>  	{                                                                                          \
> +		kcsan_atomic_release(memorder);                                                    \
>  		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
>  			check_access(ptr, bits / BITS_PER_BYTE,                                    \
>  				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC, _RET_IP_);          \
> @@ -1168,6 +1200,7 @@ EXPORT_SYMBOL(__tsan_init);
>  	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
>  	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
>  	{                                                                                          \
> +		kcsan_atomic_release(memorder);                                                    \
>  		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
>  			check_access(ptr, bits / BITS_PER_BYTE,                                    \
>  				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> @@ -1200,6 +1233,7 @@ EXPORT_SYMBOL(__tsan_init);
>  	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
>  							      u##bits val, int mo, int fail_mo)    \
>  	{                                                                                          \
> +		kcsan_atomic_release(mo);                                                          \
>  		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
>  			check_access(ptr, bits / BITS_PER_BYTE,                                    \
>  				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> @@ -1215,6 +1249,7 @@ EXPORT_SYMBOL(__tsan_init);
>  	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
>  							   int mo, int fail_mo)                    \
>  	{                                                                                          \
> +		kcsan_atomic_release(mo);                                                          \
>  		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
>  			check_access(ptr, bits / BITS_PER_BYTE,                                    \
>  				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> @@ -1246,6 +1281,7 @@ DEFINE_TSAN_ATOMIC_OPS(64);
>  void __tsan_atomic_thread_fence(int memorder);
>  void __tsan_atomic_thread_fence(int memorder)
>  {
> +	kcsan_atomic_release(memorder);
>  	__atomic_thread_fence(memorder);
>  }
>  EXPORT_SYMBOL(__tsan_atomic_thread_fence);

I find that very hard to read.. kcsan_atomic_release() it not in fact a
release. It might be a release if @memorder implies one.
