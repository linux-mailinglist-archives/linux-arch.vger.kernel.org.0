Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE03DA0AD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhG2J4E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 05:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235692AbhG2J4A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jul 2021 05:56:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C26600D1;
        Thu, 29 Jul 2021 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627552557;
        bh=tZY0Ar2/JgZ5Zu3Z2tNNFZUTTvtnn6/xEtJksdoxJqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqPn9EwW6OD52WDkWEYmU0U1XRcNZ/1t31VTYy2uY2b6egQgMwkIWFNMK+lzJE5HA
         KGZjgUvea4uusP9+tdh8l448iCwYdN01jwWeJy8F6NvzkupotnJMiCfUR49BELdPxG
         zePFjLnBQa7yCFwJX/CEr5kCs9cvd/1sRep9aeSD098ksiK6G9QgCqy64wwoBxRL+o
         hiEtqZnKhAXoRvaTJL0P9Byhl2SBz4RGUhjaeaiHx3iJkch4qcLeHE7iwj3O9vq12O
         4RBlJI1P6SmPGThm79Dwe777AddH3u7bOns4ji1r8JUKzaumSxz2BgRE3kGmWpaM0p
         4zXC7t+oq4vFg==
Date:   Thu, 29 Jul 2021 10:55:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Wang <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement
 atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
Message-ID: <20210729095551.GE21151@willie-the-truck>
References: <20210729093003.146166-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729093003.146166-1-wangrui@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 05:30:03PM +0800, Rui Wang wrote:
> This patch introduce a new atomic primitive andnot_or:
> 
>  * atomic_andnot_or
>  * atomic_fetch_andnot_or
>  * atomic_fetch_andnot_or_relaxed
>  * atomic_fetch_andnot_or_acquire
>  * atomic_fetch_andnot_or_release
>  * atomic64_andnot_or
>  * atomic64_fetch_andnot_or
>  * atomic64_fetch_andnot_or_relaxed
>  * atomic64_fetch_andnot_or_acquire
>  * atomic64_fetch_andnot_or_release
>  * atomic_long_andnot_or
>  * atomic_long_fetch_andnot_or
>  * atomic_long_fetch_andnot_or_relaxed
>  * atomic_long_fetch_andnot_or_acquire
>  * atomic_long_fetch_andnot_or_release
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Rui Wang <wangrui@loongson.cn>
> ---
>  include/asm-generic/atomic-instrumented.h |  72 +++++-
>  include/asm-generic/atomic-long.h         |  62 ++++-
>  include/linux/atomic-arch-fallback.h      | 262 +++++++++++++++++++++-
>  lib/atomic64_test.c                       |  92 ++++----
>  scripts/atomic/atomics.tbl                |   1 +
>  scripts/atomic/fallbacks/andnot_or        |  25 +++
>  6 files changed, 471 insertions(+), 43 deletions(-)
>  create mode 100755 scripts/atomic/fallbacks/andnot_or

Please see my other comments on the other patches you posted:

https://lore.kernel.org/r/20210729093923.GD21151@willie-the-truck

Overall, I'm not thrilled to bits by extending the atomics API with
operations that cannot be implemented efficiently on any (?) architectures
and are only used by the qspinlock slowpath on machines with more than 16K
CPUs.

I also think we're lacking documentation justifying when you would use this
new primitive over e.g. a sub-word WRITE_ONCE() on architectures that
support those, especially for the non-returning variants.

Will
