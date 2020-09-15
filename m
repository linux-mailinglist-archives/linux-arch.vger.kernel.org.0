Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5E26ADDF
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 21:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgIOToU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgIOTnf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 15:43:35 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C8C06174A;
        Tue, 15 Sep 2020 12:43:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9299113678364;
        Tue, 15 Sep 2020 12:26:08 -0700 (PDT)
Date:   Tue, 15 Sep 2020 12:42:54 -0700 (PDT)
Message-Id: <20200915.124254.1657521903825160294.davem@davemloft.net>
To:     npiggin@gmail.com
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        axboe@kernel.dk, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1600139445.qwycwjuwdq.astroid@bobo.none>
References: <20200914045219.3736466-4-npiggin@gmail.com>
        <20200914.125942.5644261129883859.davem@davemloft.net>
        <1600139445.qwycwjuwdq.astroid@bobo.none>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 15 Sep 2020 12:26:09 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 15 Sep 2020 13:24:07 +1000

> Excerpts from David Miller's message of September 15, 2020 5:59 am:
>> From: Nicholas Piggin <npiggin@gmail.com>
>> Date: Mon, 14 Sep 2020 14:52:18 +1000
>> 
>>  ...
>>> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
>>> optimisation could be effectively restored by sending IPIs to mm_cpumask
>>> members and having them remove themselves from mm_cpumask. This is more
>>> tricky so I leave it as an exercise for someone with a sparc64 SMP.
>>> powerpc has a (currently similarly broken) example.
>>> 
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> 
>> Sad to see this optimization go away, but what can I do:
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
>> 
> 
> Thanks Dave, any objection if we merge this via the powerpc tree
> to keep the commits together?

No objection.
