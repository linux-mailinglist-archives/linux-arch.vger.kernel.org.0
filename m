Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E88772E62
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjHGTA0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHGTAZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 15:00:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E710F6;
        Mon,  7 Aug 2023 12:00:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691434823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjw4cSUjNL/q8ajSLPjc5AEn3VQI4EuB25tHGD5K1UQ=;
        b=B8oIAA9wCOVrL3GA6hvcsjMrElEl6hLOHrz0Pe+VB0+wKr86a95yQKpfysM2jfrQAStpYU
        j5xIRnaOcBvyuIYhEYz4Yi0k+zLYwq9Ss3Bzbe6ivmt288iVn5H/74uFuOVcl0p9TKMSwx
        gC9mJuJ4JepS4CiBXCsUXq12r4mZgmVlxNr6K6vqCpjOx69qf7X+w5C5I08noMLR+HU82a
        S+Obrbr0g8VQDdyaTaC0Rdli1u6HtYtIxinOqVP2JrbHo+zFY1+dItNU8L4E3/+MDmyIL1
        mLT9bcbilTk/YoJNlelQPczE1Sldzidy0ZCDqluEjmSRgGlCrm+xRIS1Tvl1dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691434823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjw4cSUjNL/q8ajSLPjc5AEn3VQI4EuB25tHGD5K1UQ=;
        b=o78RTxUAakCGYH/QRc/fD8D0FCuhykp7DaxVY8AQvyd3X5uWqr6sN0Ooy1XtP5gEEpxMma
        1L6qS7Lp1fDEEuBw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH  v2 05/14] futex: Add sys_futex_wake()
In-Reply-To: <20230807123323.090897260@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.090897260@infradead.org>
Date:   Mon, 07 Aug 2023 21:00:22 +0200
Message-ID: <87o7jiu189.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:

> To complement sys_futex_waitv() add sys_futex_wake(). This syscall
> implements what was previously known as FUTEX_WAKE_BITSET except it
> uses 'unsigned long' for the bitmask and takes FUTEX2 flags.
>
> The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
