Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7740B959
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 22:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhINUiW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 16:38:22 -0400
Received: from xvfrqvdb.outbound-mail.sendgrid.net ([168.245.72.219]:30083
        "EHLO xvfrqvdb.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233145AbhINUiV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Sep 2021 16:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-type:
        content-transfer-encoding;
        s=s1; bh=cwoMxqGWSt3BO2nOoSMa84BFuZND+djw3Sn79Yk2hEo=;
        b=hheert+vcHXb7m23oDeiaNiYKBz1pZ7BA0pN/0lZ37Rg8zBOqLOAYwq23aFo7NypdWDR
        6X++23ZWXKGheSCHl8yo1BWq+7RwWiJ6eyIgB7USMYiKXfDb4Y6BrZ3YbuxtRCACCQGkDP
        m6vYbc+fQ88QkJQkGndowquUEofarY2vIO74JF/aNZGn02X4n7k7h6KRta1z9qyXvJZSyQ
        AiaEQ6HZkLodUAPEt9G8M4D4/ZjfKc4pQrrivwF1KabRFF4TtPTkr/lLLGz6OvQcbaaogu
        KnJE4bwTsaBjw1fcOq62whr78KTAaY/T/iaabvESf9jX3Ki0jufUof+ec02YHIcQ==
Received: by filterdrecv-75ff7b5ffb-7dt9d with SMTP id filterdrecv-75ff7b5ffb-7dt9d-1-614106BF-A1
        2021-09-14 20:31:59.922073185 +0000 UTC m=+1116683.795750881
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-2-0 (SG) with ESMTP
        id 8gPs13XHT-uuCs0omqgWMg
        for <linux-arch@vger.kernel.org>;
        Tue, 14 Sep 2021 20:31:59.412 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id 0703DA6AE8
        for <linux-arch@vger.kernel.org>; Wed, 15 Sep 2021 03:43:18 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6iI3HGoioZxY for <linux-arch@vger.kernel.org>;
        Wed, 15 Sep 2021 03:42:54 +0800 (SGT)
Received: from haxpor-desktop (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id C25EFA0A25;
        Wed, 15 Sep 2021 03:42:47 +0800 (SGT)
Date:   Tue, 14 Sep 2021 20:31:59 +0000 (UTC)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH] include/asm-generic/error-injection.h: fix a spelling
 mistake, and a coding style issue
Message-ID: <YUEGmz23fZeoExBF@haxpor-desktop>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWuecBGCtNJPzSD08Mxr?=
 =?us-ascii?Q?4CxJ8ufBkfNVbzaodY1r6B0czGpN3wEoBiuvGAf?=
 =?us-ascii?Q?GFKK9Pol=2Fsu1uzqK91EYZtAMOlZJQcj=2FymQynBg?=
 =?us-ascii?Q?4BW6G7L4h4gfuNpS63GstHD4JW76tUIIaeX7l64?=
 =?us-ascii?Q?q6BEZdOf1jZfiKsV0q7gIgINYSOUWSrlzGD8r3?=
To:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, wasin@wasin.io
X-Entity-ID: 9qDajD32UCSRojGE52wDxw==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
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

