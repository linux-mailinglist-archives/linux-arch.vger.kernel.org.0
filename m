Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649D83806C4
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhENKF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbhENKFx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:05:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06F3561453;
        Fri, 14 May 2021 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986682;
        bh=OqPJbwQLTk0vAGOMLa1o2NpwJONt25fk0xR4fYFAtYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlEMdhyUg1QWWVZWtut5Kwb1vnnlqrNSlx/1E5bM8KOsjwHLneLzRRLbIsr5dL+PP
         dZlnnMge9xnfEQNcephoE/9J/AjEEqQE6dmwM60ch/QbCpT1RNy8V6zVQaSwAgusNv
         8TjhbqpbSE/gAYplGw8KwGGPvbHbcY3GPFdO/rxqd1YVVN663PqR6LwUu7kf9ld6B5
         AuPYDbgqfR7OYuOTeWbQhIPaxRw2UewYXgKKFnvq5joD/RnFjw6IhOd/MG4f4MV5ie
         CqfcnADD1ykf4xMpaQiJQCfoiKHL+KV8TIBntt4O2fQkPnMWZkvRZ0fK6SgbBNLFfM
         AbZsGkymmiUqA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] apparmor: use get_unaligned() only for multi-byte words
Date:   Fri, 14 May 2021 12:00:57 +0200
Message-Id: <20210514100106.3404011-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
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
Acked-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index dc345ac93205..4e1f96b216a8 100644
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

