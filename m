Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345294C8757
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 10:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiCAJGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 04:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCAJGT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 04:06:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9E88B1F;
        Tue,  1 Mar 2022 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ypFVgiobg8wO+A66SFG5Fx9R9ZoG7oPUgj1Wyrv8P+k=; b=jlDbn0r2/yAl/JGPsa9Fo7fAwx
        648B6op6eIuFS8obnBy+R/ZPxwZ5Cu+uZysk57Y8WKbeAckr+bgHNRRaywV8n4fkvJleTzx1rRKMm
        zgS1q8SRIJXg46/GFkJU8K6aEm/SGXxOvXDkPu+DUNOL4Kbw23hMVjOeY5JzluH2vMC/pWhiB4j+a
        61kzZy6CsB2Ph/vPFDrmURMSiMRjDeL7b5PXDy5dNPfQ2u6T3Lgk6g2521wMTM7oX5Z3b87S4jzKg
        Pd7nq9NeTg+8+0mx9OpVX5xxZUPUItgWqOnZJEsSWURwEjuvYT1WV8otutSpRiGgtQ2lYH1iaXNMV
        S6oOgeEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOyRW-009QMM-0l; Tue, 01 Mar 2022 09:05:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBBFD30018E;
        Tue,  1 Mar 2022 10:05:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBECD2024C933; Tue,  1 Mar 2022 10:05:12 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:05:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 3/4] locking/mutex: Pass proper call-site ip
Message-ID: <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net>
References: <20220301010412.431299-1-namhyung@kernel.org>
 <20220301010412.431299-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301010412.431299-4-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 05:04:11PM -0800, Namhyung Kim wrote:
> The __mutex_lock_slowpath() and friends are declared as noinline and
> _RET_IP_ returns its caller as mutex_lock which is not meaningful.
> Pass the ip from mutex_lock() to have actual caller info in the trace.

Blergh, can't you do a very limited unwind when you do the tracing
instead? 3 or 4 levels should be plenty fast and sufficient.
