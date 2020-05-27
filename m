Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F371E1E4441
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbgE0NrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 09:47:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbgE0NrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 May 2020 09:47:23 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlfCk-1jD5sb39N4-00ili0; Wed, 27 May 2020 15:46:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask: guard cpumask_of_node() macro argument
Date:   Wed, 27 May 2020 15:46:08 +0200
Message-Id: <20200527134623.930247-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IPQ9B4qOEDeVAT6zCkUFk/+6gE2JJSw998N7HuX7io/aAOYDheD
 X7YwErGg89se16bhTbTpYxiVy/sw26V0IO/Cfn4vsmDbUr0Mb24lIdcaqoqoY7c4003P+DK
 YHN04TmVug/66eTQdd3ev9jx1nEETULaY0f+ly7FgTxV1G9cqhn9D0+bToxd4kFFn/L3GaI
 +UIcf3wttnFElnuPeAO/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K+yJ/bPAuoE=:EInc6+3xGy+xs6R42Qb+42
 YeCHSr7b/3wnG5P+D8owS3CVbIA16q8f/9rY3+UtseNBx4ByBki8PhZRrxXJoFNxe/QxQYEXP
 JjZbBuCPkTbiGH3Fx1rKtd3sUv8INsHrO1G4diNJqPGQIrFeAPXcljY4WlqZYugGM/m7p4p+h
 6xVSRMRJ7MI8szHGihSUT8KybBiDftBRbeLfdWX4c2XArLyH0j0r+XGkhor/Zztm4uJqJKWEI
 QZjlQ1nDYkmDAc0W4qiqtt7MlrBxmEGscfev2FnmXA0jRY78aRKbbWPJ8FvOx78vNlZyhJ/1h
 2d3sj7z52hGAquNP3Yafpz8oyUgcVpFK0p63kCnv3Izzfp8F+DBeRVX+mJi7jt2NAa8CvtCb+
 yQhp8XUFFjEnTpIr1HtDH9e3VNpyl8gmi1dTwaibVMRcsnqRgYHewjpZi90hWh7BH5AvhJ7vn
 fgD6WTVKRtH9dDNQQLhWag05DDop4Awos1EpLIfqcvMJFk0xGNAn+yy192lRk2LRIqz8sUENc
 mO+7Gs6PcSqTYr20bRM+HqazeUSi+zZTCzMZ4oUKsO1MoOLtiOyWLVVRzVqpr/GLm6G2psafE
 H8bo9D0rQMvkpLc9COWHKcCYSQAunKF6gygRO0tdW3Z8HqitPCEPq+YAiWNSnpLsb1BE6rq4N
 NizITXqEZsm818NveA0i9kdB8vCDAU41M92Pxz4Z1+OX295FjCqN2V8O8nnSNFItNuDhfuKCU
 6uRnOn/hTQIeVl6nj38ZppcZguMuccYIdsuAcyJe0ivCdnRR86m4lCos/KctzdahU+l3rFF9c
 w3r7W1yOkLLU2BdN8fExQuGlAlyXRKhDwA4TOZqHDFfhX/KktU=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

drivers/hwmon/amd_energy.c:195:15: error: invalid operands to binary expression ('void' and 'int')
                                        (channel - data->nr_cpus));
                                        ~~~~~~~~~^~~~~~~~~~~~~~~~~
include/asm-generic/topology.h:51:42: note: expanded from macro 'cpumask_of_node'
    #define cpumask_of_node(node)       ((void)node, cpu_online_mask)
                                               ^~~~
include/linux/cpumask.h:618:72: note: expanded from macro 'cpumask_first_and'
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
                                                                       ^~~~~

Fixes: f0b848ce6fe9 ("cpumask: Introduce cpumask_of_{node,pcibus} to replace {node,pcibus}_to_cpumask")
Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 238873739550..5aa8705df87e 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -48,7 +48,7 @@
   #ifdef CONFIG_NEED_MULTIPLE_NODES
     #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
   #else
-    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
+    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
   #endif
 #endif
 #ifndef pcibus_to_node
-- 
2.26.2

