Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2520A4379E7
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhJVPaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhJVPaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:30:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D1CC061764;
        Fri, 22 Oct 2021 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JPMv/aZIcv7sKoHIe3TOsCau3cg3s9vKutzxK4SOJrw=; b=kplLvyFCj1XhEHMCXmQBliFpec
        xfqCvJ4ky1pU73rhW3i84Gd5IadVE/nGbWk04h58YmbLW0h4Hbk3eW07s1WmKwUSaB7FMq9NaOmPb
        roN5zttrsO4/0GGF0rbd9OM8sKD2IjHRXrPsKAEvyILRghtIoDQpk1lhmr9+rYoShnB651zIU3FJc
        LTX8r8smF8l5N0luE6TB7kbI7faZpAkv5QvvCT0LVw1bboJmb1WVK+uJtVRx9y1h8cjCd+U94NTsq
        5cmE5QurZGlJ9MNqz1AIN8uF/0QCHsSdAH3KRPXjsEBTz5v7IgjAp4Kw+RebwipexdyD70wfBIAN8
        myCw01TA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwSI-00BbT0-Pk; Fri, 22 Oct 2021 15:27:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22927986249; Fri, 22 Oct 2021 17:27:38 +0200 (CEST)
Date:   Fri, 22 Oct 2021 17:27:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 0/7] arch: More wchan fixes
Message-ID: <20211022152738.GC174703@worktop.programming.kicks-ass.net>
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022150933.883959987@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


*sigh*,...

On Fri, Oct 22, 2021 at 05:09:33PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> Respin of the rest of the get_wchan() rework [1]. Given the many problems with
> STACKTRACE this series focuses on the newer ARCH_STACKWALK since that's a
> smaller set of architectures to review with a better specified interface.
> 
> The idea is to piece-wise convert the rest of the architectures to
> ARCH_STACKWALK, but that can be done at leasure.
> 
> PowerPC and ARM64 are a bit funny in that their __switch_to() is in C and ends
> up on the stack. For now simply mark it __sched to make it work. Mark wanted to
> maybe do something different, but I think this ought to get us started.


[1] https://lkml.kernel.org/r/20211008111527.438276127@infradead.org

Patches are also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wchan
