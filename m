Return-Path: <linux-arch+bounces-13843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D4BB2EA0
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ADB3C6CFE
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1332F261D;
	Thu,  2 Oct 2025 08:13:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF642E7161;
	Thu,  2 Oct 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392815; cv=none; b=BVsDAEXdE3rXIlKK0FFHPvj0F5opi+Mu2oCpMKUA1U0VEX6+n/Q4Tt4SiL2Jz7UdhqhEH9TQkFAPTS8nECTX0FeJYxFf81kkndkge4HWupyGA3cWbts144OMw6SYH3ARMwJRGzFPsX73f7HAFLNJm1/E/CjHVMIlbsQbsvnMTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392815; c=relaxed/simple;
	bh=mVczWw5AJvTGaUa2k+kGuAdITLqzYAqLiO2CNQ+CNGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Xvc/Aik8vVrt5KitwDqQW5zBokco5aoEdxG509ZGheAxzSLTEilAE3ozkOHz/UcBvtFfPhclh6eZmU4xSKLqDxDsP/EMHvaTno9QIlCXmivPNqAK6LDUuozI2U9GYFRP507t4duMfz4a6YEYH06Q/si+vAagozgVqGzdzpQNKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-d0-68de340e4fa9
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 13/47] dept: apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Thu,  2 Oct 2025 17:12:13 +0900
Message-Id: <20251002081247.51255-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTYRgH8N5z3nM2h7PTijppYawkk5wWFg+UERF0oAIrpKgPOvLQVt7Y
	zLILrXBd1EStZWqZZshIo3FsVLPC1sWcl6aWzvJa5KVykuWWadZm+e3H/3n483x4xKQsm/IX
	qxNTeE2iMl5OS7Bk2Lc01C+iWxVeYJZD2+kaDOeFAgr0D/9guNKcR8J30xQNwz3VFOQb7AgG
	TecQ3HvZjeBTjpmEN2MjNNQZMmlwmmi4cl3A0PxlkoAKYTv0lPdjyB+iwXCnmoCGsk4MRY2t
	FHwwFoqgp/YsBfd1vSIQOl4g+PGmj4DzljEMBcWdNLRartHQXfmHAl2RmwJ7TT0FLRV2DK8t
	dyjo63VQcMnZj8D4LZ8CU7qnb/SWC8O5wWoaBgqvE/Bs7CsBtl82AvRZ4yIwv3CLYOKnp/Sn
	6SMFzpwf1MZwzq3Pxpy+5TfNVRZXIu7Z1xGSs91kuYeFXSKuRDjMVRlDuLJHQwQn3L5Ac8Jo
	nohzNjWJuFKdgeSK63ZwPZm1BPd+6iMZFbBXsj6Oj1en8pqwDbES1YQ1g0h+POfo4Fs70qEq
	vwzkI2aZCNZc6qBnLHRUkl7TzHLW4Rif9jxmCVt1sZ/ymmTqF7FtzSu9nsuo2OzLudhrzASx
	A5ZXIq+lzFq2fCIL/+sMZCtMNdM9Pp68ta9+Opcxa1j9SDqRgSSenQoftt1Y9v+IhexTowPn
	IGkJmnUbydSJqQlKdXyEQpWWqD6q2J+UICDPl5SfnNz3AI3ad1kRI0ZyX6k9qEslo5Sp2rQE
	K2LFpHyeNNbYqZJJ45Rpx3hNUozmcDyvtaIAMZYvkK52HYmTMQeUKfwhnk/mNTNTQuzjr0Mm
	t3Ghc8h/SWhIdCR5t3ZYtWXTmafzbTgg2LItebxsX+axzYGWyNBtnyfDWtzfjb8ZV/9kr2vn
	k8W6qLzGpnWKd11TkYqU58MDjcEu89Xcre3LM3c7FTF7ruIgP7w/xJp2YaLj1LIPtZ3h2rfW
	FceRwXXiRvTSTwcbgoJnS2wusRxrVcpVIaRGq/wLw8+noyEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG9z/nf84p1ZJjRT3qErZGYjTKJqn6RtFsHxaOzrsmRuOFBk5o
	xzUtICwaQWjkvtKsgBS1YmgIrVhbb8i6kJoRN8agAt6gYg0CahmJtioWZC2LX9783ud58+T5
	8IpI6U1qmUiVkS2oMxRpMlqMxbs2F62NlD9VftvQSsKDwg4MAX8JhoarVhpK7Oco6G21IBgO
	lCB4HzSSoG2bxTCj72TAPzXIwKyzE0GNW0+C9XohAW9tn2h4ffcNAoN3hIbal4UYJs0VCOpH
	jQy8/CMBJobbKZj1jBHw8J0PgXnkEwEjHWcRzNSkwsVGBw3B7h4Sag29CC55PSSM20Lm9c6n
	CJzNZ2h4obtBQt9IJPQHJmn401BOw4S7gYB/bTSYzjgpOG/UIyi6fJWGmvN2DG3P7jDgfj1N
	wFCNngCLfScMm0cxdOkaiVC/0NW1JWCsLSJCY5wAw5V2AqbMLQz8fXkIg7kgBozdfRQ8b65n
	YNq7DmZNmdBpGWPA84sBQ+tED/WdAfHvtVWYb3HcJHjt/Rmat16wIj74UY94f1MRyWt1ofWu
	b5Lkix0n+KYuH81/DAzQvPOdCfN/NXJ8dfdavq3ew/DFvz9h9mw6LI5PFtJUuYL6m62JYmXQ
	VUZkORfkjQ/0ogLkiCxDESKOlXP2x1YyzDS7knv0aGqOo9ivOEflKBVmku36knvgXhPmhayS
	q/q1GocZszHc2J17TJgl7AbOHKzA/2dGcxZbx1xOREjv83bN6VJ2PaedLCZ0SGxCX7SgKFVG
	brpClbY+VpOqzM9Q5cUmZabbUeibzKemq28jf1+CC7EiJJsvccd4lFJKkavJT3chTkTKoiSJ
	zUNKqSRZkf+zoM48rs5JEzQutFyEZUsk2w8KiVI2RZEtpApClqD+7BKiiGUF6GSpsXRLjmvh
	3thV+RPLV9ZJk3DK123T/pRzSYd+0Pmi4+TZg/MOHHGo1Nvk8yoPlB+qu1VHWf8xVSTc+FH2
	m+/U/eRF9mf9Oy2795YtJqo/bKytaGh6my23HcVT+3YMHju9+eyKuO/jT8a1/+RlspR1r5bu
	6AkkH2/V3Etpit+/qzxGhjVKxbrVpFqj+A/gRvS4SQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..bd2c207481d6 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/swait.h>
+#include <linux/dept_sdt.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -26,14 +27,33 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
+#define init_completion(x)				\
+do {							\
+	sdt_map_init(&(x)->dmap);			\
+	__init_completion(x);				\
+} while (0)
+
+/*
+ * XXX: No use cases for now. Fill the body when needed.
+ */
 #define init_completion_map(x, m) init_completion(x)
-static inline void complete_acquire(struct completion *x) {}
-static inline void complete_release(struct completion *x) {}
+
+static inline void complete_acquire(struct completion *x)
+{
+	sdt_might_sleep_start(&x->dmap);
+}
+
+static inline void complete_release(struct completion *x)
+{
+	sdt_might_sleep_end();
+}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -75,13 +95,13 @@ static inline void complete_release(struct completion *x) {}
 #endif
 
 /**
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
-- 
2.17.1


