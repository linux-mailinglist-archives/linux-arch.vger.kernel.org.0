Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B841F7370E3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjFTPtF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjFTPtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 11:49:04 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE46F4;
        Tue, 20 Jun 2023 08:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My2sJRmDLqlFyaUiHpIscdZF0jWdILf7EhelPTtZUmxPfRc7mpuUnwTsD+HzQx48TiWjOJ9/v2rubEzqhxPrXlwuh71Pwmof9ogxwKCcjTLCZHeJyxGbQSFA+h6IGMqh63Uw29FhcDkfnZEmz5ADBIwHIV+D40PNaEjgADnLlOxdrn6N1hMej5lKjnn3/4VPshOBRcP5PU9nvMYKimyQDJOeIF60yU4CS3UsCg0L056iBLAQwVX9Z99d+pZfy49mAZK4h7sXSC25u2PYFV1ncvEe9KcQqq8s3+Nn0UieC/jgs9Gz6wB2SRLV56HpiSUse17hJzlCiEqYKG5YUA3ODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5K9ylMfdaCTmYgjyGTaV2+cHeJtkBsW/0ushkYsOIs=;
 b=aXWZwwIO2i4EYtFjLM7e+wp9MiuiDQ4n81lOD64aaFmzpe29atwKbNHDigAuF1WuJVXM4NVJfcQcix29mUFWqR/L8dsup8xSHH0+NA3lXYh4OtKlGRX8kvvel7+cdeoUK5f68I1d+cHcdJcthMO66ocL/iwZd0RUDBRN5/j5wN/Qeg4pwYDLZJvRHa3AT48tMSUWY1xxbI0ihLCvG7g70K2WotOHzs02ME6It0o5ZfzrGPyDgOuZ0LHcEt9wKgX+tfbpsm2oaQEAsMqgaV3OzmpsTgFo09XyrfUi4pbP/ub51wrG5AMjKkpoNOaOV6YrPdvHAWxknQ6WeiqDlqRufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5K9ylMfdaCTmYgjyGTaV2+cHeJtkBsW/0ushkYsOIs=;
 b=NvNeicb/boZ+89AeRMgT3UD4oCKlysycXLHoUaR+i/KVRNUENHhlddTxnpSstjLEWkzJRxTJuypB4v54IG6N/t/QfNyh81bHdZZAh3CXZ7iAnyj700QzsHK48ZZZ72GlGNblVMm4HsrpjBVjc5y63am0YlHyjDRNmakuyPxfGB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM4PR21MB3585.namprd21.prod.outlook.com
 (2603:10b6:8:a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Tue, 20 Jun
 2023 15:48:57 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6544.006; Tue, 20 Jun 2023
 15:48:57 +0000
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
Subject: [PATCH v8 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Date:   Tue, 20 Jun 2023 08:48:28 -0700
Message-Id: <20230620154830.25442-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To BL0PR2101MB1092.namprd21.prod.outlook.com (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM4PR21MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ae9448-12c4-4dd4-02e8-08db71a5dadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XxzZDZSSZjsY8R1ZWs4XPAmD7lkQ78GU1r0pErjf8OLJjbsV0EA6z9KV/3LsPMpOozAzIBAsSCX8Fb11ARpnk+ZXu68guJrqCFbIP2z3PD8ed4MK94gFXC/wfFnecaMMmhMzxahGzi2hg+XAo2mQgjST7yT/ynHYeOZ8jPa4GXhSVAqFCh2zc+RbRo33sbOS3cTJr3HJuAC9FwpyE74aboRY9Xh5gu7pTq62TWc85s624KO5RMES1hm63gsIlwzK83XcAFokyX2x7fCPVzzR3azHpP8w2t2w3anFuAzd2SK9gvciUH0aZto9T5iXvCpXw4OqSbdEALRkHCyQm9qEVxT3tlO1htmbRv1BQWDKWaoTVTmxfMgkET3bBkJyfG+cj+eng2JAKj6FUbG0m24bRCTz3u3ubFuDyFYXz+LHCWGmjhWMO9S+tMD+9Bj7ii1ko/+RDcMO1A2I8omJH1wWEiBAUGnwVdaPTfbBE6cHKzD7dMeynXq/2HiTQ0JcYE8whM9z+ZX1io1ZMKy7pJTQ0B3o5ffIlPUN2+AcB48hBDaY29TJtI64WxXcqZQ96FvDojbLc5V/bIaJbWFB/+wjs9vLYjrum5oIT64NUjsZjYTjzgSiwXZN+9WLd+G0lKPGq2v0UZ+2vWVjhZX5n9+lk6MtLPtQWk8Qu+rrKWtkehrNfN3AX+gEQFOMDdPn/eg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(52116002)(186003)(478600001)(966005)(6486002)(6666004)(86362001)(1076003)(6506007)(6512007)(107886003)(10290500003)(2616005)(38100700002)(316002)(82960400001)(82950400001)(83380400001)(66556008)(6636002)(66476007)(4326008)(66946007)(921005)(8676002)(8936002)(7416002)(5660300002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7SLnMkDt44b4Pmdm2qdm9FnykNEfbDbJkqpllu5gTeBgP+UijA3o3UDYGFB?=
 =?us-ascii?Q?W3GRg2k4Lxf1v2d8XblAIgUlG12XPu8beLGLz5WjjDw3Ya8q2+wOcyivYs2G?=
 =?us-ascii?Q?z13fTXBI71uvS6nbOyCloG4htJbrHYJhdkiMmVFobjqpzW1xjYvgN6ohZheI?=
 =?us-ascii?Q?rzNerjlWBHkgtGcavNny45IjeDRe7EHNoCON5SEHdiLCqiqwrQ0qcj14wx/I?=
 =?us-ascii?Q?WhSBNWCZ7Bk3kxjKqtEIb1z5EAldk8spNQAzs5bPYcoJfaxon2/z7EwHxnaf?=
 =?us-ascii?Q?XqhRjF+4T0FdRci+9z1RHJUJFVuqDzw4yNS0Qpq2JDKTHFMxapHXbbOBxp3l?=
 =?us-ascii?Q?YcK9P8zvO49BetJBVq6NE+VVCc7mLrIiChi3QRqOuFGlWa/hIDI/gbpNdZIK?=
 =?us-ascii?Q?1IfK5h1HsVT0RL4SPClXdSGsq5ca4ziUgMzCE24q/rx2UimzxIhNuh4K4fh9?=
 =?us-ascii?Q?QtVtzxdtInS6SWY6pZ28PzEQG8P5gBizjI5HJFBZ2MS0YTb5toi29gIDvdTy?=
 =?us-ascii?Q?uw5Ak26rgVkwebhevaqo3aFLpizSHLnq1yStQWSKLjFrSJxUO/jlCVDe5NGk?=
 =?us-ascii?Q?Rr1nuKHSi6jpkmo71NneK1u1Wtxx8Ez6bKwTCHuOuB9p9Kow/1/kOoJ7ChZe?=
 =?us-ascii?Q?6wCrPqhzL4+TrDysJG7F33kdlYDRRb3TWEFILe0yRFBS3IqRCpRELYBFfqgL?=
 =?us-ascii?Q?CI6c79qyyA0pQZrcX0wGjKeEsQxl3jMFFdxC0hlunBzL5/BRz7f8yQ9ShapV?=
 =?us-ascii?Q?YFmeybTGo0rm5XD80+wD/T0VJOn0ORdunnPxTEujKeMIuxiGUWCHsCjJeYT0?=
 =?us-ascii?Q?WJSM93OuThaJ0HUNPeg8SicFM6mKydt6GF7ZoomQpPeMlUg7u0x/ddFYBcO/?=
 =?us-ascii?Q?wjS6oPUObuIEDrTEJLyi3heHJXil5cAjiDDsZnDd53D/8usohLmi/U6GRwi5?=
 =?us-ascii?Q?2heMCba1fsLg76OKU1NCyCANVKZwADzsnzytSdZc5n1/agmff+H3cAPvrNLH?=
 =?us-ascii?Q?+mkSOeJ24vApQmzEC46YKU2+ksi02svn7F0krzzYJNiBknJ+z/3/GGFKaheZ?=
 =?us-ascii?Q?g8dH3un1aHOYU/vAW0yjlxyPq33YgsI23VYEavz452woIQzgj8dLSRCGsAQs?=
 =?us-ascii?Q?an3l4rp3Q1ZTNwpQiJ95dexgGiiHDqDrVKBN7Pr7WE3+mGguiEA6PZzQjqIt?=
 =?us-ascii?Q?jTVUTO6jnPlbdU8jVzFvRv+uoRds+njyQzZt8S9dFlEp300e3MYPRmwDK6TC?=
 =?us-ascii?Q?AarKUemtoEIeoBNXdyJiF7pCqswJbiSvb8tjEAqhiFSP4j8hT8V/9V7Ytm62?=
 =?us-ascii?Q?zi4PhUESp3xkLHSZEtzqqlfgPMjZ1bW6tkOg0j+t250QdL0Gx1FSUie+v/lq?=
 =?us-ascii?Q?rgS9dims+9eLqIgNcFE73hWeEYahcjLGtK/TzChcGrlhBuhpBi1onleT2cwP?=
 =?us-ascii?Q?xQJEySYx7En5BDJSX9+70hVlwn7u+fdw/2BcX9waJSQ8kJFJp0JdgUHuFdvr?=
 =?us-ascii?Q?SaJ414HgvETN/otcLS+3R45pAASk8m7+xQv8WouBX3iU5vP4VyVHjjz1xPCu?=
 =?us-ascii?Q?fxMEh6/c3ELpj72Nyivp0Ft/VZ1R4wCALFPqXzM0U0v/9GEIDSY3QGPmoOXE?=
 =?us-ascii?Q?pDCp7f5NUZtKGOGpWRVo5q6PF4fApLMBq0VSRvkraH49?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ae9448-12c4-4dd4-02e8-08db71a5dadd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:48:57.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Em9D13XekiQ9Gj2qu+zNSor0wk5e2SKiZtR3mg/ANYL+JOgelelXJzGQ2BBWP58Mo7rtV9Bb3phOwtHSlKMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3585
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

v8 is a rebased version of v7:
  v8 is based on tip.git's master branch, which has commit
      75d090fd167a ("x86/tdx: Add unaccepted memory support"), so I have
      to rebase v7 to the commit and post v8.

  v7 is based on tip.git's x86/tdx branch.

The two patches (which are based on the latest master branch of the tip
tree) are the x86/tdx part of the v6 patchset:
https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/

The other patches of the v6 patchset needs more changes in preparation for
the upcoming paravisor support, so let me post the x86/tdx part first.

This v8 patchset addressed Dave's comments on patch 1:
see https://lwn.net/ml/linux-kernel/SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com/

Patch 2 is just a repost. There was a race between set_memory_encrypted()
and load_unaligned_zeropad(), which has been fixed by the 3 patches of
Kirill in the tip tree:
  3f6819dd192e ("x86/mm: Allow guest.enc_status_change_prepare() to fail")
  195edce08b63 ("x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()")
  94142c9d1bdf ("x86/mm: Fix enc_status_change_finish_noop()")
  (see https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx)

If you want to view the patchset on github, it is here:
https://github.com/dcui/tdx/commits/decui/upstream-tip/master/tdx/v8-x86-tdx-only

Dexuan Cui (2):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()

 arch/x86/coco/tdx/tdx.c           | 86 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 76 insertions(+), 12 deletions(-)

-- 
2.25.1

