Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD31256607
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgH2I02 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgH2I0V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:26:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C2C061236;
        Sat, 29 Aug 2020 01:26:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d26so2181406ejr.1;
        Sat, 29 Aug 2020 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGxE5iVMJIAPYbJwO4mlzf3m+7Fq9NwJmmwIOsdc9BI=;
        b=AuSV/ffeCYaki1wykokBx9Nh/Vuu2aM/NfeGTgC1xOtOFRU8mO1a6rsywq0CYYtJtB
         o0W4zzPrJBoL9ehIfmlU6+Enhko2v7rd7j2bHS5BnnQ2K0xirTDpOcbOKuCz2pii21jc
         KXh9TG+wtHCsbbviE4BmKV8ExwJ8uiZ0ILW2Z86XXgN+EJYqJq6ODyH8acKkfdL+NcKz
         OttJUcU4nAMgEhXB26SQmF9gpQvfulCUeCeKoAW+dcRM4akKK7xj8fgKqM2wA/nLG6mf
         fXHlD8Pfu/dgFF4dA0CbSAGpiLbiODMy9Oce5mznMWF+GYPmwPTDQd9pF3FCxKb2yR0J
         1LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nGxE5iVMJIAPYbJwO4mlzf3m+7Fq9NwJmmwIOsdc9BI=;
        b=Tpsg2IYlh7iTab2gHHn5X6fQvLnUyUUduPTwRcEL5nLDr15K824QjhqzSsg6pfZZpx
         4XZooeny2RImo361Trb7IbaITbfAumw9V+O9/2r6SfBrBzYmOqRQDKX0NA+DX4B8ulH5
         9e8ICiC8NjtNcX0RK6yuu6U1IaivDlfahD4ZteXg5hDocqHIw+bsMA+nklhTsC9a3rPE
         RA+2aFr9cRcT3JuM6JWcWfh+hHc25lh8895OlwK3oezq7BIf3HVoVrbg2wTvVBLF6ocq
         XpsK3zbRFFr0ZuEEMCxmdrzYFXIlCpbQyoaVy7R27GlxdKngk1NcYZELf90mGhUShEX4
         HCQw==
X-Gm-Message-State: AOAM530JGCsNr/F17Vtswl/+XR/pQQP29d6xxLL2Q46FkIOWSSydf8qc
        upo/MhHtycIl6IEBefOF2whs+GVl5dA=
X-Google-Smtp-Source: ABdhPJzrJWw9+EEoa9h9T6lBn+kNcTjOgG5b2t0B9bS/x5tEMoHUhlI0ZL12Uau6bbAUMcIMm3epYg==
X-Received: by 2002:a17:906:7f99:: with SMTP id f25mr2551129ejr.307.1598689580025;
        Sat, 29 Aug 2020 01:26:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id b23sm1566538eja.86.2020.08.29.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:26:19 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 1/3] docs/memory-barriers.txt: Fix references for DMA*.txt files
Date:   Sat, 29 Aug 2020 10:26:05 +0200
Message-Id: <20200829082607.3146-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829082607.3146-1-sj38.park@gmail.com>
References: <20200829082607.3146-1-sj38.park@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

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

