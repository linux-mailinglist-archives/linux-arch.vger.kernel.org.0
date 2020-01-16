Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A513D10D
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgAPAV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 19:21:28 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:58930 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgAPAV2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 19:21:28 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3B7524070C;
        Thu, 16 Jan 2020 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579134087; bh=E375DO0quFSrIv1CdiqxQgGba4e6GmHGHZzGNU4OBz0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZV2dReEuBUqo57qsQPr8yINW2tS31kw2rQ3a8/xhShhS1yrXB+yypd605YsXaG1r2
         sddRnY3z5H0j+ycI+I5CG97D343ZJSoswuRr6PdmB7vG2aBs3wbhW2YHUegbe9NZY4
         ITyu+AGvXQ8+mUHDLSCpOsXGPrJoaEioBsS/yvabCsjShYKVmRVhO7tyrdYV4iqLO2
         uvEK1gDu4sX+zrwuCKxHziNapPlTIULQHF7YrZYKrQLD1d9uRcIpw8c+InD3MvWVRM
         4O/WH2ONzBXh4+m4wpkjyK5qbQVkidEy23J/fdK3ZetLSc/FP3R/Y7OFd1B6JeSEYR
         p08SYubtAPXCQ==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.20])
        by mailhost.synopsys.com (Postfix) with ESMTP id D3894A005F;
        Thu, 16 Jan 2020 00:21:25 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 0/2] Switching ARC to optimized generic strncpy_from_user
Date:   Wed, 15 Jan 2020 16:21:22 -0800
Message-Id: <20200116002124.17988-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series switches ARC to generic word-at-a-time interface.

I understand that going fwd, we may drop the inline versions altogether but this
helps ARC code in the interim.

v2 <- v1
 - Moved __strnlen_user/__strncpy_from_user to under ifdef gaurd [Arnd]
 - Dropped the broken optimization patch [Linus]
 - Folded 2 ARC patches into 1

Thx,
-Vineet

Vineet Gupta (2):
  asm-generic/uaccess: don't define inline functions if noinline lib/*
    in use
  ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user

 arch/arc/Kconfig               |  2 +
 arch/arc/include/asm/uaccess.h | 85 ++--------------------------------
 arch/arc/mm/extable.c          | 23 ---------
 include/asm-generic/uaccess.h  |  8 ++++
 4 files changed, 14 insertions(+), 104 deletions(-)

-- 
2.20.1

