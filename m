Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B47424660
	for <lists+linux-arch@lfdr.de>; Wed,  6 Oct 2021 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhJFTAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Oct 2021 15:00:54 -0400
Received: from xvfrqvdb.outbound-mail.sendgrid.net ([168.245.72.219]:21926
        "EHLO xvfrqvdb.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJFTAx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2021 15:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=s1; bh=cwoMxqGWSt3BO2nOoSMa84BFuZND+djw3Sn79Yk2hEo=;
        b=vwUAYZemmOCawTYdXC4hEM5jF5v1zHA9bFeC5mvFB6mie7qCv1w4n/uvBi+nXOUbsDKT
        HsegwxRp5E99J62mX2qdFttr6tXHpDVrODgtW+yy06FIt+yZimiKixx5gatfKPHbJIc1jl
        V/AX3W+bbfxsjVJtGEt9fJpOvpE3W4Qu+LODlYWRRRTtnUMcCWgvEkRweMeVsJJlYbYNxY
        0Kp/sIelo4G3xPVBPw7t5VFwqfTuwzk7n3HEh9xDq7YFS1NzS4mX0ZuiBgjACE046VSGDx
        TQerJ3ff7liNa/41OmGJ8UUwYLtRXXFDwIJczaKOCdLShWUBQHGsETl0jupba8cA==
Received: by filterdrecv-7bf5c69d5-w55fp with SMTP id filterdrecv-7bf5c69d5-w55fp-1-615DF1F3-A1
        2021-10-06 18:59:00.106387765 +0000 UTC m=+3011925.265408800
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-5-0 (SG) with ESMTP
        id mBS0SwHJR5i6ZOkOziV3Lg
        for <linux-arch@vger.kernel.org>;
        Wed, 06 Oct 2021 18:58:59.570 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id 783BFA7934
        for <linux-arch@vger.kernel.org>; Thu,  7 Oct 2021 02:07:11 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FjmUR4gHgAAN for <linux-arch@vger.kernel.org>;
        Thu,  7 Oct 2021 02:06:48 +0800 (SGT)
Received: from haxpor-desktop.fritz.box (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id 44F3EA792E;
        Thu,  7 Oct 2021 02:06:40 +0800 (SGT)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH RESEND] include/asm-generic/error-injection.h: fix a spelling
 mistake, and a coding style issue
Date:   Wed, 06 Oct 2021 18:59:00 +0000 (UTC)
Message-Id: <20211006185615.127132-1-wasin@wasin.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWueVBl8mEChcUFQGuMX?=
 =?us-ascii?Q?Xd2O9r8RkdW3hDQMqMnLqL=2FQv3n88FaODHdmBl=2F?=
 =?us-ascii?Q?O3TDjcMxz04okW6nUAbMfdh5eU2xLuYKeMvEABt?=
 =?us-ascii?Q?axRAwbE9aURxpX98mbXdIB5PegfxnhAheOBRtDP?=
 =?us-ascii?Q?dPMUbY=2FsTQeQ93w=2Fs33KgBOVMGWEzd7eW=2F5LHG?=
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, wasin@wasin.io
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

