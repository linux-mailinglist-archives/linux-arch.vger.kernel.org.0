Return-Path: <linux-arch+bounces-13873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CFBB324B
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840104C4E80
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801431619E;
	Thu,  2 Oct 2025 08:14:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6E311C2A;
	Thu,  2 Oct 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392854; cv=none; b=WZPeOKkIotPpFX+3kR8D6L1N9/kwJ21d7xSrYdu/huG9Kf/K9sKBGFuJRL7e+BpTLexgkJ9WpY6Vil0VvozC+QClZazkZLtMP/zCEFKp8I5Z7eu9ZT8pd4n5Mn3oXQjHSETVrNpuqQVwtO++sECpsIPuZp2ZHznmdKepgYMDfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392854; c=relaxed/simple;
	bh=Maxqvp8M2/Mbhj5qDNZmaX54vuIa2E/KjRgY0LGmkyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eOF9Tvpu/qb2IGaios3YBkQ1qO5xIoLYommvyVhc2n3fs9D3/PHnboOSUkxUHNxHuMe+nUrnm7uTgbK1c0JQetwMBgU7uUysXkIS5Hz29yNv+dcCSfVAZA0WL5DIjzajl3lihKD3Yz8GForrNkh5EY6OpNsq3MVY7b+BsQsfvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-96-68de34150086
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
Subject: [PATCH v17 42/47] dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state
Date: Thu,  2 Oct 2025 17:12:42 +0900
Message-Id: <20251002081247.51255-43-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXVBMcRjG/c/5n7OnZaczq3TI55qmEaKs5mUMbsycCxfowqgLls60O7aV
	7ZthdkfRxyhlqiE1W+m7yMaoVFMhTDQbqWU69J2GPqx2iyJbxt1vfs/zvFcvQ8qTqDWMRhcp
	6HUqrYKWYun4ivzt7spP6p2GxtVgn07EkGi+RUFm/xAN2WNGDAviKAE9jm8IsjMtCPL7RRK6
	7JM0vMpMoSE3JwNBVq4ZQ11fvcS5oOF1YS+GtopRCYhpmRi+jmTQkFhvx9D4cSvkX73rDGsH
	CLg/aiWgve0lhqKeTgIcqZ5gSb9OgfXGMIKqiQIavjqKSSi2T0qgzbQKMkZsErDddWB4k9NB
	QVNiHwE335po+CXWUmDL/UNBRSeGHGMqgpSELAzV30toMP74jGBu9g4Ns9WDFORO+0HV7250
	cCdfmVeJ+OmiKyQfXxPD/7K/p/lGhwnz6W+283W3RQkf3/RRwpvMUXz8s3GKryn14Qsbxgje
	XJ5E8xMdHRJ+qCub4PNeHT3iESTdFyJoNdGCfsf+U1L1QvNDKtzoGpvwxIYNaHx5MnJhOFbJ
	Fd0zUv85r2RyiWnWm7Naf5KL7MZu5Gqujyx5km1fy3V3bktGDLOSPc2V96sXNWa9uMKq8aW6
	jA3gnr0YJP6d3MBVVDcveRenf9ffjhdZzu7mEibjnR2ps1Piwg33ppH/Bqu5llIrvoFkJrSs
	HMk1uugwlUar9FXH6TSxvmfOhZmR80GKL80H1yKbJbAVsQxSrJBZvES1nFJFR8SFtSKOIRVu
	slOlvWq5LEQVd0HQnzupj9IKEa3Ik8EKD5m/IyZEzoaqIoWzghAu6P+nBOOyxoDcNu/VBko4
	Nr1JNeCuXNvSIU5pGq/h34FbfA5tCjjruq7BkpXnfnJCGNxQZR9IL9MX2MUHX2a6jp/+cGxz
	SPDR8uGkE+GGWDHUloYHlakG/+m5y31ljxMupjoC1jsip2bEoOcHakYeHTZMnV/vdWJqYpf3
	nqf59x95NT88gs8kzStwhFrl50PqI1R/ARPICcEcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTaRSF/c/5z4WOlTMdMp4oidqEkMwgagJmZ2qMzosnRo0ao4kvUvA4
	rdxMiwwYTbg1EEaUNrZEqlghFqSACGjEWiSg9YIItSPgQGWqHbxArVGQIIVOwfiys/a3VnbW
	w2ZJ2Q1qBavOyBI1Gco0OS3Bkl2KwrVRCS9V659bEmEgvxPD1GQJhgvXGmgoaTlPQX+TDcHo
	VAmC6VkzCbr2EIY5g5OByZlhBkIOJwKTy0BCQ1s+AZ+b52kY7/6EwOj10VDxLh9DwHoaQeWY
	mYF397eBf9ROQcjzhoDBLxMIrL55AnydxQjmTKlwqbqVhtnePhIqjP0ILns9JLxtDpttzpcI
	HHUFNPxXfoMEt28Z/D0VoOGR8S8a/K4LBHxopsFS4KDgotmAoLDmGg2miy0Y2v+9zYBrPEjA
	iMlAgK1lJ4xaxzD0lFcT4X7h1PXlYK4oJMLjLQHGRjsBM9Z6Bp7UjGCw5sWAuddNwau6SgaC
	3g0QsmSC0/aGAc9ZI4Ymfx+1xYiEad0ZLNS33iQE3bM5WmioakDC7FcDEiavFJKCrjy8dk8E
	SKGo9U/hSs8ELXydek4Lji8WLDyu5gV971qhvdLDCEUd/zC7fzso2XRYTFNni5p1m5MkqlBn
	G3UsPzJHZ/+E85D/h1IUwfJcAl9VG6AWNM3F8kNDM+SCjuJW861lY4uc5Hqi+QFXXCli2Z+4
	ZL7eq1rAmIvhaxr9i3Ept5G/9+A18e3kKt7W3LnII8Lc7e3BC1rGJfK6QBFRjiQWtKQeRakz
	stOV6rTEeG2qKjdDnROfkpnegsLPZD0V1N9Ck+5tXYhjkXyp1BXjUckoZbY2N70L8Swpj5Im
	1Y2oZNLDytwToibzkOZ4mqjtQitZLF8u3X5ATJJxfyizxFRRPCZqvrsEG7EiD+XK++ePDA25
	dt8sS0k5nfJsP467e3lHxL41YvKDvuBt51XFj47pO9EF9u2xOabk8TNPi4cteved4sFh/b5V
	8ZEKf+T10ljS1ntu696f4371lH2kqjpifFxAR++piHcpqj+4DO83js09VKjHT9b+3mTX9ye8
	aHwaLe4J7tVlzcQelWOtSrnhF1KjVf4P8xIkJkgDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

For dept to function properly, dept_task()->hardirqs_enabled must be set
correctly.  If it fails to set this value to false, for example, dept
may mistakenly think irq is still enabled even when it's not.

Do dept_hardirqs_off() regardless of irq state not to miss any
unexpected cases by any chance e.g. changes of the state by asm code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h | 14 ++++++++++++++
 kernel/dependency/dept.c |  1 +
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d8b9cf093f83..586f5bad4da7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -214,6 +214,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_disable();		\
 		if (!was_disabled)			\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
@@ -221,6 +228,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_save(flags);		\
 		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 0f4464657288..a17b185d6a6a 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2248,6 +2248,7 @@ void noinstr dept_hardirqs_off(void)
 	 */
 	dept_task()->hardirqs_enabled = false;
 }
+EXPORT_SYMBOL_GPL(dept_hardirqs_off);
 
 void noinstr dept_update_cxt(void)
 {
-- 
2.17.1


