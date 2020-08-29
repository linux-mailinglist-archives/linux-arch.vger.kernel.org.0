Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33A92565C5
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgH2IIp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgH2IIb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:08:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78ECC061239;
        Sat, 29 Aug 2020 01:08:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w14so1153066eds.0;
        Sat, 29 Aug 2020 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xSXJki88R/Q+T6fSRfPoG4+Pu0R/4p0TOoHdBe6ftk=;
        b=foXFP4TKja4qOPphKcrdGyfF7zgYBCakPUgd94pB/9j2PMaC3rMXbZhrqooeYxHZuO
         PcK4acSpVxE2PdM7c1lT/8zBFfXo7XH+ZyonWIxQjcSPpddfG4CZUE/BTeckTVfBViw3
         ElqKQJ0o6Z/gCrC9UiWlcxUJMjK8bfBQ6csOoGEobSmQANv9ZaX/nNRQm8dvoYy3ra95
         xQxAdhB902vVqw+wnjGh2qEWPbN94XvbY0AZeO9ft0NJaF28aCe39YNh2WnMI9jLhS39
         LexZyBee1JmOqZbsWfnF+dor8U8kF2mMWyjyvnYIo8wRDGv0VhcHDYJcJXr4cstFYAKM
         ZOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xSXJki88R/Q+T6fSRfPoG4+Pu0R/4p0TOoHdBe6ftk=;
        b=svfLy4egz/RSni2UjKHHiiRwy91N4RoSGhwoxQlEhtAv0eLrC0difcoNZRJfTGLWHC
         1Gc6dBwQT5zwrw/YCXwif6QEjJ7MjaYwQK25bJbGAW8rSKjKjw60mnVflR+GUIEB9EhH
         T0QmNU1HaiDyFDg34Bvmd6uFO8j9pBLwWoaEfEZaB3QsScs/eG5LYvKEHtxR0spVDgtg
         NIbhqMyKrVp5sDyo1AeUx4yJ6qvw0CIE5CfeIzhWmuwXazUzuCi/O9G+ePN27T5G3U60
         NnMIvr5naDpIfaRz4Q83SmzIlxTQ0QQxs41RdB0QtAszdkazbQgUWwjiAdyPGOlwRShX
         bQKA==
X-Gm-Message-State: AOAM5313b+Fr6yzVTykUkZhfi+sonU/WBEoa41DuQatF7g69mrV7pdAa
        2MD8HnuMVpE0nGwOmY1y5r0=
X-Google-Smtp-Source: ABdhPJyJhYjyzRBGCOzZjbpblqxraiBwQogtj8BAFLqoDF+iftWtwns4EHcAwCBO0DZqcya7cDk8iQ==
X-Received: by 2002:a05:6402:342:: with SMTP id r2mr2532601edw.353.1598688509413;
        Sat, 29 Aug 2020 01:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id h25sm1568923ejq.12.2020.08.29.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:08:28 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 3/3] dics/memory-barriers.txt/kokr: Allow architecture to override the flush barrier
Date:   Sat, 29 Aug 2020 10:08:16 +0200
Message-Id: <20200829080816.1440-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829080816.1440-1-sjpark@amazon.de>
References: <20200829080816.1440-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

