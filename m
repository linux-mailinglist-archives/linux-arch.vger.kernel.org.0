Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E56EF8B7
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjDZQul (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjDZQuj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 12:50:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1BA3599;
        Wed, 26 Apr 2023 09:50:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QEi8xp000962;
        Wed, 26 Apr 2023 16:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OJ9ZwvA5PtO1fy3J0kwyv9tvqOsMb74PvRDYnKl2qJg=;
 b=NOeNjmm3noKiHg2mIyNfkqvkdMVBLlnz7prltBOJoZ14OJfSbIrVZwzg3exkXYY+3SV2
 ET3nStFlKclNyP6D6xeLfzopzZ/vtiuMyknDFMT+CKxVc0yPARRCMIhxtXHGgBeUaJku
 k1ZrMg5bP4Ch6KLY3GP9eE+oGYkiSRYpHV/a7wPAPEB1YgNPETsMgftSqn6AXNKcRjBQ
 fJLC0W8Wi3SbpYoDXDFw6A9U57N+Obzjpilb6Pw59rqra6KF9Cb7g5nl4FfRRixbGV4/
 aDZ3wMzJKlmbdTFxYX+iONgwSpnyCP1tbjpRKXf0c+X2MseMmGiSPxkfBxsLHeYynnKJ LQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u1w43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFfqVK032877;
        Wed, 26 Apr 2023 16:50:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618dqt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxStjJitZtEWZ7vqvnCJwks/1QMQah/zW0iwx50krSECCiq0FLD4i/Jb9Ltk7Wt8gVtDwqcIYRqtOnK7/xk3/kWQbFKckjErdCuM3mEiVF+mNXMFObx7kr9ExXvMgvxkQld5t5grUiK1zP6yLK27IXB0SsMQyLa8boeZYEyGzjPJ5F92DLj/Ah6Gf8yLNPURxRBu0KErOgIp7KHnH086ufEcrtsg0TyI5ROOwH4GxO9kbVIkTmxs9q4ka5Tydf3pJaa33tGlt1KRz2r3sqQCMhEvWCynsId9G71qn/rUxx+t2oed/ABIjRhEbD/0U1RLMx3Dw0ZzNHmB/N7UZdEiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ9ZwvA5PtO1fy3J0kwyv9tvqOsMb74PvRDYnKl2qJg=;
 b=e7TiXZpaz+o5uwR3zQtGO+G5WhFiDKUxLDaxAyUja6ysAmNXbjKJBpampXaeMY611OUf49PtoWteQsW+sYgCHm0yKUqQOZ8bTns6ho90zcAm0zl4Hh0eVWQCfzZJoAmb0Fuk1Gbh98qz8H52n2ib6UgdoboB6a1Hty82t7EN5ZKkXV+ThHRzzDKRq1fZEHTHizKv1UwDdsZn+GG2kAGPjjwPeAotPhtU2nFrU3WfrBsti+ALmQEWgC3TihVqAIRM8IB3FT4O54TFD08zyMvDMI77+TUhPNHMZGDixvg6lNsoQh5RE2alQBl5lTwZvnY1I0FaMsbkObl0lsUmacEyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ9ZwvA5PtO1fy3J0kwyv9tvqOsMb74PvRDYnKl2qJg=;
 b=SmCF9REhgv3AxmaWAPQFSpoxdn87sjxRQ0YGyWNqnyce6j8sLTm9hua3wyo/JOml+7y2pvSYaRBUlWA4UElvtTpJQWs5+UJUzYPwdDRgebqXuY2SNH+jfdtPU7eTVNSGn2jLRm1RT9rXaTd6uxpFkjwrLX0xd/M8u/0EaaZEhZU=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:49:59 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 16:49:59 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: [PATCH RFC v2 2/4] mm/ptshare: Add flag MAP_SHARED_PT to mmap()
Date:   Wed, 26 Apr 2023 10:49:49 -0600
Message-Id: <63bb4b1339bbdf33c3412cdd097af61285162cf5.1682453344.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: d344b039-bfd0-4417-32f9-08db46764597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJCYNoxMgdeqrl226oIjM/3CfFsifcD0oyIqoEF6CfIEzIOOGtMQ97HGjUWvp6pVG+CLNY36eh0H1oHOp3bPcErdgMCKz86RnK3is1SJSLVwr3ag9/njVidM/1+unSkWNnmKnpj4/gJQUXMxkrl9wGlP14Hs9gEvJ4k86sNpMcBX4CpjcuntK3YgoAGBNVyLwoiKP3Ne8NjL3nafnOUab1y/vKU8aSEPlyaBfOUKfznlRcaEQImDIbL1u5Py9KAprC1vtImOIFcXZ5ImYr17kcOc9l16t95w3PJzx4gVsa8qDfAKJLjb8x3Dh1KlxRX6jfbNF0Ivm24JACzbbIOyJmwLl/AeprM93LQuMj7SNZXhvtllwnu0olESqFk1yKDTBnaVpcxsDrP9T0s41iGzjRHsxWlbMcxS5qOE1FF8tk26rG/00arXuWQSrZkcB1wvsQDC9v2SC8Fk4CZDi0jKE3efs0sFteemA5hfDqBTuhKggOZokbCvm/GXzTL9Zmbxr1AmC2C/tmnZowKUdmyWnNlcA46NZNuaXxou3Tou+l+TwWFLzLJjx84+hUdO8rZz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6666004)(478600001)(83380400001)(2616005)(6506007)(186003)(36756003)(26005)(6512007)(38100700002)(86362001)(6486002)(41300700001)(316002)(66556008)(66946007)(66476007)(7416002)(4326008)(6636002)(2906002)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7fhQWd5L4g/dMwRjKdajA70xo0yZNHkd/fHE8p3SLLdRpXmZJUH+LtOSgBf?=
 =?us-ascii?Q?L+AlKtNxuWWytckH5uQZRzCwNl5+E0VfTsWECJUk4pLpIOwPsOGKAjCyE1gV?=
 =?us-ascii?Q?tSeSAHxtVin4Qn4twoXrIodIEKD4KVYK3WJjnCZprzmcCGE11yS90HjDgFo+?=
 =?us-ascii?Q?G9oZDAJvmfDH6XuRluh9x6WTlQVlRRi1/TlEVHYQyXOGsip7LvAriitOai4P?=
 =?us-ascii?Q?BYtWx59Kslk1E/4JFqbkrlI0eJVnsTX5Fxgn/uxXrmEB07QPGoKCY+CxHeN4?=
 =?us-ascii?Q?L0CJ4ftvbw2fp989vEY/ESQ0zEfLd0iEq76rEuC6gvB6apObHedH8DR8DtnM?=
 =?us-ascii?Q?THy7kjhVOKhQHsvMkESR2eUcJsyfUMNm12JrP8mHxrXdLEBJe1z+tXMMFcRq?=
 =?us-ascii?Q?fGe17868JHnJg/Ls1ipXkk2e6HkSt8cGqwefSokTmALdXYNg/9iGwyeKysH5?=
 =?us-ascii?Q?XckVYZXdCmPFQgEEcjMTbgOkfL/nR/ZClrrm1zEkX9R5Iohe3JDgQ0tCOZKv?=
 =?us-ascii?Q?MPEiJZ7yrUbnCLQqU1tWHgPzeGCmBgff3gAJi+lKj6m7FDcacYdaIU3UfaSB?=
 =?us-ascii?Q?P9RKwx+TO5mUP+fhrF2XLqvXulkkLgUhf1xXvW7VKBgd9fMZR7h/CoxTNPMd?=
 =?us-ascii?Q?kTMmbsSrToYs9MsKYC3+zRLMaZi+rxag6MQXJgACzgPPMscVR9Dqz+8ie95k?=
 =?us-ascii?Q?c8cs7YY+ZoJgn0x46MoDYAyVW3yAXF/4F06I1I9o1XjZCAoDlkMzBfTgmBkP?=
 =?us-ascii?Q?P4/m0oEY7j2GC0JtFkibab0XcHqPfRLsjTzJ3e9ICcZfKl/iEJbWZq7KgxWR?=
 =?us-ascii?Q?46YEEeSKyij0J2LDifsS3g4IqITB2n7Oll9VaHVFK21TcyBaEZPvpmtyRveD?=
 =?us-ascii?Q?oY+mGyQJVgekSx1ABkDdqcrlz/2tGoKpozGlrpETsqjaV5kYugucaU4+Urey?=
 =?us-ascii?Q?f/2xvy895ElrwGcMsccnQrldBWLi6mid3xCmKgcIu2P9Lu/2R4cBZ2BgDUqh?=
 =?us-ascii?Q?Nq/I8d5ozeysH20F0wi+k3VfT3kiqRfv6AlKFSE6v1u2qcTHorXTFZ5s1b6e?=
 =?us-ascii?Q?DyoSB0hUsVzu8gph+rT6YlyqXM9iBS5lebK1XIACiNIsbwNA8oS2l0fKV0pG?=
 =?us-ascii?Q?hEZJznlePAkqmGSXUR4egioWnLJmxDhz0hognGJ3sChCjrMw0jZjgoN4dWF7?=
 =?us-ascii?Q?d1yvYlaEqKfpJgqJgG9EN91FvJQ91zHc2JOmdBYfZJRPRZzslk49Eo+rGNwl?=
 =?us-ascii?Q?pEc0NUJbvDbFR+JLh9VxNWpCDAZXNx1smGqXeroU20BW6m75zVz1KTeQLhBh?=
 =?us-ascii?Q?NQ0ycx8o1UfHdXGcOJSjacWYACUW6fp+TnE/Au11YA+IQ1IhTHu5lTvMY403?=
 =?us-ascii?Q?XdcX02nBrvCuapICAdfx8FaqvuJWJOrd8PfdBdq4HKFU1Aln+lN9G3JRfwjQ?=
 =?us-ascii?Q?aaDsPFbrh1O9e3RWSP0FUq5LsXgHDWWB+USKIofr0oOOvzt7ISQi80w7K0Sc?=
 =?us-ascii?Q?IT/xG8VpUIid/qFO+Qio9cw74UIDDn9F1MYG8fL/rxdY1urHgezGz/dHmK0y?=
 =?us-ascii?Q?w7+Vh3J6iS6ogcYrVTkQ1LFqDD+FG0P3rDDvUL0n?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zLhsajRtCeyDrC/cukJpxWH4tPFImN4+nuRTkuxjKC2uawWChywPcX+GZbrt?=
 =?us-ascii?Q?gIybXxGdNWAtYKzWjqPYnQMNzn+GSN6BI7q9N7S82HcwHV4HA7n1RswNXWNZ?=
 =?us-ascii?Q?10Ir6G8VKVk0AhxVo8nuw6Px07Vqllcmm1vrjWOblejBqd05zfinZDkw5pw7?=
 =?us-ascii?Q?kFBkr/U/qhbpXc+XsXq16zGVnkRFmIbw2Ag/AyXTfuZBhNpfL2YIVWC2+qVt?=
 =?us-ascii?Q?F4DgSdeCuzhg4BFMpBkWqIyahoSGUlJm0WAxnK05akiJZBRvC/ouj3ZLXNDw?=
 =?us-ascii?Q?v3f/qmaPyGBSc7GgbteDYligqYRIj25+oSdzMwZX4enPUHcrRJKnsw4QfaZ4?=
 =?us-ascii?Q?wtQcvHEAqduHudm6SsR4Yga6MkyEXIbGIaVDGv73Ylt73GM7rCRxpoHiwy2x?=
 =?us-ascii?Q?PauZNVkvVxDQ8WVuYuhzCQIzQbpv6t07CbpMFpTzu8NXJm6Wl4dbBycVtEAm?=
 =?us-ascii?Q?zadMQzxABWihY33GioUaoQ96h8AMzdN8B0O97oaWBw99nv23jSLd00q3zpEZ?=
 =?us-ascii?Q?Z2z3CeHmGajUyZe4revI9CW7MmdzAYGxaVSuKlXfjdifV8VjQXYd+KqbRaNN?=
 =?us-ascii?Q?R/s9+Om/hdsktfY3f+Pf4FOr52dsJPvsN//rlxxVkzLLpkcqUrvbkdHo0oSU?=
 =?us-ascii?Q?LAiu4UD1uDkBvy9TLTGyaUMRjjWCfVrAPRw4wT9rALz7IoRuLzTZKsAqYMbb?=
 =?us-ascii?Q?28MYVf3Jlcaq4VKHAfM93Mb/Q8Rs+SrDI9DkUZUdO61N9r0Zz/vVVJWQD4a0?=
 =?us-ascii?Q?XQhcyrs+aT3O4lleK4jnoXYSO4cvUdLi3vE7Djm4rvpkeW2XQwa+lNKZljF5?=
 =?us-ascii?Q?LqnRxDM4xGL6WGR/w8FxtSz8mkG//6g1+0aL9MLBHSHz6JI4/Qi211OJw7C1?=
 =?us-ascii?Q?HEm0cgWfqYjaNyczHW1AGhxf8x8/3Zl4JFqDQAROIH8B3FSokY1hFzM4j2kt?=
 =?us-ascii?Q?utGoAakfG0RTD3eNkbI8TAiZ0eApfzaorCRuyCPvE1Ds3LzwRviouxqDwZBf?=
 =?us-ascii?Q?Mfidx69/wiZ6XzQbuanJ5el3KG85Qg+YkqmQvqpEAiQ3ANzH9XznWHODieOI?=
 =?us-ascii?Q?emewPxsdp+Jwbah7KHqO9YDNA8g4ljMHNl/mTzETIVgyV1Aq/YEXd7Vdtt0w?=
 =?us-ascii?Q?upGP9IbWU+LIxqsEC3GO4sEtzcEfkKs9IfOH7POfxc04Bhqmume1QQoqWNRW?=
 =?us-ascii?Q?y0DZwnp8z1q57gQr0HoRzV65HpvSbknuJ8SWE3Nj9DDZLjzMNV5WQiWbeLhH?=
 =?us-ascii?Q?xpwSOlCbG/1IyzvlNw9KHyDpR1eR/DhFu0hmCg9m2Lj6d2knguy0Jx0l/oVQ?=
 =?us-ascii?Q?vU0rB1GrPQGAPsAnF4sry8p1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d344b039-bfd0-4417-32f9-08db46764597
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:49:59.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ7+BVmdzx0XFmbmReFFK8ubCnkHhTi8lCWO3bNBucqL8ty50gAvS8IooMurDSoq/iVwroBMRcnICPt/+3nNFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=979 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260148
X-Proofpoint-GUID: hQ_Kqw1tXKwKFNpr5WQq20G9YbuOEO6_
X-Proofpoint-ORIG-GUID: hQ_Kqw1tXKwKFNpr5WQq20G9YbuOEO6_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a process mmaps a file with MAP_SHARED flag, it is possible
that any other processes mmaping the same file with MAP_SHARED
flag with same permissions could share the page table entries as
well instead of creating duplicate entries. This patch introduces a
new flag MAP_SHARED_PT for mmap() which a process can use to hint
that it can share page tables with other processes using the same
mapping.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  1 +
 mm/mmap.c                              | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..4d23456b5915 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,7 @@
 #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_SHARED_PT		0x200000	/* Shared page table mappings */
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
diff --git a/mm/mmap.c b/mm/mmap.c
index d5475fbf5729..8b46d465f8d4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1197,6 +1197,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	vm_flags_t vm_flags;
 	int pkey = 0;
+	int ptshare = 0;
 
 	validate_mm(mm);
 	*populate = 0;
@@ -1234,6 +1235,21 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/*
+	 * If MAP_SHARED_PT is set, MAP_SHARED or MAP_SHARED_VALIDATE must
+	 * be set as well
+	 */
+	if (flags & MAP_SHARED_PT) {
+#if VM_SHARED_PT
+		if (flags & (MAP_SHARED | MAP_SHARED_VALIDATE))
+			ptshare = 1;
+		else
+			return -EINVAL;
+#else
+		return -EINVAL;
+#endif
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
-- 
2.37.2

