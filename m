Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89818A010
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCRQA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 12:00:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgCRQA1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Mar 2020 12:00:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2418FC2FB6FF7DC0FC8;
        Wed, 18 Mar 2020 23:59:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 23:59:39 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>, <arnd@arndb.de>
CC:     <okaya@kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <olof@lixom.net>, <jiaxun.yang@flygoat.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 0/3] io.h, logic_pio: Allow barriers for inX() and outX() be overridden
Date:   Wed, 18 Mar 2020 23:55:32 +0800
Message-ID: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commits a7851aa54c0c ("io: change outX() to have their own IO
barrier overrides") and 87fe2d543f81 ("io: change inX() to have their own
IO barrier overrides"), the outX() and inX() functions have memory
barriers which can be overridden per-arch.

However, under CONFIG_INDIRECT_PIO, logic_pio defines its own version of
inX() and outX(), which still use readb et al. For these, the barrier
after a raw read is weaker than it otherwise would be. 

This series generates consistent behaviour for logic_pio, by defining
generic _inX() and _outX() in asm-generic/io.h, and using those in
logic_pio. Generic _inX() and _outX() have per-arch overrideable
barriers.

The topic was discussed there originally:
https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/

A small tidy-up patch is included.

I hope that series can go through the arm-soc tree, as with other recent
logic_pio changes.

John Garry (3):
  io: Provide _inX() and _outX()
  logic_pio: Improve macro argument name
  logic_pio: Use _inX() and _outX()

 include/asm-generic/io.h | 64 +++++++++++++++++++++++++++++++++---------------
 lib/logic_pio.c          | 22 ++++++++---------
 2 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.12.3

