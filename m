Return-Path: <linux-arch+bounces-5664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E796793E958
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DECD28191C
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D66F073;
	Sun, 28 Jul 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6BjeUdH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204727D3F1
	for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198665; cv=none; b=lImYXyQpbS3X3hk11wCZeMWnz0iSs7uhgfxHl7VNDjQhpSqqzmnPuwd+st7RHBEspihVMgDlUEWlDvRbhrBeJYoRFVkmpPXOO7gbxMMFXyJLoUdNP0VU4HpiFm593fr3DRLsLM97vZ16XL8bRmpgW0OcUejGx/VJJJT5e0rJNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198665; c=relaxed/simple;
	bh=jgG0TSTo1c+hpUBT22yEfSilFpbm6otN2MQr5+RKpfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g30sXWn1DEd/dTuekplUlByvMB8IRjBpJUeJyZ+Srz2dmls2jje1nRqTbcFZzoCl7rUIDTSdoPI9rmu02dVWHDulj9efLZqnBIE1Z6c/O/CMS+8y/+CE0y3SurEGl8XtA2MdqY888SvwBuoFeOW9ql30aBRgEyRVrUHW7G6C6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6BjeUdH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19c63so46795557b3.2
        for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198663; x=1722803463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tokg3sFCTTXy/Tg/kyuYTkBel/otDfHpuf9TI5sSKRc=;
        b=f6BjeUdHR36Kg9BILRErBF2TT4LyUUUeWe/2pIZ5RJ+8bUz3/NbWjd66ppYH8KLMcg
         wybYF/uZjne3GMXh1E+X1zAYra/WCpKEUBjZOVjjzz0/kOx4veBmncDp4c0wvtTsPXg5
         Q7gXKDwUc91Ffz70gcy8siG+Z0Z8BHkr4mNeJMykTEEKau1hFbkhlp/9cmPjSSyWsQTe
         MpRwuxKr7a7JOtgdouDxBAK4YVsVaopo8toXBrxqtqBLzkmJ/gJ/volGOdGKRdngDgrw
         IAbShFBlEXNFgyUQgorAI/NfrnUVubUQo28Ed5qPYkmr/8FVyRU0slQDy9KU844a+4q/
         YX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198663; x=1722803463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tokg3sFCTTXy/Tg/kyuYTkBel/otDfHpuf9TI5sSKRc=;
        b=lXWVqYVjqAhWeOzai2CPysdfaezCYCOsT1FgzmGJUnfTVLB1PLeSMNT+rrYRV+yBkX
         p/qc7YU80kkCagRfu0C/eOBE+BMlpOaBVrEZJVN1XD9257fLiFS6vLvgqQ1SVyEsI4Xz
         SX0zBAGkF2f5zasZyDFPY/KA7c1cXcRnZ1V2ksUqKvhNKQEF9Ht6glXzUdSyuNjxZe8J
         PCugnbgELeuji8FQKcmjOlXO4niVVzc/+tR/aFExqdXwIjU9tKzaad0onz2kMyLZs7Ou
         1Tb47jHSmoAu5wh6IgJohofKXrOiD33KOKRf+z4n6P7rw3rZjV/3GQGVIL7PR5ywbicv
         0wdA==
X-Forwarded-Encrypted: i=1; AJvYcCX7mqO5nFVhBZORZydjxInimCMjnqUfQ4asOLDkm4vqtCsXCC+OsreDig7/zyfypCFSa5P2f7QEAVknVEFrkGzM7fstabXOS7sVZw==
X-Gm-Message-State: AOJu0YzDvPYRsvJ8NFVOrqmpkyRlNFEjbKaMFrFYGT3xL1Dkysnt6ZhS
	E/h7DXc3TIrjZWYbgso0cHYMF5iLDbvE1z0YHrwpw/oNhUkoYW6fLj8TB1nWoftEJQ==
X-Google-Smtp-Source: AGHT+IGFJCBpCGKio3GvIQMtPQU0FwuQLnvFXOWRFKgHtvK/N12utXtZSpDgbRkZ6jpM9dmXhNWYM7k=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:827:b0:667:8a45:d0f9 with SMTP id
 00721157ae682-67a004a2775mr1250767b3.0.1722198663143; Sun, 28 Jul 2024
 13:31:03 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:58 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-6-xur@google.com>
Subject: [PATCH 5/6] AutoFDO: Enable machine function split optimization for AutoFDO
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable the machine function split optimization for AutoFDO in Clang.

Machine function split (MFS) is a pass in the Clang compiler that
splits a function into hot and cold parts. The linker groups all
cold blocks across functions together. This decreases hot code
fragmentation and improves iCache and iTLB utilization.

MFS requires a profile so this is enabled only for the AutoFDO builds.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++++
 scripts/Makefile.autofdo          | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 97c8399e5532..7d9dc8a3c046 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -593,9 +593,14 @@ defined(CONFIG_AUTOFDO_CLANG)
 		__unlikely_text_start = .;				\
 		*(.text.unlikely .text.unlikely.*)			\
 		__unlikely_text_end = .;
+#define TEXT_SPLIT							\
+		__split_text_start = .;					\
+		*(.text.split .text.split.[0-9a-zA-Z_]*)		\
+		__split_text_end = .;
 #else
 #define TEXT_HOT *(.text.hot .text.hot.*)
 #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
+#define TEXT_SPLIT
 #endif
 
 /*
@@ -611,6 +616,7 @@ defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_TEXT							\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
+		TEXT_SPLIT						\
 		TEXT_UNLIKELY						\
 		ALIGN_FUNCTION();					\
 		TEXT_HOT						\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index f765bd9e81d7..80ad06689947 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -6,6 +6,7 @@ CFLAGS_AUTOFDO_CLANG := -fdebug-info-for-profiling -mllvm -enable-fs-discriminat
 
 ifdef CLANG_AUTOFDO_PROFILE
 CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
+CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
 endif
 
 ifdef CONFIG_LTO_CLANG
@@ -14,6 +15,7 @@ ifdef CLANG_AUTOFDO_PROFILE
 KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
 endif
 KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
+KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
 endif
 endif
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


