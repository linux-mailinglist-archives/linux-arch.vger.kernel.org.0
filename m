Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD56EF8B6
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 18:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDZQuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDZQuj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 12:50:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5F5FF4;
        Wed, 26 Apr 2023 09:50:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QEiP0r015474;
        Wed, 26 Apr 2023 16:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vajezI/6KFRDU20RVK1Zb0wq04qKO5aqoG/UHABfwFo=;
 b=yi0k2pOCe7c3wbp1qDvGAwSznMmQoa8golkF9QOnuoMrL3nMbq8gX3+Ps2skQQN7Vw1u
 6gMdXryVtxbMlLiIfw6v2uVv8RlHUkL1xtv9066+xBWUK/e2RnQpM2srJZzXW6+pvxz4
 SdpHlSADaU8XPscinWEX7iJPkt2cb+vNcTUIKepRXK7Y9Q8vK0hmCeSCk05djIXskK0P
 lP0ZfEEx2aGR6GdP6JxF8PUS/2e8vsicQvvzkEzGZsY+CP9R8bUQA8NueQlLEAx94ldO
 MZRyMZxNmR0D7t67ouZAb3RTHXdeXNpVrg8g+0fniasQ9MMgH7/NweEoQAMcPUBLjZBU mQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fasvp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:49:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFOrdx032845;
        Wed, 26 Apr 2023 16:49:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618dqr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elCoDiMPdy3sSFYC5Ri0Zq7ScBhf77hk6iIpH0POXGw6xqit3oG4tnn8c/jcSBUuhkdQFTuUNyq1kWf8K2IETJ0176hlQl3c4KS+POvidnvGKUnAxhJ89vRYUO6LQpqDzFpIfGwRy1C31GEXYRYXTEo9bN7dv1/PvRW8AYR8W4Rjv3885E44M5nO7FaiKTxy6KO4bkBumknFJ1FrPVVcJKBInfr1OTMds6t1Cb8mrEBN6FADSykzYHgq9JJX4TBpZLQwJUMiOMjVqHqe0Y3XXP9IHeEuWub6wViaT/GXCPdiFW9lIn6ecnJLtRrdcoGZGUVy5ZGyGsYW8pRtmFkRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vajezI/6KFRDU20RVK1Zb0wq04qKO5aqoG/UHABfwFo=;
 b=ZMjx2KerNrU3cXi3vP7urthdkmlD6fjibILmVqjXt1iL2Zp45W2aEpg6qM/I1aAN4or8rzoq9yfRpKXJ+bBH0TrXyMH4kJLQGdijykmy3gLv0dg+u1c4vfELe3vnm9ZZ1lOxrXSnSgHP1JSW6SXnCrlYB7zvWwMOurfAbWwZ0R6/RHDy3pCNyaAw2BSy6Z/OYikyzZJtmiyGE7FAgcO89nu3ruMy9aWTmA7BMEI7NSDOLlI+gsWc2NzpkacBNNheDpGyf9TBFhbjcckfnduEylxOh6duQR9U2uu+n8M2ICIP4ciut5RZmRfYW9LJtw8n58C731g3PRkj8Fw7x6tlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vajezI/6KFRDU20RVK1Zb0wq04qKO5aqoG/UHABfwFo=;
 b=b7sWK9wULeo8zPRI7fKGzekcSwteXGqlf1ZYI5oiNIu8ZmBdtvM+Yodq7YtaDQM2KVV+Ks6PlSbFPnN2QvNdRJgRDv5bYIzyrdkj/crXl3FoAQzLDBkbKkev4z/H+F3btOwA0FUL5zmJq2bPGG8oSl5l9gPJYx2FkwVN8/hlPLk=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:49:54 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 16:49:54 +0000
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
Subject: [PATCH RFC v2 0/4]  Add support for sharing page tables across processes (Previously mshare)
Date:   Wed, 26 Apr 2023 10:49:47 -0600
Message-Id: <cover.1682453344.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::14) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: f48208d9-4fa2-404e-2c98-08db4676427f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5Ql/7VVXNJeJ442WzEDq9jcZEgNMLDUULFa9gYWKuI4qvBWz5clHSRfvFjp5u+t4uHXRnCt9jIUfPkDu5/vKNCbadFVcRqujxogJCXnULXrkCt7DkKJHiK6ZbZS7HN3fPJCScSMSsgiJvGfJOZ5K+30RiNUsxCxDQAUoQ2QpQby6ZX14iTkU3OkfpwY5c084VPh6qEfKhu7mlVopFnos+LuvpD7qzPP/vwZq+9HzgHwF0UgznQ8N7yQe0elRTIowsZGC5HfN916bNbojphhAQG0VZcDyKNdqF4ueXrXBzme67OkqDWnDsJHsxraNmNQyH+1hkJuurwMfYkd09g+drFyggsFwOuBq9JzDB82Q2c+oPj5CotOMOSyLo0Hru7mLRI94D4VNLLiW2MAXik2TmhKnXP5NcIdcNjF+oU3Rf9faMlTjqjaT5UNh9ovYHYGKkhedRilD980O4iye+aPlErtRfh7H3pcposMAUhvuWVEX5DPH5+AUCVpzrjONHz3z5VqzwCJu5gEJdEP58LvmT1jxvFtZFQROsggNkXBMnXJTx3va8e9YkfoLGbS8KBo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6666004)(478600001)(83380400001)(2616005)(6506007)(186003)(36756003)(26005)(6512007)(38100700002)(86362001)(6486002)(41300700001)(316002)(66556008)(66946007)(66476007)(7416002)(4326008)(6636002)(2906002)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJumpdJ6FROd9BZQK52KByoddLOORySJTQDM/+tbax93ftEpoSh0/xEA3H+G?=
 =?us-ascii?Q?yg1/Av2Wae0UcQgAgf4AGzkMPLXIGvKxyslZDF1DvVpl8OpzjEOQGHpICcLz?=
 =?us-ascii?Q?pz0woL41/qX10dPgPp3P/b5a+LZca3HG/e3CAsE696CWxtyhwixfsfQvvHan?=
 =?us-ascii?Q?lf67knL/SXvDOh3kTIO6zbV8tm9Uy3n8d6iD0kVWnISpILxwXRDg02t+KMkE?=
 =?us-ascii?Q?Z2f+wbaMwoa45G+9cEhaf1N4NFyYtdKig2gwPHynjlB3lhVsnBEWcSQvbmve?=
 =?us-ascii?Q?Pab55EG3/HTUjSQ1LzViZ6SefB7R8oI55eroiIYi8WG+bBxSjYiucEnqnB1d?=
 =?us-ascii?Q?MTojqwu8xOOARGgIsunR2RBsxmiBVU4+PXb7yxkCupZokDdKFOAiwtrHFdFL?=
 =?us-ascii?Q?amULtIVuipW8+kYByQDhwptcmld+r9zI7640Fh/it76S0kMJdmTBElPNrW0i?=
 =?us-ascii?Q?N7bcO1F+Sr/ZCjw1YoSuTOHWt9Zs2m9qDAbImHGYtGBDzLMtQoJcWIzKCvKp?=
 =?us-ascii?Q?FQt+D3ixPKCnYn5xSFDZ63+aod0zDhkDITHfLw4476nOOygxNW4WNbJowg6+?=
 =?us-ascii?Q?H0Jmai3gtO5X8aVnNtoq0XCPlTBnibhBws2e1FZ57Zvde8XKbRl+DdPNLHpL?=
 =?us-ascii?Q?qdfkYgEFZDgw45kZryE1x4efNkMuuEPUQPQugWv8BuUuFlOvwlJFnvSOptT9?=
 =?us-ascii?Q?xCQKknshp/ghLFn7CFPEU4up4MKQDZCeKcY7hzrATp6DB9BXNA0xvRFwG0VW?=
 =?us-ascii?Q?pUdPCTV8k5IC11C+46Qau5ibr8VyTG/oBpCbQ7tI8H/vfNR5RLSLP6Nnv+bS?=
 =?us-ascii?Q?bvzJ48o7wWpaJhFGAcIPYQC918nYiP79WEOy4+J+evlosSrScWprQMCOemlp?=
 =?us-ascii?Q?mm5qUsqiK5nTWc+psk5HICLCoJz1GxY7TBL2cYCtFG59hK+H4VMZFvGfTRh8?=
 =?us-ascii?Q?ZV40fizn/sDrOOmcdwj5SVhNv7Xj6+99DRu9gdpOh+nR+1HAFwf3Hu6Z2i+U?=
 =?us-ascii?Q?x6sa/McCmNbfhKQBxag8oKCGvXKWKqiWSnPBplNXlexA1TSVX8+w2K148N4C?=
 =?us-ascii?Q?d3xxcsZjnAzbWslpXp2uLL82pdAiO4WjSAfaFVkpKMlpZrU1ezCzgGZwLS3Q?=
 =?us-ascii?Q?/dg0PdyFMkjRNKPHJqYV4o2ijplArBMrBUuMLryRf/2siwvYqEVmLtAeUj8H?=
 =?us-ascii?Q?KNTDjtZRi5QrYSGqtXMNhDYkp3Ihw7WNi/V5eLH+vIOoAJHzIxderDi1bM7g?=
 =?us-ascii?Q?o/DS/3qtCfuNyOu9PFmB1AkbSzLyJkm+jSp//4KVvIH3c/4LF4Aaae4fNxRP?=
 =?us-ascii?Q?iwKM3meT2fjjK25O+XzIED3ZJ3CspRxFUbsN3Xld3mUMAVGhEvqtiIt2dulP?=
 =?us-ascii?Q?XnrBOTjmN8PpieMh5JQGcjdIJVhxJ5UOA4U7cdpXCxoA8hV2KMk7QV3zgQP0?=
 =?us-ascii?Q?ie6MC+cjc7YfUfoAT7C3L1DUGhDr/ewtOzyKY4xctZIjICXOcrSW8oAXvC1E?=
 =?us-ascii?Q?GqXmT4mHlJIztkzqDPuFChlQYJnVo/OB1yDqedDsHFxlw/65Ge6Z1c1MGHR9?=
 =?us-ascii?Q?WmYWfCY7sROPivS30UIzAVKj8t7h5gDqcUOzYr/z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ClgyByCzEo0zCKLplJ0GXHGY/vhKqpApGchkqQEK07LFoP7vC3dpsT42OQHZ?=
 =?us-ascii?Q?FAHBnLcXvUH0AvHox4eV7/iDRYOtWEnci9AmXI+PcpDZ0+zaXV4+l+l42IzN?=
 =?us-ascii?Q?iBnrm8iSkGDZ0xu35F5WA+s2F9vE0JcIXLsX5TYpXjo8mm4LOPtV5ScGVVal?=
 =?us-ascii?Q?44gDN2lleTQeJmNNOBYn5f9o8tSUQWiacTm1uNmfvVWzQBulxhI2dK/inUmu?=
 =?us-ascii?Q?1pZn4uyoLPrrpI2fkdr9yCw7VxSFWFWmmVo5iestNDVt5CRI/tQwGRE5OYzj?=
 =?us-ascii?Q?KiylGh3wlrhO2m51n+auB55BJoyg7oT+uj/FbZFCfIEQTY8SV2Qm/7hc0s8n?=
 =?us-ascii?Q?M9cypsyoVJKwTqQzl0MlF3YgxZmnn2gmqezyPF1h4o4MrAmb7nG3VN2mpK9M?=
 =?us-ascii?Q?waDK+oxXjs+bzFdYfxW8SaGozipvEZDkUonK3L49Z/ytFeHgHoIsqJ+7ifPu?=
 =?us-ascii?Q?JohFbYRW4ky9Rn2gOKLBC9kmXOlxJBS0ljVo8Um0D2wn/fkHbJ51Ma58A71x?=
 =?us-ascii?Q?VhI66Q0s0h/GKUwfc/4MwsbyXXnDh1XuipfnDVFyBq89R/xcnntP+DrNH+3P?=
 =?us-ascii?Q?u6wL0BSliCbNJROMwNzjthkbU2k+AWm50dklPtJpqkLc/LYd3vhQzKpCg0ky?=
 =?us-ascii?Q?dPKcHHj47/ujl15eRqPcMy8KdVeISwtfJ5vfnatqLtEK0MfKzD7A7jJhAF7k?=
 =?us-ascii?Q?36zNjvOeWpXOyZ6DUWT12rkEohXLqMwTPJH/wpHCmBWDj+0Hsf9iO+DoAkHC?=
 =?us-ascii?Q?qwzEQgi2k6IWG/s0iXW+/OTtSav/IcC5uxJ9pCW7FdXgJApWiQKgR16R61SK?=
 =?us-ascii?Q?t43dsaJescOQggHzisGAQsd10dQcwRU8jPdMlKte2O/SvA1jNqQ7QMkk5lsR?=
 =?us-ascii?Q?PoDxnWjhvzC7x8HHzjqIKXneZI7HC1vOpPZc140vI9yY6g6K9MD7loasFqjS?=
 =?us-ascii?Q?U1e++4uA0+XbKZ6VAz2TDZm/IuA3qsiKkWVZjx8A5KqpqbEIcaniO8N1hdS7?=
 =?us-ascii?Q?XlUnBLmbI7aCvmrijJ8pj05NxrkkzGJyEIvyNK2ei9j2Gf17r4J1QbTI6Pia?=
 =?us-ascii?Q?ZJAnfN2FBeTB9CWgxRgY666wgAgebdlIacSamxmWdyV+aXX/uQP4oM2juJg5?=
 =?us-ascii?Q?LeXoPrcZYfyeZvKHXbk69RkhsZNSHuYcai19tMyyoublWZRq3+7f7oIo+/C+?=
 =?us-ascii?Q?iwofzpBe8pGdRWfdTxp9FOXB5y8DmK1sZWM3nxpdafevN4O9gzV8hw5+MmOL?=
 =?us-ascii?Q?By5sB5qmcUmpKnrNObybzRgNj2O5OG9yzKpJ64SDenmSLZDJjCCHQE8O8f2w?=
 =?us-ascii?Q?4mLNoGCJAwvTHAcfAGwWZnej?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48208d9-4fa2-404e-2c98-08db4676427f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:49:54.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ky6RrUNmPKOqOwNJCixeP5Rj8hOhqamms+d5obcqFEILkKHzKZ3vyZKMaJfGFjrhKA5PfBKGoxGYrP6WSXASaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260148
X-Proofpoint-ORIG-GUID: 4X3augm9Xc6vnxwR6XQ1O9qbnVbAcFe2
X-Proofpoint-GUID: 4X3augm9Xc6vnxwR6XQ1O9qbnVbAcFe2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Memory pages shared between processes require a page table entry
(PTE) for each process. Each of these PTE consumes some of the
memory and as long as number of mappings being maintained is small
enough, this space consumed by page tables is not objectionable.
When very few memory pages are shared between processes, the number
of page table entries (PTEs) to maintain is mostly constrained by
the number of pages of memory on the system.  As the number of
shared pages and the number of times pages are shared goes up,
amount of memory consumed by page tables starts to become
significant. This issue does not apply to threads. Any number of
threads can share the same pages inside a process while sharing the
same PTEs. Extending this same model to sharing pages across
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
This flag can be specified along with MAP_SHARED by a process to
hint to kernel that it wishes to share page table entries for this
file mapping mmap region with other processes. Any other process
that mmaps the same file with MAP_SHARED_PT flag can then share the
same page table entries. Besides specifying MAP_SHARED_PT flag, the
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
  as well. More work will be needed to make that happen.

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

Some concerns in this RFC:

- When page tables for a process are freed upon process exit,
  pmd_free_tlb() gets called at one point to free all PMDs allocated
  by the process. For a shared page table, shared PMDs can not be
  released when a guest process exits. These shared PMDs are
  released when host mm struct is released upon end of last
  reference to page table shared region hosted by this mm. For now
  to stop PMDs being released, this RFC introduces following change
  in mm/memory.c which works but does not feel like the right
  approach. Any suggestions for a better long term approach will be
  very appreciated:

@@ -210,13 +221,19 @@ static inline void free_pmd_range(struct mmu_gather *tlb,
pud_t *pud,

        pmd = pmd_offset(pud, start);
        pud_clear(pud);
-       pmd_free_tlb(tlb, pmd, start);
-       mm_dec_nr_pmds(tlb->mm);
+       if (shared_pte) {
+               tlb_flush_pud_range(tlb, start, PAGE_SIZE);
+               tlb->freed_tables = 1;
+       } else {
+               pmd_free_tlb(tlb, pmd, start);
+               mm_dec_nr_pmds(tlb->mm);
+       }
 }

 static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,

- This implementation requires an additional VM flag. Since all lower
  32 bits are currently in use, the new VM flag must come from upper
  32 bits which restricts this feature to 64-bit processors.

- This feature is implemented for file mappings only. Is there a
  need to support it for anonymous memory as well?

- Accounting for MAP_SHARED_PT mapped filepages in a process and
  pagetable bytes is not quite accurate yet in this RFC and will be
  fixed in the non-RFC version of patches.

I appreciate any feedback on these patches and ideas for
improvements before moving these patches out of RFC stage.


Changes from RFC v1:
- Broken the patches up into smaller patches
- Fixed a few bugs related to freeing PTEs and PMDs incorrectly
- Cleaned up the code a bit


Khalid Aziz (4):
  mm/ptshare: Add vm flag for shared PTE
  mm/ptshare: Add flag MAP_SHARED_PT to mmap()
  mm/ptshare: Create new mm struct for page table sharing
  mm/ptshare: Add page fault handling for page table shared regions

 include/linux/fs.h                     |   2 +
 include/linux/mm.h                     |   8 +
 include/trace/events/mmflags.h         |   3 +-
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |  21 ++
 mm/memory.c                            | 105 ++++++++--
 mm/mmap.c                              |  88 +++++++++
 mm/ptshare.c                           | 263 +++++++++++++++++++++++++
 9 files changed, 476 insertions(+), 17 deletions(-)
 create mode 100644 mm/ptshare.c

-- 
2.37.2

