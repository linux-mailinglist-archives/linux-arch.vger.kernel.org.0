Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECF67598F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 17:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjATQJ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 11:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjATQJY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 11:09:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3463894CB0;
        Fri, 20 Jan 2023 08:09:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KFwgPE023602;
        Fri, 20 Jan 2023 16:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jyDmGu+t0iQ9CjZ29z1zy69S4MwEj9oIffwRzeYprF0=;
 b=123GH3Y+fWIlwEREiohB/qhjlGZ1kDvuV7RF6x06gV0GLurdSSTgi5BNi59luqzC+xkK
 Ez+opInWR42ugR1/IZqDstIAzsjLpnJBCgoHDoMHDPxa6jxKhhA68CirBoqYDtS9TnZa
 PsprawyNVfsyY4c2Q0adaU0VfJ6x/IM+oW+xtrUQ2fj5eANclkJmc6CHgy0A5Nt6z7YG
 8EQFoYG4qo2PFOh66JKpAWAa3ZPbpHDl6tuI6qaCrvbLFl2NhpA0u0aTPC10RW3uo4yI
 JFrxGgaRzz7IZoy1OseH3J1SSsHGe2tNODiT98pPuJwHrEwiXIvlu91aq1+l8Bw8c0jC 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tw0fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:08:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFQDdF000845;
        Fri, 20 Jan 2023 16:08:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2rucu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7IQ4GUycYRv9EamVQNF17NZPXuwCYU9v9fn1BW19t+Ys1oCDszfQd+GCqf9AHAnN8YAhwDG7VapIjh5lhbXvep++nzjbK/7LMZ09wQyvWDAM4+JT9HemTiKFnES4qUwkVJ2ak6Ykp10zX4Tu+wn3hL8qfRPD1S9PUpIEnGb42XSUTgBh2YIqUf4K67PAcgK62kT1sy9Ue8Y1Kf+MVcjy+P2fUaSEGUMrD7xMXGARIeqpwwegn5NwrIXFH3yv8TxWQMc7EudbmqrWeozm6ZQ6XGjBjUeeva7m8YJvjmmzFwL+Tug7G4Dj/gR5eHnhT0ykC89jwVT+Hlpnwb1BvuiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyDmGu+t0iQ9CjZ29z1zy69S4MwEj9oIffwRzeYprF0=;
 b=m2LsASGkOEsml12yVc3C1r9Mg4ImSDDfagF3PqpkA6hI1aa82ZV/kIhVRGPFcLY9B2W5xtxrSZq6N+DafbJ8XHp300PiUAU1splQ03QHvtSGs2BcNPmmSPQWgC4FNGoFP1Gv5tkefIaWpwwYNw07KtdB0YaOQ/Dhs5qX6jmhgEWcLmgly/tLIl3pjVpWUNVjlQnMvXntlLLhOZlsvH4MqrT2O9pAzyU4bNtwyRRotepwivymEZywydsBshx3IkLugE4VOyMAdunCdLu2qOEuyK5OW6fAYrv+uriaQQeO6rMbBBLbQB7oNHR/ZX5E7MQzNYIP8yQ4eOc1Lj68yG7cPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyDmGu+t0iQ9CjZ29z1zy69S4MwEj9oIffwRzeYprF0=;
 b=XubOWr1XZmXpT6g6SItUXUZuDBUNRGBH2DDvmjpxpIoshqyXbubexvfr0PunN0hX4kHhS8HTWuvcb+5AivGYE5q9AD0VcNvoQhj8QJk9wPzLpheSicpJIwOzUnFvmlre4wdmlLRlS2U23Fg65NqU1b6VwyNJ5UFzgKUkcEhfEI4=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Fri, 20 Jan
 2023 16:08:33 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::9f6f:c50b:3f5:7492]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::9f6f:c50b:3f5:7492%5]) with mapi id 15.20.6043.006; Fri, 20 Jan 2023
 16:08:33 +0000
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
Subject: [RFC RESEND PATCH 1/2] mm/ptshare: Add vm flag for shared PTE
Date:   Fri, 20 Jan 2023 09:08:17 -0700
Message-Id: <fb672fcc0aae77214a905e95808f9566f441218a.1670287696.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670287695.git.khalid.aziz@oracle.com>
References: <cover.1670287695.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:208:32d::16) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: b07394d8-3246-4f50-bc60-08dafb009455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK5J6J61qEpwq+m2fXaacAq4+uAZY2VvOIk5PmREdHHIqJswA9QZBX1Fn4TVj+U8nwaOECs3AsgBX4h1HvI/x5/TFMvS8ESsXlR8knqMHQHRQ+fxKUcdReC/6ZTznB/X5mtPX3Bp+9amb2ywN+8OuzOBLs4JC3OAS4l11w8dmBGQgC95Ry6fTi+wJO3et7u/5fe+VH71g47FkdSCaXhRVV8sOSe4OtrGlLr/QX04Ka1YGFQk/5bq+3PlbwtpcwtIrIVnHMTgrt44doTxH1bKH9Gxa5unvmkj8lFSGiu+oa469KJMfBqfqeJuLghHW4WFHCUv2HNOiARamgRjfLoI6nq0M828SZM73Aa8zZ9AOKBxsD/SOF6TPIsMuqs3N1DKdVTGu6xVv3nwbL2vecxBhVVi4uOztXbUSj4J3vI2fCNIk52keJX2S0l8Z/26j/8oZSomGmmvpYZIb3cQwFK0C84KKjQNAJImNRVPHg9uDBQHn3AqYR6VJJRYlqOQtB4eQ2/2+9SMfbtgcFHruig/iVKqH3FDttO7+b6HKMAFbE3G0GjHoAlvzsDkOk3hOIuRVuE+4sKXT/ZEcpoorkRa3McinZIKaIIkb8nx5EE+SUH2soZ6fYDJ6QbWEXhYoymw0Bc3Tcw9Z1Qcr2mw4z/HwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(6506007)(478600001)(6636002)(6486002)(6666004)(4326008)(66556008)(8676002)(66476007)(316002)(66946007)(186003)(26005)(6512007)(8936002)(7416002)(36756003)(2616005)(41300700001)(5660300002)(44832011)(83380400001)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8p9mvjDp2I7MnG1Ii/H2NWdDmJlo7Wf/2HU1yp+AqvGRtGSu3lhmxc6rUgxO?=
 =?us-ascii?Q?woSxzxiH0lMMUGCfJpiszpSpOJw8TThcD2XsRbLfaicMBNYfX2vi/EN+N4Sg?=
 =?us-ascii?Q?NxyLK7GeIo65JPlI3Ae9CMjMnYMNnSz38nD/0R+rutjhR4spG5+4CEIov1CL?=
 =?us-ascii?Q?GiX3343RUwSKBepDBDSTo9pOus0kZlAr8PlIYP4E5JdZWN2Unvcr22pfo5J9?=
 =?us-ascii?Q?2WPJ2gBWnJh7wpMbVVTS9HpTWytazQL8ZojY0F69VhPS/kXLGjyNB3BLVoJI?=
 =?us-ascii?Q?GCNTFtI0MDVsjdr/agbnBuhh95qTIBkjuaeti7SF6N/OB7DOpdipQRJToEWc?=
 =?us-ascii?Q?ZBJLcFCSmUgqCD9vo391uyw6khiFaZ78V7CA0ERz5RjpyemDi3yvMtjerp+q?=
 =?us-ascii?Q?qP01sVIdou1sZzZnxDbSVZoZ1Pqthssrtjf6dCFYVLRz/hYzrPd8OPCfzaxa?=
 =?us-ascii?Q?IBzw/VKi7G/F1NTdo4+vKdnCCDqsouCx8ETskoAD9lBxC6eNbVF98HJZRmJu?=
 =?us-ascii?Q?DL1vrFx/a3XpmH6DI2Sd76dOTAVbxiI4vH77Hdth2mOeRfKtNAbfqJ33ztsf?=
 =?us-ascii?Q?jaEVlx/+hKR3MPq+QGQbxTV5YqYSoI+WbYf2jcs917lrVNxOlO0igBOGls4f?=
 =?us-ascii?Q?bvXrgEaOLqpDRO3NTpgXwIitQvBgcrFSlgV/YeBv46bl2kEiX4JqhCg66YPM?=
 =?us-ascii?Q?M3huXSGwVNv/il7BlijuJpneiOz67VrBpt1tjkbfTvUW3kgC43zbVL2mkg2m?=
 =?us-ascii?Q?f9OfdPWD6+fVgJJCFseUZjobePbQetpCsEm43iyi1ZXkytCFHyXm1McZn1oD?=
 =?us-ascii?Q?QnK6CvtdLOm4XFx0QObovmr3vKSQTsyYPXPJANFqKx+HHYVNHphznYLHHTdL?=
 =?us-ascii?Q?VjUlDalG2LMhAF49EhGL0/93zzdfJWs0eU7D3Ak8FvNv1SdghP13mW9GxzV8?=
 =?us-ascii?Q?QLJDAfEKExJdJ5XYzLL3ubpDmVqn7j82ekOPR4hQxFAZnrNefZ+VRbHzYalU?=
 =?us-ascii?Q?W9sdUcfYdqbn+fe7N7u6sZRpk143hn0FQFVEGlUPwO3yTFIH/gfBZjapjVOT?=
 =?us-ascii?Q?qTPMTrIMqYVioE6r4DxyJA9tspdg7uLdqPIW4AFI+iJfPHE7RsFaEOdZQc5l?=
 =?us-ascii?Q?A8KI5JSacmcZMeCa2QpX3folqpnk6+wU3PcbXINe0/Kg1dNjdKHiWdXIxTmw?=
 =?us-ascii?Q?9eVZheki9Q1LczfIyPXdstD1HMZtbfcOwW3rSC1OpviBw2urZ9G12QWyftgU?=
 =?us-ascii?Q?JdRreoz4bPzwL00itvc96ngsBAwAwBxND8Xr8kyBLGFrSTYTfnb7+v3S2MT7?=
 =?us-ascii?Q?+dAKEx3MOf/KBLluuGNsiE+vOtDKzrtTzCwjT7jg+qbi1lAIt55/I11MIs0b?=
 =?us-ascii?Q?r4ZvYLHIegRYU2ihyoendpaRzQQJlEShnhEViQ3ZGlb1OAKDH45+gWdsgno0?=
 =?us-ascii?Q?+g01V9YCFiHuuDEXW7RBNnzpjRd8CIie7IrJD/yfzWS2ysMbm61XO5QEgekO?=
 =?us-ascii?Q?Tqf5h4AtgN2jZnidwJu90Unkiemo+oMYnZIyFbguNsL2Z6va5VpKf3frltNB?=
 =?us-ascii?Q?yjudtgYmyY6PAxAS6GaSOn+MoGwrRgo3yN0lWrwtYAHMc1HitGIpm5IaPgNC?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6kGhK8AK81Ji3RRM984OzsmvSBiqwB2IyjJOMKRXyfy309Pa5Pkw7V2MKDSx?=
 =?us-ascii?Q?49i9U7pQIBqVFYQMeiSA7KuQjI0cd4zTJl60IAonmC7CUhtTHUQp6xs8mZmD?=
 =?us-ascii?Q?MZXsiWNBy0g+EbnuKYJURHJyK8vaxgTa9vxGcTu2IyKfGBgQXr6+0ZyMLpJs?=
 =?us-ascii?Q?XFsTV+Di3xz6xXBN8TyxS7xlQqh6fXAKborDXnY/C32HKUW/V/niSs1+/rmp?=
 =?us-ascii?Q?GTkMjztYUMsr4ut6ibRB9GFnRFlWdQc0YxfQcdoXq0orEH4Fo5MYpMSwOEdA?=
 =?us-ascii?Q?OuOD++YpUA4/RQS7/dWFfRfkztf0GUZi1tjxYuWWLN3se373U7ZdXT9wyJ3K?=
 =?us-ascii?Q?6X6MR+A++zLrGgw/6AC8/YjGLzUwHADYXOmzxrLDBOtsvWxAGrClVjIyH9q9?=
 =?us-ascii?Q?YIfbYn1bANT/nVn2Mqd0QOJ803cTmbH1ZMW6ulBqUOY8wVLbtFf+8RcpsB+3?=
 =?us-ascii?Q?HKpYxEGlbvhcpY7FKqYHphPhR+Hx2/8/4StSdWCqNJNL035NSP71jweA7+3+?=
 =?us-ascii?Q?s4r6Dz0z5pq8eStCM4DS7LnCf4NJyLAjm+mKx5nbRPbWeKhxc8MDLSrr31Fc?=
 =?us-ascii?Q?ycvOTAWQqyaLJ9BlbpAc+PNAljrEK3GSeAEPbeU7ZP1txTPuadyXHsbHhWIn?=
 =?us-ascii?Q?NSomidBSYF/5f2yI94Njj2IA3yQtLyIeomYF0djq0vKKF31I6QHpHabQvfkl?=
 =?us-ascii?Q?PDAZMO6o+7GXCrk0bZ7P/1lX8h2zSWNpVHMkQnbv6OAqU3qbBADFJRvXEILe?=
 =?us-ascii?Q?XHilFKbuuuWP4c8mKCaR6pwTl7wDQTOTn5swdVQ6J3LLfTS3uMFdrXHzq+ZW?=
 =?us-ascii?Q?KkWmzcGAto7FPEOXzLCneTFQqpaXqaGQgliIJ4A7WHRovp7AJtwvPjtrPajC?=
 =?us-ascii?Q?+zrtAVOcbt0trLFrGeTCWN8sLfNLW9fJ/o8+vRZuJ0mu/Q6n2tw/OVqpPowA?=
 =?us-ascii?Q?VORqPyI46Qq+qO7UZ/Vc+pCGgj2yAY/wo3kJ0ZrQiwmfMkA8JS/FK2tDynrp?=
 =?us-ascii?Q?799fPM0odKjWOpkwuE43ULyVWILlpW9YYZbdmDUWJw0kofUzBvtrfNA/9aF1?=
 =?us-ascii?Q?7nMjCoAn6mFr9JYcSqjP9Y6654JGE/WBRv5j/eAI+oVNAG2KsmpPasoBJclm?=
 =?us-ascii?Q?H/1pFfWKwGkmPF7Oc+Vgqq5Z34AW/h021tEAXu9p1irv1kqEHU7DPAUSaw4j?=
 =?us-ascii?Q?d5ZzqBQoy9KRafCwmD0AMG0w1cr11znR+RSXMxWv/fLtwJreNPhgAnIbWwRs?=
 =?us-ascii?Q?T9J11s6IBvqRNNcc/fi3vSc8f+/fAtJNDLVsZzc/oQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07394d8-3246-4f50-bc60-08dafb009455
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:08:33.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO7h00BYxkEmOqyDAhUSla2sv8ymqHdeXKYJPKuHqOu9rlBEO5yZoiUllDd7ElP7Qg/A6MehIR5A5i4sYNfEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=761 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200154
X-Proofpoint-GUID: UYXjd94tDjcXEM9zZEShW6Ka7SmfRD5I
X-Proofpoint-ORIG-GUID: UYXjd94tDjcXEM9zZEShW6Ka7SmfRD5I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
a function to determine if a vma shares PTE by checking this flag.
This is to be used to find the shared page table entries on page fault
for vmas sharing PTE.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 3 ++-
 mm/internal.h                  | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..699323be7502 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -314,11 +314,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -360,6 +362,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MTE_ALLOWED	VM_NONE
 #endif
 
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+#define VM_SHARED_PT	VM_HIGH_ARCH_5
+#else
+#define VM_SHARED_PT	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e87cb2b80ed3..30e56cbac99b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -194,7 +194,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+	{VM_SHARED_PT,			"sharedpt"	}		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index 6b7ef495b56d..16083eca720e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -856,4 +856,9 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SHARED_PT;
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.34.1

