Return-Path: <linux-arch+bounces-15201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 566CECA6E7F
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3A7E3826243
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07E31D367;
	Fri,  5 Dec 2025 07:20:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFA2F619A;
	Fri,  5 Dec 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919236; cv=none; b=JO9l1u4qt3cdNd2PMloPiQGAFuQaVtc/Wr/GnNvf4Yh5LthMsFde7LmbKr9JQm43a9DAi3CQXMfV7ND6MYORnMuK9Jrb3zcf7dZW0L1ht+fw5l55krrHaTfJIv59rhVnvzu+CJ+CYHiwJfBRjSRi22O6WdmyW5SDPhCYWGgNYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919236; c=relaxed/simple;
	bh=aqUu/KW8bP0ZWsI+tg2tM04r2CeKAOHdU5WB5GlVlPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jDnTiO7hzdlRNezQFs56Pp76fPEN/ZDv6qoz6Vc6Vs/AzkKqvFAqCrGsTcO3fVseFAvPRS9IPsfhau3iEPWBKsadPAxf+cqwYPfIAcPP9ZwMjN4is3rRLdlatGAyZ4YZOjRu+QY7Cgvckx5kPXnau8qZWnda2mbhgk1MA4mv9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-1e-6932876fec61
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
Subject: [PATCH v18 18/42] dept: apply timeout consideration to waitqueue wait
Date: Fri,  5 Dec 2025 16:18:31 +0900
Message-Id: <20251205071855.72743-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz3Sa0xTdxgGcP/nTrHL8YDxyJJBmqiEBLyEzde4kW0f5smyKRGTJfrBVTmB
	hnJJuYmJEbmspTIxJpVhGRTQytoqXSsIKIgoiAKhDJQyubRaEQaMpVAIl41hzfbtl+fJ+3x6
	GZxzkiGMIiVDVKXIlTJKQkhmN1dFpqr3KfZYBsNAU3geRsY9JPgWNASU11ko0NjKSOgayiPA
	cduMYNynQbC0qsehsGmdgIXllzToLiBwOh7gMP3Ii0Dn9lBQOnWBgDljMYJrE3oapjoOwdDi
	DAKj5x8MPG1qBJXVdgpWe/twKNU5EFS5R3HwTrkQ3OkcQ9BSm0fBm8v1OAx4PoBB3xwFs/3l
	GPxppcCQ10JCfk0dBU2uZhr6p9cwMNu+hXHjBAFXf90G+tJ8DHS37mHQUzNCgL53gIR1QyqM
	lugIGH/yAwl3c1002IY7ECwMujHQNPsIsL1+QUJn4ysMiq31JIxZ1knI1S+RUPfWiUF3ZxcB
	L3tLaOhrvkXCjaF+DNwuJwn23h7883jBZG/ABEuFBQmPZuZwocCeLdzonqGElkUDITyr5oWm
	a6O0YLBlCgWPZ0nBXhsh1NyfwoTfpz8TbKYiSrB5r9BC1eokHht5XPJpvKhUZImq3THfSxKf
	arrwtHr6zE89F+lcVEBpUQDDs9H85Njb/629WYG/M8Xu4p3OZb+D2TDe/uMEqUUSBmcHQnn1
	8iV/EcQe5n+51LJhhiHYHXy1j3sXS9lP+ErH3/j7zVDebG3zO2Aj1w2t+M2xH/OV2iX/Js9W
	BvDm4Vb0/mA7/7DWSVxGUgPaZEKcIiUrWa5QRkcl5qQozkSdTk22oY1/M55bO9GIvI64dsQy
	SLZZ2pa9V8GR8qz0nOR2xDO4LFg6o9yj4KTx8pyzoir1pCpTKaa3ow8ZQrZNum8xO55jE+QZ
	YpIopomq/1qMCQjJRVys7iY5yYZvDe12Fzg6+5KOtWPSsPDWr+p2rRRrAw3lCUHf1F43ntqy
	asr/q+hI2Y7CUyutTnPFwUNe7f6Lpj88NdFBMR+92C2XHtmSt2n7Fw+D59vCRr4+oQ5sUBsG
	unYedf02//OBKut3wXFRZYNzw7FfZvpKDpuPc57zQc+tgfMyIj1RvjcCV6XL/wUW9S5kawMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+997d+91NbksoZtFxihCoRcr40AvFL34J+jlQxBFb0OvOTZX
	bWVZRKkNl5lsi81qlS/pKrUyl6nZaCgO06KZllKaWsuSmUa5xOlcy+jL4Xee55yH8+GwpLRa
	FMkq1McFjVquktFiSrx9deZiddZyxbIaxyrQ685BV49HBO/SnRT4RvQU3HhYTkPAWs2AvvKa
	CJo6MihwPyhD0OPTIxgdt5Kgqw1SEDC5GBgZ+8CAOR1B0OFCYGk1kdDpfk5C+eN0An5VTNLg
	bfiJwNznoSFvIJ2CYVsOguv9VgYGGuPhe0+dCILdXwno+D2IwOaZJMDjzEIQsCghv8geWrf8
	oGH81WsS8sxuBIV93ST8HOhF8Nj1EYHjbgYNXwxVJLR5wqHdN0zDC/MlGr633iBgqIKGggyH
	CFpfehHctJoQ9L93EJB5+yENlpuVFNT2PmWg1TtBQJfFREBZ5TbosfVT0GIoIkLnhqYezQJr
	XiYRKt8IMN+vI2DMVsqsL0F4VJdL4VL7EwLr3gRoXH6rHOFxvwnhkZJMEusMobZhcJjEF+wn
	cUnLII39vrc0dvwuoHBzEY+LL/oJbHy1GNde72Z2btgrXpMoqBSpgmbpukPi5Bf6JvJoFXPq
	6stLzHl0gc5GYSzPreSz79wi/zLNLeI7O8emOIKbz9sv94uykZglubYoPmssd8qYyW3n7+U6
	QsyyFLeQL/JJ/8oSbhWf7w6Q/zKj+LIK5xSHhXRzh3+KpVwcn589KjIgcQGaVooiFOrUFLlC
	FbdEq0xOUytOLUk4klKJQu9kOzthrEEjbfH1iGORbIbEeTJWIRXJU7VpKfWIZ0lZhGRQtUwh
	lSTK004LmiMHNSdUgrYezWEp2SzJ1t3CISl3WH5cUArCUUHz3yXYsMjz6Izm2Ofhwsa7Ow+0
	b2zOev/JfaWhSmrGOfIcYt/+mNwnSfS2roSBPcoOm/JeuPQsqtu9ZcjvWtFekTIvfn70M+Fi
	tCtGP7R5RySONU46JxKnb9poKkiYu8C+ls1bKQTRbBRl8C5SNX8xru97F7fLuCCIe4uftiQn
	eetcH8Krt8oobbI8NobUaOV/AFFnTjtKAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 7815caf61a15..60bed80198e2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -306,7 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1


