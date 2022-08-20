Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E559AA03
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 02:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiHTAZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHTAZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 20:25:24 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85214D59B1;
        Fri, 19 Aug 2022 17:25:23 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27K0J2vZ019292;
        Fri, 19 Aug 2022 17:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=i4reeLMpz8TMzgdb7QcaKt/G8dg/jls3kpb8u1y+Lu0=;
 b=MInZ/qivtH9cruO85JAo3ftx0u/I7KHB+qzdxAXH0ayfDhOUmgKsd2QiR/NSPRGco33i
 bEMQWKUO22o/A0dXvirWZa9ghrqynonox2z7L9eQSDhoDzF59pB1lbNjkh2AIFbdYTgj
 eNR2pSOi5FfkvsDpovKqW9RnOIXtQSULg0sW9BjYL+BnMfCdoKtgwLFjFon/k73R2NoC
 2EAry8cCT2ygsdJhm+tTOZbXWqgfVZkeCFocH6HVhgl8l3jU6kAe1B3vfWCDPhsDU6lq
 xsECuAHauosZUEnzf8Drilj8eoiKmWEjRLg5zxbaXZ6Ga+7ezxWHLihiNQZL3vGhwNiF mw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx783du3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 17:25:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncQkXionmBwx8B7lCETE96dGOMkWtC0RbfyFWf62+V1WfmDxEt+/wbWf1FJ3Qsz+qdJzF2hSUcnmvcJSn2IEXqDkZ0O+3oxY9UCduDZnGOHzQHHiuyOt+we1gNUs/JyVNMiWDPmi5lYDg6XD4//btXwhY49KXTz0OlAhLbEOst2gSpe3XNyKazBmV28njNgiIqzrGWpxwrOGQD1Q2r2kDQYlM4YUu/2FgZKVcsuZTW1JLaeWE9YrAJIlB/4Ya/wJkPWoiz2nMxSEV7nTxfroYp30P3S1+x4kQpBgjJDoWTuz91zu9RNWTj6nOfRXq9aywRurdTzq3EK0mMEdZku2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4reeLMpz8TMzgdb7QcaKt/G8dg/jls3kpb8u1y+Lu0=;
 b=IA8xLftVH6XHXE3X16k/pt6/OIQjvCpuZO1C8st8hGfvCdG/uI9EzejU/4nXkRRwEnRIeKOZ8sv93EU7zK1tUouTjT7IqI985DxuUXzr2yMgVzV0gkCJo63E0Ox0Ko9bYlXC3KEkd9057iQL01mwb1zNwXLkayokRkoq+m0xjCZ08AbB1oOXvA7ZK5I3qTpZtwjjJXK58VwCaiXElpKI7gN3qeeZyKxguA0rLVhF3oSIt7VFUvGrG+bsOdeWv822Dx/CsRKoDoR5ezLzhOlvrioFHYVdpnT4KxvFce50Ol2Z8E6M3rGxrPlnkJNRF7QNqJFtYz4ZPs/wAJvvldAbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by MN2PR11MB3822.namprd11.prod.outlook.com (2603:10b6:208:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 20 Aug
 2022 00:25:09 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131%9]) with mapi id 15.20.5546.016; Sat, 20 Aug 2022
 00:25:09 +0000
Message-ID: <a22358ce-8eb3-cd34-47e1-363ce37e0ae7@windriver.com>
Date:   Sat, 20 Aug 2022 08:24:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [V2][PATCH] asm-generic: sections: refactor memory_intersects
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220819081145.948016-1-quanyang.wang@windriver.com>
 <20220819145100.ad9d08094ab9f345563fc52b@linux-foundation.org>
From:   quanyang wang <quanyang.wang@windriver.com>
In-Reply-To: <20220819145100.ad9d08094ab9f345563fc52b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a06ac67a-3281-4190-6013-08da82427090
X-MS-TrafficTypeDiagnostic: MN2PR11MB3822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUNeU0HEUB2BlmoW/kLEzlq/Ct0EiyJ6WqUTBt8SwX1ASwoEHOf2QQeePBd3na7m19o0yVWZd0nhxgZsk8pMHrcJLnVwl6w6p3C8HudF8qdRfdATjuZNc0mLyG1eJn3D+Ez69ezUuHLn2bWHAAZwODaLgnCEH/+UtoO6vED+7ORqSPHnJnjIMQz0JeR3YskfDujPO7W9qG4vCZdpWQR+HFndP72Fh04Sxrm4ZDWqH3kyM33HSIVQj6pJKaPXY5qrVzblKD+xlQNDrfdhWEJ/RsxIlGtWDu/ea9k1XDKOOsT9Swg4E12QojF+PYCLJHqj1DP2auiZIGU+T7f7yA2v81Ru+meB/O2eyTjNG/ElyFIbzWH0hdGrFEAtdKZxnRkCzxWN5WLyTLGKRtQOi8gUkzvkZfi7vrplRCXrZR+mTUHyYiw8ow6tA2X3ZiIA78vTKG+nQfKb03vNQFQWJNnnMFdLqp2ZzT/1sND3kVZVEkjJu31bYbgRHn1MeCH8pHykuyAR2pOG0Fy83tWI8Oq+bpGJAdqTq58SSyAa49CtK5py1QHSBJk2lvxNpCooTYUrxQknt24xi3i0Evu4dz7w6YnQdacKxUOsiOHXBXXWGpdIuTqujNxgKbDU4u5rS/7RF2IyIixbf3Hnsvcm1UUdxRvWQselOLpBBD5gJ2EoL22ZN9dVK43wk7Vd5PICKMv1MycbkmK9gpkrAFe6mMNvHsHYgXVtDj+8mJRzfKwasZWSzmI9TLehjcja+3ky/MH3nokWedsYm/TZEmAIDCfKIvXBhqNBIapNY4H7FRfbLwThvR1/CCooV155QrLyMGQvZBgj83RDGtRXB54D9FhVFiy9p0SAXYHcCDu0eFUmYgovuhRkKmXhbKzVQzPH8jFC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39850400004)(366004)(376002)(38350700002)(31686004)(38100700002)(36756003)(83380400001)(316002)(54906003)(45080400002)(41300700001)(26005)(6666004)(8936002)(6506007)(2906002)(478600001)(66476007)(5660300002)(6512007)(4326008)(66946007)(8676002)(66556008)(2616005)(53546011)(6486002)(6916009)(86362001)(31696002)(52116002)(186003)(9126006)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU51ejN4ZTFoSUFlWHZXRjYvL1h4VDdmUTJTNEs1VEkwVnVOemNZdzdpcFlC?=
 =?utf-8?B?MGwxNDVqb1ozNGZCZ1E2b0UrT0RUVWtNUEtUUVRzTFVwNk10YldEZjkxZWQ3?=
 =?utf-8?B?WExNLzJZNGtRMjVJZUVqSWliSzFISkkycStOQkI1R01FWThqVnd0b2tRSmw3?=
 =?utf-8?B?d1VFcU5qWUpNTTgyc092R2hoRlFpaE1jUWVzdGVUMU90SXZQR3Bka0ZtcVlH?=
 =?utf-8?B?S1hiR1R2WDcrUVVOMkF1TFNOMDZRNzFjM2xzVEt0dGtVUXk3NkxXaGp1dEpT?=
 =?utf-8?B?UmxEcjBiR0hYVUVXVVJ2SlBxVklobEYzM08xaHZxbFpxMlp3WXlOTHNObFFO?=
 =?utf-8?B?cDhHSTBOR0RBajZyMkduTHhIbmFGZ0FkV2JBbVRZTmxRQkhENnBjbFdkc01q?=
 =?utf-8?B?djUrUzJSZlV6c2VEZWUweHhOclV5MmU1dFluWE92RVdaUTJoSUtGNFZJeGVl?=
 =?utf-8?B?RjJ6TExZQlhHc3BQL0dreDB1UjJZWlBjS29CYStvblhwOExvN2ZKSlRiVXFo?=
 =?utf-8?B?RDlQaE1MVTl3VHcvc0o5M01Ob2tqb0NhbkZiN2hhaG5kZVB4SnV6RGtWS2J6?=
 =?utf-8?B?RGdtSjU5U3dMQU9RdEYwYUdOak5GMGFOZ0txM08xNDlYSDRraXBnUG1ndW1x?=
 =?utf-8?B?T1duektKRU15Lzd4RHFYTHN2Ym9tS2hrWWd0VWJxVC9JN3FTczU4ZzhpVWh0?=
 =?utf-8?B?a0xZZFVPRVN5aHVvRDRKSkVVS3hTaGtNalpUa1U1Vmh2Q2ZRZWJUcDh2R0lm?=
 =?utf-8?B?NHFvVlBkaTdPOVZ1Ym45b3hOdnhQekhYSCt6TmtNYlFoS2IwKzViOG1oNGpK?=
 =?utf-8?B?eE8yZEtSUldkZm9NckdoU3FIR09La0FFR2NrTlVieDBxTkRhU0M3T1JaYVov?=
 =?utf-8?B?WTRKRUU1SmtqN1RVS3lwRitLcWY5bmdtN2NEbnFpcFVBNnp3Z0dBRWFHYWdL?=
 =?utf-8?B?NTFDMTU5S21DdXY3YkxqNllvQ1lxUEVrZTNidTZheElJbjVqN0V5bWlMQ2hp?=
 =?utf-8?B?L3FzeVBkdVV1NTVJaGMxdDZUaCtGeHFkSkUzTzVTZTVWV1hIWmZSQkRpY1JF?=
 =?utf-8?B?MC9pZUpSVkxxaFFkRmkvajJLQ3pQb0lLd0UzeFl1cUxwK0RBYXBmU0s1bC9L?=
 =?utf-8?B?QkllTGpRcGVMKzh1ZzRNK3Z4SGRIUWlFZ3A1Rm92VVZlSDlyVE1HRWl3Zlgx?=
 =?utf-8?B?UlNJbmMzOXBUcWxLcnplcGViVDkwVC9pUnVzUGlhblVtU0t0M2VlcGZ2QTdt?=
 =?utf-8?B?M01RYkxFeUcweTdPT3g2c1h5SWQxM3lOZit2ZHZsQ1BLLy9VQ0Y5ZW5EQ01W?=
 =?utf-8?B?ZEhDUklRU1d0MzAxZGtuclF5Szd3NFBrT2FKbGdRektSY1RUSGMweU9BU2FT?=
 =?utf-8?B?c3F2WlloVnkyNWp3b3FDcHM4TUVTeFJqdjV6S3A3eDkwb0c0c2E5aWVaTUY2?=
 =?utf-8?B?OUhQRmZsS2NJZzVoYTNBcndUYkt1MUgxSzRTRHY3SmgrbFRsSVBadHprdDkx?=
 =?utf-8?B?SWhsSmtWWkludTdLdGNqd1luenEycGlISkJDMTJkTkJLckZKWGs1NUxmSys2?=
 =?utf-8?B?emVRcHQvaHdaVDRWWXQzR2hwbm5RaVY2djl5RkY1SE1vNkw0ZndsZGU0bmto?=
 =?utf-8?B?bFFMVWlYNEVGRW9IS2dMV0VWTTFSVjYrdG1Ib3hqYVdsemNqY1greWJtNjJu?=
 =?utf-8?B?SUFYZGNoMDZ5ZUxMejRrclR6Nm56QVludDJ0SVNOTUJIYUFFM3RvOWdrcVpv?=
 =?utf-8?B?ZlZtSC9OcUs4WDI2eHZJQ0U5QzBuNkdGcEdrTDFDZjNUbmJrdHV0SmZBVGVB?=
 =?utf-8?B?SitlRm1WNWdUTkhLWmlnQkJlbWdtUkRpRlhIKzZweFViSGQ0UHRwM3dLT0Ur?=
 =?utf-8?B?TlpNZnhYMkFVb0thK1g2a25qdDY1M0xNQWZDWUhYVVZ5Nm5JZCtUNjJKOXl3?=
 =?utf-8?B?dmRKMEFPcDBJUHk2Wi9OakxFdTluSGJTZ1VPOGR5b1hBYnN1Vk1tc2QvOFVU?=
 =?utf-8?B?MHMzZm9QY1N0RmV5Y3lLWUtxMWx6WFVKUndRbnB1bzVqZCs1S3hSWktlZ1pt?=
 =?utf-8?B?Nzd2aitmVzB0cUxWNmhISkd1Mi9wRktOWnFyQ0lyRStXL3pLYlFJM1oydkZy?=
 =?utf-8?B?MVBvNzNXbHVoNXBGM3BNZmpkcFdCSkhYUFBWRmx3NW9GZUdSSG1pdFN2TWh5?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06ac67a-3281-4190-6013-08da82427090
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 00:25:09.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BcFyVHA2ImwlJW5FMo30BHpriHLPraR3TKBDVZgCyaF/05jxsJfOfK8BmWNL8vJ96rWGP9FX5MCp1+wv1JXzXtdJN0zadyLkthaQDIx7qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3822
X-Proofpoint-ORIG-GUID: dezW8FopMotSvr1nl6svoLFK0Frjq8dX
X-Proofpoint-GUID: dezW8FopMotSvr1nl6svoLFK0Frjq8dX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On 2022/8/20 05:51, Andrew Morton wrote:
> On Fri, 19 Aug 2022 16:11:45 +0800 quanyang.wang@windriver.com wrote:
>
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> There are two problems with the current code of memory_intersects:
>>
>> First, it doesn't check whether the region (begin, end) falls inside
>> the region (virt, vend), that is (virt < begin && vend > end).
>>
>> The second problem is if vend is equal to begin, it will return true
>> but this is wrong since vend (virt + size) is not the last address of
>> the memory region but (virt + size -1) is. The wrong determination will
>> trigger the misreporting when the function check_for_illegal_area calls
>> memory_intersects to check if the dma region intersects with stext region.
>>
>> The misreporting is as below (stext is at 0x80100000):
>>   WARNING: CPU: 0 PID: 77 at kernel/dma/debug.c:1073 check_for_illegal_area+0x130/0x168
>>   DMA-API: chipidea-usb2 e0002000.usb: device driver maps memory from kernel text or rodata [addr=800f0000] [len=65536]
>>   Modules linked in:
>>   CPU: 1 PID: 77 Comm: usb-storage Not tainted 5.19.0-yocto-standard #5
>>   Hardware name: Xilinx Zynq Platform
>>    unwind_backtrace from show_stack+0x18/0x1c
>>    show_stack from dump_stack_lvl+0x58/0x70
>>    dump_stack_lvl from __warn+0xb0/0x198
>>    __warn from warn_slowpath_fmt+0x80/0xb4
>>    warn_slowpath_fmt from check_for_illegal_area+0x130/0x168
>>    check_for_illegal_area from debug_dma_map_sg+0x94/0x368
>>    debug_dma_map_sg from __dma_map_sg_attrs+0x114/0x128
>>    __dma_map_sg_attrs from dma_map_sg_attrs+0x18/0x24
>>    dma_map_sg_attrs from usb_hcd_map_urb_for_dma+0x250/0x3b4
>>    usb_hcd_map_urb_for_dma from usb_hcd_submit_urb+0x194/0x214
>>    usb_hcd_submit_urb from usb_sg_wait+0xa4/0x118
>>    usb_sg_wait from usb_stor_bulk_transfer_sglist+0xa0/0xec
>>    usb_stor_bulk_transfer_sglist from usb_stor_bulk_srb+0x38/0x70
>>    usb_stor_bulk_srb from usb_stor_Bulk_transport+0x150/0x360
>>    usb_stor_Bulk_transport from usb_stor_invoke_transport+0x38/0x440
>>    usb_stor_invoke_transport from usb_stor_control_thread+0x1e0/0x238
>>    usb_stor_control_thread from kthread+0xf8/0x104
>>    kthread from ret_from_fork+0x14/0x2c
>>
>> Refactor memory_intersects to fix the two problems above.
>>
>> ...
> There must be tons of places in the kernel which check to see if two
> regions overlap at all, I'm not sure why dma debug needs its own one?
>
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -110,7 +110,10 @@ static inline bool memory_intersects(void *begin, void *end, void *virt,
>>   {
>>   	void *vend = virt + size;
>>   
>> -	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
>> +	if (virt < end && vend > begin)
>> +		return true;
>> +
>> +	return false;
>>   }
> These things bend my brain, but all the cases I've mind-tested worked
> out OK.
>
> Now the forever question: is a -stable backport needed?  The bug
> appears to be six years old, so I guess not.  Can you suggest why it
> took this long?  Are you doing something unusual?

Before the commit 1d7db834a027e ("dma-debug: use memory_intersects() 
directly") , memory_intersects is called only by printk_late_init:

printk_late_init -> init_section_intersects ->memory_intersects.

There are few places memory_intersects is called.

When the commit 1d7db834a027e ("dma-debug: use memory_intersects() 
directly") is merged and CONFIG_DMA_API_DEBUG is enabled,

DMA subsystem uses it to check illegal area and trigger the calltrace above.

Thanks,

Quanyang

>
>
> While we're in there, I can't resist fixing that typo...
>
> --- a/include/asm-generic/sections.h~asm-generic-sections-refactor-memory_intersects-fix
> +++ a/include/asm-generic/sections.h
> @@ -97,7 +97,7 @@ static inline bool memory_contains(void
>   /**
>    * memory_intersects - checks if the region occupied by an object intersects
>    *                     with another memory region
> - * @begin: virtual address of the beginning of the memory regien
> + * @begin: virtual address of the beginning of the memory region
>    * @end: virtual address of the end of the memory region
>    * @virt: virtual address of the memory object
>    * @size: size of the memory object
> _
>
