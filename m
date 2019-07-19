Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B16DD04
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 06:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfGSEUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 00:20:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40909 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388840AbfGSEUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 00:20:03 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so55661645iom.7
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 21:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=y7QcXz6snFzqEHX9oNiwROmLSfrbhKnVywQpaDFxKjU=;
        b=XBMc40+zE5hV9zvUK7QKYf84WeaZeVOkHEc+Ym7qahSCly2JPuO+wQ8TMLmOlquVIx
         ZOh7vrznORPoqN9Tk5Vy4ScOe7tXXzyVDkJmHmgSqcKTiL1JAUpA3JP47Z74JkvyMKoG
         Vru5wrI101h3kL1Fmmr22gglG4E6Gg7M9VEp7u6I4WoKhlt+iT9Hefknr+x05v9NdXh3
         Ol6fNQLRfAYllDwOtTVJulMat9PzO4gQsnKKY1BKcAINbgC1gOsqYc6NzQ5+wfbg8jar
         054ZQEV4ZYt2ryIpvydkJL2E2i9kvSUaTHhVznB3dTk8d0jWQU/WsRsAfLEAHW/cGuzf
         sZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=y7QcXz6snFzqEHX9oNiwROmLSfrbhKnVywQpaDFxKjU=;
        b=bRUrvSsz77Ycy4cytCnXe3IMkW27tK8GKoz6Tk0UbpKKWKhlSuV5FOPs7uCgeoAHvD
         d8v6VJRBhuE9Svcml2+I6buEcQ1egInOliDG2TbQeFiH7LTrbU0KDDuESVDG+orSf4rI
         GieABcWa6ZS51LkeJ+ZrjNbDNuRtRkN6lqOtOieUzxl6dAo1/W4uXmZqXzX3GtK4ZCRw
         FI6cS9mWjQPW5d9PShSdLExA/Lcal0LleUCuGG4uOAhOXVdJZVy/m13pr5KBCKHQe3Br
         LQLGY/Pc43gutDLmN/9SXy8KBh87yXB98+Hc2pEd9LMS+P8eoNKcYkowiMSxhojZTuJY
         Pc1Q==
X-Gm-Message-State: APjAAAW48pWLAuye6/gEvR+GLFMgrpbGShwRFQf4jzCCLWsb8AxmxJBV
        tYlGMoTgJIu9gXE9Ud3qXvoWwQ==
X-Google-Smtp-Source: APXvYqzGiWfVK10x/o/hAhjT31ymV7flaSQ4nE5/whEi7UQaYFpREf+rTapypi5WrJkv8Azrv/2p7w==
X-Received: by 2002:a5d:9749:: with SMTP id c9mr48787103ioo.258.1563510003006;
        Thu, 18 Jul 2019 21:20:03 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id u4sm31205266iol.59.2019.07.18.21.20.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 21:20:02 -0700 (PDT)
Date:   Thu, 18 Jul 2019 21:20:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        christian@brauner.io
Subject: [PATCH] riscv: enable sys_clone3 syscall for rv64
Message-ID: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Enable the sys_clone3 syscall for RV64.  We simply include the generic
version.

Tested by running the program from

   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

and verifying that it completes successfully.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Christian Brauner <christian@brauner.io>
---
 arch/riscv/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 0e2eeeb1fd27..13ce76cc5aff 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_CLONE3
 #endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
-- 
2.22.0

