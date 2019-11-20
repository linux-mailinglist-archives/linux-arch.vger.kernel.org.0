Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34EB1034ED
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 08:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKTHQh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 02:16:37 -0500
Received: from mail-eopbgr730131.outbound.protection.outlook.com ([40.107.73.131]:10208
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfKTHQh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:16:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqAMX/mF6cX/kUVSsbpCMhrq/dfOj33gBwhh/RF+ZhjFhx8I1fWc2TNHpsJXfbDH4zSo8+nwRFe4LlZn9CiJH70HMW1kfM5TB4+F8GpXV1UfwypPMZe1gkJnrzq566Cz3mSvDTj7cwcS9ICpinCiCpYhrt8vIzduPbAhpeo9WFqZjwZIx/Csgwija3BjgJzHsVaBZnOTZt7MHZmY0qTx/KPGy4pg7s8/xSHD+G0yGo7gUExESc6rXvDPP4fdIPmmR/BKTd+FqD6mnS0SxIz0rZn+2xOrV6yyEpSsusWaCZmZosmiPDms0+cwwns9NcdFoN0zvnQGP6hp0j2sfUPcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJZ067rFQHOBXnZjm8pYtPc2kOl6YR+fhnbB2Q46OoI=;
 b=HbPcM13zIazVbX1DpoyOrWpyfaaMBQY1aD89Bs/TPXtZB6dt5IYqquKroIWzONg6oJAdt8sF5JYyVK4nacnbANVsu08GwUtFCduTXstxviiAUQJNzpjl5rQRZtVVgHQWZ+UJuflhl8kAZPxF9+nvFK91Z2ZaFuHJ8y76ynncuQboQVaeoB868yETALQNhnBff0/TXP14RTGqAtqDyGnkycGdLIwY2xaAdqeLVPgvshXg52MuZNP/IFw48OkYhR405aWfhmNOSTcYBVwrNChvzxsMgDkI8VZxAftrymlF7O4uo2jeQqOBV0Px8btnBRV0Dt7DG1RwLZOXIwdDBheDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJZ067rFQHOBXnZjm8pYtPc2kOl6YR+fhnbB2Q46OoI=;
 b=LEfu2N2nsnr5jPrPE13FXKbXOJnqrK5CIN29p9y0kMXzlO0p6PTn/XAfh9uJBTwoGmWjVh3F7zgHfOFLw6tA7yq+TdwovzjAvOvBuhZdZtZip3K8zvkDTYKQUXCFcMqf8ELIoeEbHA2C9sc7rm3jTeTEX7g6KT26smfnODjiIug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:16:34 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:16:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        david@redhat.com, arnd@arndb.de, bp@alien8.de,
        daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com,
        vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 0/2] Implement hv_is_hibernation_supported() and enhance hv_balloon for hibernation
Date:   Tue, 19 Nov 2019 23:16:03 -0800
Message-Id: <1574234165-49066-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:300:ed::22) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0036.namprd20.prod.outlook.com (2603:10b6:300:ed::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:16:33 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b83cad0b-b72e-4ba0-e964-08d76d899341
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1251DC34401ED5D9B2C6B4BBBF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(7416002)(8936002)(50226002)(81166006)(81156014)(8676002)(4744005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(966005)(4720700003)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(6306002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sq9/A1KG3kxVzBbM5ES/N4JRPkgZC/AM47pGYs7+1Yk/NVMsbk3lxLuN+iWr4pFgN1wkPNfB6fMhXbfK7lHCG5aLqjVq6txZ55l/wD2GW4mOludbV0T7ukZZDZLqj1gM2YM8EXNyojcDie+QtTF2KWGTVNNtIz2kvD+eFK3Oexg+cWnsNcvSWf1JbojD3uOQtprygOQ1ajKogrIis6/vXWiWf1PxWRvLqBq5P8NhRIMX7zPsLUhKYagbtI4lUTQRdv1LGfXeV49AQqkK10dHdUg+n81cujvyGpQcBPVqudWpR4sDVciHjadjW8SIGXSjTDA3/JAGanFr3ehxcCxV7fybZB9uTc2oen06vz4gfpUI+FEo+s74BW7f3qPAXqTUBs5PHggO9RbuMvPGQiZBlWRJ76bJSI7qJt0XvuW6V436DMNcgj3H1+QNz0QfTMpTd6fhPmhw+sdhGFVY3eQhfCIKa4FDESufzGebIWBTIqo=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83cad0b-b72e-4ba0-e964-08d76d899341
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:16:34.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze2HU/bU0FzTEtc7ULAdPqxzvJNTdyq4NF5CktEvatt1jEU4U6qIp1se5oKSstN0XPXmAw4Q71QNRWm7ZVOQUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v2 is actually the same as v1. This is just a resend.

I suggest both the patches should go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
because the first patch is needed by the second one.

This first patch doesn't conflict with any patch in the tip.git tree.

Dexuan Cui (2):
  x86/hyperv: Implement hv_is_hibernation_supported()
  hv_balloon: Add the support of hibernation

 arch/x86/hyperv/hv_init.c      |  7 +++
 drivers/hv/hv_balloon.c        | 87 +++++++++++++++++++++++++++++++++-
 include/asm-generic/mshyperv.h |  2 +
 3 files changed, 94 insertions(+), 2 deletions(-)

-- 
2.19.1

