Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65569594F5E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 06:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiHPEYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 00:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiHPEYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 00:24:07 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E7F37E9C7;
        Mon, 15 Aug 2022 18:01:09 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G0kX7Y017598;
        Tue, 16 Aug 2022 01:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=Hj5zP3xpNUMdZ72UtQMAG/9YsIcd0BcG0mtOxn0pJu4=;
 b=mYyN1AIRNZ+fmf9Gu7zNKICZn65yXzGzFVTjqiHs1/AuhOaJqVqwRJT1Na/arXXQoCjn
 mJJNbzjyRq4yPjPvbXHS98jp4OHv1dyhvaHTMXXQNHBFCNcgLXqugcUQTrGUsZZTdvQj
 KFYUNiAhJbCWByxtQhJ/qMpoJ6els7ZeH8OBym5bZcBNrSZo0aqVI58OpMRO3mj2Tey1
 jwm0x01MQoQfmVkqI+Q8mNmsDaIaIMp9zHQOm+gYCe0uA+sIzmmIHttoXt8DdTWMV/pr
 j4sTFKF4izdvSku0yADJOkpYBSGVGPxo68WfNkcmkNKo0xG+P15hFYzXs8rLS3Y/SvFd 4g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx160t6tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 01:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ4vI83xm2pWCCHHJRgHlIc2n0/NOW1mQk0/1qDVbfscPFb7q5zvinrBpUBcV7i0ZXlckeBKqyszTCwLtRQirYsd03mGET1qPtNugFdMsVTYtV7zGJdWrGNh8VMKfuJ3sGuNagkABoQsvxUUmBDfcy+j9h8hMYx6lnmcUmDPLJWByD7fwYXWHfaH3B+xaZBHTKSa+R01HsCWwO6n0ulZJQTHqeMXqcF3JwRyKjEHxTKvaAggNd66z+7EPW09LWr2JVslJT8T59/DiPT4huYNCVEAPZEBCdzf1kTA3saD2hP7x4BqRAHZD/Qajdw5pugNDDVWg2p4azTi/aHPWz+yzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj5zP3xpNUMdZ72UtQMAG/9YsIcd0BcG0mtOxn0pJu4=;
 b=ghBvdtufce94oucyWEErwzgvBoOS7Dqd/F7pXRa0/RMPXqs3byJDa2e2PCz5uraeqIUS4rPRO168UVkMEG3Qf9YBHpQDvzRaAdrQKpV3ybn1mrQw5AI8kWLa4QWZNckhw2z4gcBVn5JGbPEYzKmZyIaG4wyCt58k4OdHTxlHpxA1s/Ksn0NqotmhY0SEOlZKS69+BosgUPFwoHdZZoU68wH050coFw6Ri2+GCckDpA+7cxNUAwbrDrUPancWTok3tQ4nH4L4K8cr0pFFge5LLfHelzVpuU3sQ1JqLdkXdGrkWSdZMQlCb7BT/pLDkVer1fp2aLFE3luLMju2EfVtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 01:00:49 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 01:00:49 +0000
Message-ID: <12be770a-ca1c-7231-ff98-661211f2d8ec@windriver.com>
Date:   Tue, 16 Aug 2022 09:00:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] asm/sections: fix the determination of the end of the
 memory region
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811063105.2553381-1-quanyang.wang@windriver.com>
 <CAMj1kXHxeGjbYXhXpgRBM60Hobo+0K2JkjEtm+7kzDOYobSmNA@mail.gmail.com>
From:   Quanyang Wang <quanyang.wang@windriver.com>
In-Reply-To: <CAMj1kXHxeGjbYXhXpgRBM60Hobo+0K2JkjEtm+7kzDOYobSmNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0118.KORP216.PROD.OUTLOOK.COM (2603:1096:101::15)
 To SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75b567db-f690-4077-783b-08da7f22c229
X-MS-TrafficTypeDiagnostic: BY5PR11MB4242:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d62Yny4/76FotHplfARLMAT7FI1pOMzIky3QzjX4EVvZ4TLJjvrMV2mo1BdyVg1eL1NV0uSHWdFbbpMgssXLLq1kCBKCPF9YmXigqnMHdIbcLM/pXRPvJ+T12C8VTXNeG2PlKhB6YgZ1DTxZSYPWQ5OdtE5OvDTqli/jTTYAAdCVciY99eUNFAbvsWdm/A6cZozJc1HGOoFQwG1RVprn3ihf5k2A79f8/LyJAHUq/0ESowaLhVODN5cYHfjjxjjkKifWLdGGQAWJQ1sO5AWruEdK6tuSeTwBCjHNHWfD7m+XOMync3nGYzJb2QS098QPfgjc7RIwHWP18i7i0tnhVlxotlugdyWkAVwX3Q412pRjx4ZvuwvIehjhn3LdtAq4cwDMA4KXxGZAyf8qIrXSbveEA7oUcFz8LA/+6zoREbPO1/mAmzTfFDqnD7dkVvdUkHhVvv6JAswFQGrxowZLnDhTyoSeFqqq3qCSCFIiAzgRLebF/m5th0iXD1g/SbSYcAeUwbBuzLqMbsvcgxpbc9mnuYLEoX2NFUK/V14UTrmT5ocpuOY07FMDGCBfWGDnkzFs1sqJaXm4UyDuDIKvjmjeKFO4pT943GLVY9h3I8rDERcV5WjjDxeAyuacfOFUixbwMTSGZYqJLbM+ga2LvwdrhIbGnDfY/2olkhbRuU6Ryrt+623mlDe2HIRfi2rz0fFcH9KsoYvjeroohowv/oxpmdIhad11BpYURJTxB00AUjFp7y8lFJYIke+VZjg8SVCWaxDipriwI4mP/gHa9EThDvaCIcfmbclmusTopNQk0aOrEl82xP28X5IFH1LNIBo8HIyorywjRrMRZaqPgIMj6iQ1XMISIGah/I7tckw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39850400004)(36756003)(2906002)(31686004)(38350700002)(2616005)(38100700002)(186003)(4326008)(44832011)(83380400001)(6666004)(26005)(31696002)(41300700001)(86362001)(8936002)(6512007)(5660300002)(52116002)(54906003)(53546011)(6506007)(6916009)(8676002)(478600001)(66476007)(6486002)(66556008)(316002)(66946007)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5RODg0L3Q2RmlaWVRoTmNXakdFV2pldWREZWhCU3ZPNkhGR2VpenQ2WENP?=
 =?utf-8?B?YUJPUGxaMEk3TENUbHFpVHJJOW5Qd0ZBWVF4ZWtONTNmYkc3dVEyZ2hUOWZM?=
 =?utf-8?B?dDl5THFRc1N4Q3pKRFdXbXdvVFFUQ29rcWxvZ0ZtZjZiVUdpMXdsQnp1ci9H?=
 =?utf-8?B?RXJWZkgrSjhkS2xhU0F5Y1o1WFVXR3dwaU90Z2JYSUR5R2hqMzFjb0pFZm9m?=
 =?utf-8?B?cXY1VUNvL1N3ekY5ZFRHcmVqc3pWZzA5RVRCUzZrd0trS0xpUm5wbW1YdjlP?=
 =?utf-8?B?WS9mcmRoRWVVbVlQTndmWHQwRGtTL3Vqb2t4MHNrRWNzOU44Tzg0T3dGSEEx?=
 =?utf-8?B?QXd5NWNIeFNYaUVVajVhU2w2dXFFRU9EbU1QKzN5KzFBbFBkUCttbU1pc3Rj?=
 =?utf-8?B?QWpzdUpvVEFPaXVjOVcwMEM2WUYvdlFYV1hDNVMxakhCNmg2clVEL2NJRFZo?=
 =?utf-8?B?R3ZTQ2xvTjhmK1VLV2RSMkpIN1RpTjJxaDlRTCtNY0VEMkFHclBGVUNuZHJi?=
 =?utf-8?B?V0J6WC95SHFKc0J5SklPOFdoVkVNMTZrOGJqby92UEljWXBaRmZ4emcyM3dS?=
 =?utf-8?B?cnBGa3FiKytvWnY1SnZ6VXJTNXRJM3lUNGFDWm90cEhWWUVEdEtPKzdqR1JR?=
 =?utf-8?B?SGVTVUFFbWVyT0xLUHJLMld4S0w4ZjZremdpbUh0QWpRLy9nSjNOK3hDTHJ4?=
 =?utf-8?B?KzdCd1VZQ3NiRzN3dG9QSEN6VTdWbEN4QmdIZFBqdFFabUhaUEdIR3BDekdi?=
 =?utf-8?B?Vm9valFYV3FOZ2RQYnVjb1lJUjZ1bDZ1WGJWdk01Y0hockZpVVFldE0xSm1D?=
 =?utf-8?B?Z0ZWeGdVWWRjYW1aRDU1TU1Bc1FNWFdyN2tuRWZYWTBtcmp2cDRHYnpwajUx?=
 =?utf-8?B?UGNDc1FnRzlJWm9BZjlkejFURWViRFdnL0s0WUlUTjZnWDZvVG9FWEFJaytp?=
 =?utf-8?B?K3hjNDVLRHJLSWZpd0JYUXlzSk9ZN1kzRHR6TWRPeWxxOHlYeHo2UHlFc3Br?=
 =?utf-8?B?WXh2WGZRbWVlNnhkMzMzYjlDbWpSZlhBdTdmejNtSTZMaUczcllUVDZBc1d2?=
 =?utf-8?B?TmZzU3VYemNBV0VFQ2FqU3BLeEQ3RVdUOW94elhyLzdLTmgzUmRIWHhqZzJr?=
 =?utf-8?B?Si9xaHNvWWZ6bWkxNXhyeG1JbmlibXQ4a2w5am5rWTFtWlZsNDQwVHE1OXRC?=
 =?utf-8?B?N29rWDFqSHJ1TUVibTdmOUt2bnVQVG55Y0ZQV0VpZTRGNFRPVzd4U0t1c2lp?=
 =?utf-8?B?QzA2UnU3b3Voc2lJRDBKZzB3eDJGMUVKbjY1dVdnSlRlSkdKcmdSbzBQR1Rp?=
 =?utf-8?B?OXUwSXhXc3NCTGo0aHZZZVgvNlFSbDA1bERRQUI4VmhBMkZIS09kUUp2SWZu?=
 =?utf-8?B?T3U1V0JUSWthY3hCd1AzVG5nYVp6UnBUcHZ1WmNIUld6TnJsT2NDeXRhM3p3?=
 =?utf-8?B?NEVJT3ViWWdPdnA0QjFMdzJyY0hOWlcreXdUWTBYZ0tiMlV6RzJpcDkrVXlw?=
 =?utf-8?B?bWtISFNHWU4yaDNEM0NmWEcwdld1VFZaKzZiNmpLUFFjNTNmbTBXZndWVXox?=
 =?utf-8?B?dHkzTXpjNnJVVlJuVTA4ZVkvbFRseXh1UG95WDdhRzJ4YXdNdS94RjVVTUkw?=
 =?utf-8?B?aXhWazRqNGlCRy9razVkS3RtL3hIRnFUOXV1NUhDWisrMTZnR3Y1cFZBOWdI?=
 =?utf-8?B?bUY4MkxOTTRmWm5zZWdaa1VnVndQVnJyZDFmZ2ZpSFZNbjBFY3F3UUFzTlF3?=
 =?utf-8?B?T3pSbkI4TEF4RGM4WWNFNC9SeHZYY0hocTJidUU3MCtnMWt0dXNnMjNFQWlS?=
 =?utf-8?B?SHBtdVlNRnp2a3UrVnhETTJCbEE1UW9nSktibWNjSjdpNnFNTTk5dGF2d2Y0?=
 =?utf-8?B?ZWx5YTA4VlRaUUxyMXY4RFlzS3htRWVFQmhOejlCdjJ3cndTckIvWGFKbmNq?=
 =?utf-8?B?cG5ldVdrV1hUYjhQWmZEaTd2ckRjbU9ScGZSOGNybUFLaG5zVlQ5a3Fod0dn?=
 =?utf-8?B?RUFqTTcwalR3bFM3NWg4ZFpXZE05ZGl6VVU0WDJFU3BqdjVidVJsU3A1dHUy?=
 =?utf-8?B?ZTNwVTg3WmIvaC96bjk1NzdpcGdPWlJ3cDRRUW1UWFM1Ni9GbDhDQWFCSTBz?=
 =?utf-8?B?bWdKRmtmeUFLWnUwMVErQ2plUDRnaVVlUzdHeU92VGJuL1dlMm5BRkx0cEVN?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b567db-f690-4077-783b-08da7f22c229
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 01:00:49.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0C+H/xuu2MhOQsFGoAMOsRroHrh54iLRBhqj2jXuDLDRTOgxsRFm+BJIP9aD4fekGKA9+v1fv0VesE3Nki0ZdHEqwfqTfge1IjOsRORN+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
X-Proofpoint-ORIG-GUID: gR4Xk8966Vh1BYnDEO_nXzxJ2R7H4xqd
X-Proofpoint-GUID: gR4Xk8966Vh1BYnDEO_nXzxJ2R7H4xqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=946 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160002
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ard,

On 8/11/22 16:16, Ard Biesheuvel wrote:
> On Thu, 11 Aug 2022 at 08:31, <quanyang.wang@windriver.com> wrote:
>>
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> If using "vend >= begin" to judge if two memory regions intersects, vend
>> should be the end of the memory region, so it should be "virt + size -1"
>> instead of "virt + size".
>> The wrong determination of the end triggers the misreporting as below when
>> the dma debug function "check_for_illegal_area" calls memory_intersects to
>> check if the dma region intersects with stext region.
>>
>> Calltrace (stext is at 0x80100000):
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
>> Fixes: 979559362516 ("asm/sections: add helpers to check for section data")
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   include/asm-generic/sections.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index d0f7bdd2fdf2..f7171b4f5bfd 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -108,7 +108,7 @@ static inline bool memory_contains(void *begin, void *end, void *virt,
>>   static inline bool memory_intersects(void *begin, void *end, void *virt,
>>                                       size_t size)
>>   {
>> -       void *vend = virt + size;
>> +       void *vend = virt + size - 1;
>>
>>          return (virt >= begin && virt < end) || (vend >= begin && vend < end);
> 
> This test looks flawed to me for another reason as well: it only
> checks whether the start /or/ the end of (virt, virt+size) falls
> inside the area, so if the area is covered completely (in which case
> the intersection of the two will be equal to the area), this will
> return false erroneously.
Yes, the test lacks some checks. I will send a V2 patch to fix it.
Thanks,
Quanyang
