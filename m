Return-Path: <linux-arch+bounces-15196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DACA66AF
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6A0330CBE17
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DB3126B7;
	Fri,  5 Dec 2025 07:20:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143652F7478;
	Fri,  5 Dec 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919206; cv=none; b=etgw6smwczuZ84ayprkiz9siFP/mvgcYUMYGsioR5i1a5rGdUv6R5afx90e17z81vQCDMGxxa5zxUUu/WcBHDNLsjTVmTk1DxbMyhIjEwXl3HFF7pVLaHhbOewORh3ZKRlcuzME7QY+s2ybkbva2ctLrPzSscJV5RGyzXSacShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919206; c=relaxed/simple;
	bh=9t1sHMXhKTNZ11+nCqre6HMv27mPyrH9p28y+6gJZjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YWfjlPdPW/OdoDr1BHJ8PpL/d+xNBxmyTUZBeV4/mUL9FCIEUTDnwq8DGdz+p85FN5fi0NqsenAhqIeQEvrxukj+Okf+eyQXXpAz4i9uqvKpqLZN7mo1D50he0BnjrL/tdF/nnnPv2fy3PGqlsCjmGjWU1EfLMmTykOy0eNoR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-a4-6932876e5850
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
Subject: [PATCH v18 14/42] dept: apply sdt_might_sleep_{start,end}() to dma fence
Date: Fri,  5 Dec 2025 16:18:27 +0900
Message-Id: <20251205071855.72743-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe47nddcK847yYY2UROXqSiaMzMIGpY8HzeNi1GiNuud3FmK
	KcqLiQ6cjNoAdk1go7SAMmuFkmKrmxabSB0NL77U2WBlOMFo1SC4IS/Sgg5q/PY753/O73w5
	HKm8Ry/lZN0hSa9Ta1WMglIMzz/9ma5svbwuOJ0E42MGCqwuJwMGdw0Nk7FaEmbMARaqShC8
	9QUQVN8xk+C8WELAq9Y3DLy0lyOwRGpZsD9+Q0Ds5m0SfqkKIhh9PoDA5zjOwBPTJRLuPl4A
	ofGXDIy0MnDnxhCCSJ+PgB8bXbPl0DQBD+0RCnpMZwioamkjYMrexMLbhlwIND9loeufXhrc
	9zsQjIUGCXCWR0gweMcp8PV9CjV1/QwELj8ioLh2koaeQCcFXZbzFNz2ttAwOBCmYaIyCYI/
	V9AQNj1BUNLeSEGg4UMwR0ZZKHvWxkDofhuCP11/EOCKXCfhrGOYhu4Hr1joNdczED03e7k7
	2k1AafkUCyf6N0LstZUB21gKjJjG6IwMPFlaSWFnnRPhWNSM8AlPAf7tZJTAVywPWNzgPow9
	jtW48epzAvcNpWF300kGG4dDBO7vvcrgkVu3WNz5a4zC/usG9FXyLsUXGkkr50v6ten7FNml
	hovMQStf2DXYQRWjaYURcZwopIpD7fuNKCGO/b9fIeaYEVaJ4fAUOceJwjLRUxGhjUjBkcLd
	ZLFsqjIeLBK+Fo3eUmqOKWGFePNUBzvn5IVNosO66p0zWWxuvRYfT5htV92LxlkpbBTrjZNx
	pyjUJ4g/jU4Q7xY+EtsdYcqE+AY0rwkpZV1+jlrWpq7JLtLJhWu+zc1xo9l3sx+d3n0ZjQa3
	+5HAIdV8/lpBiqyk1fl5RTl+JHKkKpF/oV0nK3mNuuiIpM/dqz+slfL8KImjVEv49RMFGqWw
	X31IOiBJByX9+5TgEpYWI97uXjTvKWvLUkeabC2WM3opt2KLptCml/cu/yvxe6+vxXjkE6Vt
	29Zl0riuR7H52Df/bp/J2JCV37nH88OGGc3Z5oX+xRc6nI3G196072JZwY8zi790OfcwqdWe
	TTX25BcfpPtWKkLV6TvTPs/iZzqbb6zNLNlhteC/+YHMXf/ZVVRetjplNanPU/8PW5KGX2oD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHfe599uw6Wl2W1KWibBBCoLmoOJCUEeGlKIqIXr7YTS853Ky2
	suyFUlvO9WazTWqWZjpCLW1auWokipap5LJSSjNhabKVUZo5t2wafTn8zvn/z5/z4TC04pFk
	HqNOOyzq0gSNksiwbMvq7GhtznJ1bH4rgNFwGnr6PBJ4l1mPYXTEiKGwqpJA0PZICkbHNQm8
	6MrC0HGvAkHfqBHB2ISNBoNzEkPQ3CyFkfEPUrBkIph0NSOwus00dHc8o6GyNpOCn9V/CHgb
	fyCw9HsIFAxlYhi2X0BwfcAmhaGmBPja90QCk72DFHT98iGwe/5Q4KnPQRC0pkJRSU1o3fqd
	wET7KxoKLB0IbvX30vBj6BOC2uaPCFx3sgh8zntAQ6dnJrwZHSbQYjlP4Ku7kIJv1QSKs1wS
	cLd5EdywmREMvHdRkH27ioD1hgOD89NjKbi9AQp6rGYKKhyboc8+gKE1r4QKnRty3Z8LtoJs
	KlS+UGC5+4SCcXu5NL4M8WOGS5gvr3lI8YbXQcJX3qxE/ITfjPiRsmyaN+SF2kbfMM2frTnK
	l7X6CO8ffUt4169izL8s4fjSXD/FX2mP5p3Xe6Vb1+2RxSWLGnW6qFu2Zq8sxWCsJQcL5cda
	+pvwGRSQmVA4w7EruJ6HTmqKCRvFdXeP01McwUZyNRcHJCYkY2i2cxGXM35pWpjNbuNMjw14
	ijG7hGu/3CQ1IYaRs6u4O4VR/zIXcRXV9dP28NDY0uWfZgW7kisyjUnykKwYhZWjCHVaulZQ
	a1bG6FNTMtLUx2KSDmgdKPRO9lOBK3VopDOhAbEMUs6Q1x9VqRUSIV2foW1AHEMrI+Q+Taxa
	IU8WMo6LugOJuiMaUd+A5jNYOVe+cae4V8HuFw6LqaJ4UNT9VykmfN4ZdJWPMQktUc72+O0d
	JZt2bV27eUPS7vPrcd33toC8ZZlT1TjxNFdFbgtFkXG/w9+5396bE5bfZT7tIYOJX7yDFd6F
	OaWO59dUL9cGXy04acqqyg0r1Z3wajuP7zs381ldoyYySXs5MZDUdndHfFxCCnNrYb551uLh
	TYf82OljYxkl1qcIqqW0Ti/8BQUTA21KAwAA
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
index b4f5c8635276..b313bb59dc9c 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -798,6 +799,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -811,6 +813,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -900,6 +903,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -914,6 +918,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1


