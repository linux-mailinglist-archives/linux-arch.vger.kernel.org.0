Return-Path: <linux-arch+bounces-15188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598DCA6844
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 08:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 310B33176331
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F03002A9;
	Fri,  5 Dec 2025 07:19:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8212FC870;
	Fri,  5 Dec 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919168; cv=none; b=AZZgLz1n7hEeI0JhNsONqfHQidjIeWWH+iNtNSQfKKlNLVnqMCB/hPR9sqiLjf5mem0hrZyYGtRfalCfucDkOmiQ2jAY6RQjJZgGO+BMNB8OzNNEq202U8N9GjpgdhTtIsDBVKqDl2FrTEYRsBZn8ou6TM+kJFjajgQ4x2uVGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919168; c=relaxed/simple;
	bh=ZBufOsf5101zZeF1bYop0Nqu5Rg0RXtJg4uE7RC7rbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g3YoFA6MV24uc5w/pz0tKn74xCSZNyFDJChjYMQMRo5mPybgdPDepdCI2LzzstYENtyWZ5j6OirBSv5k8m0WInq/7huRk7bk8IdyR+n+i5vfma28VW1KiCrEFxefurXVqdEiugGQDZkEYk5FAFr382rXynHxQnpczvKox9vWwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-c6-6932876c6a95
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
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 07/42] dept: distinguish each work from another
Date: Fri,  5 Dec 2025 16:18:20 +0900
Message-Id: <20251205071855.72743-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxiH/Z871ZKTzsQjfig5yWKiUcHA8s6o8ZLo+aIxXmKUD9qNM2ks
	BVsF8bJQRYoNAmMWsnIrUlmlXKQd3kaXWoG5aRHUaZVixEG1IFUrhYAI1hq/PcnvyfN+eRlc
	5iPjGKX6sKhRK1Q8JSEko/Nql6n0K5UJhfp46Gm2IRib7KNh1tmFYORWCIFxYJCC8oCOgDf1
	hQhM/goaAp2bYbb/JQb1gzMYDLr0EbfsLQWhwHMEQyVtODwMv6FgtLcSA/MpJwllVXYCekem
	MXhhNUXq5gzoLzYSMOIvpcD+pBNBY6Efh4IbYQKcT5dCbb6FgN+qfRR0XXuBwbPGWRJaXnox
	+Md0iYA+TzEN9240keDw3MXBWzKEoCl4gYJfg34E911mDHQ36wiwvisn4VLN7whK/SEaQpZx
	AvLfz5Dw9zkXBvpXf1LgqegmId/SikFHy1UMLlpHSfi3/z0NDrsRh1BVRDZOF1BQoStCUNAx
	jkNb5wQNeb5kqBpLhDFbAwVNHx+hdeuEBscVTGisbkTCxTuvKWEq/B8lXDf104LZfkRwWJcI
	de0BTHg6skawN5ylBHuolBZqP7zCBd+jdkoIdnfTwvWB74XaXCO+LW6vZHWqqFJmiZoVa/dL
	0sIPm4nMIH20r/IPLBe1UwYUw3BsEnfmtI7+ygO+HvwzU+xizuudjPJ8Np5znPOTBiRhcPaB
	nNNPFkUGhvmG3cjVnT/x2SHYb7nWUkO0KWWTuZlfrpBfmnLOdtkV7cSw33HGx1NRlkWcGsNE
	tMmxNTGc4eqXYxy7kLtp9RIlSGpGcxqQTKnOSlcoVUnL03LUyqPLf8xIt6PIz9WfnE65hkI9
	O9yIZRA/T+rKTlTKSEWWNifdjTgG5+dLX6sSlDJpqiLnmKjJ2Kc5ohK1brSIIfgF0pXj2aky
	9oDisHhQFDNFzdcVY2LictG2RVL5dt4Uvv1B1zac0dF2n3cObemd3qh12obVe/6SxUKZOb78
	p4nmGc09eXF5EX6o2hYrtwT/l7xLGJ47qxOnNnnGn6y6dVCqyFPhu3cu+/l4l37FnV3J2QWe
	Ve5AiuUA35x0mXsw9MPWvFjRXF/dZOb3bdjvrtS2rM9s3bGQJ7RpisQluEar+ASAi+9MbwMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xScRjG+58bRxbtjNw65YcaW7ObZK3L27RW64Onmt2+tLVWUZ7iBGqD
	Mm25UiJNuwATWGJqlsyUyrxUlhRRua5LstJSQzeyHJZdRFNCI1tf3v3ePc/77Pnw0rj0JjmN
	FlIO8JoUhVpGiQnx+jhdjCpnoRCb8y4ecvVHocPrI+FtlouAwEAuAUXXHBSEbDdFkFtzjoTH
	rdkENF+tQuAN5CIYCtpw0DeMERAyNYlgYLhdBOYsBGPOJgQWjwmHtuZ7ODjqsjD4WT1Kgf/B
	DwTmbh8F1t4sAvrtpxAU9thE0PsoAb5475Aw1vkJg9bBPgR23ygGPlcOgpBFBSVlteFzyzcK
	gi9e4mA1NyO40N2Jw4/eLgR1TR8QOCuyKfhoqMehxTcJXgf6KXhizqfgi6cIg6/VFJRmO0nw
	PPcjOG8zIeh578RAd/EaBZbzNQQ0dN0Wgcf/G4MOiwmDqppE8Np7CHhmKMPCdcOu61PAZtVh
	4fEZA/OVOxgM2ytFK8sRN6Q/Q3CVtTcwTv8qRHGOYgfigiMmxA2U63BObwivD/r6ce547SGu
	/FkfxY0E3lCcc7CU4J6WsdylkyMYZ3wRwzUUdoo2rtoqjk/i1UIar5m/YqdYGXh9ldj/VZTe
	XlSHHUONVB6KoFlmEdvd0Yz/ZYqJZtvahsc5kpnB1p7uIfOQmMaZlulszvCZsEDTk5nV7MWC
	I389BDOTvW7KG8+RMIvZUeMN8l/mdLaq2jWeE8EsYc2tI+MsDXtK8oZIAxKXogmVKFJISUtW
	COrFcq1KmZEipMt3pybXoPA72TN/G2+hgZYEN2JoJJsocR1aIEhJRZo2I9mNWBqXRUr61LGC
	VJKkyDjMa1J3aA6qea0bRdGEbIpk7RZ+p5TZqzjAq3h+P6/5r2J0xLRjyNnIxRUsu+yV8+59
	e+pNUa+mPh1sjMfy7xuYuIeCTvn+yaeZhd3r+Eym+LEzf/vWmHfe5U6rfxfObzZF9UrnCR5X
	e9Imd7DeeCnxbvBXxtQKB9yLTj2R4NlSui95YWj+XP2igiMuZcXZ9K6lD8eMG2YP4d/nrYmV
	F6mstsxZ22SEVqlYMAfXaBV/AArVmUJKAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Workqueue already provides concurrency control.  By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 253311af47c6..ab7425adc826 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -55,6 +55,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -3174,6 +3175,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_update_cxt();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1


