Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56563B5ED1
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhF1NXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhF1NX3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 09:23:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24389C061574;
        Mon, 28 Jun 2021 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tETVd4qfZs7ZyGjHOxKkFCYCB/FaFBzlz/HaF4lqmR8=; b=m+9V3FPa/m6WA3KarpSESel7V5
        F2SVzBINIxzlN0tdjV5WAFh1r6Rd/sWy9bVKMxOA8i3pl7PHSJS2cNgvTa6F3RAdTFOclcW4GeJBm
        qC2UswMQeO9cB/MlxC9Eeu1Ubk6qr1i3QB7/QivQsfFU3DZA8h/qHaKpjrSUocCNcmGGIcWPgWXis
        l1PBWmSdKvKve9mrKoRgzbj2LXP7ohe52DZu0zyvrAWPoutX0X5otnqcZ7RKiu0xWv2r61WbqkwvE
        8ulItWULPYD5y/ZnBAOYuqXLZMksSZnWeWRo5V320CTNB3rRzp24x/wa7b/M0ozEIWQeKnE879s3C
        pwDCYQOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxrBx-00CZ9E-68; Mon, 28 Jun 2021 13:20:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E82F300242;
        Mon, 28 Jun 2021 15:20:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F0E320157117; Mon, 28 Jun 2021 15:20:48 +0200 (CEST)
Date:   Mon, 28 Jun 2021 15:20:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Thiago Macieira <thiago.macieira@intel.com>, fweimer@redhat.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
Message-ID: <YNnMsJJzI83cpnAQ@hirez.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 28, 2021 at 02:40:32PM +0200, Enrico Weigelt, metux IT consult wrote:

> Going back to AMX - just had a quick look at the spec (*1). Sorry, but
> this thing is really weird and horrible to use. Come on, these chips
> already have billions of transistors, it really can't hurt so much
> spending a few more to provide a clean and easy to use machine code
> interface. Grmmpf! (This is a general problem we've got with so many
> HW folks, why can't them just talk to us SW folks first so we can find
> a good solution for both sides, before that goes into the field ?)
> 
> And one point that immediately jumps into my mind (w/o looking deeper
> into it): it introduces completely new registers - do we now need extra
> code for tasks switching etc ?

No, but because it's register state and part of XSAVE, it has immediate
impact in ABI. In particular, the signal stack layout includes XSAVE (as
does ptrace()).

At the same time, 'legacy' applications (up until _very_ recently) had a
minimum signal stack size of 2K, which is already violated by the
addition of AVX512 (there's actual breakage due to that).

Adding the insane AMX state (8k+) into that is a complete trainwreck
waiting to happen. Not to mention that having !INIT AMX state has direct
consequences for P-state selection and thus performance.

For these reasons, us OS folks, will mandate you get to do a prctl() to
request/release AMX (and we get to say: no). If you use AMX without
this, the instruction will fault (because not set in XCR0) and we'll
SIGBUS or something.

Userspace will have to do something like:

 - check CPUID, if !AMX -> fail
 - issue prctl(), if error -> fail
 - issue XGETBV and check the AMX bit it set, if not -> fail
 - request the signal stack size / spawn threads
 - use AMX

Spawning threads prior to enabling AMX will result in using the wrong
signal stack size and result in malfunction, you get to keep the pieces.


