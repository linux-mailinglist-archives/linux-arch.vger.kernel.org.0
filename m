Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98112565C6
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgH2IIp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgH2II3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:08:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B8C061236;
        Sat, 29 Aug 2020 01:08:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so1104295edo.10;
        Sat, 29 Aug 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UF+fQ3yhVmoV6NIu/Hf2VJREVLYgAI7i8vkCdtVNFis=;
        b=SJu8oNtC0c11gbXQYOtOCTjOQgupr6bfaPdhzXo06DDIRvAhvZYoMP2HXy1yM50f29
         vg6ESvrnizGg8RvWpOcsKX1/sbZWEcQx9xqZwh9wtyPGUXFFTHyGTXR2cLItyci+4Rwm
         bDOOhWtTmwV/+hL2CgBXdvj8LQzaOmqf8magJNHUOg5X4Ki2iYdzORqk3kqAxgJe/Dh5
         +qKtHPYrz/xyTGg9Ma6PRiA1Mc0TGtZRkKBKkTLMBm/1Gt4x6/2lF+Ycz7q+v7jUKzR+
         RJQlZlEjnosiPD9G9jbZ6qfYUm5d+S1XQfGhDqTp2B0ZyGeFKFlqW+YWd5j2CBxWz2C3
         doSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UF+fQ3yhVmoV6NIu/Hf2VJREVLYgAI7i8vkCdtVNFis=;
        b=hvcr1q2A4AzDr9X+Hx7Rfdo7l6R1bDQJWYsGH2Xn45rVadpmdGrSM3aCcj2ZNNpCZN
         0mINyQX+gt5RI+NZpOOOknGkf0RbKGfU+5xEeJC5vVsbuxMM31wQcamY0gnIszIvCLHR
         4+sK43wt/yrNhAZL8MPZ5dk9pf22DDxOIWXFEIAS7tQzAIPrb8r5FLOSeOZejhR/p+qz
         61mqNzqgqEndOfUegauMIXIBxUXCaInk3g3ll01vNdXit36BCv3OoKXKK3aDQw3NTCP5
         O+rm6Dph4UtRRRuL0S4i43jx97EAex2V0KZ8Db5ugoibXstS8c0QnvD3H5JVxOhos+24
         f8GQ==
X-Gm-Message-State: AOAM531njE2GPNzt2LjH8edpSOWiN69JEq7Y+AWxVpuxNL1oUac+6Fl+
        R4lkiwj2Ea5k3o2bM7RcLSDriZLasI0=
X-Google-Smtp-Source: ABdhPJw0hJ1X2JWvrtupFcMRi53ScrI+iFUC8XaJ5HV8CuTP/ZgZVduPJJhBPw4/4vxg76MHVyJsCA==
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr2552147edu.324.1598688507744;
        Sat, 29 Aug 2020 01:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id h25sm1568923ejq.12.2020.08.29.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:08:26 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/3] docs/memory-barriers.txt/kokr: Remove remaining references to mmiowb()
Date:   Sat, 29 Aug 2020 10:08:15 +0200
Message-Id: <20200829080816.1440-3-sjpark@amazon.de>
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

    a897b13d1b77 ("docs/memory-barriers.txt: Remove remaining references to mmiowb()")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt    | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 9dcc7c9d52e6..291039d77694 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -91,7 +91,6 @@ Documentation/memory-barriers.txt
 
      - 컴파일러 배리어.
      - CPU 메모리 배리어.
-     - MMIO 쓰기 배리어.
 
  (*) 암묵적 커널 메모리 배리어.
 
@@ -103,7 +102,6 @@ Documentation/memory-barriers.txt
  (*) CPU 간 ACQUIRING 배리어의 효과.
 
      - Acquire vs 메모리 액세스.
-     - Acquire vs I/O 액세스.
 
  (*) 메모리 배리어가 필요한 곳
 
@@ -515,14 +513,13 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
      완료되기 전에 행해진 것처럼 보일 수 있습니다.
 
      ACQUIRE 와 RELEASE 오퍼레이션의 사용은 일반적으로 다른 메모리 배리어의
-     필요성을 없앱니다 (하지만 "MMIO 쓰기 배리어" 서브섹션에서 설명되는 예외를
-     알아두세요).  또한, RELEASE+ACQUIRE 조합은 범용 메모리 배리어처럼 동작할
-     것을 보장하지 -않습니다-.  하지만, 어떤 변수에 대한 RELEASE 오퍼레이션을
-     앞서는 메모리 액세스들의 수행 결과는 이 RELEASE 오퍼레이션을 뒤이어 같은
-     변수에 대해 수행된 ACQUIRE 오퍼레이션을 뒤따르는 메모리 액세스에는 보여질
-     것이 보장됩니다.  다르게 말하자면, 주어진 변수의 크리티컬 섹션에서는, 해당
-     변수에 대한 앞의 크리티컬 섹션에서의 모든 액세스들이 완료되었을 것을
-     보장합니다.
+     필요성을 없앱니다.  또한, RELEASE+ACQUIRE 조합은 범용 메모리 배리어처럼
+     동작할 것을 보장하지 -않습니다-.  하지만, 어떤 변수에 대한 RELEASE
+     오퍼레이션을 앞서는 메모리 액세스들의 수행 결과는 이 RELEASE 오퍼레이션을
+     뒤이어 같은 변수에 대해 수행된 ACQUIRE 오퍼레이션을 뒤따르는 메모리
+     액세스에는 보여질 것이 보장됩니다.  다르게 말하자면, 주어진 변수의
+     크리티컬 섹션에서는, 해당 변수에 대한 앞의 크리티컬 섹션에서의 모든
+     액세스들이 완료되었을 것을 보장합니다.
 
      즉, ACQUIRE 는 최소한의 "취득" 동작처럼, 그리고 RELEASE 는 최소한의 "공개"
      처럼 동작한다는 의미입니다.
@@ -1501,8 +1498,6 @@ u 로의 스토어를 cpu1() 의 v 로부터의 로드 뒤에 일어난 것으
 
   (*) CPU 메모리 배리어.
 
-  (*) MMIO 쓰기 배리어.
-
 
 컴파일러 배리어
 ---------------
-- 
2.17.1

