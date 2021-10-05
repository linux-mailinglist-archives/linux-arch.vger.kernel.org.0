Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA37422B28
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhJEOjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhJEOjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 10:39:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDCC061749;
        Tue,  5 Oct 2021 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NXVT547q11vxBmN0JnCHuyJ+/+kUBjr0nC1nL/Y5gs8=; b=mP1JnpeUdMoGUG0of2rU8oOvaR
        n7csvi9rY8/SEFwTuD6fzd+RSWW8AjhudXBQEJl2V5sOSMGFsjQbWG/AH5UhHDHKEuXfglXOGm25M
        JgVLJRTXxeg/i3Gq7waOsj2cBgOS3kPVMTolADirJaGu8H0NCsnkgZtZ7+Mf5WKWa/8kRTyIUFUBI
        q8PL3uMiyVJJmGBXP7KUAhgouW2MeZzn4zZny0oK8FZ18stFi47qmgU3NROIBuavFPsqzM/F+bNuZ
        xmAPZ5YvZqGVFtxTLfqX9PFJdQW9XVgPe1GCuqvR59RoAecUagUq6sUF1/NG3yy8HzY6st8oSDua+
        Njbx8NBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXlZI-00846d-FS; Tue, 05 Oct 2021 14:37:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DD7930019C;
        Tue,  5 Oct 2021 16:37:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D60D2038E211; Tue,  5 Oct 2021 16:37:19 +0200 (CEST)
Date:   Tue, 5 Oct 2021 16:37:19 +0200
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
Subject: Re: [PATCH -rcu/kcsan 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
Message-ID: <YVxjH2AtjvB8BDMD@hirez.programming.kicks-ass.net>
References: <20211005105905.1994700-1-elver@google.com>
 <20211005105905.1994700-24-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005105905.1994700-24-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 05, 2021 at 12:59:05PM +0200, Marco Elver wrote:
> Teach objtool to turn instrumentation required for memory barrier
> modeling into nops in noinstr text.
> 
> The __tsan_func_entry/exit calls are still emitted by compilers even
> with the __no_sanitize_thread attribute. The memory barrier
> instrumentation will be inserted explicitly (without compiler help), and
> thus needs to also explicitly be removed.

How is arm64 and others using kernel/entry + noinstr going to fix this?

ISTR they fully rely on the compilers not emitting instrumentation,
since they don't have objtool to fix up stray issues like this.
