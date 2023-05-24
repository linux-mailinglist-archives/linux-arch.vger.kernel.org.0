Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAD70FB0C
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjEXP7c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbjEXP66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:58:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C6198;
        Wed, 24 May 2023 08:58:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRG5q0XJJz4x4r;
        Thu, 25 May 2023 01:57:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684943823;
        bh=lhmpLwDQH5cebjnmbxXQDXCrrkxM6lArc4COr8B16+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hN9lRcU83wfB6glwdAcQY3uPnaACkF/PWSdI5fYu18ajT4j4SfDdi3UgTHTj/C+Ek
         PSdYNMyK2oxhQytwrwRzG2iPk0QfN+PqfYjR5QaqySj0vkb5SnKOEP6mLh3GyTUxpb
         ndQ6DT0x2iFNbZeCgTrobrTiwDAQhGsiqUNPXwjaszKiLGzQVd0cuVtYySi6d371oO
         yG1jiVNC1et0H63ijBzW+nOOoYscG+RQYRkgqIRyCIzhqLMOepRKlNNr1HcU6Tb83/
         hU6/xrQu2TBUuL6VC8wI66+M/n8AUmvxAktM6+soPnEtEVtU1berwOZrMP2Il4sLnc
         l1BEpf2K3Sttw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linux-kernel@vger.kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
        <ldufour@linux.ibm.com>, <tglx@linutronix.de>, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, x86@kernel.org
Subject: [PATCH 9/9] powerpc/pseries: Honour current SMT state when DLPAR onlining CPUs
Date:   Thu, 25 May 2023 01:56:30 +1000
Message-Id: <20230524155630.794584-9-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155630.794584-1-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Integrate with the generic SMT support, so that when a CPU is DLPAR
onlined it is brought up with the correct SMT mode.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 61fb7cb00880..e62835a12d73 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -398,6 +398,14 @@ static int dlpar_online_cpu(struct device_node *dn)
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
+
+			if (!topology_is_primary_thread(cpu)) {
+				if (cpu_smt_control != CPU_SMT_ENABLED)
+					break;
+				if (!topology_smt_thread_allowed(cpu))
+					break;
+			}
+
 			cpu_maps_update_done();
 			find_and_update_cpu_nid(cpu);
 			rc = device_online(get_cpu_device(cpu));
-- 
2.40.1

