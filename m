Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651BD281E94
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBWoU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBWoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 18:44:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4B7C0613D0;
        Fri,  2 Oct 2020 15:44:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A0F1911E48E5C;
        Fri,  2 Oct 2020 15:27:31 -0700 (PDT)
Date:   Fri, 02 Oct 2020 15:44:18 -0700 (PDT)
Message-Id: <20201002.154418.397749976448102823.davem@davemloft.net>
To:     lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, george.cherian@marvell.com, yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] sparc32: Move ioremap/iounmap declaration before
 asm-generic/io.h include
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20201002145029.GA25629@e121166-lin.cambridge.arm.com>
References: <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
        <20200915.131121.2090656899173531153.davem@davemloft.net>
        <20201002145029.GA25629@e121166-lin.cambridge.arm.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Fri, 02 Oct 2020 15:27:32 -0700 (PDT)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Fri, 2 Oct 2020 15:50:29 +0100

> On Tue, Sep 15, 2020 at 01:11:21PM -0700, David Miller wrote:
>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Date: Tue, 15 Sep 2020 10:32:02 +0100
>> 
>> > Move the ioremap/iounmap declaration before asm-generic/io.h is
>> > included so that it is visible within it.
>> > 
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Hi David,
> 
> can I apply your Acked-by to v2 (where I had to split this patch in 2):
> 
> https://lore.kernel.org/lkml/cover.1600254147.git.lorenzo.pieralisi@arm.com
> I am about to merge it - please let me know.

Yes, you can.
