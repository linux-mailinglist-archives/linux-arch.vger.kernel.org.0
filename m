Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF5738FC8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjFUTOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 15:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFUTOG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 15:14:06 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5D1BFA;
        Wed, 21 Jun 2023 12:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmyzrNlJ1VIuku99kfJHBYr1pELE42KrbvokqayRSiTmgG1j2xzkHf60d5IKdxBhb3aKuCsIyrPTvxNvceL902svpJeRv0hIaOaP8naxr9/wAE3CT6HPuLagqTkfuoJNmsO9JN0BIfvUp9o3/nVwCUDdhdbpfgNPR1KZFZ2pKQOTU0XMkXVpd1E49V0rudfOMIYiwO+HloCdv+AXUX9PXJF4u5ek3owQvcqDKYCM9Bmv0WtLyBIfxLGq+MwBlXqdkTN369Sp3Fr0A6qQav0PTMgS1lt+bxSDghlvxNbQNhQpHJA45v316QaKLeUcSsLubDFZAbRmhshEQ04Jn9QxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAiXjqBUIw+FDcZ6qSb+x3trhnlWd8foj6TRjIBCir4=;
 b=BcTG1LMMapgzL0ZehlQoC3UwUkWojDv4Ylh0wln2J6bjx4hxPM6xVM/+6EGe6MZzHFTJgH9oo9+KnNge0MNQHutdJaYJjGFf2zq4ny/C/zmGjJaJubJNGM4ZSBKDbIDFQrGgyti6B8mt4/JeGaoDa6MQwS3vdLSkT095oy/Jd9t5bLztU2xaUmiMGpra4CiKwqOoifjUwH5DfRWljEGftJ2mhbrftOnOzHjudJPNvhrWPL+XyfRLGO1do/+TLOtEAXIoQQ/H9BufujobXqBvCqrG/KAINjPgGmBjvl3ZAiKYR3pRiKAqw1zp2kE6SsQbaq+0MGSfxFANgJLWmq27FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAiXjqBUIw+FDcZ6qSb+x3trhnlWd8foj6TRjIBCir4=;
 b=bnOzM2d+6QekPNHuDWcX5a2CpD+BPf649mORUPND0RyLeur/g/HMnOUQz1dvGCyUDDSkuKC0ffl15BTV5NtzXJEYqj3g69gZRmCnuVVFHeYjDOierPM8lhuAB2671hw9JvqIxjd52tAGNk4XJMXCyFUttn1uD4adXbOi/u/ccCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW6PR21MB4009.namprd21.prod.outlook.com
 (2603:10b6:303:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.11; Wed, 21 Jun
 2023 19:13:51 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6544.008; Wed, 21 Jun 2023
 19:13:50 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Date:   Wed, 21 Jun 2023 12:13:15 -0700
Message-Id: <20230621191317.4129-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:930:18::34) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW6PR21MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: afae7ed1-ff24-4c2a-096e-08db728ba53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATfxLgwfjHmmNvXwqd7Dl0xCL5DSNP30bJSZCHcvM80Vh9hSj4FccSEoiJeyBlK+DhLNnwsvj7UsS3UGZj2pJh4vvy6+gk48zr/TVsZJNFemGyVYLOzmO6VWMs/4GOc+D0r4l5Kzt8UqHCU0RkQ5wNZSz7lGQUR39fp6TyctBbhm0YVbPvl3c20eVhuk3X1g7AqQ8m2vXcLlpx994r1kMcIXAJTTvn6qTvtICHMvEK0lJxFnfKeDOGTnlLJXoMX+f/MZxD/VXEZENCeAVG4t1r/UGoRRGcvuCFDAC9MRL72Z5e4YNGEcDf8B6yjxtQIt0osuLiZt/l6kCdk/FBLUzwKG+eoevkfj24neNS9p6b18RAp2W/bhhC5cOnGIn5Zowdl0dKiyMWX/LUisSiimhe2k4W7+r5cXq9J1zFiz4jO63NdpR21O5IfjkrAWkfPLKMecmRGkZz39BkesZDf2BgoV3XKBI+tjaJOKQql8WVCMQGGWiVzpEFPkMLKMV5R03FKvIxuypJsh0YjYy5vZDLT6N9Rv5bTmhHUOXXcUGzD+xMB0evip/YpRYGeFxrGiSIpUfuKfRwumOdxUXq2NWmAHO+egROWq9wd3Dd33oX3UDzxH/yjC9wZevr7bs3fvQ3Y2sF+vXh+30/6KC9BmP3Sz8r/aBzFLApOjrE8b8VW4MfuhsmFJoE9kNnnKgVpz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(86362001)(38100700002)(316002)(4326008)(66556008)(66476007)(66946007)(41300700001)(8676002)(5660300002)(8936002)(4744005)(2906002)(7416002)(186003)(6636002)(107886003)(6512007)(1076003)(6506007)(36756003)(83380400001)(2616005)(478600001)(921005)(82950400001)(82960400001)(52116002)(6486002)(10290500003)(6666004)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GXpocNX2frZhCc6UNYzfUhf+9v3ClGEvPxuVwUdUFqNI0LHhTkc8hiWEzQcr?=
 =?us-ascii?Q?z1rN0ctJwEw69jwkbeUNJLRYOTgB5psNh/t4xgWhuRWLnZAL3BZcwIy8NEtI?=
 =?us-ascii?Q?qCQuErvjllnFfw4yTHtSzGCJgtfv7flxtVV+aaf7tjLbKxk9kWm91DsdfIFq?=
 =?us-ascii?Q?5q1eBUu0ju4wsZIR6IQV4gXXcycSN9SxE3I+RtJLGmk4u//5Br+za0Mxd4HW?=
 =?us-ascii?Q?75F6m3W6Yicy4A3qi+q/UHqL7pLpE4J5ndkThv9W05hjVNnAkcsMQn+V1sdS?=
 =?us-ascii?Q?OsmU4MlRfUcvzPuNUIrID7uiuu9CPnSpp7E8lgEftHvbB6MKSCrIbW4b2rea?=
 =?us-ascii?Q?Qa7ibXF5n1D/iL32Qa2n5XDVQdp6GZZYkKo88fCfRnCzqo+K1c9Q0U5AFNVa?=
 =?us-ascii?Q?24uou51XTTLlQLJrZ13Ls+bVqLmEpHxYgGuLUyJCAICdoXto0LinPQe29Oit?=
 =?us-ascii?Q?/3vV9gWYqKzh8kmQyNLodxdOgKDqg/49xsdFDXnYelhiIvYGMRo+2BrdyKip?=
 =?us-ascii?Q?EVtAqIH6FdYV/ZjdYm8ZjX4puYXLLA8Z00OAidH+LrRj6lOwY7mO1EOvS5d1?=
 =?us-ascii?Q?Mz7M41UMemKnpDnBDi+Xnqos9Tvu84TLxzeXpN4UixQSL1FgcdGenQrw8qG4?=
 =?us-ascii?Q?mPB6YYyw2/vDmgPSdDzR1KCMfeSPRO0twGkmIUVgnml0Ns0luFsDqhtLVU2T?=
 =?us-ascii?Q?/BA7Reh9lV4eLWIz/r9PRSfqhrsrDuozeHYMswo8EgCuYKWwCIJwgWpqmTiw?=
 =?us-ascii?Q?5rO7/y4nDXgrS+SR8L/KhDnKzo+7XJFWD+k/qxGBn8JLarFZRRD3BpPxtmIL?=
 =?us-ascii?Q?HJEkHvYnZXltxNFhduVHF4Fv00Lo6LEk2QAaqHvRMDk3WYvhJs/HPkGzbtt4?=
 =?us-ascii?Q?KiPZuoiBQlQqvY5COJVRW8Nw8bzCh0/GdnmG1LqnkVLZySeigaDdoY4wm4/c?=
 =?us-ascii?Q?4pYAGNZr3VD6SkuQee/gTXFqAjaQV645dzH+15WkW6v0MVfZu3z6x8j3KuGL?=
 =?us-ascii?Q?o3BmUZ7CNOksxid3X21HLB4Tj5qGu96iU/MGY/2QJYP09AGY+DBx+0J1vEa8?=
 =?us-ascii?Q?E/+ipzk1OFBdt0eZy5+Tzo440cN9vC+ztD6duAus6gCWssyHuggoR2Wq0or9?=
 =?us-ascii?Q?EPS/SGPeLN6UP6ECxRb2uP2e/HpPdndMPFV4D0GGGiMqc2QNP5MKWoS3X/vL?=
 =?us-ascii?Q?erXlRmTz/X7HgHqvvDli5IKgApibR2O1dYS0mdxi93nLFrHpYibOSByGCpc/?=
 =?us-ascii?Q?upNbyjj8pep9fcmPRIMD5vklloRoY4sP2V2ZQijFBuG3pC2D6Xx3iTFHefRX?=
 =?us-ascii?Q?xQaFQuqDIQ9QLM/YfIi+QjaZX7w5/ijd3FGjy/fjg4LwgMqtg3X/nCfo4K3q?=
 =?us-ascii?Q?ZMfBSn7MEzBEThBDhX8kH1k3N79jjdbx+kK3GO3dvvfT2FQr4brI4jHVWWiF?=
 =?us-ascii?Q?zTfKMI0Z3N2yT1NcTXMFIxpsiINOZ3no1aKFIRPqG+AatEnG8rDN+/7ULJ37?=
 =?us-ascii?Q?0j6TbJXaglLgYvITqSZ/122OPp5xfl1rrgvMMgTX3JUQkxHsDPfGJFJ4kncM?=
 =?us-ascii?Q?Aidn2VVRKwCq7PkEIbW4R4NztkX4la56kwZnljqBYoQyzZ8AK5mLiDinqgqW?=
 =?us-ascii?Q?z1xJuUesFOPB085CaOmkL7CRSbfGrK412AqvLWEdPDpp?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afae7ed1-ff24-4c2a-096e-08db728ba53c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:13:50.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmETqLEtJPDrg8sPSOR8OJbI1BjO7g0f7+Uy7wFc5iZqzdG1ZjzmrtG0dA3ImxwuUk5VTuJG7CfszwPxPdN2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR21MB4009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The two patches are based on today's tip.git's master branch.

Note: the two patches don't apply to the current x86/tdx branch, which
doesn't have commit 75d090fd167a ("x86/tdx: Add unaccepted memory support").

As Dave suggested, I moved some local variables of tdx_map_gpa() to
inside the loop. I added Sathyanarayanan's Reviewed-by.

Please review.

FWIW, the old versons are here:
v8: https://lwn.net/ml/linux-kernel/20230620154830.25442-1-decui@microsoft.com/
v7: https://lwn.net/ml/linux-kernel/20230616044701.15888-1-decui%40microsoft.com/
v6: https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/

Dexuan Cui (2):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()

 arch/x86/coco/tdx/tdx.c           | 87 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.25.1

