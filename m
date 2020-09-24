Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F61276A53
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgIXHOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgIXHOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:14:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5CC0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d13so1350990pgl.6
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ux6BIm5/rJSpjWcuZxKCIwp0MrSLeyKL6rWTSIGyLyg=;
        b=WtO/UiL/zz4M8ysG/wBE+QP2vtWwNvlayy9W4Xt1Xk9ZKr36gU4V6bVUIXrG3hvBS2
         afq7yUqRvk9NKC56VGiOxe46UWu3YEPgJBUcZpLmj55ULEovrvPk9G6HTTpmV2A+HL5V
         14vqCGyxls2v6V5P4A/ZCjkp0kundR0PIMGuNrfkMiOmb59qUcL7xDTfLiqUIdLHv4w3
         gAEswgmqwW1IkiLjSrucycQybScELl0jZGqZL1Tt2AA2JngL7njO9Q5W+6/JNlm4R9hs
         tysBVB1oRFlHyx7+lI8Z+zVu7Spoc19YsI1kk1rXAkmMbcJsgVE3bD7+ZvrHyRnJjGeb
         c7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ux6BIm5/rJSpjWcuZxKCIwp0MrSLeyKL6rWTSIGyLyg=;
        b=sZeJs58sPBGxr3D0G5wahqg6omCt8/Wbfz8Ip2oA14reebZoSNhJJDX0WgGLvBEZ6+
         TmscYOvB5H0YWsjc3TqtP1KghXdIeczDXLyjE18hvAOM/vKY+q079VmP/Shwp4rHEQWn
         dwgcgeWxo7hcleWvc0jOU80YQ1Q8BV6a04Q2TLlk1Q/l+27dS/bOM/viRrArPQSo3fPy
         vHAzca4XyBvdWk2+qnPPE1TkEeY3pAzU4yPSj4Q5SnfBrJSbkwYk4+2ZKjBM8XspV60W
         Vk+Q5wHXBMdhSB6UHY2vLZGqpwkdhNyG9UgbB9URhBQszm+v2YaQNVEWweQkz7LEbMGq
         9KCA==
X-Gm-Message-State: AOAM532Ht3DjFsoES7yGi1yYzDtX3/R8Ypw/D4cwLZsX0y3ZFaxaKbWY
        gSZIGObp2z7WrxR5IgSIuE0=
X-Google-Smtp-Source: ABdhPJyQ4zr142YUwOvfs73T/SmyGr/3TkkxuGXP7bAaMT5m/1RvLOe1H4VGMDWeqOBTjEbE+Pcwsg==
X-Received: by 2002:a62:6490:0:b029:13f:c196:bb77 with SMTP id y138-20020a6264900000b029013fc196bb77mr3255458pfb.14.1600931679391;
        Thu, 24 Sep 2020 00:14:39 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id q21sm1823229pgt.48.2020.09.24.00.14.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:14:38 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id D9E782037C207B; Thu, 24 Sep 2020 16:14:35 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 06/21] scritps: um: suppress warnings if SRCARCH=um
Date:   Thu, 24 Sep 2020 16:12:46 +0900
Message-Id: <de27555d492b9797b41a4a98c278b8421cd643d2.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit fixes numbers of warning messages about leaked CONFIG
options.  nommu mode of UML requires copies of kernel headers to offer
syscall-like API for the library users.  Thus, the warnings are to be
avoided to function this exposure of API.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 scripts/headers_install.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index dd554bd436cc..8890a0147012 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -93,6 +93,10 @@ include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
 
 for c in $configs
 do
+	if [ "$SRCARCH" = "um" ] ; then
+		break
+	fi
+
 	leak_error=1
 
 	for ignore in $config_leak_ignores
-- 
2.21.0 (Apple Git-122.2)

