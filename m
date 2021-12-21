Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6947BEFC
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhLULcs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 06:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhLULcs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2021 06:32:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C0C061574;
        Tue, 21 Dec 2021 03:32:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB3861532;
        Tue, 21 Dec 2021 11:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B23C36AE8;
        Tue, 21 Dec 2021 11:32:44 +0000 (UTC)
Date:   Tue, 21 Dec 2021 11:32:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] asm-generic: introduce io_stop_wc() and add
 implementation for ARM64
Message-ID: <YcG7WRvrWiSxcBZt@arm.com>
References: <20211221035556.60346-1-wangxiongfeng2@huawei.com>
 <CAK8P3a2fBdh2kPDo8UGHBD0MhF5k_DoomqUaW+=ZOgksKmGg5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2fBdh2kPDo8UGHBD0MhF5k_DoomqUaW+=ZOgksKmGg5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 21, 2021 at 10:17:27AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 21, 2021 at 4:55 AM Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
> >
> > For memory accesses with write-combining attributes (e.g. those returned
> > by ioremap_wc()), the CPU may wait for prior accesses to be merged with
> > subsequent ones. But in some situation, such wait is bad for the
> > performance.
> >
> > We introduce io_stop_wc() to prevent the merging of write-combining
> > memory accesses before this macro with those after it.
> >
> > We add implementation for ARM64 using DGH instruction and provide NOP
> > implementation for other architectures.
> >
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > v1->v2: change 'Normal-Non Cacheable' to 'write-combining'
> 
> For asm-generic:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Will, Catalin: if you are happy with this version, please merge it through the
> arm64 tree.

Thanks for the ack Arnd. I'll queue this through the arm64 tree.

-- 
Catalin
