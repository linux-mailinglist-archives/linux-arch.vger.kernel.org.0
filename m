Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA8466912
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 18:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376309AbhLBRa4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 12:30:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376262AbhLBRaz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 12:30:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HHa2b020441;
        Thu, 2 Dec 2021 17:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GzBpBm8OlnMNs5eemPJt8t33n+nr2gqdhKsL4FPOLvg=;
 b=veW0liEiihbiJlh6IS5h4O0uhmdFiMJDwNjhMucMDo2JtA9YhsLm/S51NDMLGpXp5577
 QDMIiVZ3H+s0CZabNDlt6jJfYfBWDAVDoNZ2KYMX27ERyA2GeG+2AcaaLzAqeaSvHtv8
 uvXEXWAa95NPJWIQvFKcgrfz9Lv7ifNmfQbL4z8qj8YSLlVYFtR8NIe4qYE4f0V5otN6
 XLVQxIcfwZi2GJuXDsm6wYCThDIQhnAIfjX14SqNjjSJqij75B5RDqpmzHopCspNjqw7
 XKrCszX0oLy0Rn6585pUNaqMar4z9/9yVLYpmEM6tZe4ZiN+3lLvANgdu75UynGG2gp1 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gksa6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 17:27:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HGQO2001589;
        Thu, 2 Dec 2021 17:27:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3cke4ukg15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 17:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QndwIEuHD9eDyTXAIvg6Uotx94+yQNfzwBDrzng/PZGI3LCyXTSwIwYYNYRa6favjuZyLl1Gwn+aq+bKAAqTUOnVI/44gNsb/UxpFQDX4fidctPTMEWmUfXR88B2j78COKSmpSsQSJEZj3XMJTX7OjGsCgQisejQCItJvfiiEJPMuF3booQp/x4YVlqGPOdiiuDUhMNA2c2OH4JgZAENMI8QB9BqD5u/5XgHcqh83JoUENs/g4/gHzzOa+bK9RkNkRWORODh2TVyRovutItS51P7vnG+YN/LbdtlkFjd2e/q+n5FKY42ZadvaKFpfiQTMgpsOKcviDny22ifl4LSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzBpBm8OlnMNs5eemPJt8t33n+nr2gqdhKsL4FPOLvg=;
 b=ZrAG+4GKkGalLBkvK7yocRKNsft5z3g8ypKqzYaOJ7Nrh4O+TRZPr8uqFsk/oSVGIkOuXmGvwdyhI6WmtcYygyLZIR2fiIBMH6LFn5cqO1zx4gdLsG2+lpL7s3MuloFOneJcPtxlW0cKqGX5+UsJrWAVUSB1Zk+ES/S2L07+DgH/L0fazbTJKw9F3A1ECQEZhXMpN9rlJJgmFIOu5G2d3ewQYpLGyHBBF8YTOycTUhcSoUhOD7JyomyA268YFNLMu2TVZEYAs/zWPyGCG9QV+lQIqFNMI0wmCpUdb0VfQuxnG2hChm/iXf5vri04TjmHL1YtdLucDJdqXgf55cb+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzBpBm8OlnMNs5eemPJt8t33n+nr2gqdhKsL4FPOLvg=;
 b=yX8OBDYzWmAE2LoomiVVJy8356VepBqD8CY/dEV/ygzJ4A947PEUAGh5o42p0gx2M1K4tWICNgFIezA48obgwltmBHd656WssqhfMMD03r2tkoKJ7S4dKKQ4JWOpCkh0/zjFHeF9pgwCk0kMVy83XhLLPnfM6RD4y6i59ZGIEdM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Thu, 2 Dec
 2021 17:27:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 17:27:19 +0000
Message-ID: <e13bd5e9-981f-e2f1-fdd9-049a1926d70f@oracle.com>
Date:   Thu, 2 Dec 2021 09:27:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFD] clear virtual machine memory when virtual machine is turned
 off
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        fei luo <morphyluo@gmail.com>, akpm@linux-foundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
References: <CAMgLiBskDz7XW9-0=azOgVJ00t8zFOXjdGaH7NLpKDfNH9wsGQ@mail.gmail.com>
 <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 17:27:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3b1cbf-c9a1-4781-8fea-08d9b5b8fe68
X-MS-TrafficTypeDiagnostic: BY5PR10MB4273:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4273FC7574EB3066922E77A7E2699@BY5PR10MB4273.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+t0AQpxvDZSFWQUjudVZ+a4cb5Vbnq1qj5B1tN38dZtJhi2Gtxz/vpNUiarfpVbos0S99UxrFOSDwNgZY0tNDjyUWRqDzoftvR/eC6XHPc+utkZTZJ7NX22q2ABD16ATQXgrvueHP/2FsplA0rqOFjeaPcaSPlawbvCeC3Irx6bhot544jkYuANFaFTmV3TR9YLl2iSeRNV2G8ubrxrFAnr5ipXNkEbAJKNAhNK6KQG1/3eX8Jgi6f+XNQBXaBHwHtY3n0Z60djme/2pLKTrswShy7zQrq7pJUMRfokdlBPgPwumvPCxXI8SLyB5s80XpNgRHYVUpUYO41tGBFs9B03kxSJe5crTMODpInZrYUc8JzSCFvfZZH2lK5H5+MQm/v5acp870fG3NqWhtd4ok7gizh+YC+nN0ZjcGAYp4qHatTKXqZdu7098Z4TFK/EpoHnaEJBnTjHAoS9wocdAqxi/lHABFPb/N+2ygDpL1nmE/yyZk6UphswPQlUODHJhu+D8N1neAHJjqr4o/9Z1LpOCx1nLmEwCjAWNfGsw1UzP07XCunAAFZ5SE38ZLqI7aBrF+LVJd+AVDS4JOuKlVbzhNdc3qDtyme5D6XhjEFPHD7L61M/o7XeXBvpq6SMnr/D50NVzkHwjvPkn582CsiUP7o3NAaF3uJfcE3hFBHVolKn2JNQxwhtiO5d/kXSfa6CPUjxT8JB1DlRfzSQegExFuJSAukmN6/VMBjcLLy8eyicQfd+HX569y4UWwiq9ELDhxbsvbY6ZLik8rW/EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(4326008)(26005)(53546011)(186003)(38100700002)(38350700002)(107886003)(956004)(2616005)(66556008)(66946007)(8676002)(8936002)(66476007)(5660300002)(52116002)(2906002)(110136005)(316002)(31686004)(31696002)(4744005)(508600001)(36756003)(44832011)(16576012)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhDK1hQVk1WeGYvRVRpVDV6VFJMUmJXWm9tTkoxaVk0bWFlYzdObUIyV0Rp?=
 =?utf-8?B?MzhYbTRPU2FMZ2Frb2JwaVJWV0laM0JHTGZEazZhSDlUeXp4MnVpUFpkaVZo?=
 =?utf-8?B?Mkl3TUllRVZ6ekxGWElzM016UW5mdkIzQjZORnFjWkY5cTV1SjNQVmR0VWNH?=
 =?utf-8?B?MkZoNElDcXlzSUY0WnYvNDFsNUkrNjZTZ1U3THJvRWR6eW0vZUJJSW1abjZO?=
 =?utf-8?B?ZTVYVm52ek4wOTA3MHMxaVRWNVYwMkM5SitQRDdKQ1BuaWQ4Vkk2TXRBWVNO?=
 =?utf-8?B?aHFHUmVVMzZpeG9HalBjVWdmQ1pFV0lKS2RlUHpmKzg2OTZjRis4Ni9yK0dI?=
 =?utf-8?B?cVdvMjlPeGcra2NKZi8xSzJyd1RPeDRsUGh6Wjl3cHZ3azB2RXpwTWZrVUNu?=
 =?utf-8?B?WXBiVUxaVVFkV3kxcjNubUN1RmcwOERZekpNUGFwWHZQWUhhSnkza0RQZ3Ax?=
 =?utf-8?B?ZVZQdzBvNDNVSWczTjJ3Z0xvZFBpWnZZbWJYVUpISm16YjBMN0J3VFljaCtN?=
 =?utf-8?B?VkNVU1dBb3gvRUt5bE56YmN1ZVUvcW9NK2lEZldOK1B6M0dvZVlhbUE4M2hC?=
 =?utf-8?B?Uk1mSU5OUDRrL1B5aFJXdmNGUFlHTXlLRDM3UTdBenlMTFVHelhabWdDMUt6?=
 =?utf-8?B?cUZ0cXloUTJXbVZhMGJZRlphUkhnYVhBd0RIdWQrUks5TW03ZVdqUnlyVjRD?=
 =?utf-8?B?UW9OakEvdWlhRVhPNjZRU2RkbVZvdHJxQXhWektENG5JeHNwaW9CL2NCL1U1?=
 =?utf-8?B?UGwrajVlV0lpSGtBYW1UaHdneDY1QW8vbVBWLzArcnNQemp3QWJBTkJRb3Ex?=
 =?utf-8?B?amMwN24rL1AyVWY1UkdLSnFMeUI1OFZWSHU5d2pBQzc3cnkvVG96bm9rb2xu?=
 =?utf-8?B?M00yMEhJU1R6YlBrdWxrTE5qczAzL2JsN25MalA2aFYzaXJZY3o2RENSOE41?=
 =?utf-8?B?YXZDUFB0TkpJRDNhWlNFc1dNTmtQMHE4L2dDcDJEbjRRRko2VnV2ZnB2NmE4?=
 =?utf-8?B?bys5WjNIT2lBV1lFKzhMSzM4MU14bExJRG1RVmZKaXBiYk0zOU42T2VWeGxC?=
 =?utf-8?B?WXFaWEFUUmkvMkJtTVJpbERqK0RXMHJZeXYxUnpmVHlUMGRsN1FpakVRckll?=
 =?utf-8?B?VklJZlRJMWVNc1FsV0RyeThwNFQ5RU1MSEh0cTYrcjRIWEVwZzRRcmMvR2RF?=
 =?utf-8?B?OEwrRUNRcEIvQmhzVS9oY1FOYVZNbzB2QTdIVmtrT0dUc0ZZdzVhTmVVeDdm?=
 =?utf-8?B?ZW5MY3l2bWQxUFlQNmZMUkpyNkNIWGIvRmN2bzRQb1RoNXJGMUs5MnFvdnls?=
 =?utf-8?B?QmgwbjBycUFJc25vNy9aSHhMOVAxS0J3UTc2RWV5VnFUNExjY2lwRk1KcW5E?=
 =?utf-8?B?MEJhS3dTZDAxUlRPVHFCY05KMU1IV2hXK1JMWjlva3BrZGduUmZQSlZzcEdC?=
 =?utf-8?B?TTFya0hoWE9lYU1zaWxkd21WVUxJRE0xTUREakRuNUxRZ3JvL29QSzFpOG51?=
 =?utf-8?B?MXB2cDQxYW9EZStIYk52eFcraE1DYm9xQllGdFd5NnFUbStzU0x3UmZndGpn?=
 =?utf-8?B?WTE0TXhXR0w2WHZUR3VGS1U2cGlPM3FGc2x0ZWkrcG5mSGUxYzVia29DYW9F?=
 =?utf-8?B?cTVFbFJxeXdGc3NuZUwxTS83dGdrV2t6U3JVbzM5WUxhWnFMbmZDVlI2Qmpo?=
 =?utf-8?B?YWlsRjVqMGpnQ0hhRDlEODNnSUE0ZzI1ek1KVCtvUlRhdlZGMVdGdVJDQjdH?=
 =?utf-8?B?ZE92THJFUHkzYVF6Q0hSeXBUSkR5aWlIZkVRbUx6b3JNMUkxQ3M3YkkwTEdS?=
 =?utf-8?B?SXowUGhsM3Q5eE0relRKWGhzNnNsbXc5bE5EaUhMYVdVWnE3YkJRLzhWblkx?=
 =?utf-8?B?Q0o2VE0rWXlDc0V3OE5zT3VJbXVYeTZ6UzJDRk12VHgvMXFtQzQrUkF5QnlK?=
 =?utf-8?B?UWQ3dytWOStyZDNhWUtjNHRZVlVxdE5QZlphNU9vckVVSU93VmdzQTBKc3Zm?=
 =?utf-8?B?ZWlXY1o1MGl6azJJN1ZNcWo3OWFZNWZaQzhScTFab2F1TGp2djM5MjVJci8y?=
 =?utf-8?B?R0NxVkpKM2ZGNFB2aUhEbCtUWDdCMXdKOE9LM0MxdENXaXd3SjBOU2ZidW9y?=
 =?utf-8?B?eW5Sc1Z0Q1FGNkRyNVZ3cTlpaWFoVlBTYkg0Wk5lTEJwdVAvdmlkZkt0QW1Y?=
 =?utf-8?Q?FP8d9Q7gOPxjNv7Ex+G3ggU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3b1cbf-c9a1-4781-8fea-08d9b5b8fe68
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 17:27:19.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsdQpP3147L7knrt6rXueqj7hQareDZlWXFK64rSSIFwVUzZ6pIL0/NLsyWf5KdZJmvP6X1sNNDHetyp9nguZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=984
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020113
X-Proofpoint-ORIG-GUID: E_wBlojeh1lYXQmCeSGiSIwIF3TQbdDm
X-Proofpoint-GUID: E_wBlojeh1lYXQmCeSGiSIwIF3TQbdDm
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/2/21 04:47, David Hildenbrand wrote:
> On 02.12.21 11:19, fei luo wrote:
>>
>> When reusing the page that has been cleared, there is no need to clear it
>>
>> again, which also speeds up the memory allocation of user-mode programs.
>>
>>
>> Is this feature feasible?
> 
> "init_on_free=1" for the system as a whole, which might sounds like what
> might tackle part of your use case.
> 

Certainly init_on_free will not make much difference if VMs are backed by
hugetlb pages.  We (Joao and myself) have thought about clearing hugetlb
pages from user space in an attempt speed up launching of VMs backed by
hugetlb pages.
-- 
Mike Kravetz
