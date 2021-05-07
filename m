Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF6376C35
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 00:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhEGWMj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 18:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhEGWMi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 18:12:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C742661164;
        Fri,  7 May 2021 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620425498;
        bh=pZSz9/bE1dccUz0arW63l+m26jk29w2RT0c+Ugq0qIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G25uAdymMRmpMNsrSc4/A7NYT726TtqP9IbZga0Ld/6wJezslzOUOlMTMc7BWw6b1
         Ns0qhCIhJgV3EmyXzJMy0ibjD9qj8GwnE0fLGld6N+vCUJfe0vwKaedh9KSHCLNaTE
         N3hcbkkmnY/Gp8sMHlQK/ngjoRzRgFT6cO20agqouyY6jUPNHmg/kiZTDJkiAnxlq+
         GQe+6saKXwHatLjEjQ0rAHfTN5naQyy3eoAHMRpi2xfN0G9EkRWdPmWAVMCU1aBYrs
         H5hvy2G9M2Ocn3RzDuq1t8qpU3hIvFq//NSsNbaM5vixgevgsE/TUWd2AUC5xqlBlN
         4DnfpYNJ7hAnQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 09/12] apparmor: use get_unaligned() only for multi-byte words
Date:   Sat,  8 May 2021 00:07:54 +0200
Message-Id: <20210507220813.365382-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210507220813.365382-1-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using get_unaligned() on a u8 pointer is pointless, and will
result in a compiler warning after a planned cleanup:

In file included from arch/x86/include/generated/asm/unaligned.h:1,
                 from security/apparmor/policy_unpack.c:16:
security/apparmor/policy_unpack.c: In function 'unpack_u8':
include/asm-generic/unaligned.h:13:15: error: 'packed' attribute ignored for field of type 'u8' {aka 'unsigned char'} [-Werror=attributes]
   13 |  const struct { type x __packed; } *__pptr = (typeof(__pptr))(ptr); \
      |               ^

Simply dereference this pointer directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index b8efbda545cb..0acca6f2a93f 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -304,7 +304,7 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
 		if (!inbounds(e, sizeof(u8)))
 			goto fail;
 		if (data)
-			*data = get_unaligned((u8 *)e->pos);
+			*data = *((u8 *)e->pos);
 		e->pos += sizeof(u8);
 		return true;
 	}
-- 
2.29.2

