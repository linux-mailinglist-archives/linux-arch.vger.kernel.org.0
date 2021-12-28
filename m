Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30474805E2
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 04:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhL1DdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 22:33:06 -0500
Received: from mail-centralusazon11021015.outbound.protection.outlook.com ([52.101.62.15]:54485
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234715AbhL1DdF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 22:33:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMft7cvFeEGrW4Lj55OR4Kb2WceKiXME/W+omUh/8cKh4wRmF9u4yRtRK0oIZaqY3cX6mmE2LDYsS6iYu8Igh0EWDEizRminsm6m5YByNg1pK+spaREe2jacU6hU0+hLAQbkDHMe1J0gMdap41z34+rHI5RbcF8auEA2M9w+p9MrE2Ihq2RF0MURKAYG660e421jtBjUFFv2vofvvQ5yAtbTa3bo/JQAmO6OhQ2EITN1+oZkIXiQH1Y0RDI/qnif/ZCpANLZ9tjMHSY+jn8fic5gGMxZye3SbTVepglXhhVSSGCJrvO6iTauLfmAoGCoBPAm1jc65Q/rfgihdU0dBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqqbI4GcI6TC1MzwgiDGpGcXNoYXn0Wcos26jiCyinE=;
 b=b3KW/KVbCeGBTnyApyAGWqV+HOPkWQIEZcIxkMWksg1lPN7ysMAI39Gy9j04ReSyNLxpPcMRFYZkOoCYERnbVL1T6XfikwxPGWwxP4WLuSFcGFrN9ZZPyHcDPW81Rgqi+zE6RVcrP3+kVBXDLzcd4TobNBfQ7xUXZbBO1PqOfIIrwYS9lFqwIi/ea18+MfJNxZj7IjWUHfLbSMoObRE5bvDSb3eYRhyMwxu6I3/ZlmDW8JQ7A8KDBvOQgE7f7m+k7XsVvDNPtvEKGgP/Hj9tSynftKGQw4S9PztC47scMdxpv1SK0ufJ38KB7kKSNNWRkmg8HkmqtT1VbOeEeMYJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqqbI4GcI6TC1MzwgiDGpGcXNoYXn0Wcos26jiCyinE=;
 b=YYq1F7L5LU7BH2E0bzGxTJ/thx3aQLEJ1Zz+NPnhD8jZJUaB+tini1kZR2bdoUAz9E6leazfLs/rzrM7FNws4E+iJ6KRpYBRZv4gNJZZZqdYsPdMpoARJVfO0ONdw7qwyWCNnx+VyGQYWpGKo2/r7Jez/O0WQy+JZuj+V/8SzH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by MWHPR21MB0477.namprd21.prod.outlook.com (2603:10b6:300:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.3; Tue, 28 Dec
 2021 03:32:54 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::4c2:54c4:85bc:dd62]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::4c2:54c4:85bc:dd62%6]) with mapi id 15.20.4867.003; Tue, 28 Dec 2021
 03:32:54 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, tianyu.lan@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 1/2] Drivers: hv: Fix definition of hypercall input & output arg variables
Date:   Mon, 27 Dec 2021 19:31:54 -0800
Message-Id: <1640662315-22260-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:303:b4::31) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5994a4c1-b818-4ea1-e870-08d9c9b2bbfa
X-MS-TrafficTypeDiagnostic: MWHPR21MB0477:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MWHPR21MB0477A82054B44DF9CFCA80D7D7439@MWHPR21MB0477.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZDNbg2iHoy801j1dqBe8PrJDxEDosjfdvFs/IYVDw6wqqhWbRBalXPnr6wLUKkWTQsEnD40NUrRreg7FsZhkeEIGLnzxLBB8Ln8clfmAM39gLDtZdHsxCn8vcRuy6SlXY8ipAzd7HYakhYgB2g8PcaI8CawLg0oTErnLn7LpAySsLUWq9L3iBavrBmSKCeamge++aYCJW1+S7V5sKiNylYd9uL+9OagSrsRYItJpIEEQT2EmjqM4MLXn/lM72oRrbXa1CsHQ9D/wZfKqptHt1Hm9ANIVH5CL0Bq9C2DRHO3Z9eAdV8emN7T1pZDcffnY1ZN+ltQv9AKpmq6QB6kMgrkmMSZZPP+CPH1U8m7EZOITlfyqRn+pDKFsZSnffnr/ygeYakbw0OyVoJO53DfXdvMCv7A4vocJ3b6DlPT14IMZbmYpKdo99V1pAGmbzOF1GAG5MRD4DmisX3p+tphP7ixpTerU9VLj1MfnOu3LSwWFoHFC3s6G8f8NtlDiFHyyPAjaZSH6weSYHRpwfoKoIaJQsmQfOGm9WKARqRb3rJdSePdwEPx8EzBBbrSW6GjCA1S2AT6x0E4Q1Yi1TmfcztB5j6bgv6a+AAhq9Rk5xrqnOdP5+z99HmEsI+7dZ1AdKgd1029Gnedw+Jj4Lo6ioywShfExgwVz5uzZqbGuLr3HtUP+TFs2yMF+sFuew8PxTb3NV4a9QohpyM1QSlWJTm4FUSKkzrcoe+rwZCbcTGJsdmIVqs84eo6ZKrmlwSyDJsogzxO67FB19cZYSAbGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(66946007)(921005)(52116002)(6486002)(82950400001)(82960400001)(86362001)(316002)(36756003)(2906002)(38100700002)(6506007)(38350700002)(66476007)(66556008)(5660300002)(2616005)(4326008)(7416002)(508600001)(8936002)(10290500003)(83380400001)(8676002)(26005)(186003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbpZsxqLxGyTYyX8MS2apDl7ieMWTpohFXYgkI/DAkPMh1yCh722ZEQmyeUw?=
 =?us-ascii?Q?/Tx8mtskookqQfM8Zj1bEUj4Gx4cGwvOhKm1qWLdbalR3yyxVPBr1efOHAPB?=
 =?us-ascii?Q?Qyzb3a+uIzDRgvbC1Hllbu0N53a3sbzfsdu1+ZdsVPy0/jeLPOKtc23Jz0uZ?=
 =?us-ascii?Q?R0z8XLK7CN8PAITY6kjImdwTkTBehEGo4D61FzFyfmcKks7jeqlUlnxSuxkL?=
 =?us-ascii?Q?TI9AdbT4e664Iy7WM74Zn9e2S34kmS/SUM9aQpU/qceDlV05388Rq+TZnGz+?=
 =?us-ascii?Q?E5drIl3c7N6MuK5FzY3bu3RtNrWbxrtLXV36DZ9BivPUpGIJjXqgEftoGHzS?=
 =?us-ascii?Q?LMNkwuvwh7IsILlfUzq4exjdohtfCSwwPDBfbGtTIeVKkhMTvMWKPVZq1SFG?=
 =?us-ascii?Q?I9S2LTHNfK44Y7V3VJ/PGekeD+AglrolQk13Zgl74KhkbiXh5OYf8IBqainw?=
 =?us-ascii?Q?zHXu2bndse4tAuoZd4WDnBQOt28U8Btw3g4ma2d28CYpgldRUYF8r6L/EpGV?=
 =?us-ascii?Q?gEnuxGUlknMFsze77HDyGfOLgvzEf2C0An+gOh3dx9ncwTkOMx5pZzXCBAx4?=
 =?us-ascii?Q?vx3T7aU0GyGrBRUlLjIOu2p+rbaCSF0kDOGmtA/thlk2eMY6U15SKa97y0Vy?=
 =?us-ascii?Q?HrFUYYFW3DcvLin3MRfjQzUXkEVXmogDzU9BYf4ibPBzHxdF/TrzFQvreyht?=
 =?us-ascii?Q?uBVYGuQk2tKsUM0ohaIhzoikQMeek0AAgawfw+c773gFFxkBX8TZ/dIFhHNE?=
 =?us-ascii?Q?jebRCWCZn63y27kGP7fU0WpUj4fiJc/OTXqIkLm1lXYJk7BH7BVwuJBWFV3V?=
 =?us-ascii?Q?yPmkhMEvmfBq945TE+0kDYsDC8oBR1dIUqOvi+zGYo/OAXtkv9h5mhQiaTa4?=
 =?us-ascii?Q?5qpLPD/0+suIOJinMDNAw2iWALr0wYpcJR1LtXOOj4VBp8OkmmqTiWsPnvAV?=
 =?us-ascii?Q?mY5BxFYbv/JgewNTk6RShIj6FUK3Pl5VAITKCWljk8oEkHQpYaJyNWiswovm?=
 =?us-ascii?Q?2GtKPtfQB4WIvdicaaT2QHQ1nimILE2iwOgG8gGzrc34VGvrTF0dxvIgKlIs?=
 =?us-ascii?Q?+Czf5MjX8aih7rK7bUWrTEe8djMuuLAbDJYpFV3VQ9yzqKgKI6NHLSFmgbNA?=
 =?us-ascii?Q?b0j5w52bexWNOJSAf45eYMrAbqnSf6C9tMQ3yQ+tnh6TdGLS9yMsVZutQkTG?=
 =?us-ascii?Q?m8UwibHS6Acw7mjHWohxoLsyXnae5d/jS8R0nMj2+Y4N5rA4adB3B1w/OT33?=
 =?us-ascii?Q?31cKYk80lrkCzQ+34CEUFBQ0jsOwmX8XF6bhA+OwLp9dJ/BIBbTErrlvFjZM?=
 =?us-ascii?Q?i45osSwx9m6yYIoSrvWMURKqYeZzWu9Njw35VbdSermCH1rzuCD4w70XYAH7?=
 =?us-ascii?Q?iec0LiyA7qCxoMAiokfRVJmiUuJQCjG1/NnRKMzlNekvwO9rHh1KAZEEwFAR?=
 =?us-ascii?Q?q0k+AR7P4UrD1Kd2+576+StBqYaGh0A5PuVNjKNeriI9BYMUUgh/KwKWuKEY?=
 =?us-ascii?Q?+VscMddrZJdpritmkrmKwzqISxFzvA6tYeYqnVkgW65QQxs+wlf8Ex+Rqy2y?=
 =?us-ascii?Q?ftzFVfxwm3ZRTrC9+d2A3iDh3NwWFXN/9ebGDIv07vGjLmRGUf1SjBJYS40l?=
 =?us-ascii?Q?Et2AXOv7psXAay9DNUMybZA=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5994a4c1-b818-4ea1-e870-08d9c9b2bbfa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 03:32:54.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I/2WwnWPGR4x+wU7OLe0tW1xf35c7S87AkvVhgHN/oM7LZN5qk9TWSqUtg5sZTQFYvr9PgV1SW2hwvdYTSkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0477
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The percpu variables hyperv_pcpu_input_arg and hyperv_pcpu_output_arg
have been incorrectly defined since their inception.  The __percpu
qualifier should be associated with the void * (i.e., a pointer), not
with the target of the pointer. This distinction makes no difference
to gcc and the generated code, but sparse correctly complains.  Fix
the definitions in the interest of general correctness in addition
to making sparse happy.

No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/hv_common.c         | 4 ++--
 include/asm-generic/mshyperv.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 7be173a..7477e5a 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -44,10 +44,10 @@
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
-void  __percpu **hyperv_pcpu_input_arg;
+void * __percpu *hyperv_pcpu_input_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 
-void  __percpu **hyperv_pcpu_output_arg;
+void * __percpu *hyperv_pcpu_output_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
 /*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 3e2248ac..95b7888 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -49,8 +49,8 @@ struct ms_hyperv_info {
 };
 extern struct ms_hyperv_info ms_hyperv;
 
-extern void  __percpu  **hyperv_pcpu_input_arg;
-extern void  __percpu  **hyperv_pcpu_output_arg;
+extern void * __percpu *hyperv_pcpu_input_arg;
+extern void * __percpu *hyperv_pcpu_output_arg;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
-- 
1.8.3.1

