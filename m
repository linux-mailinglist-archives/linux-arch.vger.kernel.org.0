Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A953B6DBD01
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDHUt3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDHUt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:28 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB197D90;
        Sat,  8 Apr 2023 13:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgREbW4UiMfwrB8UuiaPktoGw9fv3TkLaIUcX6iCOdMZwyaoQkHSgcuH3fdgZYTo/ETr7PWWiC+qAVZ1j2Ui95TUB5y2sZBlbgQI76uFSEQhVAKryGuCLzvSvBXzhsrihqX6lXoHzxfCY2qg5EriJjx40PoOZfcY8BkhBDtK5nh/Y0cEyJfB4rqKAI5/TTj8yovcsEvwdmMONkRN01UF/zn7T9SFR3+C/2H08pK6hfDJGyOkqlARSXXo3+TRELDWNSfV94MrVDI7U+1CDqMiIwA+ADhYlU75k9wX/UVN2NSz26zSg6jcKIPIzQqyhaPVA+krpPgA8LYX22+w6I6/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfXZupIOnWx58KtiZ/3bQV4OhYbL4erVVlFq1e6FcZI=;
 b=S7MoYPYRJ2sZKJmognsJfZRkdvAtem4WiQgbZ/UWIwuvx9YrDEehiIkIRp/ylWsf1juo1dgKMDQdBlt9jNLBVXL7JhZsNtjLpt3zDxeRcB2kt+3ro6Hl3QHRUT/F2JRqGm9LqAYNxjEXW5+0ktx90nP3lEZvcX5TpoZRi/IcfEk+UcI1AgCVFLd26CPyCDy7miFg6LvalSBeM43PUQ4mfx15uxQkHzTqazr4tjWZGwHfURHmwtJ0rnwTSmBjHyml/2ITytftYexYN5j0i8Ztu0ajC3O9WCmn3WIhLIAdHOUFeWTYqN05UhsycqhpUCWnK+FzHOiKrAGH7nnbSVaEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfXZupIOnWx58KtiZ/3bQV4OhYbL4erVVlFq1e6FcZI=;
 b=T01+AebopF/6lPm/mdchofPu//wOQA54H7LmXMMOQoAHxvTSPDAjhh93qlLIgE4TPQURFkq1RZQ6xYV4wQssOgfvSo3bFp3tuzSPO8pZq7U1M/SniZc3JufK5i969OfZURjWh4FX/XLFgsqCs8hN/nuCjkIPNAAgO+lUydMpxNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:22 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 0/6] Support TDX guests on Hyper-V
Date:   Sat,  8 Apr 2023 13:47:53 -0700
Message-Id: <20230408204759.14902-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BYAPR21MB1336:EE_
X-MS-Office365-Filtering-Correlation-Id: d87cec69-a68d-449b-2ccf-08db3872bafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOqMLWwB1Va+lkVkpQRJZiJ+EE092gYPdtt2tEKopSFAzU38GbV7KcZu8cTTsUJLudDhFrc4plOcigf2/fKW+lkVVjw6VUKVF4IqwmGeSWQOUcMde5uGj9lP3eiAKq/Q1nZVpzjsCDIo7riQ5fM+a6BSFJ7aEY653cEzJrLjnSgVFbTaeqB3blw25vUvzAMyU/N6QSlYeAk+LQAKOpDqjjoEL6QLbnMmZlcwScyN3FLEJ6leFZRZK6gduuthznbUbjK4vjEVEmzRdq8bc/vnNhBdn4wIxpanv50zIUMqmHRUMPG8BuxYo7fpKEu7/USzRZ/YI8AsjE8owejlOOMmlZrbv6ssremKXAqow0cISUJan7aKR+712cBpUIfXhP/pM5TdlAQ/E8KpAsh4ZcBaFn+F1br2mfX14P33NzGose76946QjqUM3SVbPxHixzhngVd1Ta49yh7W3fx7vk8aMvAtPhw3TUUkxfbkrAWHO/s7OS99LJ2r5vzafJ1HN5Vsqu+m7tvl68IGnNPpnNWEPTTk3Up/LHR4eJaFDNsMxCzBv93RTA09DrQDS8lr5ztjB5ACHSsY3NkzqgSNk5gQAdTycJWmcEiWnbQOv0q/aIcQKh29dSbjfcPLrxJk+vofEJk1iZ3lF+C6TFrPo5G7KlOpUYj+M1h++a9D0/L82B+2BLQJH66ySvkCuqjgjxRC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(966005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VE1t3X7C6BmBo2aQWJC7CRWXKROSCa32G5KFzbAy/9UOjrcKBeqHhJfGB4RO?=
 =?us-ascii?Q?J4+KQ+mqhYJMufCeoecRAi5eOjummReQ9itTbXBRr0KteMn7dFtQE4et7OYW?=
 =?us-ascii?Q?SeZrYJrkJr6QwhXwGC23H73Zifo0YgkeaXgV/Yr+kxYXRT5TbkekReENe8mY?=
 =?us-ascii?Q?QwKNEYzOBVmfcN5LLFWcXrSvnl57tuGXnY1oXTpwz7bZV6o18NuwD+pq3L88?=
 =?us-ascii?Q?keEmFpwFZj0zYa7Rj9gssG1FLnsdPgYgJ4y32HpR0waywzKBRf7LB2kY7WXK?=
 =?us-ascii?Q?l9oXnA1sGMQd5tPTUCa/0B9h+xqv1MqZNMIQyehAbTh6FL31dnHslpDigA1M?=
 =?us-ascii?Q?fe5PWujPY6/xuOJ78vlU4ebfrGQDyRBwGxn6lo3xPS3advb/Tb9VGoqMPfT7?=
 =?us-ascii?Q?wbsG/DcU2aYwSy+oylyEQI5dk0b0W9qqR2klNe1j2Eu1MRWlp1k5A7s07uBy?=
 =?us-ascii?Q?/R3Px087Ou2eUBFpNkH93EnmMcV30UeOhyfrcr/8nwZtr5W0Kl17YA2+Grz/?=
 =?us-ascii?Q?uN+DY0EGSmqMO5lBJRizIYQs4YtoVDt6aC7W3dlsOuUGkU/o2lXXGmF6qLtJ?=
 =?us-ascii?Q?0rcBu94QomEYeBJIXvEGOGpOvKH0otIBzQfMD/b1wq22rYxY3C6kS0QlGXa3?=
 =?us-ascii?Q?xgrmBIjJHfO3urLHMceesSvxN1O9osokyg8fx5vTe0JcJN8egH2RAD+RgEAs?=
 =?us-ascii?Q?pdCP4xsoFgUrfOBq6FotYC6aJ5XH0ZVPLoqlFLVp0SoMrzCclEoeC4khhwru?=
 =?us-ascii?Q?194GTmr0LfK2RfxLRNoN9SPnySPCFh6opUHpi1qIVWmm2+Atj97FIAXRzO/+?=
 =?us-ascii?Q?LRbgCRFKo2FZpzpCGOStqDBgbO1Ddf0/uzCBz3WnIdGG90V78onpJNz8bLdh?=
 =?us-ascii?Q?1U2HXkW438NDYiSCxy/FaL2nAs536Rgt/EGCRuM2lF1Sdc4rgWpkv6EF6lIW?=
 =?us-ascii?Q?PWZRlMI1/YMWnll8YSU33TReIqdoO4C/jFrqsXoMRgWK9Hw2E2GrNtytD8qF?=
 =?us-ascii?Q?maIKI6INHWn14qvyW6CTcxETl+LdHyUTsPMp+6oP4NJQBNLE1JhjUfFhS3i2?=
 =?us-ascii?Q?NY83VYGreFetaLAQZfivLWIqxHpKJPsp12WS1CKwj5zewAq7H4WYX4h/lmP3?=
 =?us-ascii?Q?J984KdHvLVdr6bFINYJUFrARVH7LceSGjUZkHxvOqRqM8HanQLxI9rlwFc8F?=
 =?us-ascii?Q?eAkLhug8Z18S+NGlTuzjubqQW5GRtI80YHr6CvnlFZUrJFO2lWEvwthB9x3X?=
 =?us-ascii?Q?/dYntKlriso1pk56ufIWzvZaVsuzCLYmLe2HypfCK99m9SYjFgp8u1uVjFJI?=
 =?us-ascii?Q?eL90zA1z3IxEU8+bn4uMYF/mrnPwOZinT3leUDBsJgW7v1LpWEqikDFERJTq?=
 =?us-ascii?Q?RJJ/H+I8lyVj23jBpnjaOwrT6S7FAVfkyxYd7SWaYEymq7lXG/9mVkFJf1zP?=
 =?us-ascii?Q?lq4lFr+OzfUsw93pPM2HJciz4vXedoZW7TY+TnHcNIU8NJI+f1fD124gHJRA?=
 =?us-ascii?Q?LfPVbGWji68QTdgEGGGl6L8LL6h26t5oxzFCW1O5xPJAAFTBG4h+Tll/gMAL?=
 =?us-ascii?Q?ogvm2flAWCxnnkvext6Wuv4F2PuxrBH9VODEqYD7DSNcXxwukNh9NZRG7T0I?=
 =?us-ascii?Q?zexHrtXCsupZvzQGlHNRyDHfVxAqP9nVnPFKyvnzuGyK?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87cec69-a68d-449b-2ccf-08db3872bafe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:22.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4IqfIHJ8Xn5hhJBmLe8zdwFvC/eFw49GdniuYRpWbZ147eTXdkxFZN/VGlB+dlkW3xScth9jssBCw5Z01QMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1336
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The patchset adds the Hyper-V specific code so that a TDX guest can run
on Hyper-V. Please review. Thanks!

This v4 patchset is based on Michael Kelley's v7 DDA patchset:
https://github.com/kelleymh/linux/commits/v7
Michael's patches are being merged into the upstream (some of the
patches are already in tip.git and the others are going upstream via
the Hyper-V tree).

This v4 patchset addressed the comments from Kirill, Sathyanarayanan
and Michael. Please see each patch's log message for the changes.

If you want to view the patches on github, it is also in this branch:
https://github.com/dcui/tdx/commits/decui/michaelv7dda/tdx/v4

FYI, v1-v3 are here:
https://lwn.net/ml/linux-kernel/20221121195151.21812-1-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20221207003325.21503-7-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230206192419.24525-1-decui@microsoft.com/

Thanks,
Dexuan

Dexuan Cui (6):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for TDX guests
  Drivers: hv: vmbus: Support TDX guests
  x86/hyperv: Fix serial console interrupts for TDX guests

 arch/x86/coco/tdx/tdx.c            | 122 ++++++++++++++++++++++-------
 arch/x86/hyperv/hv_apic.c          |   6 +-
 arch/x86/hyperv/hv_init.c          |  27 ++++++-
 arch/x86/hyperv/ivm.c              |  20 +++++
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  20 +++++
 arch/x86/kernel/cpu/mshyperv.c     |  43 ++++++++++
 drivers/hv/hv.c                    |  62 +++++++++++++--
 drivers/hv/hv_common.c             |  30 +++++++
 include/asm-generic/mshyperv.h     |   1 +
 10 files changed, 295 insertions(+), 39 deletions(-)

-- 
2.25.1

