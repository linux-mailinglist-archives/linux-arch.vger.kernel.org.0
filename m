Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933742503C4
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgHXQup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:50:45 -0400
Received: from mail-dm6nam12on2118.outbound.protection.outlook.com ([40.107.243.118]:61408
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbgHXQtX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCxo/bzpKT91/2jx3+/kQkOPSWfMyWtJaV+/ZapYJ3pp4Hdlr/k1HyVe78j3O0szABfyb4Wrz+lFZlhO/OIcbgUCw5FYNIJLpJw6oqyyuxW8M/mm2jsCRoQi5X3Fie5wo+W8Hy74jZUJ8invYYhzX2XA0lGF2y+20kNpYv/ZEPCFlHB1ja9nJgSNDQqZH2/TyF+5QFsZLWwVtA/3Lrw/jh54x6hvbRnd4VgORMd/zKsXu+86NDRa+bWZyWqIAHrmJNzTJFT3Jr/bnObxeDvGjSseFM+qKb22MRiD8jIlcBAu0JspTPKaQUJUcEI4slBd5VlTBkv+ZwrRcYXlfUGv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tbvHCr+PAkwKsxjK8X5LwxiM17npNhS/8Ql+bo2GO4=;
 b=OMnulliczjm7xTWzVOnSz5MvvTgwJK8HEtYuHLAZvSsHC0Q7tgy1fbnSyZeudbLMkqrX7v+MCk9+hq6NpAbsh7edmPV2zAPT6RpolZYrong+IHVppoa0i4AxQF/yVHHicj/YE8DncNgZeHnN53+XGLFhHaYS6xmMpw8cPezagsQwIxYOZEvX5Qw5yGufcX1FaQbQu41GuvdzuqzVLUFRL4v9wxUVJ4u3aotKe6sQ+kr2GEnnGcjVMTP1W31lLnm1AeaMcbH7xtULVLI0FTrfzJvAvdSgacnxYL5ShMw7H4cZxr80em2VekjVhP6bN2K7WsLDfNNGYgMdD2x28MQrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tbvHCr+PAkwKsxjK8X5LwxiM17npNhS/8Ql+bo2GO4=;
 b=KxgBBWRBFAebvyidGNz7DUXoGHByx7PXRiM2slgp/anB9ojMW4bMIYT1PIvdlIOO3DeYsggaTxWH8c7KR0ISmQOu9r483StcUieYpAfK2vXOKkQyNfZV0yO0MN1rxy6PK4J+gVHBbcALZky7rkNsYCbElGSSh2ei/gggm1ssmVQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:48:03 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:48:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 08/10] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Date:   Mon, 24 Aug 2020 09:46:21 -0700
Message-Id: <1598287583-71762-9-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:55 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e14e6266-aa11-41b3-ec99-08d8484d73e2
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB07533BDAAD9AB848FED8D705D7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOjspxDxFRdsXNAyPUaaVwIdLAEE/ETylCxtVn/iK8JfijR8B5u4O2cNMuzGoOTt8r469W3FtUMJ+elgM5+/PnccG2wQhNISmDKWqc/YebbKrMIRKd8yFo7/j5TFAQ/YPQjE22kCljOtHWznO32tBRUtScEohoc2q3bBqMj7TgxUVO4W7iU/h9Pr1wt1Xvsef6WOpNancEQGZVeXSgW8fSGDPNsVsARPZTJF63+42WD44EVlNPncFRZBSQhmIbsQqxO5RlMz8n+OPMVYQcCmUTRgy/9XZvN9InsCo+hcWUyfhiUtjyEzMViNPYqfTWurPqoLzBbve6D26bnNaDDtJBZt888PLHsDWXAmHINBSnazhM80GOH9qO/7jZ7TgJQq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6cgaDNz1sdQaU+LQYgB6hSBciD/nXCPQIUHlV7RIMsi75+/wvTsCC2QAJTPOVWkfs4i8aM9Ad09cgJ+supsDkR6PR9rFiVjUDDlPU+TqVdeoQVmTCqCk/NSiOkkZa21IRs6hrq7njrQ82g/tKO0+AvAWatnp0+Ebiti78w8kxFc+dvuWRMFp4QL32O+PpD7YI0olDmkjsS1IDCN0BFIjVdjJ1zXD5R+RRyPNzaNIFtk39fj6P1RBgQNGoJgyHtmxnVnr+oE1ithzhZ5yx2c7r+uXUxlBAdGpHXzfchk/mo/re2scgo+AbeLiQqzNd9hpc1egfE9jJo6RbMxqM1diEVhgDb93BY4pqu7CjmTsc6ceE5Sl4FGa7wlwWANvguvkHpREJIUNYz85GZzS/q+o5H5diM4ft+f1FBbnE4kGS0eM/JZutIb9VAVfB6P6d4JxHyTh31bT2CSjDOEfH0tNwhxE2e/iLKOML01bw+N9No01jEEpGOaSN/45IuOy2WEXOyAPGoWG7NuqJtxqreoF9rc9oMxjxv7Sc81MmckobtOdXxhl230dABqFEDJTu/gwaPAqs1oCB9l2gsVD5c/9XZnn9HhWygO+0hy+jbK8L3gQCqq0HYLGrC4o3HURG3KwHD3z2OOvCGMzlqAB0CgfYw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14e6266-aa11-41b3-ec99-08d8484d73e2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:57.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7eQKxiWmlDdNZ348lZpCFOXXLma/0PIvjEa0yMqskPwf5Ew6lCb+FhNGEcW5rdIblB5ZvZsgzBnh0a2qXb7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
x86/x64 implementation is null because VMbus interrupts on x86/x64
don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ffc2899..dd1365c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -56,6 +56,10 @@ typedef int (*hyperv_fill_flush_list_func)(
 #define hv_get_raw_timer() rdtsc_ordered()
 #define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
 
+/* On x86/x64, there isn't a real IRQ to be enabled/disable */
+static inline void hv_enable_vmbus_irq(void) {}
+static inline void hv_disable_vmbus_irq(void) {}
+
 /*
  * Reference to pv_ops must be inline so objtool
  * detection of noinstr violations can work correctly.
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 2bd44fd..7499079 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -178,6 +178,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.vector = hv_get_vector();
@@ -235,6 +236,8 @@ void hv_synic_disable_regs(unsigned int cpu)
 	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
+
+	hv_disable_vmbus_irq();
 }
 
 int hv_synic_cleanup(unsigned int cpu)
-- 
1.8.3.1

