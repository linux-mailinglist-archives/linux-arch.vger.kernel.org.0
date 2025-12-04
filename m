Return-Path: <linux-arch+bounces-15175-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2249CCA5414
	for <lists+linux-arch@lfdr.de>; Thu, 04 Dec 2025 21:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649713198A8D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Dec 2025 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431C23563C3;
	Thu,  4 Dec 2025 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="UTGHsWHy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CD354AF6
	for <linux-arch@vger.kernel.org>; Thu,  4 Dec 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878692; cv=none; b=lK+r6p7C2tIsMrnVf0tFlF5NL7eYgAPSYNG0T/5lmkGhMnDnhMrxNzfmW4kPklJSIA26+1sk0JsPa7DwX+BHAiogxkwwtMmg3NOMRcM3UeuN5iCbViPvk1c0/c8LT0SckUpW9CUTBdy7RvQVtl143E9bzDdXvtrLtlr2JR+ugnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878692; c=relaxed/simple;
	bh=x3JVG0Npt7Vp6FJ7VZ184tzfxWj7zfRDDLEdRgBiASw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRsrM+H2S+ysJpkKl5Qi0lXN/+eRzLCE7jIH/PgTv3NvTtKgPM8ovT6s62/cYfrRPJJ6Bk6lcNAGrtuGndPmJm19OlJMiDOIce3R84diQkXUmu9EeM6sqIY2HqIcTL1I/CZXAjdgHT6Y8FPXJjCD0r3WEPZAaCuz5DF4WiT7XOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=UTGHsWHy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso954495a12.2
        for <linux-arch@vger.kernel.org>; Thu, 04 Dec 2025 12:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878687; x=1765483487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbIk5cCPbojOJ9uTDKoU4N3fqpVL6wCeA1bHhTiYoys=;
        b=UTGHsWHyV7lfri+pK4CSDfSbxVboTdHxN2N7tbXC8JwqmzJkgGxf7HV0m/MdmZ88ST
         uzJ4Z3dcQ1gkTfrpzfuzBHSQEyBl1+ZvDUDWaNGQG/zjv9pg2AvrFShZnI0FwcvFK9NO
         D8XqyPAfHwI2XeelBVtuhG92Ugo9Dj+JMfYGLOvniw2bFDasbf1B8sOw8elzsue5x4qp
         rTJ3Z0mepgnpGLPbGXdEbpIITkQ1tuznOGN+Z+Yc/wNb++pHUaP2QCews5mXczM0ZVvb
         bgHx6iLR1/gzKnfbtk9U/Ia3S6OMknYkY5SMiYQvmMBsVZ6A5bjCROVnBtQ1CwOwIRto
         wKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878687; x=1765483487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FbIk5cCPbojOJ9uTDKoU4N3fqpVL6wCeA1bHhTiYoys=;
        b=USS9kcky8ZqJLSNds3v8eJTdC5IJ3EB/fx+U3Fu3zM0h26edWeU/H6isjBgQ8SlIJ1
         uKOtTyTIe5ln95k0Ip/m2i0WakujP2GDttqu3qjLyAOahkpi4bYS4+YqKOfpMknjp4I2
         k6dFXswemoTuh9vWDgGARgEsfkVJpv9uk1jF+EAOs+/FKXIiGOz92e1J0UhAwH6cF5P/
         a9wXZJhKWS57YHydqTkr0Cu2X4ohJyGRPtbBRyFM8G/pJmkn3wepk+5pijF0lCgDIskh
         B0pm9UquEvGL67wVJVe+/QTjExj3nwTbUgFBRDJ4STpdGp64VlPN/LTU9wtWCUXHyOuP
         lvMg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhVLdNt18qYL3jY0bBNLAFvzTqf6RaKyNGZ3OgbfEUTgptkRLDg5hNVhh++30cC4Klw1w/HF/nl/J@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxc6jtUck9kWs9wg0zpY4qDY8n+vMDfG+q6Lk0eFmunY89uUV
	th8EiKGILEWdO5tJJma6UueNZ7olnZI5Z2KhA+XTmtzeHIyF098xbVdcSYmSwBB0WQM=
X-Gm-Gg: ASbGncusDw3eSqCVYaug4YzqhKVIwgjTMpHufM8tIy5qAlvrZIYCogHsFgOO8aIyU/E
	aP5KdpugJ4DFiZSNWr2804L/EHSsmpQUOCWBPjKSkjc+v25S8E4KQJWzic9rYtEi35CSmAR5Ui3
	MPmiv5J1Z2UGr9XgejEaUHeiPN/tGTug7hR4nGUexibLgZ7oVxrmSXGcjM97OjJ2+eTMeH7HTBG
	MutAKsfxUuahQafCzIVeXU43xMCWxGPfmdr8aUzC+oEqkLQ7GNXGOQrPkKIlyjCK2IB9VZRMM3+
	RTdBi9lSNJqh0uYPfpiPvw/4tn5n8BYviWb7MNs+wTJD2YhYobFCB62APuaRuEWGUO5DZZK/5Tz
	xjcWLsPsvbX657MyATGIVjPZFhkengprM9fMC7ZWIYMOnx1Gd2UgnC98sEI3uRu3S78iBwJ9FJ6
	snVVyeVdBCJd8JQ7PeBZJ5IzHuNNHsCps=
X-Google-Smtp-Source: AGHT+IEYq2NhHAW/lDvZOWPbRN9iBsKrQsBn17EmuFgRKKV+z6xhb59z1fl5AF7naBMnBmq1xnzwZg==
X-Received: by 2002:a05:7022:f906:b0:11b:2138:4758 with SMTP id a92af1059eb24-11df6470f70mr2302683c88.21.1764878687001;
        Thu, 04 Dec 2025 12:04:47 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:46 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:13 -0800
Subject: [PATCH v24 24/28] arch/riscv: dual vdso creation logic and select
 vdso based on hw
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-24-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Charles Mirabile <cmirabil@redhat.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=9634;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=x3JVG0Npt7Vp6FJ7VZ184tzfxWj7zfRDDLEdRgBiASw=;
 b=hNDMxr6g7wq/6YK67qIU5YDefsqo0/CndfmaMjIkdcARGSO7wQS9z31kxKAEl1gdVcj/OTsGi
 tWtGseRoKgfAkUcoYAl/JN76M9DNbG1WxsIm5dgpbLOPSHjJLe+KMkJ
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Shadow stack instructions are taken from zimop (mandated on RVA23).
Any hardware prior to RVA23 profile will fault on shadow stack instruction.
Any userspace with shadow stack instruction in it will fault on such
hardware. Thus such userspace can't be brought onto such a hardware.

It's not known how userspace will respond to such binary fragmentation.
However in order to keep kernel portable across such different hardware,
`arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
compile `arch/riscv/kernel/vdso` sources with cfi flags and then changes
in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
on whether underlying hardware(cpu) implements zimop extension. Offset
of vdso symbols will change due to having two different vdso binaries,
there is added logic to include new generated vdso offset header and
dynamically select offset (like for rt_sigreturn).

Acked-by: Charles Mirabile <cmirabil@redhat.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Makefile                        |  3 +++
 arch/riscv/include/asm/vdso.h              | 13 ++++++++++++-
 arch/riscv/kernel/Makefile                 |  1 +
 arch/riscv/kernel/vdso.c                   |  7 +++++++
 arch/riscv/kernel/vdso/Makefile            | 29 ++++++++++++++++++++---------
 arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  4 +++-
 arch/riscv/kernel/vdso_cfi/Makefile        | 25 +++++++++++++++++++++++++
 arch/riscv/kernel/vdso_cfi/vdso-cfi.S      | 11 +++++++++++
 8 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index f60c2de0ca08..b74b63da16a7 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -176,6 +176,8 @@ ifeq ($(CONFIG_MMU),y)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_RISCV_USER_CFI),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso_cfi include/generated/vdso-cfi-offsets.h)
 	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
 		$(build)=arch/riscv/kernel/compat_vdso include/generated/compat_vdso-offsets.h)
 
@@ -183,6 +185,7 @@ endif
 endif
 
 vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
+vdso-install-$(CONFIG_RISCV_USER_CFI)	+= arch/riscv/kernel/vdso_cfi/vdso-cfi.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
 
 BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index f80357fe24d1..35bf830a5576 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -18,9 +18,19 @@
 
 #ifndef __ASSEMBLER__
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_RISCV_USER_CFI
+#include <generated/vdso-cfi-offsets.h>
+#endif
 
+#ifdef CONFIG_RISCV_USER_CFI
 #define VDSO_SYMBOL(base, name)							\
-	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
+	  (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP) ?			\
+	  (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
+	  (void __user *)((unsigned long)(base) + __vdso_##name##_offset))
+#else
+#define VDSO_SYMBOL(base, name)							\
+	  ((void __user *)((unsigned long)(base) + __vdso_##name##_offset))
+#endif
 
 #ifdef CONFIG_COMPAT
 #include <generated/compat_vdso-offsets.h>
@@ -33,6 +43,7 @@ extern char compat_vdso_start[], compat_vdso_end[];
 #endif /* CONFIG_COMPAT */
 
 extern char vdso_start[], vdso_end[];
+extern char vdso_cfi_start[], vdso_cfi_end[];
 
 #endif /* !__ASSEMBLER__ */
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 2d0e0dcedbd3..9026400cba10 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -72,6 +72,7 @@ obj-y	+= vendor_extensions/
 obj-y	+= probes/
 obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
+obj-$(CONFIG_RISCV_USER_CFI) += vdso_cfi/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 3a8e038b10a2..43f70198ac3c 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -98,6 +98,13 @@ static struct __vdso_info compat_vdso_info __ro_after_init = {
 
 static int __init vdso_init(void)
 {
+	/* Hart implements zimop, expose cfi compiled vdso */
+	if (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) {
+		vdso_info.vdso_code_start = vdso_cfi_start;
+		vdso_info.vdso_code_end = vdso_cfi_end;
+	}
+
 	__vdso_init(&vdso_info);
 #ifdef CONFIG_COMPAT
 	__vdso_init(&compat_vdso_info);
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 272f1d837a80..a842dc034571 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -20,6 +20,10 @@ endif
 ifdef VDSO_CFI_BUILD
 CFI_MARCH = _zicfilp_zicfiss
 CFI_FULL = -fcf-protection=full
+CFI_SUFFIX = -cfi
+OFFSET_SUFFIX = _cfi
+ccflags-y += -DVDSO_CFI=1
+asflags-y += -DVDSO_CFI=1
 endif
 
 # Files to link into the vdso
@@ -48,13 +52,20 @@ endif
 CFLAGS_hwprobe.o += -fPIC
 
 # Build rules
-targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
+vdso_offsets := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),)-offsets.h
+vdso_o := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
+vdso_so := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so
+vdso_so_dbg := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so.dbg
+vdso_lds := vdso.lds
+
+targets := $(obj-vdso) $(vdso_so) $(vdso_so_dbg) $(vdso_lds)
+
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-obj-y += vdso.o
-CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+obj-y += vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
+CPPFLAGS_$(vdso_lds) += -P -C -U$(ARCH)
 ifneq ($(filter vgettimeofday, $(vdso-syms)),)
-CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
+CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
 endif
 
 # Disable -pg to prevent insert call site
@@ -63,12 +74,12 @@ CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 
 # Force dependency
-$(obj)/vdso.o: $(obj)/vdso.so
+$(obj)/$(vdso_o): $(obj)/$(vdso_so)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
 	$(call if_changed,vdsold_and_check)
-LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
+LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
 	--build-id=sha1 --eh-frame-hdr
 
 # strip rule for the .so file
@@ -79,9 +90,9 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Generate VDSO offsets using helper script
 gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
-	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) $(OFFSET_SUFFIX) | LC_ALL=C sort > $@
 
-include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
 	$(call if_changed,vdsosym)
 
 # actual build commands
diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
index c2e5613f3495..bd5d5afaaa14 100755
--- a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
+++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
@@ -2,4 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 LC_ALL=C
-sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
+SUFFIX=${1:-""}
+sed -n -e \
+'s/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2'$SUFFIX'_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/vdso_cfi/Makefile b/arch/riscv/kernel/vdso_cfi/Makefile
new file mode 100644
index 000000000000..8ebd190782b0
--- /dev/null
+++ b/arch/riscv/kernel/vdso_cfi/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# RISC-V VDSO CFI Makefile
+# This Makefile builds the VDSO with CFI support when CONFIG_RISCV_USER_CFI is enabled
+
+# setting VDSO_CFI_BUILD triggers build for vdso differently
+VDSO_CFI_BUILD := 1
+
+# Set the source directory to the main vdso directory
+src := $(srctree)/arch/riscv/kernel/vdso
+
+# Copy all .S and .c files from vdso directory to vdso_cfi object build directory
+vdso_c_sources := $(wildcard $(src)/*.c)
+vdso_S_sources := $(wildcard $(src)/*.S)
+vdso_c_objects := $(addprefix $(obj)/, $(notdir $(vdso_c_sources)))
+vdso_S_objects := $(addprefix $(obj)/, $(notdir $(vdso_S_sources)))
+
+$(vdso_S_objects): $(obj)/%.S: $(src)/%.S
+	$(Q)cp $< $@
+
+$(vdso_c_objects): $(obj)/%.c: $(src)/%.c
+	$(Q)cp $< $@
+
+# Include the main VDSO Makefile which contains all the build rules and sources
+# The VDSO_CFI_BUILD variable will be passed to it to enable CFI compilation
+include $(src)/Makefile
diff --git a/arch/riscv/kernel/vdso_cfi/vdso-cfi.S b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
new file mode 100644
index 000000000000..d426f6accb35
--- /dev/null
+++ b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2025 Rivos, Inc
+ */
+
+#define	vdso_start	vdso_cfi_start
+#define	vdso_end	vdso_cfi_end
+
+#define __VDSO_PATH "arch/riscv/kernel/vdso_cfi/vdso-cfi.so"
+
+#include "../vdso/vdso.S"

-- 
2.45.0


