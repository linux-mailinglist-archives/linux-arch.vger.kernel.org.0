Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE199444922
	for <lists+linux-arch@lfdr.de>; Wed,  3 Nov 2021 20:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhKCTrr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Nov 2021 15:47:47 -0400
Received: from xvfrqvdb.outbound-mail.sendgrid.net ([168.245.72.219]:50580
        "EHLO xvfrqvdb.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbhKCTrr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Nov 2021 15:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=s1; bh=cwoMxqGWSt3BO2nOoSMa84BFuZND+djw3Sn79Yk2hEo=;
        b=lpGdhdzfmqesyAC2vk/WLX7f3p1p0qBuuVRFUa2hKZwEfje/p461cQ/0HKHy7rIya3Z6
        8CJBBFu3meGF7j2hdCfAL6Z2q0/z0b6BmX7Us10zbzc+fptgG18lE/JEEX4vn2NhUZm3Mi
        AmkRzD7RUaFq3zgeaf79fJBx4XgQ9zZhPac/4WvE13kbEYnxXRTaHQPkF9+v5UvDWB4KHe
        jD6vY5tDmthRG9DfIHI7Ktsgm4s1zXdO+YKb9pJPahs2IiZkCCRKBIddHpmBeAR/EyO3MF
        f/9RuD4NmyLY1HCQaUiQVj7MYbLzxBgsT42IwmVQhNpPfvdlD/luDjrwm8mOWF3g==
Received: by filterdrecv-canary-dcfc8db9-hnrtr with SMTP id filterdrecv-canary-dcfc8db9-hnrtr-1-6182E610-2B
        2021-11-03 19:42:08.541570131 +0000 UTC m=+5515025.671036202
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-2-0 (SG) with ESMTP
        id 335FfVOGSPmHtTshSBf2PQ
        for <linux-arch@vger.kernel.org>;
        Wed, 03 Nov 2021 19:42:08.045 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id 26D3AA79DA
        for <linux-arch@vger.kernel.org>; Thu,  4 Nov 2021 02:46:21 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tfir0j-Eo0rP for <linux-arch@vger.kernel.org>;
        Thu,  4 Nov 2021 02:45:57 +0800 (SGT)
Received: from haxpor-desktop.fritz.box (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id C61F6A793B;
        Thu,  4 Nov 2021 02:45:50 +0800 (SGT)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH RESEND] include/asm-generic/error-injection.h: fix a spelling
 mistake, and a coding style issue
Date:   Wed, 03 Nov 2021 19:42:08 +0000 (UTC)
Message-Id: <20211103194030.186361-1-wasin@wasin.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWueRVE7jMGgZ1VYg0QD?=
 =?us-ascii?Q?cSPDV1eRiJWkMBYN4de3aCS2+4KqVJ467DBpoSD?=
 =?us-ascii?Q?cC3f4bAEIOkK6aGaLohT7rdqg8N=2F5GGNSvixb11?=
 =?us-ascii?Q?M4n=2FRAnoGUA45y6hTfi+Ji0YX+S06f+ag+EHb3a?=
 =?us-ascii?Q?dBjFNPjb1zbm9x8mihNb0K3+zWAQBwTxjazKJCo?=
 =?us-ascii?Q?2=2FzFwcjA0=2FieqQGl+1B1w=3D=3D?=
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, Wasin Thonkaew <wasin@wasin.io>
X-Entity-ID: 9qDajD32UCSRojGE52wDxw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix a spelling mistake "ganerating" -> "generating".
Remove trailing semicolon for a macro ALLOW_ERROR_INJECTION to fix a
coding style issue.

Signed-off-by: Wasin Thonkaew <wasin@wasin.io>
---
 include/asm-generic/error-injection.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 7ddd9dc10ce9..fbca56bd9cbc 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -20,7 +20,7 @@ struct pt_regs;
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 /*
- * Whitelist ganerating macro. Specify functions which can be
+ * Whitelist generating macro. Specify functions which can be
  * error-injectable using this macro.
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
@@ -29,7 +29,7 @@ static struct error_injection_entry __used				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
-	};
+	}
 
 void override_function_with_return(struct pt_regs *regs);
 #else
-- 
2.25.1

