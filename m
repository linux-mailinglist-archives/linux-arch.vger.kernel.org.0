Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31B5F3959
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJCWvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJCWvk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:51:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F95A83A;
        Mon,  3 Oct 2022 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664837497; x=1696373497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GDPKbO8FnBvQTpkAPu6IRJmIr2o9UzYMnmQhdoCwaC0=;
  b=FN5expzUv9NwNtkKyyM7gi2aXQJOCZusxMJsqJKlN3AlT0XUNHXpVfv3
   /A2fEaObY8LDg4neSEfCttigtE9q6cgbcQuNtCsgEe3W4zH5lyQKM+bR/
   Q8EEWW1yynFsaUeZQaCiyx+I+JorEd2xhYhNT/EFmhbYgptS7ODON2ZF9
   AcC9YCsaWHWALxpr/kF9TiWzc6hQi5xunfZvXIYr1r+krIL4rRZ30w7DF
   sxoIQwZKYF5w+LpIKFFogw5+GZX3x0EVTMD99UV4DdaOZakavsL+0/w+j
   2hUKsNmSHqOwfeTHORIV1oGp0de+ygr8TP54dJogsNzfbQgpdvQhDg5cl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303739273"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="303739273"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="727983075"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="727983075"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2022 15:51:36 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 15:51:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 15:51:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 15:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvZ39E7PJWwKAd5vMnWmLhVLaL28zJfzWVu9oYIesqMUZGHwAVDq0xKDGgEcN/5O+gFvcSv9slLt67iCAA0Wr++XYtrKgBXtCQPyeDBpYCLPAUjs+oUoeeIEkcRO3wYvGLkcV+PM4v1gu36DYDdQn8Wt1cVqqtfBswIv62WwMH7XmjuZKcrQfqL/fc87LyjIIlY9oW8Hvni7cvCIU/d2DNikaaJ0qjfUplQDgbbps770R4rPJtXv11rn7oKENzmq6QYJfzyAvh9mNdZNqcp+dmV4fp6X1lMP/Fef2cfRAKwFtcoNe0TBY1n2BDfzu+Zt2f50fmRR/jrSYph4N6A7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDPKbO8FnBvQTpkAPu6IRJmIr2o9UzYMnmQhdoCwaC0=;
 b=dM7ITBayXe4kq475mJWnMnG11nOpUJcZW5viCtop9tticV9qmO3KI49VTOBC+9BXr1kCeGGTEzjmqwrKQ7c/D3ENGXu2OdqhIJL66FFxqhLb54H3MlWMz8yP+cIzawklpbKIQhFRZbytUCQw2PdlK/CKJpCgufnADnwbFGUaRlQOe8W5uIbK1XMP+2wdBxKxYKj9f7E2908yfR3joFWZiSAgfgA6sdQy3sf1Qjg9CGRwQLBpqojKx6tLRXzIh4MHyUvc8yb8YyRnRpqgR/evjeRhC3fRa+EB7jKtrVJMZTvIO+6voFPxaxs7JeZL84hGOwR+uMdXqdMhRrm8WXf91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:51:02 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 22:51:02 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Thread-Topic: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Thread-Index: AQHY1FMhBBwtibGlfkiKNuNOGUg8sa39DJOAgAA//oA=
Date:   Mon, 3 Oct 2022 22:51:02 +0000
Message-ID: <8d453bb86cfe45125f2c9f2dba273d1f45d33638.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-24-rick.p.edgecombe@intel.com>
         <202210031141.0E0DE2CAEE@keescook>
In-Reply-To: <202210031141.0E0DE2CAEE@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5276:EE_
x-ms-office365-filtering-correlation-id: 8d5123b7-4529-404d-b45c-08daa591bf1e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 361dtUbk8FPdLUexZpIKyEViRtc+vsOV3aMw6mq49O4m19OgJsn3OtHnBNGZQVEtg+S2P2rz3iS04PfACAZj9X5mjQW/yKnH9mnp1aTWuaX/jk8k8TmI5pJfNq4RZl8FjdC/Zp0oB1uk+rT5XdkfZ1uEbGv5hc4IHl2W0BRwug8ARNgm1MmI7NI0ZULx2Su/3Qizxh95GaHlmrP0sQHYDBHhUMCH0gQ10hvi55QF1Q8yFtFbc2qHhpZJ3JpHvZRRV2TLHIafDie7sz/PoE4+DzOJiS3k/rcFsxA1M29DVNzLGGo4GtuKaSVEQBA3S7k5sB6rs8Hc7F9UcT1bHpDZTV5WGfl2Mzzz8D+DzOowxLQ2U8C4fFxf9TUhxeXn2VdWH3yQozc+uZN5iCVDWUhffH18bKvyj9yxMk/ZavMgAinlxcbnRB0VlC7G6te73W4pjZFVblEzinD7COJSq75AcrZrK4bs3k3HRjSCffDFXkXJcxXwqPjcOuopXoany2aWivXMLXpNlAA5a8ZW2Di0iJpcxLwVgHtAx1Tu3HUIrwqYp+MJMiy+OPindBX/bQYQNJQUDxAup9jyOQdMdBJJIcgzHoUz5LT8mB2Yo4WHG1rs4nMRFsFjKy9Hqo12H9NsN5HN/A1DU4HmLH2J4D7FXI180L7qqTNj72rQm6yay88o+M8Jm29+Tczk/UDHySbQE75CEzytXjcd0K/+1lKNagkMpdcbh6lNse++673sOQDe8lB8NS2WylYliMcgi5fyFSNvPvJh5shzzGzV9GECePg+Zp7/QGC5msfWiI1nTAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(71200400001)(6486002)(478600001)(316002)(82960400001)(6916009)(54906003)(64756008)(66446008)(66476007)(91956017)(8676002)(4326008)(6512007)(122000001)(186003)(38100700002)(41300700001)(6506007)(2616005)(5660300002)(38070700005)(86362001)(7416002)(7406005)(8936002)(36756003)(66946007)(66556008)(76116006)(2906002)(26005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU5kYzhMSklYTldwc2UwVHpEOURhVHdacUdHS2F0akN2RjNkOTlDSGJCbm05?=
 =?utf-8?B?RFp4ZDdsU1E0WnlMKzNha1J4TENBZjkxQmF0OFZtME1oM0w3eGFPemdTWWcx?=
 =?utf-8?B?MWI5R1JYWDBibG9BWFFnOVpNMG9xU0NDNmIvTGFpZzZYdEpxUkQ3QnhOeGV1?=
 =?utf-8?B?MmRMWGV2UXYyUDd1U1l3U0MycXFTU0lhT2RxVkJGdXZ5R25aN3FqWHZIb3p2?=
 =?utf-8?B?MTdwYmVpakVtZEVRYlhpV3UvQUNQYXdKRER3VG5vb3BPZWlQb0xNOGtTMnVV?=
 =?utf-8?B?RHFLTSttNDYyUWxrU1VXeHE5OWlrRFdOcllEM0pUQlVEZGZOU0EyWmFXNzBW?=
 =?utf-8?B?R2E3SGNyWTkyU3VBbTJIbFNsMTUyT0tDanZySnp3d0RPeTd3ZzlhdzNZaGdP?=
 =?utf-8?B?L2N5Y1RRdGVjanRwSkt4cnM5TDNXUFEvaEdNMEtyQjB3RUdXRnNRbTMxYmo0?=
 =?utf-8?B?VWdDMU5LOWF0dVlxbU9xSjRXazBTMGtsRWNXME1TQ2lWWUQ5OXlhRzVsdHY2?=
 =?utf-8?B?OHJIWDBwVk9Kb0NPcGQ3QVhyM3VzTi9zQ3BRdUVWMG5TVWd5eng2alVTcG5E?=
 =?utf-8?B?UXQ3cXhUR05RWDJlRVRhUFV3YVA3TWQ3WVhGRU5DNlo3b284NTFsS3pDKy84?=
 =?utf-8?B?Q1FqcGRyUHk5RVJjR2dmdXBGUndEWEwrL2lySys0NjR6M1Rna0RYczJRTDhq?=
 =?utf-8?B?YkUycmlwU09kdStkdVB5TldPenBBankvS2VMZHJidElKS2NuSzRNK2dKaklW?=
 =?utf-8?B?eDhmUWtwNUdKTUNqV0RCMkc3c0t6QWN3QWRsall2UXNKSXlDWjQrdWVwSGRr?=
 =?utf-8?B?cUZhcmFqeUdJN3MzbUNDZ0Y4TUV5RXRBZjNwU01rang0MHpwSVo5eE9melR5?=
 =?utf-8?B?V3dHYXZPb1Y3Mk5NU1ZKS1lSSFZrbVI3TFVMM1dKcGgvNkRFYXRkdWJJRnQv?=
 =?utf-8?B?dGFDeTdXYndSOVVmMTNrSDRCZWl2cGt2ZWxqeTJPMWVrZS8wcE84d0orRE5v?=
 =?utf-8?B?QWRxZkYvTWtiZUpqQUxKMmNJaEMzUlBpWkRxK08va2l2anRpN2M3QXlGS3Bu?=
 =?utf-8?B?eW1mdVE4czhHeFB1eEtFZmVwL3I3VUpGa3I0MTE2RnhSWWhMSDJDa0lyNk51?=
 =?utf-8?B?bkdKdmFMUG1VeGxOZWlNSXhScDRleHA5RGxaaU4wMHZOeXpjWC9HZUpaQWIx?=
 =?utf-8?B?bGVjdHdOSkI2L3VJV3FUY3RTSCs5Z0svWXpuVlpPSkt1dnR6NEN2b0t0SVUy?=
 =?utf-8?B?NWszVWlhY2VhZWxLcmJvWW1YRVRpaU5iUDRab3VYN3pmQXpHVXZWeW9ObzJK?=
 =?utf-8?B?a0hmR0pXTHZqTHlMVWQ4Y0tpOUtFc2E5Y3FxaDlJRnk5QXJHWWduazI0dFF5?=
 =?utf-8?B?OXU5RzA4bzlRNkg5d2JwTDF1SUs4WHFHR2dta2ZvZVJrTUg0ajFZN1pHQ01v?=
 =?utf-8?B?RnV2N3NwQWg0azhhQTMwSlBVRGJsbG1EYUt2TGJDWnRkMW9zUEVRZFFxMG9L?=
 =?utf-8?B?cm04UWhmNEtFcU56bXJvQk9ML0NZaEJYcVBLSUNTVE1LNUJFSUpNT1J2NmZN?=
 =?utf-8?B?SFZLR1p4QlFEVWFTeFFoaFd0c21MdmZHSTQwNTZxTDB1UVVkWTZGdm41WnBR?=
 =?utf-8?B?b2thQVVnNThTNVVnUEhhWU9pUlNMbnJsdkRBek5sZ00veE15WWxxYm1sb240?=
 =?utf-8?B?U2FIcExMQ1M4QTZITGFjVFlXenVvSlRzMEVJNDhXVys4RXJlaWJrbnJ3ajB4?=
 =?utf-8?B?ZXU0THZiZXJLME5adVo2MHY5VWpaTGEyYjFkMGpPSzltVW9LN3lsRzNucFhw?=
 =?utf-8?B?TlFzVm9OYTFiaGQ1Q09NQmY0ZXVmaE9qTU9zRnVpb0R5ODJUM0VSWFJjdGdz?=
 =?utf-8?B?dkMwN3RzMlJvQ3IwT1dhRDJOc2lSbFRGVG1Fd3oxV1RTUVByWFpnbGFSamhq?=
 =?utf-8?B?TTFRNjhuMXJwQ09QU09WU29sTUlzNHBuS2ZjWWthOHp4Z2sxcGEvRGp2a0kv?=
 =?utf-8?B?ZWJvOHRGYzFoMjlyeDJiam5JMFd4Q2VQbklpam9KVktXdldPN1daNHhqSkYw?=
 =?utf-8?B?Q1UzRmNzZTJ0Z3FMNk1TYi9xOTVyK3BlemtWbHJ0Q3k3R3V2VGZ1Ukp5SEFi?=
 =?utf-8?B?VDgwSkpSUDVHN0xjWmp1M05rZnZOdERrVlVOSE5NWmR0MVFKRTl2MlNjaEV2?=
 =?utf-8?Q?ObAW+JZZnRssGI6UNYu9Iu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C53EA1464BB4145851F9C76111600E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5123b7-4529-404d-b45c-08daa591bf1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 22:51:02.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcHMe0kVt6uLvdlOAus8SDJNK+RPBaq6uyDaWUAM8GQW8JJjpB4X5kf5WU+qzuP3TgwztYobcuK0MIZ1m2bGbD6jNRMgYqAncwGzTpEq4hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
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

Q0MgTWlrZSBhYm91dCBwdHJhY2UvQ1JJVSBxdWVzdGlvbi4NCg0KT24gTW9uLCAyMDIyLTEwLTAz
IGF0IDEyOjAxIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9uIFRodSwgU2VwIDI5LCAyMDIy
IGF0IDAzOjI5OjIwUE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206ICJL
aXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+
IA0KPiA+IEFkZCB0aHJlZSBuZXcgYXJjaF9wcmN0bCgpIGhhbmRsZXM6DQo+ID4gDQo+ID4gIC0g
QVJDSF9DRVRfRU5BQkxFL0RJU0FCTEUgZW5hYmxlcyBvciBkaXNhYmxlcyB0aGUgc3BlY2lmaWVk
DQo+ID4gICAgZmVhdHVyZS4gUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgYW4gZXJyb3IuDQo+ID4g
DQo+ID4gIC0gQVJDSF9DRVRfTE9DSyBwcmV2ZW50cyBmdXR1cmUgZGlzYWJsaW5nIG9yIGVuYWJs
aW5nIG9mIHRoZQ0KPiA+ICAgIHNwZWNpZmllZCBmZWF0dXJlLiBSZXR1cm5zIDAgb24gc3VjY2Vz
cyBvciBhbiBlcnJvcg0KPiA+IA0KPiA+IFRoZSBmZWF0dXJlcyBhcmUgaGFuZGxlZCBwZXItdGhy
ZWFkIGFuZCBpbmhlcml0ZWQgb3Zlcg0KPiA+IGZvcmsoMikvY2xvbmUoMiksDQo+ID4gYnV0IHJl
c2V0IG9uIGV4ZWMoKS4NCj4gPiANCj4gPiBUaGlzIGlzIHByZXBhcmF0aW9uIHBhdGNoLiBJdCBk
b2VzIG5vdCBpbXBlbGVtZW50IGFueSBmZWF0dXJlcy4NCj4gDQo+IHR5cG86ICJpbXBsZW1lbnQi
DQoNCk9vcHMsIHRoYW5rcy4NCg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwg
QS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4gW3R3ZWFr
ZWQgd2l0aCBmZWVkYmFjayBmcm9tIHRnbHhdDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBSaWNrIEVk
Z2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IC0t
LQ0KPiA+IA0KPiA+IHYyOg0KPiA+ICAtIE9ubHkgYWxsb3cgb25lIGVuYWJsZS9kaXNhYmxlIHBl
ciBjYWxsICh0Z2x4KQ0KPiA+ICAtIFJldHVybiBlcnJvciBjb2RlIGxpa2UgYSBub3JtYWwgYXJj
aF9wcmN0bCgpIChBbGV4YW5kZXINCj4gPiBQb3RhcGVua28pDQo+ID4gIC0gTWFrZSBDRVQgb25s
eSAodGdseCkNCj4gPiANCj4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vY2V0LmggICAgICAgIHwg
MjAgKysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3Iu
aCAgfCAgMyArKysNCj4gPiAgYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9wcmN0bC5oIHwgIDYg
KysrKysNCj4gPiAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyAgICAgICAgIHwgIDQgKysrKw0K
PiA+ICBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jICAgICAgfCAgNSArKystDQo+ID4gIGFy
Y2gveDg2L2tlcm5lbC9zaHN0ay5jICAgICAgICAgICB8IDM4DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICA2IGZpbGVzIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2luY2x1ZGUv
YXNtL2NldC5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni9rZXJuZWwvc2hzdGsu
Yw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jZXQuaA0KPiA+
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY2V0LmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMGZhNGRiYzk4YzQ5DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NldC5oDQo+ID4gQEAgLTAsMCArMSwyMCBA
QA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+ICsjaWZu
ZGVmIF9BU01fWDg2X0NFVF9IDQo+ID4gKyNkZWZpbmUgX0FTTV9YODZfQ0VUX0gNCj4gPiArDQo+
ID4gKyNpZm5kZWYgX19BU1NFTUJMWV9fDQo+ID4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
PiA+ICsNCj4gPiArc3RydWN0IHRhc2tfc3RydWN0Ow0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJ
R19YODZfU0hBRE9XX1NUQUNLDQo+ID4gK2xvbmcgY2V0X3ByY3RsKHN0cnVjdCB0YXNrX3N0cnVj
dCAqdGFzaywgaW50IG9wdGlvbiwNCj4gPiArCQkgICAgICB1bnNpZ25lZCBsb25nIGZlYXR1cmVz
KTsNCj4gPiArI2Vsc2UNCj4gPiArc3RhdGljIGlubGluZSBsb25nIGNldF9wcmN0bChzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRhc2ssIGludCBvcHRpb24sDQo+ID4gKwkJICAgICAgdW5zaWduZWQgbG9u
ZyBmZWF0dXJlcykgeyByZXR1cm4gLUVJTlZBTDsgfQ0KPiA+ICsjZW5kaWYgLyogQ09ORklHX1g4
Nl9TSEFET1dfU1RBQ0sgKi8NCj4gPiArDQo+ID4gKyNlbmRpZiAvKiBfX0FTU0VNQkxZX18gKi8N
Cj4gPiArDQo+ID4gKyNlbmRpZiAvKiBfQVNNX1g4Nl9DRVRfSCAqLw0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaA0KPiA+IGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcHJvY2Vzc29yLmgNCj4gPiBpbmRleCAzNTYzMDhjNzM5NTEuLmE5MmJmNzZlZGFmZSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaA0KPiA+ICsr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+ID4gQEAgLTUzMCw2ICs1MzAs
OSBAQCBzdHJ1Y3QgdGhyZWFkX3N0cnVjdCB7DQo+ID4gIAkgKi8NCj4gPiAgCXUzMgkJCXBrcnU7
DQo+ID4gIA0KPiA+ICsJdW5zaWduZWQgbG9uZwkJZmVhdHVyZXM7DQo+ID4gKwl1bnNpZ25lZCBs
b25nCQlmZWF0dXJlc19sb2NrZWQ7DQo+IA0KPiBTaG91bGQgdGhlc2UgYmUgd3JhcHBlZCBpbiAj
aWZkZWYgQ09ORklHX1g4Nl9TSEFET1dfU1RBQ0sgKG9yDQo+IENPTkZJR19YODZfQ0VUKSA/DQo+
IA0KPiBBbHNvLCBqdXN0IG5hbWVkICJmZWF0dXJlcyI/IElzIHRoaXMgZXhwZWN0ZWQgdG8gYmUg
bW9yZSB0aGFuIENFVD8NCg0KU2lnaCwgdGhlcmUgaGF2ZSBiZWVuIG1hbnkgaWRlYXMgYWJvdXQg
aG93IHRoaXMgQVBJIGFuZCBmZWF0dXJlcw0KdHJhY2tpbmcgY291bGQgYmUgc2hhcmVkIHdpdGgg
TEFNLiBBdCBzb21lIHBvaW50IHRoZXJlIHdhcyBzb21lDQpkaXNjdXNzaW9uIGFib3V0IExBTSB1
c2luZyB0aGUgYGZlYXR1cmVzYCBhcyB3ZWxsLCBldmVuIGlmIGl0IGhhZCBhDQpzZXBhcmF0ZSBh
cmNoX3ByY3RsKCkgaW50ZXJmYWNlLiBKdXN0IGNoZWNraW5nIHRoZSBsYXN0IExBTSBwb3N0aW5n
LA0KSSdtIG5vdCBzdXJlIGl0IG5lZWRzIGl0LiBTbyB5ZXMsIHRoaXMgY291bGQgZ28gYmFjayB0
byBiZWluZyBDRVQgb25seQ0KZm9yIHRoZSB0aW1lIGJlaW5nLg0KDQo+IA0KPiA+ICsNCj4gPiAg
CS8qIEZsb2F0aW5nIHBvaW50IGFuZCBleHRlbmRlZCBwcm9jZXNzb3Igc3RhdGUgKi8NCj4gPiAg
CXN0cnVjdCBmcHUJCWZwdTsNCj4gPiAgCS8qDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lu
Y2x1ZGUvdWFwaS9hc20vcHJjdGwuaA0KPiA+IGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9w
cmN0bC5oDQo+ID4gaW5kZXggNTAwYjk2ZTcxZjE4Li4wMjgxNThlMzUyNjkgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9wcmN0bC5oDQo+ID4gKysrIGIvYXJjaC94
ODYvaW5jbHVkZS91YXBpL2FzbS9wcmN0bC5oDQo+ID4gQEAgLTIwLDQgKzIwLDEwIEBADQo+ID4g
ICNkZWZpbmUgQVJDSF9NQVBfVkRTT18zMgkJMHgyMDAyDQo+ID4gICNkZWZpbmUgQVJDSF9NQVBf
VkRTT182NAkJMHgyMDAzDQo+ID4gIA0KPiA+ICsvKiBEb24ndCB1c2UgMHgzMDAxLTB4MzAwNCBi
ZWNhdXNlIG9mIG9sZCBnbGliY3MgKi8NCj4gPiArDQo+ID4gKyNkZWZpbmUgQVJDSF9DRVRfRU5B
QkxFCQkJMHg0MDAxDQo+ID4gKyNkZWZpbmUgQVJDSF9DRVRfRElTQUJMRQkJMHg0MDAyDQo+ID4g
KyNkZWZpbmUgQVJDSF9DRVRfTE9DSwkJCTB4NDAwMw0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9B
U01fWDg2X1BSQ1RMX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nl
c3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gPiBpbmRleCA1OGE2ZWE0NzJkYjku
LjAzNDg4MDMxMWU2YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5j
DQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYw0KPiA+IEBAIC0zNjcsNiArMzY3
LDEwIEBAIHZvaWQgYXJjaF9zZXR1cF9uZXdfZXhlYyh2b2lkKQ0KPiA+ICAJCXRhc2tfY2xlYXJf
c3BlY19zc2Jfbm9leGVjKGN1cnJlbnQpOw0KPiA+ICAJCXNwZWN1bGF0aW9uX2N0cmxfdXBkYXRl
KHJlYWRfdGhyZWFkX2ZsYWdzKCkpOw0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArCS8qIFJlc2V0IHRo
cmVhZCBmZWF0dXJlcyBvbiBleGVjICovDQo+ID4gKwljdXJyZW50LT50aHJlYWQuZmVhdHVyZXMg
PSAwOw0KPiA+ICsJY3VycmVudC0+dGhyZWFkLmZlYXR1cmVzX2xvY2tlZCA9IDA7DQo+IA0KPiBT
YW1lIGlmZGVmIHF1ZXN0aW9uIGhlcmUuDQo+IA0KPiA+ICB9DQo+ID4gIA0KPiA+ICAjaWZkZWYg
Q09ORklHX1g4Nl9JT1BMX0lPUEVSTQ0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
cHJvY2Vzc182NC5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jDQo+ID4gaW5k
ZXggMTk2MjAwOGZlNzQzLi44ZmEyYzJiN2RlNjUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL3Byb2Nlc3NfNjQuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzXzY0
LmMNCj4gPiBAQCAtODI5LDcgKzgyOSwxMCBAQCBsb25nIGRvX2FyY2hfcHJjdGxfNjQoc3RydWN0
IHRhc2tfc3RydWN0DQo+ID4gKnRhc2ssIGludCBvcHRpb24sIHVuc2lnbmVkIGxvbmcgYXJnMikN
Cj4gPiAgCWNhc2UgQVJDSF9NQVBfVkRTT182NDoNCj4gPiAgCQlyZXR1cm4gcHJjdGxfbWFwX3Zk
c28oJnZkc29faW1hZ2VfNjQsIGFyZzIpOw0KPiA+ICAjZW5kaWYNCj4gPiAtDQo+ID4gKwljYXNl
IEFSQ0hfQ0VUX0VOQUJMRToNCj4gPiArCWNhc2UgQVJDSF9DRVRfRElTQUJMRToNCj4gPiArCWNh
c2UgQVJDSF9DRVRfTE9DSzoNCj4gPiArCQlyZXR1cm4gY2V0X3ByY3RsKHRhc2ssIG9wdGlvbiwg
YXJnMik7DQo+ID4gIAlkZWZhdWx0Og0KPiA+ICAJCXJldCA9IC1FSU5WQUw7DQo+ID4gIAkJYnJl
YWs7DQo+IA0KPiBJIHJlbWFpbiBhbm5veWVkIHRoYXQgcHJjdGwgaW50ZXJmYWNlcyBkaWRuJ3Qg
dXNlIC1FTk9UU1VQIGZvcg0KPiAidW5rbm93bg0KPiBvcHRpb24iLiA6UA0KPiANCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsu
Yw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5lMzI3
NmFjOWU5YjkNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3No
c3RrLmMNCj4gDQo+IEkgdGhpbmsgdGhlIE1ha2VmaWxlIGFkZGl0aW9uIHNob3VsZCBiZSBtb3Zl
ZCBmcm9tICJ4ODYvY2V0L3Noc3RrOg0KPiBBZGQgdXNlci1tb2RlIHNoYWRvdyBzdGFjayBzdXBw
b3J0IiB0byBoZXJlLCB5ZXM/IE90aGVyd2lzZSwgdGhlcmUgaXMNCj4gYQ0KPiBiaXNlY3RhYmls
aXR5IHJhbmRjb25maWctd2l0aC1DT05GSUdfWDg2X1NIQURPV19TVEFDSyByaXNrIGhlcmUNCj4g
KG5vdGhpbmcNCj4gd2lsbCBpbXBsZW1lbnQgImNldF9wcmN0bCIpLg0KDQpPaCwgeWVwLCBnb29k
IHBvaW50Lg0KDQo+IA0KPiA+IEBAIC0wLDAgKzEsMzggQEANCj4gPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogc2hzdGsuYyAtIEludGVsIHNo
YWRvdyBzdGFjayBzdXBwb3J0DQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMSwg
SW50ZWwgQ29ycG9yYXRpb24uDQo+ID4gKyAqIFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRl
bC5jb20+DQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9wcmN0bC5o
Pg0KPiA+ICsNCj4gPiArbG9uZyBjZXRfcHJjdGwoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBp
bnQgb3B0aW9uLCB1bnNpZ25lZCBsb25nDQo+ID4gZmVhdHVyZXMpDQo+ID4gK3sNCj4gPiArCWlm
IChvcHRpb24gPT0gQVJDSF9DRVRfTE9DSykgew0KPiA+ICsJCXRhc2stPnRocmVhZC5mZWF0dXJl
c19sb2NrZWQgfD0gZmVhdHVyZXM7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJLyogRG9uJ3QgYWxsb3cgdmlhIHB0cmFjZSAqLw0KPiA+ICsJaWYgKHRhc2sgIT0gY3Vy
cmVudCkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IC4uLiBidXQgbG9ja2luZyBfaXNf
IGFsbG93ZWQgdmlhIHB0cmFjZT8gSWYgdGhhdCBpbnRlbmRlZCwgaXQgc2hvdWxkDQo+IGJlDQo+
IGV4cGxpY2l0bHkgbWVudGlvbmVkIGluIHRoZSBjb21taXQgbG9nIGFuZCBpbiBhIGNvbW1lbnQg
aGVyZS4NCg0KSSBiZWxpZXZlIENSSVUgbmVlZHMgdG8gbG9jayB2aWEgcHRyYWNlIGFzIHdlbGwu
IE1heWJlIE1pa2UgY2FuDQpjb25maXJtLg0KDQpJIGNhbiBtZW50aW9uIGl0Lg0KDQo+IA0KPiBB
bHNvLCBwZXJoYXBzIC1FU1JDSCA/DQo+IA0KPiA+ICsNCj4gPiArCS8qIERvIG5vdCBhbGxvdyB0
byBjaGFuZ2UgbG9ja2VkIGZlYXR1cmVzICovDQo+ID4gKwlpZiAoZmVhdHVyZXMgJiB0YXNrLT50
aHJlYWQuZmVhdHVyZXNfbG9ja2VkKQ0KPiA+ICsJCXJldHVybiAtRVBFUk07DQo+ID4gKw0KPiA+
ICsJLyogT25seSBzdXBwb3J0IGVuYWJsaW5nL2Rpc2FibGluZyBvbmUgZmVhdHVyZSBhdCBhIHRp
bWUuICovDQo+ID4gKwlpZiAoaHdlaWdodF9sb25nKGZlYXR1cmVzKSA+IDEpDQo+ID4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+IA0KPiBQZXJoYXBzIC1FMkJJRyA/DQoNCkVoaCwgSSBkb24ndCBrbm93
LiBFMk1VQ0ggbWF5YmUuIEl0J3Mgbm90IG5lY2Vzc2FyaWx5IHRvbyBiaWcuIExpa2UgaWYNCmEg
dGhpcmQgYml0IHdhcyBhZGRlZCBmb3IgSUJUIHNvbWUgZGF5LCB5b3UgY291bGQgc2V0IFNIU1RL
IGFuZCBXUlNTLA0KaXQgd291bGQgYmUgaW52YWxpZCwgYnV0IHN0aWxsIGJlICJsZXNzIiB0aGFu
IHRoZSB2YWxpZCBwYXNzaW5nIG9mIGp1c3QNCnRoZSAoaHlwb3RoZXRpY2FsIElCVCBiaXQpLg0K
DQo+IA0KPiA+ICsJaWYgKG9wdGlvbiA9PSBBUkNIX0NFVF9ESVNBQkxFKSB7DQo+ID4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogSGFuZGxlIEFSQ0hfQ0VUX0VO
QUJMRSAqLw0KPiA+ICsJcmV0dXJuIC1FSU5WQUw7DQo+ID4gK30NCj4gPiAtLSANCj4gPiAyLjE3
LjENCj4gPiANCj4gDQo+IA0K
