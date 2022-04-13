Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E26C4FF040
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiDMG7K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiDMG7G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:59:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EAF32063;
        Tue, 12 Apr 2022 23:56:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D6g93O012784;
        Wed, 13 Apr 2022 06:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gd0JQmiGkdZHDzXavLToBiy+pDH77WxHCrsdwnkz/5o=;
 b=S4VeImacHm95PsHuzR6b7JM+We9aPFgjhK61TxQCwX+0J8NIkVGFgo+VykdUC6jre503
 czoWlQEyM7exUYDkyEY3N9MkLDx9BrkhegDHpIxDbA1Jmx7S2WWR+dDcy/qtNcFFdrPU
 JJ91H3gY6r+h5sSR0pZVmDx+6YHiVxzOKgMHKk+XGtJuyc1R8EykRVBu3bES1aFkVCAB
 Vn5XxMenhbnaqC+uYN5Ot/TAmQgD2VtmGwmg8cLf7Tk0pAZ3NwYdsOSurQZCBSt6UIov
 qmZ0rGlw30IaT9Vgzt1sKv+oP3WNTQumTvyOGYfKCnucj8nxlJWHRKSPI0nJaZeUh1Lr pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu15e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 06:56:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D6pKxH023499;
        Wed, 13 Apr 2022 06:56:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k3dwu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 06:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAoSgBGYVN7mUu2qPEC039jPjexBv1R1UdUCjGqaWB8VaCOdC1Z/R/MNjLHqASqFO2aENaHAw71AjZk4cXLLX+a9IlksoVmPYueB+t8yhf3Oh+HBB6LLBW/3MSA9qUAp8JAoDflHeu+Ys8NJwA5fMnVOWK6HhPBHC0M7ch6SsmH9FK4cyIDXtpj/BR/pc3/pRwftcSrRkfH+M5bf1wJ//ODHvb3/P5NC/8Svg5pQ5cSsqU4s64Cx2epxuGlJOdKZ/GFI9rjrUeQo1MySX3Uti6LLSnedxt2DGjBgH3O8H4osl27kiEMvqmXHmHgfaw5LrSujCFbNscvF1CjNkH/MTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd0JQmiGkdZHDzXavLToBiy+pDH77WxHCrsdwnkz/5o=;
 b=l6TtpAqKyTuekRB+kvwz7a0JFSIGnLijw9+JK+cndcKL9IrbImczb/JtVieLSn/xn5al/nhjVUZBXyY2b97LtTGbdFL3b3JxJObRoLLNueBVa9NXCVH2NPvkmB+iYk3ZSbqhvJ8PzgsVOIrBCRsdOEDrEevEjAE8atDSnG+uLsh+Cis6ctgdlqG6BiKJq8D5mius2U8NbyrDx8i2Fhf71W1Lx745r2aaWGJbJ3qy12K6r3bvc6dFepfWqZIKUV58PmsgeRIiiiNwalKJ7KcHJTu6Q+usCH9dpsBxiMQSiBZNXiPxCzlK5TuNjVnWRw1oQjRhfvyheNTBkRnseOq/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd0JQmiGkdZHDzXavLToBiy+pDH77WxHCrsdwnkz/5o=;
 b=k6w5Yw49iaOw2KTaO6epGQvpdVS7SLWM8Eg47cE1tiBKbGwbZNzvjMHHW5xAAGIKmcuqCcuS3WFQZ75EJSun7o3ZmV0CvMUDQIWxjS200s2+lj9zkO0ZBEBVJWAbbA1Z4cyQk9udwLgrEDaoGheyYJPKOcITKyqm+r5pH7oEXQw=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by PH0PR10MB4487.namprd10.prod.outlook.com (2603:10b6:510:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Wed, 13 Apr
 2022 06:56:29 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 06:56:28 +0000
Message-ID: <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
Date:   Tue, 12 Apr 2022 23:56:23 -0700
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
 <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR14CA0062.namprd14.prod.outlook.com
 (2603:10b6:5:18f::39) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9137e4-3f10-434f-6733-08da1d1abbb1
X-MS-TrafficTypeDiagnostic: PH0PR10MB4487:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44871A63B14F98DC3678B8FF85EC9@PH0PR10MB4487.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cedEfIQFHvm+T/BukBHJzW9sDL7tUUIcrohpE6d/Ac3ZTIhMy9ZY3u/vwjNAdDRVo5DeGuColSQu0MWD0NLHHDQ9FT9hc9gfZzfp/Lx4OCarXKO0P3AbdFr+GahE2fXlGjB40iov+YmyGtUADzeRiFjpQFwEzrDcKczzdk4sCz87hcUd9lVWtSi+GvjP7mIdY1LLJHklAvZqvkIcf6Z9lwpNmpU4QSExC+GYn7oRIPXyiU0VYs6eugmlorvBRIEchevD8nvQ4OUR4yO1GIQMStGEpbncS07OcWB/JaHylKbGYNrjkZEgPGfj5SGhQO/tTu1zr52XqU1dYOQnnGLqvSMlXsdGV6wqdHPtSdGBgplMs3W/VZHWWJTy1FeHKDpscqqH68hVmhDS4X/nAkdsRO1AjY2nAzmbsAj3xu4N+SrliDdEETyim38UiHqQps1zUkY9XFusjm7vwiU8VmLsOs09qi9Bxt2rU0iliVmsvuYxLndcJ1TXseZuPHHkslhDNN3X7MnuyOllWZI0bA4hEkMo13P1fIzIx5ujtFs0Xthn+W+bQoIUKmLcFhWbnodiQvQlcI/6YKTWt6DYZtdF62Ba/bFH88Nn5jXc+nSkOWw3iknDQsbZlRdImqozdYm3TeTJxeCiYdYqWRWIGQJMxAjk3z1aQnHpfO8QPRBJtxZLEJu8Uo5l2szD3MvEfzx2N66AP2tC7q16P0B/VsyxK5jNpqhrsAaU/rsnjvdBKwAorQU4iaK1/ZYGzOz+Galz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(6512007)(6506007)(86362001)(52116002)(53546011)(2906002)(36756003)(2616005)(6486002)(31686004)(5660300002)(4326008)(186003)(38100700002)(8676002)(31696002)(44832011)(508600001)(8936002)(316002)(66556008)(7416002)(66476007)(66946007)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGROVnYxSjRpNWt0NDVSVU1VSjYvUmU0ZFIxc0NaR1J6RkVnU1lYeFNIZUlY?=
 =?utf-8?B?VWRVcndia2FSTHVmdHFrbjEydXZMV2Z6WWZjTHdwZTBOQkdKRFZCUmd3ZU1R?=
 =?utf-8?B?Y3NRM3FlWExNSjJCMWNiMnJJeEM2a0NPUXpLZ2NFSzBId283NXRER295a0ll?=
 =?utf-8?B?Szl5dkQrMzRPSFpyN0RHT1ExekNaa0pNSHdwcmRpbVJ5SDhBN3YvMXdyai81?=
 =?utf-8?B?YzZGMmdoMmF0N0JxUVNhVnBjTTUxVWFyUmdFMk9TQllFTVM3dlhKLzdKbmQ4?=
 =?utf-8?B?Mnl0ZWExaFVxWWdVa25aM2gwTDZ3dE9KWUVaaWRnWk5QZFhYV3ZqSnpPeS8x?=
 =?utf-8?B?NFdiRmw0cWFQck1VZjVuWGthT01GZW9JalVQZFZPSUtwUEY3eTVMeXRmT3Fr?=
 =?utf-8?B?bGxUZ0JWQ3RNa2dySzludGFlSzM1eHZ4K2IxbTNBSmtTemNocjExVlFvc0hF?=
 =?utf-8?B?QjV0QUk0LzFpSHgxdGlLMDQzc2xMTmViRy9YNGtQN0R3ODFxY1laRG5SR1Vs?=
 =?utf-8?B?bGZaNThscmo3WWpUcVJZTmlNUkZ5eVlHb05oOVNIU2ZIMG1GczRpd2lmM1FR?=
 =?utf-8?B?TFp4dm5UTDVOOW1qd1lPUlc2UFlhaEdBQ3dVQlRqSWdSOFJKbDI5MnhJSDRS?=
 =?utf-8?B?NHhSRXRzNFNOMHpRRCtRSG9qZCtWSFllMFBVRzhsRzQ3TDRTUTZFMWNxS25x?=
 =?utf-8?B?ck9iSElTTGxMWVd1ZzRmeUFQQzV1ditYNzFHVXlLWm1xVm81S2plc1pkUzcr?=
 =?utf-8?B?QmZkakpMdVg0R2ptNUtZSm1zSkxyVnFUVU4wM2FTTkZsMm41NTJhdEtzTkxG?=
 =?utf-8?B?YzJqRmFKZGRMWnBXSkgyTHJUbUp1M0Fzai9HTUpyZnIvaE8xQWZoVzZwZDRR?=
 =?utf-8?B?NENxc0hBUlpua1gweG13RC9lRjFqZzJLMUtka1ZvZC8xUndqSGRjaDdvS1g2?=
 =?utf-8?B?RU1HY0pvdHA0OTJTQVNTTWltUTBJQVZLZWtPbS9OTW5hSE5DY3VqaWp1Y3h2?=
 =?utf-8?B?QzRramhOOUNzY2tIUDBJblVEbE1uaCtuS2Y0RHZYV0s5WDhWQ0tzdlMzQWg0?=
 =?utf-8?B?UDl2QmUwenkzNEh5WkY2ZldpaVRkV0QvcGtMcHN4a2xGdGczdmE3Y3lKYUZu?=
 =?utf-8?B?WURHdWRCaXM0UEpCaVdFZ1RJZHUyTEVHR21zdUZISnZVQnZCdExnYU94VEFs?=
 =?utf-8?B?aGRNSDZLdFlXeTFOcGJIVnEzeTZwWlU4Wm93NEs1WlNQb0tTMndVZ3ZKb1lx?=
 =?utf-8?B?aUw1QVE2ekpLMXVSUGwxbkRoU2hMbnlZMmFPMi8vVzFicUVvZm9Gak92SlZn?=
 =?utf-8?B?UFlkR2xkSGV5WUlHb0dmZXNEMEowMVJoM1pRbm5kN1JVYmh4bUlZelYwWkZp?=
 =?utf-8?B?T3pqYThUVW52RGp2R3Fsck83a3Zhc2xBbXZIRFdvYldwVFFzVTZhcW9lYkY2?=
 =?utf-8?B?UGVYOVNuUVc5N2tJZXlSczMwcDRSQ3ZVVTNIdzJSOVZMaEozTG1yU2pxeDB2?=
 =?utf-8?B?VXZ2b0QyR2xsYm1EandqRnlsbldXN1F0WVRIOXd5RnM0Q2lGS3EzcFBXUVRn?=
 =?utf-8?B?a2FFVmJKUHg0SS9nemdzQXJnY0lRenVFMlZ4UzlwQWxORy9XdnNHcTVWZkRQ?=
 =?utf-8?B?bkF1c2s4WXE0YVd3ajR6bzlTK2NTV2dlYjh2bFhGdU1yditOY0pMaXRTa2tq?=
 =?utf-8?B?ejJ1a1ZQNnYzK082MHlYaGEwYjNxWkZza0FRR0pMZmtaWGx5RGFnVFFyOEZ0?=
 =?utf-8?B?ZGJKTnkvZ29jRlI0clVsd005TE0yUW5NVFhxYjBYTzd0bnZkYnAyaldlZmR4?=
 =?utf-8?B?Yno5MVNQanFNWHYvRGpwMzhkMXhBTUdZSTNNektmV3ZsRkhhczJDbXkzNDVt?=
 =?utf-8?B?SjcxMHVEQlMraTdQV2JTbWFLNVYwMVN5ckNhUkdnRmhjQ1NHOWFnbkZHdytS?=
 =?utf-8?B?OUR2TjdBZUo0Rk5lcklLdWlCY3ExU2hKTE1YaHBpTDYzYzN0bWxZMHMzamlq?=
 =?utf-8?B?MEJCM2RTcWNzSEJpZVBxWG1NQjVRdlFNMzU4Z1N1eDVVMHptQ3l2VnkzUms5?=
 =?utf-8?B?ZG5tLzhNVkhBSUM4aG5qa0ZJNXBkYXl5WnVoMU9qcC9zSmtrelFTQStwQlZP?=
 =?utf-8?B?WXdwSkc0N0pKeXN4Y2FKdXh0VEhIRjZjWms1SlpRWlhGR0k0UTMxMjE1TENj?=
 =?utf-8?B?bWtGWE94QXdSaHZmQy9VYUpvQ1Ewcis5cFFHUUFGZ0hFNlhOYVdNS1NKb2RN?=
 =?utf-8?B?SmtpVWF6SEk4WW0vNUhpYlZNZHpHQjUwa0hqcXB2OGFiNmFiaURmNDM5YzNF?=
 =?utf-8?B?ZlVBbXNKR09Odkt2ZHZuR3dhbEsrTy83Szd4dFpYcHlkQkNWY0dGcGt2cUNY?=
 =?utf-8?Q?s2RyHcBRapqSO3LeJlZe2hIc9biy0TYPlG2ug?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9137e4-3f10-434f-6733-08da1d1abbb1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 06:56:28.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2IWfwkIhD3MPp5RoLs8PtUto2oWByBypCqrZIVa6frbkH1v9Q1mQRm2Yqrhlsx0wbZGr+RzZiK5fG2g2lPEsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4487
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_08:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130038
X-Proofpoint-ORIG-GUID: YHjxY5NXOj_B0bhn0PwiuClA4QznLon2
X-Proofpoint-GUID: YHjxY5NXOj_B0bhn0PwiuClA4QznLon2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy

On 4/12/22 22:54, Randy Dunlap wrote:
> Hi Libo,
>
> On 4/12/22 19:34, Libo Chen wrote:
>>
>> On 4/12/22 19:13, Randy Dunlap wrote:
>>> Hi,
>>>
>>> On 4/12/22 18:35, Libo Chen wrote:
>>>> Hi Randy,
>>>>
>>>> On 4/12/22 17:18, Randy Dunlap wrote:
>>>>> Hi--
>>>>>
>>>>> On 4/12/22 16:15, Libo Chen wrote:
>>>>>> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
>>>>>> make a lot of sense nowaday. Even the original patch dating back to 2008,
>>>>>> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
>>>>>> rationale for such dependency.
>>>>>>
>>>>>> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
>>>>>> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
>>>>>> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
>>>>>> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
>>>>>> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
>>>>>> There is no reason other architectures cannot given the fact that they
>>>>>> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
>>>>>> x86.
>>>>>>
>>>>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>>>>> ---
>>>>>>     lib/Kconfig | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>>>>> index 087e06b4cdfd..7209039dfb59 100644
>>>>>> --- a/lib/Kconfig
>>>>>> +++ b/lib/Kconfig
>>>>>> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>>>>>>         bool
>>>>>>       config CPUMASK_OFFSTACK
>>>>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>>>>> This "if" dependency only controls whether the Kconfig symbol's prompt is
>>>>> displayed (presented) in kconfig tools. Removing it makes the prompt always
>>>>> be displayed.
>>>>>
>>>>> Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
>>>>> of DEBUG_PER_CPU_MAPS.
>>>> Do you mean changing arch/xxxx/Kconfig to select CPUMASK_OFFSTACK under some config xxx? That will work but it requires code changes for each architecture.
>>>> But if you are talking about setting CONFIG_CPUMASK_OFFSTACK=y without CONFIG_DEBUG_PER_CPU_MAPS directly in config file, I have tried, it doesn't work.
>>> I'm just talking about the Kconfig change below.  Not talking about whatever else
>>> it might require per architecture.
>>>
>>> But you say you have tried that and it doesn't work. What part of it doesn't work?
>>> The Kconfig part or some code execution?
>> oh the Kconfig part. For example, make olddefconfig on a config file with CPUMASK_OFFSTACK=y only turns off CPUMASK_OFFSTACK unless I explicitly set DEBUG_PER_CPU_MAPS=y
> I can enable CPUMASK_OFFSTACK for arm64 without having DEBUG_PER_CPU_MAPS enabled.
> (with a patch, of course.)
> It builds OK. I don't know if it will run OK.

I am a little confused, did you succeed with your patch (replacing "if" 
with "depends on") or my patch (removing "if")? Because I definitely 
cannot enable CPUMASK_OFFSTACK for arm64 without DEBUG_PER_CPUMAPS 
enabled using your change.
> I think that you are arguing for a patch like this:

I am actually arguing for the opposite, I don't think CPUMASK_OFFSTACK 
should require DEBUG_PER_CPU_MAPS. They should be separate and 
independent to each other. So removing "if ..." should be enough in my 
opinion.
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -511,7 +511,8 @@ config CHECK_SIGNATURE
>   	bool
>   
>   config CPUMASK_OFFSTACK
> -	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> +	bool "Force CPU masks off stack"
> +	depends on DEBUG_PER_CPU_MAPS

This forces every arch to enable DEBUG_PER_CPU_MAPS if they want to 
enable CPUMASK_OFFSTACK, it's even stronger than "if". My whole argument 
is CPUMASK_OFFSTACK should be enable/disabled independent of 
DEBUG_PER_CPU_MASK
>   	help
>   	  Use dynamic allocation for cpumask_var_t, instead of putting
>   	  them on the stack.  This is a bit more expensive, but avoids
>
>
> As I said earlier, the "if" on the "bool" line just controls the prompt message.
> This patch make CPUMASK_OFFSTACK require DEBUG_PER_CPU_MAPS -- which might be overkill.
>

Okay I understand now "if" on the "boot" is not a dependency and it only 
controls the prompt message, then the question is why we cannot enable 
CPUMASK_OFFSTACK without DEBUG_PER_CPU_MAPS if it only controls prompt 
message? Is it not the behavior we expect?

Libo

>> Libo
>>> I'll test the Kconfig part of it later (in a few hours).
>>>
>>>> Libo
>>>>> Is there another problem here?
>>>>>
>>>>>> +    bool "Force CPU masks off stack"
>>>>>>         help
>>>>>>           Use dynamic allocation for cpumask_var_t, instead of putting
>>>>>>           them on the stack.  This is a bit more expensive, but avoids

