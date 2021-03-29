Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADE34C53F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhC2Hu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhC2Huv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 03:50:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725BC061574;
        Mon, 29 Mar 2021 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RmtQjdY4jd7gdJlUZ3DW9jMcByENp8YMhL3jjISCf78=; b=nnsLTgcvgCRg3B8Fc0hgEyHVPa
        C3nz4ZoUQzUhylNi2HcH7gsoEOw0NP02VuD30ri51IFNz7TdHeT8fI856Z12noRCm6mDLZxDe54GG
        FcuZUNJLbDaeFENhAjbP8BsnJcQxz0D3Ue2kBv545ZemDljZy0HQZtA+o4hJkFkYyfG0vnwykvY0h
        UxSf6d+v1U+TfhvAocF63PQOzKYT4rXagudr+KYPJZSJCheIDn2HB6KLENrteYmJE5xFcHxximPDJ
        7YXs4t4aupq1wyuYM18uogTbiu005muh7DV+DWqh4GYKLgujOwVzYt4diS5ecQ/MkhQ7EDTR8mdUF
        6CmPI6cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQmew-001CUv-Cc; Mon, 29 Mar 2021 07:50:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 836C5305CC3;
        Mon, 29 Mar 2021 09:50:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62B48207189A5; Mon, 29 Mar 2021 09:50:01 +0200 (CEST)
Date:   Mon, 29 Mar 2021 09:50:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616868399-82848-4-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Some architectures don't have sub-word swap atomic instruction,
> they only have the full word's one.
> 
> The sub-word swap only improve the performance when:
> NR_CPUS < 16K
>  *  0- 7: locked byte
>  *     8: pending
>  *  9-15: not used
>  * 16-17: tail index
>  * 18-31: tail cpu (+1)
> 
> The 9-15 bits are wasted to use xchg16 in xchg_tail.
> 
> Please let architecture select xchg16/xchg32 to implement
> xchg_tail.

So I really don't like this, this pushes complexity into the generic
code for something that's really not needed.

Lots of RISC already implement sub-word atomics using word ll/sc.
Obviously they're not sharing code like they should be :/ See for
example arch/mips/kernel/cmpxchg.c.

Also, I really do think doing ticket locks first is a far more sensible
step.
