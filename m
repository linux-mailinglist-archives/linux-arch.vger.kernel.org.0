Return-Path: <linux-arch+bounces-239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEA7EFAE7
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 22:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CC1F28B9D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A94F889;
	Fri, 17 Nov 2023 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="czjRIg3v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187A01FD8
	for <linux-arch@vger.kernel.org>; Fri, 17 Nov 2023 13:28:12 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso1371559fac.2
        for <linux-arch@vger.kernel.org>; Fri, 17 Nov 2023 13:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700256491; x=1700861291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Jfb6hOBzZpUnQKwLCoqR3E0xQBxJXpYyz1BMSpxkFw=;
        b=czjRIg3v7lsgfHsW+WWanB2XXXjfFifkb1W/CB1Xun8ObXrzB0WTUbWupN0BG+XbJW
         GffCYvqqYsacP97FRxpUg1RWotohciQ7DsbQp3XQjNBX9XrJMfhvnyB8nNWU+jD5OD9B
         bbRfHZulk6gAnMdCbBXsr7FuAZZiFIUXGUsShv6BNQ+FQER/ZVdFrlbzPNZUcQMwhPCh
         WLiknuiR9m6HJ83MdBed2wVoI2LjZYZFVIu1Yso4CpgBKbnjoynkg7daI04icKBrki5+
         tUOc1X2/C3AteCjg8u64zu6Gtx2JJGhK18aCMTPuduawVtePOakUSuV2E/QWnvLChcWn
         iyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256491; x=1700861291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jfb6hOBzZpUnQKwLCoqR3E0xQBxJXpYyz1BMSpxkFw=;
        b=VF/dmisfKiDYHErqy8uYi/r0Ph0bejFdRqeQdR+gqsKnO2C56O/EW+9UaIuo7Kntaf
         YTwBXKbh1OFWjeFHAZrqOaY7M0j6qzX+2bJs8pPwLGVyNLm7i9GQ8xlHxtSGDU1JXeec
         LHmeba7v7xuC0JZKvF2N4uAcuS/jyPlLcEF5fRyYTg7DBQUyIryXLNcTVf9hIQ6HeYJ4
         NVN3l49wOMHZ9FBPrjf4PFrPycDLHcSHChtk/FBXQjZT9PZD7G5deyWqlynVnfI0wtaw
         JqbXt81ro6E0UpUoXUSX6j3vAMxWMWLRRlY+W68Du+FeXr6BrATbJoBwVDEgUv4AxF5P
         tqtQ==
X-Gm-Message-State: AOJu0YyBh0sKE5Znz31faeqzssttbzFoQojRqb8XvLy/iy/+0g0HDMZA
	MpUfPjqgYj9HLPebSjysLmyLwA==
X-Google-Smtp-Source: AGHT+IHj2Z2pnZ38FwJpnREYBKN+j7xsKbex5lAWS4vYTRD8S4SLoyfV+5pXVCGwm6dxV9XFtThxlg==
X-Received: by 2002:a05:6870:f608:b0:1e9:efa9:1199 with SMTP id ek8-20020a056870f60800b001e9efa91199mr585055oab.4.1700256491304;
        Fri, 17 Nov 2023 13:28:11 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e2-20020a05683013c200b006d3127234d7sm365677otq.8.2023.11.17.13.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:28:10 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 17 Nov 2023 13:28:00 -0800
Subject: [PATCH v11 2/5] riscv: Add static key for misaligned accesses
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-optimize_checksum-v11-2-7d9d954fe361@rivosinc.com>
References: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
In-Reply-To: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3

Support static branches depending on the value of misaligned accesses.
This will be used by a later patch in the series. All cpus must be
considered "fast" for this static branch to be flipped.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  3 +++
 arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index b139796392d0..febd9de4373e 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -7,6 +7,7 @@
 #define _ASM_CPUFEATURE_H
 
 #include <linux/bitmap.h>
+#include <linux/jump_label.h>
 #include <asm/hwcap.h>
 
 /*
@@ -32,4 +33,6 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 int check_unaligned_access(void *unused);
 
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 40bb854fcb96..8935481d32da 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
+#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -665,6 +666,35 @@ static int check_unaligned_access_all_cpus(void)
 
 arch_initcall(check_unaligned_access_all_cpus);
 
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static int set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all cpus will be available.
+	 */
+
+	int cpu;
+	bool fast_misaligned_access_speed = true;
+
+	for_each_online_cpu(cpu) {
+		int this_perf = per_cpu(misaligned_access_speed, cpu);
+
+		if (this_perf != RISCV_HWPROBE_MISALIGNED_FAST) {
+			fast_misaligned_access_speed = false;
+			break;
+		}
+	}
+
+	if (fast_misaligned_access_speed)
+		static_branch_enable(&fast_misaligned_access_speed_key);
+
+	return 0;
+}
+
+arch_initcall_sync(set_unaligned_access_static_branches);
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch

-- 
2.34.1


