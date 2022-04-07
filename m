Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38174F82BA
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbiDGPZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344577AbiDGPZO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 11:25:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6419211B30;
        Thu,  7 Apr 2022 08:22:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237EOBAX000752;
        Thu, 7 Apr 2022 15:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=N5gAWY4UhOjwnu+SiY85+CfU9YFzGboX2RshOPJcgCo=;
 b=RV5lP7u+HLZ4oK+hTy00oeVHgmu2MjLR38zEZPomTow2tZDTcKNjeaf+V6fdzCAhAlDT
 pjtdgDIu+0h56R1lHKuCK9i0zzCffzkdVCCHWUN0smMXE09PygKEMieu5Ku0EX7ocrQM
 ZYFqqSju35iFv/bdiyAqGdTpXzRSByEq8Paz1YYbSP9kr5CgbMA9erb6Y3kAmShHDLst
 9qMFpufiNJlwU7RSgfU6sgGXAfcdHOiWJSebtLXLGFVj3GZwUV0pmZN/phSxX56yXfu9
 DkKtDlFjLxr5sEYz1k7xn9tdkvvV9PK6MjL3e2FfwTgBc6aNO20ifm3H/tDBvfMGbM2I mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sv82x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 15:22:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237FDsTS028996;
        Thu, 7 Apr 2022 15:22:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974e7cv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 15:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZX5pjPrCfOZTsNqkz0PP9qsIjfZDtq6WpjJxmMddyAthxo6rGG4CF2pygKQW25kJ/1MCmInf+olnfhc1WacmDppQt5ap7uG/Oief5yLuT07UdmJhHmH7UO3DdnoH3Iz1A01FSBtvS8IgwsIy2YmTXDBeSofng3V0HAIyDhpfFfUASOUS9XoINrJaonFb5JPYOVMjy2jy/VwgFAgSuIC2Zp69A9iqrjHCluIPei0FS3gPgBnO1Ho7heuJ2IXsNNvFoE3z93S/nWS3bOzqPB4BB68z8um5LRn0sPfU1tGVX9nbTfDt1m6+CnxaZi4Ja+rtPIqboqax87gieYb57QZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5gAWY4UhOjwnu+SiY85+CfU9YFzGboX2RshOPJcgCo=;
 b=S9Cqlmsl9fX3Q1VTzwLMzHfaNVczWy5YNhFqIbBKpNEOr+4t7mGo0DSopLaicDCRKbw/f9Vg6TAHS7PYODs1fEUImg8ssRIKdMsrzM7d/AwVq/UiyP4k3XOnMNFW6wpSJKXW/d0aCi7sQPRXmqQ7rAnz7TjoGhxXWYrZvq2Jz6Oet5DxCrMgjUVC/4YM+AEpROwQTqohBfeHUEej+s3opK/G5LSq6t3bSFKNRBndFAGk0v2ZkeSWNq6+Ix6oegqiQ7hpLisSlV1kalocimtEHQt/HCyekhUx1VawvLMOVolm6Xt/T/ceCzJIiZgByyIzmmc9FD0Mk9WZBDHs5UyHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5gAWY4UhOjwnu+SiY85+CfU9YFzGboX2RshOPJcgCo=;
 b=OyPXdRBMenIGHgDlucCmUvUEJziMfH7EQXko9u7NdSZJsVtM76XUFAQDDOWMNs/Q+8T8BRXg/nN5ScJWOYtiemZoBw/w3YlQ2XsVYpQ4cZniSuStjJtonkDmyloDan7f1kKGNdjZLFLLT79f0fFl9rbrN2Qi5frAnpgfCXBw1l8=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 15:22:19 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::5bd:482c:816a:d880]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::5bd:482c:816a:d880%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 15:22:19 +0000
Message-ID: <5ee768d3-6978-8c7d-1381-5f1a0a8c7471@oracle.com>
Date:   Thu, 7 Apr 2022 09:22:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-5-anshuman.khandual@arm.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20220407103251.1209606-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcafd7f1-169e-4b59-efd3-08da18aa67df
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB41505C83704B9ED6C8A44F0486E69@CH2PR10MB4150.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VQ9uLIkoplVcyWKICOkGA1OiKEVjtA1oans7pxYS3MS/7qP42KKejySGRDHvFuH18IwrRF9lNiqMIY7ssHpefIYbBQgWD6wtiQEN7MWIeIlTNrViOEm1/bgl2WCKLNv3J/F2Ju0tyJO6HyKm92VraEOZTylCjZ7YnK83QFXh9P5PAj0YKvUeMZ4XD94H3euR3HxACmRctHH+hYfx0z8ZBVxeWgCAZYFbGFHDHzX427DMNn0TcF8yUZUmbThFB3blSQ7VbULEvDrlqVrIflsrjHEE20k4arnJufPQ7NEIl8pmYz+6j8oAuDOMrrI2P/u39pBvKYA7CX7C3CTiVTdjIPKFfyYQ5KHzL1xtuxhBQahjdKMTQo63L60tRMcuoWdV4HUnTXk5wX6gk1tiaztoP7FF2D3+kXza878uuXe4L1pG7nSMy937YxcLXz0/UdhQXd4CGGoMwPqkUQ60vcY4awFlWV7hPBkb+AEsAaYx4BILVWuPulud9QdSn1S61pqjtsECDrggZfJQXzKlHBR6bfeAvZdrFWGA27HFvf1sYFd+rszc5i3hfTxfprJTczLttbB0t2Mxm4jkJKotmE4JQRMIDgw1yoz9lJdcAZrM9PYbMa3ESUUFqx2dgmtWW4L7apyFCbMRntNY9PMvyYhbiF2e6xkjSkbYF+YEMIgSWw4kXAcO1OUEh9vuqFTh0I7aYwXLcBjY+9JdauyMWgPuksx6y1i/bDXy/z/keE4sm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(83380400001)(31696002)(38100700002)(86362001)(66476007)(66556008)(8676002)(66946007)(4326008)(316002)(54906003)(31686004)(36756003)(7416002)(44832011)(8936002)(2906002)(53546011)(6512007)(6666004)(508600001)(6506007)(186003)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZHK1lscklYVTNTaTVIdXFmN2JzY3pLWEZJNzFxNkNYT2RtUDQ2cm1lWmg1?=
 =?utf-8?B?amt0dSt3dFljcEFxTXVLeTVYOE1lYXEvYmRXbFYzcUxZMURwTnBzSm9RQ005?=
 =?utf-8?B?ZmszaDlFSW9iOGt5WU5yT1BtYXpmd2o5WFp3TWdYS0w2QUY0UUVQRDdJK0lR?=
 =?utf-8?B?UkxZaHB0cWJ5M3J3eWpqUW1VbXB1V1NIZ085V2xDU0lMVmRmM1VxNnZRV0RC?=
 =?utf-8?B?SndpMTRlN0NwNS8wek5YeTVjUkFzNitQSnlya01lOEdieWN1bFlEdm5oNDFx?=
 =?utf-8?B?WGhVNzE5S0ZLUE9lSlRtZE5EZ2RLcGo0QXJxYnJCWGt4UmN4NDJPVHAvdld3?=
 =?utf-8?B?bU5DaUlidUQ2RzYrTndRWTRpZFZvMVhCWFBXZU4wN3FmZmQzbW9kcUhUUVNW?=
 =?utf-8?B?bFRCU09mWS9icnZzMWVKYk9GK0hJL0k2Tmd4NDh6UlpXZHJTeGswbmlxRGxB?=
 =?utf-8?B?dy93ZGhBdnVHcEcreFArY1NBZWFneWN6TmEwc2lydkJRSzBQM29QaFFicFJm?=
 =?utf-8?B?aTBwcUtSRmprcThabzFhZEZkdzJ5UnlLalEreDhtcDVaU1RzZ1QzWHdDVUV4?=
 =?utf-8?B?TjJrbldRU1p2YXVxWGVTaHpUSHlxN1ZrSCt5SWYwOCtOSGp6TTBYSWE0N3Z4?=
 =?utf-8?B?aFJYckZoYmpTY3VOa2hyWWxqbjlqSzFYMzFGazBReXR5T1ZvdWRaUnZpbmly?=
 =?utf-8?B?ME9WNXZoMnZqeDVodS93ZzJKV2lhNlV1dExMRUVkYllnT0lvWnJKc2doT3ZB?=
 =?utf-8?B?QTJ5SjY0dkJqMEVxSXlYUUpJUzJacUlNaHJVeXFWRE1UYTY4TmpsdGpVNzRa?=
 =?utf-8?B?dlEzQWx1ODBXWHkzeUlwdmM4WllZN1AxZXVEVWNLSFY5UGNrazVaSDNodWxE?=
 =?utf-8?B?NUxKZDRWVzRiUEpJcGNaWGozR1RjSFNJVlI5YzBUNWFqWkJrU25neTdHTzZH?=
 =?utf-8?B?a0xYMDJuazQ3Rk5GY3hwbnNoZVBPSXM0c3pqdWVjREVoc2IzMldGcm5xam9m?=
 =?utf-8?B?RXVHZjVyaWY3NE1pKzRIVnpmSHk4UkZuUnpRRVo0RU5keGIwVjdkdjZKRi9p?=
 =?utf-8?B?cHNvWW9tamJkeXVOWUpmL243b1ppSFFxb3M1eGtWTk9YV0wwNHJSVE9PR3h6?=
 =?utf-8?B?VWI5bWpwY3Qwakd1Tnk3b3JWd0xwQ2swbEFLUmZvZ0tkbVdvM2ZONzhKUDJl?=
 =?utf-8?B?UWwvTm1GcVFMVWlqampTb29DV3paTDMyQjMzK3NNcys2YWUvQ1NZUWVDZGFV?=
 =?utf-8?B?VHBITHltcE9DMk9KemcyVzdnbVBSc3VjM3dQdUpTRllycGVsUGh5VW1sV0Zu?=
 =?utf-8?B?bHBlTmJMQm5ya0QvdExCRkdHM0pwNE1rcDdoT0lsNTRHVFhmWnlVSDhERGc0?=
 =?utf-8?B?VjZxWDBqTThxaWFiREtibGNjY2VUN0w3UG5HSjg4cnZJSER3NzY5QzBDSm8v?=
 =?utf-8?B?bmZDZ0VuYXR4VFBaOFA5YW5zSVY2ck5xZ2tmQW5zMVdLUm03cjM5dEphTDhQ?=
 =?utf-8?B?K3E1NVY1WU1haS9ydnQ2MEJ5WTYrSHNqeXpvTWdKVUwzS0FLVk5pQUJFdDZm?=
 =?utf-8?B?MUV5dS85RDJZb0l5MUJ3NG04TTNyMCt4bHdhbUdha2pjWWt1NUJ1UHdYZ3F5?=
 =?utf-8?B?eCtqaUxxVHlnVDY2cW90S3djd29xQ2xDb01mRldXQlFQR3lGYnJna0xQY041?=
 =?utf-8?B?K2RlaDB0bWpWekJPQTBUdHZaUDVvR2FCSFBXQmh2NUp0TnBKYXVuRGdwbTdk?=
 =?utf-8?B?YlhuL1NYMkRuMWp6Q0RGeDVFekR6dGQybUFlTWllb1ZvU0haK3FHV0xjekRJ?=
 =?utf-8?B?UnVZNnZyalloMzBtbW9YNUViTW9BNU1MelV1Ni9LZStLOStvK3A3RGpkbG94?=
 =?utf-8?B?QXIwZnNVd202eUdJemNhLy80eFRPSk42dElmVDEvc25LQTBwb2dOaGUySEhG?=
 =?utf-8?B?Y2xGQkFQR242L3NpYlhKM0YzOERyQ3VLVUdhVTdPa2ZEdmNmdG5kL1JIZ0FJ?=
 =?utf-8?B?RlBGL2RRdVpKaGoyZEZLRVprL0l5SGhIUThlQ0R6c3J4bllHL0xRT1FkYS9x?=
 =?utf-8?B?QWhvQlhRYkRBdDdFWlZ2KzBQYTZEZEtIYjFxcXNqRllZY1A2MURKb3d3NlJw?=
 =?utf-8?B?RkdjMDZlQ3MwTkpaUWN1N2xGMHRkWFFjS0NlOGx2bWJDOGVnVU9veGQ2N0Rl?=
 =?utf-8?B?MGkvSjFCQVVONGd0UWhKTFRIY3hSWGxHZFFiR1h3TXhFMmpoWDZUZDlsTHlt?=
 =?utf-8?B?Sjd0VzhaM0lCU0RLZ1ArVFpodTVZc2xMakN4Qlo1TVJUcjNOWjZubFlBQ0pz?=
 =?utf-8?B?c1ZEVkpEcE5VS252RWFUWWFrNW4xN0ZyMXZKSVlpV2JOWGRnSkhQQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcafd7f1-169e-4b59-efd3-08da18aa67df
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 15:22:19.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcM1AXHOcE4RGTYM5WpKdb5HA5s6EFNYLbOvGvT1jkRRrkW869sAFmFNQMA7WCL9wTmCGOoF1yxdwB0n8PH+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: QSIDVnOo0dvePkCvvHplK2_HSjY3xLLK
X-Proofpoint-GUID: QSIDVnOo0dvePkCvvHplK2_HSjY3xLLK
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/7/22 04:32, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. It localizes arch_vm_get_page_prot()
> as sparc_vm_get_page_prot() and moves near vm_get_page_prot().
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/sparc/Kconfig            |  1 +
>   arch/sparc/include/asm/mman.h |  6 ------
>   arch/sparc/mm/init_64.c       | 13 +++++++++++++
>   3 files changed, 14 insertions(+), 6 deletions(-)
> 

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>


> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 9200bc04701c..85b573643af6 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -84,6 +84,7 @@ config SPARC64
>   	select PERF_USE_VMALLOC
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select HAVE_C_RECORDMCOUNT
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select ARCH_SUPPORTS_ATOMIC_RMW
>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index 274217e7ed70..af9c10c83dc5 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -46,12 +46,6 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
>   	}
>   }
>   
> -#define arch_vm_get_page_prot(vm_flags) sparc_vm_get_page_prot(vm_flags)
> -static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
> -{
> -	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
> -}
> -
>   #define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
>   static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>   {
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 8b1911591581..dcb17763c1f2 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -3184,3 +3184,16 @@ void copy_highpage(struct page *to, struct page *from)
>   	}
>   }
>   EXPORT_SYMBOL(copy_highpage);
> +
> +static pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
> +{
> +	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
> +}
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	return __pgprot(pgprot_val(protection_map[vm_flags &
> +			(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
> +			pgprot_val(sparc_vm_get_page_prot(vm_flags)));
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);

