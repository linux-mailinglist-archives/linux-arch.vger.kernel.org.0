Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DED645062
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLGAeq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLGAep (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:34:45 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022019.outbound.protection.outlook.com [52.101.63.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C493A479;
        Tue,  6 Dec 2022 16:34:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/6IAVbaB0jRPH9hHvofbGLH+IiDgv6TkUj2F2fn8Mn7wwLRvAdDe4k8pYqFnYbkTs0qOP9STukj8wPB4RuZj7gTcf28/lvaO5l6Sxo9arIkmIoYD692Q1sDKDYTDIMVOZmnzuZkhN1zY4o0pUfkX9b1HCOk4wHWZcRFFLvMw16Drc858DiP3OYxIgvy0dPXQ+a9ZD73oRK8YIGGV+aBYWRX218S9drJPZodYmCN9VDOG67IfWUV+XM5Umd+SuGI4T9oZOKdTP7Ka0DCZVoD94jcOwoXLhGl/96ZWEWQlT177OqJmQ/jhPnULdJVqnt8pR1tJWWp2mXko4Lxv9sS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41pHDZaokWSnvXsO7377VL12viVvKng+QVLc93XiBdo=;
 b=kGdJml9oYwAsS2KXtarjFj7irESefs5TDTd7BNLaf0mx0ZuWbXwiPQAbcFM+A3Zis72g8NwghGi1t1GMkOeEeugPh1Bye6eTYijZVQmU7soZxBmMPJHMn667uPJRI7Z1acAzf5k/oItR+vFTyHc9TSxJqlxrcO7tHXDSfqo5PWDQzY/bxnuq8Venk0rbkiWK44+fUUTtBwhItxCizuYi05BDTwc7vsLMpZKcDjMpNEeNlu2YtkdDFfMOp/y0I2dBkbOTvVt6deEHlbZTYtIp8pVcCwu8GCWf992CgIqn1+vbqeR8eeJJ/KvPx8u2yOUnE0uOHwmxaYWDj7gegzf8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41pHDZaokWSnvXsO7377VL12viVvKng+QVLc93XiBdo=;
 b=eK2ZJ+qBdrDZA1x2lyVzVdhNlsH2j9BWzAY54ed0WZnxbs1y27/KqHe8tfWRpstSWa39jD4CVD8FSDQdSnhXv9BRigOp5KTnHr79M4Ctbo3BHLppm+/ALXsEQx/KfBnPi7yiIF9Ac/0xS9xphxX2j82a/udlK83VZMobitYOrm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:39 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:39 +0000
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
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 0/6] Support TDX guests on Hyper-V
Date:   Tue,  6 Dec 2022 16:33:19 -0800
Message-Id: <20221207003325.21503-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|CY8PR21MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: f30f1b3e-e139-4ea6-76be-08dad7ead2b5
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ubP02sZAXFnxsD4jgHC464DYu3dffG87LqiCylvzFxZVXpu7cFbPtKXCXm2omPuqd7u/4FijKpvRK3GxY3k+5xXqIs5FDj0oYtf2+gYNIPH4+YIzKUN1P3k2rwvHA/w9u6EGTuRlgt/l3Xf3e5Urq0ItZDLz07D8GH2uZt0DPHVdZHkzp3e5HNoRHrRIUIBGcge5+5ofz6yZS1p15aTQDi+WAsGLCIqGlDHMYmo7uXnrqHmYnRCaZPDN+5fcoqwLMSiKFfY1QBEad3P4nX5/gprH6h+dle/GXzWPFhgP5aTbB34Bw18w45zSJF5PI4nnBzBq+scXLRx5cHNA8j3Z9BnQS8KAt8PWnOZWyngB6GpbkiIIXvFnPy8v0xgyXNUjgVSBLSw6mrEFBHjl4wA6QNmBoNGDDj6SE1Swo7QutAu5/W02ux4t+J1vQRH5afuvQr/dXbz5tohKGluApiZSO2pJkvvXnu+xtBgza/J1tUg5U0DOGmzd0nMq+8gxy18JsKBt3OK6Mruzwtons2TiyixCnWvisY5qHu9pu2Td/fph1tB8zYOxHKFS3n4j4+1SFoIuVIcmuBbjC/0+nHABnjW/eRKCeiBqJaA0Q7eiTubfCBrVVaU+mzHD6WrHcD/CK7Q/2a1omP3beeIZBOubDF/iCKLL+T93C9AEWUhDSNFSTH+p7kXsO8QpNaPo2jEwZm6aOCyndmzaRASd2xqDLgx5Ii+2pI73JmIFUZH8p8LHcPtnX02lE+J6D9ms7ZutFmxf9h7gpEax7CwcAOwwvJS3CLVY0Hc1Y9T75lMdl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(107886003)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(966005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NXBjcoZ+8rw8MYgKivQPORjSrjNN0VHftu8fiJt/9/7iw8N0PJEfvROUAMkw?=
 =?us-ascii?Q?eAnSI/a6Ravlqikj/C4TbHG8gXhhRiX1UCItFxclqedcZoCTifaCkglhzS5L?=
 =?us-ascii?Q?hK1Z63/xKKyTQI/shu59CqhpUAZVRgELZntp5izERWRfALeFmRZXsYMYunQA?=
 =?us-ascii?Q?PnRInTMjbTE6Ka7Njzvl31iJDUcMSnLUMF6sweOhPfBT4VPUpVqeuDL99bJu?=
 =?us-ascii?Q?aNfvUYgrXLkQfMdP13q9YIS5Ezotfo7wJ4iQNOeSf4snA2kTyyuvKqxWgVGu?=
 =?us-ascii?Q?rBlE7/roml2S3i76ad7q9d4+JJ0kISv1P/B0IXKFtmCsZZ2mME1Bjp8UB5nF?=
 =?us-ascii?Q?QBucDYOKve9vpF2AIYFn53xyykj25BPNjDBnCJUTLyX5gD3MnNoGHoyphMkY?=
 =?us-ascii?Q?crIVmAsJlqd60d47OjYbVOeCAzj3E1xa3kN2hxog6C2btMIJSodn7BZ1jnRO?=
 =?us-ascii?Q?4Pxb3E67tR8GPW5hhH/v745Fqi2jfJ3qdusmbOf2pMYS34Itawqm3c00g9QE?=
 =?us-ascii?Q?C/VWPJ+0aqC8/0WScFaiUe5meCWYmvOOgUWfm3I87QWgqEO3IZOguKpe3wls?=
 =?us-ascii?Q?dqgDNNR5cw1igoPtwuR5q6sqyZ6NFX6uWInv1zfnBvsLwaUWm+ZNN7Jh/vo3?=
 =?us-ascii?Q?mqXwmV8Gj4XJzkWmWNoWXyY3aILf4UVZnPJ5I70jQcxMu2KnxQ05L1/UeXhz?=
 =?us-ascii?Q?3kxFLChKrZpAXf1jvXdZkAGyxQF3PtbxdZcRzL8w3wC0muKZj90Er97a52Gn?=
 =?us-ascii?Q?8KqNaDqoHIt+WZMFdFdoiM9mRDDoR/OjvvBH71UcbT7uROlh3jTqNqaJ7h/2?=
 =?us-ascii?Q?e6igIFgzBulMfvOfbEWVamVHe/n1GMv2gsVKO7D07txO8yjvhUlTCFgpve7V?=
 =?us-ascii?Q?tS/nKPR4b7Kj8+daFY0W5yvZDFDmUaUZIfhDjLTeZRG7pfwmCtytkHCE/kIg?=
 =?us-ascii?Q?mac18ADy0z/uWVZoyfAvCZdkGRNTkrpjxJ5cNcgdDs2TFR5C2lwBnF1wxIN8?=
 =?us-ascii?Q?QbVeMIAWYUiYytypxslsbARnkFfDjTN+HKSUUwaVfD98HqpzGCmVUkFzQSEj?=
 =?us-ascii?Q?pC0m9ZoK4ua/9xU3h7HTjG+qYveZRSMbWLVpBeS6nxy951333CiJ6JocIoC6?=
 =?us-ascii?Q?iQNZi7dewiaQqEZuR7kxL5qjPNV9jdqDRyzs/qPkpfKCmEWs0AY3Ramh1RY4?=
 =?us-ascii?Q?uUkyG2wSXxZx5gu+hsmoc1tDEUk2+k4Qle3zsEysRsKFUDWUNPzpdQwUI1Zb?=
 =?us-ascii?Q?H2wjlss2J4qXP9jf3XSAHpadMs+C70nF4ds+Ha1F4yYu7y4/M8HZPE6Jwn7Q?=
 =?us-ascii?Q?ufInvHxxo6zBzJUFYJST/NKmCrc0z2sJZqOly5273Oss0uQyUCWy2KydzZ60?=
 =?us-ascii?Q?ms74KL8UAeIr2rXWFrQyVkA1oVQoI8zzhMVXP2TwPUr1Fg8aog6SkTCYPwQh?=
 =?us-ascii?Q?k8vpmh1w2PBkKUuZfMGfRlKctTNmFGXdJX28UU5bgBKQWsIluH/7GHRrsaFG?=
 =?us-ascii?Q?fuyivpwwAFfwxYGsig/puGkQ88gLEpLJVgHrtu+qdyzabdvoTOG/M+D0rEva?=
 =?us-ascii?Q?eAguJXnHOlQ+RqqPPW+rSTgM3H8O51Fkkokg9QBnVybiELRB5ADk+z/TzR1m?=
 =?us-ascii?Q?AMn3OxeYccfPipB75RiNDD11BAKVzUPHfYv7dbXMroA7?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f1b3e-e139-4ea6-76be-08dad7ead2b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:39.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGtpBFtg3UkLAiCbPDLuvs4eIMUKs0xUaQKfWrvW8CtEs47vEGkBs5aBvDoG9DbAyzQ6CJHl8iyNo724ReQt3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset adds the Hyper-V specific code so that a TDX guest can run
on Hyper-V. Please review. Thanks!

v1 is here:
https://lwn.net/ml/linux-kernel/20221121195151.21812-1-decui@microsoft.com/

I think I addressed all the comments received against v1. Please let me
know in case I missed anything.

I added a section "changes in v2" in each patch: in patch 0002, the
section contains a few questions. Please refer to the patch.

This v2 pathset is based on the hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

Thanks,
Dexuan

Dexuan Cui (5):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for TDX guests
  Drivers: hv: vmbus: Support TDX guests

Kirill A. Shutemov (1):
  x86/tdx: Expand __tdx_hypercall() to handle more arguments

 arch/x86/coco/tdx/tdcall.S         |  82 +++++++++++++++------
 arch/x86/coco/tdx/tdx.c            | 113 ++++++++++++++++++++++-------
 arch/x86/hyperv/hv_init.c          |  27 ++++++-
 arch/x86/hyperv/ivm.c              |  28 +++++++
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  20 +++++
 arch/x86/include/asm/shared/tdx.h  |   6 ++
 arch/x86/kernel/asm-offsets.c      |   6 ++
 arch/x86/kernel/cpu/mshyperv.c     |  22 +++++-
 arch/x86/mm/pat/set_memory.c       |   2 +-
 drivers/hv/connection.c            |   4 +-
 drivers/hv/hv.c                    |  60 ++++++++++++++-
 drivers/hv/hv_common.c             |  12 +++
 drivers/hv/ring_buffer.c           |   2 +-
 include/asm-generic/mshyperv.h     |   2 +
 15 files changed, 328 insertions(+), 61 deletions(-)

-- 
2.25.1

