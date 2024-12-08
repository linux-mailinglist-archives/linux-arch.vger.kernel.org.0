Return-Path: <linux-arch+bounces-9308-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C09E87DE
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC27A1641CC
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263E1990DC;
	Sun,  8 Dec 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBNaegmF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBF197A92;
	Sun,  8 Dec 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690851; cv=none; b=jVwi7bHWsXl6ZQp6JqGsA1CD21MbnN088p/YPt+HyHV6DVIT0gAFLgx3JQydvAFHFqRh6HvGlf1FiS+QptZ+YyYBsv+V0E5603+p0esE+FOmYEjHgKYbbctDMI91g5u1sFi/PBdQTqeH2V3JOzRM4A3HuxJI3KXiXrZ3UANi+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690851; c=relaxed/simple;
	bh=v4+aJNbD9jqPDPBZHZg0flI9bzYjUUxQkdbtOPZJKNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FINXC3SB1xxv125hT+2hXO5710jvPweOJXSaZYDKQ+AsP1fptyvvcQ/E1WSW4tinL+hNNu1WkPycChZx+aWRhIpAEU8Sav1Dj7lUO4R+54Ek0xvLsBCWLMSwwT59Dnyk97I3QNTttDsCwBMWypfbRMX+QCYGJs2CWpRnS0Ox0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBNaegmF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434e84b65e7so14658915e9.3;
        Sun, 08 Dec 2024 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690847; x=1734295647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nHTtV9SwPVM1CI/6H4NJcvMXq5Ty5K6NAFveY7fTlA=;
        b=DBNaegmFaJv7KHERI/SlGvR13hrB+jpBjg9xBMGMiIV54DOR4ccYQtYwjd+kGcQCjr
         0mlPevWJPz5ThJA2V9BEo0f3BC/3uWVoaBmVfhsTR/QE30wP2DbU3LE8KnaqWPuUGkS5
         bwQJgliUZceNSFbPqnv44eSOCPBWR9twxLVCNyr5tCyIzVfv/KabNLqam69MdbqJ10Y+
         iDtSlhy2Tfj6XTIBJ1yvEIoZ0n6ITJce3GHX2nXhbcT74fCLTShQM3lqXsI1SNnyUBXV
         zRYiyXmzxn3d1Gphs7oPnPwpwdKXUk/9SnjDGJLyVq7ZrX6uOSe6JYnwT/Y9QPJTbmWc
         dB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690847; x=1734295647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nHTtV9SwPVM1CI/6H4NJcvMXq5Ty5K6NAFveY7fTlA=;
        b=UgPo0xE1lpnnKGefYvZSHDO5UBmArDJdfV1Z4V+BdKp4MpYXgDL6LUk55TgsWpcBjO
         7wIcXAUTgHK4VTYGDdVyROYHH5/9Y8onnqnC6AHwHgiuA+bd6bLywAmPJJdawGjzHLcB
         5n9JKx+pC4fTOR/AlRvg/mANrpJEoIbEhRI/nh6CDHCw964FzbR5J1npGgZ6Ax3UVdts
         n91vgdZdjv8PRePCrRxG1OmYH4rV+t8Qdj3uDgxs8FpCzDmBcTWV7tGvCc9kixf0PLdk
         0nat+6tDpp5x7OKgrbc6dd8FFsLpdOeaIMdx656v4WTXS46DI54boAaFyX3cJPIvM7+S
         MFcg==
X-Forwarded-Encrypted: i=1; AJvYcCUpalzNOMCE0vO+p+Gn9Hx2RSNgozRz1zTD72gZriyPEYVGVIG0E9bfgZAiAn2JXJEpSl5RHLPX@vger.kernel.org, AJvYcCVOgXkGncuY713qB4RUzSdvJ2v9A1EJ/Qkw67zs8oqjvOmMfog9+Bp4/bh+XZR0nySdf8giadMrxQJd@vger.kernel.org, AJvYcCVeWmY0B5tDbGMf+dyE6R+z+vTi8XN7qbVceO68fsXK9/JZ94G1Xa3mr6K0wxkWFkaKBD2IPD12erHQAv7X@vger.kernel.org, AJvYcCWdokxfiEtGIXLOHbcQBHDc7dHwF/EHrUj64MvfXqafh7az9XiOobnf9kur55DAOGgLFwGnU3SxDZQxMFfx7SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOqqeG1Mqk+Ur4T5PAvqhb7p9GXKhjw8/fuE15QZlIObhEXie
	artVX4IsXNyILbobMGEzI8McwxJDCec9LCm0pKMv3vtLq0hjw2JdE1JfzPRd
X-Gm-Gg: ASbGncsuMnPDKKMGxzseLQzfoFVDYRKrS+qZjAPEfdO42Mb0reKj+orrvehm0+F/+CT
	CPIcS+siQ781hZEWztVBb6Lflq6CaWkHs48GfyMQKO4eqnhCCNr7Hzw/q7V/+bOOPE4fCJNKCWS
	jRJZEqcDKvqNgVYheJ3lKB7nyZ1LZ1YcIJHL2th52xlal42lho8bdKZ0fLw9wTKXVmJ/0OawlBQ
	+42Fd6TUQp9ZDXCviX80Ua/fGMZNIy38aEnpZoqkRzaa2ILstegsAjdiM8=
X-Google-Smtp-Source: AGHT+IGhyfm67iqMr2DgS7OR5+qCYoBMZuU2f4+7la38+rQp8Jepy+V33WnABI+y4R5RoecbjJjnxA==
X-Received: by 2002:a05:6000:471c:b0:385:fac7:89b9 with SMTP id ffacd0b85a97d-3862b3e4483mr7723323f8f.59.1733690847415;
        Sun, 08 Dec 2024 12:47:27 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:26 -0800 (PST)
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
Subject: [PATCH v3 3/6] percpu: Use TYPEOF_UNQUAL() in variable declarations
Date: Sun,  8 Dec 2024 21:45:18 +0100
Message-ID: <20241208204708.3742696-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241208204708.3742696-1-ubizjak@gmail.com>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
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
index fb02c1c36004..415a5803b8f4 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -586,7 +586,7 @@ do {									\
 
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
index 35842d1e3879..266297b21a5d 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -320,7 +320,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
 #define __pcpu_size_call_return(stem, variable)				\
 ({									\
-	typeof(variable) pscr_ret__;					\
+	TYPEOF_UNQUAL(variable) pscr_ret__;				\
 	__verify_pcpu_ptr(&(variable));					\
 	switch(sizeof(variable)) {					\
 	case 1: pscr_ret__ = stem##1(variable); break;			\
@@ -335,7 +335,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
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


