Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB86F796D
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDWyv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjEDWyu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:54:50 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1911B5E;
        Thu,  4 May 2023 15:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJiLVUNvB7F58nHPTL3rXVcD0L2GQxaFtg4ke9eKLs/ZV3y5+W7ZwBYKAkF1eDJIpYB/dB61ORnJrHD9LXfX8KQqgdTp1jBm1YxziBNLXOpK0Pvl81OJGoJ5x0HpLKi3Moo1YedPKHIs0osTb9KlQyB7EvO/kZncZ3yYz7FkIXSZ7ShGUiLdW4eNh3JvJygXptB5FLqYnkN4TwaoOCz7Ldxmy1TwixTPMnZEAcXk2IiBWTOE14HuNYskPSLMxMRwOXFVmMEMhrf9mtG/EXCA2zHtJuAty3OcwwpReP1lW6YEgbI+NL13NVWPm/Od8vyuy2Dlic3aE4PsGJJtjUINPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw+nBMJW2FGZsmlVRwUlUl7zUifBNWeGez9IyxgfnTU=;
 b=LGIUT/I0M7R3bzuhXC9peXzgvQuIHxdgSzrXctxU7gX5dTpsGl/9P47gYU3G5Vbt4ate1ignud/SunFrkAPkE3B8tuG4q2O51gf3O/cr6qvCa0WxCHCPcjUcL+bKnqPGuFQyv1g/mFi+cqkheIDnw2WcAHvfdgTtFCS4mob/WvR0kkMETOEE31Y5SSX3vszhkJ1FPFv3zErpvuGQlBnXj/JuKRdztCMJ6yavt0mX5iZ1xZveT0QgQARp2rEmEh2IcJVFI9NIKHJFNewlOERfwLaqaF9lbg9pSZNJx4mSxb9hw/MkYeE3scJZyIYnBGMcARQ4W/LgnsZyzKApTLNz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw+nBMJW2FGZsmlVRwUlUl7zUifBNWeGez9IyxgfnTU=;
 b=fdsbKNjeX53UmlStS83YyQwd7rCx60KzrflezsSPH6ibFFrWqc7kzsal6JEKopVzV4OZOHHs1z2/QvjkvrLycPooaQqlxruz7iGZpiYA0c2tCWdRBiIRobMaTgTPvib21l2yBVgY11FAkpfqZXyk/NSE7zfO5Vlncg8EULGqe1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:45 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:45 +0000
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
Subject: [PATCH v6 0/6] Support TDX guests on Hyper-V
Date:   Thu,  4 May 2023 15:53:45 -0700
Message-Id: <20230504225351.10765-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:930:d2::10) To SN6PR2101MB1101.namprd21.prod.outlook.com
 (2603:10b6:805:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1101:EE_|SA0PR21MB1883:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c060b0-f649-4bd7-c0ad-08db4cf28e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8M0w+uMRgqYOhgxbYjI05GgHG0xak1v7doxiUcPssxwXoHe5nBX9a4eZcZPwuM3kx8o+nj/GGq5XTfMrCDgvUDZDWuSx91EzuAA9+xrlYsDpGy3w6CZjvonygc2ZX7iLj4xQPxxXMaXSOYjraLgFISLRUGfMLpCZ3FTH4wgIJoRmAlEy0OxXbND4mdD/rfb1VSabflUuAVaSlPE5B5nX8BeUI14MqgMarRYCjdv0JQncmbdEcoEJ5jslyh+jT0mQuXeWYlOO/sobQFXzQuS+5+IXE5/CY0DE3gr2vHwHis2jfl6GMfNorCIEb0toqbLVKnT+uTEo2a8H1ADbLM6m7PpYlOY/nkU2RqrPm2ZUjcnbkylyHRpaA7NMDAHMMoC+gNVkdQvxDD2QH4dIZc4kMpp3qJ5wuj0B4T/RtKMQ+LZijcVPdrD2WUOs8DzRcZ0LPGboQX8hifxmlMoFGn9Ktau5UDX0l0czlat45rhu877/aDa8lRk+zqrYT1guFKRah+l7sMVLmq3Ro2zL7Z2QBZahOTtWalkE359ohNPae1WlOM6cEJ4a5+nSDFXsKvPx+EyKSWmsF9mK04X3/ubD1jiIhU5Y8+z76lifFC5DKB6CaV4ucuatMuQWxKaQuPFB3+hTmBJX6lzLVYYQi/HtTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(966005)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sYLAUv9SpsmmLeAk6Ec4X+0M33m5M2SXRef7vGUSrcxNYtMyejs+J5kgXGN?=
 =?us-ascii?Q?i5OEcmmzgTQp+zsa26rWRophYsglRmhUdStKoiYw3lw8OcO5BYGrP4zRZfi2?=
 =?us-ascii?Q?SA7OzXTVRKwdz0wuU4eop/EoB4X7v5KS9ooN5+k8XLj3TCZpPRba5fyk3WMD?=
 =?us-ascii?Q?nMvSpcNWemO6OjjMPo2Be3R3o48sifvROQcKwtAhG82a3YFXmuFvkOZjnwQM?=
 =?us-ascii?Q?kQhNBR/RgMR8/WHvB4TCodzsZZ5Kei1KOkDeFEgz3a/GqLcbhxuWWjukV0MN?=
 =?us-ascii?Q?9JZTSGYQIXj4GOgsNDmRg9wY1WBfiKm/o8es3jn9RDcf4hIc3E6W3Ptm6pdh?=
 =?us-ascii?Q?A5a0470i5QwfvYnaoLoErd2ly7MlALy0mzYOGtvGTO80iPPTb0YYAsWnHSm5?=
 =?us-ascii?Q?eOtoXpXhm40HsulGApxGnATryrVGocgTsWYkLhjE6ZJcKfh/CsuZXqJ7k3OU?=
 =?us-ascii?Q?Nmcyp66x7tyWxgLvzrAn3rAxqG0QOnSKxUq6qVSwgU95OMdwD4LUK1SHXiv9?=
 =?us-ascii?Q?W/DkVgeQmmqvGKIWOAj6IaAztxks2TBKxyA+afusPbh7flPM803HqLPfQO8Y?=
 =?us-ascii?Q?8QSgAuxqUNidXSiCWHYJLXm9KSW0Zp1UQofDpWxIlsHWULkTq9rAjEVlzygM?=
 =?us-ascii?Q?o7bLRaOn6Kh6N1S/47CI+C+pSD9dcFr/VHkxvmVAoELcC9EWd8qeAzOt8L+w?=
 =?us-ascii?Q?D2Fe5qJxThZY2AgXRA7OQ/sqbu1q+h5A+vDzUhzacoY2L5H9iXpFFiEsFMaB?=
 =?us-ascii?Q?j2kl5pQ24hf1a9rF3s2eQpH8F+njVeV8BmvDDd2gWN7oN3VxQmPWX47db0n6?=
 =?us-ascii?Q?y38fHitLgFm9wJumctAkAQWgyaK0qbJPp5PUFvhvtBGZ4y/PDwLrpYs5TlLL?=
 =?us-ascii?Q?Fiu9VGmSirq3W1cCfjUo0oMW1JS5McFckjEPrZ2yae2mkC6nmWrstj2zl62D?=
 =?us-ascii?Q?sAptz2GfWlOUFvDGorxrBumV2/RS3BucWm4jPgEVn1CJMvkjnJokKp+u9vyE?=
 =?us-ascii?Q?4O3syEGPwqZby66xG9vLojM8W2hyvBAsbtzPtWGbmLM21iyBDFv+gPp/x+6V?=
 =?us-ascii?Q?KY0DT2A6cDdv4WaTgXKyI9DANrHieRx2/pbIjUta3Fib0/fM9s0IKE81Yndj?=
 =?us-ascii?Q?lKFWzU+V55u1UjXscWUhxXFG5f6g2vzzoW5hZe6Ni8LmM/HI5Cku0AgqtDbn?=
 =?us-ascii?Q?5fJ13PuOEj4o8KcSUxGa0Yy32Ax6qDCIZRl79aOa3/UDO3iCFkcSaTyX8Ql/?=
 =?us-ascii?Q?ACvDKbg05E3+KWYQMIh2gLqgQVosEtUiCOOAFoKhnA1rtH3OJ72j7G/hBkd1?=
 =?us-ascii?Q?QOA4v2+QcgSJWmNhXg4N+jEuJ7bVBCNDZE/WX233WZGTo1+NINCc0AxgO+Db?=
 =?us-ascii?Q?427uYbiRiK7WAsl1sX6zg0Wj2DlUFmx7/qu4L3qTpNC6UDOcjWugHTQswoCB?=
 =?us-ascii?Q?f9t3Ie3XFP8L6fPys7vWjTxqtniMPW3buYx77ozzHkZ9ZK/nj5AHI3ZkoMHR?=
 =?us-ascii?Q?5Jo/W1b2nR590L+ZJiHgLWCWByf5+31rQ9yr6kM5VbQk/GqsZbwijN4yqt+u?=
 =?us-ascii?Q?Xf2Fck5nyj5nYwSYYeu1oN3Q4wjb7edXv7cJMyWxuo9K/inVJAzNrdKi+YHv?=
 =?us-ascii?Q?LWVPxX+0wVNvbA5GnLGLtiRGXIVOPGEuU9aw+287lSJH?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c060b0-f649-4bd7-c0ad-08db4cf28e25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:45.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MhiBIIwpyKvLA7K67XYKoNjxNXe2jWXZueR5nT0KflcyBMR6tbPRgAP12C++rYp00NyhkZG7aVBa1eYjFcm3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1883
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The patchset adds the Hyper-V specific code so that a TDX guest can run
on Hyper-V. Please review.

The v6 patchset is based on today's mainline (a1fd058b07d5).

The v6 patchset addressed Michael's comments on patch 5:
  Removed 2 unnecessary lines of messages from the commit log.
  Fixed the error handling path for hv_synic_alloc()/free().
  Printed the 'ret' in hv_synic_alloc()/free().

@Michael Kelley: Can you please review patch 5?

@x86 maintainers:
  If the patches look good to you, can you please take patch 1 and 2
into the tip tree?
  
@Wei Liu: I think patch 3, 4, 5, 6 should go through the Hyper-V tree
since they change the Hyper-V code.

If you want to view the patches on github, it is here:
https://github.com/dcui/tdx/commits/decui/mainline/v6

FYI, v1-v5 are here:
https://lwn.net/ml/linux-kernel/20221121195151.21812-1-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20221207003325.21503-7-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230206192419.24525-1-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230408204759.14902-6-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230422021735.27698-1-decui@microsoft.com/

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
 drivers/hv/hv.c                    |  65 ++++++++++++++-
 drivers/hv/hv_common.c             |  30 +++++++
 include/asm-generic/mshyperv.h     |   1 +
 10 files changed, 300 insertions(+), 37 deletions(-)

-- 
2.25.1

