Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC96BC420
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 04:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCPDFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 23:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCPDFU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 23:05:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7B9422A;
        Wed, 15 Mar 2023 20:05:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G33afQ032207;
        Thu, 16 Mar 2023 03:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zUWiKyyfPVflnRe3UfowmVHexRuxTOL47Q+e24hlX6U=;
 b=Vg38G5Y5op46AMMa4SR7OAp4V9s9zTD8MKNbUYqVzWnffZNYmSEEiMbIK61C9WjbHh+n
 yrCU9ZyaxEF3Oyfd2hZ165Im8E+5zw00vWkLjqLWiVzgWcZJDYe6Lqj3XLG3QLH/+kUB
 Dt03IHQHUTMjByx79X4c3kgwOIaPNHY+XT1u+WxlGtoxrfgNTS3cVd9QT/NIa86QRcBW
 W4Kn5cq1HV54J6Emqw4HMNG+td0r8qV3lj9gUObEyCcBwksHdVJ78cystgyn7qkkH68b
 KpYd7kHtpnex8GW5BL9eS1cjewXEx5ktVLV9m3R1aB+4AqSSDSKMiBZAbvRrf+mqtfqe zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2603rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 03:04:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32G2l2wR029646;
        Thu, 16 Mar 2023 03:04:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq4mu2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 03:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMLqg0e3U/COz/yth81PFpAiU3Cz/sBcneUpLEurA+huWWocuNj8unAHqdCw8cstBwE3XOnvQZb5ehF+VCURwkGPvCPSfUANAyJZmiZRUEGZaTvqochgEFVNhZX7S7HS4aZHfvRsbrW6vKPyW2QL+6EsWPK09YVotrVwRLh+n8LLqaHxfAEeZQoKiEWJ/60r1lGMX64+GasXB1Pn575Lc2BacNqySKn6V6TRntDWN0Y5Ql2iO9ewJMpfPR5/KivZB11A2IVvgJ352D6pBQ5ka+wtxbzA0UULKptxeP6Zp9EV3va2iACbfKE6o0YWDSrRy24sGWt59HVbRxyQd6KJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUWiKyyfPVflnRe3UfowmVHexRuxTOL47Q+e24hlX6U=;
 b=KVfY6/04VLAh62xWPICuohNvv+F6w0Yi++JAogUvOzdk/FO5APpmbkfJF3B6BZzH2HY3uY2vaJAE2SrLiLwQC8Wq+NX+s3UN0NjXK7XmbAVNJSpcCYJ1ETYB27FZ548bgGTvt1JurbzlVidYLlSrllONYTQHz5IZ3xlwDVE+tXyiVBuFntsjZufPbTbKTqiXlzMsPaEE0k4YunPndajmQwROMGzdPiV4/hh4eHMO+zCObRchTSdOSJDmJ39PaPUSCyFODa/V8VtrsKXJJVb7SY55DsH5FSnbAbEQI/3nvNprGaDvLqD3fluiqE8ZipwVkM6TkGdNhK/rQglHeuv0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUWiKyyfPVflnRe3UfowmVHexRuxTOL47Q+e24hlX6U=;
 b=qgsuMYQYXIssJIDSXeFuBjmPbclxU0rl6P9msa2BSuSWVg4kzGYTmu6YKxZrYjKA6HzbRKcAG1q5iL8J+LqpLEg5iwEt5R1SJfxFouprM7/gTbE3lhWITEJLkoxMQQ5xuRTY0+x9TUmpE9U5+dYv5uADjy2GYZRnyZI8ZKtM11Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Thu, 16 Mar
 2023 03:04:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 03:04:41 +0000
Date:   Wed, 15 Mar 2023 20:04:37 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] sparc/mm: Fix MAX_ORDER usage in tsb_grow()
Message-ID: <20230316030437.GD3092@monkey>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ae0d4e-44d3-4b58-5237-08db25cb2f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjvvqSq0IWDE3/o/0FMdbTw1oDfVipfyLWVNTdwt+e8cLhbqkVLLghxtOyghSWlaRlWxfRABITlR2iB6oACU9OPfDNalksJ5yyXwAG69iSzQIE8sWuzuq+xhNfpOIZHCf80zi+dFWuRbzHhthvEzEVqkKwCupIWBVBSzg5Odyo1dmAOgyMnnE3AMWktnFUHBQjdXdInSb7d8TMp5IAGvFFLarFdKXUb5kDNSqFnEN0zW7vrJRqi8SpVsNGC/EZaMrxv1TzGfonMIzjWePX9XgcnKJOlQd9tSoCJvhQjTkOTH8uAeBOfgZXcYUD6BcosYDDBtGXI/A7NcTID6WjUOyUUT5LjvGU1qAS+xIVCT1knOXIsJ/EJKLF1YwbNWcr1MzWuwdqsUtGTevTOiTQLjRqce6vxwA+QyPHxthuIwCV1RYTB6YNNXHvUUqFE+5UaiSbll44vruiHycYaZhVWfG6r9aURtNiXej5dWKyS9uMCyVjgIva5ZzNZ9Mu9bpPWCLzDOFCs52cYKFwXQQM0DH/h0rR0P9vTTEErjds6o25t5i7yhSS2U60p3JLAZtyrePa6isy1rAFVq1dGXoRb2t6yLEEKUL/vMWn+2QspSUtKZfSwJVA4JAfFeRS231n6jldPMr656WjxyU+ffUCHk6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(5660300002)(2906002)(7416002)(33656002)(44832011)(53546011)(186003)(478600001)(54906003)(83380400001)(33716001)(6506007)(9686003)(6666004)(26005)(6486002)(1076003)(6512007)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(86362001)(6916009)(8676002)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtPxge8hek8NewzKznBe/PNZZ0bn+YHELfiBWI75RYNL723eH2b1IBjMJEuR?=
 =?us-ascii?Q?gYOfZiCvwe4F9NRcN2bptjB3YoXjtCzNMoluaQXoy8Tonvmzs4HRk9HAzrBn?=
 =?us-ascii?Q?TC7GvSALowhggo8o6R2JHlJrYejfvdkCvcN9Tn5GXXpMLlHqerrCVOWwYp/y?=
 =?us-ascii?Q?c2UcGQqNv84xjZ8uc7rOQvUrvWxJQ4/9UqHIcSz8IRHGzkq8YrHBxPIyEft5?=
 =?us-ascii?Q?CW4jpj5FTyfr3ZQ1PIglPs3HU69OhYNLlQx7OSLtpOQsfWv5QpsA1EQ0MAUl?=
 =?us-ascii?Q?ulnjo1T79wyTKUqXuUS2/wHmbMWEuThGyZk8jP9kAT4IqyvL6FGAA6jFY8KZ?=
 =?us-ascii?Q?IhCVAnD5OG+pjJew177F38RLKax4wStv0f0c2nPWbwfmx1SAvSHVQXb5fclU?=
 =?us-ascii?Q?3qU6Cm2aH1tmq+QSJfrxPhNUkl89KW6ch/BMj/zG/Eb8NWY+h0MfxP53ocKI?=
 =?us-ascii?Q?bJ/q3JCUVsO8DOyc/80FULtNQozDtixR7lAU+jceMSTvIqvIRdSvuy9qOSZu?=
 =?us-ascii?Q?5Hm6l/HtP50UtxIetCkB0B4T36pr+HMVe/dgnJLET/hJAAURy8I6S+5DvXxc?=
 =?us-ascii?Q?VT7juez4RLJxgu0lTaFzHuSog52u4+ScfJfydHeN7/BduFSctto4k6VyB2z2?=
 =?us-ascii?Q?VyOSp1exw3Ju06wCrbUp16tPlfKKGdpcqJjHg4/S9G/WRtpap+Q9KeKm2936?=
 =?us-ascii?Q?IDTGKvmzEa2DA5sSGO4Ir9wvoTSginmyTaP4IWlaLwKZc2OOAsSOmw4mThLn?=
 =?us-ascii?Q?2kCsEpD5glBwRkLUqnWVVTP6wR35FjXbYN21bSUp7JCaF5hqiD72J4ONoLmu?=
 =?us-ascii?Q?fwiLMqSRgl+S4/HQ50NVe1GFL2tR8LDurE3g43SA8sYd8rbLK74DG5rNgqJn?=
 =?us-ascii?Q?TkInYPSjvJbzD/GtmP88Sp9yQ8ZTqAr0R1QuhSHFIUcr+wNu0qgNd+hXURnN?=
 =?us-ascii?Q?hy30H76BCEwUc1Ky4PHHwJTqRfeHpKAaa2r5Hoi2pPbqbyXZm7nBlSuZUk0U?=
 =?us-ascii?Q?REeR9vyspAGE8s5M6PBOVSQwiSIX/OOqSdca00lTijk8O8gdop0/0cxh7Wqt?=
 =?us-ascii?Q?1fIyVOfcX0jl2w1JpuBZl7rTrrKLsH6Uu1U9aM9sIlo3JrcC8WcEzakEPsix?=
 =?us-ascii?Q?HaEPfoxwTl/vBg8dzSpqDJp5Dtw76b2NJP1Vm3ck9i5KcF81WK9bbn9jWrQV?=
 =?us-ascii?Q?EPJGZBDtPjCjxwxKtkRQ9qnsq/CWDi7ZFbhXffZPZPF97qkpwTR5pdnii5CC?=
 =?us-ascii?Q?RxXQyNc18OqWgbXJXwzX6bg1OypE0QfFYafY3fUBdIDHhncu51336joRs6FB?=
 =?us-ascii?Q?a9H8EoTtqfZMVx8mKzp3fMaH8KRdYIipxuUh0lt7fsMaIHyHxuOrMe73h1+w?=
 =?us-ascii?Q?2kiFUfOHUnZj1rg2taUu9RYEe8RoKX31nKswFUIRWk4AbTsPOVLoV4fGQS60?=
 =?us-ascii?Q?vDk27jrmFsrLwaDwu5DSKC+pkMzeOJjlXY5joYHWCY7f/vFDm6+NLccfT+IZ?=
 =?us-ascii?Q?HnZKBtBX9n5d7/mz3hssZDl6ZNMmo+l8ioZaAkZ0nKmHWHGGgPbHQMdoi+8c?=
 =?us-ascii?Q?zG0CWwx+d1FMlwCtrJhKss0Dn3r6uwHm0M8iJlmhr5vMwDtTNA8i7YzTsLc6?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GE4F734VzrhR/Z//DKqVbRSeBfYcDcuJURxEfCpKijaKrxLr4t8DWjvQcVze?=
 =?us-ascii?Q?SGIRseJmLlWjNAya943PpdMA7+VYSROXfVQ0+CRxGYy303Y1NpK8xbWoGum3?=
 =?us-ascii?Q?ZC0PJEhrtduTImB6j6GKY4O4o4ulLwNSjkeR2XAzJF3TNrznztVbdfR9aH2R?=
 =?us-ascii?Q?IcsgMuizJYz4RTC6AONG4uk87Jpv6K2QPXD8cmET+fRRJwVslW0AW6maQ/jY?=
 =?us-ascii?Q?DlXciotJ4Wayn34lSvX81/IdOBJUBwh9Zkq9QBPT+BMBrIk5/0GKnM1SpsXi?=
 =?us-ascii?Q?tSGc7er1lp82zhlCJeZy9F6sKZHAAJLwnn8lLDVn8VnY3+eK0frWBj36e9Ka?=
 =?us-ascii?Q?YBta518C6FS0BLL+X4igVS/TwbIIyToD89Afv8yi0tlzpur+jUAZx7DibNKr?=
 =?us-ascii?Q?zrRNy7jzvYTVPRUUrn2NzVdE63wN5ZIS6Le7sZd9RbaHZl3duN8vggZouH6H?=
 =?us-ascii?Q?YOMIcPEIt61F4ux7enoTMiLwx+zgVJS028sWA79QyudmvBWHi8ztASeTgxRe?=
 =?us-ascii?Q?dMV3mBJVb+SIrumQ3dn1SYI6EAs+ydWymjYcNItaM6FO+3CcTJir6zWMbi38?=
 =?us-ascii?Q?pMFWaP2UMaiCzSOKTgrBQQlfM32UujYCcPCBpq/A9AtoRvzeUe7Gz+VMqUqK?=
 =?us-ascii?Q?ezMm/kvW2kKTI1LV2KWsR/RwHJ5fBC+lNeBuB9qOfY1eSVKYKbVsPpkBdzfb?=
 =?us-ascii?Q?fDcgu9t7qhu6IfR2skuARWYqm+AxLRZelWnlyFyW6SrGIsouYoLa2jCtozbw?=
 =?us-ascii?Q?Q2XObzzQ/8x4vV0THDZ4qm/AwLBR+Jj6Ae9gt+T68qsF9Bb6E02k3UShwtj2?=
 =?us-ascii?Q?4BiinVOkGLnGOcta8m/Q6rkjUwHi86Ub1rN0P6DKdeV/GZAIkGRLYXfr0oCj?=
 =?us-ascii?Q?TbnUNLmtkB0bUsj20ha4m/FVfjcHrwDGJZKCdo1sJeFl9tHj9L6oycL/R72Q?=
 =?us-ascii?Q?QL1IOFoCIlFR0M9Exa+eAvFub7lAS77vtTnMhVWup+WVrM6P1uYtWl0MgfAe?=
 =?us-ascii?Q?n5L9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ae0d4e-44d3-4b58-5237-08db25cb2f95
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 03:04:41.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKFNhYuy7c2+NSmaptLEjXrtmfONdqBvQtuy86HVZ2Idl6PuJvM8jPCHGg8/AwHtPLHZS4LoW4c5cio5myowlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_02,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160026
X-Proofpoint-ORIG-GUID: Xs8-lBl2PufyojZ7Zh0XbizyciDMv42f
X-Proofpoint-GUID: Xs8-lBl2PufyojZ7Zh0XbizyciDMv42f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/15/23 14:31, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in tsb_grow().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: sparclinux@vger.kernel.org
> Cc: David Miller <davem@davemloft.net>
> ---
>  arch/sparc/mm/tsb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index 912205787161..dba8dffe2113 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
>  	unsigned long new_rss_limit;
>  	gfp_t gfp_flags;
>  
> -	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> -		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> +	if (max_tsb_size > (PAGE_SIZE << (MAX_ORDER - 1)))
> +		max_tsb_size = (PAGE_SIZE << (MAX_ORDER - 1));
>  
>  	new_cache_index = 0;
>  	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
> 

Fortunately, I think this only comes into play if MAX_ORDER <= 7.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
