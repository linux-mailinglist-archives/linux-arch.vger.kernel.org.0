Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF062FB7B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 18:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiKRRUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiKRRUa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 12:20:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499EC2F03B;
        Fri, 18 Nov 2022 09:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668792029; x=1700328029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lSeXBxuUK3sZe+Wkf7iDLtYF0f3I5KZNZWfAYXniLII=;
  b=JvdyfS453b1qOH7FSALn7zHBbzah24HYIKZ7JX9eX6OuTTXm+gpTx4s0
   cX9LdqeFOSKohtbGqqJPnCi5UBxX+xeeKz71jfh9NG6oQim25Y4n7mIsm
   o70I4kIIXyf4RxTJrEbVIhBVEi+W0sOSBWHqoD0hMsf7EF5evuac2XUmI
   GEZKC2IRMCSuv0tuPDNT55h/hLRwlAABm3iXJ/VCHJ0uy7QpElI0V0IES
   MUsXNCFIQcS1DDnNeWxpPFyHeWfTv9bUSxmg47Vl1T1rcxyxx3Pc4K+eg
   snTVDBidk2kuS4IQikLzXjlVPbxWV+UtTdjA6ZU/sS9iHbwjzIfuNgTG0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314337396"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314337396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="671384109"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="671384109"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2022 09:20:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:20:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 09:20:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 09:20:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH1DzS0JZIpYccszWjTZU5Ndfws5Z6T+9HK1ZjNN48V6VVgO/LU34kmPY0KZW2EVvNBKZZ/yGvMyrby7GpflPB+srAQiJVd1ug21bpJm7uchKRaSXKaTmC7+wKUDjuNpM1IDIMg1Za9qyFcSPnHEedhiWGHSQgIptu3GGjn9mgf9di55OAL9GeTqbpbd4bgE5xGz0H5UHnO6mPVsF2fTHUSTJDDxqOjrFjDKKhbmL7DnbxjsH4HuSoFFlr79yC6l/OT5Ld5z3iERNjKR5JZXz5xZtx38q5p6kQQGl9cfsy/2gdUtgJb0p98qTqjM+ymI1Rp6KNwxdpEM0hh/cUkmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSeXBxuUK3sZe+Wkf7iDLtYF0f3I5KZNZWfAYXniLII=;
 b=M8TvTPGmyjvoJa4ZYbEej6gK6HjqfGg9VJVEH50Bqc++QBOohf3qD2a1IDTrZerS+1PY9RZc8+IsqCFKYa9eq5PuSoRSXeJIjSYzXgEDXY9TsqqaNRkfG4f0Lz729zHS9Lx6LmFcC8acU/n7gmpJP6eK/eleIJjPpHpmBmGtZ2fzrwFaMyrjPYYPuz6No3xDGUvHhhY6pGJogyCTXoj0t7SJF5JPMHlu/jqF17Wi5ZlyqjJtfKlbUoy13CIDWqm1sITddBeGqGW6gKkrvenQ3SF0q8Zv8+13qoTxsqw7KuclyCxW6sr6g213Ig0Cd8TL0P+Jnm+wVJP93ChztahE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 17:20:19 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 17:20:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkIAAH/sAgAHGHQA=
Date:   Fri, 18 Nov 2022 17:20:19 +0000
Message-ID: <88f33231041de56c70a4c06c603962a2f8d7ca4e.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
         <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
         <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
         <Y3ZB4iJew2Fkh4R3@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3ZB4iJew2Fkh4R3@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6553:EE_
x-ms-office365-filtering-correlation-id: 9b90c413-6e93-450d-daaa-08dac9892b06
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5IMgij66+zxli6Q3HgOM0ZnB52Gs6Ig5Aek7ji9T70Wj4lHz5OtgcX30abSXL3URTtZ5leJj5FaPQarLDGraDbwCNDfT81J39EE9LaKEVU39mvzkRQpMuQhva90cPx9+oWvNxhccXef9e9qcUlsvuNFc8u4xUIOfErinlHr6jCYJ+hEKXzVYT1ldS/PrWDuIEcHno/luS+LCkpdR9WCGIhmZWuP1nbMief8FTtUbqD8IJ+IF7l51iNc3jUP+RWsZuQqSdm23FXH0HdQN09/zPtqQlTajOdnV6R5TxaBAbH3pyq5FxIy3pzl4XVzdCVcNyYStn9BOyTWPIsH95hBMvEgqWo7/nfJXas8dz2q8vyN82Xi8KW/r4OmKlE88I2Pk8qEC9InMw1Th+ZZAz1dize5gli1cW6jhldK+/KPmicx7kDvwb56WmMgPrMlw9fz4Im1qXUNDEWFNFHNuhIzBNcujKt47Fi3F4xIxfRPWnALCF99waRabnsh5HdPIK2ZCKIoUibbCYn/c1KF8WfN1IBc8t+IQOIbO2V6dWaNeZLG8fVuNPaVdzuxYGA5SMf+UqIQ5Okkfbhc8ZN67i5KS66UA0tJ+aF0uaGzUXvqYc1F5xrBuixaHn1Cg0dwd9ULTRjUgL/Q4ac6HasSFe6puhkOz6iWxR+CQ1VbAC0R8GfCB7ifdanT1LKm3ttDQG9SYWqffgurq2IUC6pdlthJaGoiNTRiqpHr2Qs6gnLzcXJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(2616005)(38100700002)(66446008)(66476007)(66556008)(478600001)(66946007)(76116006)(64756008)(4326008)(91956017)(186003)(6486002)(6506007)(558084003)(6636002)(6512007)(26005)(36756003)(86362001)(316002)(8676002)(54906003)(71200400001)(110136005)(2906002)(4001150100001)(122000001)(82960400001)(8936002)(41300700001)(7416002)(7406005)(38070700005)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXVhVFdDUTg5UTE0Q09yZzc1Y1VYeGRzWDd6aHg0ZW9ua3prZUtZbWhzUFhY?=
 =?utf-8?B?b1BCMG5DUllvODlGQTJIWkQ4bVlvR0tpUGFwaENCWTJrMkNKVnMxdDJmOWNL?=
 =?utf-8?B?M3pXa3V4YWNJN2VWQ0RCLzc3dnl3NTZFVzRQQWcyWDN4T2NKQWYxeXVmVWl4?=
 =?utf-8?B?WlBab0hNZ1loUmN4N0MvMHdFaHFrQkhXejg1Si82QUE2TGNIY3dMSkliSG9J?=
 =?utf-8?B?UWthZjVCeU9zaW1UeVVuRjZIbDcxTHVVbUhQb2Z1alZIL0w4alRJV25lMzda?=
 =?utf-8?B?UnFkWXVMTWhGNGhXMWJKSWxHeXdiZ0RxZXUwZXBZZ1Rnd29Qenl3Z1NnS0d5?=
 =?utf-8?B?ckpSMTh3UHZtN1BVUzcxWDZzaXo4S3granpKakY2RFo5YmZxM3c1YmZUUmc0?=
 =?utf-8?B?NTFmcVlWOGcvRTBqUUVQZmJlUEMrb3VKWGFtQm9rUTBCMHNaU2RkY1hlaTY4?=
 =?utf-8?B?TitIZGtUWWxPODBxRlp5VFJqdndZdjZTRzhONVVYT01vUUh0dmdMc253ci85?=
 =?utf-8?B?M25XTW9ZeTJrb2IrZithLys1cmFURVNIR0xOR1JmdkF5SE8yMXA5cmFjeTVY?=
 =?utf-8?B?OHc3NFlBdmIrQWNyWXp3dzd4WFBoM3k4SEJKWGFGTFVtOThRTTlQTjZjRVQw?=
 =?utf-8?B?R05wVVJ5bmZBMnNwYjcrdGEvU25BNHFLZGluVVlIMmh3bUFlUU5lU21lUzQv?=
 =?utf-8?B?ZWRRWit1bzZSanNlOGJBUTFGT3JHWVcxeUJLVStFVFp6dEs1NWRMUENlU0ZR?=
 =?utf-8?B?cFJERkpUOVRkY0ZWUUdFcVc5ZkdkSkh4U20xMmVIUUxJT2FmR2NRazl0Sm9M?=
 =?utf-8?B?RHpmckljMnNmRThDN25sbTRKSFZjUlRlOEhNelcrMWtFdHpPZ2ZvUXk1QU9w?=
 =?utf-8?B?N1IvQ0ZRR21USmxxczE3aWwyZFYrWnUvQ2VDS1d0bG12dUhLcXNHZEUxODlq?=
 =?utf-8?B?dlM1MlVFWmNnVmFBbHByN2dnN2pIYkt0eFhRdWFEMGhCTk5ZZmhCYUVxZnhJ?=
 =?utf-8?B?UExxb29oMDBlUkZmNWZyaGIyVXhRMXppakR3UCtuTVpxakd5aW1OenVnenJW?=
 =?utf-8?B?L1pvcHV3cFdOcTZGMEQxcDNoQ3VnK3dDdkdWc0xLTzZVeGVxeVVXbWhKUFdS?=
 =?utf-8?B?azV1T3Y3SUd0U3lYbmdWeU00V1lLdUVHQjZLeFRsdE4wTzhoNDlzNWphdzUx?=
 =?utf-8?B?TjQ0aXk2emdPeWpDVkt6M1ZUUmpybkpoWnpuc0RPYnlqMWdsTmVJdzNKQkpT?=
 =?utf-8?B?S2o0am5IMHAwbVkzbXd6bDVvSGt6QkhRUjJ3ZGtrMjE5bUNzMGVYWnNDa1Z3?=
 =?utf-8?B?ZCtsTzF2bUFURCtPUmV0RXkyVGhmTTVRanVtVUtRbzcyNTVsTzF1ZG1FWHFT?=
 =?utf-8?B?SFVpMlRIa0pxaG9acnByK1hPNHY1TGphNURUbEUzOWlxdVp1WEp2WWZmMkVj?=
 =?utf-8?B?SFAwMEVtR3lsRS93TDUvSzQ4WlZMOTNSNDlOR25FQ0h0RjMrQmZ0akZOOGUw?=
 =?utf-8?B?ZW12eVExc3ZTREJFVmVXZjQwY2MyWW1oS0Y5Mzc2WXBNSEVBVCtNK21uQkY5?=
 =?utf-8?B?SC9NeU5jT1g0UW5NUjJBU1h5SXM2WEl4Tk1RVjErVW1ycmszRHkvRS9URnVI?=
 =?utf-8?B?ZkMrMnkzb0FFdFg4WDljZGdFSUcrcS93U0cyUzJWeTB6aXFPcjU0ODVYOTZZ?=
 =?utf-8?B?TGxwSGpQb3JaSEQrWkVib1ZJeGdpSGswOHBSTVREV0FNUGFKbXc4NmM4citL?=
 =?utf-8?B?RlZGYzZrUUZmZy9maktQL0ZJOUFaNlNsNFJuTmF5KzNnbFpWV3duSERkampG?=
 =?utf-8?B?ek1HNndRcGRmd2FaMUJHUnZTWjBJMmNPVGpoZ25xam5aOXN1ci9sNFRWQTVX?=
 =?utf-8?B?WHVKYXBqNTJRR2ZGRVd0d0RrSnJRM29JOVhjbnF4UXg4WmEyUkcyU05iQitB?=
 =?utf-8?B?OUpMVFdUcnVCaEF4SnVRdE9HcUpKa2l2U0JpWWlyRHlBRWlLSVZMOWk2c2Vv?=
 =?utf-8?B?K0VFRGJvdUx2QlZ4QTlhUVN1aVNvRjg0TDdCN2phTmJ4ZFhmbncyZU1Yazdj?=
 =?utf-8?B?WUFHOG00QU05OVlXbGFKS3NocVluZCtnQkJKbE9CVHBZekwwQU1pc2FXbzZH?=
 =?utf-8?B?ZDRPSmFjWTV1Z0d0bkQ2SHQ3QWZTNHA5bkZpWnpFUXFOSjNucXNsbURDY3k5?=
 =?utf-8?Q?eFb6UJ3kcHR3wvTzSlwHnTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B35116EBBD4F24D8B4D089D7F38607E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b90c413-6e93-450d-daaa-08dac9892b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:20:19.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfQdIWl65xPNW1Wv0xafCvctVz/Elp5xJDDZdvQsbvXVoj+hlBDNBYWc9IrLnCiNn4ieQUlCUaMu4nyd9lMg4sEYs7dNnPs0xrQFZbYs0fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTE3IGF0IDE1OjE0ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gQWxzbywgd3RoIGlzIGFuIGluZmVyaW9yIGNhbGw/DQoNCkkgdGhpbmsgaXQncyB0aGUgR0RC
IGZ1bmN0aW9uYWxpdHkgdG8gbWFrZSBhIGNhbGwgaW4gdGhlIHByb2Nlc3MgYmVpbmcNCmRlYnVn
Z2VkLiBTbyBpZiB5b3Ugd2FudCB0byBjYWxsIHNvbWV0aGluZyB3aXRob3V0IGFuIGVuZGJyYW5j
aCBJDQpndWVzcy4NCg==
