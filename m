Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0687484BD
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGENQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjGENQ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 09:16:26 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3515171C;
        Wed,  5 Jul 2023 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1688562982;
        bh=MQxEHzoj7/QzWcBHD3sDIDxrK5ABdydHyDEuVfPWfKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QvAuwK3OzpsW/IOcVjc9hI7vX9cS+8uT54rs+ziIY3srPy6v0XX5y6pbGT5RFHlZc
         thamGNKLCvgpITCJjLkCeD0S+b8ZqyQOhdMPfY/hHeFzdPFOFAqICsWRpdFtb/tvnM
         Z+woG/gDq4rrrL6xj3AKZRw5rv5jb8tBtpoBIcauw2uBhGmesekH9AzOcJk7EleZaz
         BgiGcCJPVQ4FxXEAX9vkG0pfGVGoxYug09CyX+92/9bAUrbM0BCBzN8Q7ycroh5Gm4
         K+ec3FMW2Yvn6rrfwLFEo3wLtZ+qTdhjN6+lbXlcDVUNU3SejLXcoJZopit5E/y37s
         i6/Rs2t+/hVyg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qx0Y16QlVz1Fsy;
        Wed,  5 Jul 2023 09:16:21 -0400 (EDT)
Message-ID: <58fa5c39-1481-58f3-9309-aa03bd3344ce@efficios.com>
Date:   Wed, 5 Jul 2023 09:16:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Olivier Dion <odion@efficios.com>
Cc:     rnk@google.com, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm@lists.linux.dev
References: <87ttukdcow.fsf@laura> <ZKUWPKWAnjZvqsgL@Boquns-Mac-mini.local>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZKUWPKWAnjZvqsgL@Boquns-Mac-mini.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/5/23 03:05, Boqun Feng wrote:
> On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
> [...]
>> NOTE: On x86-64, we found at least one corner case [7] with Clang where
>> a RELEASE exchange is optimized to a RELEASE store, when the returned
>> value of the exchange is unused, breaking the above expectations.
>> Although this type of optimization respect the standard "as-if"
>> statement, we question its pertinence since a user should simply do a
>> RELEASE store instead of an exchange in that case.  With the
>> introduction of these new primitives, these type of optimizations should
>> be revisited.
>>
> 
> FWIW, this is actually a LLVM bug:
> 
> 	https://github.com/llvm/llvm-project/issues/60418

So it was more than a dubious optimization, it's actually broken as well.

I am worried about adding to the compiler's ability to optimize those 
atomics because of the subtle corner-cases/bugs that can creep up.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

