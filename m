Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A668C6B9
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBFT0P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBFT0P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:26:15 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59611B304;
        Mon,  6 Feb 2023 11:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F68EadGhDv+KbEELsbim+cQW0fNSQUFFJtbOzraOXFlIOEjs2nQGECJ6JoNiCyJnWtUL93dy7PJQEqSb59xH73lut/rbuHN2PJ5uAgpJ/xYbOel6LEcGQBUYldDbl4fnF9A/tUxcNRybHzTY1cs+P98B6HghzWSeW3yzo58C2EvLvMPNZ6EaH7KcR70gL6Ydx9ArPmSgfYDLxRQIr9KnYn7UPtcVRuVNbaH8AoIAMaFw2vn2f37J6dzj3d5S52cj7LvlSGpHttPWdw0N9+Uw8BqBOErDtAg8plAC21QXihHUjY1dh9vWdIqv4w2xCkWK5fpy2KmLWyRzcUFHGeWgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woqGNcox7yMXTDVmxHkgTiZlV66Sk2NX0Scv0HEvMBo=;
 b=VMGdik+CMhPES7XoOU6YEMSw4BoJJushNH6/0H60m4liG2nxYKQtga15a6YCQrhf4LTWbDddb/IdKa7yvohfOz3R6x+cRmaauxP4bETjm0Jl/oQWmVEl8jWfSPz/92Euvo8MqXE5c/1hH9kpCG1pkUk8vX2At7km/FcGUB5GT0OaR/GWEJ98gxMpzBK9wpp5/s4GYttjsR2QsaoButLFAWAitH1KbWgjoTcr729Zm1Sd6fngN4CtUiRRvOEYa019p5cNWwjCSKXvOn4VhDy3grE7Ol6e/Ib0yhLFdW77lLBeb2/NeIB7oE2sV9LnK0J1wx3Rbh0OEQTNBsQXMV7biw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:11 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:09 +0000
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
Subject: [PATCH v3 0/6] Support TDX guests on Hyper-V
Date:   Mon,  6 Feb 2023 11:24:13 -0800
Message-Id: <20230206192419.24525-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MWH0PFEDFF6182D:EE_
X-MS-Office365-Filtering-Correlation-Id: 432fc0dd-de87-448b-a077-08db0877ff5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSDsRKrW5t+lUpwxFWgVVUDtL4wNNZ9mlhPOTef5Vgy6NH/0UainTVatGp9hqmkvK/oEQmsxJEAgT8tKpooNvh+VbyTc7QFE2rTHOqYbnQCgun9YKLx/GcEGk6DpDyLmHL4YJvlWTFSg3so6crKRIhcUnURnVYH2Y/y+Zt1bHymNeeLU6UAVoj7le+Vaqmkdx9g2ozch794b8StTFrTDAyXVxK3xfNM8f5108HIp3tLgViVnb8WYWYuDtaSvjx9NWW2QHE/tzScYwAxBgAggCcU2nvO5AOW4t7lipoROps8Cx42hJ2xeXCAw8aQJB83ImvBbn9yOOgO5SIt/QSu+KJ0BNug9awWYvm6FXcP6dpR1UiRA9l8e+ZbgX/wKY1OtOgP2UwcKnNFBVIxsJpkwNvaobiSkh+ixM7vEsZQoDIPoKcuJXMc7xcSC3Zr2/onDH3J1Zk/41/82INDGB4GVkegvaVFn8Umg3mCLHRO6scPaA6JfvFkl4NZ83kpgA2/F8zKpN5Y4/BVxlmMbncer6HYiK+DuQ8ZoOklwn06P68BhYSjHbpfyMB2/0E5vt7KBoOvlEAc5DRf3I+dQXxCpAkT7A6//6mcg5KhrpRmQyHfnIa9NCiu/XZKa8bGGkBnOL+1Zcm/bfVx7R02Lou5/DK+X2hRnXpdziETemMINey+x9uyx8O+gegt/8HO5Yi0J1DvF/4ZY8OXOB3ysxwORVvyY8+6hUQsWJWPHd6zRyMVM9HYwd6o+dY75MGoY8m7zq6dLZIkKHGunzfcfwPjYew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(966005)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7z7clnxwEiOaBLgqAYK8dX9Iv+2p8B3vPhoGsSwg9Rebbnb3zF3RYUrerfN?=
 =?us-ascii?Q?mdzdviuCCTZ08BvUIbIrULWcYTPg3g5i2xqKYx5qRReKj4dRntun3A8XvOS5?=
 =?us-ascii?Q?ddRaINxeIFiEDuWH9OhAbAoXb3aAefafvTWhVxa/P5CsV6PjgYxIKFN2GAMv?=
 =?us-ascii?Q?Mun4ynYHmQ8ryfk8u3y11uXZNbqZURCJmJacXt0x0c4e0Xcv5Hy5PhqNYL8M?=
 =?us-ascii?Q?f1RxK8cVjkJ51MYUgeoYwHmwy27ycrXPy9ZEpfZZ+yH0U1mP6nBjGP7msdkl?=
 =?us-ascii?Q?gagRU+RyKiam2CbDoNhBsd0fYEhGWxS+h8XqW5Ovv5sAbPju1KULVwDY9pGt?=
 =?us-ascii?Q?dwDcf8NWNXFr7fwbIUYkuNHDz5y5EcJrfTgFYyaTA3rnAJjLFJAVY0YVwaKk?=
 =?us-ascii?Q?V/pLwfOuwF1QCtYGSQHsXqrCMhFmb+NL3iGg4L1ZeHSneDFUd0nJsR2rbrEI?=
 =?us-ascii?Q?ff8av8vflJZDdGg1Tpcr+gcLTqEI3wrkbS+Wp05aSd8ebmvw6Y5US/ICPgEG?=
 =?us-ascii?Q?4uY+5EME/8LYL/AfOcqPkgrFTb7+d2oBydVT0BSLvQ1mIG6r/BpjWxCUCryn?=
 =?us-ascii?Q?LgBNXJjahpP0u5bKrJKt6vsxJoq0Br+OEyu2LtgPwDkrN5A6ZtI4eX8C1NC/?=
 =?us-ascii?Q?u3x4+2j2jT/ZNDAkrSoS0CQu4MbB1I5Sj/WWSJzlLuvEgXcpMB/VSLaBz8s1?=
 =?us-ascii?Q?2YdZPa4WqLUJWCJhfUb5i2mEafzptaCxDv+iYxtKKd/kuRBevxHZmt4abIdk?=
 =?us-ascii?Q?X6Eot2P483ozaYrtIOabnOvasqELN7ddF4E6dT56Rhml5aJNVyot4GBoUhf1?=
 =?us-ascii?Q?FSA1XwaYXBfoPs9GbUX6R1ZTdMSlzDfQuCTTxApJVFdIS72XjO737Q1opdyY?=
 =?us-ascii?Q?Q2F4WRcDYRm6QbUBcTHK4Vl4OtQFHoBPlMnxWF9A5fTVOlm5loAdFLZKtqCB?=
 =?us-ascii?Q?oBEPAghG8UcOqXNM1jhI2C6yPMcZ3rMLa+JNTgTywL4X5VGJZ5OYr+Ng9PWs?=
 =?us-ascii?Q?SLSXX9CfFni/VWYtb/YiRfVOxHdkCXQzCHpZy265gfQ3v/YHWWuOyGcZ9ZFA?=
 =?us-ascii?Q?A3EuRfU3cpAtTlECuZBaBfWv+vSvMI7g8tD/NYq8dPy/14+zkkgexKjQ4eRg?=
 =?us-ascii?Q?foNOl/P09zP+EHoWuR7ZxEGgvyN5QMTk7sjMThW2i8rBcDw/eHwPUAPNec3X?=
 =?us-ascii?Q?2XgE7fD36reu3UzANN2hiFELBj5g2K+f6XZqyJ7UxYwT3ff5ygBzpPva829c?=
 =?us-ascii?Q?1z1sO1L4qp0hv+HW3IRHUPkd++yPkTaAvA+4IYiopxmwsbbrRwg5CObjeBf3?=
 =?us-ascii?Q?au4x6k2hW+BF4+JfG4lDSUXJ/nc96SmKonPZ1HIVVbAYuzAy29o/g1AcTROl?=
 =?us-ascii?Q?FHOHWH8s767mA+aO++1Rt1F1nxzXuo48rqbTQ/+8pH83eeIivT1Y8YOH4B4C?=
 =?us-ascii?Q?kBoQ1NU1L/PthOFSbLCq34HgK7EghZ5/152b+wcNlp+xMpBkN4+3rVxTu28z?=
 =?us-ascii?Q?vo2XTc63Y6d9+A6Bf3wHJCsfK+SRiDzzatiASiqX4Sxg/BH6C0afPMLBUTFT?=
 =?us-ascii?Q?wh4cBRZ33jTbvxqZnsqBX8rcqDD4kgp62Gmn/mTIry7Ue1LkCSNI2K87Ox0i?=
 =?us-ascii?Q?nlylm8ytwuiihuppLuskL4i00hzkSs3mS8yKBum6kaEo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432fc0dd-de87-448b-a077-08db0877ff5e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:08.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UjYEOJV6cbpkDUnDcIem+DAh3BzN9+c4D8TYDNCxQA3dBim7keGgJiGKtSz48Chmw0l97WLVjIIuuVbyNwlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The patchset adds the Hyper-V specific code so that a TDX guest can run
on Hyper-V. Please review. Thanks!

FYI, v1 and v2 are here:
https://lwn.net/ml/linux-kernel/20221121195151.21812-1-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20221207003325.21503-7-decui@microsoft.com/

This v3 pathset is based on tip.git's x86/tdx branch:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx
(The x86/tdx branch now has Kirill's patch "x86/tdx: Expand __tdx_hypercall() to handle more arguments")

If you want to view the patches on github, it is in this branch:
https://github.com/dcui/tdx/commits/decui/upstream-tip/x86/tdx/2023-0205

This v3 patchset can also apply cleanly to:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

Thanks,
Dexuan

Dexuan Cui (6):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for TDX guests
  Drivers: hv: vmbus: Support TDX guests
  x86/hyperv: Fix serial console interrupts for TDX guests

 arch/x86/coco/tdx/tdx.c            | 113 ++++++++++++++++++++++-------
 arch/x86/hyperv/hv_apic.c          |   6 +-
 arch/x86/hyperv/hv_init.c          |  27 ++++++-
 arch/x86/hyperv/ivm.c              |  28 +++++++
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  20 +++++
 arch/x86/kernel/cpu/mshyperv.c     |  50 ++++++++++++-
 arch/x86/mm/pat/set_memory.c       |   2 +-
 drivers/hv/connection.c            |   4 +-
 drivers/hv/hv.c                    |  62 ++++++++++++++--
 drivers/hv/hv_common.c             |  33 +++++++++
 drivers/hv/ring_buffer.c           |   2 +-
 include/asm-generic/mshyperv.h     |   2 +
 13 files changed, 309 insertions(+), 43 deletions(-)

-- 
2.25.1

