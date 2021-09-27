Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29512419F1B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhI0T2f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 15:28:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:51388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236447AbhI0T2f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 15:28:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211797484"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="211797484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 12:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="615977548"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2021 12:26:53 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 12:26:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 12:26:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 12:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGkxZRkN03Fm5T+e3Vk6YzOFHUL7N+mqanJYycUsocm97dpo9ulopY/NMgHEw75lpqLN/mxdkhBurJlPlUuoAuh78oyyyuthpQZHgJuy2nLq/Bn3t6SAS0ftmJglPmGiqCjxU4k3H9RsmZQIZnAwn0ZA7OuC+cY+svGP2vDc/TWF6tJurRj1cHh3aold3sES0ZX8bCZf/oyQJSK4w+5x+GRvShTrHBDuZac524YeLrPeAGqOG5wUO8uVRbMPdy74FliSzOKmFAdaXK5kL1xV9FGUCJtROOqZVmhay21Par22d/L1rlMYZWuZzJFWhCh4X09V+DExVR25teyvmSXXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r10G1+NTA/T43K6hiiNO5wD0MoSNUdRvft0CPmC22N8=;
 b=dxsaK8iE+5jN4L6CS2JQTNYa5mXkbdWE2co0PmrgaG6H1v86gB1AhefrLJQUlxkiK5OgFGQUED7IgHX3XOoTE+cpm8lSEm1FSTblIsbgyP/onCOS8cP/nym6Ce4APtevNgfh3xcH+gT9u4C7zYSWQjPNzJ4Hl9ZImfedwoMaELbH8c9Vw5q2z8OCS2kjYomkD3YK7QPc1VVNWlaEXCvpSOuNiGvxzD9COUs9rifiAReCV276bHjIUAjjW/uWxS42ZYqkRDbVFYcq/0xax/3vfSjhajjZ4IjA3Hv2tKU3DNseMHLQT0LJt2T4wRrNK8+nfCh5M9s+sGaREyp2aACILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r10G1+NTA/T43K6hiiNO5wD0MoSNUdRvft0CPmC22N8=;
 b=DMYUllc/SADiNsizkFNO2+pMBmWzdlNBvvzAOsWXRhq+bce0bT/y5bBRK8LCRvQjs/yphS/wmiD6Ylkiw0hjJ2jusizvFJaKettymS76hI2R4PNJLuRCYVw//hkvpqTjq0SAWkkZotu6o8TB1G9tEl5jgbLzb5e1RruYW1J8FHw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3127.namprd11.prod.outlook.com (2603:10b6:a03:91::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 19:26:46 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:26:46 +0000
Subject: Re: [RFC PATCH 05/13] x86/irq: Reserve a user IPI notification vector
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-6-sohil.mehta@intel.com> <87fstugabg.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <7b0f2e77-51c5-f9e9-de5b-8fe59b1df8fa@intel.com>
Date:   Mon, 27 Sep 2021 12:26:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87fstugabg.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9 via Frontend Transport; Mon, 27 Sep 2021 19:26:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85652cd9-3578-42d0-fe88-08d981ecbedf
X-MS-TrafficTypeDiagnostic: BYAPR11MB3127:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB3127E96D969595CFEC12B76BE5A79@BYAPR11MB3127.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEZLFRfabn/bJ5kcDHruDV1j5xnLZNkt4CHgRASyUwXZPbFb/gppq/MUPwBZTKr1h+ShQtF3AnQE7E4MtGcuRufod8svlZBzUOZUCKTFa0xbew7nNMp0xJoBxkvwKKX50WIq43veq15MLSuMPMXvQSA2WvdWL6W423WjkQBljfPVrHbp4m+qqLemsR8T1j3VzKffo23Qlwi272+J9OFVX8Ha5OJ/8DHR57ElWWPcZJWzw8GEFXcI+vgtV9xKad8WqF4RCP00/9NvR7SySQnonP1uaZph8xiUYS7OBaNI1UExuX+7GBypLZXF7JgI738uP2MTWhJ9XHoMPh4viRhqvM2oZ2N3Wn5BYf3Hu7LRwQvGmuRHC6F0BCxRFozRXco/ZwdytpSKrWnC9We3FTgOqwugOtgeVF4t7VhPLEBWeljjw7mh4AHiv9Llq2HYjy8zQJHmBIQNfArtRGvig+u6uUmlJcWE8xLQFKD3PsQrseJoIdZGspBcwbiQ6tECMqvPS5R/O7w6+8HR2jlEMSLoGypgK0EvY/oCO3rpMSZ3tO/p8htPi5cts8GE5CZ9CkSKuJhOzA0EWzy9vtq7C103VCOoLisz5TGPcveKI023ZPwsH+E4VizSSWGi2fGaL9JgOo81s2DdvMRLvXC40w+w2EFJTr2dPNk8pO4jLRiRL/p7l9APLgSkl2Y4oeUOodSCNta6oC5qE0B5Z+cFhMgRAr1BZrxEIcN3JOJGa/UJa6Y9gIZPe45DD78HcqP1uvCW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(508600001)(66556008)(66476007)(4326008)(36756003)(316002)(31686004)(16576012)(54906003)(26005)(44832011)(31696002)(53546011)(86362001)(8936002)(6486002)(83380400001)(2616005)(5660300002)(8676002)(15650500001)(38100700002)(2906002)(186003)(956004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0MzTUYyZlkrQ1BRWUpuWWdGd2xkaXpVYXVGbHYxRmRrSW5rR0JpNUc0RjZ1?=
 =?utf-8?B?TzEwS1VhTU4vcVdJM1RlTXhlbTY1bHRGYlRSUVEyL255STFORkdVSjI3MUdZ?=
 =?utf-8?B?UjdKcGd6eXA3TWdZRStydWNmM2IyelZSeXZOS3dHRlhxSEl5SURzeUQ5bnQ5?=
 =?utf-8?B?OGhyYXJYbVdxZytzY0tCUDNBTlhCUitEWEV6SFZRcE1zSVVJZkVLUm5ZYkQw?=
 =?utf-8?B?VXlTdVZNZHJ4aXFCZ1J4QzlUdTdZSVBJODhzMGlWSkpDNzlKT2p4OGlYY2tx?=
 =?utf-8?B?ZlpqVnR6MXduOEtNR0lZNXBhR0l3TzF2d3FSSGNZaEZxSEU1ZFBOL2RkOFhu?=
 =?utf-8?B?ajRnbkhhdjZFR2tGcmpISElaT1o3MUc3OXZWOVg5bHlZN2l5MHRiWEdhRGhE?=
 =?utf-8?B?RWNXT2FERythSXB0RG9HRW9XMGxON3FaWjBhM0RKUkN1KzRVODVJTUd5MnFi?=
 =?utf-8?B?REtrWHROSTJScUZSbnA5bDA4d3UwQmZnK2FiNEpYNjFrZ0oycmVKQ003WTNL?=
 =?utf-8?B?NnY5S1ZTTnpnRmZkOUpGTGNMRlJVLzU4Z3BTWmVJNnZpZVBlNnQ4ZW5wOWdM?=
 =?utf-8?B?RmJ2WjZ4OHlnem5RSGhTV0JVUFhCOTgwM2tna1laUVZ1SkhyTTFuNkhJMksr?=
 =?utf-8?B?b1AyK21pQlpxbzlMTkNYTUFSazRrY0hPak9qcXd2SHBhcVEvdnpVVGtnWFIv?=
 =?utf-8?B?MlFUT1dKRWMzMUdCWnNoSnlPUVJHNXp4LzR5K1oxS2ovYUg4Q3hPaVVRRXhO?=
 =?utf-8?B?MU1BdzlIL1hmeVdoWEFxTjFXanZIQklyTnZWUnFYVmg5enlRR25qNHNMZU9R?=
 =?utf-8?B?emtJQVFkSjVSUFlDc0hVWmExWGpWQm5mcytKQ0hQQ0szMjlxTGMzb1NTL0s0?=
 =?utf-8?B?L2hZWSsydnJFRXRBOEtxVEVjWml2UTJJMmUwSXFpWWxWOERVYmlVaGhNVVZ4?=
 =?utf-8?B?T09ZQmp6cVBLanNLSTZmckxyQ0NhMGlqbE1WcWh3TnFIc0lRZWhWQXhYZ0ds?=
 =?utf-8?B?Mldpcjg3bTZGWkpVYW9HVUhBaFdQWGlnRm52THh3czVSVnJnTGQwRlRqQ0l6?=
 =?utf-8?B?VkJpNFBkYTJLN1BPLzZSdTd3akZyVUxhVElPOThKdHN2RTRyQ1YrTFpJQi9j?=
 =?utf-8?B?NklBWHUzNzBTMFQ0SFZEYWtBVFhJV3JQSVljRHY1OERFRmxHSXdWUm1ZOFAv?=
 =?utf-8?B?QjUvV0JkS2NXZTkvTUYwbjIvdWxOZ1dRM1pLRUtqYllNMGtPbE0rU1ZUbVZT?=
 =?utf-8?B?UHdhemYyRk1wSjRuTE8xQ0pzazVmTS81SjMzM1lLU3JwOVR0Q3E0ZmNIb2M2?=
 =?utf-8?B?RUtVOVExcDUxY0dTTUx0VUthRGo4bk9Uc0UzVkgrMi95WjBSengwdTdEam9l?=
 =?utf-8?B?MWZyTTZ3cjJUeFVvYWUwakhZK0JuQkxhZ1A4c3FPUHpCeERJSFBTZURKb2E3?=
 =?utf-8?B?dFRLVmFVR0lBRWg2UEVOOE4xSUJnM3BKQ3l4TnRscnl6TGg4MFpyQzY0M2Jk?=
 =?utf-8?B?NmhKQTByb2tGQkhUb013TkZpa2hyWnRPYXdoKzl5bmZHYm1NZ2JRQjRtMDVR?=
 =?utf-8?B?WGtGUkdtK29NN3cxcXg5aEtPL3dxSVh2VXg2d3EvbEFWbDQwZGZFMUR2RjdM?=
 =?utf-8?B?NVcwN3EvRVBRS25lTXY4a2o4M0luYkFXdlFXYldVeEplUWZucVVpNU9TdGJv?=
 =?utf-8?B?VnFkemRZbVVYYXlLSkJXSkRGNzZCQW1NSC9wOXVkM256Z25QV0RmM1FXODNK?=
 =?utf-8?Q?OIb6Lz5UO8jfd0Hj2JlxnvJyODPWBbLu18gg1lM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85652cd9-3578-42d0-fe88-08d981ecbedf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 19:26:46.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H7LD89A/vOXKD6U9PgMTS0drkcAtaUguuiyKg2slDt79LKyx6USTRp1k3mpSqsCRYcym5n1MlyEaqCW3k6eRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3127
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 4:07 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> A user interrupt notification vector is used on the receiver's cpu to
>> identify an interrupt as a user interrupt (and not a kernel interrupt).
>> Hardware uses the same notification vector to generate an IPI from a
>> sender's cpu core when the SENDUIPI instruction is executed.
>>
>> Typically, the kernel shouldn't receive an interrupt with this vector.
>> However, it is possible that the kernel might receive this vector.
>>
>> Scenario that can cause the spurious interrupt:
>>
>> Step	cpu 0 (receiver task)		cpu 1 (sender task)
>> ----	---------------------		-------------------
>> 1	task is running
>> 2					executes SENDUIPI
>> 3					IPI sent
>> 4	context switched out
>> 5	IPI delivered
>> 	(kernel interrupt detected)
>>
>> A kernel interrupt can be detected, if a receiver task gets scheduled
>> out after the SENDUIPI-based IPI was sent but before the IPI was
>> delivered.
> What happens if the SENDUIPI is issued when the target task is not on
> the CPU? How is that any different from the above?


This didn't get covered in the other thread. Thought, I would clarify 
this a bit more.

A notification IPI is sent from the CPU that executes SENDUIPI if the 
target task is running (SN is 0).

If the target task is not running SN bit in the UPID is set, which 
prevents any notification interrupts from being generated.

However, it is possible that SN is 0 when SENDUIPI was executed which 
generates the notification IPI. But when the IPI arrives on receiver 
CPU, SN has been set, the task state has been saved and UINV has been 
cleared.

A kernel interrupt is detected in this case. I have a sample that demos 
this. I'll fix the current code and then send out the results.


>> The kernel doesn't need to do anything in this case other than receiving
>> the interrupt and clearing the local APIC. The user interrupt is always
>> stored in the receiver's UPID before the IPI is generated. When the
>> receiver gets scheduled back the interrupt would be delivered based on
>> its UPID.
> So why on earth is that vector reaching the CPU at all?

You covered this in the other thread.

>> +#ifdef CONFIG_X86_USER_INTERRUPTS
>> +	seq_printf(p, "%*s: ", prec, "UIS");
> No point in printing that when user interrupts are not available/enabled
> on the system.
>
Will fix this.

Thanks,

Sohil

