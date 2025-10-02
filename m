Return-Path: <linux-arch+bounces-13866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F1BB31AF
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44372463519
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC905313D7C;
	Thu,  2 Oct 2025 08:14:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1E30F807;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392849; cv=none; b=ex+QB8Iw8G1zQrcW3Y0Sw1RxIbewGjS/K26AyjWm1Pv7dtESUjLTdbwYygpvjVQcHikh9iBXqOMyJ3EQLMzo8Z3zw79reiQtWU08LSmwiwoy3aZoMei8A4xldzQQDBUcQRpE8y32s11c8pp2n0HbuNYTfAdJCUC2Rf7betQ5VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392849; c=relaxed/simple;
	bh=wPgCGFth3sUpJztlYzWQSwfpstbJ+L/W/hvoYDKPCvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qUvI2P5esdgB4ic+bq+OH6bWT5XqhhNMl+BmowQS+Z8JqB8deFpKUNpnfQ8tWc/Sc4zfquJJ9Zo2+5gRsIvA7GBZDQgMfBK6Rz2antpFZz5t64RXpMm5HH5ve15UCaPofGhsflfucLXdDj5Ois7NN3cBTuQPcIUHTzQGKJk/Bjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-c0-68de3413dcb9
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
Subject: [PATCH v17 35/47] i2c: rename wait_for_completion callback to wait_for_completion_cb
Date: Thu,  2 Oct 2025 17:12:35 +0900
Message-Id: <20251002081247.51255-36-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSeUiTcRgH8H7v7XD0Ms3eUihWEahph9VTSPRfb4JoSASG5Mi3ttRls5Yr
	CiNnS6xMyDwqPGoe82IrvDLKY5aWObI5xZmr6DRHprNpVpvRfx+e6/vPw+CSHHIlo1CeFFRK
	WYqUEhGib75lG/wixuQbC2cjYWZaR8BAvQHB7HwJDgv5Zhr+tJsRFFjycai9fwEDpz4XwZBr
	AsFCQTIMzjgpmGyk4GJFAwWjBfkYGIzR4NbX0GA2fKSh/ttLEt70ZJNgHO5GoGudIaB9JAQy
	S2ZJeFZcTYBj3EaC6cVzHFxXA6FuspyCry49DheeVBDw4XU2BubSAMj+8ZuES5/aPCFXvxAw
	ONyG4JFuHANjrZWCj8W3Mei1/6DBZLyBw5y9mYS5Sk+eNtdNg8FCgK7LhcOD7lka5n/eonZv
	5Gvv1CJ+fi4f8do8jzonnDifZTrN3+uboPiWYjvNZz0aoXlTVTBf8fAzxhtrLlP8qPUhxU/2
	99N8i2MH/37wJsaXZd7AY7l4UWSSkKJQC6rwXYki+VtjPZ1Wx2WU6W14JnL45yCG4dgIrqJ6
	fw7yWWR1Xg/ymmLXczabG/fan13Nma58IL3G2b4gzmoJ9dqPTeDKe4Zorwl2HfeuvAHzWsxu
	48Z6i/B/N1dxhsbHi/bx1F85+givJexWTuvM8syLPDMlPly/2439W1jBPamyEXlIXIqW1CCJ
	QqlOlSlSIsLkGqUiI+zw8VQj8nyI/tyvg81oaiCuA7EMkvqKB9bZ5RJSpk7XpHYgjsGl/uLE
	qlG5RJwk05wRVMcPqU6lCOkdKJAhpMvFm12nkyTsUdlJIVkQ0gTV/y7G+KzMRNqwZWhki0U7
	HZd8fqdy7+e7J3p3Nm3XhhZeFy9NjBwvCcJizpRHMSFr9jisCXvPBk+1rVXrnzVej/4Vmyb+
	8ic0ICqg6+w13hoR3jpvs5o7GLXUZe3Uaaoj4yuPzBzjimMypl2yon2atZV2v+n1KxxTTQvf
	DxzZXz/U/r6AeRolJdLlsk3BuCpd9hfDyDU/HQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTcRQA8P733t07V4vrHHgxoRjZi+wBGgezJ1G3oEgixCBy5aUNNx+b
	rUwLTUf2nqMpuR66cJjvtrTMVqK4HlN0WTbKaatlVppUWphT24q+HH7nweF8OHxc1MgL48tT
	MjhVilQhIQWEYNfavMiQqH7ZKlf7XOjNbSFgfKyAgKt11SQUWK7woLu2CsHAeAGCX5NGHLRN
	MwRM6e0UjE28oWDGZkdQ5NTjUH0nF4Mf9dMkfGn7jsDg8ZJQ/CmXgFHzeQQlg0YKPrVvg5GB
	Zh7MuD9i8OrnMAKzdxoDb8tpBFNFyXDDZCVhsrMLh2JDN4IyjxuHoXp/8469H4Gt4hQJH3QN
	OPR458KL8VESnhrOkTDivIrB13oSSk/ZeHDNqEeQd7OOhKJrFgKa3t6nwPnFh0FfkR6DKstO
	GDAPEuDQmTD/ff6p26FgLM7D/GEIA0NNMwYT5koKOm72EWDOiQBjZw8P3lWUUODzrIaZ0lSw
	V32kwH3JQEDtSBdvowGxv7QXCbbS2oix2udTJFt9vRqxk7/1iB0rz8NZrc6ftg2P4my+9Shb
	7hgm2d/jL0nW9rOUYJ+ZGLawM5JtKnFTbP7D19TumH2C2CROIddwqpXrEwWyd5ZaKq2GOVZm
	duE5yCM+i4L4DB3F3NI9RgGT9GLG5ZrAAxbTCxjrhUFewDjtCGd6ncsDDqH3M6bHr6iACTqC
	eW+qwwIW0muY/mdX8H875zNV9S1/HeSv93gcRMAiOprRjuZjOiQoRbMqkVieolFK5YroFepk
	WWaK/NiKQ6lKC/J/k/mEr/AeGuvZ1opoPpLMEToj3DIRT6pRZypbEcPHJWJhYkWfTCRMkmYe
	51SpB1RHFJy6Fc3jE5JQ4Y54LlFEH5ZmcMkcl8ap/ncxflBYDtpZ+UBhrwl7szDjQqEuoW3V
	7KwnCYetrnXB3opZn38sQXHlJxuncgyPjp9Nt/E7CtKn4+bE6kuUxGnN8uy4lqyt2d2HOnzf
	Y4bD1WKlJnRffNumzdtj1jr2Nmhysy4HBy2at6U3+q4eZYcEx5dtWPrNW5t817cnITz24LkO
	VdKZ5nYJoZZJVy/DVWrpH7oHRxxJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Functionally no change.  This patch is a preparation for DEPT(DEPendency
Tracker) to track dependencies related to a scheduler API,
wait_for_completion().

Unfortunately, struct i2c_algo_pca_data has a callback member named
wait_for_completion, that is the same as the scheduler API, which makes
it hard to change the scheduler API to a macro form because of the
ambiguity.

Add a postfix _cb to the callback member to remove the ambiguity.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/i2c/algos/i2c-algo-pca.c      | 2 +-
 drivers/i2c/busses/i2c-pca-isa.c      | 2 +-
 drivers/i2c/busses/i2c-pca-platform.c | 2 +-
 include/linux/i2c-algo-pca.h          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 74b66aec33d4..ee86df4cff4b 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -30,7 +30,7 @@ static int i2c_debug;
 #define pca_clock(adap) adap->i2c_clock
 #define pca_set_con(adap, val) pca_outw(adap, I2C_PCA_CON, val)
 #define pca_get_con(adap) pca_inw(adap, I2C_PCA_CON)
-#define pca_wait(adap) adap->wait_for_completion(adap->data)
+#define pca_wait(adap) adap->wait_for_completion_cb(adap->data)
 
 static void pca_reset(struct i2c_algo_pca_data *adap)
 {
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 85e8cf58e8bf..0cbf2f509527 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -95,7 +95,7 @@ static struct i2c_algo_pca_data pca_isa_data = {
 	/* .data intentionally left NULL, not needed with ISA */
 	.write_byte		= pca_isa_writebyte,
 	.read_byte		= pca_isa_readbyte,
-	.wait_for_completion	= pca_isa_waitforcompletion,
+	.wait_for_completion_cb	= pca_isa_waitforcompletion,
 	.reset_chip		= pca_isa_resetchip,
 };
 
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 87da8241b927..c0f35ebbe37d 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -180,7 +180,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	}
 
 	i2c->algo_data.data = i2c;
-	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
+	i2c->algo_data.wait_for_completion_cb = i2c_pca_pf_waitforcompletion;
 	if (i2c->gpio)
 		i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
 	else
diff --git a/include/linux/i2c-algo-pca.h b/include/linux/i2c-algo-pca.h
index 7c522fdd9ea7..e305bf32e40a 100644
--- a/include/linux/i2c-algo-pca.h
+++ b/include/linux/i2c-algo-pca.h
@@ -71,7 +71,7 @@ struct i2c_algo_pca_data {
 	void 				*data;	/* private low level data */
 	void (*write_byte)		(void *data, int reg, int val);
 	int  (*read_byte)		(void *data, int reg);
-	int  (*wait_for_completion)	(void *data);
+	int  (*wait_for_completion_cb)	(void *data);
 	void (*reset_chip)		(void *data);
 	/* For PCA9564, use one of the predefined frequencies:
 	 * 330000, 288000, 217000, 146000, 88000, 59000, 44000, 36000
-- 
2.17.1


