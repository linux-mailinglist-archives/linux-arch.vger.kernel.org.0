Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1682D422718
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhJEMzE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhJEMzD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 08:55:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2DC061749;
        Tue,  5 Oct 2021 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3mL4e6pocxVR5OsISP9dNIeRYN7ixRmDV8QCVBso/L0=; b=mgxTuiy9hW/M1nl8BaIQ6Qvws0
        YMpUaUgLvtSSiyL3eQUj+/XylScDbvdNDuIA6xONAnbVYTxIRsjjDzurhwBABzA1M9hUAtvUKgIwQ
        YcLZf8yv9NcBiiS8MOkrYsKxYk5Hj2ugMGnp8+yUGSmRXx24CKa2hVWDs+F3udLOJpWH7ZVnqpXmb
        8Inzuyu1FoOPkk+acWPg9ew+lmG1lRGkh1MTUY+FnEbTroysx3/vRDVw7Wh76x1AsvD6qhkQA1dJo
        TWa0NrBb+CKV+l+IZXnJSkMUsXTv+cs4Se6IWsMVeRpQS3HQ+T1eIjYM1O8s+MlAsApC8j1meHlL0
        gJrLZP4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXjwF-0083AP-Q5; Tue, 05 Oct 2021 12:52:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25C0130019C;
        Tue,  5 Oct 2021 14:52:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 134AD2026A8AF; Tue,  5 Oct 2021 14:52:54 +0200 (CEST)
Date:   Tue, 5 Oct 2021 14:52:54 +0200
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
Subject: Re: [PATCH -rcu/kcsan 04/23] kcsan: Add core support for a subset of
 weak memory modeling
Message-ID: <YVxKplLAMJJUlg/w@hirez.programming.kicks-ass.net>
References: <20211005105905.1994700-1-elver@google.com>
 <20211005105905.1994700-5-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005105905.1994700-5-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 05, 2021 at 12:58:46PM +0200, Marco Elver wrote:
> +#if !defined(CONFIG_ARCH_WANTS_NO_INSTR) || defined(CONFIG_STACK_VALIDATION)
> +/*
> + * Arch does not rely on noinstr, or objtool will remove memory barrier
> + * instrumentation, and no instrumentation of noinstr code is expected.
> + */
> +#define kcsan_noinstr

I think this still wants to be at the very least:

#define kcsan_noinstr noinline notrace

without noinline it is possible LTO (or similarly daft things) will end
up inlining the calls, and since we rely on objtool to NOP out CALLs
this must not happen.

And since you want to mark these functions as uaccess_safe, there must
not be any tracing on, hence notrace.

> +static inline bool within_noinstr(unsigned long ip) { return false; }
> +#else
> +#define kcsan_noinstr noinstr
> +static __always_inline bool within_noinstr(unsigned long ip)
> +{
> +	return (unsigned long)__noinstr_text_start <= ip &&
> +	       ip < (unsigned long)__noinstr_text_end;
> +}
> +#endif
