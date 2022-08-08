Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9958C5C5
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 11:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiHHJlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiHHJlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 05:41:12 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 02:41:11 PDT
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517A2FA
        for <linux-arch@vger.kernel.org>; Mon,  8 Aug 2022 02:41:11 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 35513B0031D; Mon,  8 Aug 2022 11:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1659951104; bh=cAm0EF/td7pugO5S6hgTN1A7+5y0vwo9DxRBgMuNTBQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LDa2NTnVzPd6kEC7wusjeNwIM0cuMz+3R/iBHFN4COgE+Cvgj1cZmXpjCByFf0QIq
         k1VkgeRGA0gooFKtOpta6BdcHZVyI/UBTAoC8T+eX32jzrsgxg36fLzKrfELVcegef
         gMyRlSrKoNOYki+D+fSwK5IoV1YmGlKOLicYOKUMWq1UbD/vrj/FA9mWLQbtGmhmcu
         UeGsOcrH7QJM8PGolvvaZnngGc4xqBgjjTcRMbhT6m3XWbKQWXCf01gC/wlGkr6Fto
         TMxpGipWiOdiz0iZIdLKCwU0354++VdoKcyTQYv/r9lV5s0u5w/i5w8VO0hiceiGzc
         f2LOzG6aMZA8g==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 327D9B00179;
        Mon,  8 Aug 2022 11:31:44 +0200 (CEST)
Date:   Mon, 8 Aug 2022 11:31:44 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Guo Ren <guoren@kernel.org>
cc:     tj@kernel.org, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 1/4] vmstat: percpu: Rename HAVE_CMPXCHG_LOCAL to
 HAVE_CMPXCHG_PERCPU_BYTE
In-Reply-To: <20220808080600.3346843-2-guoren@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2208081119230.411952@gentwo.de>
References: <20220808080600.3346843-1-guoren@kernel.org> <20220808080600.3346843-2-guoren@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 8 Aug 2022, guoren@kernel.org wrote:

> The name HAVE_CMPXCHG_LOCAL is confused with using cmpxchg_local, but
> vmstat needs this_cpu_cmpxchg_1. Rename would clarify the meaning, and
> maybe we could remove cmpxchg(64)_local API (Only drivers/iommu/intel
> used) in the future.

HAVE_CMPXCHG_LOCAL indicates that cmpxchg_local() is available.

The term LOCAL is important because that has traditionally signified an
operation that has an atomic nature that only works on the local core.

cmpxchg local is used in slub too in the form of this_cpu_cmpxchg_double.

But there is the other naming using this_cpu.....

Maybe rename to

	HAVE_THIS_CPU_CMPXCHG ?

and clean up all the other mentions of "local" in the source too?

There is also a local.h header around somewhere
