Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3187823CB
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjHUGja (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 02:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHUGj3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 02:39:29 -0400
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A39A7
        for <linux-arch@vger.kernel.org>; Sun, 20 Aug 2023 23:39:26 -0700 (PDT)
Message-ID: <f7eac106-abe4-aba1-14df-6c9d1bfdf3b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692599965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSfoQd3XwUpQ2de8+t1B67oe5dl5I//p69PX46d5rUI=;
        b=Y9Gkcsuwz8GKzo/HVa2xnfBnTUBofFVRasCqWLC+irW23+SvnZVhzqfMRN4NWaF4LgfGRe
        t/Swk8UqSL7FmrO5PqMOXWNGIV/qR51RnxvokXhWknTxsFeBrl3qwyhXR9wdeqnzCcg3ke
        IOnT+4RKxGMnJEP/g1SGVmR1ffBLhGs=
Date:   Mon, 21 Aug 2023 14:39:15 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
References: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
 <20230819162526.GA274478@leoy-huanghe.lan>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <20230819162526.GA274478@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for your review!

Your suggestions will be integrated into the next version(v2).

On 2023/8/20 00:25, Leo Yan wrote:
>> +		|       |   :   |        |   :   |       |
>> +		|       |   :   |        |   :   |       |
>> +		| CPU 1 |<----->|   内存  |<----->| CPU 2 |
> 
> Unalignment caused by extra space around "内存".
> 
If using Chinese, it is impossible to align properly no matter
how it is modified. If strict alignment is needed, the text in the
charts should not be translated.

Gang Li.
