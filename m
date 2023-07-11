Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182DD74E881
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 09:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGKH7P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGKH7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 03:59:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2BE42;
        Tue, 11 Jul 2023 00:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzyypnsdvNYIHA+4/rQcdQ21eQe/5HnzjNjZeOhCpj0nTBcG+LKsbbduMA37Tct8AtHc39Oo1oFKcLVQF7oMBEGl7CeBkT+XdWZfnt40AKro5TyUq3nmt/CyeQP7pMFd2Iam5uC93GtfLNtBxklVyzJ/SH+gD7sn9i4RHqJBR1OuKjrIb/Ld/pSeyAlSuCuvEJT1dYyurv6ZlYNJaJ+ltX+yBn0L1ivIRKIV2yt3YQfQ5nPDP1tCj624pK34fXzbwggnsuUo6DGvCXPko338sYI4wzf1SZNtOwbMroqeOQT9p2GjSHK5yVvb66Op//GRBtccFKNtDNth0RzEYkzMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wg27b6J64h/TEKFShBrZw1PAz6mjM40CQ+ihaIvGx4=;
 b=UPVLB9bcsJ+cwtLzM4C+7n43FPeqdQgUT0Xc3kOnXhJL/SnoRtk3vW5YUTxFx4LtSbmTX8AY4JRK2ZQnKULkuBdySU+2BmWf6dabsIhbKY5QijcxOHDqBR5Fh5MVVo2FKLahw4VvVW/m2kGeNhLut0pyZoRllnOCR3+eqz+I+xn19p6pjTzv5rHc7DKtsQgrwFXxF7rkF84rN1UUhnp7fi/T2elwpGy1PgkYiIakAZ7Nqxni8+CWXVFx2C8DNAU3gwtr7Nj6sEL6psTF19aUrGJgTmLsUE/fj54gYfZzLxEwJ/2jNRubAy0tCpNwnUhwGWbsSpMNKVF+V5q3j9qUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wg27b6J64h/TEKFShBrZw1PAz6mjM40CQ+ihaIvGx4=;
 b=VgrOKtnO494wEayw5wawu/6HbvONNcAe/2WYY9ivEKu2qwsSQmhFqhwV5wMkVNGRHggWAeR2Z6lZXJXfQMQlL9MDs57f1jDdnwt27f0+EqCr1UntgB2ts1FRtA9uVYI76W9gEilMHJLp30yxUjvk9M8XAMDrfRHAV0KHO3mjpcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 07:59:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 07:59:06 +0000
Message-ID: <f19a7b31-a87e-56d1-c084-2bdb3e1e5a2c@amd.com>
Date:   Tue, 11 Jul 2023 09:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 01/10] dma-buf: add support for paged attachment
 mappings
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
References: <20230710223304.1174642-1-almasrymina@google.com>
 <20230710223304.1174642-2-almasrymina@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230710223304.1174642-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: eba508c4-20a8-4593-56d8-08db81e4b2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSPpLLEkhUUyOomAgTrG9HhcqcaX/LZcgOZBTiahGP5hL0gT3CEayG7jvFLB9S50DBQbtWC4yzOVa/teiXm/S3qV1cyvllkuqqXu8Bxbe2mIZA71HGozjoQlpPOBEow8lCcmjatsAud7pVHo8aAqTj+sPVgDQBMVy7SpgZMBoWoNJ/9HrpYOh6D5gDbf+attD9mENFlno4Jv5MDSI5lIOTpWTG19+BMFl/VN0jp6Y3/jNjBr9GFyLesHtw4FIEQyQrLrzur5umNsOjLWUAZCargTIomqfKkWC+1WnhEpQvG3SOTrryQiQ8fVeechndDm/7cLBpCp6lB+PC9s5TUgCR/acQUyUjmjrCIhREKij8+uaQQj/uDcXc+RgdkvVvMp73WJaAWP67BxGwIL8ymAt3liXxDqLpyDSrFHvPIMG6XN0cp680J5cFrqRmbf+HyiOQrY3oW9b1JOS9oQK1/0Aw7BljHAZYmxxbBrwMH/KhrN73kiZf1IaAwXiioGW7eJGYZTVZhfB8Jt1Zft98GGJr5xUiM/1s/r8zMFk1Y/k4SV0JdfiSfKl9YU6G2M5jjUw6sBccMQAiZwN+LEiXfjFs7kroasqSlAbD+7HDhRyBg92jV+JFqCTFhkfp6JVxEvjDwfVY9K8O6VdetHIvIbIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(54906003)(6666004)(6486002)(478600001)(6506007)(186003)(6512007)(66946007)(2906002)(30864003)(41300700001)(66476007)(4326008)(316002)(5660300002)(7416002)(8936002)(66556008)(38100700002)(8676002)(36756003)(86362001)(31696002)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCsxQ2hHenh6VkE3SVV2TW0xVXZvL3dKMGZPYXFhNHArN1I1dU5JeTBXcW9u?=
 =?utf-8?B?SUdJL2hpdDh4T0VXdTBQOVhtZmw3bXBndXlzVGdYT1VaaTJRclV6Zk16RFQ2?=
 =?utf-8?B?ODM2cjRleVJzejFxRWRMbHlkYitLMmxzdU12YTV0V01hK1M4Tm5qQ2xiZkNs?=
 =?utf-8?B?aXhiaVFEanMrTG9EYk1yWWRFT1BqVmxpZW5GK1NTMGhUNDdvNHFVMVV2N1BH?=
 =?utf-8?B?NHZmeHVna3h6ZHl6RWw2eXhMOVczV0JLVStMemJadTZRN3pLNlBOcFNzMnJ3?=
 =?utf-8?B?K0lKanJaUTlJNUpoVXZlZWY0UjZNYXJ0Q3hpL2lHZGo1aTQ0OEkwZ3lMeTZE?=
 =?utf-8?B?d1JzWVZ5SHI4Tk0xS2tJNVRSOUw5M1dqTVBLcUFXOExSZUR6V3ZoTW1Bc2lu?=
 =?utf-8?B?dloya0FZRkZuY1Q0QmdCZWwzaEdKTERKSW04Z2ZHd25iUDNWRnRqWUE1Nmg4?=
 =?utf-8?B?dFpwU016bE9HV1p3WmtXU0VxZ3EvR1djYTJPZjNtREtZb2JyZkxMWmlhRTQz?=
 =?utf-8?B?UW0vcE5Ncy9HMVBieEZPcFN6Wnk5cFN6ejUzNVVwcHd4RVhHYkxickE1WlBI?=
 =?utf-8?B?eEhleHVyaHNTRys0b2pFQUt6ZHQ2d0JhYm82SmFFNzZnRitjaGJRa1hndS9m?=
 =?utf-8?B?aXdGbm1kNnJxTll4S3lOUC9nNUJOWElGSHdoRkhaSWxBQXlMRGR3SEozd0xT?=
 =?utf-8?B?TVNkeGY5dHo4UWdEOFY0SVBEVHpYRHFOVE5JdThmaCsrV3pWdTc3aUNGd0lP?=
 =?utf-8?B?QXBhUWt1b3RFVHVnb0tQQ1dCemNGVDNGcjN6WjB5OUU2L3NvR0pBL293VjVQ?=
 =?utf-8?B?WWhjSnNZSEdkVzZ2Ykw3RVVoa3pYaGtoeXMvNjAxejlTZXJxUEhpOXd3eTZU?=
 =?utf-8?B?cEhoeXE5VW1LYmUyZU9acEkwbWFOMDNMMzNBNk52S2Rxam5neXFnUWpTOGZ2?=
 =?utf-8?B?UmJUcTJZZEp1eGlJUGdKLytYNncwSmdPQ2lVMWZPcFg4VjVxZjdVUkdKenpZ?=
 =?utf-8?B?K3hnRUpZMmdoNUFnOHZxV25TVlBoM1ZCeUxJbHlNL2d5K08xYkFZY0Yrc28r?=
 =?utf-8?B?cGh2SjBlQTI0UitMYkplZU5TM1hzTll2QmsySUJiSTJuL1VSaS92YUNvWDJi?=
 =?utf-8?B?RmQ4Tjk4bER2a3FhU1dlcGp4S01aTUdjcU1WYjA0Z3FiaG5yTnk3VTA5SUZN?=
 =?utf-8?B?VlpLSEpWRVJFTVVSV3RYdHdBNXVFYUtvZURuUjUxL3pRdzNrdlc0U2tXNHl2?=
 =?utf-8?B?NElWeGlWR3ZhRkhWZ3lSZTF0WWROOXlnYjdaai83eEJsSzEyZXlUdzlIMjBP?=
 =?utf-8?B?bEdvR24rRXZSd1hSWmhNd09QY1Evc0NicHFsQXBKTVNma05uemV6MHg5c1py?=
 =?utf-8?B?M0dra3pIWUxwelNqTlZNUzhDSCtFUE1xQ09YWnhya1ppNWdnelUxcHNwLzRj?=
 =?utf-8?B?bnBZbi92TmhaSXUzT0M4aWdtelErdFRkakYzVGp5OWp1cWtUZzJnVnhvak1R?=
 =?utf-8?B?R0tENzNpTWNLTDBuRTVXTDRVbEJpRzM2T29OTEN4RzRJdktZNm5TTlpVd0tW?=
 =?utf-8?B?MUJ2TE0wTTZ2S0lYZ0d6LzdMYVZKQWtHK0xsMFpRS0d5SzBqTjdZRklaQ0ZH?=
 =?utf-8?B?a0hEL3Z0MS9vUjBxZkxQWmxhaTFmaVJwZVcwMXZQUmdLNkJlTWxhMDVON1Ex?=
 =?utf-8?B?WTFWNkZzVDhOdUtpclh4MlB2ODZpWkcrZW1hZmNyZHBXbDBTYjh0MTZZaHRB?=
 =?utf-8?B?UkpFVEo4ZXVUQklDcVlmamQzOGtTODFXcm9qejJTUHpST092S3lTS2lEeDd4?=
 =?utf-8?B?c0ZNbHZyLytvODFPVTBrYlh4TlY4YzFIemxudmpHT25QSmNwK2czUkNQRGhp?=
 =?utf-8?B?YktMYUE3QzY5Z3pVcWdNTEJMbFZjd3plL3I0MThzNFFEN0JLamU3Z0Rhamxx?=
 =?utf-8?B?ZDM0RVkwYzFJUDNvOXVGNVN0S0lvbml6YTgwdDd0ckx5UEpTY0JuaDNDOFNQ?=
 =?utf-8?B?dkhpTjEzTFdZTlplNHJ5WjdBeVlQd1ZUalB2T2QxOVEveWlUenBvUGRCM0Nh?=
 =?utf-8?B?eFY4c0tXY0VSMm43V0xJS1dFQkc1amk1MC9KTC9lRDZ0L1JFNXkxL0lRckpV?=
 =?utf-8?B?ODdEVVJuMXRRUDdoRGFMeE5LcDZrNGh5akovN1B3MjBWNjZiNHRBNzlDeVQ5?=
 =?utf-8?Q?t9HSMXGaEqaH3GUONv0iRDTOVCRnwAWw9Ra+9hkdYs5U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba508c4-20a8-4593-56d8-08db81e4b2f5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:59:05.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoxvibfVugHNGabVAZECMWG/+FvD1fbKVSV5Qn/HnuXLhTVQtQ08UU9qaywmYkIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 11.07.23 um 00:32 schrieb Mina Almasry:
> Currently dmabuf p2p memory doesn't present itself in the form of struct
> pages and the memory can't be easily used with code that expects memory
> in that form.

Well, this won't fly at all.

First of all DMA-buf is *not* about passing struct pages around, drivers 
are *only* supposed to use the DMA addresses.

That code can't use the pages inside a DMA-buf is absolutely 
intentional. We even mangle the page pointers from the sg_tables because 
people sometimes get the impression they can use those.

See function mangle_sg_table() in dma-buf.c

         /* To catch abuse of the underlying struct page by importers mix
          * up the bits, but take care to preserve the low SG_ bits to
          * not corrupt the sgt. The mixing is undone in __unmap_dma_buf
          * before passing the sgt back to the exporter. */
         for_each_sgtable_sg(sg_table, sg, i)
                 sg->page_link ^= ~0xffUL;

> Add support for paged attachment mappings. We use existing
> dmabuf APIs to create a mapped attachment (dma_buf_attach() &
> dma_buf_map_attachment()), and we create struct pages for this mapping.
> We write the dma_addr's from the sg_table into the created pages.

Hui, what? Not really.

Regards,
Christian.


>   These
> pages can then be passed into code that expects struct pages and can
> largely operate on these pages with minimal modifications:
>
> 1. The pages need not be dma mapped. The dma addr can be queried from
>     page->zone_device_data and used directly.
> 2. The pages are not kmappable.
>
> Add a new ioctl that enables the user to create a struct page backed
> dmabuf attachment mapping. This ioctl returns a new file descriptor
> which represents the dmabuf pages. The pages are freed when (a) the
> user closes the file, and (b) the struct pages backing the dmabuf are
> no longer in use. Once the pages are no longer in use, the mapped
> attachment is removed.
>
> The support added in this patch should be generic - the pages are created
> by the base code, but the user specifies the type of page to create using
> the dmabuf_create_pages_info->type flag. The base code hands of any
> handling specific to the use case of the ops of that page type.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   drivers/dma-buf/dma-buf.c    | 223 +++++++++++++++++++++++++++++++++++
>   include/linux/dma-buf.h      |  90 ++++++++++++++
>   include/uapi/linux/dma-buf.h |   9 ++
>   3 files changed, 322 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index aa4ea8530cb3..50b1d813cf5c 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -22,6 +22,7 @@
>   #include <linux/module.h>
>   #include <linux/seq_file.h>
>   #include <linux/sync_file.h>
> +#include <linux/pci.h>
>   #include <linux/poll.h>
>   #include <linux/dma-resv.h>
>   #include <linux/mm.h>
> @@ -442,12 +443,16 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
>   }
>   #endif
>   
> +static long dma_buf_create_pages(struct file *file,
> +				 struct dma_buf_create_pages_info *create_info);
> +
>   static long dma_buf_ioctl(struct file *file,
>   			  unsigned int cmd, unsigned long arg)
>   {
>   	struct dma_buf *dmabuf;
>   	struct dma_buf_sync sync;
>   	enum dma_data_direction direction;
> +	struct dma_buf_create_pages_info create_info;
>   	int ret;
>   
>   	dmabuf = file->private_data;
> @@ -484,6 +489,12 @@ static long dma_buf_ioctl(struct file *file,
>   	case DMA_BUF_SET_NAME_A:
>   	case DMA_BUF_SET_NAME_B:
>   		return dma_buf_set_name(dmabuf, (const char __user *)arg);
> +	case DMA_BUF_CREATE_PAGES:
> +		if (copy_from_user(&create_info, (void __user *)arg,
> +				   sizeof(create_info)))
> +			return -EFAULT;
> +
> +		return dma_buf_create_pages(file, &create_info);
>   
>   #if IS_ENABLED(CONFIG_SYNC_FILE)
>   	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
> @@ -1613,6 +1624,218 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)
>   }
>   EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
>   
> +static int dma_buf_pages_release(struct inode *inode, struct file *file)
> +{
> +	struct dma_buf_pages *priv = file->private_data;
> +
> +	if (priv->type_ops->dma_buf_pages_release)
> +		priv->type_ops->dma_buf_pages_release(priv, file);
> +
> +	percpu_ref_kill(&priv->pgmap.ref);
> +	/* Drop initial ref after percpu_ref_kill(). */
> +	percpu_ref_put(&priv->pgmap.ref);
> +
> +	return 0;
> +}
> +
> +static void dma_buf_page_free(struct page *page)
> +{
> +	struct dma_buf_pages *priv;
> +	struct dev_pagemap *pgmap;
> +
> +	pgmap = page->pgmap;
> +	priv = container_of(pgmap, struct dma_buf_pages, pgmap);
> +
> +	if (priv->type_ops->dma_buf_page_free)
> +		priv->type_ops->dma_buf_page_free(priv, page);
> +}
> +
> +const struct dev_pagemap_ops dma_buf_pgmap_ops = {
> +	.page_free	= dma_buf_page_free,
> +};
> +EXPORT_SYMBOL_GPL(dma_buf_pgmap_ops);
> +
> +const struct file_operations dma_buf_pages_fops = {
> +	.release	= dma_buf_pages_release,
> +};
> +EXPORT_SYMBOL_GPL(dma_buf_pages_fops);
> +
> +#ifdef CONFIG_ZONE_DEVICE
> +static void dma_buf_pages_destroy(struct percpu_ref *ref)
> +{
> +	struct dma_buf_pages *priv;
> +	struct dev_pagemap *pgmap;
> +
> +	pgmap = container_of(ref, struct dev_pagemap, ref);
> +	priv = container_of(pgmap, struct dma_buf_pages, pgmap);
> +
> +	if (priv->type_ops->dma_buf_pages_destroy)
> +		priv->type_ops->dma_buf_pages_destroy(priv);
> +
> +	kvfree(priv->pages);
> +	kfree(priv);
> +
> +	dma_buf_unmap_attachment(priv->attachment, priv->sgt, priv->direction);
> +	dma_buf_detach(priv->dmabuf, priv->attachment);
> +	dma_buf_put(priv->dmabuf);
> +	pci_dev_put(priv->pci_dev);
> +}
> +
> +static long dma_buf_create_pages(struct file *file,
> +				 struct dma_buf_create_pages_info *create_info)
> +{
> +	int err, fd, i, pg_idx;
> +	struct scatterlist *sg;
> +	struct dma_buf_pages *priv;
> +	struct file *new_file;
> +
> +	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> +	if (fd < 0) {
> +		err = fd;
> +		goto out_err;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		err = -ENOMEM;
> +		goto out_put_fd;
> +	}
> +
> +	priv->pgmap.type = MEMORY_DEVICE_PRIVATE;
> +	priv->pgmap.ops = &dma_buf_pgmap_ops;
> +	init_completion(&priv->pgmap.done);
> +
> +	/* This refcount is incremented every time a page in priv->pages is
> +	 * allocated, and decremented every time a page is freed. When
> +	 * it drops to 0, the dma_buf_pages can be destroyed. An initial ref is
> +	 * held and the dma_buf_pages is not destroyed until that is dropped.
> +	 */
> +	err = percpu_ref_init(&priv->pgmap.ref, dma_buf_pages_destroy, 0,
> +			      GFP_KERNEL);
> +	if (err)
> +		goto out_free_priv;
> +
> +	/* Initial ref to be dropped after percpu_ref_kill(). */
> +	percpu_ref_get(&priv->pgmap.ref);
> +
> +	priv->pci_dev = pci_get_domain_bus_and_slot(
> +		0, create_info->pci_bdf[0],
> +		PCI_DEVFN(create_info->pci_bdf[1], create_info->pci_bdf[2]));
> +	if (!priv->pci_dev) {
> +		err = -ENODEV;
> +		goto out_exit_percpu_ref;
> +	}
> +
> +	priv->dmabuf = dma_buf_get(create_info->dma_buf_fd);
> +	if (IS_ERR(priv->dmabuf)) {
> +		err = PTR_ERR(priv->dmabuf);
> +		goto out_put_pci_dev;
> +	}
> +
> +	if (priv->dmabuf->size % PAGE_SIZE != 0) {
> +		err = -EINVAL;
> +		goto out_put_dma_buf;
> +	}
> +
> +	priv->attachment = dma_buf_attach(priv->dmabuf, &priv->pci_dev->dev);
> +	if (IS_ERR(priv->attachment)) {
> +		err = PTR_ERR(priv->attachment);
> +		goto out_put_dma_buf;
> +	}
> +
> +	priv->num_pages = priv->dmabuf->size / PAGE_SIZE;
> +	priv->pages = kvmalloc_array(priv->num_pages, sizeof(struct page),
> +				     GFP_KERNEL);
> +	if (!priv->pages) {
> +		err = -ENOMEM;
> +		goto out_detach_dma_buf;
> +	}
> +
> +	for (i = 0; i < priv->num_pages; i++) {
> +		struct page *page = &priv->pages[i];
> +
> +		mm_zero_struct_page(page);
> +		set_page_zone(page, ZONE_DEVICE);
> +		set_page_count(page, 1);
> +		page->pgmap = &priv->pgmap;
> +	}
> +
> +	priv->direction = DMA_BIDIRECTIONAL;
> +	priv->sgt = dma_buf_map_attachment(priv->attachment, priv->direction);
> +	if (IS_ERR(priv->sgt)) {
> +		err = PTR_ERR(priv->sgt);
> +		goto out_free_pages;
> +	}
> +
> +	/* write each dma addresses from sgt to each page */
> +	pg_idx = 0;
> +	for_each_sgtable_dma_sg(priv->sgt, sg, i) {
> +		size_t len = sg_dma_len(sg);
> +		dma_addr_t dma_addr = sg_dma_address(sg);
> +
> +		BUG_ON(!PAGE_ALIGNED(len));
> +		while (len > 0) {
> +			priv->pages[pg_idx].zone_device_data = (void *)dma_addr;
> +			pg_idx++;
> +			dma_addr += PAGE_SIZE;
> +			len -= PAGE_SIZE;
> +		}
> +	}
> +
> +	new_file = anon_inode_getfile("[dma_buf_pages]", &dma_buf_pages_fops,
> +				      (void *)priv, O_RDWR | O_CLOEXEC);
> +	if (IS_ERR(new_file)) {
> +		err = PTR_ERR(new_file);
> +		goto out_unmap_dma_buf;
> +	}
> +
> +	priv->type = create_info->type;
> +	priv->create_flags = create_info->create_flags;
> +
> +	switch (priv->type) {
> +	default:
> +		err = -EINVAL;
> +		goto out_put_new_file;
> +	}
> +
> +	if (priv->type_ops->dma_buf_pages_init) {
> +		err = priv->type_ops->dma_buf_pages_init(priv, new_file);
> +		if (err)
> +			goto out_put_new_file;
> +	}
> +
> +	fd_install(fd, new_file);
> +	return fd;
> +
> +out_put_new_file:
> +	fput(new_file);
> +out_unmap_dma_buf:
> +	dma_buf_unmap_attachment(priv->attachment, priv->sgt, priv->direction);
> +out_free_pages:
> +	kvfree(priv->pages);
> +out_detach_dma_buf:
> +	dma_buf_detach(priv->dmabuf, priv->attachment);
> +out_put_dma_buf:
> +	dma_buf_put(priv->dmabuf);
> +out_put_pci_dev:
> +	pci_dev_put(priv->pci_dev);
> +out_exit_percpu_ref:
> +	percpu_ref_exit(&priv->pgmap.ref);
> +out_free_priv:
> +	kfree(priv);
> +out_put_fd:
> +	put_unused_fd(fd);
> +out_err:
> +	return err;
> +}
> +#else
> +static long dma_buf_create_pages(struct file *file,
> +				 struct dma_buf_create_pages_info *create_info)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int dma_buf_debug_show(struct seq_file *s, void *unused)
>   {
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 3f31baa3293f..5789006180ea 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -540,6 +540,36 @@ struct dma_buf_export_info {
>   	void *priv;
>   };
>   
> +struct dma_buf_pages;
> +
> +struct dma_buf_pages_type_ops {
> +	int (*dma_buf_pages_init)(struct dma_buf_pages *priv,
> +				  struct file *file);
> +	void (*dma_buf_pages_release)(struct dma_buf_pages *priv,
> +				      struct file *file);
> +	void (*dma_buf_pages_destroy)(struct dma_buf_pages *priv);
> +	void (*dma_buf_page_free)(struct dma_buf_pages *priv,
> +				  struct page *page);
> +};
> +
> +struct dma_buf_pages {
> +	/* fields for dmabuf */
> +	struct dma_buf *dmabuf;
> +	struct dma_buf_attachment *attachment;
> +	struct sg_table *sgt;
> +	struct pci_dev *pci_dev;
> +	enum dma_data_direction direction;
> +
> +	/* fields for dma-buf pages */
> +	size_t num_pages;
> +	struct page *pages;
> +	struct dev_pagemap pgmap;
> +
> +	unsigned int type;
> +	const struct dma_buf_pages_type_ops *type_ops;
> +	__u64 create_flags;
> +};
> +
>   /**
>    * DEFINE_DMA_BUF_EXPORT_INFO - helper macro for exporters
>    * @name: export-info name
> @@ -631,4 +661,64 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map);
>   void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
>   int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
>   void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
> +
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> +extern const struct file_operations dma_buf_pages_fops;
> +extern const struct dev_pagemap_ops dma_buf_pgmap_ops;
> +
> +static inline bool is_dma_buf_pages_file(struct file *file)
> +{
> +	return file->f_op == &dma_buf_pages_fops;
> +}
> +
> +static inline bool is_dma_buf_page(struct page *page)
> +{
> +	return (is_zone_device_page(page) && page->pgmap &&
> +		page->pgmap->ops == &dma_buf_pgmap_ops);
> +}
> +
> +static inline dma_addr_t dma_buf_page_to_dma_addr(struct page *page)
> +{
> +	return (dma_addr_t)page->zone_device_data;
> +}
> +
> +static inline int dma_buf_map_sg(struct device *dev, struct scatterlist *sg,
> +				 int nents, enum dma_data_direction dir)
> +{
> +	struct scatterlist *s;
> +	int i;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		struct page *pg = sg_page(s);
> +
> +		s->dma_address = dma_buf_page_to_dma_addr(pg);
> +		sg_dma_len(s) = s->length;
> +	}
> +
> +	return nents;
> +}
> +#else
> +static inline bool is_dma_buf_page(struct page *page)
> +{
> +	return false;
> +}
> +
> +static inline bool is_dma_buf_pages_file(struct file *file)
> +{
> +	return false;
> +}
> +
> +static inline dma_addr_t dma_buf_page_to_dma_addr(struct page *page)
> +{
> +	return 0;
> +}
> +
> +static inline int dma_buf_map_sg(struct device *dev, struct scatterlist *sg,
> +				 int nents, enum dma_data_direction dir)
> +{
> +	return 0;
> +}
> +#endif
> +
> +
>   #endif /* __DMA_BUF_H__ */
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index 5a6fda66d9ad..d0f63a2ab7e4 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -179,4 +179,13 @@ struct dma_buf_import_sync_file {
>   #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
>   #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
>   
> +struct dma_buf_create_pages_info {
> +	__u8 pci_bdf[3];
> +	__s32 dma_buf_fd;
> +	__u32 type;
> +	__u64 create_flags;
> +};
> +
> +#define DMA_BUF_CREATE_PAGES	_IOW(DMA_BUF_BASE, 4, struct dma_buf_create_pages_info)
> +
>   #endif

