Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5C77C7F5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Aug 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjHOGiz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjHOGhw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 02:37:52 -0400
X-Greylist: delayed 57922 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 23:37:31 PDT
Received: from out-86.mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CA1BE2
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2023 23:37:28 -0700 (PDT)
Message-ID: <8e232b68-cc15-d47b-4c49-4f36fd696963@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692081446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MvC5Vc55osq3n54e9YCchu2oQZ8ocFcc0a2zTwhcsM=;
        b=IKLcPW6nwIraNa9SEH4OcTu+wJLJ5YtvSKgC6LEUtY7kNyTSJHsN+94/s2Rl3ITE06qCuw
        flE3Ndgn+j4WS3EpZY9LfbyKXuGNtS29XWM/dwJBdc46caKjiPgiqmFStHCMHi2aI3hkCy
        FfcYSgG55OwEkN3xtdMI7sRlcwjELGY=
Date:   Tue, 15 Aug 2023 14:37:17 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Content-Language: en-US
To:     Patrick Yingxi Pan <pyxchina92929@gmail.com>
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
References: <20230811080851.84497-1-gang.li@linux.dev>
 <CANJ3EgExk-TC=qx0Dn7wA-RfTE-h3E_E+i1MctvhvV-VEUJFnQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <CANJ3EgExk-TC=qx0Dn7wA-RfTE-h3E_E+i1MctvhvV-VEUJFnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/8/15 12:02, Patrick Yingxi Pan wrote:
>> 它由于有意 (为了简洁) 或无意 (由于人为因素) 的原因而不完整。
> 它由于有意 (为了简洁) 和无意 (由于人会犯错) 的原因而不完整。
> 
>> 这些内存模型是维护者的集体意见，而不是准确无误的实现规范。
> 然而，即使这些内存模型也只是它们的维护者的集体意见，而不是准确无误的实现规范。
> 
>> 再次重申，本文档不是 Linux 对硬件的规范或期望。
> 再次重申，本文档不是 Linux 对硬件预期行为的规范。
> 
>> (1) 为内核屏障函数指定可以依赖的最小功能，以及
> (1) 为每个内核屏障函数，描述其可以依赖的最小功能，以及
> 
>> (2) 提供关于如何使用屏障的指南。
> (2) 提供关于如何使用现有屏障的指南。
> 
>> 请注意，一个架构可以为任何屏障提供超出最低要求的功能
> 请注意，一个架构可以为任何一个屏障提供超出其最低要求的功能
> 
>> 因为该架构已经保证了该内存序，使得显式屏障是不必要的。
> 因为该架构的工作方式使得显式屏障是不必要的。
> 
>> - CPU 的保证。
> - 功能保证。
> 
>> (*) Inter-CPU 获取屏障。
> (*) CPU 间获取型屏障的效果。
> 
>> (*) 内核 I/O 屏障。
> (*) 内核 I/O 屏障的效果。
> 
>> (*) 假想的最小执行顺序模型。
> (*) 可依赖的最弱的执行顺序保证。
> 
> 

Thanks for your help!

I try to be concise and localized in translations because sometimes
literal translation can sound odd. In order to improve readability, I
even rewrite certain paragraphs.
