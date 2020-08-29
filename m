Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195BB25660A
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgH2I0b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgH2I0X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:26:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01DC061239;
        Sat, 29 Aug 2020 01:26:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so1127521edo.10;
        Sat, 29 Aug 2020 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYl76rnN2H1mnkHaeRQQX8eMRyBs+za5/Hgs3tadHtA=;
        b=QbCqGbl66PGAoPlqI+aVEIhcdHNOe+ipBg+Z4iDU42Zqy4rV5NuOmJ4vm1NhytMsKL
         ekdYyTN36SjmY4wW6Ocj0d/Dr8idd7nlolnoYDhwGLwV1lg0UqzpMQ74ZkmQWDqW72XE
         B2ZVE9PEvtB30rNagiSaxcemWw7fQ9okCSTixwJI+ZMENdP3V8QNUBmxmHq0WgvSLPas
         +J+Nj/jb/yO+13YDdE7Z5/2Hf9IpNxdjqEN7XNsTrleOhjoU4/CYLYZUrD2ltLBMTVLk
         IlTdfUr+fvbIGzSf4WITDOlWA3ZOGgRoB2/0vJZDygReIUvpksePd7LMUvxk1NTVRPZu
         Q8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYl76rnN2H1mnkHaeRQQX8eMRyBs+za5/Hgs3tadHtA=;
        b=nk3Txq/rO5PwkJf9Rrge4XTK7BuBo61gtggwUe0oCuepkvV8NN48l/JBWJVxst36Ll
         uPcLJWVGZIZKxqKngCoNvVxbtEVyv2vpDgZ4NUY7wB+BNcLp6ttVbTCYqIeScxvSL9jy
         qU7EjmpWXAz3aWQeO2CLcNAbaVyk5jEKndf+Nt5x6YuoNREmNY9kDPCaC9nbHHiNnS/C
         HJCYkLMDGLIY0xtS00hlqhUfkiFGcUqKNla1qS6JjdiM2dWsvbbl4/sxKQa0yKoXnGY1
         Fq58MF/MrPiLxKTvXe25P1QOqQTCgUA2tu58SQ/lzxgc2SPGNVlWwV6yGNGsTJUNb5Ex
         mVDw==
X-Gm-Message-State: AOAM530QuR70V1vj61U/fd9vn+JhAjM5d9xiAqPb0LZPtZQEQG5MIWLy
        klsYLYbHPoelioWctI0vU18=
X-Google-Smtp-Source: ABdhPJywEqJ9qb0MIfqAyraGfAVMP/XST7RHRLgYMcctZPEIJNf+Irq0JBnAU84T+QfEgWAtSFkgVw==
X-Received: by 2002:a05:6402:342:: with SMTP id r2mr2581777edw.353.1598689581319;
        Sat, 29 Aug 2020 01:26:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id b23sm1566538eja.86.2020.08.29.01.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:26:20 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 2/3] docs/memory-barriers.txt/kokr: Remove remaining references to mmiowb()
Date:   Sat, 29 Aug 2020 10:26:06 +0200
Message-Id: <20200829082607.3146-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829082607.3146-1-sj38.park@gmail.com>
References: <20200829082607.3146-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

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

