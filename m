Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5A172F30
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 04:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgB1DLX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 22:11:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38838 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgB1DLX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 22:11:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id a16so335892pju.3;
        Thu, 27 Feb 2020 19:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NEaCPmHcMTUExH0eMnT6okYoT7G10RBGyN+Jnq9dgA=;
        b=Ut7K4++s2I8f9S2Q/YL/qgP9r4dM0byVRCayMuJM0fZ2l73LKesbNns+xZDCQ0+l88
         P+x9mlL78cFv3aVT2dAbKa+Sa0slZsJqaHrDTjPGVXACghsXx/cdY8FF+dMhJNVOK2rS
         LoSFSeeIHGD7GRrFIUSt1XPos60yXTGWgmoO7ltRLyOn+Dp627jMz5MkL1szvPLdwXbC
         zk8kzqhv2DpoLEu/lNQpY0BW0/sQAU0jmibp4oJMGv7dl6bwWDPSbg7926Zi7qlOkIyM
         mbOshJ9jcI32HkT6R70rB4/Nvf1rs+4cVQf3WM353SnhHnP/sg+POZHhLWI/+w464KOR
         sHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NEaCPmHcMTUExH0eMnT6okYoT7G10RBGyN+Jnq9dgA=;
        b=c46d3M9z2kPQltA66vyVf1ki9uOf8fwKv+nLdIC/xQ2pmZoEKfqQqthJkU/rSntjNV
         lmLBe8K2DyHVb5zJjSxQT/k1i6hK8MXUqNYVFndj7L+CybDKYyNdxL7jSC4ipy9R0nas
         BZsLoftBYPibDACbXj1Pg2rOqrX+JEGniLrCH8pq2UaoJldgwKg3gNzuC8sX5iOI9hkp
         sThK076Y+BWB2G8ld9YL7aMyHO3eTwLLY13ndY3R8PYO3FsylFZtGA9mzGOFVOpu1kiz
         Wt+fPdGxi6TOkf768o4IH3FnZvGu1NmMZGGMaX1w3wVIPrm+yfW/oN0W+5SV7ZRcOFew
         wQXQ==
X-Gm-Message-State: APjAAAWGyZJ1a5XFPvfinBsaryz3qW5EEHCHXsOcSLEyXGVffTkAggpH
        RAtrGjywNKyA+eidhTV1GT8=
X-Google-Smtp-Source: APXvYqyIv73dxuwUnK3HVno066YT3MUYfEekaSRzb1LyR0YOdUJwKly1UCe/z5x6/C68NNQk4ttvgg==
X-Received: by 2002:a17:902:b488:: with SMTP id y8mr1904248plr.206.1582859482226;
        Thu, 27 Feb 2020 19:11:22 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-109-34.tpgi.com.au. [193.116.109.34])
        by smtp.gmail.com with ESMTPSA id a17sm8132185pgv.11.2020.02.27.19.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:11:21 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, skiboot@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/2] powerpc/powernv: Wire up OPAL address lookups
Date:   Fri, 28 Feb 2020 13:10:27 +1000
Message-Id: <20200228031027.271510-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200228031027.271510-1-npiggin@gmail.com>
References: <20200228031027.271510-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use ARCH_HAS_ADDRESS_LOOKUP to look up the opal symbol table. This
allows crashes and xmon debugging to print firmware symbols.

  Oops: System Reset, sig: 6 [#1]
  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc2-dirty #903
  NIP:  0000000030020434 LR: 000000003000378c CTR: 0000000030020414
  REGS: c0000000fffc3d70 TRAP: 0100   Not tainted  (5.6.0-rc2-dirty)
  MSR:  9000000002101002 <SF,HV,VEC,ME,RI>  CR: 28022284  XER: 20040000
  CFAR: 0000000030003788 IRQMASK: 3
  GPR00: 000000003000378c 0000000031c13c90 0000000030136200 c0000000012cfa10
  GPR04: c0000000012cfa10 0000000000000010 0000000000000000 0000000031c10060
  GPR08: c0000000012cfaaf 0000000030003640 0000000000000000 0000000000000001
  GPR12: 00000000300e0000 c000000001490000 0000000000000000 c00000000139c588
  GPR16: 0000000031c10000 c00000000125a900 0000000000000000 c0000000012076a8
  GPR20: c0000000012a3950 0000000000000001 0000000031c10060 c0000000012cfaaf
  GPR24: 0000000000000019 0000000030003640 0000000000000000 0000000000000000
  GPR28: 0000000000000010 c0000000012cfa10 0000000000000000 0000000000000000
  NIP [0000000030020434] .dummy_console_write_buffer_space+0x20/0x64 [OPAL]
  LR [000000003000378c] opal_entry+0x14c/0x17c [OPAL]

This won't unwind the firmware stack (or its Linux caller) properly if
firmware and kernel endians don't match, but that problem could be solved
in powerpc's unwinder.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/include/asm/opal-api.h        |  6 +++-
 arch/powerpc/include/asm/opal.h            |  3 ++
 arch/powerpc/platforms/powernv/opal-call.c |  2 ++
 arch/powerpc/platforms/powernv/opal.c      | 40 ++++++++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..4d32b02d35e8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -115,6 +115,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_HAS_ADDRESS_LOOKUP		if PPC_POWERNV
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index c1f25a760eb1..c3a2a797177a 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -214,7 +214,11 @@
 #define OPAL_SECVAR_GET				176
 #define OPAL_SECVAR_GET_NEXT			177
 #define OPAL_SECVAR_ENQUEUE_UPDATE		178
-#define OPAL_LAST				178
+#define OPAL_PHB_SET_OPTION			179
+#define OPAL_PHB_GET_OPTION			180
+#define OPAL_GET_SYMBOL				181
+#define OPAL_LOOKUP_SYMBOL			182
+#define OPAL_LAST				182
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9986ac34b8e2..ef2d9273f06f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -312,6 +312,9 @@ s64 opal_mpipl_query_tag(enum opal_mpipl_tags tag, u64 *addr);
 s64 opal_signal_system_reset(s32 cpu);
 s64 opal_quiesce(u64 shutdown_type, s32 cpu);
 
+int64_t opal_get_symbol(uint64_t addr, __be64 *symaddr, __be64 *symsize, char *namebuf, uint64_t buflen);
+int64_t opal_lookup_symbol(const char *name, __be64 *symaddr, __be64 *symsize);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 5cd0f52d258f..ba11112d94df 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -293,3 +293,5 @@ OPAL_CALL(opal_mpipl_query_tag,			OPAL_MPIPL_QUERY_TAG);
 OPAL_CALL(opal_secvar_get,			OPAL_SECVAR_GET);
 OPAL_CALL(opal_secvar_get_next,			OPAL_SECVAR_GET_NEXT);
 OPAL_CALL(opal_secvar_enqueue_update,		OPAL_SECVAR_ENQUEUE_UPDATE);
+OPAL_CALL(opal_get_symbol,			OPAL_GET_SYMBOL);
+OPAL_CALL(opal_lookup_symbol,			OPAL_LOOKUP_SYMBOL);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd..fdf6c4e6f7f9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -107,6 +107,46 @@ void opal_configure_cores(void)
 		cur_cpu_spec->cpu_restore();
 }
 
+const char *arch_address_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, char *namebuf)
+{
+	__be64 symaddr;
+	__be64 symsize;
+
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return NULL;
+
+	if (opal_get_symbol(addr, &symaddr, &symsize, namebuf,
+			cpu_to_be64(KSYM_NAME_LEN)) != OPAL_SUCCESS)
+		return NULL;
+
+	*symbolsize = be64_to_cpu(symsize);
+	*offset = addr - be64_to_cpu(symaddr);
+	*modname = "OPAL";
+
+	return namebuf;
+}
+
+unsigned long arch_address_lookup_name(const char *name)
+{
+	__be64 addr;
+	__be64 size;
+
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return 0;
+
+	/* opal: prefix allows lookup of symbols that clash with kernel */
+	if (!strncasecmp(name, "opal:", strlen("opal:")))
+		name += strlen("opal:");
+
+	if (opal_lookup_symbol(name, &addr, &size) != OPAL_SUCCESS)
+		return 0;
+
+	return be64_to_cpu(addr);
+}
+
 int __init early_init_dt_scan_opal(unsigned long node,
 				   const char *uname, int depth, void *data)
 {
-- 
2.23.0

