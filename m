Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AA6EFC70
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjDZV2z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 17:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjDZV2y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 17:28:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683253C28;
        Wed, 26 Apr 2023 14:28:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGwqi4017120;
        Wed, 26 Apr 2023 21:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RFV7woIek143czbYOKmtP+rmtHt1yjz1eE8jFYXeQ1Y=;
 b=YcFDjx+3c3dRGhBb2ED035gYic9IDk56YdzLcHv/z6YrjKIMr5aTM6NSYLVrbxtkou9s
 PbT/vpg0cWP51CY3yH2BHpkNICVH2hG9f8QkBjxwZrOZZOleuhmMWbdXEO1K1c2ziZOg
 E4P3MuZWLg6IdryBFAbIn+6M5+INhqqWhqHs0RnyEQo6avTQP6Vm+GICVqS9nB5KaYSG
 fVyFbZW5wdT7ZBhNDulVA+e/pix1NNi/UwDoemcbTcDn2ZYbddok0JouJ2A/wKRPdWvC
 NhClUDOihtJrpu5BGHUiZEcF1mc9PO1Xys6Anzuqrn3//yPO1fxz07XLaOswuDPeB5v0 Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c4akg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 21:27:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QJVwil025226;
        Wed, 26 Apr 2023 21:27:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461es9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 21:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIOBYeJ36vPOg4B2+L5T6/eICxAJddCRyEhWbY/WPy6hKOYjwb+7xsRSGOtjMvoz4JWtUzDV+R90rPCBbNSwJRZE7COyIZbZr4rADggHFPGksxFZoplFhnHaodAt2u1c5kKORDMJvALoKbwYw9vvy0gEUnTzLLzMzKqsHOzmJp/cvwQ4WwRhS6lQDca+ml1I9ag8HROg1Ze37lD1D4ruayd8O/XRZ49X40UemwQ56vgfQPYkTikRtaM+HcfG0Vr7xEkATLDrif++Algd0XqpcUGZiLAwwb7gGEIC+iSEC+ZPWIQKcFzl82NL4llDfhtGzHAR2KdRtzTUhabhjI941A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFV7woIek143czbYOKmtP+rmtHt1yjz1eE8jFYXeQ1Y=;
 b=YKfwhVTE24uaOGmP+5XfaddYc1qXYDp7EaoQRo9NWxRxMNCpOO25lTCugddRdQVziv7H97kmbhHADGEtsDeQDezzsA34PCPF/Akfhq1zcc8HqOPjG6GerLqmbTg1oDHYwKOKwphCPGpHCBPbMOzsUKuabH/fQCvYUVYISNc0VTafDI3kViS8to158pccirg4E2XjTZa+qF0G7hP2HXImkau5jBIrhLDmQB/WtMTH59cOJMFKyt/ndLYELseW9hUpbxrEPyOAuFV2OONpGfnVGWeIJGq8c4FqEdboZHljvD3xUkxTKJwjvNEkrmTxk0Pgf9+1FngUS9YXGkBuHwc6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFV7woIek143czbYOKmtP+rmtHt1yjz1eE8jFYXeQ1Y=;
 b=HmdNlLr8QhOGBfWRhdrLFfA4qjz4ZSEwm56SvOY/AteclF83MJ/D8RdpkabvaM0XPG1Uaf12PW7/G4F9QZU5QwfHLjL9Wbhw984aNHp/VYb97JUTeOno61T4M6oB14T3hRK0mMXqCWxJwVboMInE3l8QauZ69S2P+nwrRfWTuJ4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6919.namprd10.prod.outlook.com (2603:10b6:8:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 26 Apr
 2023 21:27:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 21:27:49 +0000
Date:   Wed, 26 Apr 2023 14:27:45 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhiramat@kernel.org, rostedt@goodmis.org, vasily.averin@linux.dev,
        xhao@linux.alibaba.com, pcc@google.com, neilb@suse.de,
        maz@kernel.org
Subject: Re: [PATCH RFC v2 0/4]  Add support for sharing page tables across
 processes (Previously mshare)
Message-ID: <20230426212745.GA4755@monkey>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b0b449-8284-4abc-5de2-08db469d15ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3PJtyNQaBIq9MNUjqG60sATYnsHq14yZKFIXyCHNBKjFcHiye25TDwbufYapbkOu/IRGzpONDbjEP7XoU1+fRdn63XrYQB/GolNpRW6XWTO817RPBWpWO1hcgHoQX1fKLYnN1qMINqiGaXJny0PApDy5eQaGD/p3Tmbu4NN5lxKOuWnsluTuCBZqIC3wJ2Oq/er4BomVdMsYHgGTSDJrqcdB2r6RRMJHoG/ros0+M0Juv6ZUj5Bxja++vI8eIXkjtM2qe8YHqXy3aozIq+UQD/GRGBtMHQo56uAcrUDFE9P5eA5MK2fulDAZiQqx53U6E1BnWIZpJQU1dfCpwYnUAF4XRlBs4H3PtGWjZr9mkkl+/0yf3t5R77SW1HD1zTo5gy5K8ixJ/4HsYyne8t7w1NArw617ixY+U4xZYMXyPHtlLkl/ZxzSe/cvbJU5JRJuVyqoW16VF5HcZaA0wW3QOIM/vdO5uCUscclq3l+foyuGO0oiFGql82NDGScHQlzph/FQ71RaONfq2MhWY4amrluqt8xx+VGXfDmV6AzP9eqIQJz7rKQmNTr3iJt6iOS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(53546011)(186003)(6486002)(6666004)(1076003)(6512007)(9686003)(26005)(6506007)(4326008)(478600001)(6636002)(83380400001)(86362001)(66476007)(316002)(66556008)(66946007)(41300700001)(8676002)(44832011)(5660300002)(7416002)(8936002)(38100700002)(6862004)(2906002)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBIg3PHolfGMa1MCie6cQu7DkaEbVJSFm5U7J1ASQj5JtgpeAT9bnBHsOO/L?=
 =?us-ascii?Q?aT13LU8+lKW8Kgn8J4haIlYqgQKS1zdZYZuNuCPTWHt5KWoEv3AYOg/k4pN2?=
 =?us-ascii?Q?LwuAR7QR+I3RNiAdN4n+3EY0SqSareSWbLKnDgu4RnLAty7yGUMIJs7NjOcC?=
 =?us-ascii?Q?GN0pUYPVAhzueEClkfk6iYgD8gu8YRp6/YrU/4FESrY6phTU2GhT/jPCLHbF?=
 =?us-ascii?Q?lFl5F223qjeuMU+dYNQXvMruS9/hDye+YAjJutkVNbO/zmDXmG108LdCbloC?=
 =?us-ascii?Q?t7AJOxC35fhILTMIv3icEE94wWV+RYtnlQUMhTQ49jNNveD6Y44SQF+Bw0u0?=
 =?us-ascii?Q?yds55WiE98ALRmT+yTA79/ZEA3SQixDEH8wMJWO85y/TwxmwaLi6zc/VjNNt?=
 =?us-ascii?Q?+se5FTs73fWbd78aybues4AqTagJNWG5cuydAFGc9GP6OA88xexnpohJpC6i?=
 =?us-ascii?Q?a8YF2QynqsP1NAQwKNxiVPcHq/zCmmPtSoWtuPTjxL2DgCkv9TAnLwG3Ui4S?=
 =?us-ascii?Q?NPoOVNWtcaypCP9jnIUA8UFmNmMxfskgkBXJF7w84x+QPNrXfwXQA6qsrdJD?=
 =?us-ascii?Q?Ak8h13TbrK9AEr3m+bH/BoKxtXV4gS9Ea3jt8fH1aC5XxDdv2UoDzzMsxCT4?=
 =?us-ascii?Q?nz6J1onSmsnKwjAIrKQ3yhuRcqkBmGyZQDrrkaP/PHSSopV6BeaMgTe6TkLo?=
 =?us-ascii?Q?+Lj9dtAFipVvQFy74VfJNE428BxDLo3L0otcadKiiP5s2iJRr9FJmsOo0taf?=
 =?us-ascii?Q?yT0qbCZ76lRPizFDGapUG5uZx3vM3pYbkZzOpq/42g/QUfyF4TxVwygU2qDx?=
 =?us-ascii?Q?mtRWRsYU/kKNw5Gdej5axwRQKuz+2A+Fiw8QQmUu4N6go8AXwiuYpca2+lLZ?=
 =?us-ascii?Q?PNinJwafnK1TQwWZygd8X+wAg9KPLGVT6qiqdSHrAIb+x5WhQ10Nf3jFEW7U?=
 =?us-ascii?Q?0yAcT62y5j3EdbSotK4eJxJwlyJhKMbeaVYeJYg83uugsCGFBaQq9gp8+ekZ?=
 =?us-ascii?Q?uOJhMsz60y4H2C9zSDVrmWpMljcEZjvl4Hows+F5AOV1GElfgu099zM9ZNLi?=
 =?us-ascii?Q?BcVxTdTwrtYrv4fw6Oh/xw+O65n3iC1V5iq6QXs7jkgrSjga1YEU7g4P/DWe?=
 =?us-ascii?Q?E7X9dmnGVCxPN6FjyO3jpVexFas59+sFt+ay2AqL4C2ShfKByf++aGmDPSe6?=
 =?us-ascii?Q?iI9syi59p14lAU6avyM6Px8nW3OI4YlWMDrkCEVyuyFzRf/3Y1uagifODApf?=
 =?us-ascii?Q?l1iQ80IxCOrsYa6nnLT2is5awphJufWAgShEcDtDCQJTFEt61T5NlKEByV/3?=
 =?us-ascii?Q?6XWeITTssZ1ZP5fAfUkJLAGPuJV7kSPcS6VwGel62MaPplnuC/rRTozwXoJG?=
 =?us-ascii?Q?9mZ8Ur+gglZYwJqh5Sv9V/lwyI8GFY53xgS2qoyt94kawep0d2N56zZNWMTx?=
 =?us-ascii?Q?9PXJ7+MnuGWnw9XWkus8stPimWToPgoqXd+GeFkcrZPfFKFXbmWO0/P591PA?=
 =?us-ascii?Q?kP7odbQQs0q6zs61T377nZ/S09yyJOpIQwqUInnp7mG/6wdlZFRrwP920FRV?=
 =?us-ascii?Q?ftTA1GLv0fS4jc+3ozT/5BneHIZ5mDjAkhtHB6Bs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?80z3ay+itXf871zP0HClqZeeFis/XSKHZ5P1KH9v73XSc/8Ls5Uj0Z1Vh9i4?=
 =?us-ascii?Q?4D4UBVrbuasfTi7zCaQ1ROC/fJQXehtoAbP6STa6Mispu730v9NM0Q3anfkR?=
 =?us-ascii?Q?Mm11TId3/cW2ZjBgnUtpDfaNv74fMZ8UiZwNbRV9KmFDZD/vfyJuiDcBP4Xb?=
 =?us-ascii?Q?xiwDtIQGel0Cp79RuOy0STV9DbFdu8vudvV1qIr5ZAmoG/9cPZs/16uuYVmA?=
 =?us-ascii?Q?0oZuW7BsX0zbM1lFUk3wOGb7ktqVpqioKhuPRCz9LC0+tl8Ssq+4cMEAsDk1?=
 =?us-ascii?Q?7aGyXdKfoEvVKqkp8lZQ/d8jv8z3hgKLlmYka8VgRvVhAyCeqedTFrYcN8sO?=
 =?us-ascii?Q?6/Ja9t1n0v2iws23ztTtbZ4LRDH9D85HN40MOnhjoIRR/JjlEb3hAxbi+NYS?=
 =?us-ascii?Q?1NagoowB/KARHrswYDyUfqOrtAIqU2c96/+sk8zk/irjFcw/bYoIpRNnij2P?=
 =?us-ascii?Q?GQY8JXZt9kbPpGjyzpDkUDv8jkaDL0hdQWcLLza0tR4lSi4/iPcHlz56oBt+?=
 =?us-ascii?Q?sI7g0Xz/7sjvkccZ89xmk/+zV/ZvjYKHHd9JDzu8iSj+vwMSIETfiJiBDryE?=
 =?us-ascii?Q?u7G2I6OgnTfWbpPu0K97RZYpYBRGNSStOzsGuHZ/+NWaMlYXD6CGgqowyBXV?=
 =?us-ascii?Q?sFhvi3szZuZ+WPpbm1nu7Ay1LJIzxvREtSMP5B8TgOeoAVH6U4Z1XGOLFNWu?=
 =?us-ascii?Q?NXFsWYlajuU2nr8Lb7XVCe7pXw7yHbMuwTV3fxi9LDTm4uNiAsCTVyR5gyTT?=
 =?us-ascii?Q?Jge3LLPDryuMxUuWbgJoDDJ8bZUx38EZnuMQnbfLj+3nTB8bmWrT7P75PWmt?=
 =?us-ascii?Q?vrJshnL9wWCS1fVi4uFFcYVW2Zux9h4SpKZ1VTG+dfjBaMVFutwaApn29G2v?=
 =?us-ascii?Q?8NLEBj4FjSZz73APT+1GNONlyWQBroLeXt9CUlzPbxzSV1kxgPESqial7uMq?=
 =?us-ascii?Q?kA8qlO78SBbvz2g77Gwd+ljwYOhBWVFcjmJ8SwyooW1i/mbWjeipQ5Hag0TK?=
 =?us-ascii?Q?RbAVM3hdvnR3n/7YoQ/wfCJMac5yvCCCRlXaOT7mDy+yGLhcnfQRhnL9tri4?=
 =?us-ascii?Q?qlblTK90TTIIwFffOcvaVz1+x5xhNY2Fgq8OF6w1cmW79BJYMrV7N20yqpWR?=
 =?us-ascii?Q?QW+CqKnOJGtPSdf7L01JMO5tFCh681DYAEDJ3h4r9gDyTrAIJZzK3C+Lar9K?=
 =?us-ascii?Q?DK5Hd721R8WTLxcOu/nuBNK5nuWp+BaUPJBKLDCBCBaJaxeRSjgdtWwRKVlU?=
 =?us-ascii?Q?/eN3pbo3kn6X6/JTsRHdNWBObbC6UYDGdlXoClPbgQlr0P8+TxCDvH/Mt3Ca?=
 =?us-ascii?Q?Z/slrWdXBE7tuH2qNmDmpMkm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0b449-8284-4abc-5de2-08db469d15ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:27:49.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzsEJMiJxiuqUgDHjMXIaqtwvqllSM4H3CSXVgtFKCIspr55PYEQOpIGFBrXsU2hah5ff9ctdxKZQGkNym6T6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260185
X-Proofpoint-GUID: CAsCZhJJone0WpQ1Xn7ocFsiCFQ1b18g
X-Proofpoint-ORIG-GUID: CAsCZhJJone0WpQ1Xn7ocFsiCFQ1b18g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/26/23 10:49, Khalid Aziz wrote:
> Memory pages shared between processes require a page table entry
> (PTE) for each process. Each of these PTE consumes some of the
> memory and as long as number of mappings being maintained is small
> enough, this space consumed by page tables is not objectionable.
> When very few memory pages are shared between processes, the number
> of page table entries (PTEs) to maintain is mostly constrained by
> the number of pages of memory on the system.  As the number of
> shared pages and the number of times pages are shared goes up,
> amount of memory consumed by page tables starts to become
> significant. This issue does not apply to threads. Any number of
> threads can share the same pages inside a process while sharing the
> same PTEs. Extending this same model to sharing pages across
> processes can eliminate this issue for sharing across processes as
> well.
> 
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is only 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system crash was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, amount of memory saved is very significant.

When hugetlb pmd sharing was introduced the motivating factor was performance
as much as memory savings.  See commit,
39dde65c9940 [PATCH] shared page table for hugetlb page

I have not verified the claims in that commit message, but it does sound
reasonable.  My assumption is that the same would apply here.

> 
> This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
> This flag can be specified along with MAP_SHARED by a process to
> hint to kernel that it wishes to share page table entries for this
> file mapping mmap region with other processes. Any other process
> that mmaps the same file with MAP_SHARED_PT flag can then share the
> same page table entries. Besides specifying MAP_SHARED_PT flag, the
> processes must map the files at a PMD aligned address with a size
> that is a multiple of PMD size and at the same virtual addresses.
> This last requirement of same virtual addresses can possibly be
> relaxed if that is the consensus.

I would think the same virtual address requirement is problematic in the
case of ASLR.  hugetlb pmd sharing does not have the 'same virtual
addresses' requirement.  My guess is that requiring the same virtual
address does not make code simpler.

> When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
> is created to hold the shared page tables. Host mm struct is not
> attached to a process. Start and size of host mm are set to the
> start and size of the mmap region and a VMA covering this range is
> also added to host mm struct. Existing page table entries from the
> process that creates the mapping are copied over to the host mm
> struct.

It seems there is one host mm struct per shared mapping.  Is that
correct?  And, the host mm is the size of that single mapping?
Suppose the following:
- process A maps shared file offset 0 to 2xPMD_SIZE
- process B maps shared file offset 0 to 2xPMD_SIZE
It then makes sense A and B would use the same host mm.  Now,
- process C maps shared file offset 0 to 4xPMD_SIZE
Does C share anything with A and B?  Are there multiple host mm structs?

Just wondering at a high level how this would work without looking at
the code.

>         All processes mapping this shared region are considered
> guest processes. When a guest process mmap's the shared region, a vm
> flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
> fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
> flag is found, its corresponding PMD is updated with the PMD from
> host mm struct so the PMD will point to the page tables in host mm
> struct. vm_mm pointer of the VMA is also updated to point to host mm
> struct for the duration of fault handling to ensure fault handling
> happens in the context of host mm struct. When a new PTE is
> created, it is created in the host mm struct page tables and the PMD
> in guest mm points to the same PTEs.
> 
> This is a basic working implementation. It will need to go through
> more testing and refinements. Some notes and questions:
> 
> - PMD size alignment and size requirement is currently hard coded
>   in. Is there a need or desire to make this more flexible and work
>   with other alignments/sizes? PMD size allows for adapting this
>   infrastructure to form the basis for hugetlbfs page table sharing
>   as well. More work will be needed to make that happen.
> 
> - Is there a reason to allow a userspace app to query this size and
>   alignment requirement for MAP_SHARED_PT in some way?
> 
> - Shared PTEs means mprotect() call made by one process affects all
>   processes sharing the same mapping and that behavior will need to
>   be documented clearly. Effect of mprotect call being different for
>   processes using shared page tables is the primary reason to
>   require an explicit opt-in from userspace processes to share page
>   tables. With a transparent sharing derived from MAP_SHARED alone,
>   changed effect of mprotect can break significant number of
>   userspace apps. One could work around that by unsharing whenever
>   mprotect changes modes on shared mapping but that introduces
>   complexity and the capability to execute a single mprotect to
>   change modes across 1000's of processes sharing a mapped database
>   is a feature explicitly asked for by database folks. This
>   capability has significant performance advantage when compared to
>   mechanism of sending messages to every process using shared
>   mapping to call mprotect and change modes in each process, or
>   using traps on permissions mismatch in each process.

I would guess this is more than just mprotect, and anything that impacts
page tables.  Correct?  For example MADV_DONTNEED, MADV_HUGEPAGE,
MADV_NOHUGEPAGE.

> - This implementation does not allow unmapping page table shared
>   mappings partially. Should that be supported in future?
> 
> Some concerns in this RFC:
> 
> - When page tables for a process are freed upon process exit,
>   pmd_free_tlb() gets called at one point to free all PMDs allocated
>   by the process. For a shared page table, shared PMDs can not be
>   released when a guest process exits. These shared PMDs are
>   released when host mm struct is released upon end of last
>   reference to page table shared region hosted by this mm. For now
>   to stop PMDs being released, this RFC introduces following change
>   in mm/memory.c which works but does not feel like the right
>   approach. Any suggestions for a better long term approach will be
>   very appreciated:
> 
> @@ -210,13 +221,19 @@ static inline void free_pmd_range(struct mmu_gather *tlb,
> pud_t *pud,
> 
>         pmd = pmd_offset(pud, start);
>         pud_clear(pud);
> -       pmd_free_tlb(tlb, pmd, start);
> -       mm_dec_nr_pmds(tlb->mm);
> +       if (shared_pte) {
> +               tlb_flush_pud_range(tlb, start, PAGE_SIZE);
> +               tlb->freed_tables = 1;
> +       } else {
> +               pmd_free_tlb(tlb, pmd, start);
> +               mm_dec_nr_pmds(tlb->mm);
> +       }
>  }
> 
>  static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> 
> - This implementation requires an additional VM flag. Since all lower
>   32 bits are currently in use, the new VM flag must come from upper
>   32 bits which restricts this feature to 64-bit processors.
> 
> - This feature is implemented for file mappings only. Is there a
>   need to support it for anonymous memory as well?

I have not looked at the implementation, are 'file mappings' only
mappings using the page cache?  Or, do you just need a file descriptor?
Would a file descriptor created via memfd_create work for anonymous
memory?

-- 
Mike Kravetz

> 
> - Accounting for MAP_SHARED_PT mapped filepages in a process and
>   pagetable bytes is not quite accurate yet in this RFC and will be
>   fixed in the non-RFC version of patches.
> 
> I appreciate any feedback on these patches and ideas for
> improvements before moving these patches out of RFC stage.
> 
> 
> Changes from RFC v1:
> - Broken the patches up into smaller patches
> - Fixed a few bugs related to freeing PTEs and PMDs incorrectly
> - Cleaned up the code a bit
> 
> 
> Khalid Aziz (4):
>   mm/ptshare: Add vm flag for shared PTE
>   mm/ptshare: Add flag MAP_SHARED_PT to mmap()
>   mm/ptshare: Create new mm struct for page table sharing
>   mm/ptshare: Add page fault handling for page table shared regions
> 
>  include/linux/fs.h                     |   2 +
>  include/linux/mm.h                     |   8 +
>  include/trace/events/mmflags.h         |   3 +-
>  include/uapi/asm-generic/mman-common.h |   1 +
>  mm/Makefile                            |   2 +-
>  mm/internal.h                          |  21 ++
>  mm/memory.c                            | 105 ++++++++--
>  mm/mmap.c                              |  88 +++++++++
>  mm/ptshare.c                           | 263 +++++++++++++++++++++++++
>  9 files changed, 476 insertions(+), 17 deletions(-)
>  create mode 100644 mm/ptshare.c
> 
> -- 
> 2.37.2
> 
