Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2C21BD66
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJTLY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 15:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJTLX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 15:11:23 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D397A2075D;
        Fri, 10 Jul 2020 19:11:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com,
        Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org,
        olof@lixom.net, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, prime.zeng@hisilicon.com,
        linux-arch@vger.kernel.org, kuhn.chenqun@huawei.com,
        xiexiangyou@huawei.com, linux-mm@kvack.org, arm@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date:   Fri, 10 Jul 2020 20:11:19 +0100
Message-Id: <159440712962.27784.4664678472466095995.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710094420.517-1-yezhenyu2@huawei.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
> NOTICE: this series are based on the arm64 for-next/tlbi branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> 
> --
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This series add support for this feature.
> 
> [...]

Applied to arm64 (for-next/tlbi), thanks!

[1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
      https://git.kernel.org/arm64/c/a2fd755f77ff
[2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
      https://git.kernel.org/arm64/c/db34a081d273

-- 
Catalin

