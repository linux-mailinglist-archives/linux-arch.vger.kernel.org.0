Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE96053C1
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiJSXHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiJSXHH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 19:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2171D79B1;
        Wed, 19 Oct 2022 16:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A8AB619EB;
        Wed, 19 Oct 2022 23:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E878C4347C;
        Wed, 19 Oct 2022 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220813;
        bh=lTX9ipknMP55kKZxdcqlxeVmEcKWJL407+RtDAVEreI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQddWgBdcPbv7MqLBNXayF/qxwuVqpTIpTViazTmVI6+Mt4bKWVcBqy0aN17KwgxI
         STCVuIY1TytazsBy4QtVDRnK15B4druDiq44ZutBJiB7JkFuRIVPQmVGGl1apVBTrZ
         0wgG4ByUspor201IoQBugKbZPGiTvEB/SFOP6MmQflGcmT12zMUj2mEflLK3jKKSGd
         g25jDSKL4VxIaW6kD4hjv9VBXTAwWFq8md3OMp8ZZQGMS//Ak2Egm8gynSYmk12+Q2
         MGs4lixLM2eiaQEYFOVyBGU++kIvx3tutaYZdHHoBdUIlnaiKhW5u4mg2xGB3jJ3y3
         VlU2gXOIiNQlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06E9F5C0A04; Wed, 19 Oct 2022 16:06:53 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, SeongJae Park <sj@kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 5/5] docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency barrier'
Date:   Wed, 19 Oct 2022 16:06:51 -0700
Message-Id: <20221019230651.2502538-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

Translate this commit to Korean:

    203185f6b1e3 ("Fix confusing name of 'data dependency barrier'")

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../translations/ko_KR/memory-barriers.txt    | 127 ++++++++++--------
 1 file changed, 69 insertions(+), 58 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 38656f6680e23..7165927a708e9 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -80,7 +80,7 @@ Documentation/memory-barriers.txt
 
      - 메모리 배리어의 종류.
      - 메모리 배리어에 대해 가정해선 안될 것.
-     - 데이터 의존성 배리어 (역사적).
+     - 주소 데이터 의존성 배리어 (역사적).
      - 컨트롤 의존성.
      - SMP 배리어 짝맞추기.
      - 메모리 배리어 시퀀스의 예.
@@ -217,7 +217,7 @@ Documentation/memory-barriers.txt
 	P = &B		D = *Q;
 
 D 로 읽혀지는 값은 CPU 2 에서 P 로부터 읽혀진 주소값에 의존적이기 때문에 여기엔
-분명한 데이터 의존성이 있습니다.  하지만 이 이벤트들의 실행 결과로는 아래의
+분명한 주소 의존성이 있습니다.  하지만 이 이벤트들의 실행 결과로는 아래의
 결과들이 모두 나타날 수 있습니다:
 
 	(Q == &A) and (D == 1)
@@ -416,19 +416,19 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
      하나씩 요청해 집어넣습니다.  쓰기 배리어 앞의 모든 스토어 오퍼레이션들은
      쓰기 배리어 뒤의 모든 스토어 오퍼레이션들보다 _앞서_ 수행될 겁니다.
 
-     [!] 쓰기 배리어들은 읽기 또는 데이터 의존성 배리어와 함께 짝을 맞춰
+     [!] 쓰기 배리어들은 읽기 또는 주소 의존성 배리어와 함께 짝을 맞춰
      사용되어야만 함을 알아두세요; "SMP 배리어 짝맞추기" 서브섹션을 참고하세요.
 
 
- (2) 데이터 의존성 배리어.
+ (2) 주소 의존성 배리어 (역사적).
 
-     데이터 의존성 배리어는 읽기 배리어의 보다 완화된 형태입니다.  두개의 로드
+     주소 의존성 배리어는 읽기 배리어의 보다 완화된 형태입니다.  두개의 로드
      오퍼레이션이 있고 두번째 것이 첫번째 것의 결과에 의존하고 있을 때(예:
      두번째 로드가 참조할 주소를 첫번째 로드가 읽는 경우), 두번째 로드가 읽어올
      데이터는 첫번째 로드에 의해 그 주소가 얻어진 뒤에 업데이트 됨을 보장하기
-     위해서 데이터 의존성 배리어가 필요할 수 있습니다.
+     위해서 주소 의존성 배리어가 필요할 수 있습니다.
 
-     데이터 의존성 배리어는 상호 의존적인 로드 오퍼레이션들 사이의 부분적 순서
+     주소 의존성 배리어는 상호 의존적인 로드 오퍼레이션들 사이의 부분적 순서
      세우기입니다; 스토어 오퍼레이션들이나 독립적인 로드들, 또는 중복되는
      로드들에 대해서는 어떤 영향도 끼치지 않습니다.
 
@@ -436,37 +436,41 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
      오퍼레이션들을 던져 넣고 있으며, 거기에 관심이 있는 다른 CPU 는 그
      오퍼레이션들을 메모리 시스템이 실행한 결과를 인지할 수 있습니다.  이처럼
      다른 CPU 의 스토어 오퍼레이션의 결과에 관심을 두고 있는 CPU 가 수행 요청한
-     데이터 의존성 배리어는, 배리어 앞의 어떤 로드 오퍼레이션이 다른 CPU 에서
+     주소 의존성 배리어는, 배리어 앞의 어떤 로드 오퍼레이션이 다른 CPU 에서
      던져 넣은 스토어 오퍼레이션과 같은 영역을 향했다면, 그런 스토어
-     오퍼레이션들이 만들어내는 결과가 데이터 의존성 배리어 뒤의 로드
+     오퍼레이션들이 만들어내는 결과가 주소 의존성 배리어 뒤의 로드
      오퍼레이션들에게는 보일 것을 보장합니다.
 
      이 순서 세우기 제약에 대한 그림을 보기 위해선 "메모리 배리어 시퀀스의 예"
      서브섹션을 참고하시기 바랍니다.
 
-     [!] 첫번째 로드는 반드시 _데이터_ 의존성을 가져야지 컨트롤 의존성을 가져야
+     [!] 첫번째 로드는 반드시 _주소_ 의존성을 가져야지 컨트롤 의존성을 가져야
      하는게 아님을 알아두십시오.  만약 두번째 로드를 위한 주소가 첫번째 로드에
      의존적이지만 그 의존성은 조건적이지 그 주소 자체를 가져오는게 아니라면,
      그것은 _컨트롤_ 의존성이고, 이 경우에는 읽기 배리어나 그보다 강력한
      무언가가 필요합니다.  더 자세한 내용을 위해서는 "컨트롤 의존성" 서브섹션을
      참고하시기 바랍니다.
 
-     [!] 데이터 의존성 배리어는 보통 쓰기 배리어들과 함께 짝을 맞춰 사용되어야
+     [!] 주소 의존성 배리어는 보통 쓰기 배리어들과 함께 짝을 맞춰 사용되어야
      합니다; "SMP 배리어 짝맞추기" 서브섹션을 참고하세요.
 
+     [!] 커널 v5.9 릴리즈에서 명시적 주소 의존성 배리어를 위한 커널 API 들이
+     삭제되었습니다.  오늘날에는 공유된 변수들의 로드를 표시하는 READ_ONCE() 나
+     rcu_dereference() 와 같은 API 들은 묵시적으로 주소 의존성 배리어를 제공합니다.
+
 
  (3) 읽기 (또는 로드) 메모리 배리어.
 
-     읽기 배리어는 데이터 의존성 배리어 기능의 보장사항에 더해서 배리어보다
-     앞서 명시된 모든 LOAD 오퍼레이션들이 배리어 뒤에 명시되는 모든 LOAD
+     읽기 배리어는 주소 의존성 배리어 기능의 보장사항에 더해서 배리어보다 앞서
+     명시된 모든 LOAD 오퍼레이션들이 배리어 뒤에 명시되는 모든 LOAD
      오퍼레이션들보다 먼저 행해진 것으로 시스템의 다른 컴포넌트들에 보여질 것을
      보장합니다.
 
      읽기 배리어는 로드 오퍼레이션에 행해지는 부분적 순서 세우기입니다; 스토어
      오퍼레이션에 대해서는 어떤 영향도 끼치지 않습니다.
 
-     읽기 메모리 배리어는 데이터 의존성 배리어를 내장하므로 데이터 의존성
-     배리어를 대신할 수 있습니다.
+     읽기 메모리 배리어는 주소 의존성 배리어를 내장하므로 주소 의존성 배리어를
+     대신할 수 있습니다.
 
      [!] 읽기 배리어는 일반적으로 쓰기 배리어들과 함께 짝을 맞춰 사용되어야
      합니다; "SMP 배리어 짝맞추기" 서브섹션을 참고하세요.
@@ -571,16 +575,20 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	    Documentation/core-api/dma-api.rst
 
 
-데이터 의존성 배리어 (역사적)
------------------------------
+주소 의존성 배리어 (역사적)
+---------------------------
 
 리눅스 커널 v4.15 기준으로, smp_mb() 가 DEC Alpha 용 READ_ONCE() 코드에
 추가되었는데, 이는 이 섹션에 주의를 기울여야 하는 사람들은 DEC Alpha 아키텍쳐
 전용 코드를 만드는 사람들과 READ_ONCE() 자체를 만드는 사람들 뿐임을 의미합니다.
-그런 분들을 위해, 그리고 역사에 관심 있는 분들을 위해, 여기 데이터 의존성
+그런 분들을 위해, 그리고 역사에 관심 있는 분들을 위해, 여기 주소 의존성
 배리어에 대한 이야기를 적습니다.
 
-데이터 의존성 배리어의 사용에 있어 지켜야 하는 사항들은 약간 미묘하고, 데이터
+[!] 주소 의존성은 로드에서 로드로와 로드에서 스토어로의 관계들 모두에서
+나타나지만, 주소 의존성 배리어는 로드에서 스토어로의 상황에서는 필요하지
+않습니다.
+
+주소 의존성 배리어의 사용에 있어 지켜야 하는 사항들은 약간 미묘하고, 데이터
 의존성 배리어가 사용되어야 하는 상황도 항상 명백하지는 않습니다.  설명을 위해
 다음의 이벤트 시퀀스를 생각해 봅시다:
 
@@ -590,10 +598,13 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	B = 4;
 	<쓰기 배리어>
 	WRITE_ONCE(P, &B)
-			      Q = READ_ONCE(P);
+			      Q = READ_ONCE_OLD(P);
 			      D = *Q;
 
-여기엔 분명한 데이터 의존성이 존재하므로, 이 시퀀스가 끝났을 때 Q 는 &A 또는 &B
+[!] READ_ONCE_OLD() 는 4.15 커널 전의 버전에서의, 주소 의존성 배리어를 내포하지
+않는 READ_ONCE() 에 해당합니다.
+
+여기엔 분명한 주소 의존성이 존재하므로, 이 시퀀스가 끝났을 때 Q 는 &A 또는 &B
 일 것이고, 따라서:
 
 	(Q == &A) 는 (D == 1) 를,
@@ -608,8 +619,8 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 그렇지 않습니다, 그리고 이 현상은 (DEC Alpha 와 같은) 여러 CPU 에서 실제로
 발견될 수 있습니다.
 
-이 문제 상황을 제대로 해결하기 위해, 데이터 의존성 배리어나 그보다 강화된
-무언가가 주소를 읽어올 때와 데이터를 읽어올 때 사이에 추가되어야만 합니다:
+이 문제 상황을 제대로 해결하기 위해, READ_ONCE() 는 커널 v4.15 릴리즈 부터
+묵시적 주소 의존성 배리어를 제공합니다:
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -618,7 +629,7 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	<쓰기 배리어>
 	WRITE_ONCE(P, &B);
 			      Q = READ_ONCE(P);
-			      <데이터 의존성 배리어>
+			      <묵시적 주소 의존성 배리어>
 			      D = *Q;
 
 이 변경은 앞의 처음 두가지 결과 중 하나만이 발생할 수 있고, 세번째의 결과는
@@ -634,7 +645,7 @@ P 는 짝수 번호 캐시 라인에 저장되어 있고, 변수 B 는 홀수 
 중이라면 포인터 P (&B) 의 새로운 값과 변수 B 의 기존 값 (2) 를 볼 수 있습니다.
 
 
-의존적 쓰기들의 순서를 맞추는데에는 데이터 의존성 배리어가 필요치 않은데, 이는
+의존적 쓰기들의 순서를 맞추는데에는 주소 의존성 배리어가 필요치 않은데, 이는
 리눅스 커널이 지원하는 CPU 들은 (1) 쓰기가 정말로 일어날지, (2) 쓰기가 어디에
 이루어질지, 그리고 (3) 쓰여질 값을 확실히 알기 전까지는 쓰기를 수행하지 않기
 때문입니다.  하지만 "컨트롤 의존성" 섹션과
@@ -647,12 +658,12 @@ Documentation/RCU/rcu_dereference.rst 파일을 주의 깊게 읽어 주시기 
 	B = 4;
 	<쓰기 배리어>
 	WRITE_ONCE(P, &B);
-			      Q = READ_ONCE(P);
+			      Q = READ_ONCE_OLD(P);
 			      WRITE_ONCE(*Q, 5);
 
-따라서, Q 로의 읽기와 *Q 로의 쓰기 사이에는 데이터 종속성 배리어가 필요치
-않습니다.  달리 말하면, 데이터 종속성 배리어가 없더라도 다음 결과는 생기지
-않습니다:
+따라서, Q 로의 읽기와 *Q 로의 쓰기 사이에는 주소 의존성 배리어가 필요치
+않습니다.  달리 말하면, 오늘날의 READ_ONCE() 의 묵시적 주소 의존성 배리어가
+없더라도 다음 결과는 생기지 않습니다:
 
 	(Q == &B) && (B == 4)
 
@@ -663,16 +674,16 @@ Documentation/RCU/rcu_dereference.rst 파일을 주의 깊게 읽어 주시기 
 해줍니다.
 
 
-데이터 의존성에 의해 제공되는 이 순서규칙은 이를 포함하고 있는 CPU 에
+주소 의존성에 의해 제공되는 이 순서규칙은 이를 포함하고 있는 CPU 에
 지역적임을 알아두시기 바랍니다.  더 많은 정보를 위해선 "Multicopy 원자성"
 섹션을 참고하세요.
 
 
-데이터 의존성 배리어는 매우 중요한데, 예를 들어 RCU 시스템에서 그렇습니다.
+주소 의존성 배리어는 매우 중요한데, 예를 들어 RCU 시스템에서 그렇습니다.
 include/linux/rcupdate.h 의 rcu_assign_pointer() 와 rcu_dereference() 를
-참고하세요.  여기서 데이터 의존성 배리어는 RCU 로 관리되는 포인터의 타겟을 현재
-타겟에서 수정된 새로운 타겟으로 바꾸는 작업에서 새로 수정된 타겟이 초기화가
-완료되지 않은 채로 보여지는 일이 일어나지 않게 해줍니다.
+참고하세요.  이것들은 RCU 로 관리되는 포인터의 타겟을 현재 타겟에서 수정된
+새로운 타겟으로 바꾸는 작업에서 새로 수정된 타겟이 초기화가 완료되지 않은 채로
+보여지는 일이 일어나지 않게 해줍니다.
 
 더 많은 예를 위해선 "캐시 일관성" 서브섹션을 참고하세요.
 
@@ -684,16 +695,17 @@ include/linux/rcupdate.h 의 rcu_assign_pointer() 와 rcu_dereference() 를
 약간 다루기 어려울 수 있습니다.  이 섹션의 목적은 여러분이 컴파일러의 무시로
 인해 여러분의 코드가 망가지는 걸 막을 수 있도록 돕는겁니다.
 
-로드-로드 컨트롤 의존성은 데이터 의존성 배리어만으로는 정확히 동작할 수가
-없어서 읽기 메모리 배리어를 필요로 합니다.  아래의 코드를 봅시다:
+로드-로드 컨트롤 의존성은 (묵시적인) 주소 의존성 배리어만으로는 정확히 동작할
+수가 없어서 읽기 메모리 배리어를 필요로 합니다.  아래의 코드를 봅시다:
 
 	q = READ_ONCE(a);
+	<묵시적 주소 의존성 배리어>
 	if (q) {
-		<데이터 의존성 배리어>  /* BUG: No data dependency!!! */
+		/* BUG: No address dependency!!! */
 		p = READ_ONCE(b);
 	}
 
-이 코드는 원하는 대로의 효과를 내지 못할 수 있는데, 이 코드에는 데이터 의존성이
+이 코드는 원하는 대로의 효과를 내지 못할 수 있는데, 이 코드에는 주소 의존성이
 아니라 컨트롤 의존성이 존재하기 때문으로, 이런 상황에서 CPU 는 실행 속도를 더
 빠르게 하기 위해 분기 조건의 결과를 예측하고 코드를 재배치 할 수 있어서 다른
 CPU 는 b 로부터의 로드 오퍼레이션이 a 로부터의 로드 오퍼레이션보다 먼저 발생한
@@ -930,9 +942,9 @@ CPU 간 상호작용을 다룰 때에 일부 타입의 메모리 배리어는 
 범용 배리어들은 범용 배리어끼리도 짝을 맞추지만 multicopy 원자성이 없는
 대부분의 다른 타입의 배리어들과도 짝을 맞춥니다.  ACQUIRE 배리어는 RELEASE
 배리어와 짝을 맞춥니다만, 둘 다 범용 배리어를 포함해 다른 배리어들과도 짝을
-맞출 수 있습니다.  쓰기 배리어는 데이터 의존성 배리어나 컨트롤 의존성, ACQUIRE
+맞출 수 있습니다.  쓰기 배리어는 주소 의존성 배리어나 컨트롤 의존성, ACQUIRE
 배리어, RELEASE 배리어, 읽기 배리어, 또는 범용 배리어와 짝을 맞춥니다.
-비슷하게 읽기 배리어나 컨트롤 의존성, 또는 데이터 의존성 배리어는 쓰기 배리어나
+비슷하게 읽기 배리어나 컨트롤 의존성, 또는 주소 의존성 배리어는 쓰기 배리어나
 ACQUIRE 배리어, RELEASE 배리어, 또는 범용 배리어와 짝을 맞추는데, 다음과
 같습니다:
 
@@ -951,7 +963,7 @@ ACQUIRE 배리어, RELEASE 배리어, 또는 범용 배리어와 짝을 맞추
 	a = 1;
 	<쓰기 배리어>
 	WRITE_ONCE(b, &a);    x = READ_ONCE(b);
-			      <데이터 의존성 배리어>
+			      <묵시적 주소 의존성 배리어>
 			      y = *x;
 
 또는:
@@ -970,8 +982,8 @@ ACQUIRE 배리어, RELEASE 배리어, 또는 범용 배리어와 짝을 맞추
 기본적으로, 여기서의 읽기 배리어는 "더 완화된" 타입일 순 있어도 항상 존재해야
 합니다.
 
-[!] 쓰기 배리어 앞의 스토어 오퍼레이션은 일반적으로 읽기 배리어나 데이터
-의존성 배리어 뒤의 로드 오퍼레이션과 매치될 것이고, 반대도 마찬가지입니다:
+[!] 쓰기 배리어 앞의 스토어 오퍼레이션은 일반적으로 읽기 배리어나 주소 의존성
+배리어 뒤의 로드 오퍼레이션과 매치될 것이고, 반대도 마찬가지입니다:
 
 	CPU 1                               CPU 2
 	===================                 ===================
@@ -1023,7 +1035,7 @@ ACQUIRE 배리어, RELEASE 배리어, 또는 범용 배리어와 짝을 맞추
 	                   V
 
 
-둘째, 데이터 의존성 배리어는 데이터 의존적 로드 오퍼레이션들의 부분적 순서
+둘째, 주소 의존성 배리어는 데이터 의존적 로드 오퍼레이션들의 부분적 순서
 세우기로 동작합니다.  다음 일련의 이벤트들을 보세요:
 
 	CPU 1			CPU 2
@@ -1069,7 +1081,7 @@ ACQUIRE 배리어, RELEASE 배리어, 또는 범용 배리어와 짝을 맞추
 앞의 예에서, CPU 2 는 (B 의 값이 될) *C 의 값 읽기가 C 의 LOAD 뒤에 이어짐에도
 B 가 7 이라는 결과를 얻습니다.
 
-하지만, 만약 데이터 의존성 배리어가 C 의 로드와 *C (즉, B) 의 로드 사이에
+하지만, 만약 주소 의존성 배리어가 C 의 로드와 *C (즉, B) 의 로드 사이에
 있었다면:
 
 	CPU 1			CPU 2
@@ -1080,7 +1092,7 @@ B 가 7 이라는 결과를 얻습니다.
 	<쓰기 배리어>
 	STORE C = &B		LOAD X
 	STORE D = 4		LOAD C (gets &B)
-				<데이터 의존성 배리어>
+				<주소 의존성 배리어>
 				LOAD *C (reads B)
 
 다음과 같이 됩니다:
@@ -1103,7 +1115,7 @@ B 가 7 이라는 결과를 얻습니다.
 	                               |        +-------+       |       |
 	                               |        | X->9  |------>|       |
 	                               |        +-------+       |       |
-	  C 로의 스토어 앞의     --->   \   ddddddddddddddddd   |       |
+	  C 로의 스토어 앞의     --->   \   aaaaaaaaaaaaaaaaa   |       |
 	  모든 이벤트 결과가             \      +-------+       |       |
 	  뒤의 로드에게                   ----->| B->2  |------>|       |
 	  보이게 강제한다                       +-------+       |       |
@@ -1291,7 +1303,7 @@ A 의 로드 두개가 모두 B 의 로드 뒤에 있지만, 서로 다른 값
 	즉각 완료한다                           :       :       +-------+
 
 
-읽기 배리어나 데이터 의존성 배리어를 두번째 로드 직전에 놓는다면:
+읽기 배리어나 주소 의존성 배리어를 두번째 로드 직전에 놓는다면:
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1785,21 +1797,20 @@ READ_ONCE(jiffies) 라고 할 필요가 없습니다.  READ_ONCE() 와 WRITE_ONC
 CPU 메모리 배리어
 -----------------
 
-리눅스 커널은 다음의 여덟개 기본 CPU 메모리 배리어를 가지고 있습니다:
+리눅스 커널은 다음의 일곱개 기본 CPU 메모리 배리어를 가지고 있습니다:
 
 	TYPE		MANDATORY		SMP CONDITIONAL
-	===============	=======================	===========================
+	===============	=======================	===============
 	범용		mb()			smp_mb()
 	쓰기		wmb()			smp_wmb()
 	읽기		rmb()			smp_rmb()
-	데이터 의존성				READ_ONCE()
+	주소 의존성				READ_ONCE()
 
 
-데이터 의존성 배리어를 제외한 모든 메모리 배리어는 컴파일러 배리어를
-포함합니다.  데이터 의존성은 컴파일러에의 추가적인 순서 보장을 포함하지
-않습니다.
+주소 의존성 배리어를 제외한 모든 메모리 배리어는 컴파일러 배리어를 포함합니다.
+주소 의존성은 컴파일러에의 추가적인 순서 보장을 포함하지 않습니다.
 
-방백: 데이터 의존성이 있는 경우, 컴파일러는 해당 로드를 올바른 순서로 일으킬
+방백: 주소 의존성이 있는 경우, 컴파일러는 해당 로드를 올바른 순서로 일으킬
 것으로 (예: `a[b]` 는 a[b] 를 로드 하기 전에 b 의 값을 먼저 로드한다)
 기대되지만, C 언어 사양에는 컴파일러가 b 의 값을 추측 (예: 1 과 같음) 해서
 b  로드 전에 a 로드를 하는 코드 (예: tmp = a[1]; if (b != 1) tmp = a[b]; ) 를
@@ -2837,9 +2848,9 @@ ld.acq 와 stl.rel 인스트럭션을 각각 만들어 내도록 합니다.
 DEC Alpha CPU 는 가장 완화된 메모리 순서의 CPU 중 하나입니다.  뿐만 아니라,
 Alpha CPU 의 일부 버전은 분할된 데이터 캐시를 가지고 있어서, 의미적으로
 관계되어 있는 두개의 캐시 라인이 서로 다른 시간에 업데이트 되는게 가능합니다.
-이게 데이터 의존성 배리어가 정말 필요해지는 부분인데, 데이터 의존성 배리어는
-메모리 일관성 시스템과 함께 두개의 캐시를 동기화 시켜서, 포인터 변경과 새로운
-데이터의 발견을 올바른 순서로 일어나게 하기 때문입니다.
+이게 주소 의존성 배리어가 정말 필요해지는 부분인데, 주소 의존성 배리어는 메모리
+일관성 시스템과 함께 두개의 캐시를 동기화 시켜서, 포인터 변경과 새로운 데이터의
+발견을 올바른 순서로 일어나게 하기 때문입니다.
 
 리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다만, v4.15
 부터는 Alpha 용 READ_ONCE() 코드 내에 smp_mb() 가 추가되어서 메모리 모델로의
-- 
2.31.1.189.g2e36527f23

