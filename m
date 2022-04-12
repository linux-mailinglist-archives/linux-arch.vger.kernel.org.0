Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9224FEA83
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiDLX2j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiDLX2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 19:28:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915E78912
        for <linux-arch@vger.kernel.org>; Tue, 12 Apr 2022 15:33:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso4427451pju.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Apr 2022 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFSlDAEzxG2DmB4Xo/jpKWlcMReBrQbKvAja9Mz03WY=;
        b=BAgyN2cjIkVkau6NaxZfdrINA1JnGPeOxEMSQIuNw88cOd9poeQU7JYlOrJo65FxMh
         SBZgNZs5Eozgz9MxeaLL6P9JPOH5DJW1eYYB93FJ2KdIzLY35CGr7lfUEU8C4VpTHqN3
         NKIU5fUui4D5BaZHPQ5Pgq3P7eJ2M8bgOu89A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFSlDAEzxG2DmB4Xo/jpKWlcMReBrQbKvAja9Mz03WY=;
        b=e2LJCcUQ1kl0mzHkRHffS/FjnTFb8kaI8+HkjUr/7VtZnUm/bEWQR/hCcB7EqJ7Ikn
         eo0YgUfiTz4eYduY5pvr5Lb89J+aZQiupqwHjkH9N2Bz9XkA1yv/De0s/Vy/DqaajVJY
         a8zRu+10I9/qWTPSmVoWzDXvImbwDEdV/DurfR/nNEZ6aFi1FD+DUr76OyOklQ2bvc8x
         r8kfe40AVQx7ArudJxDvHMW6R5Drfp1tD1fHUJH/+hVDhBJ2EYlNjSFZXlAhQ7EuZoZd
         244ABktNis5EX6fsEGLxoJSASAHig4OGf9QugG13/7c1xGGx4QaV7kqGlxJOWYzl1iO+
         P34A==
X-Gm-Message-State: AOAM531xWxbdQsre4pziibDRglX9O9rUQZtdTnfBddhz2FXcIkxvLEwL
        rB10/UO+v5wXW1iP31M5w5bSiwDrFfmqfA==
X-Google-Smtp-Source: ABdhPJzbjoFfvbiVhFHrd/ap9MG24S9rnvtRGaAqVEv5YOwoNHzH2GnHp5wYCqSOLPVNm+CpToaQlA==
X-Received: by 2002:a17:902:e84d:b0:156:bf35:6449 with SMTP id t13-20020a170902e84d00b00156bf356449mr39376031plg.26.1649798738080;
        Tue, 12 Apr 2022 14:25:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm38747092pfg.133.2022.04.12.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:25:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] init/Kconfig: Remove USELIB syscall by default
Date:   Tue, 12 Apr 2022 14:25:20 -0700
Message-Id: <20220412212519.4113845-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; h=from:subject; bh=6oMzRtW3jqjXSXD7mwm7E3NvhHShAvTH9FoLSWVAO4M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiVe4+5UcWIk2DLvOe8RGsuRpGeIvF3QQi+b9keWfe ae+3yXGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYlXuPgAKCRCJcvTf3G3AJkLiD/ 96HnJHanZQA4f1r3EyXeSCTJK9Br96PbdgM0mL+dn+KI2TY5vNV9yastv+A68vDF1obNNVqoReykC5 5FN5BcdjFCoiim0fnBWl4jfiIL2cWZh5j4Yy24c2l6fo18d5VLT1I72U1VTkxOtR8M+oywg0x7RUj3 oWVEcGIBOfHJ49YBhM+Y/suTJEuCVy/+WMLl2miWyTj5iO1mNfn5mClXdG5B5HJlwxlULu9LijoC5L LUw+yx5pA6uq+8TCkkkMqg3L+242aXJ9qrUsNPbzQOertituEAg6BTEcLB+0mvw56CjNLSKeuXCujP VhSbgWg9jIfAwh4njrUTNuhpCdsvQcpHwq2EVl6M58ZEgW/r55JXgZ7GEqvHy/EXU130mZ01OcyBOD PWsleIP4AuCncIMwLoJdmCct7m76kqBt+tpD9eapWSat6+Rm1+21ajAidllEIIguzs12iXm35LCpiC IT2f/oKL99C79d34/n8pCbsaSJiIVW8TjmNQX2NtFt84SyM/ScriTvsbQIQ3WD3qIedxUGg8iEkQ+I 2oDnhfLQ0J0leXj7EqVIgepP9NEd+dGTxVnbg3OlYRbCbbx2RilC5zweK4hQoim5epE4p4oSWOg1Tb kHXFcL/j/XLHkgOrIC3BmKfszU+YZK6oJBJNO3fhyuHnHzshnZ/OurXaEt4A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The uselib syscall has been long deprecated. There's no need to keep
this enabled by default under X86_32.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..5cddb9ba0eef 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -435,8 +435,8 @@ config CROSS_MEMORY_ATTACH
 	  See the man page for more details.
 
 config USELIB
-	bool "uselib syscall"
-	def_bool ALPHA || M68K || SPARC || X86_32 || IA32_EMULATION
+	bool "uselib syscall (for libc5 and earlier)"
+	default ALPHA || M68K || SPARC
 	help
 	  This option enables the uselib syscall, a system call used in the
 	  dynamic linker from libc5 and earlier.  glibc does not use this
-- 
2.32.0

