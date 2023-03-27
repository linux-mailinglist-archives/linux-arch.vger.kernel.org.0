Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC26C9953
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjC0B1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 21:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0B1V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 21:27:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01040EF;
        Sun, 26 Mar 2023 18:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679880439; x=1711416439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lUpo7MlOcRVoo3I9us1eQD+7dyCzpUms2bKMyRfAF3M=;
  b=N6iwPyhmEU5VotIeiPAO/xLEmLGka2N/gCxBm4TT9lLObnJ1bvoI25mO
   xmtIRDWALmd6/CQ8Sl3HNpTkRydm/JvsUzBpnRQH5TNFN+NqgSwLSoj5I
   SSX4AThHCakl0rRdtlr+pEleSWmSrcGO2bxBiPAycDSusbhl7+rgefRRU
   aEfw4yVYZXOVdnPYP3cn0E5r9nvGUgfFDF5i16LQNTZ4ap7vQ+vx478QF
   KOVu6K2dlU8zbZIN8JHt7vSZSV3FxnnUXyzcNWOYI7pMNDDy4NLVXX+gk
   HidopkIvUc94pYMOX3og0midBTS9Pp2p60fhZN9LmcA3FdTMRG+oyDPBB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="405077585"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="405077585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 18:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="1012914749"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="1012914749"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2023 18:27:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 26 Mar 2023 18:27:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 26 Mar 2023 18:27:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 26 Mar 2023 18:27:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 26 Mar 2023 18:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRR8fQaznTjvJxr1o951IbSzFGHevQjSgMPY6Iha39MKO8vJ73QQlv4D98xSyqk2A0+vA81Nul6RLQDKbrgG+LLnR6CjXRUV4BZsefYIpAGvYXtK4NX3FSa1bqAnnOiJXCUuT67N4J2nPCgR8V8m/61VZkpFhLrXnHEDKEQlQgPASClJQBDrTXSXXQiAxZzwFA2GNRWoeqNpmbRV+OyEBxkQTuUoJSWkJrT0N2ukhp9par6TZZVvOh8kHufVLhNIluhAWoixohN/BTDHBBIQbsN+cZRoAGLJoDm2nNsEuUbihxvJudyjQNR+SEANCwOGdi/Pd6CGgtdYgfTbuUyNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfR/SjSVIYGcPVziP4kpJKgB4yiUBuCCRpXs70UK0ys=;
 b=n4e3NO+uS7SFjOiPv5SDZtWJdef+t+aGY5wuTAmzGb2f3Sq1gzkOI29fiYO8qB8r6s5v0dSpdYnGiKASPzNKcHuxehhies6J3+0Sa1cD1/FVRIyvn58sc2mfIILrXMsOcdCg9jfcZzCe+0p1Ny2Fmdv7tLEPcxEZ6UMsljIl+vovwHSaQY9VrtT+ITFkc9Gr5sG2SRL8CNa5hWGoRdx3xJ22ATz8JtzpGem01LcnQuQSlVCm6TDMmlqfbqINu7D6vMvXNJedMsXaVjEuTF8WhNnJ6CnvHl6qfiGJ55zbYMvWHIKhx8V3gazwWMLadbUz+s4spYLtvJ5pzh6Kozg/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7216.namprd11.prod.outlook.com (2603:10b6:8:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 01:27:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 01:27:16 +0000
Message-ID: <240650f1-a5cd-8b0c-fe91-0f8b116d6fe9@intel.com>
Date:   Mon, 27 Mar 2023 09:23:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
To:     Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>
CC:     Ryan Roberts <ryan.roberts@arm.com>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
 <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
 <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
 <20230324145828.GB27199@willie-the-truck>
 <ZB29hND1tt37dNUX@casper.infradead.org>
 <20230324172319.GA27842@willie-the-truck>
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230324172319.GA27842@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b19ce83-4f1a-479c-dcfe-08db2e62663a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wja0bpBVr7vsQkThoA/Lu/ngYjc6qg5vyOBIdoQsA+131G/bIE4Y+3RLIafaPNt19l2wo4gysCUDNUDdn4iUyTKI9H9dY8iG6CzRuwEHpOUb7Of3aFHfUKj1kV0YG+gTbg0/+uGjt3AAHrwJ3aIHrs5O93By1aqraCYGOs+aNMlDaz/dU7PpBAnAqBYkdSGnTYhZYzfQDKsoqS23wHuTlbFecy5QWdjNkJW/4WKyuo4X+xLOfOcG9UkNJPfE7Cbfos3RSvsGBr7c5gO1PRpbfYv/1uSRVvG/cCP8IEmhNwjUYW+wz9gc3ebgviyVxa2MVbrZl/WJszmDplzheNzKTym1mHTrHdfx9SzT2KwmuaVPYq4+sF93E/Samz1F1KWuNYEpsPPMH9WaEKYGZdoX9ENNpWb3YZFdTjBB/PXQV/Y9ZKjs8V/MYRRfA+eFnUndSnrRykmOCo3EOD/PQfvfQ4+mXemRy8UJpCq5BNm3982LB07sgXl1c0OLVQXJfWphVM8gjc80C7ZjF23KvfCMcbTZ6EKiWj8hddgClPKdO7XG2ZrvP0dxUSF+RWSwI3TbJTu/MBVx5FXcTYqtqnD3o8kwUO64JkV5wfYpMnU8Pq2H3gYExT3FSQLSnMPo5a4T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(2906002)(86362001)(31696002)(83380400001)(186003)(2616005)(38100700002)(36756003)(6486002)(82960400001)(5660300002)(8936002)(4326008)(8676002)(66476007)(41300700001)(66946007)(66556008)(26005)(6506007)(6512007)(966005)(6666004)(316002)(110136005)(53546011)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdkQnBqbG5Sc1NxalQ3Z1YzY0dVYWpieUMyczNOYW5BZFl5WDNkQ1h2WXN4?=
 =?utf-8?B?cHhpaXg2ZXpEM3F2YVljalB5TUNlL1VobWNtREdCUmVkdDNLbGw1UkpYYXBE?=
 =?utf-8?B?RHEyenlQWjBQd2lpazNDZ0E3cWcrQ3ZHay80TVkzeEhzU0hmbzFpZ0t1MFc4?=
 =?utf-8?B?M0lNT0F0blhPaVE2QkEzRndMbnVwS2lkMHRJZnZMVUJ6K0VoSCtTKzRwUjNq?=
 =?utf-8?B?OVFTWWdSZlAxUUxpQnI2b1lnUUFOYTFheHR0TzMwLy9GVHdFWCtwU0Z1NUx4?=
 =?utf-8?B?ckgrb0Jxc2hndjhoRnh0WTdabjZ6YmV5b3J1akVxaW9xTHNvVTRaWndsdDVV?=
 =?utf-8?B?U1FlVDM1M3lHNHR1b1RPSy9wbjJ4bzIwVnI5V2NNYWdjTVFnaVEzTjRDVm0w?=
 =?utf-8?B?ZGV2R1l3RDRiTVc0ei9IeUNTVnNzd1lhUzVvbktYSGVtUnE5M3RJaVNKTGdv?=
 =?utf-8?B?eWF0dERlNllWY0syS085citXSTNPVlN4OGNGbkN4VnkyVUNsVXBvWldNV3VO?=
 =?utf-8?B?c2RGOStWNEIxY0tVN1Jnbzh5SXBDY29NL1UxbWpCN0tGc0ticHZZeko4Lzk3?=
 =?utf-8?B?UTdIeXJLM2FES3MyTXdYL214ZGNLaGRsQ1pjdG5GLzM4TEhNT0p2ODVONk1r?=
 =?utf-8?B?MHVzbS80dHc3Wm11TzV2Vlcwb0FQNFhTM3hkMVh1YWlFNm96TGtXMUR3Z3dJ?=
 =?utf-8?B?V2ozbWRteithRDRudmptUkJoTTMwVStUL1NwSE1EYVJKeENWTm1CVmgwMEtR?=
 =?utf-8?B?bTlOWVg5N0VNV09DczlWK3NxOXN4cFY3VXd1QnRhVXN5TVVMWkdXMFA1Mkpq?=
 =?utf-8?B?RnAyVHpIQVNJMGpxRkx5U1g5OG5wL3RnbFFSdUVNdjFlU2I0TWRkT0Q4eSt3?=
 =?utf-8?B?SjEwTEtLK0RreVNCZ2psL2dGTlF5cmlNMTFPZlVnTG9vU29zWWpOd00zWXh2?=
 =?utf-8?B?eGlDVkpzUUhsR0dnOWpPTUpzTWVnVVBnWHhRS0E4L2k1QkFYdHdodzl4d1dK?=
 =?utf-8?B?Qm13aWdRa2xLQlBhcitnd2J4WEgrQlZHZHdIYlVvaktkUTBDYkFPdkNPTWVj?=
 =?utf-8?B?VHBybFl1cHJ5OFQxU2ZqdlJ0UkJFRFBnRlVFRDJWellKNWhidUkxYUtIdVpa?=
 =?utf-8?B?OUFhVHhVbHl3ekFMSHE5NHRLZ2lDVGtMTDQ0R0I3czZtNEsyaGpLUDNpQ2I2?=
 =?utf-8?B?MjZHd0svbDFKeFhLMS9FTmlJdVBzSkh4SXl2ZTlEUWZ6NmJXcThiV1YxZWtQ?=
 =?utf-8?B?NUd3c1hRL1lpakJiRW1aTFl0VWpncnBPNFNCYjhWeU04T2twenVOODFrZ1Rx?=
 =?utf-8?B?REQzTmh4SFZGemlwTU5icEJnWVAwR0RzK0VkNG92aVdiN1l5NFhTL2E5ODZP?=
 =?utf-8?B?WlNyTVY3eTVoWG92cXc1a05zOWZQZldFTVdNR0I2TTh2Y21kYnFZN3lXSjJD?=
 =?utf-8?B?WlpuRGl0Q21ubW1YYklYdDZTYUUyOHFyWUJuNnNBM1lQeG51RURCNkwvSE81?=
 =?utf-8?B?RmpwNk1QN0dwTVVUNEMvckxvTEY0dzRlcitsRElzS3JzbHplN295enA3bkhE?=
 =?utf-8?B?MkpyV05aV3Vib1lJSTB2MWdhRXFGNThTTldVWE55M0d1QVlLM3M2WE96N3ZL?=
 =?utf-8?B?dXZTZm92eGR0d21pRFR0SmdVQ2JCU0ZVTW5pMWlDU1hyZVZLT2R5d3dkSkpK?=
 =?utf-8?B?R0NteTZkSU1KNEpMMmFaUHJJS2MxNTV5VVZIUDlqZFhFekdTeDZJbVREaWsv?=
 =?utf-8?B?TTdDSmdmektRZ2RoUHRsTFFROTZEc3VzMmpOZ3ZMZWZFenlPeVBjY0prRXdi?=
 =?utf-8?B?SHlMcG9ENDRtZkgzOWt0d3NXa1hiNWViRFNucXJRNXN2NVlXSnpoSXZVRTV2?=
 =?utf-8?B?VlNSSFI3K1FVb01vYlc2bGxvbnhtakFDTDk2c0RwNFFkN3Q5TERMMGpUajkx?=
 =?utf-8?B?c2MxSWlQZS82RnQ4eDlBSm96YlFuclY0WU12NVFDdjh3TmRYUW40ZWQrY00r?=
 =?utf-8?B?aGVSbkVvSFUwK0hxSlNMQ21aazdYWXlJcFJNelRESjczbHRpaDhuN0ZuVlBH?=
 =?utf-8?B?V3VJUTB3ZjBTSDhuVml2ODlxYVFHL0k2Sll4RW4wWGlHV09haHUrME5SVEtm?=
 =?utf-8?Q?cJ0CmkjzYuAjgiFI146xtv6JM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b19ce83-4f1a-479c-dcfe-08db2e62663a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 01:27:16.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaRjZHL1/pIdftiWgb2daG/FykEMx3ziZnbGje7WUXZTcAFscEIneE89P8CVaidnVxe731NN0GehC0tFdmAvXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/25/23 01:23, Will Deacon wrote:
> On Fri, Mar 24, 2023 at 03:11:00PM +0000, Matthew Wilcox wrote:
>> On Fri, Mar 24, 2023 at 02:58:29PM +0000, Will Deacon wrote:
>>> Yes, please don't fault everything in as young as it has caused horrible
>>> vmscan behaviour leading to app-startup slowdown in the past:
>>>
>>> https://lore.kernel.org/all/20210111140149.GB7642@willie-the-truck/
>>>
>>> If we have to use the same value for all the ptes, then just base them
>>> all on arch_wants_old_prefaulted_pte() as iirc hardware AF was pretty
>>> cheap in practice for us.
>>
>> I think that's wrong, because this is a different scenario.
>>
>> Before:
>>
>> We faulted in N single-page folios.  Each page/folio is tracked
>> independently.  That's N entries on whatever LRU list it ends up on.
>> The prefaulted ones _should_ be marked old -- they haven't been
>> accessed; we've just decided to put them in the page tables to
>> speed up faultaround.  The unaccessed pages need to fall off the LRU
>> list as quickly as possible; keeping them around only hurts if the
>> workload has no locality of reference.
>>
>> After:
>>
>> We fault in N folios, some possibly consisting of multiple pages.
>> Each folio is tracked separately, but individual pages in the folio
>> are not tracked; they belong to their folio.  In this scenario, if
>> the other PTEs for pages in the same folio are marked as young or old
>> doesn't matter; the entire folio will be tracked as young, because we
>> referenced one of the pages in this folio.  Marking the other PTEs as
>> young actually helps because we don't take pagefaults on them (whether
>> we have a HW or SW accessed bit).
>>
>> (can i just say that i dislike how we mix up our old/young accessed/not
>> terminology here?)
>>
>> We should still mark the PTEs referencing unaccessed folios as old.
>> No argument there, and this patch does that.  But it's fine for all the
>> PTEs referencing the accessed folio to have the young bit, at least as
>> far as I can tell.
> 
> Ok, thanks for the explanation. So as long as
> arch_wants_old_prefaulted_pte() is taken into account for the unaccessed
> folios, then I think we should be good? Unconditionally marking those
> PTEs as old probably hurts x86.
Yes. We do only mark PTEs old for arch_wants_old_prefaulted_pte()
system. Thanks.


Regards
Yin, Fengwei

> 
> Will

