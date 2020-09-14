Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB02695F3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgINT7w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgINT7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 15:59:52 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9910C06174A;
        Mon, 14 Sep 2020 12:59:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0A5F912354CAC;
        Mon, 14 Sep 2020 12:42:57 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:59:42 -0700 (PDT)
Message-Id: <20200914.125942.5644261129883859.davem@davemloft.net>
To:     npiggin@gmail.com
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, axboe@kernel.dk, peterz@infradead.org
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200914045219.3736466-4-npiggin@gmail.com>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Mon, 14 Sep 2020 12:42:58 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 14 Sep 2020 14:52:18 +1000

 ...
> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
> optimisation could be effectively restored by sending IPIs to mm_cpumask
> members and having them remove themselves from mm_cpumask. This is more
> tricky so I leave it as an exercise for someone with a sparc64 SMP.
> powerpc has a (currently similarly broken) example.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Sad to see this optimization go away, but what can I do:

Acked-by: David S. Miller <davem@davemloft.net>
