Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9394A256619
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgH2Ikr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2Ikp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:40:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830AC061236;
        Sat, 29 Aug 2020 01:40:45 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so1182741eds.3;
        Sat, 29 Aug 2020 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgnMShIR6M9zxB3f3djmyVOwSU+pv1up9yjWprNIX24=;
        b=nSPyGnDf1Xluwc9TQGXjHiOUyBzSSfB1VbP52G45UAfIsYoVh/5fN1iqNm/rfHj1Vj
         fR06QmVPxqEXVBVnnx357v5w9IxAsL5lyH4I7exXUfY3cBWwKRW0wwGrtyb0IyE17/z3
         ZbuH1wIELckgPtcG8a+VWtU2GuKUPk+dCn/z0wAXgq1HX425O4OiVYlJ8PUTNy0deOCF
         G1WH0rvDMNrQ6njQQTytV9MlaeboQ1rA4oNsROUuz2YrjBYk1v1wa3tCyKopwWWdGgDo
         Cczv6qeejbpwLXIMl/B/DqyJlonmF97VJYnWyO5G16P1MM/Qle4PuWEbmEepwLWbUyWj
         Ccug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgnMShIR6M9zxB3f3djmyVOwSU+pv1up9yjWprNIX24=;
        b=bomFc0eQGPf5oH1v2t3TEjLsSIZYBytjpvjuh2sWK25WXWANtkIySylL0bkbWMlLjI
         yRhMUBwxgwfo3UuFNtV4/Bw41aFRNTDhBTxGyg1zLLlKP6Q/cfMqhLu6QGg2dw2jQohI
         Lmlhxbjj01E4urgN01JgFgae9l42SfPNwxbqwzcLkAQZudzeVX83pcNkw2PTJsD/xzwX
         28Sr05hWtX6WDS56llRqcf6Fq89s405yayGTZPVNIe+CU/9F6tRE7+LrLFLeRdeRNeL2
         HnzE+zQl05zu1foi1/XU1aAvhl42v+2q07UlC/9qDb1ryywS2ATm8tqviE+MyY939xTb
         3E5w==
X-Gm-Message-State: AOAM532B0ouKzptEd4VdnLuLhTZzHTMDsg/pUZxhqokbJg73xXAYLLxj
        q4hz8j6ZpHVHh9ssrfFjncbyqIlsLAY=
X-Google-Smtp-Source: ABdhPJyVprHNM1Z7CZo72TVXNBeylOAwrVhjSACju7p2p2Guqh2L6dtAJiE7SGM+dAdr9+JhjeeNig==
X-Received: by 2002:aa7:c6ce:: with SMTP id b14mr2724488eds.208.1598690443845;
        Sat, 29 Aug 2020 01:40:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id o7sm1536215edq.53.2020.08.29.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:40:43 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 3/3] docs/memory-barriers.txt/kokr: Allow architecture to override the flush barrier
Date:   Sat, 29 Aug 2020 10:40:27 +0200
Message-Id: <20200829084027.4591-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829083819.4350-1-sj38.park@gmail.com>
References: <20200829083819.4350-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Translate this commit to Korean:

    3e79f082ebfc ("libnvdimm/nvdimm/flush: Allow architecture to override the flush barrier")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 291039d77694..64d932f5dc77 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1904,6 +1904,19 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
      "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
      위해선 Documentation/core-api/dma-api.rst 문서를 참고하세요.
 
+ (*) pmem_wmb();
+
+     이것은 persistent memory 를 위한 것으로, persistent 저장소에 가해진 변경
+     사항이 플랫폼 연속성 도메인에 도달했을 것을 보장하기 위한 것입니다.
+
+     예를 들어, 임시적이지 않은 pmem 영역으로의 쓰기 후, 우리는 쓰기가 플랫폼
+     연속성 도메인에 도달했을 것을 보장하기 위해 pmem_wmb() 를 사용합니다.
+     이는 쓰기가 뒤따르는 instruction 들이 유발하는 어떠한 데이터 액세스나
+     데이터 전송의 시작 전에 persistent 저장소를 업데이트 했을 것을 보장합니다.
+     이는 wmb() 에 의해 이뤄지는 순서 규칙을 포함합니다.
+
+     Persistent memory 에서의 로드를 위해선 현재의 읽기 메모리 배리어로도 읽기
+     순서를 보장하는데 충분합니다.
 
 =========================
 암묵적 커널 메모리 배리어
-- 
2.17.1

