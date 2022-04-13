Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258774FF8BE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiDMOS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiDMOS4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 10:18:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0261A24;
        Wed, 13 Apr 2022 07:16:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DDfRS9028018;
        Wed, 13 Apr 2022 14:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=srV6HHyLtBRl/IaJFkKSldk05tcf0nWiWzyq6u3AYnk=;
 b=aRBwej2b1fmx7auTzZZjpDlz6zGVvT0z1ZVX4T2VybhDazVMV4qIPbFrGo5mAZ4xsz8P
 qzUBPm5tPv/SvwAMI2u7HwCsX6+g1Dj0GaTlhRYER8ALEBVLT5b4rhP39ANojpyaNgSD
 RQseK7p9odtVjQuclNz1eIpEmnESRRIF3p+dLk951XXlGd1/uA7Eqbrg7/vfI7ZsKT99
 defwsLLAIma5rH6EIUVcUn4ldSU5999NyMf7g5Fs8s+lejREfyGdlvXoHL2Vz6j9sayf
 Q7jVmoXj75smAbqUMGw4iFVjFvvYAsshvsT6MYunfg2MDSOvX+yDqK+/4uFHpimDEfyA qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a1p44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 14:15:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DEBpsm040387;
        Wed, 13 Apr 2022 14:15:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k47ae7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 14:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGj+PfS0h1hQa5Z8s9dHuZOvS7s8hUHhIMnULTYdAWftT3+VR3BS/HiujNQllYgGw8wMqKL0NoPAdhGZBUszNwu7xnHoVGvnJcORY7MilldH2VQHjHfpuJGFxVwePgns6S5Sjq7REwxh+/PSwt2D538On7aKKaHrAp0CYTc4Z2iOHJ8o5GYpwh0oVc17LbTzFShe2Tgxb1/Cgti6w8bRzjalgR3qULfg/3hUdFBgluIMkgqKmpDm1z9F1weTYnF4ntGjUD0CSj9zl1ZBsYjbgmjv5QAy0eCcZjwQ38/NAYD93sar+vWXImkH6mvAq5LWeCiLeQ6PGNtRZtUCvMzA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srV6HHyLtBRl/IaJFkKSldk05tcf0nWiWzyq6u3AYnk=;
 b=cfh1KNpGaRo6UOZSVIxi5jTjHN9OgflXAxGGXcU90xWHOoyrsBVZqeQC0uo97xJBBcKv/z2WWl3Ww6JvTfa972R/k8ed3e1fA0u3zo1o3pSBNWp0PDUTs/45VdWFYKNUuuBcAv4l6wdok4rO9fnCyUXQUIrfw+bpWx6qH6vNa5pVr9EaH4yTG0Q8Mu2O6uUTwN3E2kKVYzlbQYrLtHPQuHZfR1MYwIohaM+tj1zgMbav11nSITqA59cxedU8mHTm/0sUiNHUe61NMrIk5+GAA9LeB2x51hgZFrSSVqAn89wlNlfOnqfQrwRQ9wtQEusMbALQIndVkP1fph5NMUHx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srV6HHyLtBRl/IaJFkKSldk05tcf0nWiWzyq6u3AYnk=;
 b=orGfqqvvG7dxkgnOzw6fd2rdlZLCSf2Ya9lv1DlAKIB4Ib9l3KFHYl5ydhhluHYVbU39dHKA7Oy9do8Evl2MLd9jtH95aWeVJNfwyDQSbYD5DAwkC9k+j6l5N0+w4Ty/GHLT1Zt+754vPuLlLz+1i4fLq9w278REj83yzC2Anr4=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM6PR10MB3691.namprd10.prod.outlook.com (2603:10b6:5:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 14:15:51 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 14:15:51 +0000
Message-ID: <c9a95b2d-9628-6c0d-5da9-c8164ff93a05@oracle.com>
Date:   Wed, 13 Apr 2022 08:15:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V6 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
 <20220413055840.392628-5-anshuman.khandual@arm.com>
 <c3619877-32db-aaa3-5dd9-4917c067bc42@csgroup.eu>
 <e0efde60-625c-fa58-79c4-5e8a86ddf203@arm.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <e0efde60-625c-fa58-79c4-5e8a86ddf203@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 506ef692-5d45-4ed8-c05a-08da1d581d85
X-MS-TrafficTypeDiagnostic: DM6PR10MB3691:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3691CD5F8E657F52CF8FBFE986EC9@DM6PR10MB3691.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AF/sauRK4DO/zM7uJD1VDDU0ACF3mGJZvmazjgLfOgcv/vsCvkJ6kqc+WttkpdqJzJo+gDRCLINnTmHZt7pfKcFztzasItfuqVAFRln1aDwmLIqYqNw3qt1MSJRTwFQmGEgTXPxUSCybqDGMSbW3mnI5pVxZS+eE90zANRjirorVbIRJFZ1ZVOfoDlMeIKlzhq9vs6mf0ZR6zIoz6k08o/4Cbxs5NSyH9OaiS8g8sFnd8q/mrl7LIuOFLMmdkWXyoA45SqVjJlGkR70AWdoaADePC+VIC60ZVx090+v6P2cOr2u/arw4ea+8ijDiemClIptHpVlKeBceMTw5oqDnvjR/bj4wst6eq14rt2sKL53D4Rg0kprwKDh2gbQIb+Ns/XQhEvHvq3ryafbIdFjTs+rCyM2ZtRc4En3lneplvGbQib42SNysTjGYF/6XWqItCkpvxxzZb/EEgmuFKsKOq+O7B1UhuVLalzd58ZchEE6dDWqsucL877b7xY2N8MA4r+dj7RhkxZMvKb6XtLeCrscQBrsIbYcZkZeV7DS9bLlIO2WT2/0F+QPZfj+jpvV4Jpe1TeIs71KqVwWeWwbJMwQjtCyrIvKt9mQ0Tzo831SpM1/+zFy6Jlhkp/3KucEx65dVAwwukHVJcIRWxonQiF7MoIbzPZcngwFH/ZnbO+gsB2h1Je/8lMj2pMIMhoNkgcpCQjgSuhij6avQRTZtspjlpX25M5UzuNVxMhgf8Zg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(31696002)(316002)(31686004)(110136005)(5660300002)(186003)(36756003)(26005)(66574015)(38100700002)(54906003)(7416002)(44832011)(86362001)(4326008)(53546011)(8676002)(83380400001)(6512007)(66946007)(66556008)(66476007)(2906002)(2616005)(508600001)(8936002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9pcEVGbCtKZDJUOUwxVUprdVNpM3pPMm8rTXNyR3ViUHNTY21oYkpZS3oy?=
 =?utf-8?B?WlZxUTVaZlhFVENnVUEwbGNxT0wwbk9JQTVYMDVvak1oU21EdXo1Y0RyMEQx?=
 =?utf-8?B?c3JaZ1hVTGE2RUNaelFaUEs5K0R5Vy8wcHlqSjkyZ1M0MzVyVmZWOFpKYWxD?=
 =?utf-8?B?aWJpRW5yMThmK0p0Ti80ZFg5c0R0NHNUSE5TRDNiUXQ0TWgrZWRxaXlUR3Rm?=
 =?utf-8?B?VXNjWHk3eUV1Uk9FbmFyUy9hbUMzMlJrdkw3Qjc4OW1USllSc1Yvc0V5Ylpw?=
 =?utf-8?B?U2U0Rjk0bW5kUEtKcFZDSzdmejhrZldyY1dNaEcwQ2VMZm1JSXJFZUxyS2Ez?=
 =?utf-8?B?QmFxd3lBbVpQcmVTNWxMSTBnRVVxN3pQRjh3RHZIY0M3Z2xZRVFyTzN2Qmtx?=
 =?utf-8?B?UTIyMGdHd1RKRktFR25nRk5zRlFBb1FobzBjZW5mdXFOQU9hSHY3K2ErRXV5?=
 =?utf-8?B?M052aHNHOGFXYnhvbUtpdmpBSWE5bjJaWFlRTndheUFSTmhqTnRscUJOQUJZ?=
 =?utf-8?B?Wjd6eWxGYU5vM3pod25JTm5nT09zeFVZQWc1U0RUR1dkcDRRSWJXTUw3Ym5q?=
 =?utf-8?B?K2lqWHpwL0dRcHNyRExiYmhjSUdFN3ExazR5ajZLQ0tJOFpYdGZSNUJyTDQx?=
 =?utf-8?B?WjZoUGFLTXFsRU5CT3NnWVBnVTdra0kvRGdVYVZrV0VIY2h1Y01PbG9TYWUw?=
 =?utf-8?B?dWxsaU5KbHVzRkJKd1o2TzNQSkhTQUZxOW9wckNwb3hvSkhOa1FOazNlMEhp?=
 =?utf-8?B?Z29GcFAwMjFPaHRDL2hJRTV5cW14RlU3SzVqcEpXbDA1dnRzOEhiaHR3aCtw?=
 =?utf-8?B?aUl2dFphVXNPTURBc1U3VTNqVUIyaVZDWlFQL1kzOFBNMTkvMXBzMXFhRDND?=
 =?utf-8?B?TCtWSUlKcTVGZ3BVQ3p1c1pwcHRQR203MHJucE5iRDEyN0RFY29EUUFJRVha?=
 =?utf-8?B?VEttS1dDWXpaQWlwU3pxYUdQSUtXYU9CZlROUVE5UG9pNEk3NlFnY0w5NnNG?=
 =?utf-8?B?TklVUmUrdU0ycC8wdnlmVkt3REZwQ3QwSEMvMm16Wm1jSWpEdklReDl1cE9q?=
 =?utf-8?B?SzJhSzRQUGtqenNYRXJGcHM5OUNReS9HVTltVFJxYWJyN3kvbmVlSlpzL0cr?=
 =?utf-8?B?OXBoUEFZM2lSamx3Tk5TcTlVb0F2SmptTTJiUjRWYitMWnhKRXNMYUh1SlF5?=
 =?utf-8?B?ODlCTWY3Z2V0cmRvQTB1emo1VkwvVVZqS2c0a09wclZzcnR1d2p0WVF1THpE?=
 =?utf-8?B?aC9Tdmphek1QM0ttdzNkSjBrTjRsS3NCVkNTVHl1R05VcHNKOUNmMForNnpr?=
 =?utf-8?B?NUxQaHVRbWF5V0NIWERuVElJTVcyVnp0cS9MV1pKY0JGT3VVZUdDTjl1bzB2?=
 =?utf-8?B?TThyTjVhNkJXYXZIUmJXcityRmo0MjNhYy9lMHp2UWVkalVNVHdpcS9nRVgx?=
 =?utf-8?B?QVRWb3RyeTYvbUx1RnJzaXhBTTNDTzdCU3RSa2NqY2VMcC9wNkhIZEFGSTFm?=
 =?utf-8?B?YWgrcEhpd01INkc3TFlTWlpxakFNeGw2cDlkdkdJNjV2bGdlaFh5N09JQmFa?=
 =?utf-8?B?cGE1TGxnanZNM3dxeHF2NnVQRXlXQTh5a29sTkFVY2oxWk0rTUNqby9yc09o?=
 =?utf-8?B?K2JSZmxSdDV5L1VLN2pOandGbFByRnN1YVVjbjdTUEVBK0dHeVJMTGxtRUtl?=
 =?utf-8?B?RTZrS05BVGpUcDJDbElwMXJPL0huVkdKWGFIc2NYc1ZMOG1ISzRMY0pPVjFm?=
 =?utf-8?B?UDZWYW5Ndm02TDRQTUlDTmpCYkJrRHdLUGdwMk1DdjhLS0NORmg4WXVVdDQv?=
 =?utf-8?B?RVBvNTZCSy9TdTNOUkVXYWgxbTFaT1BIVDQybE1YWktSeXNiQlFvcVhMRm8y?=
 =?utf-8?B?Y1FKS1ArMmpFRmprd2Z5MkloalF1aEdyK2ZWSnJtdGg0ZVlJS1RNWTFDckVx?=
 =?utf-8?B?eHBoT1lOQzZRSHIyaVhMNWxqKy9lRWI3RzVJWmNkNEdpRFo5anBqby83ZDJi?=
 =?utf-8?B?azVPbFRCTG8vZlFXTVk5RjJFZFZwbzhaUTkwTW1sYnNHaHh3NjFPMkJiNmRR?=
 =?utf-8?B?M08vK1RSdUtPVWU2Qk5zWXFISVVrVExJemI4ZnhhV2d5Ky9VU2VGQi9KZEFC?=
 =?utf-8?B?SVd5Wnk4VnluV0JHK3hvaFdQVlVueVVaQTRrMFh5ekFyQ0ZwQzZiWDlNekxs?=
 =?utf-8?B?a2c2UlpoaW9VeVpkM0xraldjcHliMFFhQjJmaEl6dW9GR1EwbU9DblFDQnBh?=
 =?utf-8?B?Vk5GL2xGSnBHQjVHOGxmZU1NWEc0ZThzYmhnd05yRHpkYnUwY2RXOElKNWlI?=
 =?utf-8?B?MnF3TVFUTDVobEZKNStmZTlnQnNxWjRyTXNCeTZFVVlLZDEzRHBUZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506ef692-5d45-4ed8-c05a-08da1d581d85
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:15:51.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZUsDkf163W+j054lgF9RFKDKmn2GZk3LexnN1G5txM8Id1rqTkYrtvpLUqj8JMfWM/cXe/f7G/GFzbNuSK6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3691
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_02:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130076
X-Proofpoint-GUID: iBbKMebAFKxn6SQC2Cc9RY6b4TFPWHHV
X-Proofpoint-ORIG-GUID: iBbKMebAFKxn6SQC2Cc9RY6b4TFPWHHV
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/13/22 00:22, Anshuman Khandual wrote:
> 
> 
> On 4/13/22 11:43, Christophe Leroy wrote:
>>
>>
>> Le 13/04/2022 à 07:58, Anshuman Khandual a écrit :
>>> This defines and exports a platform specific custom vm_get_page_prot() via
>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. It localizes arch_vm_get_page_prot()
>>> as sparc_vm_get_page_prot() and moves near vm_get_page_prot().
>>>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Khalid Aziz <khalid.aziz@oracle.com>
>>> Cc: sparclinux@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    arch/sparc/Kconfig            |  1 +
>>>    arch/sparc/include/asm/mman.h |  6 ------
>>>    arch/sparc/mm/init_64.c       | 13 +++++++++++++
>>>    3 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>>> index 9200bc04701c..85b573643af6 100644
>>> --- a/arch/sparc/Kconfig
>>> +++ b/arch/sparc/Kconfig
>>> @@ -84,6 +84,7 @@ config SPARC64
>>>    	select PERF_USE_VMALLOC
>>>    	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>>>    	select HAVE_C_RECORDMCOUNT
>>> +	select ARCH_HAS_VM_GET_PAGE_PROT
>>>    	select HAVE_ARCH_AUDITSYSCALL
>>>    	select ARCH_SUPPORTS_ATOMIC_RMW
>>>    	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>>> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
>>> index 274217e7ed70..af9c10c83dc5 100644
>>> --- a/arch/sparc/include/asm/mman.h
>>> +++ b/arch/sparc/include/asm/mman.h
>>> @@ -46,12 +46,6 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
>>>    	}
>>>    }
>>>    
>>> -#define arch_vm_get_page_prot(vm_flags) sparc_vm_get_page_prot(vm_flags)
>>> -static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
>>> -{
>>> -	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
>>> -}
>>> -
>>>    #define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
>>>    static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>>>    {
>>> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>>> index 8b1911591581..dcb17763c1f2 100644
>>> --- a/arch/sparc/mm/init_64.c
>>> +++ b/arch/sparc/mm/init_64.c
>>> @@ -3184,3 +3184,16 @@ void copy_highpage(struct page *to, struct page *from)
>>>    	}
>>>    }
>>>    EXPORT_SYMBOL(copy_highpage);
>>> +
>>> +static pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
>>> +{
>>> +	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
>>> +}
>>> +
>>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>> +{
>>> +	return __pgprot(pgprot_val(protection_map[vm_flags &
>>> +			(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>>> +			pgprot_val(sparc_vm_get_page_prot(vm_flags)));
>>> +}
>>> +EXPORT_SYMBOL(vm_get_page_prot);
>>
>>
>> sparc is now the only one with two functions. You can most likely do
>> like you did for ARM and POWERPC: merge into a single function:
> 
> I was almost about to do this one as well but as this patch has already been
> reviewed with a tag, just skipped it. I will respin the series once more :)
> 
> Khalid,
> 
> Could I keep your review tag after the following change ?

Hi Anshuman,

Yes, this change makes sense.

--
Khalid

> 
>>
>> pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> {
>> 	unsigned long prot = pgprot_val(protection_map[vm_flags &
>> 		(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
>>
>> 	if (vm_flags & VM_SPARC_ADI)
>> 		prot |= _PAGE_MCD_4V;
>>
>> 	return __pgprot(prot);
>> }
>> EXPORT_SYMBOL(vm_get_page_prot);
> 
> - Anshuman

