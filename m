Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124824FED03
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 04:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiDMChT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 22:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiDMChS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 22:37:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809362E6BB;
        Tue, 12 Apr 2022 19:34:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CLRl4W029058;
        Wed, 13 Apr 2022 02:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RNbWpK77Do+OA3M1Fd1lLqOWWVAxykFqaEit+1Xx6Vs=;
 b=btCF6+lDdORfecQ0uA+UdHCsOgZsULWk3qDjuIYzniF1FdAfhUG88uKAvbujOtjNhc7l
 5SL9457n2OILzKagEuKlp5pnJRGJ5Kg+eld+3Oi4ygX5elkGWjH/LH6lRir0s/O1s65l
 lZj/GvwQIRdp+my6Ldgk74qfkgHdlkDnfkZ3Be0FGVfWMIKvyYM4bygbWr+VCc2cFJaN
 LN8mpjtsHJ0zpesBnCyOa8E2MvkTPymzovyvNq4qhVFgRZs1RfZ7gGPhsvbkDpONMnOO
 SGSfq5qpsvs6cVmGM/muVG9wGv36w7nXsoua3K7H2W9bmCAVzgQpBWCoChatKq7HHTFP 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs8nk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 02:34:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D2FOa7020083;
        Wed, 13 Apr 2022 02:34:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k3xv0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 02:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azy3QlkMl6m7DPxWjE4lY2Pday4QWSLrngtCZTuaZxiDjNyIT3WJZa9X40fopMscIDU6pibVF+OHqbHCj9Fyv8pp5n2OEt35EMOZBc7mKXQo2bhgOdE2S0JmZqkAgEJZFsF+4iIIBsUzgTQp9z3vXaIDDklCUILRKqIyBR5jHGYYFvCMMtIJghQJDm5WpHzeImGiAa7Dca3bW9qI+h+MwDOUYiEhmWh1pg3coTiI+XO0KQrAX+UcfyimNsaqivhqp18cpTX4hsGAtJN4He5RZBGSN+fb93I6Otowc6Jeyg90tVsSNADrBpBt6xT6p05/62RGTKojvrUCJk+RPdomGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNbWpK77Do+OA3M1Fd1lLqOWWVAxykFqaEit+1Xx6Vs=;
 b=gTpUV1pdmEXAc2tXuzG2SmgSI49poQQ+3a6DOoaesHZrp3t7HJOcVEF2lmfH8/NcuTYxJJNSHwejGlrrG1dvbyEcgqP6dt/48vjxeWRtFJGPq31IUDiXfkf82mCxSWJyr4EFEBh9GAkVm1rrTMloDgFCSjMLR9CvVd4vGDAH/TCeUK88jQByAXybiBpsRXygtxMOSO3HWweqYyd6B7XDMBr2nXEMQ17yXX/diEE3zIzkHhoDYomfztukUJniDvOQZ0GI4wLdrB7B5viljzr7azJc8LaPNvmELTDPjr4VIrbeiPZbfEQzkBWx5NyC170+V9/7N6OnJGJ7qIV//4Na3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNbWpK77Do+OA3M1Fd1lLqOWWVAxykFqaEit+1Xx6Vs=;
 b=J4D9W4Ljc9JJYmAkh1+YugTuYEeP27XJZYaI4Uc1LJR9NsNChR2Kj1dt4OSPqpgyf/0AAvchWVYR8usp/v64N2kFfeLnCIq3Y1Goq7+uPp/R3g2M/mRlmCnXCd82jVZcRO/WUZdweBWFiy1qbnSuaw9E8A3lcD8Nn4R2V2/cLug=
Received: from SA2PR10MB4569.namprd10.prod.outlook.com (2603:10b6:806:111::11)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 02:34:40 +0000
Received: from SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287]) by SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287%2]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 02:34:40 +0000
Message-ID: <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
Date:   Tue, 12 Apr 2022 19:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20220412231508.32629-1-libo.chen@oracle.com>
 <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
 <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:a03:167::33) To SA2PR10MB4569.namprd10.prod.outlook.com
 (2603:10b6:806:111::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d149dede-89f1-4703-9ce6-08da1cf628ce
X-MS-TrafficTypeDiagnostic: PH0PR10MB5755:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5755CE9ED0B2787F3100AEBB85EC9@PH0PR10MB5755.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TMQ96mPa8uEskaJulGOXZWoPmODbSiLswJU6XBI9PLz08iWx5CKKUPa/Olwkb3hXPJrPCQORHGcX7oCKlKzAIWcvi5fvwdpou5Hi2TUDCGWW6CC0H83h/bMJm3HngBu3Wuyc7dhcfbw6ujdRiBWQMsLwNi0JRCJhHVPAQUSoVYgeen//vVpGHb5eXOLyeJXHQ5XYVJwADUc2LhwygnPHRzVI1iHR54khgmpj9ic3fHho2LSUbn/x17Q/01xmnmMbYSNVV7uZorAYi+5jQ6lrJQfN6JN4SW9tP0u5BLuLUViGVhdsWcCy6ENrcm/697QML8wBtAwVCuMtQjILo9mmhWB0Hi3a7vshQU3q0blsCdieMjLw/2tocNRDfJyu6tdtzk6KTlIW6vSRd6jv1mlBduRohA1danQAlzENSga9yPdqEzcC2FkojAi647Rzbk2M9rKIclB4HGqhGy/KnY+BWrMl2uUjRV61UfmixGPmMOpqYKgzVDLgrQu9xjQ6HjnRo24srgWh0sWvirvKIDGJzOR1M5NObdVBzrYyLo5h0mrIOF4hLagzHOpXuTNM70C1+GA5ltAOwGdjqcQ3fqLuGTSrgcZCQ7HrOLQ9DLGrfQLJo8AwlJps1AhCt0JdzX+Xc0we4Lc8naDU94QANtkW8NQ5/l6d8ldm2Y6AF4aM0XRzdn11wUb2aVosOkGvpVQvnqI0Ucr4PiOEA1fh3KLney4ojhNpfd62bW7RldfiEc9+PhpbguDMSoAlXPuGAAJrBlvHgQ+TJ0wrsoNE8euqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4569.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(4326008)(44832011)(53546011)(2616005)(86362001)(8936002)(31696002)(2906002)(38100700002)(6666004)(8676002)(7416002)(66556008)(83380400001)(186003)(52116002)(66476007)(6512007)(316002)(508600001)(6486002)(31686004)(36756003)(6506007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUk3Q2NQdk0zall0Q3N1b1pKanJlZVdWczRDSitleWppRjlicGhndzhIL3lF?=
 =?utf-8?B?SUpndmlLRG4yTHdzWnJSaDQvRUhtbWIyM3VJYVBTMDE3V0VCUHVxa1dnM1hI?=
 =?utf-8?B?ZDNabzRnM1lCMFRLWWpES0liMVBpaXJlTk9KR1dhR1RIdE9YOEhVWWRISXVS?=
 =?utf-8?B?ZE1jeUxKV284MUVVMENxWlhXSjNHN1p4L1hZem1lMlNpNXYxM0JOYzc5dHpr?=
 =?utf-8?B?QnRtK0RscXltRkZUWktrUmd6SzEwSTQ4czJ1bnBtYWtSVEtmcy90aE5IVzgx?=
 =?utf-8?B?ZjlLZ0xzc3U4YzlWVHlnSkluYmxHeERUcTFYbFpyaUpBZk5KUlhnd0RzVXBm?=
 =?utf-8?B?bFVqa1BFdnpxdkFmVFc2WkxUNnQ0T0RtOVFZM21IUjN5Z2JLajhWZEVoUmVz?=
 =?utf-8?B?QXowVnc2clp2aS9XcThzM0dvWnd5ZXBOUi9RcFk4YThDd1ovZkx3YUJ1a2VP?=
 =?utf-8?B?WnpWd0JoTFoyYUZNVW1wVFRWWFVvZHJXVnBpdFoyc2ppdUlIRW83UjVWTmZk?=
 =?utf-8?B?MVkwNVBXQWNSYVN5K2QvZStsS29OSVNSY01RemN3UnhnVy9YNTFsckJXTW1y?=
 =?utf-8?B?RDYzcFQ3d1NGTkw2cUtta0lQZUlJSWEydnlCVUFMcThuQzZha09oTGRtSURs?=
 =?utf-8?B?Q2tVUWg1L3d6NGdaMXVKR2lGT0lvekRLZFZVbVlqRXk2UXVTTURvU3VLaUIw?=
 =?utf-8?B?RFJJQ1k0VExNaFlsRWkxcEJ6d3VZSWpXWmIvek83dXkxSWlpQzM3LzUzNEVv?=
 =?utf-8?B?dUxzaTVOTW5JS2Q3YzJLYjdkUURuYTdiOTJGdzVWa1hkbWhiaVBvMGRXVnVY?=
 =?utf-8?B?bHBNTlp4TzNISHZhOXBaVkdkRnBuZk5oUGxUNXJVdHkxeVFacnFoT3FsMkcv?=
 =?utf-8?B?RXQ0MUhLY1FQVEpIeHlFQTQ1ckhFMDNPblN5YVMrVHVyUFM4cmhTU1V2YzlD?=
 =?utf-8?B?NlJRZUhBUWlVSGNYMzZGdi9mV1dIMTF2cjVkM2l0c1BrRjVqTnNuTEJsSEJ2?=
 =?utf-8?B?S25UKzdZci8wSGJxWE14NGp2RUV2dXI4L0llaGJJcVQwamhIVFlGZ0RNY3Fx?=
 =?utf-8?B?RlpJKzdXY1hSWjF3U1BLUFpvaERmQWpZNU4ya2R3S2w3Z05KZUp5T3RKazV4?=
 =?utf-8?B?SGN1bUZITXU4ZnFFd1E4MEpTcWIwa1dDMkFTc1lIMjVaT0NtUnJsbWJ5OWEx?=
 =?utf-8?B?bUFnTmVMN0pnNHZhNjV0WkhEUjVaYVNta01RY3pWR01aeW5CSzVVR1oxaE1t?=
 =?utf-8?B?TUJzRmJlVHo1bTVrS2psWTJaeVN6T3l4OHVUSUsrYm5LWmRwU3VibitZcXBO?=
 =?utf-8?B?ZFMwVVIwV1dRbkpVdmVzb2lsU1h2M29ORFljeEZpR0IwT0x0cGZEQ1ZZVEps?=
 =?utf-8?B?RFlGQ09aTW56QTh2SEdFL2dneVBwS1JMekJ6RXRFTVIyNlozZTJqUlczUnRm?=
 =?utf-8?B?TGlzZHZERDUvKzlJTlhDaVYyQTA2MFltOUZwUHo0NzJ2M2FTSHRsQkJZTGt1?=
 =?utf-8?B?bytHNGpsNDdUS09PYXFEUVpjdzZaMnoxc1kzK0FaYzJRdTFOLzBEaTdpaWIr?=
 =?utf-8?B?azNVRU5IbWFIMGlsYzNpVmtIL3VqRnZ6SVBLTEp3MnYrVVFuZDFoZlc4eVA2?=
 =?utf-8?B?L2wzVjVmRHplZk1YMjhNdU15cy90OHhIVnkwczhFWUlwbW45ZldFQmpUd0Zm?=
 =?utf-8?B?bVVBMmJ3aU55MGEwUVBaMTJzU0twMC9YdjhvT1NyOEc2VGtVZEN0TXVKV0Nj?=
 =?utf-8?B?bERtZzlHTjFjWjU0QTdJd1VMTEw3R2E3NWdEbnMxMHI4Ynp5bkUxdzQ4Q3Jr?=
 =?utf-8?B?M3VISlFQTktaaEdzQ3hEcDRwekRPYisvTm15Rnp5SmpYUUw5VERyUVMrV0lx?=
 =?utf-8?B?SjlKMWFFbXBBeEphM204MlErU2VMSGRNZzV0ZFJPYXVDZHk4MlYvRFlwY2JV?=
 =?utf-8?B?QjhSR3pySFU2L0dwdEZKMkJDWFdsT2tralBzekpvQ21tM205Vkt2U3lQQlJh?=
 =?utf-8?B?bkVGdVpDaDNhN0RYd3ViTVdyYjZZMytybHNJdnlEdFUzMVFEUGVzcUxFdzFt?=
 =?utf-8?B?Z3lDcHJyRkNJRkVQZndEWTZmbksvNWpqUERjZ0ZWcHVncUlKa3hoeG9OV2Qr?=
 =?utf-8?B?N0FIaHF0aVFHWnZYK0FCcmRXSG5rVjdWUGNnZEo2TzNTVGZWV1pxSEpubDA3?=
 =?utf-8?B?VU9mM3lUZUV0dERweHNJTzlUNTFCQkNxUGpuRlpnWklZMUh1bFQ3Sno0WGVp?=
 =?utf-8?B?bkx3Zy9CdWIrbUJzRHlHd0Q2bDBGOXdLUVovbStHS1VnaDErc3ZEaGQ2ZHc0?=
 =?utf-8?B?OWFMdktCc1VGQ3d5WGsrR3Z6Nkx6V3pWeHN3eHJXU3B4WEh0c1RySVVMZWk2?=
 =?utf-8?Q?0i7fJZqeG6f3bxB7Z1XKuLUNgYSbf7ZbI7124?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d149dede-89f1-4703-9ce6-08da1cf628ce
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4569.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 02:34:40.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfi5RfMQH4YD8czH2hgeqWVEtx5pdgj6VgQSj0iuLBUGsBPEvLTPSxxx2ZjBeb0OHz6J/IoywnVVEJqeVtC1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130012
X-Proofpoint-ORIG-GUID: QbAZyM5YBsTsc_a-cDu919yqk9Vuucgk
X-Proofpoint-GUID: QbAZyM5YBsTsc_a-cDu919yqk9Vuucgk
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/12/22 19:13, Randy Dunlap wrote:
> Hi,
>
> On 4/12/22 18:35, Libo Chen wrote:
>> Hi Randy,
>>
>> On 4/12/22 17:18, Randy Dunlap wrote:
>>> Hi--
>>>
>>> On 4/12/22 16:15, Libo Chen wrote:
>>>> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
>>>> make a lot of sense nowaday. Even the original patch dating back to 2008,
>>>> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
>>>> rationale for such dependency.
>>>>
>>>> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
>>>> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
>>>> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
>>>> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
>>>> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
>>>> There is no reason other architectures cannot given the fact that they
>>>> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
>>>> x86.
>>>>
>>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>>> ---
>>>>    lib/Kconfig | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>>> index 087e06b4cdfd..7209039dfb59 100644
>>>> --- a/lib/Kconfig
>>>> +++ b/lib/Kconfig
>>>> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>>>>        bool
>>>>      config CPUMASK_OFFSTACK
>>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>>> This "if" dependency only controls whether the Kconfig symbol's prompt is
>>> displayed (presented) in kconfig tools. Removing it makes the prompt always
>>> be displayed.
>>>
>>> Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
>>> of DEBUG_PER_CPU_MAPS.
>> Do you mean changing arch/xxxx/Kconfig to select CPUMASK_OFFSTACK under some config xxx? That will work but it requires code changes for each architecture.
>> But if you are talking about setting CONFIG_CPUMASK_OFFSTACK=y without CONFIG_DEBUG_PER_CPU_MAPS directly in config file, I have tried, it doesn't work.
> I'm just talking about the Kconfig change below.  Not talking about whatever else
> it might require per architecture.
>
> But you say you have tried that and it doesn't work. What part of it doesn't work?
> The Kconfig part or some code execution?
oh the Kconfig part. For example, make olddefconfig on a config file 
with CPUMASK_OFFSTACK=y only turns off CPUMASK_OFFSTACK unless I 
explicitly set DEBUG_PER_CPU_MAPS=y

Libo
> I'll test the Kconfig part of it later (in a few hours).
>
>> Libo
>>> Is there another problem here?
>>>
>>>> +    bool "Force CPU masks off stack"
>>>>        help
>>>>          Use dynamic allocation for cpumask_var_t, instead of putting
>>>>          them on the stack.  This is a bit more expensive, but avoids

