Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0F37155E
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhECMrn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhECMrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 08:47:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF8C06174A;
        Mon,  3 May 2021 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QfWmNFzhd1S/Ji2/R39Bqc12Zh4EulMnH47lj47aGq8=; b=XumoXk4rcDMvg1IUtUvmE938GI
        b9X1L0f/kTqhp+eUmDneBVIM+VLK4tcedpSWvAruEG9FrIV+dDDkG6tk9dPnLUIw2aULil5oYw5OZ
        l3hYxn7VHpVQXPZiVHyY5oS/cRee2er8krYJO9JDfWWTji6bid8Jc0oVN5trfSQc6fw0MfF6NldLt
        fRrPh5i+52JaYvSqjmnyptQdJ/EQl3DkIWZzPd9/yn0b22j2Uta1ux3PhjLV+HJwWlJxLi0oFVYV2
        +/cY512qd4rCd23VnD6vVYYYURxouR+zJIFvt03xYQ6SB/LUBlP3xHPpRXnVRnzD4t1wWmG2P1FRB
        9sCS/Ibw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldXvz-00Dt54-Ne; Mon, 03 May 2021 12:46:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF9C83001D0;
        Mon,  3 May 2021 14:44:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0B282CEAF0C5; Mon,  3 May 2021 14:44:21 +0200 (CEST)
Date:   Mon, 3 May 2021 14:44:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
Message-ID: <YI/wJSwQitisM8Xf@hirez.programming.kicks-ass.net>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
 <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org>
 <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
 <m11rarqqx2.fsf_-_@fess.ebiederm.org>
 <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com>
 <m1wnshm14b.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wnshm14b.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 02, 2021 at 01:39:16PM -0500, Eric W. Biederman wrote:

> The one thing that this doesn't do is give you a 64bit field
> on 32bit architectures.
> 
> On 32bit builds the layout is:
> 
> 	int si_signo;
> 	int si_errno;
> 	int si_code;
> 	void __user *_addr;
>         
> So I believe if the first 3 fields were moved into the _sifields union
> si_perf could define a 64bit field as it's first member and it would not
> break anything else.
> 
> Given that the data field is 64bit that seems desirable.

The data field is fundamentally an address, it is internally a u64
because the perf ring buffer has u64 alignment and it saves on compat
crap etc.

So for the 32bit/compat case the high bits will always be 0 and
truncating into an unsigned long is fine.
