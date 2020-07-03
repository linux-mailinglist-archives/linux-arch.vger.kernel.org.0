Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF32138F0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCKtw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCKtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 06:49:51 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5EBC08C5C1;
        Fri,  3 Jul 2020 03:49:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49ysDD0gdYz9sSy;
        Fri,  3 Jul 2020 20:49:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593773388;
        bh=RfcGFiZqerkVV2+Xy8mk+CmXEwgXM5XeAEZk9tVyLEo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jE5FAgWTrhkfhhz6BYzecTvfdbDagKlkEWrYP3L0gbYhUVcSmlNc1lC6f2ixexXfj
         QMnhT3le4DAgIHjrdKH22ewB074mqgaY+h4/qPtQCqXxPj1aL8oLqf9cRSSFg+ZpER
         kOBkntxdcz0tYKdN5N9tEC3tWly5GI/no1ixwSUH2ll5U30V57HbQBu863Xoilh+tH
         faLA8P2ykdWIk2tfZCnjGNmZvES09DuT2hr7WHCNOOgcbnej88JykIeo5CrGmWKVP4
         mhpmHq+ygewJ07zs3nF7tn1T8SdxHp2Y2ozRdDw+CH0ePoLytwGYkTSssCCGuyHwKH
         P9M8prScLig4Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
In-Reply-To: <1593686722.w9psaqk7yp.astroid@bobo.none>
References: <20200702074839.1057733-1-npiggin@gmail.com> <20200702074839.1057733-6-npiggin@gmail.com> <20200702080219.GB16113@willie-the-truck> <1593685459.r2tfxtfdp6.astroid@bobo.none> <20200702103506.GA16418@willie-the-truck> <1593686722.w9psaqk7yp.astroid@bobo.none>
Date:   Fri, 03 Jul 2020 20:52:02 +1000
Message-ID: <878sg07twt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Will Deacon's message of July 2, 2020 8:35 pm:
>> On Thu, Jul 02, 2020 at 08:25:43PM +1000, Nicholas Piggin wrote:
>>> Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
>>> > On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>>> >> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
>>> >> new file mode 100644
>>> >> index 000000000000..f84da77b6bb7
>>> >> --- /dev/null
>>> >> +++ b/arch/powerpc/include/asm/qspinlock.h
>>> >> @@ -0,0 +1,20 @@
>>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>>> >> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>>> >> +#define _ASM_POWERPC_QSPINLOCK_H
>>> >> +
>>> >> +#include <asm-generic/qspinlock_types.h>
>>> >> +
>>> >> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>>> >> +
>>> >> +#define smp_mb__after_spinlock()   smp_mb()
>>> >> +
>>> >> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
>>> >> +{
>>> >> +	smp_mb();
>>> >> +	return atomic_read(&lock->val);
>>> >> +}
>>> > 
>>> > Why do you need the smp_mb() here?
>>> 
>>> A long and sad tale that ends here 51d7d5205d338
>>> 
>>> Should probably at least refer to that commit from here, since this one 
>>> is not going to git blame back there. I'll add something.
>> 
>> Is this still an issue, though?
>> 
>> See 38b850a73034 (where we added a similar barrier on arm64) and then
>> c6f5d02b6a0f (where we removed it).
>> 
>
> Oh nice, I didn't know that went away. Thanks for the heads up.

Argh! I spent so much time chasing that damn bug in the ipc code.

> I'm going to say I'm too scared to remove it while changing the
> spinlock algorithm, but I'll open an issue and we should look at 
> removing it.

Sounds good.

cheers
