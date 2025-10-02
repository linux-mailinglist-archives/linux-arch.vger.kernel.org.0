Return-Path: <linux-arch+bounces-13848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA9BB2F24
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E84387952
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275C2F9DA1;
	Thu,  2 Oct 2025 08:13:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B1A2F28FA;
	Thu,  2 Oct 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392821; cv=none; b=U63CsD3JWRBQzXJZV/NWHnob86mGpH0/wOOQnQhnHBlX+CTk+h8LCGyJNzXGMdclkWkZUoatJ8ybyYLbGfW8BHl8HtVbu6cXfXj4yhapagulWyOxtNHRuGYbTzBsZYphQt8pWd98ltHcmfQDk55QnMqOAHz/mUCuXD9Zu9J8FUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392821; c=relaxed/simple;
	bh=/eJEKpM6DvD7cP5eiSm/CQ1e5JaHdLSiARPtkWa6PhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ge4yrzzVqbvrvISz9UiaWcKOLXoDV2b2vrJmwveaXlty6k5n78gLJHCEEMPqPMLdqwp+Smi7pQW8E0HJjfWrYWD/ySrQXVIbTh4E1DEsiXiMN5uAHWMl7pBZXeK4Tsb+pQUJHDNlsSa63tlvdwY+qBpIJERdFCophcORvDflltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-6e-68de340fbe9a
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
Subject: [PATCH v17 17/47] dept: apply sdt_might_sleep_{start,end}() to dma fence
Date: Thu,  2 Oct 2025 17:12:17 +0900
Message-Id: <20251002081247.51255-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+93XHjS9TclbVtZMFmX20vgSFVFUNyhKogJLc+WlDXXaNNNe
	bORbg2XpQHtsabZSUKeB5USzHCzRNq01Y1paLqMsNLWHj5pG/32+53vO+evwcfEVciFfoUzm
	VEpZnIQSEsKhuYbV3qG98rUW9SJwaJoJeDuWjWCqwMKDyjoNBp+fjiDQfdIQ8K08H0Gxu4QH
	Q28bSJhof4GDrtCGwNDXg8NgdRaCOksvAmthHgVFN00EtGnvYJ4sBSW6QQxK2rtI6DcW88BS
	8ZEH1l4HCabuVgTZj8cIaHyzCgyZZQTYmttIsBbfJ8CpHUCgeVJKgHFYR4L7VSYGFv18qE73
	dGR+nybh7uhXHLIGGyhoL+kgIbOsBoOX3Q0IrnXqKXAU3Kagwk5A9rNxHB62/uBB9fA9CiZ+
	3qC2rWUzOqcotvJWJWInfhcgdvTuZZzN0HrOxnE9wT6/w7CPint4rN50hq01rmRLzZ8w1vQg
	h2Jzh15irMthpliDuhBnb1nDDzARws0xXJwihVOt2RotlNfY1HjiDVGq2dZBqtGkMBcJ+Awd
	yvSaXcR/vmqoomaYoqWM0/kLn2FfeilTe8VNzjBOty1iHPbgGfahw5k/Y6OzWYIOYt5VaWb9
	Inoj0+fWoX+dAUxFdfOsLvDoXX1ts34xHcZkfEvHcpHQ49EJmM6BKfJfYAHzxOgktEikR3Me
	ILFCmRIvU8SFhsjTlIrUkJMJ8SbkGUn5xcmj9WjEdrAF0XwkmSuyBfXIxaQsJSktvgUxfFzi
	K4o2uuRiUYws7RynSjiuOhPHJbUgfz4h8ROtHz8bI6ZPyZK5WI5L5FT/vxhfsFCNwotONDXv
	4sV+kYYoyyMOH8qYty/Ea4vphLRmIDr1w1jp9LudyyrrpSNb888SHZu3DLv8vcL2CIK984b8
	qrT2DW5z54KpnIBpV2RwoO+FriVH9uedtkadj2TTmrYfSI9y1u+Y9FtsX3Ep0Scw7NgF6W47
	hvXvvfr78uvrm3z831uXP5YQSXLZupW4Kkn2F3ZUeBogAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+9/XOZpcluHNomJlRqQVZRxKoi/RpTcSo6IvuerWhlNjK9Mi
	2NSZlNYcTMtZ+ULDdDl1FlkZomTUsrZZFuXUlW2V2iC3ypyuzejL4Xee5+HwfDgCXHyPjBPI
	s07xyiypQkIJCeGezQWJ0RsGZWt9LZugX9NJQMBfTECVxUxBces1EuxNjQiGAsUIfk0ZcdC2
	hwiY1vfQ4J/8QEOoowdBuUOPg7lNg8FE8wwFo90/EBjcIxRUfNUQ4DOVIKj0GGn4+mQ7jA89
	JCHk8mLw9ucYAtPIDAYjnRcQTJdnwM1aKwVTva9wqDDYEdS4XTh8aQ6bbT2DCDrq8yn4rLuL
	Q99INLwO+Ch4ZrhEwbijCoPvzRRU53eQcN2oR1BQZ6Gg/HorAe3DD2hwjAYxGCjXY9DYuhuG
	TB4CbLpaLNwvnGqJBWNFARYeXzAw3HmIwaSpgYYXdQMEmNTxYOztI+FjfSUNQfc6CFVnQ0+j
	lwbXFQMBTeOvyK0GxP3SXia4Bus9jNM6pynOfMOMuKk/esT5bxXgnFYXXrvHfDhXaD3D3bKN
	UdyfwBuK6/hZTXDPa1murDeRa6900Vzh4/f03k2HhCnHeIU8h1eu2ZIulLXY1fjJKlHuI/tL
	Uo2CwosoSsAyG9iyGgsVYYpJYN+9m8QjHMMsZa2lHjLCOGNbxPY7Vkd4HpPKhgJ+IsIEE88O
	WzSzeRGzkXV7KtC/m0vYxubOWT0qrPe5bbN5MZPMan2FmA4Jq9GcBhQjz8rJlMoVyUmqDFle
	ljw36Wh2ZisKf5PpfLDsPvL3be9CjABJ5ooc8S6ZmJTmqPIyuxArwCUxovT6AZlYdEyad5ZX
	Zh9Wnlbwqi60UEBIYkU7DvDpYuaE9BSfwfMneeV/FxNExalRW8LwYufmbue+T4a5Eylpu++s
	XbZG6lTsWvnG3Jbi2QNpuh2p7xMpPPfqnONe70Tp+rTY/uffng7OXF1hj3+sUBO3zxlVitES
	x2/N2NudT5HTXPrgQHRqnKypvsS7y2pLXl50LrTgQ862IzXBpfMTajJPHNyvrXPkB4rEP2It
	SUUSQiWTrluFK1XSvylOh+5JAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by dma fence waits and signals.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 3f78c56b58dc..787fa10a49f1 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -800,6 +801,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -813,6 +815,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -902,6 +905,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -916,6 +920,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1


