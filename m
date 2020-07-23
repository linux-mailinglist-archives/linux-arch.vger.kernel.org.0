Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144E422B60B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWSsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSsS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 14:48:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADBC0619DC;
        Thu, 23 Jul 2020 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1f7jSo8LA10wBMQErGxZHBOUpBnSmikLw3twngiB9do=; b=F/slu0yrPHxiFr2ZrGc9sNP3ns
        LfcamOV4YCSjJmAGql8AMoxgRpgB7ejoGOoyBLRe1+NSiLXfp9s6mu47IldFSbQMbbcbjzbuf5u9O
        833qpQHg1wNCif0Lkq4328/WTptDw86N2VO7KfNGktPrwAGmjr8DSQjE1+eFSW1K8SBisHKNbRDV7
        cmLO0EzWU8yk6Qi6ew5Fj8GFbqy5DhWcjYesQlU6LImS6PD+RqUFfZR8xNf4Vgk5d/STeIWcbrgB3
        HEhT+oCJJ9EhcXF59Ajf1oGcNx4KwTMd9LXGPsPEGnP5wOjXWz5J0tqHK64RSquaQFlBJPTpvUZQp
        TcS/d44Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jygG9-0004Wx-0f; Thu, 23 Jul 2020 18:48:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28C213013E5;
        Thu, 23 Jul 2020 20:47:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4A532010461D; Thu, 23 Jul 2020 20:47:59 +0200 (CEST)
Date:   Thu, 23 Jul 2020 20:47:59 +0200
From:   peterz@infradead.org
To:     Waiman Long <longman@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200723184759.GS119549@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845de183-56f5-2958-3159-faa131d46401@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
> I will have to update the patch to fix the reported 0-day test problem, but
> I want to collect other feedback before sending out v3.

I want to say I hate it all, it adds instructions to a path we spend an
aweful lot of time optimizing without really getting anything back for
it.

Will, how do you feel about it?
