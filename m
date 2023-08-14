Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA377AFA4
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHNClg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Aug 2023 22:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjHNClE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Aug 2023 22:41:04 -0400
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF542E64
        for <linux-arch@vger.kernel.org>; Sun, 13 Aug 2023 19:41:00 -0700 (PDT)
Message-ID: <f8de40bf-1743-793f-7723-232adbfab623@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691980858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4Z2iziGNc9EaR/EDNMeDU4tEch1epKY77bLxp45IzA=;
        b=wwlw1dVWK9TCOQti1gOCQRL8CzigtTXE7TAaFpglOAbQLQB/FFo91JTsJKqgS3my6Ro6Lg
        dG46Z6UVJOkbV/xNlqDCLKZafwbNCWC9e9C49cENbhmEVHbBPHZ9HHQ11MCabqYEXZ5v9N
        oArOxMtZrhT14WTRepJyTofXTJfpgoI=
Date:   Mon, 14 Aug 2023 10:40:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Content-Language: en-US
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Alex Shi <alexs@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org
References: <20230811080851.84497-1-gang.li@linux.dev>
 <2f519a69-8f12-4c07-bf20-6776a5ada256@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <2f519a69-8f12-4c07-bf20-6776a5ada256@loongson.cn>
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

Hi,

On 2023/8/12 19:00, Yanteng Si wrote:
> 在 2023/8/11 16:08, Gang Li 写道:
>> +译注：
>> +本文仅为方便汉语阅读，不保证与英文版本同步;
>> +若有疑问，请阅读英文版本;
>> +若有翻译问题，请通知译者；
>> +若想修改文档，也请先修改英文版本。
> 
> In fact, we already have an easier way to do this, just include 
> disclaimer-zh_CN.
> 
> If you observe the files under .../zh_CN/, they all have a similar 
> header, and we can completely follow them.
> 
Thanks. I just noticed that there are txt files under 
"zh_CN/arch/arm64/" and "zh_CN/video4linux/". They have the same header, 
and I will
refer to them in v2.

> But you should also have noticed that memory-barriers are not a standard 
> rst file and will not be built, which will result in it only staying in 
> the development tree.
> It won't appear at:
https://docs.kernel.org
https://www.kernel.org/doc/html/latest/

But people can still access the txt document in this way:
https://www.kernel.org/doc/Documentation/memory-barriers.txt

> Finally, this patch is too huge and we may need some time to review it.
> 
Of course. Would it be more convenient if I split the file into multiple
patches and send them as one series?

> 
> Thanks,
> 
> Yanteng
> 

Thanks,
Gang Li
