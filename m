Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747DB1D46B0
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEOHHa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 03:07:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgEOHH3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 03:07:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6610CA908959FDAF50FF;
        Fri, 15 May 2020 15:07:25 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 15:07:16 +0800
Subject: Re: [PATCH v2 0/3] io.h, logic_pio: Allow barriers for inX() and
 outX() be overridden
To:     John Garry <john.garry@huawei.com>, <xuwei5@huawei.com>,
        <arnd@arndb.de>
References: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
CC:     <okaya@kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <olof@lixom.net>, <jiaxun.yang@flygoat.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5EBE3FA3.2060703@hisilicon.com>
Date:   Fri, 15 May 2020 15:07:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On 2020/3/28 0:06, John Garry wrote:
> Since commits a7851aa54c0c ("io: change outX() to have their own IO
> barrier overrides") and 87fe2d543f81 ("io: change inX() to have their own
> IO barrier overrides"), the outX() and inX() functions have memory
> barriers which can be overridden per-arch.
> 
> However, under CONFIG_INDIRECT_PIO, logic_pio defines its own version of
> inX() and outX(), which still use readb et al. For these, the barrier
> after a raw read is weaker than it otherwise would be. 
> 
> This series generates consistent behaviour for logic_pio, by defining
> generic _inX() and _outX() in asm-generic/io.h, and using those in
> logic_pio. Generic _inX() and _outX() have per-arch overrideable
> barriers.
> 
> The topic was discussed there originally:
> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
> 
> A small tidy-up patch is included.
> 
> I hope that series can go through the arm-soc tree, as with other recent
> logic_pio changes.
> 
> Hi Arnd,
> 
> I added your tag, but please let me know if you have any issue with the
> updated change in patch #1.
> 
> cheers
> 
> - Differences to v1
> 	- fix x86 clang build by adding extra build swicth for _{in,out}X
> 	- added Arnd's RB tag
> 
> John Garry (3):
>   io: Provide _inX() and _outX()
>   logic_pio: Improve macro argument name
>   logic_pio: Use _inX() and _outX()
> 
>  include/asm-generic/io.h | 64 +++++++++++++++++++++++++++++++++---------------
>  lib/logic_pio.c          | 22 ++++++++---------
>  2 files changed, 55 insertions(+), 31 deletions(-)
> 

Thanks!
Series applied to the hisilicon SoC tree.

Best Regards,
Wei
