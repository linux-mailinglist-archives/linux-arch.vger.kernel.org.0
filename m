Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E76C67598D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjATQJZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 11:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjATQJY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 11:09:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373579576C;
        Fri, 20 Jan 2023 08:09:19 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KFwer1027559;
        Fri, 20 Jan 2023 16:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=suxyTOmwgQomt824QvLXmrTwiw6g0R7ZyfxXpkMoEW0=;
 b=treqZd5Y/U63nnu1JYMUk3qn5Nj0KZ4s7PJ+DbT+dT3pM98vp1S8KTcj3o1VViaH3DH9
 8mmfUt9K48kBcKM5GcJGKRPIj/YB2vRxRdkeIU0TgEOY5VSdjbSWbWBP6tyG/dfsnVMG
 84i+LSzHWqo6ov9/v8IsKk5siA4tlhNXuSJLwVTHRRTcZQ6fiLYcSEmVr+zuDBwfF0kQ
 VmN7Oa06d+dOG2iTmf6bsc15S4dS1btapyd6jcqD359+0b6AtKlrBYZqetkUZiqQ8zfn
 qlFKfGBGjSYVYEleEGDOHiIDLr7qGmLZJ9/gDj4UatHWdDOOjRTO1lm4gR7ilulDZID7 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn5uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:08:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFQDdD000845;
        Fri, 20 Jan 2023 16:08:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2rucu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkgUwUev2rj3bTqRAWzKnKJRCh6aywKGz1XW9Xts7piFuYV+G6MZ4BVdZgc0xOBQx8abHYk+0AkhIqQSDV5YQHDTHs2jnPxp3wuT+0I7neBctyz0R0bcUI2PgG9K0efj3bU8ZTSYte0cWjuq+mZ4LyJaoyCJJBWjsCIkf9xxT5+KL5CfM4U3E9FjYbJOpiGyfbhyCcFDFJcI2mc5WTw5v83e+OlIBL2gOln3Ppif8eUxoEpDujLk2iBjfA13SXmc9FYUZHT//QvqTkJp4aS+8GDqk8eeA1pfmwTQDO6Qx8MwcJMvE4zUawmucAQWpvD9wSXxx88smXAmrdvHL9ihkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suxyTOmwgQomt824QvLXmrTwiw6g0R7ZyfxXpkMoEW0=;
 b=XWVm6VsaG3zbxBJqFU1YlDJNcJoSIc9TfGTpr/O3t2xHAgQ4PVlCtIYLYdpTUi4KR62NY5ET6XKDeERPeeBpKFji9cYy7vqx+wgn3PavFm2rhXhp1wukk99sT+q1IW3Q6mgSlx0aSGtsd/F9jEnEMpkfMV0xAI5oqArqoy/BGJ9yTGOah12S49PGYaS5SmPBioixWRxVeMTuSvz0j8zKgMOkHDZDtaczvolmHubHeIhCmxf8j19Qb5ov79ryRbtY14bynm4RdgufcMFKt2toDCyNxqD4+033PzeMSNuUjkkNEInMY3iDsBSesjnjYK+3Wk7URgHnut0IsqG+/75CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suxyTOmwgQomt824QvLXmrTwiw6g0R7ZyfxXpkMoEW0=;
 b=A0mBN2dyRVhwAGHQ6GBI+CvAWgy/+vbFy/hc0H95XLdMZyiJRtaL8L0nmo7cQ+Eu+PO7Z920gHbr4YD7N7QGOt2XVrVQCK8jF/6X6QJWuVssZ+TUFQo2glqgC9Mw9sF+yfkj8rvCr76vGL6j8aboAzgtpqxP9AYiMDjuNjAMb7I=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Fri, 20 Jan
 2023 16:08:32 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::9f6f:c50b:3f5:7492]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::9f6f:c50b:3f5:7492%5]) with mapi id 15.20.6043.006; Fri, 20 Jan 2023
 16:08:31 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, 21cnbao@gmail.com,
        arnd@arndb.de, ebiederm@xmission.com, elver@google.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com
Subject: [RFC RESEND PATCH 0/2] Add support for sharing page tables across processes (Previously mshare)
Date:   Fri, 20 Jan 2023 09:08:16 -0700
Message-Id: <cover.1670287695.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f914f7-c624-4154-b1b4-08dafb009345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C54OWFwXyIW13r/jXbSVFdF9j9RVd9MI4ZevDuf8isA45HCG9v+yuTVQwGwPCbX/P2aPaDOPSGy0A1zZLLykI/mMqYtYUgA1qmUzlMmwvza3wxZVK9GajX5QhbTWSO+zA02vSTo1kGzAR2j7SVqNNtLnEJCL+AxG06Jy4TSSF4z1jTaVSsj11mKhBAgx1uKU3BU5dd9yQvTrAZLNouKcQeO6ZQLF8S/dP06ApdLQ1fQmsinXp9X57lQ9+eJl89gNQhFxt9/MwMTfSxhmX2ArXNJYxHhnt5yJEU4+TEBl3DrDrUgAD4Z4CiRGWae6hKB9+ZTJjuUx5GCOhyOS/1GIkC1ZBMPx5j06U2FDvl2OIaWQ0q4qoZ3/y8iYeZdBBozjINh66ssDGGsCFJola8R93VYcMfmcMPWBauKJURfaFUataWcyl4Jht8YcFQdEFKPW7Qi1slxueG2eeHo9Gu8Yb5SbI7SDZGt11RWd+UUBeocefheZ8UPZL7r0KbgTUdTfkOreZraAQ6y4GIYGcd/p8dYoDm79/pOape/PAK8sz8XQBlWU+wmgSCGCSBluQAmlLayScBOMkoJ5Go5oWycNzg+C73x00Yo0bvsHdDpQK0z33WgkX57MmCZtAwsePj4eYbQf1N/9x07sXqWd8ZV0Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(6506007)(478600001)(6636002)(6486002)(6666004)(4326008)(66556008)(8676002)(66476007)(316002)(66946007)(186003)(26005)(6512007)(8936002)(7416002)(36756003)(2616005)(41300700001)(5660300002)(44832011)(83380400001)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRSwBR0sDyUd6X/XcX+LtOZC7xKBEg0i+7qpzFH8pJOsZbz9Ih1s/gF7h8c/?=
 =?us-ascii?Q?HSbPGDWDzKYOLGUeqM6M7aHjeF13fbviAjvRF7QOKTJoeWZaYA+lS7ItsCqO?=
 =?us-ascii?Q?ut+GUuiuZGH6WiizQsOUI14mXrj7QSo8HaHQOE46mU1ZPD/O81Gd/cpjvu3O?=
 =?us-ascii?Q?KFsZnCQNCWnkc5lNP+eWR8rtSKXkyYLATjp84x5uLKbkbX1JZCbSpoO9lzBp?=
 =?us-ascii?Q?Qf/C5BAdx4sUqnC4VwdzDW0F7zc7ohjzcbbeDcZJfcnlvch2iWGU28mP5Eme?=
 =?us-ascii?Q?MIF3hlFEJeOhjmCW7jtgVn0HATr5dsjS++/7SMGdwMdbF1mpp14BWbg7OACY?=
 =?us-ascii?Q?BhX+bE6y/DEp7BNmp2mbRuf626RRJPUVj/6IMqVFFxPgSE7mNRPAL37WiWr0?=
 =?us-ascii?Q?vzy/CnYTpW3dD+BgwevKjeNpzaNHzYkWBPBc9SbvAY9vUhpeAk7/qwZU3HIu?=
 =?us-ascii?Q?jIyrZ+U9O4kawTIuUlkTUh//lzY4wOX6GJIQbhitRNN+U17/V48DhaOuiLRi?=
 =?us-ascii?Q?oQNsNUo59P7sYJJqlbe2qZXYtsPNcP3p2+xekqn+y1d2ZfA+FQI6Q/uV8BaD?=
 =?us-ascii?Q?oMGVKy3UUJgGrbHgiUY3m6T9WP7wtvGp5m77EaBgAhmUbiL5ADWX71k66jLd?=
 =?us-ascii?Q?sehi0Wm+89Z8wsaRuILpchHbmUZwOT9tR+yJepUPjHHbcUyUTLLhPihodUaY?=
 =?us-ascii?Q?2rt3pcPUZna78hvLtCWpbbsl4i4rfUEXQhh3irF3c82dC6I1KQtEL24Py0w2?=
 =?us-ascii?Q?rrsc6ebO8dD3nP4cygE0WCFuWY7jtGB/r7pjzeGLaEmiJ5tpPENOmz7NH+c7?=
 =?us-ascii?Q?OGEIOauqb2DH5fkkPEY2V4lqMEyaG3NcvXwenRJR0/zMOsTz3Ui6C3WMtoYQ?=
 =?us-ascii?Q?rpqqf9VG86peCXNF1sJIz9eCzzZ583TuE/lJrv+AVOj4WLA3mznVjk3aXDFo?=
 =?us-ascii?Q?b77bhcSqCRo7w4XMQzgCxQvljJ6UPVa3hw3+IeDC3B3/lwJHkmhOc0+Lu71I?=
 =?us-ascii?Q?cMpOPAdfDxd5Nm7HPxUh8CTLt2OfWwYzm4L6mZ4PESLOJVOUw3BkRHeyDZvG?=
 =?us-ascii?Q?L7AqVPj2EXQqs+6fe7pBzTvRzDRJA6Ws7b5bKr2ebADuAeyCFmSWIK8oBCGI?=
 =?us-ascii?Q?A7MHYuIUGXMmR24tKKhjTXWcgfDcu0UuabqH5urfiexJmRvhs2qMIxYTOdj2?=
 =?us-ascii?Q?nB2HDlIH1tqV5CFyvBpdgG2ypCebiKQv+CQ24rcAI7V2jnA58eHS3ciOSphV?=
 =?us-ascii?Q?xCepmnDyGejvAEmfCVHL1Ev1+ia+hCJKwMfENIyERBro/s7c5VcH8OjVJWBv?=
 =?us-ascii?Q?dtd2SFO1N+fZX2n5FUnzJrMXLyUc3RCRblVwZ57tS3u6V+v6aPp+uV0yAfh+?=
 =?us-ascii?Q?QH7hHCarIWA88+kGQvn3+FpsSDaJ5J2ZpSERkFPWhQ1JbarsiTEEQntoi5dk?=
 =?us-ascii?Q?ovxBAA6Qkr15L/FLWvf8Tbs5t+j/aCmQ70/otzgDsVBNBTXs5J2fHJOqUSYI?=
 =?us-ascii?Q?g467hyD8jq0+wXlYWZ5K78K7iZyQshIgPqWjlD2/reCqdXiNikYNpn/UU99V?=
 =?us-ascii?Q?UnYSMdfAhcVIcXBJzXSXMnk0m5YDRaZj+Vmxp1x9W1CWTQlTYBPsJexJdM3N?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CuppCxU7LNFdTWQ3wd+fRB6pr+QkGWTZiC82nYZGUQ7zCQ+ZHafEcmbC89Be?=
 =?us-ascii?Q?c/bdou9LVTMseQv9LB7wljgzNts0/9S1qcNWFxWb+Ks+Fd+vwINRzmnr4Oj9?=
 =?us-ascii?Q?JNuMWklQ21ZuVeP0pfM88h482So+nLVnidh0Rw8wzZXKVHnzD+Qp2PRYaSgB?=
 =?us-ascii?Q?+cxro58T/igP3mDdM1OLZUlo5ZaA7vJnLPcIZESUDyZc0AyqshqjbWaIw/pC?=
 =?us-ascii?Q?+SOdTOfEc8qqvXKITkWDW7yBf/2h73ebpwyMklE+USr3LKKK7DrYOL2BcIxf?=
 =?us-ascii?Q?uG1lg9uCr1OmIiwm4KrLVHL8luT/WGxFx0MbfN/bYOBOL/H1OobzfGZ8WhLH?=
 =?us-ascii?Q?6VjvOYTTfwTFDdp+Jn7jw4r0kD5FDP7Q4pqzCO1HULPOJklWiN13NqywmsRZ?=
 =?us-ascii?Q?B2MyPJGzdQYGGnRBGKXUXyMVWvA52wDXeEXAfMwiVQUaQ3CC/gbZdujbsMB3?=
 =?us-ascii?Q?4L9i95hV6DVttJ3ZM7AGaTrxRxbNRivGFAmlXkdz97BPhFI7d5Qy///KnHya?=
 =?us-ascii?Q?9pDXSfI+TFUXcwuKuAPK7mi/jTyr+Slu9TbRpT1wucUb70P0rFjWb11wpU6x?=
 =?us-ascii?Q?70o324iDRqWo3W2QXQzLyfqMA45eqMs1/QFsZFsL3pbtZla4vNhFeIO14zbC?=
 =?us-ascii?Q?6rflJHfDXfsTa3Ac/wmVFluZPwdoDv7Qi+7y+I1McZfV1N39mG58RMgHFyTT?=
 =?us-ascii?Q?3aUmQKhvl2G2HYw9DsrTF0RW2u642JhNYrA7IR8MT8pKf0DsYOZfsuKAWB/X?=
 =?us-ascii?Q?HjgbfT+UXpjXgsffQf5nJS8iR+p2ra0p1PAcLOs7m01xA6AVkeQPuP9lK7pW?=
 =?us-ascii?Q?HIEh9f5AbbvGKNN5NSImagEfNzTq/EiGSKyZhRSGzRWp65uvE+GNKD7B3nOh?=
 =?us-ascii?Q?WJro5zDjEFDg2CBJIHCPP43rbM+lkuDoaz4UYvWOy84+jpAP6gj6V+sL4cDI?=
 =?us-ascii?Q?c21rFcXu8FC20VyR4YYOZxXtEmgWZQI9nrRJGoFaorVtNsbGw6NyJe6vDGbm?=
 =?us-ascii?Q?n1MA2gyeIbmTpJOcwVTacL+KHF9NDSV67HetpfyvaJsJFKxXAMQwW1LnBujy?=
 =?us-ascii?Q?BCLZ3Nw0EoDHOMonJB1yJRp5RvTkXp0k3omXXGxkovLCjmax9jOFjdObOQW1?=
 =?us-ascii?Q?V4gbW8q23yiE3JdTMzAMr65dhRzkTugD3HbHxVFC2wZEuE82TZZ0WPN9Lkwm?=
 =?us-ascii?Q?a2olNz4fzKat1CkgzJOUkgtYpZLQX5SLkBOb+hXJj98IclQpwjz42mRw3z3F?=
 =?us-ascii?Q?hsg57SC45gR2XF9tZdlEMFJnk303O5T5fD+yFrOR+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f914f7-c624-4154-b1b4-08dafb009345
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:08:31.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJHEg0tqQ1HiOX2ySjaDQCByq7r7/Ckc+Rw6V67l38PVlHVkftR5VPegOS71dWYKc0ZedGz3aDs7RTjowVderQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200154
X-Proofpoint-ORIG-GUID: BEvFTT-DKEdsl-vJes2v_xKbfzL7QaIg
X-Proofpoint-GUID: BEvFTT-DKEdsl-vJes2v_xKbfzL7QaIg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Previously mshare patches. After discussion on mailing list and at
LSF/MM, mshare implementation has been reworked to eliminate the
mshare API and use mmap instead with a new flag. This eliminates the
need for msharefs. Alignment and size restrictions were changed to
PMD]


Memory pages shared between processes require a page table entry
(PTE) for each process. Each of these PTE consumes consume some of
the memory and as long as number of mappings being maintained is
small enough, this space consumed by page tables is not
objectionable. When very few memory pages are shared between
processes, the number of page table entries (PTEs) to maintain is
mostly constrained by the number of pages of memory on the system.
As the number of shared pages and the number of times pages are
shared goes up, amount of memory consumed by page tables starts to
become significant. This issue does not apply to threads. Any number
of threads can share the same pages inside a process while sharing
the same PTEs. Extending this same model to sharing pages across
processes can eliminate this issue for sharing across processes as
well.

Some of the field deployments commonly see memory pages shared
across 1000s of processes. On x86_64, each page requires a PTE that
is only 8 bytes long which is very small compared to the 4K page
size. When 2000 processes map the same page in their address space,
each one of them requires 8 bytes for its PTE and together that adds
up to 8K of memory just to hold the PTEs for one 4K page. On a
database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, amount of memory saved is very significant.

This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
This map can be specified along with MAP_SHARED by a process to hint
to kernel that it wishes to share page table entries for this file
mapping mmap region with other processes. Any other process that
mmaps the same file with MAP_SHARED_PT flag can then share the same
page table entries. Besides specifying MAP_SHARED_PT flag, the
processes must map the files at a PMD aligned address with a size
that is a multiple of PMD size and at the same virtual addresses.
This last requirement of same virtual addresses can possibly be
relaxed if that is the consensus.

When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
is created to hold the shared page tables. Host mm struct is not
attached to a process. Start and size of host mm are set to the
start and size of the mmap region and a VMA covering this range is
also added to host mm struct. Existing page table entries from the
process that creates the mapping are copied over to the host mm
struct. All processes mapping this shared region are considered
guest processes. When a guest process mmap's the shared region, a vm
flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
flag is found, its corresponding PMD is updated with the PMD from
host mm struct so the PMD will point to the page tables in host mm
struct. vm_mm pointer of the VMA is also updated to point to host mm
struct for the duration of fault handling to ensure fault handling
happens in the context of host mm struct. When a new PTE is
created, it is created in the host mm struct page tables and the PMD
in guest mm points to the same PTEs.

This is a basic working implementation. It will need to go through
more testing and refinements. Some notes and questions:

- PMD size alignment and size requirement is currently hard coded
  in. Is there a need or desire to make this more flexible and work
  with other alignments/sizes? PMD size allows for adapting this
  infrastructure to form the basis for hugetlbfs page table sharing
  as well. More work ill be needed to make that happen.

- Is there a reason to allow a userspace app to query this size and
  alignment requirement for MAP_SHARED_PT in some way?

- Shared PTEs means mprotect() call made by one process affects all
  processes sharing the same mapping and that behavior will need to
  be documented clearly. Effect of mprotect call being different for
  processes using shared page tables is the primary reason to
  require an explicit opt-in from userspace processes to share page
  tables. With a transparent sharing derived from MAP_SHARED alone,
  changed effect of mprotect can break significant number of
  userspace apps. One could work around that by unsharing whenever
  mprotect changes modes on shared mapping but that introduces
  complexity and the capability to execute a single mprotect to
  change modes across 1000's of processes sharing a mapped database
  is a feature explicitly asked for by database folks. This
  capability has significant performance advantage when compared to
  mechanism of sending messages to every process using shared
  mapping to call mprotect and change modes in each process, or
  using traps on permissions mismatch in each process.

- This implementation does not allow unmapping page table shared
  mappings partially. Should that be supported in future?

- Patch 2 will be broken up into smaller patches after RFC. It
  likely is easier to review the proposal with all code in one patch
  for now.


Khalid Aziz (2):
  mm/ptshare: Add vm flag for shared PTE
  mm/ptshare: Create a new mm to share pagetables

 include/linux/fs.h                     |   1 +
 include/linux/mm.h                     |   8 +
 include/trace/events/mmflags.h         |   3 +-
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |  21 ++
 mm/memory.c                            |  52 ++++-
 mm/mmap.c                              |  87 ++++++++
 mm/ptshare.c                           | 262 +++++++++++++++++++++++++
 9 files changed, 433 insertions(+), 4 deletions(-)
 create mode 100644 mm/ptshare.c

-- 
2.34.1

