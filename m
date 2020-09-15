Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8A26AE84
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 22:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgIOULo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgIOULY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 16:11:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50503C06174A;
        Tue, 15 Sep 2020 13:11:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8250613680FBE;
        Tue, 15 Sep 2020 12:54:35 -0700 (PDT)
Date:   Tue, 15 Sep 2020 13:11:21 -0700 (PDT)
Message-Id: <20200915.131121.2090656899173531153.davem@davemloft.net>
To:     lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, george.cherian@marvell.com, yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] sparc32: Move ioremap/iounmap declaration before
 asm-generic/io.h include
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
        <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 15 Sep 2020 12:54:35 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Tue, 15 Sep 2020 10:32:02 +0100

> Move the ioremap/iounmap declaration before asm-generic/io.h is
> included so that it is visible within it.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
