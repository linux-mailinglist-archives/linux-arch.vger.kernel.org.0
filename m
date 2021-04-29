Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC136EF28
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbhD2RwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 13:52:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhD2RwL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 13:52:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13THngC6118078;
        Thu, 29 Apr 2021 17:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=43n4WCu36N6Yo9wgtHy01ToLFV/XMMYfUs1pC3ue4NQ=;
 b=ldP/0l8swlzwnNLjO2X8sza/ekcBe4V4hsKHBVmr6xtwtoNmhZAnWvO3rSCtdal/yMsL
 rAPpEQHqhNyVFtIcQBCGhNm+e8BJJLi8fNba/eqsDpIG0ue1Vj9DZMTdxl8ev6KCZ8qz
 xDsYBm8IiYtveTUSoycPLlx5q6xX0XJc8EHtYOjdJqcaI/dFeE31Yqp+kEJphfkzgzaT
 am5yjvpxTu8l9UUBJgHnBl/irfb3eNID2shU9L9LXO4vE/knfR5iX73T5ze93X99OyNe
 7+gwonikySUV7TXNTmt+j+lAmNt9NQpmPD530qfyFq7TYoH9nxlr/9XWPGDOh6TvLtMa Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 385aft58w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 17:50:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13THnwIv192587;
        Thu, 29 Apr 2021 17:50:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 384b5aq4h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 17:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG9g4b1sgaQ8nwl+jTA/EaDSsJoXSlXMVfI5u1cLIPHYIbsQyiYFmLzvWY25QNlzvnUfHCB9Rij5DoVHocJtQjsgSLN4hzmYYoEftaGMEEqmhO3hH7y5ba5zfdILA3s7jqRPnXZiWfeQkqqcYAKF0kL2hXsqdtOC785852yEz6WXU91Iq/cZrtFUoUMi3WYLgT8ygGltwiLRGJpD6tVD71xQlenqRGHu7n7Kw7KA556Vp4LtE14j00mmlWN549ZDfh36rvFAZ7kmLCaNeuY4FpOSfO2Pr3MynOerYR09Go35R18SODrcD54D7CeWS9KwELb0kX8rW3zCP7uFOVYf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43n4WCu36N6Yo9wgtHy01ToLFV/XMMYfUs1pC3ue4NQ=;
 b=L7ZB9hI/BEUsvN+0ZRtKJsOAzDAgFAUha5zIFHqzCD0HvqvFEWmh+hSj8+FY3gH4Vgez1SidlkE2seC5rPukNxMVLQQpvS83pDBLHUlREj7ZiXAA5tMB+t7s44rCJERGncdTBh4++cqaqzrKlB5NMPqPtWCwr53c8H5FaBq5BBiHXXQOY5hSRiFpW8bpGUuHk5C2Vg36xqgIv0/RH+X4XRNbZgxS5bXcm88jG5wG+g5OIXLvLC5kKPn491/aMqYB5PMertBU7eEScRAXfma/IFl37xX+1NukFfKkUyXc4nWPvotDna1AJY0Ndbwq/8tu7Vg77BPivoklRBEFkmuHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43n4WCu36N6Yo9wgtHy01ToLFV/XMMYfUs1pC3ue4NQ=;
 b=sNTQVFf886EgfTVnKQ1smVv6Sy0Gai2pwF2VVMcGhrEif3SjjNOBCotDKIS1BOFZCJ1mV/N91ricsGIJN2wZ+OJWpWZBQrL0EbAyB+/5wqz+0/cEs5vR1gwzXVg4qjdV0GQ9YsGsJt9TVKJjOTc/eVJioLuhF7lOyGNJkU9hmjs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 17:50:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 17:50:52 +0000
Subject: Re: [RFC PATCH v1 2/4] mm/hugetlb: Change parameters of
 arch_make_huge_pte()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <cover.1619628001.git.christophe.leroy@csgroup.eu>
 <e111d0d90231ae63e4b89da8efa87cde31daeeee.1619628001.git.christophe.leroy@csgroup.eu>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d7c516b7-4fec-dc1c-c931-e7b17272372e@oracle.com>
Date:   Thu, 29 Apr 2021 10:50:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <e111d0d90231ae63e4b89da8efa87cde31daeeee.1619628001.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 17:50:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be01d3cd-9c22-491f-1d30-08d90b375479
X-MS-TrafficTypeDiagnostic: BY5PR10MB4353:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4353C14F4BB18D3F47571913E25F9@BY5PR10MB4353.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CF5AiQzEZRtjjGdgmaQfLpm3m5Pxmoo+b0AmK+8S8XfgG8M+SIZ3tvMQbJaATDeoZsA6VZ6dtFHCoZKOLmspspcyMVHogPxMkmrU5oqgCGiwQBVxNEVmmyQNSjkHf3Ege6dbh/TKpWXIgBcWSnLr+Sk9nItb6pLW9/3VKlzdRncFqPSKtdP42e02Exe+mZAtv59M/4NFEkFY/8LmqsGBnbO4cqxrEFgCJvFwXT1pq/NGMfEZMBDkIoddscf4DcLXjjIRRKzjKYhP9Bxf8J6YI1nhOsb9UOAAENOszPM/8idAQ2bFyMKZo22hSRvjRz8uN7DsZRTSu8Ub4D2LNjoNDwGeKaGLmzT6PonVF8RWXakpKsQWWpoaiMM3Q2TvU4+3mHGL+lCSHiPO8ePEgI8VB+k5YMkJheS32p7wQSOcwFSIU+xY/8IpCfbEiXLO1K8jXcvQ2lyCI9n0Xc/xiygAGse+LrdGBmfjaWn9vUeX679iFTYHaHLKXIrPnwx/ysDFAxLA8gQ7arf2/KP5eYveagJvkHr+BIGZk1AOykwgwHB0YlPprceicxUf+KYZ1tmE5dsgSHHfieSsg9tO/BH98CvSWChJ9BteIeRRpVMn73E/zP4+K5P+HNHYu3YRtVOfg/mj4kPE7SB0OEbtpdYShGcD1lnaum1oNnX5AV+h5S4NvX4IeiFmADhWb1wHhF3jNeRNgGGHYsSNtBUvOtnLV8GwPk1ZXgPgRwQIz6E8/+i50LWsigKTiaG9lnSXsZR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(44832011)(26005)(2616005)(2906002)(66556008)(956004)(7416002)(36756003)(66476007)(5660300002)(16526019)(478600001)(6486002)(110136005)(38350700002)(4326008)(83380400001)(316002)(16576012)(31696002)(86362001)(31686004)(186003)(38100700002)(66946007)(53546011)(52116002)(8676002)(8936002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VjRMdmpzemhzUlpBMGhhQjFINmQ3dU1GbFRZTUxJeCtSemNDa1BNaXZ6ZTNC?=
 =?utf-8?B?eGptb2Y0cXVYR1pRQVNQVGFCRGdBODdaV2dYdmFmeEpzZ1M5VlozcXBHZGNV?=
 =?utf-8?B?V1VsUU5PNXIxVnUvTmFXNHE3WUllLzJ3Q2Q3eG9oaWZGL0RaMjgxZkZ0UlNz?=
 =?utf-8?B?NnBEa2ZhNjFLell4UUVLUTcwU082NHFvdWpoWk1XNnRhSnZzakUvQmc1OXRS?=
 =?utf-8?B?cy9aZmYycUdRRTExWFJjQ2FzSXQ2dWJBYVZoTmhTYm9sc2laWEFJVEdUVDhz?=
 =?utf-8?B?NnFTYTZ0VUtGMGROS3ZhY0xuZEJYUGpXZldPZ0pEbUh4OEhVRlRXMFNqdHQw?=
 =?utf-8?B?Z29FL200ejlXbVhkUGdhNG15d0s5UURqalFOY0NUZ1g5b1pnN2FvamNzZFNy?=
 =?utf-8?B?T1YzKzFEaHZNdEpzOHF4WkFLL0hTeGtMU1B4V1VqNDhXTEFSQmJ6ejJFeGpw?=
 =?utf-8?B?WFR1d0JSVHZ0RW5vK0lKTXpTVFJUeWpvMXRXWFphVXNhdTRuSkRsRE4zbG9t?=
 =?utf-8?B?TVduTnZVcW9CTDZuU21STm00eVdpNUY4UzE0WVM0VFR5Mi9nM2JmVW1icm9L?=
 =?utf-8?B?dmdFTTM1S3J4NGlTRm5GdkI5S0tBRnNNV2xldDJ1RW5KajJ4b0x3eVBrYkVQ?=
 =?utf-8?B?Wkk1WnJBcm0rbkE4bUpBS0FqZXhnSkppNDh0c2pXQ3BxV2pSMGMrd3NBTDgy?=
 =?utf-8?B?VkRtSXU1TGdLZWdFL3B2dHhoa3FTVVNHVFpnSGZMeUZReElUVS9BOEZCejhi?=
 =?utf-8?B?OUwxeGhJMkNZYlBLVVNsNWl6c0ZRbmdGRGhLNE1XbVVXZFhUcjNJVlRDRHQ0?=
 =?utf-8?B?dGJOOUhTaW1ORDFLbU9OM0dnY0tLcEFWUDFrZk9CdFAwK3NmZVUwUmJPaVcz?=
 =?utf-8?B?Z3FsK0d3TmJiL2J2RjhMV0U0d0V5cC8wZGVEYnVod3ZJeXJVK1NCd1FHd0ZQ?=
 =?utf-8?B?SzhYOVd2SmNSWHliUVZCUDdEOW05RDdHYmJvVEdlR0NvdjFYVkMxd2NlbzVi?=
 =?utf-8?B?R0VVZlFiRUpBVk9UNWY3U0JEVXBnY05pUHhjZmQrY3ZtTVlyd1ZxVWs5UEJJ?=
 =?utf-8?B?S20ya2IyeS9nbzcxNGt2T1NJeUdiMG1XU3NUL2dxc1c3eG85MjFGb2M2MVo1?=
 =?utf-8?B?UzlaR1FhVmp3VHVBKysrTllrK2Q3Qmlwa3JBeFUzbWFRcFNteUVzYkFHbWxY?=
 =?utf-8?B?UHMzNThSNHZBNERnV0lEN0hZcGhmVzN6S3ZOZ1pMdUMzRTFpSzdHbW5CMW1C?=
 =?utf-8?B?ZzdiRzhhSEVHM3p3T0YzelUyUnEzU3NSMzRvSHljSlNUY05LZm5VcWxtSzhK?=
 =?utf-8?B?aGVoc1pwT0VyOEZqZkF5WTJSb0hvWUFDWVlGRnVWeHBTS3psN3pGSmFJVDRn?=
 =?utf-8?B?VCt6UW4ybmJiZGNBU0NkR2VQV2R2NWdEdG80ODY5Tm8vbWxMUjlSSVozSjdi?=
 =?utf-8?B?dThVQzIxUHRFSGU2SG1sRGhOaVQxUTUxaEVSQk9mdHIyeFR0ZnhmdGd6bzFE?=
 =?utf-8?B?VFFQUnVlRnRkSkI4Z0ZzMzc4bkhSOFZJSHZSb2FxWW50Yi9PbXVIM2U3VHNY?=
 =?utf-8?B?NW4xOUozUGVrd1hIbDNZWkdVNVljTHRmbkpjYU92U2FCQUhZTDBUNFRmSWds?=
 =?utf-8?B?U2pSbk9aaHFYSDh0anFsWGs4SkRPaHVuUmtlUG5pS3N6VlBwTnlFOFlMWEh2?=
 =?utf-8?B?UTVnUWthWFM0VjZyb0tLRGJyUHJsUU95ZEFWcHR2dkFRN0t2dUxuaVphMU0y?=
 =?utf-8?Q?W53nLqWea9nz03TTlkItRzaHqN9r0hmoEOh900x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be01d3cd-9c22-491f-1d30-08d90b375479
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 17:50:51.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkkfGpvp0kflmcVUA6QE21SxVoYidAAkDUidV1u4fnNSp4QA3ZepFDYmygLwkRunzXtizXwAGMP074ChA8Iihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290114
X-Proofpoint-GUID: lpIwFLQgmVUIcAnbQjnxaSIOx2hh5NU2
X-Proofpoint-ORIG-GUID: lpIwFLQgmVUIcAnbQjnxaSIOx2hh5NU2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290114
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/28/21 9:46 AM, Christophe Leroy wrote:
> At the time being, arch_make_huge_pte() has the following prototype:
> 
> 	pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
> 				 struct page *page, int writable);
> 
> vma is used to get the pages shift or size.
> vma is also used on Sparc to get vm_flags.
> page is not used.
> writable is not used.
> 
> In order to use this function without a vma, and replace vma by shift
> and flags. Also remove the used parameters.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/arm64/include/asm/hugetlb.h                 | 3 +--
>  arch/arm64/mm/hugetlbpage.c                      | 5 ++---
>  arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 5 ++---
>  arch/sparc/include/asm/pgtable_64.h              | 3 +--
>  arch/sparc/mm/hugetlbpage.c                      | 6 ++----
>  include/linux/hugetlb.h                          | 4 ++--
>  mm/hugetlb.c                                     | 6 ++++--
>  mm/migrate.c                                     | 4 +++-
>  8 files changed, 17 insertions(+), 19 deletions(-)

Hi Christophe,

Sorry, no suggestion for how to make a beautiful generic implementation.

This patch is straight forward.
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
