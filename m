Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14174EDD5
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGKMNv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 08:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGKMNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 08:13:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93838E67;
        Tue, 11 Jul 2023 05:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVfRPQ1/U7KTqev2eM4uHlwDb4w3VdWilj+zBzDSreLKTYp11btWZ4vtZ3Sg4S0h6MJIMKeTTp++bh5ueAuyJWFuo5ofDl2bhLm8eq+nOu/qYR34sxKAnmsAgT3muItnIDZQoPRo6VlL+NEHmWgUluPhj9Btg0ibAINZDTkWgOVEsebqL8QMb4hcAzJCZNCsoQ4cchQGT352REOCr/ix3fEvRNAwJ//6NlWH7au0NKfPEQZZYl+pcV2GCMws+OuV4KrbrCsuyuZbaUSRwwVuE1VMg3JI3gwrZf9kmp0mFskiWuZ3H8LMc77de3EvIR7V00d23Ye+gBkDndpU01ETKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx0ea0RytZlWXnXrn4HhqvdqYsyjPmlEsIuWYV2CJQo=;
 b=DcAEJDasIFfbJTXKkWSnW3oYXICJVa+cp7gNxOLYADxTepWXLRZJZ92m+DoxiR26bjH9pcpo1aeRwuXOxFOsPXaz3e+MZvfHDE7HupUA49I5t2ziMIQVICmXL8doQB0UG3hU2w1xxewQoDTvjUl7dT7Mv5QLF/5CCWSicHUXGxKFpafxwkmV3Bm+l00qy2lkC504TcVMQ86G7TJSOcigs0ZeHs8FXS5UKUf48H8tJ8/4G2xW+XTXILX88BNC4DQK3Kw2UHZ6jwrp+ZXsj9UkTzByVgUo9WyTHRe5aqbKgCsfECYr/fqChPHYIdRv+uN+NqaUSaxFB3r5urd4bXpBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx0ea0RytZlWXnXrn4HhqvdqYsyjPmlEsIuWYV2CJQo=;
 b=tNCAmT6Cof+PHN7YCHgH8rvmixSDiUNYTUPut+z4IRU86DgVlnZHEtVth9+nfmzDMUNcftXlKIEo6GJhhERFQ5iEctDg2d5sU6kfLRoWQmm+RusGxIIwLBlhCGazwLS0xnBvdjer1gLZYVyWDFTSDUFOEzdvs5/oE/ETBqIHGag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 12:13:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 12:13:43 +0000
Message-ID: <8719bf65-6906-0426-1ce4-b08970727a08@amd.com>
Date:   Tue, 11 Jul 2023 14:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 01/10] dma-buf: add support for paged attachment
 mappings
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
 <f19a7b31-a87e-56d1-c084-2bdb3e1e5a2c@amd.com>
 <CAHS8izNRfcdQOUyOtprxtwo_XE2piw6X_ALsb+REJrHB_t8KXg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHS8izNRfcdQOUyOtprxtwo_XE2piw6X_ALsb+REJrHB_t8KXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 170e8048-adf3-473b-1cac-08db8208449b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdjD+x3fOLpgeFu2ukzOFhCKEV/Jj2PkFBmlqPVjOHBlklgg2/eZ/EYu+JCTreVfOYiw0h+oEjOjUq27FGIi3rTClimKmI1i1FMTsU+tMqvh+Yx0+fICpVRrDr5WNSnAWOcH10oHV4ZnxNYZev1M7MdDeAtbAMWplJ3/0qOqx45UYmZBGRqdtA9UD6Vd7KXMtbOOvp2FQH17q5wlLqB8RXcOGWwtsACTvHyVTPVWr8SznI7knYn9s5CXIV3duLCKsJtcthSYbvcwsDwxwQucEXk1FxKVGZWtRTQ2qKWNjtdQeRFNZHMCHQHBgesQQnOFpOPRkptCmVNkpKkiVMG/rtjAvXm4Fpq2Rfl3p16Mx1sWQqgPrnK7BYY1iJ4FGcxsotVEsyvu05hEjsXsGNNhILwSZvrpS3owMcirPxD5Zgy7L5d8mgsZjxz15jiEv4+YQ6nHky1qab6i3qYpm1uMz05QHxl+JKa5vqT/AXKEFiOUbWe2DBlRLhoXxuNgjN9Pt7VA5Z95Zp5fksN/wgvtp7onqnad5NcIu5nuxt9KmjOjZPYWFjQxwQwB61w34P6QM1iojiqCwPDanmpcO7+gUpotUF+QdM5xZCmOmiK2o2b7C4OyaOjUJUq1P8cU/jtCYxULvz1/W8WTs17lCLH7Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(6512007)(966005)(38100700002)(66574015)(53546011)(83380400001)(186003)(2616005)(6506007)(2906002)(30864003)(7416002)(5660300002)(8936002)(8676002)(36756003)(66556008)(6666004)(6486002)(478600001)(66476007)(4326008)(66946007)(54906003)(110136005)(316002)(31696002)(86362001)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNxMjlneW12NnZpd0JwckZrSFc2RnVMODMwcmtrenJDYnp2L0ZVaDFKM1Rx?=
 =?utf-8?B?amg0QnVPV1NqUWxYOEZGUVAxUzVsSjVLeVBtK1QwSTl3aWlIN0VmNHFBNzJq?=
 =?utf-8?B?RTMwa1ZpN2NHUmpDLzdmQnVTK1d3ZTdtQzJZMFU5RFpOTmJEVXhvb2QyMzkx?=
 =?utf-8?B?RHVaV3pmdGVvbGNBTzNtYk1wRlJIYlc2S1JlLzgvUmxrNmlqSDdFc1k5d2tN?=
 =?utf-8?B?aXMrWjZNSGNHMjFuTHFKaVJ5YWEwUlc3aVIxdnBWYVZFSHArbnBSaEFxNnIw?=
 =?utf-8?B?MTRYaVF4eUlBR2NEZkx1K3JuaTJHQTlGRUlSUHhhV3IwRTQ4YS9CamxxMVE0?=
 =?utf-8?B?TlNJSWpXMDE1c2JDNksyNHRxbXNJbnRwdUNsQW1SMjJkY2FZTjNLdjUwMCtP?=
 =?utf-8?B?emtndlR0Nzc1UjlDQ0ZoM3RDOXpoRnJDMFBLdU1iUDVnaUJNWUg0TTZwditp?=
 =?utf-8?B?OTNjdnFreFJoK3FjbUZPWnVBRURIdmRLZVZDQkR4dVVOZHVUQThhMUc2aGlG?=
 =?utf-8?B?ZTYwZVdZUE9kdWpmNW0rWkF4cDhyM09KVnlBY0c4Um00dEZZeDczZEdKOUN4?=
 =?utf-8?B?bmFuWlJGNEpDU2tRUXY0VzAzMzl1RGVFazBjaGg5Qlp6aktWL0hEZGJDU1lr?=
 =?utf-8?B?VDhVYmFpVDRNUXA3LzdUSzdpNlFIQ0RiNldYMjZ5bWtUeVB6czREV0FBcU9U?=
 =?utf-8?B?ZXV1QzNscXRVQlpQeTViQXBvbjdOYXZ6SDVJa0ltb1RLbUgyU2h6TlBPR09v?=
 =?utf-8?B?VFhPNk1xbnBMVXlpcjZJdWVnWjM0RHAvSmNIa0k0VWF0NStqbWhDVUNsL3g2?=
 =?utf-8?B?akg5Z0ozZVNjYUVEMXF1eU84cWR3WXRNcXFnQ1dkcVlpRnZ1S081VlB0ck42?=
 =?utf-8?B?bndEMXpBemhpV0N1dzdLOVpIWGpHMENjODRJV2JncS9PUVhpT1BPYzI2VFB5?=
 =?utf-8?B?NXhUY21tTWtNZXdYanVaK1RyVU9QcU53Rk1tMzdHWlhWYmwwVFdOWm10SlRI?=
 =?utf-8?B?R0U1QnZiVlZ1cEQ4YmUreTVZcHlMYityYnNJNzVrK2R6THBTei9KbDRka2JI?=
 =?utf-8?B?Z2UxaGRTWlo1MG15RXNZSVlKWld2SVgwMWpqK3ZaakV5OXJYbWtadDVTbDZm?=
 =?utf-8?B?UVBndVdGKzNVcVpPbTVVaGJuNmhyMndMRUh1S0tjbGMybmV4SW55T2pZazZ0?=
 =?utf-8?B?STlkWnhmZGdSU2JBeFJSOUFaSWEwREFFdUg3ZitWZDJFVXF4bm02eXErSnJN?=
 =?utf-8?B?NS93V3VyNXorb2ljQ2hBN2hudko0aUQ5c0EzRm1sWk5GS1ZCYi83b0ZnMGc4?=
 =?utf-8?B?bzdtdWZJNFZ6K2RCQnd2cURZQU1pcVhFaEV4c1YrSWhHMUttdUlzUms1Q2Mx?=
 =?utf-8?B?UWNvcUhwMTBlQmgyeVZpZzl0eFh0UE05TlVIanc1aVZ5UWhacFZaalo1bHdy?=
 =?utf-8?B?OFoxMVMwdGY2bDduU0dpVlZSRnJOcVRTVGNlRklBcDJ0Nk1FMWI0aUZqWXFT?=
 =?utf-8?B?WHJEL096S1lkOVVqQXI4aDJkZUFoYkxPRU1XaEM4eHVac0NKZzE2aDgyMjJS?=
 =?utf-8?B?QkVRLzhhWjJKRzBvT0JSRDBBL0F3MlRLdk9DV1c4ZTcxY3c1M1UwcmRnTFVU?=
 =?utf-8?B?V2s2SHAyaFBqTXJESHRmbldMNHZCOHJzN3czaWhpVE9oazlLTHdEWjlDWFhx?=
 =?utf-8?B?ZFRjTFhJVWpGbzRVdEs1dWRUTFBKV1R4bFl1ck5kVk1LVFRkclZCMUhIN3hl?=
 =?utf-8?B?T3FtcUVpcmJlUUlNQkhuaTgwckF3cFZkWmpTWHllOWtqWmtLUExKdzUwTm5E?=
 =?utf-8?B?S05WRTBHd3FjS2FGYWo1aVQ3ZzVCcTYzdk1zckExek81TVZtNSs2NkNKL2tr?=
 =?utf-8?B?amlmUmFjakhTY0RuSEVEWnQ1TUVGSm1lM0QxK1RZTGtRaHAvZUk2azF1NnVZ?=
 =?utf-8?B?THpuTURVVXI5eFJIaUhQdUtFS01VbEYvem5ISkN5bHhFRTZQSTRGTWxaajlD?=
 =?utf-8?B?Vm5INEpVMlhRVUcwYTk3YTBxVjlBRm1VSjlFeGhhQk0zOFZqdnlGNHppaWRB?=
 =?utf-8?B?bERsYUw4eGJPbTVRVjAyZ2FQM2s1RTMrdHNzbTllVDlZU0dvckcyRmNXRDFi?=
 =?utf-8?B?dlpQM1JtakpISFV3OEVaenJUSUFKU1FiR3FaTmVRQzlXVGo1bmc5SXZ3MTMy?=
 =?utf-8?Q?uGcvEichYRfiVPNyKTo3LJqyTHt9K8CpD5BQ2bqdUft2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170e8048-adf3-473b-1cac-08db8208449b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:13:42.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZorVYD5lP/Vl7vSJEwjJJKGQW5ztR/ytsKKggR9JNdk9wE9xdwYvJfuhsRM1jhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

Hi Mina,

Am 11.07.23 um 13:44 schrieb Mina Almasry:
> On Tue, Jul 11, 2023 at 12:59 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 11.07.23 um 00:32 schrieb Mina Almasry:
>>> Currently dmabuf p2p memory doesn't present itself in the form of struct
>>> pages and the memory can't be easily used with code that expects memory
>>> in that form.
>> Well, this won't fly at all.
>>
>> First of all DMA-buf is *not* about passing struct pages around, drivers
>> are *only* supposed to use the DMA addresses.
>>
>> That code can't use the pages inside a DMA-buf is absolutely
>> intentional. We even mangle the page pointers from the sg_tables because
>> people sometimes get the impression they can use those.
>>
>> See function mangle_sg_table() in dma-buf.c
>>
>>           /* To catch abuse of the underlying struct page by importers mix
>>            * up the bits, but take care to preserve the low SG_ bits to
>>            * not corrupt the sgt. The mixing is undone in __unmap_dma_buf
>>            * before passing the sgt back to the exporter. */
>>           for_each_sgtable_sg(sg_table, sg, i)
>>                   sg->page_link ^= ~0xffUL;
>>
>>> Add support for paged attachment mappings. We use existing
>>> dmabuf APIs to create a mapped attachment (dma_buf_attach() &
>>> dma_buf_map_attachment()), and we create struct pages for this mapping.
>>> We write the dma_addr's from the sg_table into the created pages.
>> Hui, what? Not really.
>>
> Thanks for talking a look Christian,
>
> FWIW, the patch doesn't try to use the pages backing the sg_table at
> all. The patch allocates pages here:
>
> +       priv->pages = kvmalloc_array(priv->num_pages, sizeof(struct page),
> +                                    GFP_KERNEL);
>
> And writes the dma_addrs to the pages here:
>
> +       /* write each dma addresses from sgt to each page */
> +       pg_idx = 0;
> +       for_each_sgtable_dma_sg(priv->sgt, sg, i) {
> +               size_t len = sg_dma_len(sg);
> +               dma_addr_t dma_addr = sg_dma_address(sg);
> +
> +               BUG_ON(!PAGE_ALIGNED(len));
> +               while (len > 0) {
> +                       priv->pages[pg_idx].zone_device_data = (void *)dma_addr;
> +                       pg_idx++;
> +                       dma_addr += PAGE_SIZE;
> +                       len -= PAGE_SIZE;
> +               }
> +       }

Yes, I have seen that and this is completely utterly nonsense.

I have absolutely no idea how you came to the conclusion that this would 
work.

> But, from your response it doesn't seem like it matters. It seems
> you're not interested in creating struct pages for the DMA-buf at all.

Well the problem isn't creating struct pages for DMA-buf, most exporters 
actually do have struct pages backing the memory they are exporting.

The problem is that the importer should *not* touch those struct pages 
because that would create all kinds of trouble.

> My options for this RFC are:
>
> 1. Use p2pdma so I get struct pages for the device memory, or
> 2. Modify the page_pool, networking drivers, and sk_buff to use
> dma_addr instead of a struct page.
>
> As far as I understand option #2 is not feasible or desired. I'll do
> some homework to investigate the feasibility of using p2pdma instead,
> and CCing the maintainers of p2pdma.

Well as far as I can see neither approach will work.

The question is what you are trying to archive here? Let network drivers 
work with p2p? That is certainly possible.

> The cover letter of the RFC is here:
>
> https://lore.kernel.org/netdev/20230710223304.1174642-1-almasrymina@google.com/
>
> If there is something obvious to you that is blocking utilizing p2pdma
> for this work, please do let me know.

The fundamental problem seems to be that you don't understand what a 
struct page is good for and why this is used the way it is in the 
network and I/O layer and why it is not used in DMA-buf.

I strongly suggest that you read up on the basic of this before 
proposing any solution.

Regards,
Christian.

>
>> Regards,
>> Christian.
>>
>>
>>>    These
>>> pages can then be passed into code that expects struct pages and can
>>> largely operate on these pages with minimal modifications:
>>>
>>> 1. The pages need not be dma mapped. The dma addr can be queried from
>>>      page->zone_device_data and used directly.
>>> 2. The pages are not kmappable.
>>>
>>> Add a new ioctl that enables the user to create a struct page backed
>>> dmabuf attachment mapping. This ioctl returns a new file descriptor
>>> which represents the dmabuf pages. The pages are freed when (a) the
>>> user closes the file, and (b) the struct pages backing the dmabuf are
>>> no longer in use. Once the pages are no longer in use, the mapped
>>> attachment is removed.
>>>
>>> The support added in this patch should be generic - the pages are created
>>> by the base code, but the user specifies the type of page to create using
>>> the dmabuf_create_pages_info->type flag. The base code hands of any
>>> handling specific to the use case of the ops of that page type.
>>>
>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>> ---
>>>    drivers/dma-buf/dma-buf.c    | 223 +++++++++++++++++++++++++++++++++++
>>>    include/linux/dma-buf.h      |  90 ++++++++++++++
>>>    include/uapi/linux/dma-buf.h |   9 ++
>>>    3 files changed, 322 insertions(+)
>>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index aa4ea8530cb3..50b1d813cf5c 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -22,6 +22,7 @@
>>>    #include <linux/module.h>
>>>    #include <linux/seq_file.h>
>>>    #include <linux/sync_file.h>
>>> +#include <linux/pci.h>
>>>    #include <linux/poll.h>
>>>    #include <linux/dma-resv.h>
>>>    #include <linux/mm.h>
>>> @@ -442,12 +443,16 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
>>>    }
>>>    #endif
>>>
>>> +static long dma_buf_create_pages(struct file *file,
>>> +                              struct dma_buf_create_pages_info *create_info);
>>> +
>>>    static long dma_buf_ioctl(struct file *file,
>>>                          unsigned int cmd, unsigned long arg)
>>>    {
>>>        struct dma_buf *dmabuf;
>>>        struct dma_buf_sync sync;
>>>        enum dma_data_direction direction;
>>> +     struct dma_buf_create_pages_info create_info;
>>>        int ret;
>>>
>>>        dmabuf = file->private_data;
>>> @@ -484,6 +489,12 @@ static long dma_buf_ioctl(struct file *file,
>>>        case DMA_BUF_SET_NAME_A:
>>>        case DMA_BUF_SET_NAME_B:
>>>                return dma_buf_set_name(dmabuf, (const char __user *)arg);
>>> +     case DMA_BUF_CREATE_PAGES:
>>> +             if (copy_from_user(&create_info, (void __user *)arg,
>>> +                                sizeof(create_info)))
>>> +                     return -EFAULT;
>>> +
>>> +             return dma_buf_create_pages(file, &create_info);
>>>
>>>    #if IS_ENABLED(CONFIG_SYNC_FILE)
>>>        case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
>>> @@ -1613,6 +1624,218 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)
>>>    }
>>>    EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
>>>
>>> +static int dma_buf_pages_release(struct inode *inode, struct file *file)
>>> +{
>>> +     struct dma_buf_pages *priv = file->private_data;
>>> +
>>> +     if (priv->type_ops->dma_buf_pages_release)
>>> +             priv->type_ops->dma_buf_pages_release(priv, file);
>>> +
>>> +     percpu_ref_kill(&priv->pgmap.ref);
>>> +     /* Drop initial ref after percpu_ref_kill(). */
>>> +     percpu_ref_put(&priv->pgmap.ref);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void dma_buf_page_free(struct page *page)
>>> +{
>>> +     struct dma_buf_pages *priv;
>>> +     struct dev_pagemap *pgmap;
>>> +
>>> +     pgmap = page->pgmap;
>>> +     priv = container_of(pgmap, struct dma_buf_pages, pgmap);
>>> +
>>> +     if (priv->type_ops->dma_buf_page_free)
>>> +             priv->type_ops->dma_buf_page_free(priv, page);
>>> +}
>>> +
>>> +const struct dev_pagemap_ops dma_buf_pgmap_ops = {
>>> +     .page_free      = dma_buf_page_free,
>>> +};
>>> +EXPORT_SYMBOL_GPL(dma_buf_pgmap_ops);
>>> +
>>> +const struct file_operations dma_buf_pages_fops = {
>>> +     .release        = dma_buf_pages_release,
>>> +};
>>> +EXPORT_SYMBOL_GPL(dma_buf_pages_fops);
>>> +
>>> +#ifdef CONFIG_ZONE_DEVICE
>>> +static void dma_buf_pages_destroy(struct percpu_ref *ref)
>>> +{
>>> +     struct dma_buf_pages *priv;
>>> +     struct dev_pagemap *pgmap;
>>> +
>>> +     pgmap = container_of(ref, struct dev_pagemap, ref);
>>> +     priv = container_of(pgmap, struct dma_buf_pages, pgmap);
>>> +
>>> +     if (priv->type_ops->dma_buf_pages_destroy)
>>> +             priv->type_ops->dma_buf_pages_destroy(priv);
>>> +
>>> +     kvfree(priv->pages);
>>> +     kfree(priv);
>>> +
>>> +     dma_buf_unmap_attachment(priv->attachment, priv->sgt, priv->direction);
>>> +     dma_buf_detach(priv->dmabuf, priv->attachment);
>>> +     dma_buf_put(priv->dmabuf);
>>> +     pci_dev_put(priv->pci_dev);
>>> +}
>>> +
>>> +static long dma_buf_create_pages(struct file *file,
>>> +                              struct dma_buf_create_pages_info *create_info)
>>> +{
>>> +     int err, fd, i, pg_idx;
>>> +     struct scatterlist *sg;
>>> +     struct dma_buf_pages *priv;
>>> +     struct file *new_file;
>>> +
>>> +     fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
>>> +     if (fd < 0) {
>>> +             err = fd;
>>> +             goto out_err;
>>> +     }
>>> +
>>> +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>> +     if (!priv) {
>>> +             err = -ENOMEM;
>>> +             goto out_put_fd;
>>> +     }
>>> +
>>> +     priv->pgmap.type = MEMORY_DEVICE_PRIVATE;
>>> +     priv->pgmap.ops = &dma_buf_pgmap_ops;
>>> +     init_completion(&priv->pgmap.done);
>>> +
>>> +     /* This refcount is incremented every time a page in priv->pages is
>>> +      * allocated, and decremented every time a page is freed. When
>>> +      * it drops to 0, the dma_buf_pages can be destroyed. An initial ref is
>>> +      * held and the dma_buf_pages is not destroyed until that is dropped.
>>> +      */
>>> +     err = percpu_ref_init(&priv->pgmap.ref, dma_buf_pages_destroy, 0,
>>> +                           GFP_KERNEL);
>>> +     if (err)
>>> +             goto out_free_priv;
>>> +
>>> +     /* Initial ref to be dropped after percpu_ref_kill(). */
>>> +     percpu_ref_get(&priv->pgmap.ref);
>>> +
>>> +     priv->pci_dev = pci_get_domain_bus_and_slot(
>>> +             0, create_info->pci_bdf[0],
>>> +             PCI_DEVFN(create_info->pci_bdf[1], create_info->pci_bdf[2]));
>>> +     if (!priv->pci_dev) {
>>> +             err = -ENODEV;
>>> +             goto out_exit_percpu_ref;
>>> +     }
>>> +
>>> +     priv->dmabuf = dma_buf_get(create_info->dma_buf_fd);
>>> +     if (IS_ERR(priv->dmabuf)) {
>>> +             err = PTR_ERR(priv->dmabuf);
>>> +             goto out_put_pci_dev;
>>> +     }
>>> +
>>> +     if (priv->dmabuf->size % PAGE_SIZE != 0) {
>>> +             err = -EINVAL;
>>> +             goto out_put_dma_buf;
>>> +     }
>>> +
>>> +     priv->attachment = dma_buf_attach(priv->dmabuf, &priv->pci_dev->dev);
>>> +     if (IS_ERR(priv->attachment)) {
>>> +             err = PTR_ERR(priv->attachment);
>>> +             goto out_put_dma_buf;
>>> +     }
>>> +
>>> +     priv->num_pages = priv->dmabuf->size / PAGE_SIZE;
>>> +     priv->pages = kvmalloc_array(priv->num_pages, sizeof(struct page),
>>> +                                  GFP_KERNEL);
>>> +     if (!priv->pages) {
>>> +             err = -ENOMEM;
>>> +             goto out_detach_dma_buf;
>>> +     }
>>> +
>>> +     for (i = 0; i < priv->num_pages; i++) {
>>> +             struct page *page = &priv->pages[i];
>>> +
>>> +             mm_zero_struct_page(page);
>>> +             set_page_zone(page, ZONE_DEVICE);
>>> +             set_page_count(page, 1);
>>> +             page->pgmap = &priv->pgmap;
>>> +     }
>>> +
>>> +     priv->direction = DMA_BIDIRECTIONAL;
>>> +     priv->sgt = dma_buf_map_attachment(priv->attachment, priv->direction);
>>> +     if (IS_ERR(priv->sgt)) {
>>> +             err = PTR_ERR(priv->sgt);
>>> +             goto out_free_pages;
>>> +     }
>>> +
>>> +     /* write each dma addresses from sgt to each page */
>>> +     pg_idx = 0;
>>> +     for_each_sgtable_dma_sg(priv->sgt, sg, i) {
>>> +             size_t len = sg_dma_len(sg);
>>> +             dma_addr_t dma_addr = sg_dma_address(sg);
>>> +
>>> +             BUG_ON(!PAGE_ALIGNED(len));
>>> +             while (len > 0) {
>>> +                     priv->pages[pg_idx].zone_device_data = (void *)dma_addr;
>>> +                     pg_idx++;
>>> +                     dma_addr += PAGE_SIZE;
>>> +                     len -= PAGE_SIZE;
>>> +             }
>>> +     }
>>> +
>>> +     new_file = anon_inode_getfile("[dma_buf_pages]", &dma_buf_pages_fops,
>>> +                                   (void *)priv, O_RDWR | O_CLOEXEC);
>>> +     if (IS_ERR(new_file)) {
>>> +             err = PTR_ERR(new_file);
>>> +             goto out_unmap_dma_buf;
>>> +     }
>>> +
>>> +     priv->type = create_info->type;
>>> +     priv->create_flags = create_info->create_flags;
>>> +
>>> +     switch (priv->type) {
>>> +     default:
>>> +             err = -EINVAL;
>>> +             goto out_put_new_file;
>>> +     }
>>> +
>>> +     if (priv->type_ops->dma_buf_pages_init) {
>>> +             err = priv->type_ops->dma_buf_pages_init(priv, new_file);
>>> +             if (err)
>>> +                     goto out_put_new_file;
>>> +     }
>>> +
>>> +     fd_install(fd, new_file);
>>> +     return fd;
>>> +
>>> +out_put_new_file:
>>> +     fput(new_file);
>>> +out_unmap_dma_buf:
>>> +     dma_buf_unmap_attachment(priv->attachment, priv->sgt, priv->direction);
>>> +out_free_pages:
>>> +     kvfree(priv->pages);
>>> +out_detach_dma_buf:
>>> +     dma_buf_detach(priv->dmabuf, priv->attachment);
>>> +out_put_dma_buf:
>>> +     dma_buf_put(priv->dmabuf);
>>> +out_put_pci_dev:
>>> +     pci_dev_put(priv->pci_dev);
>>> +out_exit_percpu_ref:
>>> +     percpu_ref_exit(&priv->pgmap.ref);
>>> +out_free_priv:
>>> +     kfree(priv);
>>> +out_put_fd:
>>> +     put_unused_fd(fd);
>>> +out_err:
>>> +     return err;
>>> +}
>>> +#else
>>> +static long dma_buf_create_pages(struct file *file,
>>> +                              struct dma_buf_create_pages_info *create_info)
>>> +{
>>> +     return -ENOTSUPP;
>>> +}
>>> +#endif
>>> +
>>>    #ifdef CONFIG_DEBUG_FS
>>>    static int dma_buf_debug_show(struct seq_file *s, void *unused)
>>>    {
>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>> index 3f31baa3293f..5789006180ea 100644
>>> --- a/include/linux/dma-buf.h
>>> +++ b/include/linux/dma-buf.h
>>> @@ -540,6 +540,36 @@ struct dma_buf_export_info {
>>>        void *priv;
>>>    };
>>>
>>> +struct dma_buf_pages;
>>> +
>>> +struct dma_buf_pages_type_ops {
>>> +     int (*dma_buf_pages_init)(struct dma_buf_pages *priv,
>>> +                               struct file *file);
>>> +     void (*dma_buf_pages_release)(struct dma_buf_pages *priv,
>>> +                                   struct file *file);
>>> +     void (*dma_buf_pages_destroy)(struct dma_buf_pages *priv);
>>> +     void (*dma_buf_page_free)(struct dma_buf_pages *priv,
>>> +                               struct page *page);
>>> +};
>>> +
>>> +struct dma_buf_pages {
>>> +     /* fields for dmabuf */
>>> +     struct dma_buf *dmabuf;
>>> +     struct dma_buf_attachment *attachment;
>>> +     struct sg_table *sgt;
>>> +     struct pci_dev *pci_dev;
>>> +     enum dma_data_direction direction;
>>> +
>>> +     /* fields for dma-buf pages */
>>> +     size_t num_pages;
>>> +     struct page *pages;
>>> +     struct dev_pagemap pgmap;
>>> +
>>> +     unsigned int type;
>>> +     const struct dma_buf_pages_type_ops *type_ops;
>>> +     __u64 create_flags;
>>> +};
>>> +
>>>    /**
>>>     * DEFINE_DMA_BUF_EXPORT_INFO - helper macro for exporters
>>>     * @name: export-info name
>>> @@ -631,4 +661,64 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map);
>>>    void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
>>>    int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
>>>    void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
>>> +
>>> +#ifdef CONFIG_DMA_SHARED_BUFFER
>>> +extern const struct file_operations dma_buf_pages_fops;
>>> +extern const struct dev_pagemap_ops dma_buf_pgmap_ops;
>>> +
>>> +static inline bool is_dma_buf_pages_file(struct file *file)
>>> +{
>>> +     return file->f_op == &dma_buf_pages_fops;
>>> +}
>>> +
>>> +static inline bool is_dma_buf_page(struct page *page)
>>> +{
>>> +     return (is_zone_device_page(page) && page->pgmap &&
>>> +             page->pgmap->ops == &dma_buf_pgmap_ops);
>>> +}
>>> +
>>> +static inline dma_addr_t dma_buf_page_to_dma_addr(struct page *page)
>>> +{
>>> +     return (dma_addr_t)page->zone_device_data;
>>> +}
>>> +
>>> +static inline int dma_buf_map_sg(struct device *dev, struct scatterlist *sg,
>>> +                              int nents, enum dma_data_direction dir)
>>> +{
>>> +     struct scatterlist *s;
>>> +     int i;
>>> +
>>> +     for_each_sg(sg, s, nents, i) {
>>> +             struct page *pg = sg_page(s);
>>> +
>>> +             s->dma_address = dma_buf_page_to_dma_addr(pg);
>>> +             sg_dma_len(s) = s->length;
>>> +     }
>>> +
>>> +     return nents;
>>> +}
>>> +#else
>>> +static inline bool is_dma_buf_page(struct page *page)
>>> +{
>>> +     return false;
>>> +}
>>> +
>>> +static inline bool is_dma_buf_pages_file(struct file *file)
>>> +{
>>> +     return false;
>>> +}
>>> +
>>> +static inline dma_addr_t dma_buf_page_to_dma_addr(struct page *page)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +static inline int dma_buf_map_sg(struct device *dev, struct scatterlist *sg,
>>> +                              int nents, enum dma_data_direction dir)
>>> +{
>>> +     return 0;
>>> +}
>>> +#endif
>>> +
>>> +
>>>    #endif /* __DMA_BUF_H__ */
>>> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
>>> index 5a6fda66d9ad..d0f63a2ab7e4 100644
>>> --- a/include/uapi/linux/dma-buf.h
>>> +++ b/include/uapi/linux/dma-buf.h
>>> @@ -179,4 +179,13 @@ struct dma_buf_import_sync_file {
>>>    #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE      _IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
>>>    #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE      _IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
>>>
>>> +struct dma_buf_create_pages_info {
>>> +     __u8 pci_bdf[3];
>>> +     __s32 dma_buf_fd;
>>> +     __u32 type;
>>> +     __u64 create_flags;
>>> +};
>>> +
>>> +#define DMA_BUF_CREATE_PAGES _IOW(DMA_BUF_BASE, 4, struct dma_buf_create_pages_info)
>>> +
>>>    #endif
>

