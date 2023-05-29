Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01955714C62
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjE2Otd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjE2Otb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 10:49:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE645AD;
        Mon, 29 May 2023 07:49:30 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C5DA2907;
        Mon, 29 May 2023 14:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C5DA2907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1685371770; bh=MJb91rfbyeDMNEkLwCwXqy7phkjSMP9NzxdT5e8DDYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx31VTCwcoexvx2jhgmTgfGBeENQrjZLoiJ9MgFfAy+J2YdmOHgmYUJFbkesUnHw7
         9aWqhtNlosZHpCKbc8N6pYArq55TbJIgd66R6JISh1BIuC4M2Kwf24unUZbMMjTwXW
         TqgGxUIQXhF+WhLuLqU3gWAW24GEKEbVhciCnz/0SJ+bihT3ruG/zoXer+OC7Rfkv2
         7hmGqJJ2l4BjnNmxjZ8B27Tx/WWfSnUMWN4rjJ71xbQaZSJ4lZPJYrxJHhJp6oa0GN
         0huMSu5F/EWP60EpN2vy/G6ggxbI7bn+VIan9mTzxUmJJNSsHzeeo/BaVO04Ks0fqR
         k4ovxeARntFHQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v2 4/7] mips: update a reference to a moved Arm Document
Date:   Mon, 29 May 2023 08:48:53 -0600
Message-Id: <20230529144856.102755-5-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529144856.102755-1-corbet@lwn.net>
References: <20230529144856.102755-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arm documentation has moved to Documentation/arch/arm; update a reference
in arch/mips/bmips/setup.c to match.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 arch/mips/bmips/setup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 549a6392a3d2..053805cb741c 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -178,7 +178,10 @@ void __init plat_mem_setup(void)
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
-	/* intended to somewhat resemble ARM; see Documentation/arm/booting.rst */
+	/*
+	 * intended to somewhat resemble ARM; see
+	 * Documentation/arch/arm/booting.rst
+	 */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
 	else
-- 
2.40.1

