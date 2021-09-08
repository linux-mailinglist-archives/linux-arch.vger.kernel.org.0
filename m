Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE6403FF5
	for <lists+linux-arch@lfdr.de>; Wed,  8 Sep 2021 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbhIHTn6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Sep 2021 15:43:58 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44783 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350940AbhIHTn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2021 15:43:57 -0400
Received: by mail-wr1-f43.google.com with SMTP id d6so4884183wrc.11;
        Wed, 08 Sep 2021 12:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/XJiQEpE7jUl93U2dRCaSlCXjM0mPRU2w5BruXuWoQ=;
        b=YtJ92oK2oDs9H1n7mmTDFP+FYX0UFxOBff9JIiBu5N/fqZIzlhGPRd1yRhIeHK7MqQ
         5YPqxWRUhh7Unm5l8VVJPzp/XKB0aCFimLnUhkI9TulIOQuoIWC9Dtnevp2rCTP/iOvN
         Ct774JFyMJ/Cj3Kle1M54pM/hQewCQqb5PtCUA+MeDrp9XQd3xpfiCRYOI2QKeVwxwyZ
         +ABF0Dl55o0UuMoXkXgb7Qy567Qo1MyLpUDfcflKK4Wbtu89FC2Kla+lymkrMed3IzRP
         sA7mbvgLj0xu9bCfiL+vkDGOf5jn7YwCebco1TQvMOj6qS/4PegYgIsFON4kocebao4H
         xiWQ==
X-Gm-Message-State: AOAM532L1LG7wP6GlP3k3TMx4calipaiSPNWWVuCzDD1/9vLpsZoAvKs
        2FCZgtBPHMAaFHi9P2q5mk5dt/e543I=
X-Google-Smtp-Source: ABdhPJwlMltNpc6b0yJAy9xdierOJ6ZhV9PRvErMzW25L/1jVWDW9jj2Ew8TTsMnXLk/cozjiJjF8A==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr5906273wrf.405.1631130167626;
        Wed, 08 Sep 2021 12:42:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p5sm72852wrd.25.2021.09.08.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:42:46 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] asm-generic/hyperv: provide cpumask_to_vpset_noself
Date:   Wed,  8 Sep 2021 19:42:42 +0000
Message-Id: <20210908194243.238523-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908194243.238523-1-wei.liu@kernel.org>
References: <20210908194243.238523-1-wei.liu@kernel.org>
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
---
 include/asm-generic/mshyperv.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9a000ba2bb75..d89690ee95aa 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -184,10 +184,12 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
-static inline int cpumask_to_vpset(struct hv_vpset *vpset,
-				    const struct cpumask *cpus)
+static inline int cpumask_to_vpset_ex(struct hv_vpset *vpset,
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
@@ -219,6 +223,18 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	return nr_bank;
 }
 
+static inline int cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	return cpumask_to_vpset_ex(vpset, cpus, false);
+}
+
+static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	return cpumask_to_vpset_ex(vpset, cpus, true);
+}
+
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.30.2

