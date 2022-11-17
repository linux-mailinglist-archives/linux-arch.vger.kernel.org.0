Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890F62D7A5
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 11:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiKQKA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 05:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQKAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 05:00:54 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE156442;
        Thu, 17 Nov 2022 02:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GueS9iEP9nq7xhndQyGWYdM9thMIqNfc8M+XHKkIw/nZKXEz5yscUEZeleAqdC0CKuBXNzOxhbyEFJGznhIcUNK105rYcrpMjUaJd1jsbBaSo65RBgdrq3VrzOTD1X7lqfW1pDFoNyAl9yBwWMYkLxwvDTN/aVbxrzDtfZJlT7JnxObEAF7FIZkJLilgcIGWRlfkL6txuWpE6J8pLRTKMWyf/KVKwQdZNf1TaJ8n6tUFEbgTbt0yinUwvykCzdCdQ93QQJbxHxiGe3euwXB46rO1CbiLSU+1J+JAAivHC5peYGFl/T5tG2ENsnKNPMGuYWIVpPguXdQsI5k5YAn3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIgBVY7AydegLb6VzfxR9witDc3d12cE/Wca7W4HPZw=;
 b=BxAtZpFL0en9fnVtaTf2omjMX95wMRmsMQVTq7/OrtGlE3+XtjL3I8ByynAmJXDhjRcT5/x3bQnTGNb+WwT5yFeLbbsLD54t4C9wUEUp1ryKWGrdtJ9bJtU0M2KFKoUxhKKomwTH+1hRs69LbRoTMUWv9NkU4vRjNch+wx5pRJDay9Kl4T7UVP6XiHG8a0zzA++rf2+XWLszTWmCqOcCN/vAzYmDSGa1Tya+EhuGRt2CgHJlfjrltvW5sOVMOTFauLby96gEOdkjIXqTu5jJ+QtU7nxTBkZgc6Qc2wmxqTM/EUIULHWeedf6dk0xoQThHoofqKPOMDnHlPpyfp/Ajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIgBVY7AydegLb6VzfxR9witDc3d12cE/Wca7W4HPZw=;
 b=RjB49+iYdpvShv6i7HR9xKWfWlMFfrMzOlsuFCuxrDzsyI091Cf9xcMLhH62iERkqL/JPg2kB27vpxjdY2Jo4rP3frXFmwFBXwl5Xstw+dEhbGovyk4HayLMzcUagn4oyUkpVNLiD0c+WOJgW4KTuRPWpiPqgUkcYiVXgn2jsjwUI+YqVFehV+Q3hz7whzmeJMgqD1douyIu1aOGtY2FdX8ZwSbyLF7DHBcXifSYNEk2GoIBN1+wgavBRRydpj9K//+D1FBkl58gGKMiz9UVnc9vsovbWjpN3Zd79R4QVzyrKkZHDtYyxmLNExQwhe2KQVMsWbh4aVcf8ZMulO0Prg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 10:00:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 10:00:51 +0000
Message-ID: <e98d2048-57ef-4515-8290-ddf6596856f7@nvidia.com>
Date:   Thu, 17 Nov 2022 10:00:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/15] kbuild: build init/built-in.a just once
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
 <20220828024003.28873-6-masahiroy@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220828024003.28873-6-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0580.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adc3cfd-7e43-46be-735e-08dac8829c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrQRQiJdPI7oL3pRniOsfb1SoQVofEtJdZzCcGPvKrcsQN++ZJpmqJIDMe+jgmieV4vPdbAEToAe1pg4u1eHlcZ8qMmcEhsAz2iUJ9uxTvXhmIfbZ1WbUOQS/+GdOHhl6J5I6AszLGqLFaSz8/Pep7JvUXDpaTwddfmr9/cygfyYa3dR9p4Xq738B/5eWXugKVFiFFOQfBV3/vZuSPJ0Xsjl75wSpoNtBNl9ch6jGQMK+E5Z/lNjq78cKn+591ZF0w3iAHUh9Kq6tCOA+4iLI5q3VT6+8nJ8NlZDU5CCjabXjvS5Q9p2hZ5Q4UXcHTuea5PWjJ5VhnFJAkDU75syi+7TlQqAVljlsK2nlEb1jKvushcCHuo4mK7/EsT+GN0ZWHQkT6TrUPpoUVQRNmGfmqLDMZRXkx3p5jXdZnd5ycdoxn4mjSKLCRcAoYP7h2UwelrwZtrPZK6AuejQAIzmQH84/Jy7QFnuT05AU3FqKY+ssAHV8xsbm8UrnRqrRluVCrirc05GTE7FSOOgEz7TLCIbwlFSPoXVbe0FFOzZRtG+hKAT6/twPGESpiyUdQjTuoiDvGJhnl9Z/71GBeet2alaFyABhueqz7AKrOFc8wYbNFlpPffQ8R8utqqT6jzoQMjKGO2xEeGWOOAuQgXNw+xgurUiWMY5unTNEkPJZ2VZSjsqgfTInVX/5rAdlnNB1A6AKNlxqqewyrRUhfmLt9vWatnPgi24Q5Dh4oBI0ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(31686004)(38100700002)(478600001)(6486002)(83380400001)(86362001)(31696002)(5660300002)(8936002)(36756003)(2906002)(8676002)(66476007)(66556008)(4326008)(66946007)(6506007)(55236004)(53546011)(6666004)(41300700001)(6512007)(186003)(26005)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkE4RUJtN1NCUnc4NkJyK3lyQXFGUUY5V29zdFVxVXVucUtqSERlVnIzanpa?=
 =?utf-8?B?OWRCd3JUc0g3R2MyV3pmcnp1R1ZXODd4VmlSL0V0TFUrNWNqUjUxMDRJQnZB?=
 =?utf-8?B?OHRuVjhFN0VJdVRLMmhDSWJnU3h2NHo5S1FySEdFUkhjeVlscWkrQTlRRmdj?=
 =?utf-8?B?N0c5d1l1QjZKVE1hd0JSSFc5ajgrVVhSL1I5NTg2SjlHUlByTWRZU2cwNFJC?=
 =?utf-8?B?L09IYTFNeVVsaDZMTWVlN1BwNVpCcUlxOE5OZGpBc2xibFljNDdyRXlaMFVN?=
 =?utf-8?B?c1hGd210WGpQcHFibjBneFNhS2Nud2tsbCs3ZG92TW0yWk9HOFpkWXlkN2M0?=
 =?utf-8?B?VnRzTUE4R0tpNjJpZWp6aXQyUXV3R2U1cWFFc0J2b09SY3FhWU40dmdPNG1w?=
 =?utf-8?B?UGRTeTYxaDY2bDVoV2tOZFlpQlhwbWMxZGEzM01wTUk5SmtGZExHRmVYU1Y4?=
 =?utf-8?B?cEhFRWFpL01kSGtLS3hKQXZhWG1BTzdMWms5Q09GOURmenNNeGg4TFIvRGlL?=
 =?utf-8?B?RU1sY05yRm0vNW8xVjNhd0pIa0pCTDcwSVJEb0ZWQzJtdGJhM0VSSVZuWlFM?=
 =?utf-8?B?WDZURVcvUm9Pak16VERlbi9RUUtKRWFtOUhBVE1hUjBaQm45RG41aVZqOG4z?=
 =?utf-8?B?SUtYV2tYd0NHblF2N3VVbStvYW9vSlI4VmFjaHk3UUxGNUFTVS9BcFZWSFZh?=
 =?utf-8?B?YXE5blpLSFBoUnF3emxIRS9BamFObXZyckszTmxtT29vbDFVMUxiZm54VGN1?=
 =?utf-8?B?T1F0V0ZBVFM2c1MxamFIYmg0blIwTlp3REg0dzJPcjR3alUvZXgzcGJVNi9Z?=
 =?utf-8?B?cFdWWlY1d2Q0TXZJVHhFd1psZmhSZG56OUhBZXdTZ0RTcmtLditLeVd4SkUv?=
 =?utf-8?B?T2NJbnRjc1o2WFNyZU9UZDZoREFaQk41eWh2S25aYjZrb3IrbzNKY0tITHFQ?=
 =?utf-8?B?TVJSUW1GOVgwV3NGZEV6U3N5bG1Pd2NHQi9VbDBWNldON0NKY2Nqc2s3bTRx?=
 =?utf-8?B?aEV4VStrQmJCUHhoOGpqTjFMMXBwWkkwQ3VPR005bDlEVVBFWWVLT2s2ajFp?=
 =?utf-8?B?S09aWVVYTEZlaG5CcVNJTTkyZGRRM0xOUnlqR0c1d0g3OGlnRFhqZmQyTTZV?=
 =?utf-8?B?Z1lxWHBvNEdjUndwRmw5RzY0WTBwMlJsbmErc3hLS2F6U25MQkp1TGRKRGNN?=
 =?utf-8?B?RHpXazFhTDlZRGl4aGZxSVJpV1hMNHNRMkhSb1BIWUNETDZiU3NsQ1h6aUd5?=
 =?utf-8?B?ZHhweHFadDlEcTk5eTVpai9xdU0wUjdNamdUbURXQUV5VXpNTkRTYUt0RlNz?=
 =?utf-8?B?UFdWWVZvS0hUUFl5cThKc3lsZEUxSnczZC9sblI1QUNYS1lCSkxVNUhQcGt3?=
 =?utf-8?B?ZWg3T00yREZwVFIwNWRwRkhEQjNUaHdGdEQ4RjFZQXdBSXZMcVJaVUdvOHZo?=
 =?utf-8?B?ekREeHIxVjlSWCtpVXJzd1R2UG42U1NUOWtNejlQcG1qYzVDU3IwMXZNM1ZO?=
 =?utf-8?B?Nk9KT3E5aWVOL3VzdStNUm5CWGpHcExibUFPS1dQS0NWd1R0VkpxRloxTUNt?=
 =?utf-8?B?WFVVczJ6cklhWkM0eExCQ3h1SnZDUHZ4ZkRDa3FwaW85SkgvdFdRWUZQUUp3?=
 =?utf-8?B?eU04bjhTRHpFRXFOa2R2UjhWeE1BU0JKUFlOUWdRMlJlYkkyaHRwcnBhNGJp?=
 =?utf-8?B?c2sxY0RTR0d4Q0F2dm90QzhUTmx4Mk8xOCtwV3RVa253M2UyVHpYWis2MGVs?=
 =?utf-8?B?SExQL1dDamZ5TGw1WFJkQkdOWmJmYmc4VFpLQUNGNjNPbXY2T2RkdnphNHlV?=
 =?utf-8?B?SXFWUTVmdU9aSytwdjVTRzRXY0p6NktWdkc3NzdDVmFlb2JIZnhhdjZibGJq?=
 =?utf-8?B?bEMwaDF1YW5zZmxoNG9OcGUxT3U2eWlrSW1qUUhCTFRFMHpVQkJITUI1M3kv?=
 =?utf-8?B?bXVJeWtWZ3pPRUZoYXZZWjQ3TGxJSFRuRUdHSE1DZkdnVmlvN2FVNzZHdmlC?=
 =?utf-8?B?dGRnQ3pqVUlucXRMa0xHRXREY290K21tR2dGL3RuMS9taE1CV3lKSWNZajJq?=
 =?utf-8?B?UmY2K01WNG5kc2t0YVRnQkJLa1J2YjZlUXJZWW1XZUY0dnhOaytKcUtUb3p1?=
 =?utf-8?B?S2p3U3Rjb2xLY2RQbWNQN21YN2s4NU9UR1BGdERoblhzUU9NWDJoL0V0NTg0?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adc3cfd-7e43-46be-735e-08dac8829c1f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 10:00:51.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiJpSDPu+K0s9+ZWhQoBhcLJrvZVShBmrdlyuasD4eVbJOT6vWxVIgjepFZCMqLaetJuHfq1Dq071ry0jfHxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro

On 28/08/2022 03:39, Masahiro Yamada wrote:
> Kbuild builds init/built-in.a twice; first during the ordinary
> directory descending, second from scripts/link-vmlinux.sh.
> 
> We do this because UTS_VERSION contains the build version and the
> timestamp. We cannot update it during the normal directory traversal
> since we do not yet know if we need to update vmlinux. UTS_VERSION is
> temporarily calculated, but omitted from the update check. Otherwise,
> vmlinux would be rebuilt every time.
> 
> When Kbuild results in running link-vmlinux.sh, it increments the
> version number in the .version file and takes the timestamp at that
> time to really fix UTS_VERSION.
> 
> However, updating the same file twice is a footgun. To avoid nasty
> timestamp issues, all build artifacts that depend on init/built-in.a
> must be atomically generated in link-vmlinux.sh, where some of them
> do not need rebuilding.
> 
> To fix this issue, this commit changes as follows:
> 
> [1] Split UTS_VERSION out to include/generated/utsversion.h from
>      include/generated/compile.h
> 
>      include/generated/utsversion.h is generated just before the
>      vmlinux link. It is generated under include/generated/ because
>      some decompressors (s390, x86) use UTS_VERSION.
> 
> [2] Split init_uts_ns and linux_banner out to init/version-timestamp.c
>      from init/version.c
> 
>      init_uts_ns and linux_banner contain UTS_VERSION. During the ordinary
>      directory descending, they are compiled with __weak and used to
>      determine if vmlinux needs relinking. Just before the vmlinux link,
>      they are compiled without __weak to embed the real version and
>      timestamp.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Since this change I have noticed that the kernel image (at least on ARM64) now contains two version strings ...

$ strings arch/arm64/boot/Image | grep "Linux version"
Linux version 6.0.0-rc7-00011-g2df8220cc511 (jonathanh@moonraker) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) # SMP PREEMPT
Linux version 6.0.0-rc7-00011-g2df8220cc511 (jonathanh@moonraker) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) #20 SMP PREEMPT Thu Nov 17 09:49:18 GMT 2022

Is this expected?

Thanks!
Jon

-- 
nvpublic
