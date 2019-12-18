Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67914124282
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRJPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 04:15:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfLRJPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2019 04:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yy7XJzKs/UVClyYTN6M5/1lRHUyMKVCwSsAA8ZPCmDQ=; b=f2iQ9azv80SPhY1T31gNmGIth
        IRmUrC2nCGebnp8jCvPy6rwls9g/I+lCe9ysconaUXAjoLM5a7hO1Zwp35Zz9HlKCRktBLUDc+2ck
        rvgcEcrnipKOUkHFAylmYW1CeD45Qd20DK0oRrkaRXq8bt/lCqNXnq3TIvyYPUlG3DMZAO1eq0tuA
        MPlzwIyak2WIrkPE00kXSKlQkuM8ydEarSWrGm0Ks2LqQKBHi2Rz99vIDlwGNU0upOm4ge1Cbgnkv
        /O6ixuJxILbPjSXh+gVGt7H3MaqptdS7QzbEZt8FBfep+a3zcpw17WrRDF3sS1RWk/2c6w50A1MsK
        DTyfUYK/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihVQ2-0000jH-56; Wed, 18 Dec 2019 09:14:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD9163007F2;
        Wed, 18 Dec 2019 10:13:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB8072B3E30F5; Wed, 18 Dec 2019 10:14:54 +0100 (CET)
Date:   Wed, 18 Dec 2019 10:14:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/3] powerpc/mmu_gather: Enable RCU_TABLE_FREE even
 for !SMP case
Message-ID: <20191218091454.GN2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


I'm going to assume you'll take these 3 patches through the powerpc tree
for convenience, a few small nits, but otherwise ACK on the lot.

On Wed, Dec 18, 2019 at 11:05:28AM +0530, Aneesh Kumar K.V wrote:
> A follow up patch is going to make sure we correctly invalidate page walk cache
> before we free page table pages. In order to keep things simple enable
> RCU_TABLE_FREE even for !SMP so that we don't have to fixup the !SMP case
> differently in the followup patch

Perhaps more clearly state that !SMP is broken for Radix/PWC. The above
sorta implies it is, but it's not spelled out in any detail.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
