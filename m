Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67052815C7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgJBOuh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 10:50:37 -0400
Received: from foss.arm.com ([217.140.110.172]:38144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJBOuh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Oct 2020 10:50:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 109F230E;
        Fri,  2 Oct 2020 07:50:37 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 997383F73B;
        Fri,  2 Oct 2020 07:50:35 -0700 (PDT)
Date:   Fri, 2 Oct 2020 15:50:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, george.cherian@marvell.com, yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] sparc32: Move ioremap/iounmap declaration before
 asm-generic/io.h include
Message-ID: <20201002145029.GA25629@e121166-lin.cambridge.arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
 <20200915.131121.2090656899173531153.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915.131121.2090656899173531153.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 15, 2020 at 01:11:21PM -0700, David Miller wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Date: Tue, 15 Sep 2020 10:32:02 +0100
> 
> > Move the ioremap/iounmap declaration before asm-generic/io.h is
> > included so that it is visible within it.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Hi David,

can I apply your Acked-by to v2 (where I had to split this patch in 2):

https://lore.kernel.org/lkml/cover.1600254147.git.lorenzo.pieralisi@arm.com
I am about to merge it - please let me know.

Thanks,
Lorenzo
