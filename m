Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D693752AA
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhEFKzZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbhEFKzX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 May 2021 06:55:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6DC061574;
        Thu,  6 May 2021 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OGAgGqtk2aQf4lRyJ1TmlGnAs66cYrU1G5wL3SCCxF4=; b=j/1aaMedwOwOw2crJULMBUsPgi
        Cp0YM5p/12hyQGDf4u6wzuY1lebCTt6+VhBn8F3VsMPwzFtf0DFQ3YknvHT1ZfWFGSg+y9dDaqY/7
        ftdGsC56V4bzp/v6R+aqR0PfK1FDRlE4/RZ6eGSad7bYsqHqjzspZZJlQ7lgNNzN+dfvLGKglQ3yi
        1gRgEC/R1gUB6I9w0k7IgGb5f14d4QJ93qPhIBmDj+ZWcl0fSQ5Nhg3T32aWAhkCUpMb8vny/2Ei2
        xgiGhQPUl2GT/DWEqmoKVZQqOaZ/7CtJDV960K1iQMt2lvLdBVPyJh7xaw6AW5eKl7dA4hWEXb46Z
        oXfLxgpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lebdz-0042wA-Ex; Thu, 06 May 2021 10:54:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94500300103;
        Thu,  6 May 2021 12:54:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B8D32C328C4D; Thu,  6 May 2021 12:54:10 +0200 (CEST)
Date:   Thu, 6 May 2021 12:54:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Beiderman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH v3 10/12] signal: Factor force_sig_perf out of
 perf_sigtrap
Message-ID: <YJPK0oWD8t+BYvMQ@hirez.programming.kicks-ass.net>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505141101.11519-10-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 05, 2021 at 09:10:59AM -0500, Eric W. Beiderman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Separate generating the signal from deciding it needs to be sent.
> 
> v1: https://lkml.kernel.org/r/m17dkjqqxz.fsf_-_@fess.ebiederm.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for cleaning all that up.
