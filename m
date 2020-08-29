Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1847A2565BF
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgH2II3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgH2II2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:08:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A91C061239;
        Sat, 29 Aug 2020 01:08:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so1116414edb.8;
        Sat, 29 Aug 2020 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5mWbp3HU90BdNQ7rwYNrm+iZpbbCo//6v0CsR2ScTo=;
        b=HNV5sTGBJei4CoC5F0yvmkYacbYaXfwk5+V9wHeknCa/gNSGZgEjbRJ8WXkiFHTGcK
         EkPUTt2yvr9Qsq5785clLn+n2pkpRbdm8l3gU7AESbbdHjnjlsxu54ZoLRLh3MCoYswQ
         bbWNnLPPjWAFFkm8jQZHDLsPouU9/4rxpQTnA6Tl82SfbSJ62mwUMKl96JZZxnyOrOnk
         Rz8z9zw6zA82MFPV5F+sST95sQmtpdisG2YGjqSAzzcu5/UGITVhjNAv5CIjU0KKkeSr
         3EwO4cZ7ZMj5w65EFZ36qSRtoYukUq01QvGhB/uQtFB8NRUIsuouzt62Pk7aACSenqnu
         GVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5mWbp3HU90BdNQ7rwYNrm+iZpbbCo//6v0CsR2ScTo=;
        b=s6ST60SG16d2fQTxWxKNcau99XNtnL3eTRaW3+c6PLMIrJVJozIZsDpmV3y3+jJTnU
         dS9JhpJP3G9+ykGPDcl069fwy1SadjrGZRwuwZvT0gAt2EfNju6soE/WotPxV8lXTl5G
         s/VfvVwL8NhhGghIfMnAlGlG5NUSYJbxt7AIGLTKLdyfax565bsgqbk1DJrM4I2rRvXq
         uBbcmczNrnziZFZ7HfBnz5HC4tZFPmiLX+Ph2ezl2Jyqr4qvWsbNp7r2fvpRcAYFj7cO
         uvoXtDZpbhqiRqjkgMhzf2ma8IfDbcpWcS2SbVP1i7fB1hMoHWrjdXCrcllBh5ZP9Dv4
         C9lA==
X-Gm-Message-State: AOAM531tkyw4KHzyW7AVnFNScjjTrEh2cGyl9bcK4doOMVrFGJ4S8tWd
        ju/hm8uvVpf6a9CVWPe0aPk=
X-Google-Smtp-Source: ABdhPJxqeivzAIry3yfEOLj0D6wE5v1ZmWFvaO/b6GnMmguq3NQ+3O5i3ibzz3wyKev3+Z2PrA7ySA==
X-Received: by 2002:a50:e38d:: with SMTP id b13mr2542844edm.314.1598688506038;
        Sat, 29 Aug 2020 01:08:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id h25sm1568923ejq.12.2020.08.29.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:08:25 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/3] docs/memory-barriers.txt: Fix references for DMA*.txt files
Date:   Sat, 29 Aug 2020 10:08:14 +0200
Message-Id: <20200829080816.1440-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829080816.1440-1-sjpark@amazon.de>
References: <20200829080816.1440-1-sjpark@amazon.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 985098a05eee ("docs: fix references for DMA*.txt files") missed
fixing memory-barriers.txt file.  This commit applies the change to the
file.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/memory-barriers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 96186332e5f4..17c8e0c2deb4 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -546,8 +546,8 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	[*] For information on bus mastering DMA and coherency please read:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 DATA DEPENDENCY BARRIERS (HISTORICAL)
@@ -1932,8 +1932,8 @@ There are some more advanced barrier functions:
      here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
-     information on consistent memory.
+     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
+     more information on consistent memory.
 
  (*) pmem_wmb();
 
-- 
2.17.1

