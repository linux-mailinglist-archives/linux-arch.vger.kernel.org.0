Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D99124935
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLROPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 09:15:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37380 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfLROPe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2019 09:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2nES9kOBc4cV/fZ0o+JoYgqv77t/8xkE/A+hcyPMYUI=; b=BZV0qpJAM9mgU5zTXeGH9+luw
        0ncgwa+JZofxcOi8owdKKmIwwyoltYlTATau/3PhXu5TTvRQzRGwV7tsHHqHEBeB4pVx4Si4lvZOH
        a4l6FgaINOZzxU9Yy4D8V0rzda3zW81VpI5T0WPLbSA9CSSrh8ycdYYsibY54cfVViEJ+RFrggPY/
        mC9cxGiOs2DDtkRS+AlOaMPh44g/Ij9LksYx78+GAvSQAiMC0x7MeoyWMDrJ8Pe2yWUMFl1Fk2oeC
        jdhSLaImANWgAhXbmEhsyoRPmql01B27AZr546QZPlZq8R7kom+CWd8NMaH12KuIjzi9UVhaupsxh
        eNqPA6S5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iha6T-0004bj-Jp; Wed, 18 Dec 2019 14:15:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BC8F30038D;
        Wed, 18 Dec 2019 15:13:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8933E2B276121; Wed, 18 Dec 2019 15:15:01 +0100 (CET)
Date:   Wed, 18 Dec 2019 15:15:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, akpm@linux-foundation.org,
        npiggin@gmail.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Message-ID: <20191218141501.GT2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
 <20191218091733.GO2844@hirez.programming.kicks-ass.net>
 <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
 <87v9qdn5df.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9qdn5df.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 19, 2019 at 12:13:48AM +1100, Michael Ellerman wrote:

> >> I'm a little confused though; if nohash is a software TLB fill, why do
> >> you need a TLBI for tables?
> >> 
> >
> > nohash (AKA book3e) has different mmu modes. I don't follow all the 
> > details w.r.t book3e. Paul or Michael might be able to explain the need 
> > for table flush with book3e.
> 
> Some of the Book3E CPUs have a partial hardware table walker. The IBM one (A2)
> did, before we ripped that support out. And the Freescale (NXP) e6500
> does, see eg:
> 
>   28efc35fe68d ("powerpc/e6500: TLB miss handler with hardware tablewalk support")
> 
> They only support walking one level IIRC, ie. you can create a TLB entry
> that points to a PTE page, and the hardware will dereference that to get
> a PTE and load that into the TLB.

Shiny!, all the embedded goodness. Thanks for the info.
