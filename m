Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906A6F3F15
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKHFDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38610 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHFDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so3250440plq.5
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxJBcBRow1AvQI6ecmVgHCS/pUSBuJYc9TYuMuJ/9+8=;
        b=FRllAVZrda6jMCsSgu5V7aaOLbxuTjxOdk9PQpdfqtay0M/yIOVAcz3gfFlpwLFFUy
         S8vUSUEyLXBntqowdhUZvNwugxMzZCS+4/r2doHwUsm9f43F59zsGvudetTbekE815Vw
         Y2/LDc128I4J/i/W/jQMI8cZjCJh12s53o9esOZ06oZU0vwggjWFChnFBieju6tWWk7A
         /gDBdDYBfitR27LrMG/VC4np+yVO48p9QZoxgJUQbFygWNAPYMSqjNI+TlVP2P7k+eFI
         FqIyd2b0JF4qcX+HPs9ZcakfPXIUDPO8T4JMIpUsrOUXZu6a2W+RJEccy+yP1Uv51v+f
         IfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxJBcBRow1AvQI6ecmVgHCS/pUSBuJYc9TYuMuJ/9+8=;
        b=jJ2Crnj3yGUw+r5AWC5X6ci+V3W8Hs6iIFGRPohNjL7jsbU8SZ1W1jq6fMTIeEd4FN
         ggLegtmjtzyRlm1yLYvpwLOzSWZIFgUOSJvozZCJVtaWLgSLStB4CqeE1ZdA8b1G4vup
         S0QDs0TN3L9VuMiKLA8anyhbZCwvdi1vrfAVyErO4DOAuAOYBQkVhwBzjk4EvGa5sBo1
         ibqzxpZuFDuawgGMJONk7fLeY6vCqrFr8kQ1HTVv3Q3+SNcrGFSuyKVBgboAV6uatBtV
         grcHvZnYidHpob4awWJdKQ774GUx4oxa0ug62Z6IP/wQj4FsFp+USZ+lcC6uLYFBC2FC
         9J3A==
X-Gm-Message-State: APjAAAUvSP/Lc4FvhjZJWYaNsJiUiM72plQgo2AQvdNqi5LF3Y87GEvq
        fM5jcKXvR5uoSPRwMySqMyZwAlDvBTJNsw==
X-Google-Smtp-Source: APXvYqyHAIakQgLUm4cLJb+cpxpiOCi3L7tXPMzg6kR+Di4q02niLoBC0u80z7GD7Ntx5rUiiVMIOA==
X-Received: by 2002:a17:90a:24b:: with SMTP id t11mr10776362pje.77.1573189384508;
        Thu, 07 Nov 2019 21:03:04 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id c12sm5559511pfp.67.2019.11.07.21.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:03 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 9D775201ACFC45; Fri,  8 Nov 2019 14:03:01 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 01/37] asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
Date:   Fri,  8 Nov 2019 14:02:16 +0900
Message-Id: <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
are not compiled due to type conflict of atomic64_t defined in
linux/type.h.

This commit fixes the issue and allow using generic atomic64 ops.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 include/asm-generic/atomic64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d4450f..9b15847baae5 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -9,9 +9,11 @@
 #define _ASM_GENERIC_ATOMIC64_H
 #include <linux/types.h>
 
+#ifndef CONFIG_64BIT
 typedef struct {
 	s64 counter;
 } atomic64_t;
+#endif
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-- 
2.20.1 (Apple Git-117)

