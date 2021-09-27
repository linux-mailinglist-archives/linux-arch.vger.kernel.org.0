Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AF41A3C5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhI0XWL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 19:22:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:61660 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238012AbhI0XWK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 19:22:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224232367"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="224232367"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 16:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="476093690"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2021 16:20:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:20:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:20:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 16:20:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 16:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDJMMrTS2iXhHz0GL9LCN/OW3fK8joy4b6WrSqwaa66fRhTO4TEEL9AEIyt3FjdtCIzgYkR3P1S4yLOE19pVWxLLOD+Fq+AcAFKmCVvLSE3BjxKVDfD62zPn6e2YubJ+SgADTJ3spdahm34ChRmxQ6wVvmvk7JjoLum1qaEA68u6eRAI5RhmTzB0ctqRpKoQPSIPIx+F36VmXsR1co2wKu7QdOgLMDH16VJzyMEECnyU/7+pWLj5nK10yPv8sI05Hi2coO4I/uPYzZ9gSe0lEN1mVjtVL7WFj8mCVbkCKLX5u2GzwrE75IZgL56IRe27w9Ax9iCFpCQoXZcSIX9OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HBW4dVNKQkooVKRFRI/MMj+UKY1agGIMEokBjoYWOJU=;
 b=eRtTDyKcqRKEWiCNBlP3SMehSD2cW0I4hf2Xmi0+Zlvl+/EcY29sele3YaOWHuQufUih/XJE3oI8q9IOXOtb0GuMcZ3w5t+kpUqC/7IhsCG+eW072v9tsBD740MtiFkDhAwZlcxYT4JNwvEJ8vPPPhAw05GAnfBlFVyFYdyo1E2O9vXpHbddMCCGuXtA/e1U6PY9rYlsbmH2GHIAg27Cnb1L5P3iG38n8DBNm8lF4tj/qLYWZAg50nGCzDcjRvpVMMuV9ybGYP5OYvIqKRUvJbfpzMmUMMamzKO6eycDv4sN2zAg1w9FEPvaZ4mKkPSi0HyY+9zrOVcXPNDHZkmghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBW4dVNKQkooVKRFRI/MMj+UKY1agGIMEokBjoYWOJU=;
 b=WO274NfM4UFWWIVleqCg6RZRBAqZ3nL95XpPE0TJaVwd3KCJ4cCwEpue4tqVIOWMzPWj/K8x85iuYIZlDjZ8Vfcc83dsMcrvkTYrwxm9ES6vQB+qWdzEFZTvPWp1PEvDpszN7WZxbtlRjctNVoy1Xa3F2qlU2kmyo3pV+2gyLuk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 23:20:27 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 23:20:27 +0000
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
 <20210913200132.3396598-7-sohil.mehta@intel.com> <YUxyZuJoK87OeGlw@kroah.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <d3cabce0-922d-b09c-13b6-cafa7023d93f@intel.com>
Date:   Mon, 27 Sep 2021 16:20:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YUxyZuJoK87OeGlw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 23:20:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c8c7ccb-2ef9-462e-78de-08d9820d63dd
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5216:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5216D7B579F5715D9E10912CE5A79@SJ0PR11MB5216.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eU5yo7LHrlzx00CPRFlM5Gww2/iYk23af0Tss+jZeXI+5aGxkwVJamoRKFjdYKwh8EXhbhniMQC93bC0Eu/DMjVSXSX7V1iMDkLyaZxfXin/kYCVaS5vjxyNy7ohCmNpLXZysxeDi35qQQbWkENlQ0otDBmpU+9imDfhCu7pB3CGR0OLwUsiHTdlYye8T7TlmOlUX2oa8tgRU30ZbpCe5NvCsDANeYbTZpT8jhVytmnUKWSVNXvDYJ19kD7bmNF6lNwnFp/yrQa1OjiTvROuNNoJJw2DZLE9t0vmYYBuJ3RZp7TT4HN9UUCbZtf6eQevTr+fIkaDpufZvlE4yE36F0TGFLo/xkYzS/vlx4DydBpZV9mHGtuyLxktxbOhX5IAr7EyLqMwdVCDINDpQV/7PSMEIMMsrswCZsw+EFHLPKDc2GQicgGYCtk3vuOMCrg0T4oifOciKZsJObWRdzZhCjoYIiFm8ikgYtX4dakXKwDN/pZsvks6Wh718PkNTTuxmMr9ycjpnund9Ib/KQOormyeL1g262dBAFzdCdHtSkkv3unWIR2cFROHMClNP3+PntgEpbrN3ml3ADggxjvY2+SSPhkCdfLF9hM4rYXZ3mAw+HZNlYCQpAeaTB+xXI3OyQ8ZS+DRYJDcDKzC+7Pr9xHhYsk9TutM54nAuz1tr0ohGA9qyES/SwRUVx6vX335orL4xmSiWDJgHJXEQoALVqacR5W+5CtRBS060Hi1uj7nowzxuRmhvtn2s9lGOPJx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(31686004)(6486002)(66946007)(26005)(53546011)(38100700002)(66476007)(66556008)(5660300002)(186003)(8936002)(83380400001)(36756003)(956004)(7416002)(31696002)(16576012)(4744005)(8676002)(316002)(4326008)(86362001)(54906003)(2906002)(44832011)(508600001)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBGYk5aN0w2OS80YlI2ZXhqRDVtcS9yWWkvN0JQTExiVTFZZXZEbXBBVjhX?=
 =?utf-8?B?MkpyWXZDWkJtWVdPUjNVaVRub0xCcTE2dW80TUlkYUlDR05ZbENFNEYrTnpq?=
 =?utf-8?B?SFpPSWtNaTJkZ3QyM1U3REpIMytreVMyMlFNdzd5bTRsT1UwRkFEOENPUkMv?=
 =?utf-8?B?WXFHNVYrNWVxdVZ5RDZJRlRoTXh4ZnhNSDBTZWlRRlUrbnlRWVlCOElLalk1?=
 =?utf-8?B?WjFHcHM1Uyt2VVB3S2xuVzU4TkwyUXpmUnFCaU9adDFnelZ1NUlBOGlNRFhW?=
 =?utf-8?B?Zy9IS29hSjNmZFU5Tlh6clJBcHp0WnFOdHVJVVcxQmZXOFJDM1k0YUM0N09W?=
 =?utf-8?B?eCs1TmM2K0QydkdvRlVEOGtjZlVUZm9oQUdJQ2Nxd0E3MUI1SHVzd2YzVFpr?=
 =?utf-8?B?cEFsMUN0RHRyaEFhQk9VdGdyYnlVbEVzSGV4T2VBQUE5V2VpcU1aL2xGRzJC?=
 =?utf-8?B?ZURvSXltN2tqV1FRMEwxaVZ6TDUvdTI0REhyYmk0TEIvTVhCZXY3aGl2Mm9R?=
 =?utf-8?B?Y0J6TU9MWU45ejVabEtSak11dUtSWkFTUnF6cXFpZ0Z2MG1DQ2xBSW5uNDhn?=
 =?utf-8?B?Z0EzektpWXdHQXlCK2plM2ZjVGduVGtWSmx4ZFNMMlBWbFJqVFkrbUFXUERa?=
 =?utf-8?B?WWtEd1N4cVkzSnZUeHBKd3ZjbUhNNzc1aitPNCt0c2JjUk1YcmgwVE0vcFdD?=
 =?utf-8?B?a3JWTmNhSks1UXJxN0dYQjBDdWMyaVlZWEttRHhheGJscnVPSGs5RG0yWlZu?=
 =?utf-8?B?d1RXQlltUjFQa3JMS043NTZZbGZ2OWNVUE9SNlVHR0FWNHNMaFYrSEQvN0Fx?=
 =?utf-8?B?amRESlJFTTg5bHdKd1VuMzUyNFN5SzhBMnY1RE5wUHM3NzlNTHBueEhYQnd3?=
 =?utf-8?B?dkpwREZpWnQ1T1cyMEh1cDdtS2VNMGFTZ2tnVVliMzhjZEtLRkdNYnpVVjQz?=
 =?utf-8?B?VndvNmhOdFIxZytheFBMczBYMzBhYkFKSUtST2F3K1NtaWsrcEVWWXlzMUl5?=
 =?utf-8?B?Ukl4Ymg1K041OFhxQStLK0dPeDdsd2xRLzNIN1BDUXBMQ09ucWNWYnRCZHZ3?=
 =?utf-8?B?NXhUM3FjMDF3Wmt4YlF1VG5iTnN2Q2pVeCsxWEVkWnVjMElmMGNWVUtWT2Zs?=
 =?utf-8?B?bEVUbW9UZFYwNnIzSGJ0K2xIV21lRU5vUGRvL1A5TlhhSFJ1QjlkbHBtOXg2?=
 =?utf-8?B?blZaNVREcEg4eHNIMHNsSTRyTUR6OHB1KzIyR09kSXdzVElZVGlaODdPSW5j?=
 =?utf-8?B?dkZwWkIydUlmSUZCMXNVS3JaZmFYNEFtVWVSLzRtT0ZEbmZyeUNkeGZJVDh2?=
 =?utf-8?B?VTUvRFRYOHQ1aW9ZeHQzVUpSVHlwSEd4c1JmYTgwWDFzTUZ2STdzNnN6Q1p0?=
 =?utf-8?B?U1ZveDF6YlpNaVhmQ01wejFPekQ3WXN1V3pqazVrUXVYRWNoZm9WUlZ2WHFG?=
 =?utf-8?B?U3oyckd5cTJSclZueGhBRTdNQldvRmRqb2RvdTNueXhXL1pmNXJWSktEL1Rn?=
 =?utf-8?B?Z2xGM3grWFFHcXMvemtxVGVIdzNENW84Vy9nTHFUdWR3ejJDZ2o0RC9YdEVz?=
 =?utf-8?B?c21wM1hVeWlpbjVMZnQvMGZRNDIwTkFZcVpMdFhZa3VRNzFxWkczWjJZVmpV?=
 =?utf-8?B?S3Nucm00ZVNPTXdFZU5Dekt0dWprZUZxMmpQazA1YzRyODF0K0xXUDNvRVJl?=
 =?utf-8?B?V1FOTitOYm9CKzk2d3lSb0NBQlkvUDJFWmtmbzl2V3h5ZEVkTWFzdzh1Z2Y4?=
 =?utf-8?Q?4ztcymY5jYbGsnI702dp5lShbvIoWMV6fdwMVGv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c7ccb-2ef9-462e-78de-08d9820d63dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 23:20:27.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0pwecZBF+vMg/TPJdWCRcb54VrX5SPxkZn2PgydagRYJB6uhbAPPdWQJ5XLDgksZI4xF+emOWxwjwCeeVZXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 5:26 AM, Greg KH wrote:
> On Mon, Sep 13, 2021 at 01:01:25PM -0700, Sohil Mehta wrote:
>> +
>> +/* User Posted Interrupt Descriptor (UPID) */
>> +struct uintr_upid {
>> +	struct {
>> +		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
>> +		u8 reserved1;	/* Reserved */
>> +		u8 nv;		/* Notification vector */
>> +		u8 reserved2;	/* Reserved */
> What are these "reserved" for?


The UPID is an architectural data structure defined by the hardware. The 
reserved fields are defined by the hardware (likely to keep the 
structure size as 16 bytes).


>
>> +struct uintr_upid_ctx {
>> +	struct uintr_upid *upid;
>> +	refcount_t refs;
> Please use a kref for this and do not roll your own for no good reason.

Sure. Will do.


