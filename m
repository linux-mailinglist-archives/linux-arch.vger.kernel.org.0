Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8367638FB65
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEYHJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 03:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEYHJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 May 2021 03:09:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EFAC061574;
        Tue, 25 May 2021 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DoIbSCZTbEoN70AvyZhpVM+9DseLPlFDyKptyhG0ieA=; b=AILSOYTr/eYzC8gkl6dwpUFWua
        xH/saKYH8uSCGZYaC1kybPIRbisbATdGGSrIxuUlEQ6mxr8bvChEkJIqlFKkSjmDQXhgc1JLtde+/
        FgPSiwfAzlIhulNAhGpKp4VCSmvL5rhHERaiBJ1TjxMkL3tjvsImj30DHrzS/o9Wd91W4W6s9w5QT
        QtUvd1qz+JRvwUjn5ebT/xm8JMWp1qp9vaTKZMEs3Zdvl3g7JWnwywU/EV277SMUlr8O9oWSOpXx4
        U+clAnJVrLFA6vACuUDvRpic4nzVWGVQbR78HxhZpsQ6klC+nR38PY00J8s5mczvwfAYP+7qwtaxA
        PL0qkh/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llR9v-003DP1-64; Tue, 25 May 2021 07:07:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BE653001E4;
        Tue, 25 May 2021 09:07:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 363C131474564; Tue, 25 May 2021 09:07:22 +0200 (CEST)
Date:   Tue, 25 May 2021 09:07:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Julian Braha <julianbraha@gmail.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Message-ID: <YKyiKk6CAHq0+D9a@hirez.programming.kicks-ass.net>
References: <20210524224150.8009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524224150.8009-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 03:41:50PM -0700, Randy Dunlap wrote:
> Some arches (um, sparc64, riscv, xtensa) cause a Kconfig warning for
> LOCKDEP.
> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
> of the arch-es that LOCKDEP depends on.
> 
> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
> intend to have LOCKDEP support, replace the awkward list of
> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
> 
> But wait. LOCKDEP_SUPPORT is included in LOCK_DEBUGGING_SUPPORT,
> which is already a dependency here, so LOCKDEP_SUPPORT is redundant
> and not needed.
> That leaves the FRAME_POINTER dependency, but it is part of an
> expression like this:
> 	depends on (A && B) && (FRAME_POINTER || B')
> where B' is a dependency of B so if B is true then B' is true
> and the value of FRAME_POINTER does not matter.
> Thus we can also delete the FRAME_POINTER dependency.
> 
> Fixes this kconfig warning: (for um, sparc64, riscv, xtensa)
> 
> WARNING: unmet direct dependencies detected for LOCKDEP
>   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>   Selected by [y]:
>   - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>   - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>   - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
> 
> Link to v1: https://lore.kernel.org/lkml/20210517034430.9569-1-rdunlap@infradead.org/
> 
> Fixes: 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!
