Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EEC5205D0
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 22:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiEIU0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiEIUYl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 16:24:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC7A2618DA;
        Mon,  9 May 2022 13:08:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249IwwHV021122;
        Mon, 9 May 2022 20:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WnqaMU1mkikP0ixNCni5W60M3H7cJcQ7s4DwrovBUlM=;
 b=tmunh8uyu39tV926iR3qMcQ60c25FnZuGB9eEJSIbK7AJ4fkmdjc8+emJBpWxoOBs1QY
 Y6YYPEjU3rUp97lQUdEgrbfk1/Yia6ZwXh1LS6ljvEe4sFtAu51WhJLvHUrNBAGcCjLR
 aeoI9Q+oX1VHzxkFqc5uz9joNVpBUCOlptBAQ/mQQNTXCi/twWyB30nQ4+p0PB+DYVSi
 0M/Ubt7yfJSCNoGnppWpub3vv6borz9kPFniriZlLazdWXQeJ+d5z+JX/Kw5qnwFVYqp
 SUTArt1j9Cn1w+L9bwDqM2xp8VyEmx+7hEb3Z7/jrjSGFcEEPejgjmqjQUatMUgEVsFH lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2ct8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 20:02:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249K0vKu025122;
        Mon, 9 May 2022 20:02:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf78jde2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 20:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlKy5z35QrlTOo3AKG9LSamnxCCuxKgoethTrzEF1YtxrTO6t83TAZbio5zygJ0vBM4r8AFZhxQFdpyaRRKSsYXjmj+F2coOoac5fCpaNMPOPRaLQVCiZ5iSIUyw3S8Vs5j0ZRfIgkPFOalJ3TQBthfZ47xIFN3oF4SORGXushYv6hmHeQt1hwmOkxnOsL/F7UJnrr6R3B6mMr0mVW61hEEBEpkaiA0ObhKsTWPsEPO1aLWT/+0gzbdSOt+RMol1vJfzabc43zYvENbgtu5BvOt3xZpAEheSQrtqUWNYkCV+w+7KEYo68eQsVkVMVN3SEyMk6xgpdvvA1TdGqO1/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnqaMU1mkikP0ixNCni5W60M3H7cJcQ7s4DwrovBUlM=;
 b=CR8HuROtY3UswRp7196/ne1dKbIvV+V/e80SM4PkLhmprAjJYiS58wEhzABhi69mn0QzwStPe36siclmo9F4P84swgPrGv1visHZJPqJaAZbT8O6Vejh2FhPHkXgHGQc3DdooaJGKT99KYM/DZjy1yIKWz1qMxLKGu3s8jcrJk5vnPiX7iXkYgE3ND66QuJv2eggwO7TDFBc0aScZHCUp/7orE9EWJPwH/tRRy10p6VVysMT0b9f4UIXb0tQFPEFVvZPkaHDfKVySD/UNgeNArqPU9w+rH8T9o9F3HAJ3Y5zH9qrjfERs8VxDWICMFzdGO99Qu+6gmgeSmoJIhZiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnqaMU1mkikP0ixNCni5W60M3H7cJcQ7s4DwrovBUlM=;
 b=c+JY7/TG3ieqGGyY+Bvmnh3EGbvVQswlEgfIQ2EYIToC0kkdqexUEy2XzXOAZiP2Jd1/cumutJ6EPZr1YP2HNaqodL7FG1N7HPoj5IfUf2derXfGcXggIj0wEmiTzxgziPoy7kUHROBJL3WIcWX0C/IlNZ1AuSWEIfpz+FRhCjY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN7PR10MB2417.namprd10.prod.outlook.com (2603:10b6:406:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 20:02:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 20:02:27 +0000
Message-ID: <de7ca6bf-6a82-acba-df63-ee78eee6ee2c@oracle.com>
Date:   Mon, 9 May 2022 13:02:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/3] mm: change huge_ptep_clear_flush() to return the
 original pte
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "dalias@libc.org" <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "deller@gmx.de" <deller@gmx.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <012a484019e7ad77c39deab0af52a6755d8438c8.1652002221.git.baolin.wang@linux.alibaba.com>
 <Ynek+b3k6PVN3x7J@FVFYT0MHHV2J.usts.net>
 <bf627d1a-42f8-77f3-6ac2-67edde2feb8a@linux.alibaba.com>
 <d5055b48-d722-e03d-fc32-16fd76e3fa22@csgroup.eu>
 <a6cc9765-1d8c-b725-978f-53f226d2fbb9@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <a6cc9765-1d8c-b725-978f-53f226d2fbb9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc4bebf-a905-42c9-d5dd-08da31f6d759
X-MS-TrafficTypeDiagnostic: BN7PR10MB2417:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB241732D1E1489A9EC9F5D582E2C69@BN7PR10MB2417.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLBDy8WkfmhOHnqSP5Ma+lH4UiFXr1o5QDm3I7r5zWYat5FlTLf6BHsdVC57Ovkle0fJtSguJ5sRIoCSHsoJCyWfrtpX6PSCkbSQrLtvSf2Sr6JHAMvtwxBWW44KX3oaQp1q7AN6J2/iUFR9kAGg9IOexeA9Q8umBdzPEomaoTFR5FAFEb7Fajhe1JQLy+aw88dtSUqQ3YEA1yLTLVFp5PloiCNFzyKysv56mU76EEVVWMNEp2ZInVonvE9Kl+5EebI4/pkjPJ4vHXY8X2lHh2g8XcGc/gExm+Pip0mE9Cz/sXnDEezvGJDBCA3LzqAJhu67oYD6kb8DDYDKRq2x4FEHrnGXWMQY3hZQZ151P+kD9EoJuQNfd7kh9kwZuDWeTllwQVElgYo3HCiG9FLbnoSDK6KgHA/+xDpEPEoj3AeCyEiN4F109/dwCmvVGTVkciSj6rgBVjM7Skn4tBuHVLRJdyRbJN7SH0cDGdNHIpIqDkwNl2BA9v9dIiktwfiADaETpxd3Cr/trbC6GQUCfmPekvOm8UPcXnWeQqFxlJFuVoLFlLImVo5Fkpvmy6cL5Q90Ke6KCwvcNc+CwdGJb622DAhhZDFj8+pvcizUJO9u2qtHrL62J9A1KQOpcZX9/RayrvhN8JCdnGS6ynETgl07MYqVlr3d1nEtQzLLggl0UcGO5KQe81V26QH/XkMN/SLsclabwdlPQZcNJ2JvIC13xLK78Yisc8Li4YVb0HtcffqNXfqK3tZDaZ87OKH1f6nrygvlPEliJVnsYc1oZNwJM9dMUdniAHE+JShmjrijJBbes8um3Kx9Wnwmqf4kQ9tKfGBZ+krPgtvdlFjweWzwIulMcYZWVCHfwCXPhCkDKVOdY19pjSd8niGgU9W1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(966005)(86362001)(31696002)(6666004)(53546011)(508600001)(7416002)(52116002)(7406005)(6506007)(5660300002)(8936002)(83380400001)(38350700002)(2906002)(6512007)(38100700002)(26005)(2616005)(186003)(66574015)(316002)(36756003)(110136005)(31686004)(66946007)(54906003)(8676002)(66556008)(4326008)(66476007)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REYvb0VnWXJjTXc0Rjd3YjN1TmdSVXZxMHFUb0tUNm5icVJJL0pEQm02eFFB?=
 =?utf-8?B?ZncvYi9IY29tVkVkSzFxK0dtakd5Y2lPOFpkU1NxU3ZNd2pUUXlHT1RWekRp?=
 =?utf-8?B?Wk1SYmRBZUc3Ny93a1BSRHl5aGJ6aFo5QTJVc1p5Z3RKekZud2JmUThsVmVD?=
 =?utf-8?B?MU0zNlBFUUZvemhoOTlQU1NzdDBuenNVWVljbnFGM2d5UzhOZDdoRnNSOVNx?=
 =?utf-8?B?N3l0SUIvRTNWem1SZW91SnJqNmhCZUtTQmtpY3EvYmhjOTZUQnduS29JTnVP?=
 =?utf-8?B?ZDl4UjIxYmFqV2VURUJqc1RUbGxvMWdRc3lzd3Q3TVZPL0NxR1ZpNHRJSW9H?=
 =?utf-8?B?eC82S0I4UmR0ODJYUWZLV3VlcGhTYVRxbXJuMzAvQjMvWWM4SXJySWZYR2ZM?=
 =?utf-8?B?bmNOTEdhQ2J4bkJWK3pVdjJJYmVlZndHTW14WnE2U0JKRFFXSkczdkRuMkN5?=
 =?utf-8?B?TWdWZnliV205THBzSUtqWVVnZ1VuOGd4cGlZeXJVMnJwcEVsVlBZV01hMjRR?=
 =?utf-8?B?dmNoZ2NlOG43N0RHcytkdGE1clVjREZ1dWFWakxTbWJTUEhyVmFqUlFxb1dO?=
 =?utf-8?B?clkrWUpSSXhlYVdpdFc3SHNERnpsZHpNTHUvRFIvQVVlMm5oblJpRUs0ckVw?=
 =?utf-8?B?YmRETVdibDJLNnFjUWJtbmFRNXp0ZWpLMTlOQkErb0cxWFpFUjdJVXhqSHlX?=
 =?utf-8?B?VlBtcVZLN29rbmN2Q0dBZE5UeVZBV0Evd2lydWVGSnFKa1JKKzNkZy9OaUVR?=
 =?utf-8?B?bGsxbzdUaEpkWXdMazRhb2UwYVNGZEVkNUZTWXMycm9BSWV3aUo0MHlUMlJU?=
 =?utf-8?B?QVQzWlBJYytOVVJ1VmJ6bmdXSTUydmVhNEZsc2VoanNzb3NnQzNDV1NiQmlH?=
 =?utf-8?B?Zm81SGtic2I0bjFRbEZtcytpdUNVMklGWmFBdXRmTXJBNytxbGpFRFJJNzUw?=
 =?utf-8?B?c3NWTTFwZ3YyTkR0QnJ2OWxXNm9LbTVrSWVMZGVML1A3SHdyemJ0SXI2T1px?=
 =?utf-8?B?N1RPOU93QkEvOVFBNEZSOVRaUWl1WXZzVk9lVFdtTThQZ21YVmpRdFZsL3hq?=
 =?utf-8?B?cUNtMUVtaS9UbzNQWnpWZ0ZFNXdWQzJiazJQT0YzdnZLMFVYSmVhNkp4NDd0?=
 =?utf-8?B?WFlTTmEvWk9pY2xKajNMTzcwMDNObjQwZ1FjbVFCbU1CU2FBWllVWWhMOHpq?=
 =?utf-8?B?VVd6Vk5BVVppVExtQmhUazhncnBhQmFTVWpiMGlXUk5qQ3hPS2xOWDc3T0xj?=
 =?utf-8?B?NXB4VnFPdzBsQjU3eiszeDBha3prUS96YWlzT1Fjcy9hYkR3V1VzZmNmVnRQ?=
 =?utf-8?B?VXJyRjY4djl3WTB6VTg3VWIxcm9TUUk0WWt2aXg5Q1BJYWVzOC95c1R1NUxM?=
 =?utf-8?B?dUd6SGNwd3F2NExhYkEvSThvUjB4YWcrVjZTR0JHZHhoeDJDSVBtTHBwTVZD?=
 =?utf-8?B?R2RZRkFTZ1ZkVXRNdUE4ZEhhc2NjM2UyQXR5bS9JWG9ULzc3cGs0aG1lMWlx?=
 =?utf-8?B?N1BUZHJ5RE5hcXc3ZDdiVmM0d1BnaGhTbm83Zzd4bFZKUVZEV3hVd1pEeG9w?=
 =?utf-8?B?Sk10ZVluMEZJaW5kSFRLVG55N0J2azZIbFlJYm4rUUdscS9SYjRCc3djZkY0?=
 =?utf-8?B?bDQyUTYyamRuVVNMU1JBYlU4SkhsNGExeXNsL2k3NHhzdFZsalVWMWJYdlVw?=
 =?utf-8?B?eThDS1NibHE1RUs5U0FGdmtEY3g0ZzZCOEZ6MWEzRVAxdzdLOWdIeVNmMURa?=
 =?utf-8?B?RTZ4ZHpDdEgyQ3ZGWVhYNElBc05MQTg3bDVka3NIdGRIU2lodlJpa3NkMnFZ?=
 =?utf-8?B?d05xSzN2NWNNOUJsWlVnVkwrRllEYjVJdTkrSG5FS2dhYUlPUDBVOFBuVDdp?=
 =?utf-8?B?bm5zbUZ6VC9TeThxWEJSMS8yWXArYTJvTHpmMk9VRlMvWHB6WmVQSlVxRzBS?=
 =?utf-8?B?aHMwaWhJTDk0cytCbE1GeFl5UXF1N3ZOSTlDN1hCV0pVcEh6WUlFbGFjaEUx?=
 =?utf-8?B?MEtxQ1cyUmlHdUo0THlOU3VyOHc4cE41QitERG5iL29LcHV4dG1weXROLzY3?=
 =?utf-8?B?WHNFTUpLRXozU1kxQXd3M1JzOThlMDJhYUx1YjNHVmxxcStPcUkxUFJ0QUpL?=
 =?utf-8?B?ZURRMjk3d0pvejZ4R1AwTEJ5UDVHb1dFcGo4SWxqRU9DeVRvVkdMY3Q0Y21r?=
 =?utf-8?B?alNBb3I0YnROMDhUWEE1QUJFNHgvWEduRXkvSXpMVG14V2NxaHdJVXdVK1VP?=
 =?utf-8?B?VXhKTmlPUUFUWUpGOHQxYllRTXd6UFdwdnViSDcxUXFUT01uTHlvalFjTEZO?=
 =?utf-8?B?SlZ3ZVRDTzhEWXlyVi9PeTB4RFNIaCtPTnB5cko2MS8weFJubWVjTUIvOXhy?=
 =?utf-8?Q?3TAvdVI5zOxiFcGs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc4bebf-a905-42c9-d5dd-08da31f6d759
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 20:02:27.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuYsProqCOsVW6uio7YEHba7ok4tnQGiQvyv1/43SUClwO5VNyA0qWJjy4sMVYVr3yf6HzYxfFLTK6YpQMYlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2417
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_05:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090104
X-Proofpoint-ORIG-GUID: zB9RsKzbABfTNHYjPGkCKlhIWVAUY_TH
X-Proofpoint-GUID: zB9RsKzbABfTNHYjPGkCKlhIWVAUY_TH
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/9/22 01:46, Baolin Wang wrote:
> 
> 
> On 5/9/2022 1:46 PM, Christophe Leroy wrote:
>>
>>
>> Le 08/05/2022 à 15:09, Baolin Wang a écrit :
>>>
>>>
>>> On 5/8/2022 7:09 PM, Muchun Song wrote:
>>>> On Sun, May 08, 2022 at 05:36:39PM +0800, Baolin Wang wrote:
>>>>> It is incorrect to use ptep_clear_flush() to nuke a hugetlb page
>>>>> table when unmapping or migrating a hugetlb page, and will change
>>>>> to use huge_ptep_clear_flush() instead in the following patches.
>>>>>
>>>>> So this is a preparation patch, which changes the
>>>>> huge_ptep_clear_flush()
>>>>> to return the original pte to help to nuke a hugetlb page table.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>
>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>
>>> Thanks for reviewing.
>>>
>>>>
>>>> But one nit below:
>>>>
>>>> [...]
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 8605d7e..61a21af 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -5342,7 +5342,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct
>>>>> *mm, struct vm_area_struct *vma,
>>>>>            ClearHPageRestoreReserve(new_page);
>>>>>            /* Break COW or unshare */
>>>>> -        huge_ptep_clear_flush(vma, haddr, ptep);
>>>>> +        (void)huge_ptep_clear_flush(vma, haddr, ptep);
>>>>
>>>> Why add a "(void)" here? Is there any warning if no "(void)"?
>>>> IIUC, I think we can remove this, right?
>>>
>>> I did not meet any warning without the casting, but this is per Mike's
>>> comment[1] to make the code consistent with other functions casting to
>>> void type explicitly in hugetlb.c file.
>>>
>>> [1]
>>> https://lore.kernel.org/all/495c4ebe-a5b4-afb6-4cb0-956c1b18d0cc@oracle.com/
>>>
>>
>> As far as I understand, Mike said that you should be accompagnied with a
>> big fat comment explaining why we ignore the returned value from
>> huge_ptep_clear_flush(). >
>> By the way huge_ptep_clear_flush() is not declared 'must_check' so this
>> cast is just visual polution and should be removed.
>>
>> In the meantime the comment suggested by Mike should be added instead.
> Sorry for my misunderstanding. I just follow the explicit void casting like other places in hugetlb.c file. And I am not sure if it is useful adding some comments like below, since we did not need the original pte value in the COW case mapping with a new page, and the code is more readable already I think.
> 
> Mike, could you help to clarify what useful comments would you like? and remove the explicit void casting? Thanks.
> 

Sorry for the confusion.

In the original commit, it seemed odd to me that the signature of the
function was changing and there was not an associated change to the only
caller of the function.  I did suggest casting to void or adding a comment.
As Christophe mentions, the cast to void is not necessary.  In addition,
there really isn't a need for a comment as the calling code is not changed.

The original version of the commit without either is actually preferable.
The commit message does say this is a preparation patch and the return
value will be used in later patches.
Again, sorry for the confusion.
-- 
Mike Kravetz
