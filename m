Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7157822C0FA
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGXIjd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXIjd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 04:39:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E54C0619D3;
        Fri, 24 Jul 2020 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kXKoci4B8YFJHJ87vnIjv2pljX59x+0imMdXpdyFpys=; b=NOYfAHJA8hb2Qu9M1EZf7yK6p7
        oAGUnuV0K8ZPNz8luha/UDR+MErxMNAsWl7tyldtKpLUEwE4KadkV1OvV8ilFUkYfZv7TJDdWESXn
        Bv0lYR1TyldeSGNn6nqqTTdrfXbGEHkz16ZQotN57YyMlCtyfCYs8H/QUAYA7Ijl5XI/GdPPWRpDS
        ZxBMqC+t8TFI9+IbyUCahfq8OvwYopWJdFXLG3R/cAhza18nt8WFjZxkyj1Zv9/ixuRtO3dE5CuIq
        b6t8COU0aCgQqeI4ABEpLc2zmYb+zVUdj63R2WJ0o57i6FXxl1AVlF9Kq01eWxBV9EDuYkpKZErXZ
        jVD9r4Gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jytEi-0000RG-O8; Fri, 24 Jul 2020 08:39:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C4C430768E;
        Fri, 24 Jul 2020 10:39:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B86925942EE1; Fri, 24 Jul 2020 10:39:20 +0200 (CEST)
Date:   Fri, 24 Jul 2020 10:39:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/8] kcsan: Compound read-write instrumentation
Message-ID: <20200724083920.GV10769@hirez.programming.kicks-ass.net>
References: <20200724070008.1389205-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 09:00:00AM +0200, Marco Elver wrote:

> Marco Elver (8):
>   kcsan: Support compounded read-write instrumentation
>   objtool, kcsan: Add __tsan_read_write to uaccess whitelist
>   kcsan: Skew delay to be longer for certain access types
>   kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
>   kcsan: Test support for compound instrumentation
>   instrumented.h: Introduce read-write instrumentation hooks
>   asm-generic/bitops: Use instrument_read_write() where appropriate
>   locking/atomics: Use read-write instrumentation for atomic RMWs

Looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
