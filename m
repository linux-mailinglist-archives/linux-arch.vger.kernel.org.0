Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5A726854
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jun 2023 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFGSU1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jun 2023 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjFGSUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2023 14:20:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DB01FC3;
        Wed,  7 Jun 2023 11:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa1cSx5szMheQbgD+pI2407W+yAn18jMxJLbC0wnl7fgfTxGvb7HWu571ysaF7a5jnF06siIoeFiMT+eKcBu1WK9W6olNuLfLwXJ6g4jnOtMFFjEUZ905z+U587vEckU/qyZngJs8CxnU9W/az6WyuTnnmJ8b4EJtwQxIPXUT+2zZ6HiLw//xEAW1dL0nX0Wu8Mpbqj4MpUg5Ie+GsCPbthM5EKv9cWWtH9lOvKru1wvKgDGa/OpPh8MzH/qV/npN9HINsZeeGxGmcfp/xgmQWpI2Hic0Yl07jqqtw2Kd1T1FUgZdK6tdTH8AeGfybKCE/jz2JSy5jQk6UqAQhuEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TK9SzjvqnrmjcO8gZRZTMN8bZBjqJuoC92fqtjaMaE=;
 b=jVfpohRbJhRchubd0fCm0hj1J2Hh+3Wv5so8uvfqHg+erALjrpvh9kdRoSLgD/0sVk23r2pPNl1YA41VqkOvFsO6kA7HIOqOlP3eBp9LwiIDuZeq/6hSq0q8Szgpmy0PeRJrK2M6AnieAKSemaoigRiGmsWJ2Xjn5vTTjEWlBwJ57RX8QuxIi0mKKGOXmbbYCherLwA+HWv6LG9L4Y28Eux9taoc+UFg9bvwplP0UqMWkgYXrYAzLnE/f/D+Q0tk+1QN039guJkmHdCmdatlN2QdMZ5qG/JfwsMisjuPyqW/rsK0e1Li8Eg8IIXvS3nbAefhxNa5ADy++AqUyij7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TK9SzjvqnrmjcO8gZRZTMN8bZBjqJuoC92fqtjaMaE=;
 b=DxAFVUG75rc8pux6pJT1PNcZQ0C8T6mAduEHNDKt8hOVMe/mUDUvcQmpDiYPeMtgR/jRfUKbwEVmEzsS4j85DYW3d4FK+n8cQmSlhxI+jqE8R+32jxJ70GcJakWGeueis517Y/Abjhc7Mohn6wWaP386VAfdZahI4MmU/UiNKCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 18:20:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 18:20:03 +0000
Message-ID: <383cd217-b128-fcca-0a99-432210de5e99@amd.com>
Date:   Wed, 7 Jun 2023 13:19:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
 <20230530143504.GA200197@hirez.programming.kicks-ass.net>
 <0f0ab135-cdd0-0691-e0c1-42645671fe15@amd.com>
 <20230530185232.GA211927@hirez.programming.kicks-ass.net>
 <20230531091452.GG38236@hirez.programming.kicks-ass.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230531091452.GG38236@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:806:127::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a0d2dc-47d1-430a-4b82-08db6783cfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JwWBXeBMkKywv+wjBSc/PpcZVZfdzmMLwhbPodeRJQ+aetFwlJXCYRvHKfUnZuTnVC/ysYDWPcsk0KM46hqv2zmN1RkbRYtNXhIxhE2VPljpAsqPpc5Fsl/h1NSOZq870rEwOAqdstlP4AT15hHoHgOppV3TgwUs8mpvvSiESnx1UwyhOogvI3CWhkgj32jZOhCNNV7VYFDuKi6I/uwQuefvD4XHBFWotEM99xNJMTX/2Xqqai1bKZDgU+ndzHwbIsilBEHD3iDvleDWOkJho00gazFQF7YXCez9wZjEqWuINc0ygLusJrLZs20Vbeu2oXEtYObNit7HfAqd23juPk1PWSVQDSoTwcvTbz3zkgTBLuwZXV9t8lMiVqwRxgOOamYttBla/G13i+6wHZ5mQXKOObZ2ORMHh2kVK/R7nt2xujBAtbknXrzaKi0OSd+dDALmKCCmv7B4gHqgqigdrZAxr/U62WekHY1mt3SGvuhAEyL5+qQ3Dkt64OmutjcKwQ1ROjObyHfisZJQkh+i3u9YEbarAbSryEbafJ3CIAcUd+bK3rBzJlAoMtMBx1pZNNfWCYm+hA3E7dEN4VduJsU2ONmDN/K70arCvHN4bvzQKZkI99TkKVmH6rLKJE89jw1taTKBQ6fjAahIz3naQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(41300700001)(316002)(54906003)(7406005)(7416002)(5660300002)(2906002)(66899021)(66476007)(4326008)(31686004)(6916009)(66946007)(66556008)(8936002)(8676002)(478600001)(6666004)(6486002)(86362001)(31696002)(36756003)(2616005)(186003)(38100700002)(26005)(53546011)(6512007)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dqT1FaRjZMV0NTZVZxc3YzQmJ0NUtrQnRZa3BQbmUveXdKOGFzR0JISjBj?=
 =?utf-8?B?bit3bklCM0xiYWk3dVAvRFJUdXQ3UnBqL2xNTjM1QWxuVkxmbUVUNHpVb3lz?=
 =?utf-8?B?R3p0RWp6MkZZS3BNNEd4TDl6YlF0Y256NiswVjNqNWkyekZlZHNSK2R3UVRh?=
 =?utf-8?B?eWQ0c21uSFJzTEVDV050WW1qQ2U3NEQrMjhTeFA4L1pObGJJbDAyQ2htYTlE?=
 =?utf-8?B?T2Y3Umh4ZUZDL3hBcU91QWErWWFMZ3Q2eTNrcVV0QUZjdHEzVWE4MVQxdmpW?=
 =?utf-8?B?ZE9Wc0xYNCttekRwTnVpRkxwa0dDQUhSdzBSdWdCNWloY0NsVS91eUJBTFBi?=
 =?utf-8?B?MVVET2htWXVDT0Y1T0ZHeWdMTVA2d3FjTFQ2MHRjZGhZblVQUk1Ddlh4WXlS?=
 =?utf-8?B?REJoN1B1aUVyU1RLNHYzdmxKSTNSZzZLZ3phUzkvM0c1dUhBQ1Nhai9ueTgr?=
 =?utf-8?B?UlVRZ2lPRGFXY2Y3L2JNSEpjT29MSHhST3J5OEJ6ejljR3RiTk1Bbm42R3dz?=
 =?utf-8?B?blM3MlVDeG9xVllHYm1TS2lFNmhVYk4rNTBaR1VCWHJzVWt4TncrOGdBV3NW?=
 =?utf-8?B?U2pGUUtiWE5vYlVaYWhPNEl2U0ZzVHBqb0ErVkd1QlhPMTRvbEliUGZ5MDI1?=
 =?utf-8?B?cUhkaTRhNHYvTk4ySmJXR2tvcElxZ3VXR094SXZCOTlrK3RKUVdkY21PMjhL?=
 =?utf-8?B?d2dUcUdZazU4aTloSlZjZXJNMzlxQWxjcnV1VG85eUZYeFRTK09SaGhGUVpP?=
 =?utf-8?B?U24wbkNTQVlUaXoxMHRTMGRHaDFnaGhYcjNGdlZOazZyQkNUeWpyRllGdUtZ?=
 =?utf-8?B?M05iMVVVbGpMSy9EbmhKTTNxUkFFWjc0eW5LTDlKKzJxWHlJZ0NpVGRuZzVx?=
 =?utf-8?B?RU93d0o2dklraWdScXA0L1hxV2NIcis3Vm1xaDhaVXQ5T0tubFlybnNYVVNw?=
 =?utf-8?B?YmhoN3c0WlY3ZHd5NmV4VGpGZlpEcEVJODVFK3NIODY4WlZqV2ZuVGUwN0d5?=
 =?utf-8?B?Mi8zVDFLYUNUeVk1VlhucWtKYUtiKzBsUWlWTkQzR3pxWlNDemxWWXozTWl5?=
 =?utf-8?B?U0Flbjd1UytiYkVvdGNxbXU1RFNyemIzUDZQWWFLd01kamxoWXZPdHh6QnRE?=
 =?utf-8?B?dXh6ZU1KaG5uaDBEbSs4SGkyL0FYMHM5MmNZaFZRSTdmOEs2eDgxa1lEckkv?=
 =?utf-8?B?Ym5CTWFTejFQTElBM2c4ekRuTFdyQUZXV1NXajU4UmJrcU5rRm1nbC9PWTRu?=
 =?utf-8?B?eDRGMkE0N2lvREtHeGJzQlFaeXhuaVFSQUkxeUd4aHd0bklCTGhieGN2d1dp?=
 =?utf-8?B?Y3JKQWRWc2pSV2xXNWtjYWRnQ1VHell1WWZtOFhGZmxjME5qS1JPRS9GbE9K?=
 =?utf-8?B?Nnl4YWtTSndveDR6ZjIrNUV3QXl4U3lDZ2I0RGNHSENFUExiQjNHM0Fmd2p4?=
 =?utf-8?B?a0FhNEVtMFE1R0toc0ZibkdkdmRUbnZBUkZ0WDVHcXptc3lkSlNycm9abU5o?=
 =?utf-8?B?TUxlemdiT3haajNWS25CSk9FRmU2cHFVUlZUTG4yc08rSXVab0NvUkVNQUdO?=
 =?utf-8?B?Ti9ocG9yOXo3d1JESHhKcXhQMDNCZW0rTUN0S1ZNTnpIMlkza1hXbkRaaEdi?=
 =?utf-8?B?VnV6bzB5VHFRTDJIR1hJOVMwRVd6ZUMwcUk2eUc3REh1aG5GK0o1UDB3OEZI?=
 =?utf-8?B?aFV4SlRmRmJzbTkyRTNsSW03bGZER25sNEhaY1Y5NC8vTUxVWHdxbkpmTTZG?=
 =?utf-8?B?R3FWcEh0SEw5cDNCKzNVV2ZLYkkzL3dqY2UzSzFYc3pHMmwrTzR5ek50azFP?=
 =?utf-8?B?a2RYMFpTNk92S3RvbkQzc2l5YTZiNEZRY3lnTzJKZUhEbk1EN3VXYVBIME5L?=
 =?utf-8?B?SlJOdnlXaFE2V0c1MlduWHdQYXA5MEFmVFdXZEUzbklhN0NyUUVEQVgvQjJR?=
 =?utf-8?B?SURHMjNlMkp6VUxGcGJFMitTdWk4b214RjA4SmtGbWNiazhzaThON2xvN3kz?=
 =?utf-8?B?OWJRUkpJMWNCdEQwQ1gycEJvS2QvaDd3Ny84MXdWbTQ0Y3QxbDFPVDJSWSt0?=
 =?utf-8?B?TmIyZWRiaURZUkVVclpoVjR5RkJRNHQrVUIzV0FqRXFtV2thMll6WCs1Nnpl?=
 =?utf-8?Q?hprdlfGBvMy41Txc+fMmg9jJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a0d2dc-47d1-430a-4b82-08db6783cfe2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 18:20:03.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OggdZSsOXU9sOkPWlFEAx9nGym9HkUKeGNKFjv/TDQg2gMekAstMXaong6+2dpBnEomE+5xdU7IuevLfX84wJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/31/23 04:14, Peter Zijlstra wrote:
> On Tue, May 30, 2023 at 08:52:32PM +0200, Peter Zijlstra wrote:
> 
>>> That should really say that a nested #HV should never be raised by the
>>> hypervisor, but if it is, then the guest should detect that and
>>> self-terminate knowing that the hypervisor is possibly being malicious.
>>
>> I've yet to see code that can do that reliably.
> 
> Tom; could you please investigate if this can be enforced in ucode?
> 
> Ideally #HV would have an internal latch such that a recursive #HV will
> terminate the guest (much like double #MC and tripple-fault).
> 
> But unlike the #MC trainwreck, can we please not leave a glaring hole in
> this latch and use a spare bit in the IRET frame please?
> 
> So have #HV delivery:
>   - check internal latch; if set, terminate machine
>   - set latch
>   - write IRET frame with magic bit set
> 
> have IRET:
>   - check magic bit and reset #HV latch

Hi Peter,

I talked with the hardware team about this and, unfortunately, it is not 
practical to implement. The main concerns are that there are already two 
generations of hardware out there with the current support and, given 
limited patch space, in addition to the ucode support to track and perform 
the latch support, additional ucode support would be required to 
save/restore the latch information when handling a VMEXIT during #HV 
processing.

Thanks,
Tom

> 
