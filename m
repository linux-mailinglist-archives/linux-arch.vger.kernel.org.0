Return-Path: <linux-arch+bounces-13850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA0BB2F0C
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865D37B3C8D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB292FE06B;
	Thu,  2 Oct 2025 08:13:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BD2FC01A;
	Thu,  2 Oct 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392827; cv=none; b=fvLxY5bPfNz4qErcg25YC/fM1QIKkunlCH0HlfWBL4goGszRRNjoI9q21z+4G2k8mpGok5E3L2UbSZL/4aa82UrPlFZ4XgTJ26vDpDgPbmuK8jols4rBoyRwEafPgJ3/Ce3KwZvSNmqW/uW3W2eOTZN7YWh7LletDp1AX3H0jws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392827; c=relaxed/simple;
	bh=Nq6eF1vNPqQexxbO5CbSo0SEOxl3ixoZ4tUAk3fFOuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Yi13h6sWXWHdmdi5HC6QtzLv+rpPBherjHnct3rcPRUCHh1q5oWgpzRc9HZjx9ku4bCn7u2lX3Mb02lhQIAMsVL5+I0imQxXnCluRVfmAqocayt1iNLvKHOrtx62mANOcyMSTVjCTjfaCDojv1mxDpQVjJAJTJAoMIT8Tkfqk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-ac-68de340f56f4
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
Subject: [PATCH v17 19/47] dept: apply timeout consideration to wait_for_completion()/complete()
Date: Thu,  2 Oct 2025 17:12:19 +0900
Message-Id: <20251002081247.51255-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+92308VtFV0rSFYSZU+xOH9U9IC8/xVEEBXkyEtb+WIu00hY
	pfa2ZaTVypaaLGdq0zKt1Vyp2BS3VmvZXEq1XDYDy4mv7Gr0z+FzzvmeL5zDYXCZm5zPqFI0
	gjpFkSSnJIQkGFGyko3zKdf8eMqA+6SVgFvVlRScNd8gwVFlQjA8pscht2GSgImCFhp+j3yk
	YdLSgqCy7iQGN/16GgLN8fA+9APBF+sZBBOFR+BOSS0FYx2dOPTViKW6Fh8Ci/EUBV91j3Bw
	fZkJb4d+UtB27QIFQectDAZqKDCcspBQeNtMQENPIw3O/nEMvIUFGHwq9xNg15VgUBSgoPDh
	PNAXncbE0IfBSHkFDe2lXgLKtdGg73CRMN67FiYNqdBi+kZD9+VrBFQFO0lo87lJ6PcXUFCv
	7aHB/KFZ3OGiH4ezjUMEmD+LXUtXDNwo9lJwseYRCVr9sHgDq52ENyYHAdXfPBjce+/EIJS/
	ABxXLpFwdcCPNifyFbWPMb6yuBLxY6MFiP997zTO5+rEdHToHcW/LuH4hpvdNJ/zvIvmDeaj
	fM6rIMnXGpfzpc8CGH93cIjku/o38uaKc9TO1XslGxKFJFWGoF69KUGifOftwtOKJZll3/NI
	LephzqMwhmPjuHxDL/2fB/K+ElNMsUs5j2cEn+I5bBRXe8lPTjHO2hdybueKKZ7NJnD2sr5p
	DcFGc4PVL6c1UnY91278Rf7zXMSZaqzTmjCx7uq1T/vL2HVc7s8c7DySiJqiMM5Q147+DURy
	TUYPoUNSA5pRgWSqlIxkhSopbpUyK0WVuepgarIZid9Wnj2+7wkadOyyIZZB8gipI7pbKSMV
	GelZyTbEMbh8jjTB6FXKpImKrOOCOvWA+miSkG5DCxhCPk8aGzqWKGMPKTTCEUFIE9T/uxgT
	Nl+LluzJu8q6fLGWGJ3zeOOKvsueqL22usUBX094oFOTnxDr3r4jbf/Wwfvh5qUHDrv+fMx+
	EYwK9605kb1yYtthanZ7vW9Z1ejuyO+aBxHDjwPJpa1b7Ja59535TYsbrKHI1mBMU1amJn69
	qTX0JN6G1WfEpV43XMhuthJtt2dd/9whJ9KVirXLcXW64i9s4CzzaQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+923o9VtSd0sMAYSlGYv49CLiqJL0EMKCv/JkZe2nFM2My0q
	TWf21AabtJWZ2RC1tK2XlSWTFrbE1npIbdlkPkqnYJuhbtk0+ufwOef74XD+OAwueUTGMApV
	tqBWyZRSSkSIdq8vTJi95pt8RbhoAXwqaCEgGCgh4HpDPQUllmskvLtXh6ArWILg94QJB23T
	JAFhnZ2GwNhXGiab7QgMTh0O9Q8KMPjV+IeCgdYRBHqvj4LyHwUEDJsvITD2mmj48WoH+Lue
	kTDp6cPg8+ggArPvDwa+lnMIwoZ0uFllpWCivQOHcv07BLe8Hhz6GyPhA/s3BM01ZynoKXuI
	g8s3Cz4Ehylo01+kwO+8jsFQIwWVZ5tJuGHSISi83UCB4YaFgKbvT2lwDoQwcBt0GNRZdkGX
	uZcAR1kVFrkvYt2fD6byQixS+jHQ332GwZi5loa3t90EmPPjwNTuIqG7xkhDyLsSJiszwV7X
	R4OnVE/APX8HuVmP+N/aKwRfa32E8dr3YYqvr6hH/MS4DvGBO4U4ry2LtK2DwzhfZD3O33EM
	Uvx48CPFN49WEvybKo6/2p7ANxk9NF/04gu9d12KaEOaoFTkCOrETaki+Uf3FzyrQpRb/bOY
	zEffmQsoiuHYNdxQcQ8xxRS7hOvsHMOnOJpdzFkv95JTjLOORdwnZ/wUz2VTOUd1/7RDsHHc
	SEPrtCNm13Jva36R/3bGcnWNLdNOVGTu8jqm90vYJE47XISVIVElmlGLohWqnAyZQpm0XJMu
	z1MpcpcfzsywoMg3mU+Frj5BAdcOG2IZJJ0pdsZ55BJSlqPJy7AhjsGl0eLUGrdcIk6T5Z0Q
	1JmH1MeUgsaGFjKEdL545wEhVcIekWUL6YKQJaj/pxgTFZOPDtptG3dbW7d4k33uUzOEx6Hs
	rK2dqp6KbbnVI8vUc7r7ml7v7w4nM/dXt+lKa4XAS0O/odr16uRAadXrhMTiLv/R82TH5lju
	yfZ4S3ka4zuhdXfE+KMuLFQmmY/HtyUze848N+5jns+xjUNsYkponnHXhzOjKW3BmFWZGaeH
	0qSERi5buRRXa2R/AUKjNwVJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 19ee702273c0..5e45a60ff7b3 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -115,7 +115,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1


