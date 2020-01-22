Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F098144E75
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 10:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAVJQM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 04:16:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=de9Krq9WPfYisRqIZvIrOmUj6iWBtQLyqA73nPcoF8w=; b=l9JX2nkNY2fxHyIdZU7hasx5C
        PBAR9hJawsYgfFkrmRqc/Rjh1IZYJO9JKWNA/kTgBrTBI6NJYM1mVz+5892V502NDKCzWe+a/cedz
        IgBMO7Lak5koQUkdc6XRGW+Cxgx1IFlGMhxK/BDZHDEqSp+VIgX8KoG+Q98hR69t91IxUo8mH6ICV
        QdbYVrcxHkR7rxlE9HZKz8cX2eIjfOEg1Jla68Zfw8fLDY8bhsUfe8uqKlNmrBU+fVsNKRpsWJCnC
        3VLMaxDYrVEZeFvBf9Wy6GOW/953cYk8n8ZDqUzwmfq/SUg9RjFEsy13DG2O3uC7fXfzf8eaW2eDb
        Uhla+mRVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuC73-0002ue-Uc; Wed, 22 Jan 2020 09:15:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3ADD305D3F;
        Wed, 22 Jan 2020 10:14:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E84920983E34; Wed, 22 Jan 2020 10:15:47 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:15:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v7 1/5] locking/qspinlock: Rename mcs lock/unlock macros
 and make them more generic
Message-ID: <20200122091547.GU14879@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-2-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125210709.10293-2-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 25, 2019 at 04:07:05PM -0500, Alex Kogan wrote:

> --- a/arch/arm/include/asm/mcs_spinlock.h
> +++ b/arch/arm/include/asm/mcs_spinlock.h
> @@ -6,7 +6,7 @@
>  #include <asm/spinlock.h>
>  
>  /* MCS spin-locking. */
> -#define arch_mcs_spin_lock_contended(lock)				\
> +#define arch_mcs_spin_lock(lock)				\
>  do {									\
>  	/* Ensure prior stores are observed before we enter wfe. */	\
>  	smp_mb();							\
> @@ -14,9 +14,9 @@ do {									\
>  		wfe();							\
>  } while (0)								\
>  
> -#define arch_mcs_spin_unlock_contended(lock)				\
> +#define arch_mcs_pass_lock(lock, val)					\
>  do {									\
> -	smp_store_release(lock, 1);					\
> +	smp_store_release((lock), (val));				\
>  	dsb_sev();							\
>  } while (0)

So I hate those names; it used to be clear this was the contended path,
not so anymore. arch_mcs_spin_lock() in particular is grossly misnamed
now.

's/arch_mcs_spin_lock/arch_mcs_spin_wait/g' could perhaps work, if you
really want to get rid of the _contended suffix.

Also, pass_lock seems unfortunately named...
