Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B566328498C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFJpM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B836C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bb1so952570plb.2
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ux6BIm5/rJSpjWcuZxKCIwp0MrSLeyKL6rWTSIGyLyg=;
        b=MLIlWw93PBHBMVkQQHSTClS18CV1OGZYVrm31xEY1AYwuxeU8tfsOvwlrjuHcVKkNS
         uMfICWKy1e8zQCEbFz0ZDtVp5xLtL4h5V2bYgGNnISKhl3jCZDRPMc/ykAPxFC4FcIZJ
         8NPdJCpkli/vHiWvnhWy/QEREnRa4jtWKhvGw4/ZlI16ypeK1HU4nZzLXj/f0n7g/Xnp
         nCK8i9WzgYfN0NzSEGr/QkFV4aaRQKC71yjhegy+VDBICfZt+avELrSQS7D3aYnIa89N
         pCnwk8rrd9vhF3sEGp4T4PbAqpbVQAcZZ2nkkRE4lgGHFK1NY26uxdA+5ebXXY3He8cj
         3Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ux6BIm5/rJSpjWcuZxKCIwp0MrSLeyKL6rWTSIGyLyg=;
        b=PK4tNN4SaP67uQ20agjAzo9E2ut56yMJTBEje1jCiWlqVOq1MiEUeYzt072ySEKS6e
         y0ojRd3A2/Jn5iZmDB5G0ABuz8DN7SU7doIXVgy5gVF7AdkjSoe5ETEK9BTAXHD3i1/j
         yKfLkq4x3HrXJJFXEIKLLB4OL2x5Kbj1ZWYrlsFnPJHXA4FDsuDurqu4eN1lw4UQJ1pB
         qzVnkldL70vy440rdHBc6jR85hjNtNWucIgGYPLCcpTTmbF/4H1Tr7ltPCZfLlQ/cm/+
         WJWcHOpPfZgaqdsEcgYQckESXkis83ezvWmFeSbcvt3OClITIYjzy2FUDeSgWAxV8Xx7
         31SA==
X-Gm-Message-State: AOAM532wMP49wZLzK8dw3Y2OWb4DOlU+jXfSGBHYUcSAneJYmy8czu2Z
        GJ18ryYxoUDvvMJ1PqOBk8Y=
X-Google-Smtp-Source: ABdhPJxaTBmfKTZ40FYajSYtUyNW9LKvKysTXfe8tNTmsB2mgWpfGKoowauomGZFTllL8YXC0hBe3Q==
X-Received: by 2002:a17:902:be06:b029:d3:e6c5:52a0 with SMTP id r6-20020a170902be06b02900d3e6c552a0mr2458543pls.77.1601977511645;
        Tue, 06 Oct 2020 02:45:11 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id j12sm2186241pjs.21.2020.10.06.02.45.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:11 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 6E9FC20390F4A0; Tue,  6 Oct 2020 18:45:08 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 06/21] scritps: um: suppress warnings if SRCARCH=um
Date:   Tue,  6 Oct 2020 18:44:15 +0900
Message-Id: <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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

