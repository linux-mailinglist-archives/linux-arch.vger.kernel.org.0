Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6804E652A94
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 01:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiLUApO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 19:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLUApM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 19:45:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8AA1FF80;
        Tue, 20 Dec 2022 16:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671583511; x=1703119511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PTL5wgAOAWVX1XUZ0WCXfZ76HYekQb0vXA+EF6Gv8rQ=;
  b=D/CQzMz2QMvF2ChTwyLG5nVPjLKrtWPV7XPOrTnfMUYoz7AgPS3etdsX
   19paWjrqMJLAg/0817DMf7/ocGbsnSnygDMETa6ThzNlhE31wfjeMDsMO
   xYZjylFxu8yNrrOkK1VIYXBpm/sV2QBALKQLtytezJmWuoJDkXdv+5UhF
   9JfjvKGrNPNQwb35DY/xV09WeAgDsRtTn+WhCLHWdm0iepSnbcJr7d3dp
   AqTtZWVy12bEqaVZwAs72zzicx2I8WgKyA0ibLF09i4Gkq7oqm4mm/9eH
   NOhe6eDx+kYQB5wjESNgTp29A8JRerKo1UETep82l9Qal7t8Sfgr1x56b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="307435055"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="307435055"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 16:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896679622"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="896679622"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2022 16:45:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 16:45:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 16:45:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 16:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noqEkdMe5ZPBUNz+tvtF0AXjRbx82uUjWYa5Xscit4fpjsa3cQP4lmY/MU3DbQNiwVFbYmqMXr7i76o6zt1vcc7hfill3Sbykq4lSGYezUitapEJwYI6v+U/7T4fhENrUHaR7gknP+ytjP7pP++4H2R4ydZSNIMEIJZ+FxBp+5guRQ6V36WW7y46XumHsru4K9VBj3Nzce4KxX6J8IUKIp9qt4spM0/cMP2DX5pjGvfYOkXyWVRPBAStBlmW1HUGDUy17J1/EFdN3t2BZOjFdCc7Wi9y5gmT8SPzxQTBEJfQeksPDQbSTC3PUm5WK2epKwNFauwHSgRwlmXKLE5u8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTL5wgAOAWVX1XUZ0WCXfZ76HYekQb0vXA+EF6Gv8rQ=;
 b=aTPq7DwUcZL5R3fKSL9d8BvVxnl1oJOkfDq35hsQySxT2jZkG03UjrXfcRlk+iv9Jst8EtOVQdj6+GLC4fbxnlIzZFIoFDSalr5FAAvWhdw4vk30HSY+q+BLwN2HmNw7ZFl/JwfWavMLG8rJgNhIDNCZTIIW9v/MxcCZkEuYmlgcMdb52LcCc6EVXjEJm/ekMcQVGeOF0Ks3xo1UwmcP6dVWSLd95r+VB5VPmrK0uCuC4irFBZpaC57ZvdhP2epuOh3n6tx95mkUpseZPw8W3cw8LMxrJC6eKO2rZL17YwPiCO0fEFsNIdVEpau7AeL1caLwjS2g9i1DPuMT39SXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 00:45:05 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 00:45:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v4 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHZBq9ZBci4Y1E6ok+dC4f6YB5Fea53ZtaAgAA2t4A=
Date:   Wed, 21 Dec 2022 00:45:04 +0000
Message-ID: <3e9e675c4f24adb5f96165081d04f9fd035d1c2b.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-11-rick.p.edgecombe@intel.com>
         <Y6IpKb6pPvYy43NO@zn.tnic>
In-Reply-To: <Y6IpKb6pPvYy43NO@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: 905e70db-fe3a-4b07-c005-08dae2ec99b2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKZ0536FwPKu6SKpkXlYlexPQrqgaUTCB2jtX/2UcQMKLQI3XeTVjxHsSGOshjtOm4WSmB+QwQYVRPvvUUbl83byPuMhITRkThzjLTBPgCGYRX7EWoVT3drFvHndbzO5jMqsqPqTvqKDK0npNL8LO1PEVNOIIVbRZ1Y4sugoDMhKZPVQwJ9ESxCiGAEQEOeHwGq8Lh+tB7GK7SvFDAH3Hyj6T//xqLrhR6puksxq9UgGW5jLat+pfyVsqodhMKuHTOp+OhZFCFykc/udtboNC2F4p8dzx+dF3fFSVkK5hVaMA5bM51xZHGO1LXQGX4MxMgRYqvGWZHJfBSDXowjCIpi3ec6HZVPPWOPvJSFrm0i9Ic9Qn3fXDVHAyqdAJsoEMBHuwpSdQEYJMHj95P6Ck2YTbYXSM8pqNvHbRSnuEKQHbcKOgAhOuxVtH7j0gID2VFmuuIq82ro/0+RA8F4Yoqp7aNxhmFKYYBl0W5Px17UPE0iFb4VKGKAuadNn3MNedTC4UOv0W4IfeJZRR0Tfyu378KcTydvmCNdwD7PsAAFGSfKt6kDURQ3zktA2GxK9mbIlLQy1VYtYfwcgiwYhpySqD/joKq4TvYr9ZFtIWa/9bOKzw32gumxD+c/WHGXR2G9IYm3zuMYw8sIfC7tYtk/L6tHWH4RBQ8Zy7/tPrH9KKq1jzFiSrOTUnWDtFtbq0cSXuCS3ZZtsrDcvBhF2UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(8936002)(38100700002)(83380400001)(6486002)(71200400001)(36756003)(6506007)(4001150100001)(41300700001)(54906003)(2906002)(478600001)(26005)(186003)(122000001)(5660300002)(6916009)(6512007)(316002)(7406005)(8676002)(7416002)(4326008)(2616005)(66446008)(91956017)(64756008)(86362001)(66946007)(76116006)(82960400001)(66556008)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21iMTJRZlppbGw2Qk4zUXlkY0JBYURZT0R4L05BRVhKbU9hSWxrWmhKQWdz?=
 =?utf-8?B?UWdWRXVmZUhDZ210Y3dBTlduZjY0bzB0Q0VqcHJLNjU1MG0vVXRxNExEM25J?=
 =?utf-8?B?cFJ3MzFINnorMHQ2ZmJmQjZVS2tuSUdxMHZuSmZQb2w4cFUrTC9PQ09ybTlk?=
 =?utf-8?B?dmszS3hIbkdHdmpLVUpha0dxbUtEbE43SEcrQldxa21VNkdmZUJYOWN5Z2c0?=
 =?utf-8?B?a3FTOThRamNTYloxWFVEOEdYc0VHOTFwVTJpS1g0aS82bTM5UDZUZXRVa3Ni?=
 =?utf-8?B?MVF6WFZYU1R3Y1VETXF3QnBEVVoyMy9VVFZyekhGK0xCWTNMdXhPWFhxTEtJ?=
 =?utf-8?B?NU82QmRVNjBDY1YwbjE5bTFaUnc5S1Nlc01iZmE1QUVybmZwTzVmcU56djVp?=
 =?utf-8?B?Qzd6TjQ4QlN3YTdpTEpvMEg5cnFmSmhjVzdUNTlNdjlBSCtFblVhTmJJMXdC?=
 =?utf-8?B?M1lUVHlTTlVQbFRUYkU4WUhPdWhPenI5Zk5nZkIwNUhiWnphRVBuK3FQK29n?=
 =?utf-8?B?VmZPcVhBbDhZU3NNbVBuUU9MbmIzcjQwazVwTC96bk5hMExDZEJWS25jZGJX?=
 =?utf-8?B?Tm5RUlcxWTlxemxaWGRlVzNzaFFUeHh1Y1ZhQ2NJUTArK1pvWnlIdXBUZEpS?=
 =?utf-8?B?MlAxV2lHbFJiR1BiVHNLT25GUFY4K1lHN0cxNHdzZkJTaXV2bEEvOXh5ZlVO?=
 =?utf-8?B?eXgxN2hDbjB3V3BwUGhHdS9Lc0NrdHBHUFdDaHlHWm5sWm5mWnhKOXhFN3RQ?=
 =?utf-8?B?aVFhckM1R3J1cHZrSmkySGNqUXNWc3loM1I1TVkxYTJTZ1ZXT25tNENrdXFm?=
 =?utf-8?B?N01xZ2ttUXE3SnplcDY0ak5SMmlyQ1c0Mjc2QXJpYjl1cFFqdFJsdkdxY2lk?=
 =?utf-8?B?NFMzWWxaSWlzUDBXdzZTM0F3VkdRbjI0Z1lZNUtBSkZqaGVvY3o5Rkc1SkNq?=
 =?utf-8?B?c2hySHRsNzllSVdtbXRxSFYrOWJqeHVlYlJUZjcwMzFta3R4K2NyaUJLbXNo?=
 =?utf-8?B?Y0JRWk9Gc3pXc0hKdzNwVXJwcEM5cm9BY0ZCUHdEZm5BWFRWTDFCSXo2KzVy?=
 =?utf-8?B?YiszY1lVYWtrMk4yb2Y0VmJnVFgxVXRkN2lGaVhPNTVJdVlQMGlGZXZ0Q0w0?=
 =?utf-8?B?M2F4QTlTM3J6YU1pMmRKZnVRSVZVQVRiY1AzaXBndnNtVm5iNWwyL01YbE95?=
 =?utf-8?B?SFRhVlJnN1I0dlFvK2dSNVZMZUZiT2NHTjJ4aDlyU3IrK0pHRU1wa3RMc28v?=
 =?utf-8?B?Ujg0bCtqd2VOUGJIaVdzK3dybmVTMW1FQnJOLzhUOFJXT0hRVGpPUndDRjc5?=
 =?utf-8?B?ZndVc2tVVEFvWWMrQ1lJdThMOUtZNktoTHh1aENmd0tUcEwvMVliQXoyYnZ4?=
 =?utf-8?B?VFMwcW9mcCtRbzNIQXMwU21wSVg5UEIrbVNoWDU1WnJmUlpnbEM2SDQvK0ZS?=
 =?utf-8?B?MjRrUVdhKzRlN0ZkckRvQU5yZzZ6SzZhT01EVkVMMURZN1Qycy83MHFOOGhp?=
 =?utf-8?B?eGYvSStvVWcrSzJYRnRTckVQMmJSWVczaFhERzNDTFQ4SUtZVStxUW5tRDZG?=
 =?utf-8?B?WDBTZmZhVndlZGNybnhENFp2QVp5TFEvSU1TaFhmY0R5UzcxaU5IejA0VEF4?=
 =?utf-8?B?cExqSWdzekwzQ1M0cC9wRUhOU00xOU43UklEd0t0dTRBN2lwNnZmcDJmOWhH?=
 =?utf-8?B?RkJSUVB4K1ZoM2N5dXZCRGZ1ak14b3ZqcUI3MmJDOXJmUXFpdk1idzFRKytM?=
 =?utf-8?B?RjRGenowT093ekZIVlY1TUxjdEpkNGxUL09TWWxjMGNhVnBGZkc1ZEFqeVpU?=
 =?utf-8?B?OW9uMndkNVBhOXlUaENmWTJ0bDJLd045MzhVbitGeS9RTDZZcmE2bytPWmpx?=
 =?utf-8?B?RlF3andTbDczejBZcTBLVjlJUWJhNHBoRlFUNHRaZzFlKzBFQUg3Mkd1OGdl?=
 =?utf-8?B?dklSUGRmZTlYazNiNXc3eXl2N3BrWnBQNHZPTFFtdXp0M09jeDZTOEc0WjN5?=
 =?utf-8?B?Uytycmx6Yjl4RGFyQXlEK3hGdWM3ZUdKMHd5TlNlMy8xb3V5SlVRYjUvVVhW?=
 =?utf-8?B?SGdFc0IvSGdueHZJcmtqWFN4bHFXenZ3b01mK3ViUHhYYmYwNU1RelJhSW5n?=
 =?utf-8?B?WkVGamNnYlFmMVRUKy9SdFRkMVZscUc4SUd6QVBFZUkrdUJVVWxCU3NIWEl3?=
 =?utf-8?Q?avPb3NTrqx9zzt+oPDv0nhY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B65E2761A64664CBBB674C6BAE5BCB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905e70db-fe3a-4b07-c005-08dae2ec99b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 00:45:04.4665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqxCM7ehU9ZB5h/852iEnjoYtgzlQwnhHp5rtYaMd8QpUMAbKGIFxoRlDy4PixMEhi4HdKqSpYLjH6Gcx3K7C8zMlI46//N/dXus4q6qfAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
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

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDIyOjI5ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjM3UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSBzaXggYml0cyBsZWZ0IGF2YWlsYWJsZSB0byBzb2Z0
d2FyZSBpbiB0aGUgNjQtYml0IFBURQ0KPiA+IGFmdGVyDQo+ID4gY29uc3VtaW5nIGEgYml0IGZv
ciBfUEFHRV9DT1cuIE5vIHNwYWNlIGlzIGNvbnN1bWVkIGluIDMyLWJpdA0KPiA+IGtlcm5lbHMN
Cj4gPiBiZWNhdXNlIHNoYWRvdyBzdGFja3MgYXJlIG5vdCBlbmFibGVkIHRoZXJlLg0KPiA+IA0K
PiA+IFRoaXMgaXMgYSBwcmVwcmF0b3J5IHBhdGNoLiBDaGFuZ2VzIHRvIGFjdHVhbGx5IHN0YXJ0
IG1hcmtpbmcNCj4gPiBfUEFHRV9DT1cNCj4gDQo+IFVua25vd24gd29yZCBbcHJlcHJhdG9yeV0g
aW4gY29tbWl0IG1lc3NhZ2UuDQo+IFN1Z2dlc3Rpb25zOiBbJ3ByZXBhcmF0b3J5JywNCg0KU29y
cnkgYWJvdXQgYWxsIHRoZXNlIHNwZWxsaW5nIGVycm9ycy4NCg0KPiANCj4gPiB3aWxsIGZvbGxv
dyBvbmNlIG90aGVyIHBpZWNlcyBhcmUgaW4gcGxhY2UuDQo+IA0KPiBBbmQgcmVnYXJkbGVzcywg
eW91IGRvbid0IHJlYWxseSBuZWVkIHRoaXMgc2VudGVuY2UgYXQgYWxsLCBBRkFJQ1QuDQo+IA0K
PiAuLi4NCg0KT2suDQoNCj4gDQo+ID4gKy8qDQo+ID4gKyAqIE5vcm1hbGx5IENPVyBtZW1vcnkg
Y2FuIHJlc3VsdCBpbiBEaXJ0eT0xLFdyaXRlPTAgUFRzLiBCdXQgaW4NCj4gPiB0aGUgY2FzZQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Xl5eDQo+IA0KPiBQVEVzLg0KDQpUaGFua3MuDQoNCj4gDQo+ID4gKyAqIG9mIFg4Nl9GRUFUVVJF
X1VTRVJfU0hTVEssIHRoZSBzb2Z0d2FyZSBDT1cgYml0IGlzIHVzZWQsIHNpbmNlDQo+ID4gdGhl
DQo+ID4gKyAqIERpcnR5PTEsV3JpdGU9MCB3aWxsIHJlc3VsdCBpbiB0aGUgbWVtb3J5IGJlaW5n
IHRyZWF0ZWQgYXMNCj4gPiBzaGFvZHcgc3RhY2sNCj4gPiArICogYnkgdGhlIEhXLiBTbyB3aGVu
IGNyZWF0aW5nIENPVyBtZW1vcnksIGEgc29mdHdhcmUgYml0IGlzIHVzZWQNCj4gPiArICogX1BB
R0VfQklUX0NPVy4gVGhlIGZvbGxvd2luZyBmdW5jdGlvbnMgcHRlX21rY293KCkgYW5kDQo+ID4g
cHRlX2NsZWFyX2NvdygpDQo+ID4gKyAqIHRha2UgYSBQVEUgbWFya2VkIGNvbnZlbnRpYWxseSBD
T1cgKERpcnR5PTEpIGFuZCB0cmFuc2l0aW9uIGl0DQo+ID4gdG8gdGhlDQo+IA0KPiBVbmtub3du
IHdvcmQgW2NvbnZlbnRpYWxseV0gaW4gY29tbWVudC4NCj4gU3VnZ2VzdGlvbnM6IFsnY29udmVu
dGlvbmFsbHknLCAuLi4NCj4gDQo+ID4gKyAqIHNoYWRvdyBzdGFjayBjb21wYXRpYmxlIHZlcnNp
b24gb2YgQ09XIChDb3c9MSkuDQo+ID4gKyAqLw0KPiA+ICsNCj4gDQo+IF4gU3VwZXJmbHVvdXMg
bmV3bGluZS4NCg0KVGhhbmtzLg0KDQo+IA0KPiA+ICtzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZV9t
a2NvdyhwdGVfdCBwdGUpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWNwdV9mZWF0
dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfVVNFUl9TSFNUSykpDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBwdGU7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHB0
ZSA9IHB0ZV9jbGVhcl9mbGFncyhwdGUsIF9QQUdFX0RJUlRZKTsNCj4gPiArwqDCoMKgwqDCoMKg
wqByZXR1cm4gcHRlX3NldF9mbGFncyhwdGUsIF9QQUdFX0NPVyk7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbmxpbmUgcHRlX3QgcHRlX2NsZWFyX2NvdyhwdGVfdCBwdGUpDQo+ID4gK3sN
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIF9QQUdFX0NPVyBp
cyB1bm5lY2Vzc2FyeSBvbiAhWDg2X0ZFQVRVUkVfVVNFUl9TSFNUSw0KPiA+IGtlcm5lbHMuDQo+
IA0KPiBJJ20gZ3Vlc3NpbmcgdGhpcyAidW5uZWNlc3NhcnkiIGlzIHN1cHBvc2VkIHRvIG1lYW4g
dGhhdCBvbiBrZXJuZWxzDQo+IG5vdA0KPiBzdXBwb3J0aW5nIHNoYWRvdyBzdGFjaywgYSBDT1cg
cGFnZSB1c2VzIHRoZSBvbGQgYml0IGZsYWdzPw0KPiANCj4gSS5lLiwgRGlydHk9MSxXcml0ZT0w
Pw0KPiANCj4gTWlnaHQgYXMgd2VsbCB3cml0ZSBpdCB0aGlzIHdheSB0byBiZSBwZXJmZWN0bHkg
Y2xlYXIuDQoNClJpZ2h0LCBJIGNhbiBjbGFyaWZ5Lg0KDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDC
oCAqIFNlZSB0aGUgX1BBR0VfQ09XIGRlZmluaXRpb24gZm9yIG1vcmUgZGV0YWlscy4NCj4gPiAr
wqDCoMKgwqDCoMKgwqAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfVVNFUl9TSFNUSykpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBwdGU7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4g
K8KgwqDCoMKgwqDCoMKgICogUFRFIGlzIGdldHRpbmcgY29waWVkLW9uLXdyaXRlLCBzbyBpdCB3
aWxsIGJlIGRpcnRpZWQNCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBpZiB3cml0YWJsZSwgb3IgbWFk
ZSBzaGFkb3cgc3RhY2sgaWYgc2hhZG93IHN0YWNrIGFuZA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IGJlaW5nIGNvcGllZCBvbiBhY2Nlc3MuIFNldCB0aGV5IGRpcnR5IGJpdCBmb3IgYm90aA0KPiAN
Cj4gIlNldCB0aGUgZGlydHkgYml0Li4iDQoNCk9vZi4NCg0KPiANCj4gPiArwqDCoMKgwqDCoMKg
wqAgKiBjYXNlcy4NCj4gPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqBw
dGUgPSBwdGVfc2V0X2ZsYWdzKHB0ZSwgX1BBR0VfRElSVFkpOw0KPiA+ICvCoMKgwqDCoMKgwqDC
oHJldHVybiBwdGVfY2xlYXJfZmxhZ3MocHRlLCBfUEFHRV9DT1cpOw0KPiA+ICt9DQo+IA0KPiBS
ZXN0IGxvb2tzIG9rLg0KDQpUaGFua3MuDQoNCj4gDQo+IFRoeC4NCj4gDQoNCg==
