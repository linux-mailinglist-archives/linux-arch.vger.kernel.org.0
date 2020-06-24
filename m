Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91963207D6F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406653AbgFXUeL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406551AbgFXUd0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:26 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF84C0617B9
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s20so2489945qvw.12
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wwQ0FnciQOJFFrw9pZwNR1174M1Ii6KWK+Cwx1DZR0E=;
        b=D5jMBEz7Lm5U+UfoGelxUyQqWOYc6Z+dLXzaDR1SoyT3D0mSDtKUxokHJAk6ca9TzV
         4mueVog2jOcmVS+jVjlFOcthTwG/yiHbkE9KBrSSXn5wKv43C8TlR+Cgbt0KoNrOQO9O
         owGlgSWarEMzSBvxtlWzfcQXQKNdv2ZE3V35XOQO9JLobrLz8Yl2Oqg2ofnVQSUcX7cV
         WTnphEXJJam/USPXIaROhEV6UnjgXvvwGpug+fLsCxrQtPsDK3qYgboxAvYEWoFvxtr6
         m6eXCYH8PEMH1MvefhDCIQOQ3Zw+2VmFPtKpPIPHPwUqkF/2Zm2/4J+lIul1mO034S+9
         DBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wwQ0FnciQOJFFrw9pZwNR1174M1Ii6KWK+Cwx1DZR0E=;
        b=bgm/cus1UnJxO34p2uHYaFbXUxklFYJCHm+7SCZHtv3WmRnlzk9/nX10XjIaN54EkH
         kh9RgaNu7BASYTYFq8350T5xsAWO2O2K/KuYRPqoTWpOm/sILey0D1303pjDVfA0hK/f
         hqfTTC7q3TkG7PNdqP7jyhExlQuUdyM43jED78N5nihq0mVaVhIVu79hlt6rlCbm7yWd
         wZ38FSwYpdGu0WeN+VEpEvVGLUs65s4fqfyr4AKKiZANVQt5NobfRMuCFwzclkomTBtk
         Jd8eiwg8I4acK6yIh3iFnLlEmwFVlunIgmby+zBge913+uiMvSNfnxhEjLe089lE5toZ
         GwZA==
X-Gm-Message-State: AOAM531BFz2WhNh60U3PMWTLhUH5Z8wpPmy9GeoZF+eoMJxOEfWIy+bX
        E1voR2u7t+GaeUhlbrhqHNMug1DsiXwooy3dzV0=
X-Google-Smtp-Source: ABdhPJxdY2l3AI8wfRrd83iTVnOoqT0z2xypmyGa8SBbcpKlWTHBGxwu1psE5fER0U56oerLL9wNd1erMNW/Ru+uB28=
X-Received: by 2002:ad4:4cc1:: with SMTP id i1mr3207160qvz.249.1593030805093;
 Wed, 24 Jun 2020 13:33:25 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:53 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 15/22] drivers/misc/lkdtm: disable LTO for rodata.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.27.0.212.ge8ba1cc988-goog

