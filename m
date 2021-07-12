Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5005A3C41C8
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 05:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhGLD3G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jul 2021 23:29:06 -0400
Received: from mail-mw2nam12on2112.outbound.protection.outlook.com ([40.107.244.112]:5176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233049AbhGLD3F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Jul 2021 23:29:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8lhKvrNFiSpyboVI1OFPAth/iuHJeTtj5xck7jAJrVorEKEyAWUhmzqnE0u+g9e8yFkLQzI2wpbktu47CTa/cCyPN3wTVIaUc3VS+Cqg5TXZ5dXMP6Iz73LonN8JBwoFXjgVWCplhRocts3w7CgMf2b3tTL4Q8Mk5QIShvYg7d+Zed+FsO+dVTzXq64J11pwnyYX8UlwbDBioRBStDQp5ZaDlWOz5ws3V264xyGVIdxc4yTbvAvjvhlG5oKnYws80IKHAZ6Q03H4Ah5pHeNEpfC4FpLAhb+iQ5AGeYl1MvB/hwTWBN4HvSBPxVRG0gg7/npJYY6UzoXOzx+gbAtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7JfKTsFTaFanDzTy39o+CycA0t2W9jaP2C7xb1Bd6I=;
 b=BmKEusMRuoj560lDcZtJtzOUZqA5m5xqSq+2I8UKhAzQxPCrUsazFPwbvny6S6kDUoS5DAS74B8ypjK2F7GHwPcQGtf6x6MA7zYrANyuWa9oxXn5uSN3OjrkuljxdnJaeh5gZ3HIJcSLEH/ed7yu7SlLdOSNb1ndHY/lL2NIZ0CKDYuJvF2xWYICbblN+GgdL2GFGQwTrqNZgs2oFx14tc9Q03IKWiRmrl1k+mzbOPsJ0sM3yU9a8F0cbg4HW5lVzZWxwHymIasIi+5ft4iCovlx6Sz/FMSV+BQs/CwibF8TX4VqfmV9Vl44de/jHZl+e8Cjp3frvTvDDuvjD2RNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7JfKTsFTaFanDzTy39o+CycA0t2W9jaP2C7xb1Bd6I=;
 b=AqEc0/LDJ/piEWXBuEYNq819y+uvYokHx7k0WVQEN34sf3odHYiknC5codb/ViXs2NJqbDqC4LXE5572jAkdm/6hReYCzEA5wksaiOs/hYaldkknz5ASPID484FP/YqIHl/nX+imozaIyAgH4ID59pCE3ntTL22GxnOXGEhb1qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1402.namprd21.prod.outlook.com (2603:10b6:5:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.8; Mon, 12 Jul
 2021 03:26:14 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%7]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 03:26:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 2/3] Drivers: hv: Add arch independent default functions for some Hyper-V handlers
Date:   Sun, 11 Jul 2021 20:25:15 -0700
Message-Id: <1626060316-2398-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.16) by MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Mon, 12 Jul 2021 03:26:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffd7ea5f-2253-4868-0441-08d944e4cd8b
X-MS-TrafficTypeDiagnostic: DM6PR21MB1402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1402ECE1670D9B57ED45CCB2D7159@DM6PR21MB1402.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk+rgn58NHs0heug4U+d54E0vLFWM5Yu4vSNpmqaYU4qpvNaEze27G4+03iYKKtY9UFNlFM8AjqvIHeP1FwdkPkD8gJSM+M9sdPKZFGu7IA/Tt7ZDdPLVHvjo42V7utRla1JcneLIYUb8QaqeVdhPnrbZW1664X/DAImNO2ckQUO8bA3dSnrYo1JEvZUM07H01UpU649BMwq4R/WIAH1mk0V4ixZTCHC/QrZkeWMUjhLUp7wsSkzMX0wNSLBOXMlLVZSbhe43iP0s3APhTUiz/me6M1+jrgwFeXGrlElGbEJZp6v8QxK514d5kyJvCc1UY1jnfU4qmQ7Dv0+F4PTEBN04BDKAbd6WE4iCU18UtKc7SFbL0JuBkIVjHDA8LaLTtsnWhssXqB/oHoT1kzk9YvImwlHDoFPUttBfVBeYd9ewTFWLeq818H57t8DjBYlXCXOHNebkIKCIWGeg3won2GdhGXPFJULzPbqjyRh6m9j5uxNM10FNj6MP7UYQoIXUj+GMx+C4n8Fo89/bAmuAjOoUa8+yuUi5ufM2FsUxx66/h4znV1ThZmWdiKb1Ksa4hKW6HrETeIT/9LepB0bOmdGfMwpAvUDYMxlMLTLSAh85x7H6kh7jQZpnSyAUbPVKg7aOdG++VN9oARj3OeX6XijTRxUKWD+CqiXaypqLllXj6ig+DuNC+ZGsZgjv0igKQC1EKUqLHmGWjPQDmadQUYY7yxtS0ffyus2I3PjBt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(8936002)(7696005)(66946007)(2616005)(316002)(186003)(38100700002)(26005)(36756003)(38350700002)(83380400001)(478600001)(52116002)(8676002)(86362001)(7416002)(6486002)(66556008)(4326008)(82960400001)(82950400001)(921005)(5660300002)(66476007)(2906002)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVmrOGfIkVhpSKQ6eRa9pex6hA/uD3dY1kUZdWQejA3M7dqFrGCb3hvQY+jD?=
 =?us-ascii?Q?3rmLR1b+nZr+1yJNfDQnrH4Qh4F+Lpxm+yj4kcyzGNWNBBmWUnkDKkJwiUfH?=
 =?us-ascii?Q?3SyetsKVjzJkovAAfx49UZOHNFIm3yaD5whd28KYsIwmxw3UYMyicqGGn2R2?=
 =?us-ascii?Q?9nibVjrNNuzWYqGptdCd2JuOteeYSmwVDiVB+IW6tyo8HqTqz+edeUckNwyW?=
 =?us-ascii?Q?ZvBfTdLy0QpjUsxNVu3aeoi63ofu6hH+YwvbzWJUVf7xm4EmuE2pgrhSSCo6?=
 =?us-ascii?Q?q/AZHBtDcq6yrukMIfOyXiWJDHlt4gDEV2lMW/5Kr3rzz6GpgmSXhVVRJfgD?=
 =?us-ascii?Q?O+hf2ir95khMq4E1OENIjix3gvWEeqsFJeSHxig3Gl3MjKx6CLPIIq4D8wkQ?=
 =?us-ascii?Q?BXC6Zt3+vfTaicyxOjZfYlw+l+dwKnrw9fYLlLofMfDW9tUsH08LjOIt34Be?=
 =?us-ascii?Q?TtN8Q3uSctd7exJYfDhKuMbeIPQCk4fKTTiY7ng8fZutf+eJ11dIU0tVKzot?=
 =?us-ascii?Q?K284ljOfraa/DytPvVbWTcR9lOXk2CHoZ/jnFOST5YKuZ0axfqhHT8GBmq79?=
 =?us-ascii?Q?ghXQ2i3tgu6VHY8HcJxQpH5OhYLwpQanbB1uiQoic70Em4slnrBnbrhciQOh?=
 =?us-ascii?Q?hE3eqFCfxLqGQNUfL18Cs78rsadwnW/vexpzvbC2nc2aFLFm01EkAKQXy/N4?=
 =?us-ascii?Q?NA4MmylkM+x7QC2M+5h08vqgu9tXHf+XmqMWaAtSkLAEbKwNjM6heyz0hMrr?=
 =?us-ascii?Q?IJAEQUBb3tm7Wc0a3ZJ+qEnp+iYyY1Kfb8uCVy3mkH/IG8DuTVzvoF1nR5dm?=
 =?us-ascii?Q?C7Xhwpv8tIbDY3Ny7+WJvS4EjznX6H67MnjyDzSGmFN6qyscTyPT67gR5cZX?=
 =?us-ascii?Q?hO6L5Nm4U2Sc1gkgL1Rli0LuZMeR7r5SJQaXsoZ5yDuKNu7vyxxuNLtCf9oJ?=
 =?us-ascii?Q?FH6bj2Mib0oQC5bJSwXMDEnjDEfCPBNDNBz3rgnm5Fh0LhKwpkLatbaYhS4F?=
 =?us-ascii?Q?wcxtGWYxMTJGJk0t5lQHD1mXddYlDdrzejw+NyPXCA1Nw1vXBBkyI//OiTQ3?=
 =?us-ascii?Q?QsteMjv3WPZ/30tWQBiWaVZix+rFaAW0MuWEn9M7ds62C8KaHczz0fDjS5PV?=
 =?us-ascii?Q?6iwCTZL+aoHwnqj2iLFIsr3rJv6s29IO9epCrYCyuO7U/yOpBU2T9CLe09fT?=
 =?us-ascii?Q?1owajofnDRWEielkqn9Q8LcsyPo6syCn9bQsuLCHKwrpCLOtAMp0SU7gpBqY?=
 =?us-ascii?Q?ghNsyEYdbrj9qU5J/IUAKV500HzyfgonY2wowQr2X4C7mmyfy8qrgyWVy9kM?=
 =?us-ascii?Q?/QltRkWV6NPpJDInfhjOuSsr?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd7ea5f-2253-4868-0441-08d944e4cd8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 03:26:14.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wmnqkjAn8TodulpFAL2g/6cXo3s7vaoYHaScJuuo7ZM2uBqoWw3+tp/Chxpw1x9ZEMLEoyDMF6N2QEn3znfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1402
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architecture independent Hyper-V code calls various arch-specific handlers
when needed.  To aid in supporting multiple architectures, provide weak
defaults that can be overridden by arch-specific implementations where
appropriate.  But when arch-specific overrides aren't needed or haven't
been implemented yet for a particular architecture, these stubs reduce
the amount of clutter under arch/.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      |  2 --
 arch/x86/kernel/cpu/mshyperv.c |  6 ------
 drivers/hv/hv_common.c         | 49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 5cc0c0f..e87a029 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -468,7 +468,6 @@ void hyperv_cleanup(void)
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_REFERENCE_TSC, hypercall_msr.as_uint64);
 }
-EXPORT_SYMBOL_GPL(hyperv_cleanup);
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 {
@@ -542,4 +541,3 @@ bool hv_is_isolation_supported(void)
 {
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
-EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9bcf417..3e5a3f5 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -58,14 +58,12 @@ void hv_setup_vmbus_handler(void (*handler)(void))
 {
 	vmbus_handler = handler;
 }
-EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
 
 void hv_remove_vmbus_handler(void)
 {
 	/* We have no way to deallocate the interrupt gate */
 	vmbus_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
 
 /*
  * Routines to do per-architecture handling of stimer0
@@ -100,25 +98,21 @@ void hv_setup_kexec_handler(void (*handler)(void))
 {
 	hv_kexec_handler = handler;
 }
-EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
 
 void hv_remove_kexec_handler(void)
 {
 	hv_kexec_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
 
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
 {
 	hv_crash_handler = handler;
 }
-EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
 
 void hv_remove_crash_handler(void)
 {
 	hv_crash_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
 
 #ifdef CONFIG_KEXEC_CORE
 static void hv_machine_shutdown(void)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9305850..c429306 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
+#include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -195,3 +196,51 @@ bool hv_query_ext_cap(u64 cap_query)
 	return hv_extended_cap & cap_query;
 }
 EXPORT_SYMBOL_GPL(hv_query_ext_cap);
+
+/* These __weak functions provide default "no-op" behavior and
+ * may be overridden by architecture specific versions. Architectures
+ * for which the default "no-op" behavior is sufficient can leave
+ * them unimplemented and not be cluttered with a bunch of stub
+ * functions in arch-specific code.
+ */
+
+bool __weak hv_is_isolation_supported(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
+
+void __weak hv_setup_vmbus_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
+
+void __weak hv_remove_vmbus_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
+
+void __weak hv_setup_kexec_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void __weak hv_remove_kexec_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void __weak hv_remove_crash_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
+
+void __weak hyperv_cleanup(void)
+{
+}
+EXPORT_SYMBOL_GPL(hyperv_cleanup);
-- 
1.8.3.1

