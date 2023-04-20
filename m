Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D856E9A57
	for <lists+linux-arch@lfdr.de>; Thu, 20 Apr 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDTRIg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDTRIe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 13:08:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30520A1;
        Thu, 20 Apr 2023 10:08:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KDwk43002114;
        Thu, 20 Apr 2023 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=oQ7QWHfo2/xmEl/nFiOTQbPvJgGYvETA77vPtdyHvbM=;
 b=jm0+6l9O5ftYWDGZD7lwVvgOaHEaxzwZp3h6MFMInEEIRcW8XgWyHNNm98ORt/Fwlnp2
 FX2X52NdSWTf6M9wUQkhrd2o6D3UX0dEWT5/q6spcNTBt9/XIgiC/0jmzgVAaMZeTKhQ
 Il1snuvnhKSlG+qVWZ2HLvfy9sN0q2qDn9OupUT0m4SGDcDkXHEInTXQq4MkRarpbPBM
 rJ5vPA9a8+4oR+q5c4x3sHs0qxSi6MS8LHxFxuT8pZRjv1Mrvmhra8sKCkRlhT5LwBiR
 oQxPVDMK6aWJ2fx0u6LPT6+L+Y4BqZPhskXWvkrhGlwZFVmhukXQeOIrkBKcuTMrJA5m fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu3e4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 17:08:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KGRGDu011173;
        Thu, 20 Apr 2023 17:08:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc82cve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 17:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3K/Mn4+fxw0ppMgjWqFplkd/BCwrPtjoB13bQk9tnhRez4qQdLXTUwjAI1nhVMomfuO+v0ZnZ6n2pStw2m6Ilq1TSFZx+LByLY9zsARrP2rlQB+35+hEkdknB7oX0tuBToGu74pv19THIPCwutly1rm8YNaK/Mh08XBZ51J83dSU0WOMHHaddnReITRFPYkyCEm0RWnhBf1v6hfqcSZ/gBex4IdH9JkRRA1hXzE72rRCA0U4HlvGxSAq5SinOuGFFQfah5TO8HpnOT2zneSxrfKYZJeOUqZDP0+Ty58/d3tsi/ccHwfm1/CBovKe0T94AMJTVy0IqPcAfPPaz2CGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ7QWHfo2/xmEl/nFiOTQbPvJgGYvETA77vPtdyHvbM=;
 b=fP5ht8wdHhwzsNVQ5WNcXIW4SuT0vXSNf6hF6K71DF3ejw6Bs0JBx1kRvVnzrr3AukQOavkUBAOFRnsMGaBxBvlLa/DNsapHoODDs5qN/sENsxG4vXD9KU0ibmjJW5x39lihQIuoONhTZh25+A0XmuXaIsjJSO1v5ZqyKwJ9WvN4ppeP9HatTMqVtjRATv2+icORBn5VU8Kn8SsMKp2lTSplSIO33ZhkO2pEaRgJugi/Os7aPEHLw4cmlcj4k6A8eQbEoXcjx9w1YNNC+ajz/6qQChJbGEbsGwb2LFIFr0zTy+akUuAfv1e/RB4SIv05ORvRM1jJeS8KYUkgzYgrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ7QWHfo2/xmEl/nFiOTQbPvJgGYvETA77vPtdyHvbM=;
 b=GHPwJQaGelefFSFNGrwmI53UG23PXyjF3ix5i1et6Xyk52Q5SgdBiNct/GZx3yXPOd5OXwUzcfsoEuk5VzGmFVDKsREH4QaUmCIeZZ5Gb6ugRK6Jp/x+kKROL/TTpZ6y2PoK9fCKzuKJ7+d78wXMgHj84u6B3QLwHL+fYKNjSKg=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 17:08:16 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::64f7:13cb:da5d:24f6]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::64f7:13cb:da5d:24f6%5]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 17:08:16 +0000
Date:   Thu, 20 Apr 2023 10:08:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH next] hugetlb: pte_alloc_huge() to replace huge
 pte_alloc_map()
Message-ID: <20230420170813.GA8230@monkey>
References: <ae9e7d98-8a3a-cfd9-4762-bcddffdf96cf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9e7d98-8a3a-cfd9-4762-bcddffdf96cf@google.com>
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 302b2785-f3b9-4f77-c151-08db41c1d51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yD0Ik2exIF9z5Ocs+Z45Y+PuRrQs7QQR6DD+b/bO6BY7LDI+7XWwX8v8wgHkKn940DQOKBwMPfSq8glTHM8GgyhzhvJDmrpfkr6U7laHbyvBChrJD5fb8Esqfr+FiV1ncSc2MjDLM1GaE97C8iubvX8TFtdA2d+9Di0s18I9lQw/WBUwRzJhGfXft2/JhunVtlSrjoXq+Db3CabE4rxgRwV40X9Ufj95Api1Srq/yyYnNsdccDHCgabwSqDkYOK79cxvh20qoswBmWE+k4ipv7ERjdQmH/CAcq5mjqFtSpxUIvdpkOpE8tN/WvKfvBl+z4z5MrSWpwDU4OUVkXvoK07+N0mbmbzuL29PM6CZzKaDQ6up1fhDR3rVTPcJrCAXcDpg4iR7lPap5PB0spA6/S52hb2bm1jvRbKcv4H1aXvlOre7pDO+sAwVg76xGO5kNDcfkpFSCTvVatffZJKtBCY0Dx8XLNkhWL87qA3siY8LxEPCejgV3vlqbX4WpjbIVOyqBfHInO7XRvIC7hkU2n/yOsIetDt74Yv9QPqXBUwrAnwnhpGjLvVqbcdkE/wRacj7A0ZAB6HS3mbrYxo9jTm/6D6dsoBZ4m53Q3OCwwuY/V1pOvo8PlY250hOPDHHSi6ExMUx1JTe2gdKv0fFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(1076003)(44832011)(6506007)(53546011)(6512007)(9686003)(26005)(186003)(4326008)(66556008)(66476007)(6916009)(66946007)(54906003)(33656002)(316002)(478600001)(6666004)(41300700001)(8936002)(8676002)(5660300002)(33716001)(6486002)(38100700002)(2906002)(86362001)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z95yC8WMdb0VFeq6XDr6uyh+sVDub0Big5T/w+39t213mK0efPrT9Cn5WHFV?=
 =?us-ascii?Q?N9QHA9UdyLQXL0RvngJAT7LOKuOMs4iB8nO+nDW+R8Yd5epd78WNI6LK4YQS?=
 =?us-ascii?Q?jNcoX25B6HBpfwipTzNm9/jNtvTiKdlyT5x07jhJaUMu1I9l7HbAQ7BQ9ZRi?=
 =?us-ascii?Q?gKXogV0OH2Af2sdXn+nuejqG8TXpwwPEiykQd6QmyceD52CIX/xUhdVI4hrZ?=
 =?us-ascii?Q?eqdG+HUF2qyYQKhURWrqBsqldEGviDl6jO2hNN2kDtlWjJ5JrWtaFIPLcirY?=
 =?us-ascii?Q?WzvRaKFn2lGRwMxI+eYRalve1MULJVXehreyZZIRnzcde6REc0Yv35e2Xk2E?=
 =?us-ascii?Q?lXK7ypTJnSmP2UAp3liNtAPBEnEeyhueCSM3dDajmncCTnmGh7o1Ob8jCVZN?=
 =?us-ascii?Q?opXSOvS+UVagxzly7WunzKhjoRsBhCpsOXJ+GTwKsyHYLLGssRzJZgcv579F?=
 =?us-ascii?Q?LFNoSHXZW8XP7jgyRGDcLAc/B4YjiavQwGp9PJ5mrhmg7F3pSW2eSsHU+wzE?=
 =?us-ascii?Q?gFpeDmMew8YV5U/FRZNvPH6HW/0t14o7vKU1w5wwVWjJWGFzloETpgFxgBij?=
 =?us-ascii?Q?O6TvyTsJo7DJgiY4sNISpibd9hMs8tNj+WRma8E7iWrth6IQVTgwJo6pj04z?=
 =?us-ascii?Q?HPnJnjKS4mjnt9xXHNzLCFRgVP9mTjt438w9lZImelwHeI/AEO9sdhq9dE2y?=
 =?us-ascii?Q?ETY7w+Wuh8wmc1ZuFBod+0W0jTeWvg7aIQTbCllTwWCKq/h+g7gPqtGgihcS?=
 =?us-ascii?Q?sUxuXJACKwfCQN87zSgxrn16WfoeY52PNNn2k0COiEzwdVG4ZvS23UtofRaR?=
 =?us-ascii?Q?/bdJqQcy4UVh9k2pt7760gq5QhxnCNJZWyoo4M/gFsVrcv8yztWzPeZXbMnd?=
 =?us-ascii?Q?MVNaZIEOVM2tk2jqtLL79Pcl0bgNUPv/+loohIwuqXYbyZRWYwFHA2x/6nDm?=
 =?us-ascii?Q?kzT7VUemoZguahMW3Kg+m37OBvjj33osbSz7C/dKevPxv1SQSFU+Z5tYAGEC?=
 =?us-ascii?Q?Gn0DcAxn9/TpwKRltrOkO1lbnINVMoXkufgKAUB4kYfnc/yrChC8RNXcE7Sx?=
 =?us-ascii?Q?AnKdsEMOZvMX8cIVOHUXiuiGsZVHFonue75U306XSs1udSzuREPnDloCzX3T?=
 =?us-ascii?Q?fyfwA8dbwPFfioW+fRCgSXmKiZm7ARRJ6/SQ65Dp7j6gOsKfscTZ2JPWwdCO?=
 =?us-ascii?Q?te34K0FavqlEKV0poP8xF1oUhwX5oUx41VLmGriJozmTKggR/lNpnwusw5um?=
 =?us-ascii?Q?0329SuWcpeQT1/SFGuqzh1sQEHQQIuFlMlg/hitYOLkRTbTqh5vghBimJ9Y7?=
 =?us-ascii?Q?dwybdOusHfPKMoktAOG6HRHVuVBEYKm55QCb9NxHdTSBli8sBOf3W84cRCk+?=
 =?us-ascii?Q?FdD9CBdAmQeHLOaA24O9db8x5YcLEuPZNffWZSqZ8ztsxF5ysu9q0Ox3zSEZ?=
 =?us-ascii?Q?St3F4VNjVjsKPRLo0bz/l+vd5Yo6rEs1bGhTzYw46yPpA3MSPM7p8zgzEe/m?=
 =?us-ascii?Q?lsg/wEr2/4kAsbj5QLH/DtjJ1b1NaA1SrxuLvD7CV+i/qjucDu+v/bsCATR3?=
 =?us-ascii?Q?pZq2EFT2xmN47n/gb072zKxImQf+39Ojd1T+dgbW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /cbJ28GGKfz/SiBw0InPM5tqZmUxsJdiiiYKGpjjURXvcL6ovyHfAL09Zambr1RppqotHSvLGf2ZIZzjtYtTTZhIofM7jMhkMuoWe+7oydyciAc67/Ehnsf9Tv1rK+8VXyg0bnvb/a5n2NCIAVNvdIbJKkPG2EBEQlHh3OQeiYlCQ8tIJfpIeEyELZ/SAhEoOAnVdaIHVXJtU2TUCijgwlgboM4ANgED+lFR6Jpow5Kt2fCe5wpByv3E1xBnZfKPnBRC2RmxDch2D+hrmSFdn4XrjQ+oILF7WMleR9HEIyGQuo7noTZXqUARIX9mE1Ne7BZRRnDle92AEktbKqve8OODj0oPKcCrBlpVyySnn0ovM9uaDUGWd1XRjOEKsQEQx3gzj91lLJ+hkzPw40qp7I+xF9zd9PCUjGP0GI2JdklSlOyK0KH30kHelUf1ajdIpEx0BXov4GVhESNVtlZS1UjyrPHWin89p3VuNyTe1GypK7+6WRVOHXnhGp/ujxYazcbrBppP2xtryoW2OrkPYWryH45OphG2qwZhHjcP1je9esT6/pFwtVhTihq9hPCCALe0vvNhwKyhz21HcW+SX87+mx6un8meGf+7vszYoIww6dJJcbOnlfNA4vWAFX37NbH4o4mPbjBI17eliYHK4i6xm6QlZ8nKPuUYp5IzWAJFScBQV7UB90sgrU2yqttCsH0UpzMCeWq/3umHWYd836hDwUn4JCdGZZLElyZwc9N7NENQ9Ym92RO/ioZrIqRWbv8wL4ZYqBMnySrNNTkIa0pDwfw67LHRIP3fUIENqEmT4lBtstmo2HmK02a1zHpe597q8yPki9TtGE/FokrEfRo4zIyJuJzAU6D2Os8avoi51Ivhal0tpdTmHUD3bGgl11LoDs+bdl5M2FxAZcu3ew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302b2785-f3b9-4f77-c151-08db41c1d51b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 17:08:16.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvMLdbcM7hUeA9HFSmIIGOmJCCDcKrdtUYvyZhV9YbOCDjIZLo4Q4o2uqfGPasBWLvYaMl2GrzLtSU6twREshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_13,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=734 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200143
X-Proofpoint-GUID: jDcY2Jsq7imApisl84tTpP63Za1ONkyE
X-Proofpoint-ORIG-GUID: jDcY2Jsq7imApisl84tTpP63Za1ONkyE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/18/23 22:22, Hugh Dickins wrote:
> Some architectures can have their hugetlb pages down at the lowest PTE
> level: their huge_pte_alloc() using pte_alloc_map(), but without any
> following pte_unmap().  Since none of these arches uses CONFIG_HIGHPTE,
> this is not seen as a problem at present; but would become a problem if
> forthcoming changes were to add an rcu_read_lock() into pte_offset_map(),
> with the rcu_read_unlock() expected in pte_unmap().
> 
> Similarly in their huge_pte_offset(): pte_offset_kernel() is good enough
> for that, but it's probably less confusing if we define pte_offset_huge()
> along with pte_alloc_huge().  Only define them without CONFIG_HIGHPTE:
> so there would be a build error to signal if ever more work is needed.
> 
> For ease of development, define these now for 6.4-rc1, ahead of any use:
> then architectures can integrate patches using them, independent from mm.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  include/linux/hugetlb.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Hate to say that I am ignorant of the 'forthcoming changes' that might
add an rcu_read_lock() into pte_offset_map().  But, the reasoning is
sound and code is fine.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -183,6 +183,23 @@ extern struct list_head huge_boot_pages;
>  
>  /* arch callbacks */
>  
> +#ifndef CONFIG_HIGHPTE
> +/*
> + * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
> + * which may go down to the lowest PTE level in their huge_pte_offset() and
> + * huge_pte_alloc(): to avoid reliance on pte_offset_map() without pte_unmap().
> + */
> +static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
> +{
> +	return pte_offset_kernel(pmd, address);
> +}
> +static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
> +				    unsigned long address)
> +{
> +	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
> +}
> +#endif
> +
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz);
>  /*
