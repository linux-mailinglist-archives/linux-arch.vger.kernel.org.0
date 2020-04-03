Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD58F19D11A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbgDCHU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 03:20:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17211 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389177AbgDCHUz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 03:20:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48trv835QJz9txjs;
        Fri,  3 Apr 2020 09:20:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=l+jIG9oq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5wS7b9_ulMkO; Fri,  3 Apr 2020 09:20:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48trv76VHtz9tx3s;
        Fri,  3 Apr 2020 09:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585898451; bh=JLC61II4uokq7KTS7RbQPm5FmSCvhQoLsRB6ODnrrTE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=l+jIG9oqKo2ergcSx0CB8uXGPebP+BmjHsdA7/k6ncJ7MMqDM8VTh6/Ei43GdKGg6
         0kkdwyKbrJsABxMmCyQnlOw9Ppctg+EHBuoB6tkVOeed8KWUVT2pDbKHin38WR0Ysd
         hWXarkP7dxLG87ECVbBuwSltitJCKlO3jfnUCaD0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C08268B943;
        Fri,  3 Apr 2020 09:20:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LLPqqNnKx87z; Fri,  3 Apr 2020 09:20:52 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6839F8B75B;
        Fri,  3 Apr 2020 09:20:52 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3E8E465700; Fri,  3 Apr 2020 07:20:52 +0000 (UTC)
Message-Id: <ebf1250b6d4f351469fb339e5399d8b92aa8a1c1.1585898438.git.christophe.leroy@c-s.fr>
In-Reply-To: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/5] drm/i915/gem: Replace user_access_begin by
 user_write_access_begin
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Date:   Fri,  3 Apr 2020 07:20:52 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
that's only to perform unsafe_put_user() so use
user_write_access_begin() in order to only open write access.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v2: Rebased (one part of the patch flies away)
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 36d069504836..b4c903308590 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2794,7 +2794,8 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 		 * And this range already got effectively checked earlier
 		 * when we did the "copy_from_user()" above.
 		 */
-		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
+		if (!user_write_access_begin(user_exec_list,
+					     count * sizeof(*user_exec_list)))
 			goto end;
 
 		for (i = 0; i < args->buffer_count; i++) {
@@ -2808,7 +2809,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 					end_user);
 		}
 end_user:
-		user_access_end();
+		user_write_access_end();
 end:;
 	}
 
-- 
2.25.0

