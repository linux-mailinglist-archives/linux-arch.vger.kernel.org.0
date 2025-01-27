Return-Path: <linux-arch+bounces-9921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29294A1DA33
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B583A80A3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3318872F;
	Mon, 27 Jan 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXLDTB2l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACF17C20F;
	Mon, 27 Jan 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994049; cv=none; b=abqfNPi1LrYJLMvw10iIzJL4kDPhiOyD3UXFdesnbokKsVdRGdivFeRmFOL6g2t161hq9PufEmT8PDTitMypy09EPzyoYwDimLwPyKkGr1wy3YqQRwX3OG/ebR4ycDJDr3ZeL3gUHlwJXTcVbQp9gU5Ycz70qNDGUwOoKh5MNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994049; c=relaxed/simple;
	bh=+OxcuWyTmpuvVZrJy438ZPLoZDH7E8GuHxtnwkkCxWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+JYpR44kbvr66S6A6nZkQSdaRgtyG2E4qLt6AH0C1LcvXnokB5Lpq5vIpjECI3zo00hlD+GrHLn4zM0Hx1q0PdnlO8URZCu4mnYgqarrbLFo0O7hO1ug9B1gYQ/AVgTAeNyanA6eDJJmeHiE/6aLrJTzrYyJbhBGbTK+9m/Egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXLDTB2l; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab68d900c01so369969766b.0;
        Mon, 27 Jan 2025 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994045; x=1738598845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuZxe+AfFouuIU0wQHkXEH3/7ewa5etNqEUu9GIF73k=;
        b=aXLDTB2lk6O6zVBh7ADoKQlxm4UveK3OvoMyavu3ymqtGnSwDFYohFUT+vsQvcYnXZ
         4Gn2tv36F/xzgJmG6DZHOGB2k3kUkN2qJLCARiYNSMjCZCDC8fU80H1n5vCSA58z6uiy
         JwxHQZVbEria5GZrihTQivncia53V9mbOLDeqML9F8arJnFVhQr1H9gyF5dUEKMffx/H
         XQuZjLz8DzYGN+wnb51eqPIHh0tQDmvoE1bkCz0zgDArnUN25KGR0f/hg7OV+6vDisQv
         rYAj6lKB5i+egADZAV3unDxe1tRZqxl7hQSIctRKo7LXaTRgrkeuYL6z+IjuQMY4GId+
         6g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994045; x=1738598845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuZxe+AfFouuIU0wQHkXEH3/7ewa5etNqEUu9GIF73k=;
        b=p+Qd7C0A9jDvVJdByVf+K3uOy62mAiRif+V14nQB4CoK1v0132bQsiIcKwNyRHJOM6
         Q+lJQx0WlxYzk5jigUg/vdRIMqz9n8jiPTJdcYnU6fvGrfqEiFoZ54shqMj2PlHs7cDD
         wN0Ur2pdmGtu/rMscSu2/sDF4YXfBu+Van5QEDwb8Qy28b4OjIi47UWEUVTKE/8ZOLVS
         UGIQkI02UBR7/cwfCORRCWc+EJpG1xw+Fe1lG/HZBBXd9JHGa7bL3Lw02Am6L31Ye5QN
         /Gh/aK2gKZ+pnitpWl9yiuacPN0LoBRhzf9sVHjZqL70WkqXjKbN1v/7drfV+8HH0MX1
         py4w==
X-Forwarded-Encrypted: i=1; AJvYcCUEgFfCu5e4r4ORPq/513Wtna7AB9KBwFvY3bH/zPpu1DTuvVT3iVv6WKFEIC2c0qGYKyfGns+iVdqMXVvK5xk=@vger.kernel.org, AJvYcCViWIe/SA70T3ZlGBv74FjUnYHtf9Z10mX1m5dZ+nUZd0eeFdbWVrP0zby793KThyjIHhGxnbAL@vger.kernel.org, AJvYcCWzC4gm7ZQD+Xp2k5viFCghGz/r6ncBhjHKeWcdjaugXIhWjBU5Ays9HUw85UyE27oSNDIozl1AnMqZ@vger.kernel.org, AJvYcCXTLHAYGtsProesjkjTolRMr8ce011xJMsHyiBbuUz+Ua1akZi3/bLd4dMQhU3Fu88Qw4GAHrKHWtF6Y9q+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oyyDcyfbt1/Ya9dlRfyy6L3QjpLmdPH+mDziFeeeK7iLejwe
	PNWSt8DClbWI/CTLijXRSZzn/mPlhE6K+KUg4ZrdF42GgGnQV4nL
X-Gm-Gg: ASbGncsKrjwyZDeHtxI+gmKaQuf7ZFn8R1dBuYnjugkTYgBR8jLqMLHIpISqympIODN
	UOvftpryQ7WqpFpQn4qEdec7t/8gQzCjm6HUCHrUPvXvElBYYhmU5BKgUvLA2im66Ix1HAqhHVH
	jhH0cZEnjPuhtyKkgJOosZDNGmwZReu+P6LBB67mzIFdZOw/3Nh3Ozbwxhs8UvJ/icrMnXIla43
	s8f+ZlV6qyB4TT6rkI4hz4qyTDhAV+JuqPXH/vwRhDPGEbvr8h7kg0uxwIzlfCBvKn/X19nzU0H
	KFVvAOPbAd3v2g==
X-Google-Smtp-Source: AGHT+IEhkb1QlpKpjEVh9Qlf5cg4BvflbRVDsJrlA2oE2R2yIM44Ae2Zi5eaJQiOnUdYAJplTRaD5w==
X-Received: by 2002:a17:907:7e85:b0:ab6:59e0:b756 with SMTP id a640c23a62f3a-ab6629cce1dmr1786130466b.14.1737994045166;
        Mon, 27 Jan 2025 08:07:25 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:24 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 3/6] percpu: Use TYPEOF_UNQUAL() in variable declarations
Date: Mon, 27 Jan 2025 17:05:07 +0100
Message-ID: <20250127160709.80604-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250127160709.80604-1-ubizjak@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use TYPEOF_UNQUAL() to declare variables as a corresponding
type without named address space qualifier to avoid
"‘__seg_gs’ specified for auto variable ‘var’" errors.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 10 +++++-----
 fs/bcachefs/util.h            |  2 +-
 include/asm-generic/percpu.h  | 26 +++++++++++++-------------
 include/linux/part_stat.h     |  2 +-
 include/linux/percpu-defs.h   |  4 ++--
 include/net/snmp.h            |  5 ++---
 kernel/locking/percpu-rwsem.c |  2 +-
 net/mpls/internal.h           |  4 ++--
 8 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e525cd85f999..666e4137b09f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -180,7 +180,7 @@ do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 									\
 	if (0) {		                                        \
-		typeof(_var) pto_tmp__;					\
+		TYPEOF_UNQUAL(_var) pto_tmp__;				\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
@@ -219,7 +219,7 @@ do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 									\
 	if (0) {		                                        \
-		typeof(_var) pto_tmp__;					\
+		TYPEOF_UNQUAL(_var) pto_tmp__;				\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
@@ -240,7 +240,7 @@ do {									\
 			 (val) == (typeof(val))-1)) ? (int)(val) : 0;	\
 									\
 	if (0) {							\
-		typeof(var) pao_tmp__;					\
+		TYPEOF_UNQUAL(var) pao_tmp__;				\
 		pao_tmp__ = (val);					\
 		(void)pao_tmp__;					\
 	}								\
@@ -273,7 +273,7 @@ do {									\
  */
 #define raw_percpu_xchg_op(_var, _nval)					\
 ({									\
-	typeof(_var) pxo_old__ = raw_cpu_read(_var);			\
+	TYPEOF_UNQUAL(_var) pxo_old__ = raw_cpu_read(_var);		\
 									\
 	raw_cpu_write(_var, _nval);					\
 									\
@@ -287,7 +287,7 @@ do {									\
  */
 #define this_percpu_xchg_op(_var, _nval)				\
 ({									\
-	typeof(_var) pxo_old__ = this_cpu_read(_var);			\
+	TYPEOF_UNQUAL(_var) pxo_old__ = this_cpu_read(_var);		\
 									\
 	do { } while (!this_cpu_try_cmpxchg(_var, &pxo_old__, _nval));	\
 									\
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 1a1720116071..e430a32050c2 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -609,7 +609,7 @@ do {									\
 
 #define per_cpu_sum(_p)							\
 ({									\
-	typeof(*_p) _ret = 0;						\
+	TYPEOF_UNQUAL(*_p) _ret = 0;					\
 									\
 	int cpu;							\
 	for_each_possible_cpu(cpu)					\
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 94cbd50cc870..50597b975a49 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
+	TYPEOF_UNQUAL(pcp) *__p = raw_cpu_ptr(&(pcp));			\
 									\
 	*__p += val;							\
 	*__p;								\
@@ -82,8 +82,8 @@ do {									\
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
-	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __ret;						\
+	TYPEOF_UNQUAL(pcp) *__p = raw_cpu_ptr(&(pcp));			\
+	TYPEOF_UNQUAL(pcp) __ret;					\
 	__ret = *__p;							\
 	*__p = nval;							\
 	__ret;								\
@@ -91,7 +91,7 @@ do {									\
 
 #define __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, _cmpxchg)		\
 ({									\
-	typeof(pcp) __val, __old = *(ovalp);				\
+	TYPEOF_UNQUAL(pcp) __val, __old = *(ovalp);			\
 	__val = _cmpxchg(pcp, __old, nval);				\
 	if (__val != __old)						\
 		*(ovalp) = __val;					\
@@ -100,8 +100,8 @@ do {									\
 
 #define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
 ({									\
-	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __val = *__p, ___old = *(ovalp);			\
+	TYPEOF_UNQUAL(pcp) *__p = raw_cpu_ptr(&(pcp));			\
+	TYPEOF_UNQUAL(pcp) __val = *__p, ___old = *(ovalp);		\
 	bool __ret;							\
 	if (__val == ___old) {						\
 		*__p = nval;						\
@@ -115,14 +115,14 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(pcp) __old = (oval);					\
+	TYPEOF_UNQUAL(pcp) __old = (oval);				\
 	raw_cpu_generic_try_cmpxchg(pcp, &__old, nval);			\
 	__old;								\
 })
 
 #define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
-	typeof(pcp) ___ret;						\
+	TYPEOF_UNQUAL(pcp) ___ret;					\
 	preempt_disable_notrace();					\
 	___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
 	preempt_enable_notrace();					\
@@ -131,7 +131,7 @@ do {									\
 
 #define __this_cpu_generic_read_noirq(pcp)				\
 ({									\
-	typeof(pcp) ___ret;						\
+	TYPEOF_UNQUAL(pcp) ___ret;					\
 	unsigned long ___flags;						\
 	raw_local_irq_save(___flags);					\
 	___ret = raw_cpu_generic_read(pcp);				\
@@ -141,7 +141,7 @@ do {									\
 
 #define this_cpu_generic_read(pcp)					\
 ({									\
-	typeof(pcp) __ret;						\
+	TYPEOF_UNQUAL(pcp) __ret;					\
 	if (__native_word(pcp))						\
 		__ret = __this_cpu_generic_read_nopreempt(pcp);		\
 	else								\
@@ -160,7 +160,7 @@ do {									\
 
 #define this_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(pcp) __ret;						\
+	TYPEOF_UNQUAL(pcp) __ret;					\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_add_return(pcp, val);			\
@@ -170,7 +170,7 @@ do {									\
 
 #define this_cpu_generic_xchg(pcp, nval)				\
 ({									\
-	typeof(pcp) __ret;						\
+	TYPEOF_UNQUAL(pcp) __ret;					\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_xchg(pcp, nval);			\
@@ -190,7 +190,7 @@ do {									\
 
 #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(pcp) __ret;						\
+	TYPEOF_UNQUAL(pcp) __ret;					\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_cmpxchg(pcp, oval, nval);		\
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index ac8c44dd8237..c5e9cac0575e 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -33,7 +33,7 @@ struct disk_stats {
 
 #define part_stat_read(part, field)					\
 ({									\
-	typeof((part)->bd_stats->field) res = 0;			\
+	TYPEOF_UNQUAL((part)->bd_stats->field) res = 0;			\
 	unsigned int _cpu;						\
 	for_each_possible_cpu(_cpu)					\
 		res += per_cpu_ptr((part)->bd_stats, _cpu)->field; \
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 5b520fe86b60..79b9402404f1 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -317,7 +317,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
 #define __pcpu_size_call_return(stem, variable)				\
 ({									\
-	typeof(variable) pscr_ret__;					\
+	TYPEOF_UNQUAL(variable) pscr_ret__;				\
 	__verify_pcpu_ptr(&(variable));					\
 	switch(sizeof(variable)) {					\
 	case 1: pscr_ret__ = stem##1(variable); break;			\
@@ -332,7 +332,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
 #define __pcpu_size_call_return2(stem, variable, ...)			\
 ({									\
-	typeof(variable) pscr2_ret__;					\
+	TYPEOF_UNQUAL(variable) pscr2_ret__;				\
 	__verify_pcpu_ptr(&(variable));					\
 	switch(sizeof(variable)) {					\
 	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
diff --git a/include/net/snmp.h b/include/net/snmp.h
index 468a67836e2f..4cb4326dfebe 100644
--- a/include/net/snmp.h
+++ b/include/net/snmp.h
@@ -159,7 +159,7 @@ struct linux_tls_mib {
 
 #define __SNMP_ADD_STATS64(mib, field, addend) 				\
 	do {								\
-		__typeof__(*mib) *ptr = raw_cpu_ptr(mib);		\
+		TYPEOF_UNQUAL(*mib) *ptr = raw_cpu_ptr(mib);		\
 		u64_stats_update_begin(&ptr->syncp);			\
 		ptr->mibs[field] += addend;				\
 		u64_stats_update_end(&ptr->syncp);			\
@@ -176,8 +176,7 @@ struct linux_tls_mib {
 #define SNMP_INC_STATS64(mib, field) SNMP_ADD_STATS64(mib, field, 1)
 #define __SNMP_UPD_PO_STATS64(mib, basefield, addend)			\
 	do {								\
-		__typeof__(*mib) *ptr;				\
-		ptr = raw_cpu_ptr((mib));				\
+		TYPEOF_UNQUAL(*mib) *ptr = raw_cpu_ptr(mib);		\
 		u64_stats_update_begin(&ptr->syncp);			\
 		ptr->mibs[basefield##PKTS]++;				\
 		ptr->mibs[basefield##OCTETS] += addend;			\
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 6083883c4fe0..d6964fc29f51 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -184,7 +184,7 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
 
 #define per_cpu_sum(var)						\
 ({									\
-	typeof(var) __sum = 0;						\
+	TYPEOF_UNQUAL(var) __sum = 0;					\
 	int cpu;							\
 	compiletime_assert_atomic_type(__sum);				\
 	for_each_possible_cpu(cpu)					\
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index b9f492ddf93b..83c629529b57 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -33,7 +33,7 @@ struct mpls_dev {
 
 #define MPLS_INC_STATS_LEN(mdev, len, pkts_field, bytes_field)		\
 	do {								\
-		__typeof__(*(mdev)->stats) *ptr =			\
+		TYPEOF_UNQUAL(*(mdev)->stats) *ptr =			\
 			raw_cpu_ptr((mdev)->stats);			\
 		local_bh_disable();					\
 		u64_stats_update_begin(&ptr->syncp);			\
@@ -45,7 +45,7 @@ struct mpls_dev {
 
 #define MPLS_INC_STATS(mdev, field)					\
 	do {								\
-		__typeof__(*(mdev)->stats) *ptr =			\
+		TYPEOF_UNQUAL(*(mdev)->stats) *ptr =			\
 			raw_cpu_ptr((mdev)->stats);			\
 		local_bh_disable();					\
 		u64_stats_update_begin(&ptr->syncp);			\
-- 
2.42.0


