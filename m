Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFE4FEC54
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 03:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiDMBiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 21:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDMBiU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 21:38:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834BBA1BC;
        Tue, 12 Apr 2022 18:36:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CKgwRh031505;
        Wed, 13 Apr 2022 01:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P/oTSgmIFBVcNEZMHUhYWaJ/kgTlTJcILi/Bujh2Xss=;
 b=HgQno6C+80/DA7tm2NltFJwaIoY2CJu3lZmi3S/WdTUJiRqhwAUzfkvw71X6ac/IMG0z
 uaHDp2DCHAHW4cDb39py2ztdh2B+WfIG3YA4WxSOAIFvI8yM1MdXbAFUgrQGBmtj1gS1
 8vt+LmTlaXo3IBI9iq8vTsrS76C7Bjx7nj3zv/2OPRvH8DLlhtgHWgC1nQlsfy0liCux
 eBzRkQCKZuhp7MNmK//jvjrn9+9h4vJ0pxIZpvMW9R08i4TzThy/EoEGt378wF1Pqnyq
 H7KayHOr9VQq1ASD1SwtB2o8aK/DdYeF0N3++7m5Ma5EFvn4V6U05TtmeJalrDJqJ+5M nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs8km4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 01:35:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D1ZOl5029488;
        Wed, 13 Apr 2022 01:35:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k3wqt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 01:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQcwGC3byBp3/fbzianNp+0JpqGbKzH27rDBzus7a5IR57TBtlqe+jgj5ikx1pnjM5Dx56UlGaTzsA0yDalkRlTBTVza9pohTl+pjX1KVmxB37RGm8LkfWQGIVzwQvKe298yK4hnw9umI6Knz4+sEgneTwlBc5E5yfFzO4t+lqvuHWo/G3K6qgfBqPpnB6EazR175XXqz69TpUqV4c2KvF23pBYCk1adiOGStup+JKiCFTr6eU1fYmxc0KVU6njo9nTFt8BLSV7klwXtddptMO+0YBLVZL/YsoeUDXODqujNUPyo1jkNRYc4cH39gde/+piezL1f3zAjjjmGd6Z1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/oTSgmIFBVcNEZMHUhYWaJ/kgTlTJcILi/Bujh2Xss=;
 b=ECZnVjKl24GfTlpkgSHsYiTXEcTJaJd1V25nx1MtFhevEjfLg176nDwcJbee8m9FrTi2CA9fR6Vcq9dS3Ktmne0uvkWn4mJso78A8rPSu591dO4b5i8q9jNPNsHoGvK5Rtdjvh/nvW4liDPKjwudYY0pI2jS+Ladn6bxYiad2Gt+50qvnXnVPODtO2fNmFTKLzEt0Av9CId1dOHnxA61QaXYOJEfEEPdftMLGYzixeENZ7y3JL+SFpyAh0mcYBqMDjI7y2UkhIeJ8t7OKyH9ipvCiv9XE9GlfSk4k7WxMYje49xiO92ftv+wYqR4TXGBK94c+l8ypGXJmbyqR49kAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/oTSgmIFBVcNEZMHUhYWaJ/kgTlTJcILi/Bujh2Xss=;
 b=Gj8VDoC5Mh9GPcNECo5PSJ/7uf5suKd9ApMLEVBZZznFy6V9lPX9e7fLiL9KraiYO12DWIcrHS0/VQ5NZXpcfVHvQlru1QSfpTvTPKVbS57QBtrM3IGCP1UD26ey/cgtx/hgcreb1lAx02Gc8FbxztAXvt/zP8VH5zfo0fEPPoY=
Received: from SA2PR10MB4569.namprd10.prod.outlook.com (2603:10b6:806:111::11)
 by BL0PR10MB2932.namprd10.prod.outlook.com (2603:10b6:208:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 01:35:32 +0000
Received: from SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287]) by SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287%2]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 01:35:32 +0000
Message-ID: <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
Date:   Tue, 12 Apr 2022 18:35:27 -0700
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
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To SA2PR10MB4569.namprd10.prod.outlook.com
 (2603:10b6:806:111::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57107e02-717d-4492-a09a-08da1cede5ef
X-MS-TrafficTypeDiagnostic: BL0PR10MB2932:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2932DEF152DFEB3EAD4DDF8A85EC9@BL0PR10MB2932.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZqNAzV5tVSTvH0zEB4rO5/NvRsHMtgzgZqBfdwzWMW0pDwECyfjmfIcyXUGkwY0xt74VyL2hkU0mn5OhR76t4VlbxvBAAUurpvUPVX/KPJNssay864RZpdVf8RypxW30ibcrTxxIKv8LIHV3TKmr6hZa8jaWnufzMdW8C1dDsfcuBozJhk/Osj4R8D/7SIohJkwmFMPaf+XNZLG9RVWv5irEWYLKmZnAFdXGCB9oOltzwJEi4WyM8nRroMp+ckZwgehkAPWknV8598Ur1BwoelFy7HgGKCsXwIH8mbQMxMOgizpg2zwSCkkpDubAZyHkCWfUtBp4IvM2VcATm5h3AzaZ4iPSCPjOETD+dab2vd96LQK3RZyeOBYA7aIl4wbXAfSSsmoY1vaDPK8vqq+0V5RiznCbnLhZfK2Z4uG70jhYtaEOPvq5BPCOQP51jiyfTa/dtlvY1HdjEj2z+Gw2Q2UnQFoV9pq3ZrPAxXKQHaEsDBrtFX2ECF6nrIv8b3ew3GcXioKaMBjrQUB7Pziusllfx2/JZfE2dwAItANrLJl7tSLqcEV5XLcknrFURPmXncw5T/8/lpCnV2B9CpuSk72tLq4D3dLaukN4WOg2EL++6xjeDvA9khSxSx/XQ6AVtuU1mhCaNGpN0dKZHSBB9/bP3E4iElvy3vMVfslItkr8Al18T0IQ2O7ImrelYNY6wv2RVqVZoGwsb7FK2L9ayi+/TpFvEW145daa7zustLtT92xbvkt/LdbM0MP7yH+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4569.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(44832011)(66556008)(66476007)(8676002)(83380400001)(4326008)(86362001)(186003)(2616005)(2906002)(6486002)(316002)(508600001)(36756003)(31686004)(38100700002)(66946007)(52116002)(7416002)(6512007)(8936002)(5660300002)(53546011)(6666004)(6506007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZHMFpTRTMwRlRhZWlRWlZkdTMzVFRldVJIZjRpcXg0TENoTW4vaUFvWkl4?=
 =?utf-8?B?Z0hBdGZOK1Urb0NmeEk2WEZya3ArUkRkMWxKRmlvOVhXTEt0M2ljanFVK0tv?=
 =?utf-8?B?WWQvTVNENkV2L3NMQm5qZlMrVkJtNTNEZXZORGp1M01mMjVCUDZOTDB5eGZO?=
 =?utf-8?B?MGJRN1dYNjVqWU5SNDEzZldhOHgxVDZQUGo5Z0FybEtRUCtTU3p5STFnN3Zy?=
 =?utf-8?B?NGgzRWxBU09za1MzM3YxOHdPUDJLWktOdDFsU0xYQnhSTVkwSEIvLzFHajdN?=
 =?utf-8?B?QlB6WXgrdVI4SitoQmozWWpWNTk5S1YzVTdXQlBhemVrZGpvMHlMV1dDRUx5?=
 =?utf-8?B?bjdDbzFVTUNUYVRNVGY5QldJaTRjNGlGRzE0d1JsWFllWm96TjhFMDFlMklr?=
 =?utf-8?B?T0NzY3B0bXVNNHpmQzUrby9IUnFaSjJhZkRpNHVZZFROeFNxSjJUOXJDVUU5?=
 =?utf-8?B?Qzk2aVdjblJFSno3NmQ0QzRSMmdORUE2cXBhczVoNDBoejdndVE5d2hJUlFh?=
 =?utf-8?B?R29tQ2xhd3lFQUw2SXVnQTF1RUhUSzQ2V3hUb1ZtanQvUTNhZlF5L01vRzFP?=
 =?utf-8?B?RzAxaW9PbFlZSjlBL244MFk5ZEtkcGt4QzFuSVVXZVV2b21yR1BEUFp3ZDk3?=
 =?utf-8?B?N2RuVDAyQ002bjRLZU5WbWpvLzhsT25hTkM4T2FjbDVHOVhoL1V4V3ZJbCtl?=
 =?utf-8?B?dEtKMHVaemlFVjV6RmtuUE5CUGxZUzc2aVFTbmszWmVvVmt6aVZWQVMvWXkz?=
 =?utf-8?B?em4yWVkxZnZvN1B2NERFZnlMU09zOE5LQ0hET2lIMGVCU2dHWjFGY3E0R2hy?=
 =?utf-8?B?aldvaW5ocEtoWjJDNlVBOC8vV1BvTVdFNzFMYmNRc3JoSWlwMlVheHBNLzZx?=
 =?utf-8?B?cFBBWXMyWmxtOU9jcEVPdHY5NHdWanFvQ1daaEN4VHdxaXVyOElIMGc0OWhC?=
 =?utf-8?B?cndadTg2QjVaN1BpL1gvTVNYVlo2dDdJY2c5UERhTWltRit5MVZIUE9vbUNm?=
 =?utf-8?B?NDI1VWJ5NmZNaUthWXIxRlBPUHRybnF4bjFkUzhlNVJzUExNS3ZqQ1RUSDI1?=
 =?utf-8?B?NE9xcFVSQ3RlL0EyOXFQc2NUWFN4TjQ0OHNSK2RzMXhQQklGWm5GdWJpRjRl?=
 =?utf-8?B?QVdMY0VKMEsyOHhGYlkvRFFyeVFadnRpNmdpOXJCRE5ZTFJnNlVnWjczU2Q5?=
 =?utf-8?B?UXpwNnVrcjh6VTV4US84NFB3WGd1R0VsTTd4UWlBcTc1WTB2UzhDM0ZwOFdR?=
 =?utf-8?B?MmY1STY1Z3I5bXVQbTcvSEp5Qk4wM1RJMWhaS1NzTTBkNHFTaDNDMEZvMklR?=
 =?utf-8?B?QkJSSnZTajdTUStURFd0VWZ2dGVKNWFvdVJCTmM0RVBCemFTb0lybWhTeHdk?=
 =?utf-8?B?TUZQWHhVZG05M0s5ZlRRNThldThlUjFiY0NuV1RkWldLWlVBVFZjRFhYbWFJ?=
 =?utf-8?B?T1hYSGsvdXpSRm9OTU0zVGxVVWhWaUVsbnhHZjVTZTFNZFNsUkdmNnc2Tlhv?=
 =?utf-8?B?RDVwZXo3ZVFRek9IYk5pekVYazFVZ0V6T1RrRFYzVXB0eG8wNDA3KytKemFk?=
 =?utf-8?B?YVV3c2RpdytHelJUeVZFZnhudjJOdkhOYlV6cE5OcUg5UjF1b1VkZ1FwYnJG?=
 =?utf-8?B?dWYyWDlLanRjN2diTThqVW9sMi9JUk1kWTVtZGxJTXBWWUtUbzd6U0FXUit5?=
 =?utf-8?B?ZmpFNDY0RjJQbXY3WVNlVzR2SVlidmpaeDhKM21kMkFBQXk0VE83VDR3bWVX?=
 =?utf-8?B?NjE5NDBwTXNhOTM5NStuaHFMNlZBbG1obEJCc2xnaENyYWVlT003T3JtdWp3?=
 =?utf-8?B?akN1aTdmcEdBNDJBWFYvcVZPNGxRYnhjZkFnNFBwWFZCb3JxcDVWZUZUSThI?=
 =?utf-8?B?NkdxRTIwSkRla0J5VlpOaHVpcFFFaUVUZnAySjAzZEV0b2dDTTd2TlI3U0NP?=
 =?utf-8?B?RUt1M0c5Z0g0RGV5RmFKUmpFSTh6QkRBV29HOFUvMjBkWWEydlduMjhFV0c2?=
 =?utf-8?B?Vm5YKzNTWlN3YmFNVDlTYjVaNHMrQWJPSkVJUURvcDNrVFY1TU1pSHgxc0pL?=
 =?utf-8?B?N2t3YXJHeVNPVk10MnV3U2dkZm9MMjR2YnZ6WFZsMnhrRzBOdHhCU3htVklW?=
 =?utf-8?B?OTFrUGNKUWVLS2R0T3M5dkk1QVR2T01CVWJqbW9Iei9nVXJCby9OdHZmbzdU?=
 =?utf-8?B?Sjgxc0VvTFpWMEdXWVZudTJhanE0MkVoUUJGZ1VMU005NXB5eGRRS3B0b29P?=
 =?utf-8?B?TTViSUdSSUJaQy9nS0hmVEVhWUZDQmljcEt6NDRZVUQyaFJ2azN5dFQzS0Fx?=
 =?utf-8?B?cTdwR1Q4MFhDa28vTGdBVGRleXhPSFlDRHA3Y29Sa1psUHRmSjZmRFE1WFkv?=
 =?utf-8?Q?wAPTHUIu/GtBak9irCu/dg8PeC3T+I4OyqtcO612hhsxI?=
X-MS-Exchange-AntiSpam-MessageData-1: b7Qk62Ux3zZ8pw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57107e02-717d-4492-a09a-08da1cede5ef
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4569.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 01:35:32.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq42s97iCitBcIBZybUnjCI0TCNKMzxQOOiTSmG8kjw9AOvXw/nXFcpmE/+RSR6iLuAuOgp9c+8w0DMLzz+QCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2932
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130007
X-Proofpoint-ORIG-GUID: z3sY3gTZnr6OkhfkXx5sSRTCZ_7U7QPF
X-Proofpoint-GUID: z3sY3gTZnr6OkhfkXx5sSRTCZ_7U7QPF
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy,

On 4/12/22 17:18, Randy Dunlap wrote:
> Hi--
>
> On 4/12/22 16:15, Libo Chen wrote:
>> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
>> make a lot of sense nowaday. Even the original patch dating back to 2008,
>> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
>> rationale for such dependency.
>>
>> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
>> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
>> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
>> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
>> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
>> There is no reason other architectures cannot given the fact that they
>> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
>> x86.
>>
>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> ---
>>   lib/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 087e06b4cdfd..7209039dfb59 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>>   	bool
>>   
>>   config CPUMASK_OFFSTACK
>> -	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> This "if" dependency only controls whether the Kconfig symbol's prompt is
> displayed (presented) in kconfig tools. Removing it makes the prompt always
> be displayed.
>
> Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
> of DEBUG_PER_CPU_MAPS.
Do you mean changing arch/xxxx/Kconfig to select CPUMASK_OFFSTACK under 
some config xxx? That will work but it requires code changes for each 
architecture.
But if you are talking about setting CONFIG_CPUMASK_OFFSTACK=y without 
CONFIG_DEBUG_PER_CPU_MAPS directly in config file, I have tried, it 
doesn't work.

Libo
> Is there another problem here?
>
>> +	bool "Force CPU masks off stack"
>>   	help
>>   	  Use dynamic allocation for cpumask_var_t, instead of putting
>>   	  them on the stack.  This is a bit more expensive, but avoids

