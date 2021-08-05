Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29453E10BE
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhHEJDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhHEJDV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 05:03:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A24C061765;
        Thu,  5 Aug 2021 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iyogr41TYqX3XaEU9z9PHRCA66roQiTg9TFQpCtbrZA=; b=jHUPxFy4HCXN9LUgwTvnVmQ2Yl
        XrV4EAfZsb7u8HgY4X6H2KHY5iImkCfMry4mwvOjXBwamaCFkJN9YcRVGTORWbx/isvOYDreV2TUL
        znU9o6amdLO9qfo+MSWD3p69r0m79Fmgwk2P/GueHvHx7PdedTm1i71pY8qT3qJsnAAb3n87p2/6o
        SQu0hgj0clW2tz/mmJkwuWaplhkdTyt2D4NayDcDP7XRi4spra1PvFlC/LhPk3bUB1jJbq8b8NAqA
        wJlyx6VuqRgIQPhorHfsNRtUMXlY2uTqbbaxlLtavq7N+DTFIhZTyA6gxMfik9Gya0Y7qwjn3fkMP
        r1oeZyFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBZGU-006mjC-3e; Thu, 05 Aug 2021 09:02:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 634259862B0; Thu,  5 Aug 2021 11:02:09 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:02:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Subject: Re: [PATCH 00/11] ARC atomics update
Message-ID: <20210805090209.GA22037@worktop.programming.kicks-ass.net>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 04, 2021 at 12:15:43PM -0700, Vineet Gupta wrote:

> Vineet Gupta (10):
>   ARC: atomics: disintegrate header
>   ARC: atomic: !LLSC: remove hack in atomic_set() for for UP
>   ARC: atomic: !LLSC: use int data type consistently
>   ARC: atomic64: LLSC: elide unused atomic_{and,or,xor,andnot}_return
>   ARC: atomics: implement relaxed variants
>   ARC: bitops: fls/ffs to take int (vs long) per asm-generic defines
>   ARC: xchg: !LLSC: remove UP micro-optimization/hack
>   ARC: cmpxchg/xchg: rewrite as macros to make type safe
>   ARC: cmpxchg/xchg: implement relaxed variants (LLSC config only)
>   ARC: atomic_cmpxchg/atomic_xchg: implement relaxed variants
> 
> Will Deacon (1):
>   ARC: switch to generic bitops

Didn't see any weird things:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
