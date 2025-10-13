Return-Path: <linux-arch+bounces-14055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B6ABD4CF6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621EC188B162
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C330BF65;
	Mon, 13 Oct 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfYgJeQ1"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB430BBBD
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370851; cv=none; b=m8wsLBuqv9uN10/eNnKtQbTvYkMArqTwqnpD7DhOeNFHWGoqDd65sbChuD8XorgQl2SJBrhaAKMWq61umG4LcbK1kPYKzJquthxQPIo+it0Nm7ro5e8lTwdFsmyAUChfjCL2cK5nHU3Ax3fnAEYhj0ReKz5Vdvfg5cw8NLRIB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370851; c=relaxed/simple;
	bh=OvzJovNv1ctaRAi0qWxBvnsOPU9DoRZIj3SLiUKtWkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PujwoHl8pfCa85zoz/vzLVjIZVPWrdGHGIZK3dq23krejYVUwrwcfvwX/lCFlwwSIzQ1kQwXVsP/ph6Hx5K6CS/R/F4+LZRAVNTwvTUZreMn7TIv0987ZKgUxVqW+N5fwHsemWvDe7BoEq+bCWu9piau9O6E4E/Nr/XkCdFoqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfYgJeQ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVWnS0RcSrifKORRkaxSlEBfAdbDlyJkXOwnKgyyCWE=;
	b=AfYgJeQ1gC1GSNrKw12Ht1DOe7+ILg3nFS359qUVBJwtDgqQwdh+u2fNKSzgqrimsijcVY
	8qu0jxMGntNhi4kskjdfuGyuF/B8X6qYDioQRubBvpysaD3c/ohTKAgtahT263pEffmAoC
	k36bEfw+BujXUrRRup6zwid5o87oWCQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-hoQr19x9MGeShnhZzexXCg-1; Mon,
 13 Oct 2025 11:54:05 -0400
X-MC-Unique: hoQr19x9MGeShnhZzexXCg-1
X-Mimecast-MFC-AGG-ID: hoQr19x9MGeShnhZzexXCg_1760370842
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D86331954105;
	Mon, 13 Oct 2025 15:54:01 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BC8E30002D0;
	Mon, 13 Oct 2025 15:53:56 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v13 04/17] preempt: Introduce __preempt_count_{sub, add}_return()
Date: Mon, 13 Oct 2025 11:48:06 -0400
Message-ID: <20251013155205.2004838-5-lyude@redhat.com>
In-Reply-To: <20251013155205.2004838-1-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Boqun Feng <boqun.feng@gmail.com>

In order to use preempt_count() to tracking the interrupt disable
nesting level, __preempt_count_{add,sub}_return() are introduced, as
their name suggest, these primitives return the new value of the
preempt_count() after changing it. The following example shows the usage
of it in local_interrupt_disable():

	// increase the HARDIRQ_DISABLE bit
	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);

	// if it's the first-time increment, then disable the interrupt
	// at hardware level.
	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
		local_irq_save(flags);
		raw_cpu_write(local_interrupt_disable_state.flags, flags);
	}

Having these primitives will avoid a read of preempt_count() after
changing preempt_count() on certain architectures.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

---
V10:
* Add commit message I forgot
* Rebase against latest pcpu_hot changes
V11:
* Remove CONFIG_PROFILE_ALL_BRANCHES workaround from
  __preempt_count_add_return()

 arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
 arch/s390/include/asm/preempt.h  | 10 ++++++++++
 arch/x86/include/asm/preempt.h   | 10 ++++++++++
 include/asm-generic/preempt.h    | 14 ++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 932ea4b620428..0dd8221d1bef7 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -55,6 +55,24 @@ static inline void __preempt_count_sub(int val)
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
+static inline int __preempt_count_add_return(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc += val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+
+	return pc;
+}
+
+static inline int __preempt_count_sub_return(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc -= val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+
+	return pc;
+}
+
 static inline bool __preempt_count_dec_and_test(void)
 {
 	struct thread_info *ti = current_thread_info();
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 6ccd033acfe52..5ae366e26c57d 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -98,6 +98,16 @@ static __always_inline bool should_resched(int preempt_offset)
 	return unlikely(READ_ONCE(get_lowcore()->preempt_count) == preempt_offset);
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	return val + __atomic_add(val, &get_lowcore()->preempt_count);
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	return __preempt_count_add_return(-val);
+}
+
 #define init_task_preempt_count(p)	do { } while (0)
 /* Deferred to CPU bringup time */
 #define init_idle_preempt_count(p, cpu)	do { } while (0)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 578441db09f0b..1220656f3370b 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -85,6 +85,16 @@ static __always_inline void __preempt_count_sub(int val)
 	raw_cpu_add_4(__preempt_count, -val);
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	return raw_cpu_add_return_4(__preempt_count, val);
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	return raw_cpu_add_return_4(__preempt_count, -val);
+}
+
 /*
  * Because we keep PREEMPT_NEED_RESCHED set when we do _not_ need to reschedule
  * a decrement which hits zero means we have no preempt_count and should
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 51f8f3881523a..c8683c046615d 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -59,6 +59,20 @@ static __always_inline void __preempt_count_sub(int val)
 	*preempt_count_ptr() -= val;
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	*preempt_count_ptr() += val;
+
+	return *preempt_count_ptr();
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	*preempt_count_ptr() -= val;
+
+	return *preempt_count_ptr();
+}
+
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	/*
-- 
2.51.0


