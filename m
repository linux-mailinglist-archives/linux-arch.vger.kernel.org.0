Return-Path: <linux-arch+bounces-15003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E79C78624
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DD04ECA19
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5D34BA31;
	Fri, 21 Nov 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+rpZ0JX"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99A34C9B5
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719287; cv=none; b=gudKSuln6T7SN0p1K369AfjFGAxJwFKBgb5Pji8BCCDbv4D3//tck7KQUZuMzM53YqV4DRaiY9ADp5gUECmEF4FutDC8yeaMuhpeUjDFajA6vuwpRKSZ9iIBbGNl3YtxDohT7tbOT9lMjbcXf6ZtUfaAx9KM3BHs7wft/qfYYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719287; c=relaxed/simple;
	bh=LwRvAVOz9x5OyrTMiSJMSn0BAArGSPDSf4fZXbrtPLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOkvwLe4ZV12F5jzVYCN17F3+7pBRp1OjL0AOk+6FkKu4A5WuWoaMP0bH3nEdDMDHUCoF2jhZREAuHLFgpfb1vS93Jd3sMKUJyqxrW6xbdv2Rs/5xP1S7OKWcurzJBIR7aqJ60Dend89PhQvOsHMzqsRYQCh03QLB/bGuIF/IvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+rpZ0JX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMUi3E5xQLGsvjrDLEu0jzTaGSgSK7r1Aug1eykzjqQ=;
	b=A+rpZ0JXawufHljGYTn9ZxDGK6NW/mOm3qJVvStM+OYtvHfwLALvh48P1ELsZZjUMKNpPf
	v7cFbS7LNR2OGqA9dQARsOHnFtjAfC/HEM8ojb6+VavsFgG3Mo9+r//oUp33g/EgZSVROm
	Uz8/4zs7H2K419Ju1jiHQ8k1pjmmiMQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-E0g8jvFNPGGdApUQwvZkvA-1; Fri,
 21 Nov 2025 05:01:20 -0500
X-MC-Unique: E0g8jvFNPGGdApUQwvZkvA-1
X-Mimecast-MFC-AGG-ID: E0g8jvFNPGGdApUQwvZkvA_1763719279
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49BCF180034D;
	Fri, 21 Nov 2025 10:01:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA87A1955F67;
	Fri, 21 Nov 2025 10:01:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 6/9] uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 21 Nov 2025 11:00:41 +0100
Message-ID: <20251121100044.282684-7-thuth@redhat.com>
In-Reply-To: <20251121100044.282684-1-thuth@redhat.com>
References: <20251121100044.282684-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/dev-tools/checkuapi.rst              | 2 +-
 include/uapi/asm-generic/int-l64.h                 | 4 ++--
 include/uapi/asm-generic/int-ll64.h                | 4 ++--
 include/uapi/asm-generic/signal-defs.h             | 2 +-
 include/uapi/asm-generic/signal.h                  | 4 ++--
 include/uapi/linux/a.out.h                         | 4 ++--
 include/uapi/linux/const.h                         | 4 ++--
 include/uapi/linux/edd.h                           | 4 ++--
 include/uapi/linux/hdlc/ioctl.h                    | 4 ++--
 include/uapi/linux/sched.h                         | 2 +-
 include/uapi/linux/types.h                         | 4 ++--
 tools/include/uapi/linux/const.h                   | 4 ++--
 tools/perf/trace/beauty/include/uapi/linux/sched.h | 2 +-
 13 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/dev-tools/checkuapi.rst b/Documentation/dev-tools/checkuapi.rst
index 9072f21b50b0c..3c9a3a58c24da 100644
--- a/Documentation/dev-tools/checkuapi.rst
+++ b/Documentation/dev-tools/checkuapi.rst
@@ -273,7 +273,7 @@ Consider this change::
     -typedef unsigned __bitwise __poll_t;
     +typedef unsigned short __bitwise __poll_t;
 
-     #endif /*  __ASSEMBLY__ */
+     #endif /*  __ASSEMBLER__ */
      #endif /* _UAPI_LINUX_TYPES_H */
     EOF
 
diff --git a/include/uapi/asm-generic/int-l64.h b/include/uapi/asm-generic/int-l64.h
index ed8bcd99c34d7..f840806bbe7e9 100644
--- a/include/uapi/asm-generic/int-l64.h
+++ b/include/uapi/asm-generic/int-l64.h
@@ -11,7 +11,7 @@
 
 #include <asm/bitsperlong.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
  * header files exported to user space
@@ -29,7 +29,7 @@ typedef unsigned int __u32;
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_GENERIC_INT_L64_H */
diff --git a/include/uapi/asm-generic/int-ll64.h b/include/uapi/asm-generic/int-ll64.h
index 1ed06964257c3..4fc3e882bcff9 100644
--- a/include/uapi/asm-generic/int-ll64.h
+++ b/include/uapi/asm-generic/int-ll64.h
@@ -11,7 +11,7 @@
 
 #include <asm/bitsperlong.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
  * header files exported to user space
@@ -34,7 +34,7 @@ typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_GENERIC_INT_LL64_H */
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 7572f2f46ee89..4073143fa3dae 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -78,7 +78,7 @@
 #define SIG_SETMASK        2	/* for setting the signal mask */
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef void __signalfn_t(int);
 typedef __signalfn_t __user *__sighandler_t;
 
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 0eb69dc8e5722..6b089d4b2965b 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -57,7 +57,7 @@
 #define SIGSTKSZ	8192
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef struct {
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
@@ -88,6 +88,6 @@ typedef struct sigaltstack {
 	__kernel_size_t ss_size;
 } stack_t;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI__ASM_GENERIC_SIGNAL_H */
diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
index 5fafde3798e57..cbcc37674e64c 100644
--- a/include/uapi/linux/a.out.h
+++ b/include/uapi/linux/a.out.h
@@ -10,7 +10,7 @@
 
 #endif /* __STRUCT_EXEC_OVERRIDE__ */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* these go in the N_MACHTYPE field */
 enum machine_type {
@@ -247,5 +247,5 @@ struct relocation_info
 };
 #endif /* no N_RELOCATION_INFO_DECLARED.  */
 
-#endif /*__ASSEMBLY__ */
+#endif /*__ASSEMBLER__ */
 #endif /* _UAPI__A_OUT_GNU_H__ */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index b8f629ef135f3..42c89884b6be1 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing asm support
  *
diff --git a/include/uapi/linux/edd.h b/include/uapi/linux/edd.h
index 0fe3e02aec653..566f206964862 100644
--- a/include/uapi/linux/edd.h
+++ b/include/uapi/linux/edd.h
@@ -53,7 +53,7 @@
 #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at EDD_MBR_SIG_BUF
 				     in boot_params - treat this as 1 byte  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
 #define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
@@ -187,6 +187,6 @@ struct edd {
 	unsigned char edd_info_nr;
 };
 
-#endif				/*!__ASSEMBLY__ */
+#endif				/*!__ASSEMBLER__ */
 
 #endif /* _UAPI_LINUX_EDD_H */
diff --git a/include/uapi/linux/hdlc/ioctl.h b/include/uapi/linux/hdlc/ioctl.h
index b06341acab5ec..0905383d72aa5 100644
--- a/include/uapi/linux/hdlc/ioctl.h
+++ b/include/uapi/linux/hdlc/ioctl.h
@@ -35,7 +35,7 @@
 #define LMI_CCITT		3 /* ITU-T Annex A */
 #define LMI_CISCO		4 /* The "original" LMI, aka Gang of Four */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef struct {
 	unsigned int clock_rate; /* bits per second */
@@ -90,5 +90,5 @@ typedef struct {
 
 /* PPP doesn't need any info now - supply length = 0 to ioctl */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __HDLC_IOCTL_H__ */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc76a40..30f0c11959011 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -43,7 +43,7 @@
  */
 #define CLONE_NEWTIME	0x00000080	/* New time namespace */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * struct clone_args - arguments for the clone3 syscall
  * @flags:        Flags for the new process as listed above.
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 48b933938877d..00743f894e7e3 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -4,7 +4,7 @@
 
 #include <asm/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef	__KERNEL__
 #ifndef __EXPORTED_HEADERS__
 #warning "Attempt to use kernel headers from user space, see https://kernelnewbies.org/KernelHeaders"
@@ -59,5 +59,5 @@ typedef __u32 __bitwise __wsum;
 
 typedef unsigned __bitwise __poll_t;
 
-#endif /*  __ASSEMBLY__ */
+#endif /*  __ASSEMBLER__ */
 #endif /* _UAPI_LINUX_TYPES_H */
diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
index b8f629ef135f3..42c89884b6be1 100644
--- a/tools/include/uapi/linux/const.h
+++ b/tools/include/uapi/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing asm support
  *
diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
index 359a14cc76a40..30f0c11959011 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
@@ -43,7 +43,7 @@
  */
 #define CLONE_NEWTIME	0x00000080	/* New time namespace */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * struct clone_args - arguments for the clone3 syscall
  * @flags:        Flags for the new process as listed above.
-- 
2.51.1


