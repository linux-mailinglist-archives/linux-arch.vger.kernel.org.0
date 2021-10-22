Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479014379CD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhJVP0n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhJVP0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:26:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0416C061766;
        Fri, 22 Oct 2021 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WoE97t/zQUrXsz62gIwM8CUrTYMzo/mNJAYUe3nFHGQ=; b=nCh0Yw9HOyGXMCKz7dBw1hMYTJ
        yk2yQuJv8wJXTjfuTsvY+2ChYe+AhbHQdU0kS1R6sboCYOuG+OyRi9sjEqY1m1a04mmWnikfT5gXx
        cSYRr4dgQjrKjy6nTpi2R3+gLFuTivZyTVQ40rtJy3XShfxniN/cFQKEBgfALQXG+TXRDde4NBwX4
        xLZT/MY78h1Qv960b6YiLn9MuzuUIYeY3rlTK4d9x2UDfpGj9t/yAQ6bB9K4zp1dUNaXmfboJhsyn
        jDH7AjWR/79yN3oqYhkVnSYQlzHcuAKnetEDEemHzujBf/oTRLtxp8OViORzN3FV4TtwjPzhs5P5M
        gGAjmYwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00BbM0-58; Fri, 22 Oct 2021 15:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76E383002BC;
        Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5CC4C2C0CA17C; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022150933.883959987@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 0/7] arch: More wchan fixes
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Respin of the rest of the get_wchan() rework [1]. Given the many problems with
STACKTRACE this series focuses on the newer ARCH_STACKWALK since that's a
smaller set of architectures to review with a better specified interface.

The idea is to piece-wise convert the rest of the architectures to
ARCH_STACKWALK, but that can be done at leasure.

PowerPC and ARM64 are a bit funny in that their __switch_to() is in C and ends
up on the stack. For now simply mark it __sched to make it work. Mark wanted to
maybe do something different, but I think this ought to get us started.


