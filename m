Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260AA73264D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 06:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjFPErX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 00:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFPErV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 00:47:21 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10302D5E;
        Thu, 15 Jun 2023 21:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad0+dSiv1VVmKXjRPRWfkdC14jwUh4k4WPVnoBGcRSryiAyfvkGXMzIRTkYJC0V1jcQC9YcRk+AyFRdOJQLt44uXdAV8s51thdHGGdPlLiwFWiY4vTA2mgBFZ2Cn/zEQ0wVxReZdzvebciNAQT8YMTQbJ0suOGxpCprJmxKumUMPWEPx5u/kjsFgr3gkngEGLlXGIPQdFKv0yGlIk4jz4BJijJfYziF865RxWntcGBVc+S6YhzZYp9gb743ekAwy/BslpK3aK8dZpoetPUgh/omu2vbt4Rad9WSAOuR3zuIBRtHANP3cHHTjHOJC9T+qMYa4JdCxKZS6v8fznt++1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FJtVvhGJt2xoc6RZEuOxdP7jQpu0jTrbmfu9ob3wd8=;
 b=K8LkcG8GnCGfI8PFvK5hl/0sAWglArp+L0tIUMcYQw2JqNQawg3+GVj3qVVB1qfNMEaIY8y/Km7sE1DQzQs88S/OlZ5k/DZWGoeEOYxG0PtY00h6OLSxUqN3Whm7o8h48+iaSnClOPt1z+im5yfUZozqwNprx0G3GjTDZn4BYt5pnQsS9yUNPL+WJIAkKD5jeJAZt9xubzmHRc+/hqlE0uvSakBhBo8yUEHrJbEefhEdbpkRKXSwd/3pEmi0LwMK68M3OuA5/UXlCZ1gvzzq82VejUnu97y0zWuq4a3vgwttLp6btA+upV+1GcFoc2sm0wKSBDluxREtYGCFP+VM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FJtVvhGJt2xoc6RZEuOxdP7jQpu0jTrbmfu9ob3wd8=;
 b=Ox1YsBGDbsCZEyAnBnxiR3j9qTtIuBLriLtVJOkw2Luu4DUEp19s7hE10peQ8Vs7HJtl+7fns2CB7TAPevqQCVz31FN9VFTUV6sa4ikg1W9PuWlZp7p7NvMQfG16p+GBxS5+iuXbBOuELEWTS9hNtni1advZirwo2oY7jjOECoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by LV2PR21MB3158.namprd21.prod.outlook.com
 (2603:10b6:408:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.6; Fri, 16 Jun
 2023 04:47:17 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6521.013; Fri, 16 Jun 2023
 04:47:16 +0000
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
Subject: [PATCH v7 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Date:   Thu, 15 Jun 2023 21:46:59 -0700
Message-Id: <20230616044701.15888-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|LV2PR21MB3158:EE_
X-MS-Office365-Filtering-Correlation-Id: c797f395-51ea-45ef-7daa-08db6e24c133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7JTwulsxyuK9zThY3L+aGa8D38+q2rSPtY6j9wGi6xM3VJOJFSPdY+/WYUNaLU28RL05zoRBvqVWCabKN/2+8j5g0X7fX1Hr1HMRUnTL7xW3+OWEHQ/5Q7/dVMQhpmPIKiQgPOmMbq8lfPON8vPBwH/E5Qr7uZW1jxILqmeTgiyzCcSwaxiakPpU0SgvBvsLxS9/jVICcLSc52sNyKqed2BEWk+s4pqotELNuWe3zzu51POZMESAlfMea/93hRm2x4tIBDiZkS4ajlVxI1zeRykJDVR2WYLVrjKybq9ZWSgeHK4VUt7j8VybLYxXt4NzRQgdQbnh0oJLCIsnfS1/nn37isUsqrKZITKeIQEM1az3QqGlp0JCLbDbVBoybWa45FRUS1dEwLziJvgu5/P6mq9bZ3JWmW8sT6m/ttMeqMo5pHMirSnWg4dPTKWYAIOljGD3ERQKYfIHTsSaIibGTap357nSdgT82mm7GSItlDs/J0mjc1AcWUWs2ewHiWsKmGqIYOto2osbGcmA3Sh5pA+48yKGl+7UtPlKNlhO+oMXXnM4Bnho++sBjYEYsdvjSsJgT9oFmZtqGu5gfFwDC64yPFQgV8ygdfe0jfQhJGywQtKqFCzn80OQGbYf2Z4Op28XPAchjq4i8iwkOiXsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(921005)(38100700002)(82960400001)(82950400001)(10290500003)(66476007)(478600001)(66556008)(66946007)(6666004)(86362001)(36756003)(1076003)(6486002)(966005)(52116002)(186003)(6512007)(107886003)(6506007)(316002)(4326008)(8676002)(2906002)(7416002)(6636002)(8936002)(5660300002)(83380400001)(2616005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4NgmjdZcAPRku5BPki7tyU80E102kn+rshOpB6xdpndINxUpk19F5eRI2iUA?=
 =?us-ascii?Q?z4SvPfwgbpqg+P2ETB+shjNcrR6EvQFRilZuh/M71GffbsQRuN2IIAYrdPBC?=
 =?us-ascii?Q?aRS5Jc91aUg9ybWWQGAbArp0lOJ2LD91GzuGF1RenoNkDK5o5z6Jjul9IHah?=
 =?us-ascii?Q?pIIDXSz2CK2ViBFMWl6jDUaHxcqUvil+e+iOV2Hc91lrBODErRC45AeDQj5B?=
 =?us-ascii?Q?DL0wi0I3O9XyLrMnugX7tbeBCnHA3Xpb2wIQL51JRHr36kNbAWG1DyIyGveM?=
 =?us-ascii?Q?+zyb/2ugW+zcsNw8jncC/a1siHATeo74ll0P40FuP1sOwMW+0kINqfhXd4sk?=
 =?us-ascii?Q?gKCwYUTR02AYPsxxRu2uWg5uXj63/u/g3l5D2rBaP4m40geAi7wyyY4d43JQ?=
 =?us-ascii?Q?SjmgSUjYgOJb9AVk7y+JG8iWH2A4lhFD2gRb3RNkjGNyiRHogkTXQWbyUV/X?=
 =?us-ascii?Q?AmWVKAWpD2k4O4EyHYawbOO7xAPbLJk6mUwbAqtTQ0V6aKqNkQuO2Wui9o+4?=
 =?us-ascii?Q?gCxfPctvxU+jyJ5BEDOPEzLozZzmHAMcg8P4ehNuTCJZTRmEp/5lE8oiFdgS?=
 =?us-ascii?Q?cXQcsRtC956LanG+dU2X0bgzFYn1hDgbq1voHtpVcGbTNKahtsimbqdiS+7C?=
 =?us-ascii?Q?g4QR9F+qrvuctF9gUQ0sFfhAG64jSdmPeWHM0IObE2e+8Bo3Cmgj3QkCEpbP?=
 =?us-ascii?Q?W6HjN4svxK59oMFqlPRSVIC+0xMveJsrL69TlqiRXr3lWaG6IOjkKLsbdpAt?=
 =?us-ascii?Q?oHAXnbvJMtrQnP/koiJm7NOwT6T1MU2rPR0q7vruVp36F3vTRgPJIPs7btPQ?=
 =?us-ascii?Q?l2yEDE4i8Al9lCjUAo+XGWehdt3RiNkG8kwCklwO5OLAlnlRblsc1KIIsYWz?=
 =?us-ascii?Q?FaE3BZeYFDm/9hjr3vI6svNXtweBV5eu7bp7ZZo+NzrzmATkWKH66wsOaT9k?=
 =?us-ascii?Q?IUNzJIIVzanJSEZir7aaB+oZ9U96ctjJLNfGety9ZDh5a6VRqN8syH+/NObc?=
 =?us-ascii?Q?c8ZLMMuoaQFAi+tvCR8OUY2Br9VWtttzXRwCBOxbw4wDTRCSrRC//vR9di6V?=
 =?us-ascii?Q?iEOshnLQNk4ENvC5dgkoKE2LeRF7hVrasMtaXMejmz9eMFzpZfkQPjIZmmZQ?=
 =?us-ascii?Q?LDNLUf/rajIFNwAbC8yxNXOSPBoWuoiGpd4O1bSyr0HrPV7KnhwEIb6eJB/U?=
 =?us-ascii?Q?Ul3j1OeeOTDVL/cIzBKZhScovuekNXfoZwTWQtKbCU8nY/tUig6usa3F5T6n?=
 =?us-ascii?Q?41+c853nrAE0BMgJSW3qa1PmNPCsYcsvzpByT7NLNMZbh/mrDVNPk0OpAnlU?=
 =?us-ascii?Q?bJ9kkK2OwSPNcUctvQfzLeE4hRWn5vALH5yJk6xgOyYsXnWS+m8aFFf9JGxT?=
 =?us-ascii?Q?uB+LOgZRbsqHfyVfEE+H1vERlmwmga6JM+sdNUY53jOtmBitdK4jRAxrUGIJ?=
 =?us-ascii?Q?l9Euih7yBVfpADAnWVztCUc0qKPurZwYyVlf5zcbOJuIAd4FdxU+2wgmfmZ1?=
 =?us-ascii?Q?udm/VHRTq+C3ZerNZPv0CZ9zhiMK2sB/Ljse+bSCMxXr1ndnkDD7VyeE3ZBl?=
 =?us-ascii?Q?CMFHRgEOO10ZEfr6UUXa87xc/DumWMmZuBQwyvtOyZ2SzbpGeydBWi3Qpgz5?=
 =?us-ascii?Q?/ZbNy5wD33lq+YAZtHMse1/rqsn2vrVj0oQpLbEyOBer?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c797f395-51ea-45ef-7daa-08db6e24c133
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 04:47:15.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heGWeA6ghmevfMOlp77kpwxZFA/CVigy3/VOGasi6KPSpfmmc2reDaQZ8njRGEF4Mzc4Jh4WM2uqIL6NYWKBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3158
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

The two patches (which are based on the latest x86/tdx branch in the tip
tree) are the x86/tdx part of the v6 patchset:
https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/

The other patches of the v6 patchset needs more changes in preparation for
the upcoming paravisor support, so let me post the x86/tdx part first.

This v7 patchset addressed Dave's comments on patch 1:
see https://lwn.net/ml/linux-kernel/SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com/

Patch 2 is just a repost. There was a race between set_memory_encrypted()
and load_unaligned_zeropad(), which has been fixed by the 3 patches of
Kirill in the x86/tdx branch of the tip tree:
  3f6819dd192e ("x86/mm: Allow guest.enc_status_change_prepare() to fail")
  195edce08b63 ("x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()")
  94142c9d1bdf ("x86/mm: Fix enc_status_change_finish_noop()")
  (see https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx)

If you want to view the patchset on github, it is here:
https://github.com/dcui/tdx/commits/decui/upstream-tip/x86/tdx/v7

Thanks,
Dexuan

Dexuan Cui (2):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()

 arch/x86/coco/tdx/tdx.c | 123 +++++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 27 deletions(-)

-- 
2.25.1

