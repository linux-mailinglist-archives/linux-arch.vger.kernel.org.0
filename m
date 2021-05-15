Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044B93815A0
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 05:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhEOEAR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 00:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhEOEAR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 00:00:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F220613F6;
        Sat, 15 May 2021 03:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621051144;
        bh=Z1sccg2vrpIeTClwluNbqzKfuQ+iCA6YJXcgWJREDvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJGtllVDTxzsfnQoqk8BsCbL64losT+Ty47Mg00VeF0nf6O82MPJ4NXwclyYvMmjU
         6To2isk6gBN6F7TMXgX3O8djMUZfQn6d2WNAOfFd2afdfKBNfYGfuEHSiKRQT8Q984
         ImdElmlY38m5D0beV6Ke2Gkbgyor8Kfx1/LnuM81Fi6X9ghxMu/2J4wek/8dVZ998P
         f1JqGJTkRYzzXMKKduiP/OHQM/m56qOQcav6Jt//03j3VosRZ77UWA5SZdukjMT/39
         3MqPRJ2WKfoOXg+d7S1Puls51F/EiiR0wRlp1htvcOFmyrWwq7yB6acKq7gw4x0K/2
         UqF1mdOKHOuRQ==
Date:   Fri, 14 May 2021 20:58:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, naresh.kamboju@linaro.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm64: Define only {pud/pmd}_{set/clear}_huge when
 usefull
Message-ID: <YJ9HAg+o8nd2xmix@archlinux-ax161>
References: <73ec95f40cafbbb69bdfb43a7f53876fd845b0ce.1620990479.git.christophe.leroy@csgroup.eu>
 <20210514144200.b49ee77c9b2a7f9998ffbf22@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514144200.b49ee77c9b2a7f9998ffbf22@linux-foundation.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 14, 2021 at 02:42:00PM -0700, Andrew Morton wrote:
> On Fri, 14 May 2021 11:08:53 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
> > When PUD and/or PMD are folded, those functions are useless
> > and we now have a stub in linux/pgtable.h
> 
> OK, help me out here please.  What patch does this fix?
> 

Naresh's original report is here it seems:

https://lore.kernel.org/r/CA+G9fYv79t0+2W4Rt3wDkBShc4eY3M3utC5BHqUgGDwMYExYMw@mail.gmail.com/

I can reproduce the failure that he reported with
ARCH=arm64 allmodconfig and this patch resolves it for me.

Cheers,
Nathan
