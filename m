Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF00A407186
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJS6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 14:58:32 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:41843 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJS6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Sep 2021 14:58:30 -0400
Received: by mail-wm1-f42.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so2054518wmq.0;
        Fri, 10 Sep 2021 11:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmF22FF10VEqJ3XXc0rOTEglVQ69MnGfxCNpGugVz3s=;
        b=VBiXpmS2PSdLU6yvYPVGgk3tgFjMBMYwlgT1IG/ogJymSwQUM/HVC9do7FwIIiBX/f
         8PjW4kD09eAgaDbdIQ5yIbOTAVr9vemIHtKo26pHVBQRqp9B4jTjDXQMPMxgOqnYt/9+
         MaSqW80ZHAlb6kSwhoNaRaRrgxewBp0+IysHMqIdhvlU06JcgSvxW7F1nF732y4sNO7g
         Nc1VLyOXOlliarpwtb+3BB8pJwTO56xznBAtjGEEhkpZgAnX1E7wPxTRcyYfPRaLOWgk
         3hAu0X64Z5OXy9+j52HiS8MlNUwJPbCfgulLeMTkLbKSCcUD03EXldCLjv4GNCPyOYWT
         Trpw==
X-Gm-Message-State: AOAM532TFbWa6HHvssJm8B6zq3NOwhRWKZx1O0Fsd9pSbxYWosT+iVWa
        4OptTHw7PZoNBkC+wAlkogVXeJt7i+Y=
X-Google-Smtp-Source: ABdhPJxMwIAPUIIgtWQ2PROYOhh89ZLAVG4KkM8B3daRv6H5KRh9ZkgUJfNiDVG5Hk+ZqqYT+7asfQ==
X-Received: by 2002:a05:600c:22ca:: with SMTP id 10mr9753190wmg.170.1631300238170;
        Fri, 10 Sep 2021 11:57:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y4sm5015351wmi.22.2021.09.10.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:57:17 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] asm-generic/hyperv: provide cpumask_to_vpset_noself
Date:   Fri, 10 Sep 2021 18:57:13 +0000
Message-Id: <20210910185714.299411-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910185714.299411-1-wei.liu@kernel.org>
References: <20210910185714.299411-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a new variant which removes `self' cpu from the vpset. It will
be used in Hyper-V enlightened IPI code.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Provide a new variant instead of adding a new parameter because it makes
it easier to backport -- we don't need to fix the users of
cpumask_to_vpset.

v2:
1. Rename function
2. Add preemptible check
---
 include/asm-generic/mshyperv.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9a000ba2bb75..9a134806f1d5 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -184,10 +184,12 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
-static inline int cpumask_to_vpset(struct hv_vpset *vpset,
-				    const struct cpumask *cpus)
+static inline int __cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus,
+				    bool exclude_self)
 {
 	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
+	int this_cpu = smp_processor_id();
 
 	/* valid_bank_mask can represent up to 64 banks */
 	if (hv_max_vp_index / 64 >= 64)
@@ -205,6 +207,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	 * Some banks may end up being empty but this is acceptable.
 	 */
 	for_each_cpu(cpu, cpus) {
+		if (exclude_self && cpu == this_cpu)
+			continue;
 		vcpu = hv_cpu_number_to_vp_number(cpu);
 		if (vcpu == VP_INVAL)
 			return -1;
@@ -219,6 +223,19 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	return nr_bank;
 }
 
+static inline int cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	return __cpumask_to_vpset(vpset, cpus, false);
+}
+
+static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	WARN_ON_ONCE(preemptible());
+	return __cpumask_to_vpset(vpset, cpus, true);
+}
+
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.30.2

