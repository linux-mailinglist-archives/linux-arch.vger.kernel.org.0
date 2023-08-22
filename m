Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10318784A8E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjHVTh7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHVTh7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 15:37:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C75DB;
        Tue, 22 Aug 2023 12:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ntj7TOlhP/71zpNxlwAsC2wPisd2aVwHmgTsZrylBd3gGdD/Z0NFTdrO9sAQQVvjf7I5jKA2pRE71902Ctf8u4PNHaoByjmQyrKq1FhpZGVfc1elO2m+MAF1v87jSMj1OdxvkpFbPXGhsut8Y2AAdK69WKH6VXvuoHyTM8N2VCFcX3NYz/zSllCAKHk2/Kzs7o8jB7KiJfmMeZN9x7ZEFk3bu0UCgEeochidI7EdQf8FED5CouC586Fe5xPMbxGZE2hXwAMoGgeZb8r1ifvN3CXUy013yXxDd7KBz8mDLtv5US1wD2NO8bWBgqP/ohtQsBQZSpMi9ZFtrk1x0Qr2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2CQmxeF6WgC0hSnRi/4VUuvtoyUa0c99krdeD4025E=;
 b=EttsEh2tDttna3Q4eUnSqB0c5Ld7hUF3y0nxN26U7G7V18oVsJBL0qp14ad0EjyfCk9L14+Gna3CbG/uAWws1zlv7Ex276wP0qlBvG7oi3WFIeUoMncF4PH6pYSrDhbCFJgCa6Tbu9jXx1GIBeSBrmcGrf3I3CotQDu+eNjzpL6chs3Ckj18aFOLzhG/8utJyzeipVe/2Z34c2bvmzASHl8+yTA93nYFl0oUBPwzKXhZHavB7xn518PyUjSHnylnMS98WwVV3oGfpLH8JY+Xr/O5ndWWOpqZMIqEkLsJ/HlQ8y7QiMU3vQQSW9RDhX9i3OXtCagr3HZJK//4PoHICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2CQmxeF6WgC0hSnRi/4VUuvtoyUa0c99krdeD4025E=;
 b=DLQpV3Rijs/zw3GvSWDTEgECqnjhIRw9Iwd1u7ipqwGVopCcXAGSKdN6M9B/poT48Zd8cGvO5GBJSfhKI7OryjNBKq44aOEkseZ8OMKLGdW1fJWRGw41vWAtPMLqM9K6qw18SdX2X3ciB6RguZPCcQTDTnu+Bm3vBF5m+zezxI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 19:37:51 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 19:37:51 +0000
Message-ID: <b4979997-23b9-0c43-574e-e4a3506500ff@amd.com>
Date:   Tue, 22 Aug 2023 14:37:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/8] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
To:     Wei Liu <wei.liu@kernel.org>, Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
References: <20230818102919.1318039-1-ltykernel@gmail.com>
 <ZOQMiLEdPsD+pF8q@liuwe-devbox-debian-v2>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZOQMiLEdPsD+pF8q@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0172.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: b36e66f5-cf9e-4a6b-bf53-08dba3474606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBKfrTKdu7Vh2wIGNyByPBUj/JCd1LFJPcAv2/WtfXWuN03K9e9G4pxZt/173/W6uuOLMjusRSReMcJNSg+mdVeTzs3rfvn2+0+PTI20cRNnFYJM2DrEKxRSZ7EL6F0WeiZCfrsj3SOt3eiiET11I867p7csiRpMx6A8QlCXYRlCH/mNzmwxmpWaEVjKr87NCZ4WuA+wIY8Y6p/pgnapXF1AcTwY+QSm8qlCWdvR5UTeYn7oCOf9GLovG6e1paexcwDoU+IE7AgAoRuhx2FbIRcP4ZvW44Fidtb/sjEGNkHw29/mVa//jrEGGcrZNvcRJ/Z5hQUrA8wwGwElLZ0zm16YWOht7m5Pm6aY/mnR7O6Q8r8ME6LPC70ecr/fkbzgzfXLSKipehLV/aqQni+Prtm/QJoFa+paIGHFMh/xWGMKuL3W8K1JuZKYY4Ptk7QOcYPXi0/7Y44qIjCwuHvWwNFbgZt/GV4RwKe3SEJqui2blK2a1Ij2+UKchILvY+8+u8AM7Hl+OT/S3HHm4eZCeJbTf82ghOicAy2PCsKxCa0t1RRjb0xA9+EJ8C1ZhxSTlGsB2z4ls+9A9491Q16I5HwbqPffqvVOd69velO7TkgIOAtEn7qAwrlGcPQg5YeKe+ynHE0oy24gdqakH5akIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(6666004)(53546011)(6486002)(6506007)(2616005)(6512007)(66946007)(7416002)(5660300002)(31696002)(86362001)(2906002)(4326008)(38100700002)(110136005)(8936002)(8676002)(36756003)(41300700001)(66476007)(316002)(66556008)(45080400002)(478600001)(83380400001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZaL3pRNGtzMThabkJaekV4Y2txMUs2N1JmUy9sU3pWNFhxUkZHT1VVU0Ra?=
 =?utf-8?B?bEFqRnpwZWhRSVFRL3k0WWFhbTRwamNDdnN0eFMwSVlyckNPbzBFcXp1elE1?=
 =?utf-8?B?MmRhRXpuTVdOYllSK2pHOEE5bk5qaWVHQ0VOOVA3UXh5MGhndUJ4K2M4b0V1?=
 =?utf-8?B?STBSdXMvbWxidUVZZEFjbExGTTIvcnE5TEZsazN4V1FpNUJ4TVBad1RmcTZC?=
 =?utf-8?B?cWtYYmZsclFxeEwrazBUZDNKS29lZ01oT3dVZWMzOFdyWDJIdmdXNm0zMWN0?=
 =?utf-8?B?eldUL0Z3eHJjNTlMejVEWVo0eDl0SThUUzk1ZThVUG1XZ29YanMzbWRNZFdt?=
 =?utf-8?B?czEzaWRBTUtDRTV3MDFSN01CZVpvYnozbkdjbmlaZEVqd3I5Z1JMM2svYTNk?=
 =?utf-8?B?c0NVaFNaanJKMHJZYWtTbzlUZVJFVVRSSDRaZWpOU29rVUxZOVBoMkVueUNS?=
 =?utf-8?B?UkFwVTVVallLQ05Dck5zZHRzVW9jb1Npc25YTGxzejBaOTV5VThnNEVFZHFK?=
 =?utf-8?B?d2d4Zys3LzlVK1V2bmg5T1A2UHc0WjNTTUFlNjRuSlVnYi9IVzJKY0J0bThq?=
 =?utf-8?B?ODc3cE1NVkZEeS9OSkJWSnUxM2x1UVV4L0JjSDZPWXdOODRYc0NCUGpqTHhK?=
 =?utf-8?B?ZmMxd3l0ZDY3QmxSTmpTQ3V1SmpSb0M1QWR5aTdiSUdsSDBPNjBrcUJJOHJi?=
 =?utf-8?B?YU45RkJ5WlFPZjdmaXA5RDM2bGtlY0xQY2pVNlVwdkk4VmVTSm52dG92WDZ0?=
 =?utf-8?B?NlREOUFwbDAza21WY3dqTG9kLzJoZXRWN1VjYlhkVVVxSTBsQ0J4L0czdTNG?=
 =?utf-8?B?bU5PbHZqVnJCR2tEajI5U1JnaWdKUkNIbW11Y0Y0ZXJQY0NrR0pWN2N4c3F1?=
 =?utf-8?B?QVc3blV1bUY4dHlMY2FOc1hVUGUwV1JrU0xFRXRybkZLYVJ1ZUxxWHZ2RExy?=
 =?utf-8?B?MWc2dkJXdjVYRGxoNXJUellPNllzMWcrRjFldDdPSVI5d1ZOd1kxZjdQU3Ix?=
 =?utf-8?B?M29LMUZaVDFlL3N1QjJLNFZ2QkZBMU11UDMvV3JvMkdvOFI5aWxNSm1aWHZh?=
 =?utf-8?B?Nk0xMEtkeGNVaEhaTEg0TDdDMVNmVi9DOXNlVmNXN1RTWjFsMEhVVElSOHBo?=
 =?utf-8?B?WEZ4YmdMQTh5RDQwZy9Edzlwd2JvR3VrVTZPYTJhdTdFdWttQVhCTTVEUGN0?=
 =?utf-8?B?ZlplMTVFdWZLWUV4TEVrMHVuSU5UNS9MY21ZSEk1UVBRdm5sNmw3anpPMHB6?=
 =?utf-8?B?M28wd1hVQkxDYlpOSGdsZnptVGxIMnVPL1p2cTVNMVQyZ1grcFV5SUdjeDhC?=
 =?utf-8?B?dVJzcytZNVU4bTArNnpiOUZreGEyaitEdXQ3UXlRK1hLT1UrcUtrak9qYWlP?=
 =?utf-8?B?bUE3UmhtcGM5N0haMHNiQzltRU5LdHRyajRJdGE5V0FmalhKZFQ2T2x0amhj?=
 =?utf-8?B?Qlh5RkZSVnJJdmxTWE9pWmdsVzFEa2hOejlGTStRQkw2OTRQWStXMWQwd1pP?=
 =?utf-8?B?a2ZXVW8xTXZLL3JJTU9IVy85Z3hDTlRHZmYvSWtwam1uUGZMOVUzdE9Tb29v?=
 =?utf-8?B?alRHQi9RbGFKYzdUMEQvYTkzdnhxY0NGejJmMjJSQVhIRStsOWs5bmY4clpV?=
 =?utf-8?B?SHp1ME43cFdMRkc3OXVaYmJiWXQ1L2swTmxON0dobEJuV21aMmxhZ0dFTGly?=
 =?utf-8?B?T0JMUmlOZFk3TkduVTJXc2ZYL0thbitwQndtcVNYbDVjMUZzNm9OWDRIMXow?=
 =?utf-8?B?dEdKUDR6WUJjMTVyZjE2TkxNZElmUzh0VTE5anBKVFozcEN0Ym9PM203MmlX?=
 =?utf-8?B?RXNCeEU3RVNxOWRCNUpDcCtkbHhLUW9zQ1RKVXBCYytYZlN1eWZuNThnQlRD?=
 =?utf-8?B?TWxLSWtDaFQ1SDVFUyt2eldRNi9SM1kzR3dET2Y3RFhQWGlXR1NtcnVIZmxs?=
 =?utf-8?B?Wnp2U2t6b1hBc2twNk9sWm5vR0NLSUlQZWE0bGN4RFFMT2xzMERGY3FxRFgv?=
 =?utf-8?B?TWRjMGtuV0hMREs2aHpacUI2bzZYWkdIVlJBUG05OUpsQmFKZXJLVzA1cm1F?=
 =?utf-8?B?YkYxanVRQXZXZ1dPUEhFRllLYXRNZnRBZmVYeHlmL21OM3ZlNUZ5YWxBbTdV?=
 =?utf-8?Q?qFmV9J6+E1aMy+floKKVHOcSr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36e66f5-cf9e-4a6b-bf53-08dba3474606
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 19:37:51.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u01zuaFCEMtQESsCiCkMatdfnd8WTqBs9Lvo1Iqkxkw7UwhFzELEiHHpzL0H15jy3sVCv6xR1xsJQEbLfea0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/21/23 20:16, Wei Liu wrote:
> On Fri, Aug 18, 2023 at 06:29:10AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <tiala@microsoft.com>
>>
>> Tianyu Lan (8):
>>    x86/hyperv: Add sev-snp enlightened guest static key
>>    x86/hyperv: Set Virtual Trust Level in VMBus init message
>>    x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
>>      enlightened guest
>>    drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP
>>      enlightened guest
>>    x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
>>      enlightened guest
>>    clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
>>      enlightened guest
>>    x86/hyperv: Add smp support for SEV-SNP guest
>>    x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
> 
> Applied to hyperv-next. Thanks.

Just found that this series fails to build if CONFIG_HYPERV is not set:

ld: arch/x86/kernel/cpu/mshyperv.o: in function `ms_hyperv_init_platform':
/root/kernels/linux-next-build-x86_64/arch/x86/kernel/cpu/mshyperv.c:417: undefined reference to `isolation_type_en_snp'
make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
make[1]: *** [/root/kernels/linux-next-build-x86_64/Makefile:1166: vmlinux] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:234: __sub-make] Error 2

Thanks,
Tom
