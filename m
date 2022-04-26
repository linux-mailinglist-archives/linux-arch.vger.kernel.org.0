Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C850F396
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbiDZIZY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344591AbiDZIZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 04:25:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF903A5C3;
        Tue, 26 Apr 2022 01:22:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id bx5so8040613pjb.3;
        Tue, 26 Apr 2022 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ry61oQOw1TxefJWFjV86DTJxbbTM3u3aRIyja+cc07w=;
        b=hYJberNWpJnZgnTf9pcAYGQU8G2uGwQ2H/D/mBrao6r6L3a1I5qEFJkqTZs4lJea0q
         ctvAk6eqcD2ijFAs7BGRcE0NXBVDrJsP5Ff2/ZUetBi7VGCIMp/dr+E++nYuYJQ6Jlh9
         gp5hFY/7219vQgRGSf5PglWn/eBG4mcEu+hNp/JWpOviLN4sPKKOVq8/SzswSPVvMLHM
         APUJGGc246PwSz7zG0VxqC2cETjCATQuy/z3U5uJn7sCQlBNhhMzS2IkHTH6euQ6H/Kw
         Hj0x+4nk/QT4/kzlUQAuwXJjB3vjImdFqxox0NBReIszeeZNyysFeZKCwUO/DOlKYyEx
         s5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ry61oQOw1TxefJWFjV86DTJxbbTM3u3aRIyja+cc07w=;
        b=miiCMD2tsr/YmB+jQkQXDk2/oR5y0tKJihe8whwCnVkKY060X7mvbBU0cQ2I/vkIX0
         bOhxeulxbKhuJfCg2xTfrzk7UaWLijm4pVVfacHcq+c/yILJ3gO2Xlun8NKS5zRcgbqG
         55CQtzIpms4FzQybpm7aH25nEC7RogOY+OQ1M40ohX5cwC8/YzWJ8VJY6QqxkKXJPspP
         Z+Vt+w6HbmH6jV8ZlLXvBpN0gjc+d9wL8IRmfmamYln6copYez+WPEGmmwpyvIfYZEhH
         /TmCBgFYzmucrzOpCekJhr70h+OtVlnaakJworPWRM58uHsZ+1P1GHs44wrdsmq7ANsS
         cq+g==
X-Gm-Message-State: AOAM531nd6bN63Ktv12vyWZp9ue0gBr/a7KcH7dFhQ6PUphyiUo3f7i+
        xw+d+nVsdHNgiGwwQly4HlA=
X-Google-Smtp-Source: ABdhPJxNiF8zanUQKYJ607EC0HUpOomtgJ/TOStVYGUmh9XKjhgzkTyZdlRXyDGwNaSRPD1rBszaCA==
X-Received: by 2002:a17:90b:304:b0:1d9:752b:437f with SMTP id ay4-20020a17090b030400b001d9752b437fmr10486148pjb.242.1650961336347;
        Tue, 26 Apr 2022 01:22:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id s61-20020a17090a69c300b001cd4c118b07sm1879143pjj.16.2022.04.26.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:22:15 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Mengen Sun <mengensun@tencent.com>
Subject: [PATCH] bitops: remove unnecessary assignment in fls()
Date:   Tue, 26 Apr 2022 16:21:55 +0800
Message-Id: <20220426082155.10571-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

The last bits left move for the various 'x' in fls() is unnecessary,
and remove it.

Signed-off-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 include/asm-generic/bitops/fls.h       | 4 +---
 tools/include/asm-generic/bitops/fls.h | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index b168bb10e1be..07e5cdfc3b98 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -32,10 +32,8 @@ static __always_inline int fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
diff --git a/tools/include/asm-generic/bitops/fls.h b/tools/include/asm-generic/bitops/fls.h
index b168bb10e1be..07e5cdfc3b98 100644
--- a/tools/include/asm-generic/bitops/fls.h
+++ b/tools/include/asm-generic/bitops/fls.h
@@ -32,10 +32,8 @@ static __always_inline int fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
-- 
2.36.0

