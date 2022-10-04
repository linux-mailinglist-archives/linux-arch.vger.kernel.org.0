Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75A85F4C48
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJDW4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJDW4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 18:56:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3823BDF;
        Tue,  4 Oct 2022 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664924197; x=1696460197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sBKKjFkVkwzqgbsy/1aBPkAAHIB8Qx9h0FUpH0XkxZI=;
  b=IzYIofB4UWf3t0dwcwNuDHyPkCwLqNctspqri/NYW3lqU2yg9wq2K3fy
   tlO5PhjomxRrke3YtRJY/P+ug7lGHzeyANK3yW3Wwp5ujHmhHrHuYzWOX
   jmOmNBxPvbM+pBxSqeQWuBXqLdXwGfLrgoug1lGG9VmBLIrKMfXJIPOwb
   i65oj/z63hCt+/kWj3vTsKqpMZP6pAipUzc7I70C/iUaiEOSUyERQjmXt
   3RH0Y/lT3UoWws2wUwyJrCM/ejA8bo0A47vJ19hoAUdOweiXH6U3Ybu1I
   cj87x7OKnKZQ9uT3uFanY7BDCPju6MSHCNX9E8jIUtzOEwzeVeqTf6c8s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="329457186"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="329457186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 15:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="657318591"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="657318591"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2022 15:56:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:56:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 15:56:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 15:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIUYEJvGAvLdd3n2O63HymDlawzCT3yBUpMLijxndNP62Glin4MayWFmgRicOI3vyoalRl8cPEhsgQUYdldVZmNXmofLimRjw/HkonCcOw/iQkYNFPm+DRF4iSS08GXCfyKvjX4hDhxfXCD16z6zwRQ06biMHXh90oiz+PXfrCkOv7Y/ZYidn+2SUjqbYdtCALfFSW2gpmMntd7qw+t7ao1X4b5hZ4HwbIE1YNmnki3xT2b7xkE27vQOaREtAVPc03I2Pu5KC2CucDGjwVx9spLJH8utnQtvDPFs2/uQuERB33vSiORFeq+7QrdbfAhhsoL3RDK2PDjoPcBF4e5crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBKKjFkVkwzqgbsy/1aBPkAAHIB8Qx9h0FUpH0XkxZI=;
 b=VdudoCSQF7EJvD3q6ZtAYB8nwK8H01epnAXycF1htNTH4+nReaz/WAGOfWF6Ggp6lx35vfwmFKYqwcQNLOZHX7lyEPTqvHtgiiz42Uvnd8E4qmEQml/i6aGrU0FIkoKJ5NbLTGZLTb4mVVZrevsrOxhs88cgRFyYNgONZ6fQPdfw8GTr9hcvpwZ5DJJHSQx7i1NrIcZssNigj11rpKILrxbvLTHTkF3FhGdEyYvXUSV29ltghOSwUY94VUaMrrLfKYJ7U72MKgdMpm5hyDocrD+wC2mCZJe+FN+2hkRGtlBdyCNVCP5MedmKGQOmAEMeDHJzkJdAKdG5QgpHKDm2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 22:56:27 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 22:56:27 +0000
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
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack
 syscall
Thread-Topic: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack
 syscall
Thread-Index: AQHY1FMi8rsI6jI+g0WVLzW/66vOoa39RPsAgAGbbgA=
Date:   Tue, 4 Oct 2022 22:56:27 +0000
Message-ID: <fd227d72e0c2251f97ff3fd0ed50fd5f8d19c8b8.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-29-rick.p.edgecombe@intel.com>
         <202210031446.E4AD9EE66@keescook>
In-Reply-To: <202210031446.E4AD9EE66@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW3PR11MB4764:EE_
x-ms-office365-filtering-correlation-id: a4710af9-78dd-4b19-5ba8-08daa65bab31
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcR2JeLOePK36m3nxd/q/NSUaUz+AWFw9osncAUgEtOOVuifwWrmcZ0drI6hGdpBxiZigWhTADZq7DCFtgRNDyM+dAwGWPU+m0/VKSIKwLHQNcYAQRP80pKBM3NL/nla4TiORkv2aoENvDNsZ89Lpz4yd1igdhqtMjJmfpVB5iYD+jYyXG61gyRAlNb+LBxf6FTNsDiSG866vARhctbJH/UFwla7cBomj6czyn9AIM/XzuQEkh4+0CfUefClyRg3Uc5AoeYM57D/5NOFodIi0AMm99fSUKN1i2hthM9bXzH5EQt1sKcA4nbUlxXyXDuOlyhmyXvcSAH8wh13uuQqMnOQjioAGUXG1ozf+eaK9u7HmRuLW950pt2cnzxKCyNQfVofw2ruoabu5tvyQcOfJss9jYu1mRoR4w7DrA9IUEOVyMCQ32ERgpIKiNtjKejXmjFZox6b/LaCC6bjwGmc7E5TBUZhGm4t862FWwI9KCOGz7Nk8cY62R3+xzcRodoM41SlAMBY3gCuRj5NpJmuhEggKm6/hQQw68dfFPT2vKlX9zlRKuuPn2UqNmIvBS1xW5J2o9mJyTlWYpM6Aut7o5Lb9e3JNn/NEM1eG7K22KR0tdGR4zj5++K6xAcEtMFam5Bo57RFkWhCRX3Wav5ZqBrfmpEzxbejknq++NOVcbJ8I7HHKcpyuoeVgDDywGc/kscPvU+DKe8FhkSGo57ArQTV4ikI9m3UPFdD6KU7MPZHfSO9wFehGO/DTiFDk80uRgt39viP7iVLXpdvXW7UQPwZrFx6KnysAvqtvCLL6M840AozGPQJt4eOLNCAXDVZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(316002)(478600001)(6916009)(54906003)(6506007)(83380400001)(36756003)(66946007)(4326008)(8676002)(91956017)(66446008)(64756008)(5660300002)(66476007)(66556008)(7416002)(6512007)(7406005)(26005)(86362001)(8936002)(76116006)(41300700001)(82960400001)(71200400001)(2906002)(2616005)(186003)(38070700005)(38100700002)(6486002)(966005)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjB1ZlhwanFxcC9QUitZbWY4OTRqNnBKNExsSUxVRWdTWUlEWWhJcE9vckJD?=
 =?utf-8?B?eUFMTzZiRXZSNkhwL2pHYjJKK1hPNVVXU0JzZDhsRDkrb2pEeU5GZENqVzZ5?=
 =?utf-8?B?QkFUaktaT0JnKzlDVDh0dFIrSzRMM0p4ZDlvVVBqMmZ0dUZockVrRUk4eWZm?=
 =?utf-8?B?aUh6cFZVMjdyZDlodGhqV3hKeWlzL3NhaFppZlI5ODhrblJ0VnEzand5UUto?=
 =?utf-8?B?ZE5ZVDdCUTVqMUNwRTErWmRQMlhiV0wzbkV6VXA3TGoxOXQ4cThaZ1Z4VGEv?=
 =?utf-8?B?VkJxZkovYUozbnJQbXVwN2ZzOVFUTE1EdGxoeTdTRXJPT1U3UmQrdGNTQVBl?=
 =?utf-8?B?T3E0aWJHUVVzQlYvczQxdnFQZkdEZTN5em9CaGQ2dm1yWklmVHJtZHhOcDM1?=
 =?utf-8?B?MVFST05kRG9YV2NTRU1QOVE5UGwxY2g1Q3h3MWhGb2VDZlMxZy9sTU9LRU12?=
 =?utf-8?B?QWhrcjZ6Yko3cndRMnI3N2psa1VXR0FQd2VDNXJxMWZoS2xtS0VsVlpJSGRa?=
 =?utf-8?B?OGdhRlJHazEzdE5PdWUwb0dPREgrMHM1Q0tVa2M0Nm51aXdpWFdDby8yd1Jq?=
 =?utf-8?B?Z0xaUWpFYWlDWWxaSmNGMDlIZmROc3o5b2xiUWlvRXEyeW1TcTJsbjNnVDBq?=
 =?utf-8?B?K0tRd0FRdWhCZ1NRWUIvTkJ4cXd1bFpwd3FNT2tJcVBVU3dBM3Y5UlZBZ243?=
 =?utf-8?B?YXlreUF4REhMS0xGTTZIM3M0UkQzWXpXSDlWdkJoazlzSVU0SVdXeld3Nm55?=
 =?utf-8?B?Vmg1R2pMVW1CUUwxbGZRUlFXNFRLYlQxZFpnRStCTzFDSWVtTnM0d0lxMGZk?=
 =?utf-8?B?TU50RGtMTzYwQ2tPcHo1VlpUYWh0b3lYbWRLSE1aNHpYbGFHTEVEcXl3NjR2?=
 =?utf-8?B?RVRiOWp6WXdSZFBpT1R4ZU5ZZmtkdkVhS09kT1Y3QVJ5M3pwQW1zaUxIZGQw?=
 =?utf-8?B?RWtCc0w2NXJRRFZkRU1ERnQwQkxsZDJmeUd5RHZ3WTdURVJyMVlxdWR0WmI1?=
 =?utf-8?B?MnFNa0JLUU45WGc2VlJROW9ZbE9VMEJYRTNiWUt4S2YxdFRXb0RadmUveHdj?=
 =?utf-8?B?R1plU3k0SkM1WG1UbXhPSDlwQjh3VTVOeWdEUlZHV2UwZTBPTTcwWi9iR2o3?=
 =?utf-8?B?akg5VjJUdC9sSnlqTEN2bEdCSmVjMm8rM1FWMUI2UWc0alVTMm1NOW0xejd1?=
 =?utf-8?B?My80WW5ZUUIyRU54U0FqbXliRHd2YmpiWExrQzNyTWFvMW0veWdhTzdKTGFR?=
 =?utf-8?B?UVloaStkZElIWGFFQ1g2OENkaW9mdXp1TTFVeWtBY2s2dzB0WlJocmIwWUgr?=
 =?utf-8?B?YVFtQ0cyMzk5S0JPQ05lRFZxSDVoUlN0RWk1QmozaS9sYmNWeWdXbVhSVmlN?=
 =?utf-8?B?d0Nwc2lnRDNHdUdYQytWTys5V1JoMjRmb0JBNENNRGFkT3ZxaUxtT05sOXVv?=
 =?utf-8?B?RHl4K2NYVG9oTlQ0VEhtVTZjUThRcTBUUlpYTUVWNlA4M1kyWjBBVVJsZDBs?=
 =?utf-8?B?TGtSSHVnZHp1UEQ3MStyUlluazJ3c2tycmpLME5PTjZHN252SFR2TDAxUTNO?=
 =?utf-8?B?S0tacFU3Tys4ZS9tS0hYMnlGTXp6aXZFcTF4OUkxb0lpcDRhNHZOQUVTTFhn?=
 =?utf-8?B?UHJpY2picTVGSW1lQ2wreHlSRWRBUDQrQXBzYnZ3djJvZVc1aVhsY1E1RUVm?=
 =?utf-8?B?WUI3eGF0OVRGVUdYb3V5aXBYQ2llUk14eEZKVkZxeTRjM0tMK3VUSTl1TlhZ?=
 =?utf-8?B?YXBoR0dsWmI1Y3MrOUgvcWp1NUxVT3l0bXhhRUorZGF4SUwrYlFNbUZwbUFP?=
 =?utf-8?B?Rlp3OHFRb0tRV2ZnMllOM1ROSXRMbEk0VVVDaHowNzR5ZFVQSEtFQlhwVjdm?=
 =?utf-8?B?Z3ZPa3pkWjhoNmJBTnVYd1NXQ2lTd0lDOXM5bER3SEVxenY3aGpPNFNYWmFh?=
 =?utf-8?B?MmFBYms4MUhzSEd2U0tCVmlYMEFDN1JVMTR2aWpQNWYvcHBZcEdDM0l4YTFi?=
 =?utf-8?B?ZnkwN0JXTkJjN0lER3Y3ajJZTzI5UnBMYUgxM0swb3EvU3krQU1QMlhWY2Vr?=
 =?utf-8?B?dG1KVXFCUFVDNmFzbkNkNzgvQWpoSHkwTGg0M2lsdnhHSE1lSS9SWkNmbE9G?=
 =?utf-8?B?WHArNS9pTmNLTnFLaktHVlA0NXdhUGxVUXRNWnFVNEFDb1ZuQWpDRzBZVERW?=
 =?utf-8?Q?epar/or+esSHkuJf3uBpFNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF18886F27F1C44A06DAAE53B76BD6B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4710af9-78dd-4b19-5ba8-08daa65bab31
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 22:56:27.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpQsUH1A8/+DkIV+hP2psgdas/7gWhd2+0RoeD/5uauXZ7eqcaAhiGkfefRDyL6mdjSWQY0w6UJlE9iXeBqtAlGJ2Uhi8DtBWi1CLRpEh+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4764
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE1OjIzIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjI1UE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFsuLi5dDQo+ID4gVGhlIGZvbGxvd2luZyBleGFtcGxlIGRlbW9uc3RyYXRlcyBo
b3cgdG8gY3JlYXRlIGEgbmV3IHNoYWRvdyBzdGFjaw0KPiA+IHdpdGgNCj4gPiBtYXBfc2hhZG93
X3N0YWNrOg0KPiA+IHZvaWQgKnNoc3RrID0gbWFwX3NoYWRvd19zdGFjayhhZHJyLCBzdGFja19z
aXplLA0KPiA+IFNIQURPV19TVEFDS19TRVRfVE9LRU4pOw0KPiANCj4gdHlwbzogYWRkcg0KDQpZ
ZXAsIHRoYW5rcy4NCg0KDQo+IA0KPiA+IFsuLi5dDQo+ID4gKzQ1MQljb21tb24JbWFwX3NoYWRv
d19zdGFjawlzeXNfbWFwX3NoYWRvd19zdGFjDQo+ID4gaw0KPiANCj4gSXNuJ3QgdGhpcyAiNjQi
LCBub3QgImNvbW1vbiI/DQoNClllcywgdGhpcyBzaG91bGQgaGF2ZSBiZWVuIGNoYW5nZWQgYWZ0
ZXIgZHJvcHBpbmcgMzIgYml0Lg0KDQo+IA0KPiA+IFsuLi5dDQo+ID4gKyNkZWZpbmUgU0hBRE9X
X1NUQUNLX1NFVF9UT0tFTgkweDEJLyogU2V0IHVwIGEgcmVzdG9yZSB0b2tlbg0KPiA+IGluIHRo
ZSBzaGFkb3cgc3RhY2sgKi8NCj4gDQo+IEkgdGhpbmsgdGhpcyBzaG91bGQgZ2V0IGFuIGludHJv
IGNvbW1lbnQsIGxpa2U6DQo+IA0KPiAvKiBGbGFncyBmb3IgbWFwX3NoYWRvd19zdGFjaygyKSAq
Lw0KPiANCj4gQWxzbywgYXMgd2l0aCB0aGUgb3RoZXIgVUFQSSBmaWVsZHMsIHBsZWFzZSB1c2Ug
IigxVUxMIDw8IDApIiBoZXJlLg0KDQpPay4NCg0KPiANCj4gPiBAQCAtNjIsMjQgKzYzLDM0IEBA
IHN0YXRpYyBpbnQgY3JlYXRlX3JzdG9yX3Rva2VuKHVuc2lnbmVkIGxvbmcNCj4gPiBzc3AsIHVu
c2lnbmVkIGxvbmcgKnRva2VuX2FkZHIpDQo+ID4gIAlpZiAod3JpdGVfdXNlcl9zaHN0a182NCgo
dTY0IF9fdXNlciAqKWFkZHIsICh1NjQpc3NwKSkNCj4gPiAgCQlyZXR1cm4gLUVGQVVMVDsNCj4g
PiAgDQo+ID4gLQkqdG9rZW5fYWRkciA9IGFkZHI7DQo+ID4gKwlpZiAodG9rZW5fYWRkcikNCj4g
PiArCQkqdG9rZW5fYWRkciA9IGFkZHI7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPiAgDQo+IA0KPiBDYW4gdGhpcyBqdXN0IGJlIGNvbGxhcHNlZCBpbnRvIHRoZSBwYXRjaCB0
aGF0IGludHJvZHVjZXMNCj4gY3JlYXRlX3JzdG9yX3Rva2VuKCk/DQoNCkkgbWVhbiwgeWVhLCB0
aGF0IHdvdWxkIGJlIHNpbXBsZXIuIEJyZWFraW5nIHRoZSBjaGFuZ2VzIGFwYXJ0IHdhcyBsZWZ0
DQpvdmVyIGZyb20gd2hlbiB0aGUgc2lnbmFscyBwbGFjZWQgYSB0b2tlbiwgYnV0IGRpZG4ndCBu
ZWVkIHRoaXMgZXh0cmENCmJpdCBvZiBmdW5jdGlvbmFsaXR5Lg0KDQo+IA0KPiA+IC1zdGF0aWMg
dW5zaWduZWQgbG9uZyBhbGxvY19zaHN0ayh1bnNpZ25lZCBsb25nIHNpemUpDQo+ID4gK3N0YXRp
YyB1bnNpZ25lZCBsb25nIGFsbG9jX3Noc3RrKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQg
bG9uZw0KPiA+IHNpemUsDQo+ID4gKwkJCQkgdW5zaWduZWQgbG9uZyB0b2tlbl9vZmZzZXQsIGJv
b2wNCj4gPiBzZXRfcmVzX3RvaykNCj4gPiAgew0KPiA+ICAJaW50IGZsYWdzID0gTUFQX0FOT05Z
TU9VUyB8IE1BUF9QUklWQVRFOw0KPiA+ICAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50
LT5tbTsNCj4gPiAtCXVuc2lnbmVkIGxvbmcgYWRkciwgdW51c2VkOw0KPiA+ICsJdW5zaWduZWQg
bG9uZyBtYXBwZWRfYWRkciwgdW51c2VkOw0KPiA+ICANCj4gPiAgCW1tYXBfd3JpdGVfbG9jayht
bSk7DQo+ID4gLQlhZGRyID0gZG9fbW1hcChOVUxMLCBhZGRyLCBzaXplLCBQUk9UX1JFQUQsIGZs
YWdzLA0KPiANCj4gT29wcywgSSBtaXNzZWQgaW4gdGhlIG90aGVyIHBhdGNoIHRoYXQgImFkZHIi
IHdhcyBiZWluZyBwYXNzZWQgaGVyZS4NCj4gKHVuaW5pdGlhbGl6ZWQ/KQ0KDQpBcmdoLCB5ZXMu
IEknbGwgaW5pdGlhbGl6ZSBpbiB0aGF0IHBhdGNoIGFuZCByZW1vdmUgaXQgaGVyZS4NCg0KPiAN
Cj4gPiAtCQkgICAgICAgVk1fU0hBRE9XX1NUQUNLIHwgVk1fV1JJVEUsIDAsICZ1bnVzZWQsIE5V
TEwpOw0KPiA+IC0NCj4gPiArCW1hcHBlZF9hZGRyID0gZG9fbW1hcChOVUxMLCBhZGRyLCBzaXpl
LCBQUk9UX1JFQUQsIGZsYWdzLA0KPiA+ICsJCQkgICAgICBWTV9TSEFET1dfU1RBQ0sgfCBWTV9X
UklURSwgMCwgJnVudXNlZCwNCj4gPiBOVUxMKTsNCj4gDQo+IEkgZG9uJ3Qgc2VlIGRvX21tYXAo
KSBkb2luZyBhbnl0aGluZyBoZXJlIHRvIGF2b2lkIHJlbWFwcGluZyBhIHByaW9yDQo+IHZtYQ0K
PiBhcyBzaHN0ay4gSXMgdGhlIGludGVudGlvbiB0byBhbGxvdyB1c2Vyc3BhY2UgdG8gY29udmVy
dCBleGlzdGluZw0KPiBWTUFzPw0KPiBUaGlzIGhhcyBjYXVzZWQgcGFpbiBpbiB0aGUgcGFzdCwg
cGVyaGFwcyBmb3JjZSBNQVBfRklYRURfTk9SRVBMQUNFID8NCg0KTm8gdGhhdCBpcyBub3QgdGhl
IGludGVudGlvbi4gSXQgc2hvdWxkIGZhaWwgYW5kIE1BUF9GSVhFRF9OT1JFUExBQ0UNCmxvb2tz
IGxpa2UgaXQgd2lsbCBmaXQgdGhlIGJpbGwuIFRoYW5rcyENCg0KPiANCj4gPiBbLi4uXQ0KPiA+
IEBAIC0xNzQsNiArMTg1LDcgQEAgaW50IHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1Y3Qg
dGFza19zdHJ1Y3QNCj4gPiAqdHNrLCB1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLA0KPiA+ICAN
Cj4gPiAgDQo+ID4gIAlzdGFja19zaXplID0gUEFHRV9BTElHTihzdGFja19zaXplKTsNCj4gPiAr
CWFkZHIgPSBhbGxvY19zaHN0aygwLCBzdGFja19zaXplLCAwLCBmYWxzZSk7DQo+ID4gIAlpZiAo
SVNfRVJSX1ZBTFVFKGFkZHIpKQ0KPiA+ICAJCXJldHVybiBQVFJfRVJSKCh2b2lkICopYWRkcik7
DQo+ID4gIA0KPiANCj4gQXMgbWVudGlvbmVkIGVhcmxpZXIsIEkgd2FzIGV4cGVjdGluZyB0aGlz
IHBhdGNoIHRvIHJlcGxhY2UgYQ0KPiAobWlzc2luZykNCj4gY2FsbCB0byBhbGxvY19zaHN0ay4g
aS5lLiBleHBlY3Rpbmc6DQo+IA0KPiAtCWFkZHIgPSBhbGxvY19zaHN0ayhzdGFja19zaXplKTsN
Cj4gDQo+ID4gQEAgLTM5NSw2ICs0MDcsMjYgQEAgaW50IHNoc3RrX2Rpc2FibGUodm9pZCkNCj4g
PiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICsNCj4gPiArU1lTQ0FMTF9ERUZJTkUz
KG1hcF9zaGFkb3dfc3RhY2ssIHVuc2lnbmVkIGxvbmcsIGFkZHIsIHVuc2lnbmVkDQo+ID4gbG9u
Zywgc2l6ZSwgdW5zaWduZWQgaW50LCBmbGFncykNCj4gDQo+IFBsZWFzZSBhZGQga2Vybi1kb2Mg
Zm9yIHRoaXMsIHdpdGggc29tZSBub3Rlcy4gRS5nLiBhdCBsZWFzdCBvbmUNCj4gdGhpbmcgaXNu
J3QgaW1tZWRpYXRlbHkNCj4gb2J2aW91cywgbWF5YmUgbW9yZTogImFkZHIiIG11c3QgYmUgYSBt
dWx0aXBsZSBvZiA4Lg0KDQpPay4NCg0KPiANCj4gPiArew0KPiA+ICsJdW5zaWduZWQgbG9uZyBh
bGlnbmVkX3NpemU7DQo+ID4gKw0KPiA+ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9G
RUFUVVJFX1NIU1RLKSkNCj4gPiArCQlyZXR1cm4gLUVOT1NZUzsNCj4gDQo+IFRoaXMgbmVlZHMg
dG8gZXhwbGljaXRseSByZWplY3QgdW5rbm93biBmbGFnc1sxXSwgb3IgZXhwYW5kaW5nIHRoZW0N
Cj4gaW4gdGhlDQo+IGZ1dHVyZSBiZWNvbWVzIHZlcnkgcGFpbmZ1bDoNCj4gDQo+IAlpZiAoZmxh
Z3MgJiB+KFNIQURPV19TVEFDS19TRVRfVE9LRU4pKQ0KPiAJCXJldHVybiAtRUlOVkFMOw0KPiAN
Cj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9hZGRpbmctc3lz
Y2FsbHMuaHRtbCNkZXNpZ25pbmctdGhlLWFwaS1wbGFubmluZy1mb3ItZXh0ZW5zaW9uDQo+IA0K
DQpPaywgZ29vZCBpZGVhLg0KDQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIEFuIG92ZXJmbG93
IHdvdWxkIHJlc3VsdCBpbiBhdHRlbXB0aW5nIHRvIHdyaXRlIHRoZSByZXN0b3JlDQo+ID4gdG9r
ZW4NCj4gPiArCSAqIHRvIHRoZSB3cm9uZyBsb2NhdGlvbi4gTm90IGNhdGFzdHJvcGhpYywgYnV0
IGp1c3QgcmV0dXJuIHRoZQ0KPiA+IHJpZ2h0DQo+ID4gKwkgKiBlcnJvciBjb2RlIGFuZCBibG9j
ayBpdC4NCj4gPiArCSAqLw0KPiA+ICsJYWxpZ25lZF9zaXplID0gUEFHRV9BTElHTihzaXplKTsN
Cj4gPiArCWlmIChhbGlnbmVkX3NpemUgPCBzaXplKQ0KPiA+ICsJCXJldHVybiAtRU9WRVJGTE9X
Ow0KPiANCj4gVGhlIGludGVudGlvbiBoZXJlIGlzIHRvIGFsbG93IHVzZXJzcGFjZSB0byBhc2sg
Zm9yIF9sZXNzXyB0aGFuIGENCj4gcGFnZQ0KPiBzaXplIG11bHRpcGxlLCBhbmQgdG8gcHV0IHRo
ZSByZXN0b3JlIHRva2VuIHRoZXJlPw0KPiANCj4gSXMgaXQgd29ydGggYWRkaW5nIGEgY2hlY2sg
Zm9yIHNpemUgPj0gOCBoZXJlPyBPciwgSSBndWVzcyBpdCB3b3VsZA0KPiBqdXN0DQo+IGltbWVk
aWF0ZWx5IGNyYXNoIG9uIHRoZSBuZXh0IGNhbGw/DQoNCkZ1bm55IHlvdSBzaG91bGQgYXNrLi4u
IFRoZSBnbGliYyBjaGFuZ2VzIHdlcmUgZG9pbmcgdGhpcyBhbmQgdGhlbg0KbG9va2luZyBmb3Ig
dGhlIHRva2VuIGF0IHRoZSBlbmQgb2YgdGhlIGxlbmd0aCB0aGF0IGl0IHBhc3NlZCAobm90IHRo
ZQ0KcGFnZSBhbGlnbmVkIGxlbmd0aCkuIEkgaGFkIGNoYW5nZWQgdGhlIGtlcm5lbCBhdCBvbmUg
cG9pbnQgdG8gYmUgcGFnZQ0KYWxpZ25lZCBhbmQgdGhlbiBoYWQgdGhlIGZ1biBvZiBkZWJ1Z2dp
bmcgdGhlIHJlc3VsdHMuIEkgdGhvdWdodCwgZ2xpYmMNCiBpcyBqdXN0IHdhc3Rpbmcgc2hhZG93
IHN0YWNrLiBJdCBzaG91bGQgYXNrIGZvciBwYWdlIGFsaWduZWQgc2hhZG93DQpzdGFja3MuIEJ1
dCBISiBhcmd1ZWQgdGhhdCB0aGUga2VybmVsIHNob3VsZG4ndCBzZWNvbmQgZ3Vlc3Mgd2hhdA0K
dXNlcnNwYWNlIGlzIGFza2luZyBmb3IgYmFzZWQgb24gSFcgcGFnZSBzaXplIGRldGFpbHMgdGhh
dCBkb24ndCBoYXZlDQp0byBkbyB3aXRoIHRoZSBzb2Z0d2FyZSBpbnRlcmZhY2UuIEkgd2FzIGNv
bnZpbmNlZCBieSB0aGF0IGFyZ3VtZW50LA0KZXZlbiB0aG91Z2ggZ2xpYmMgaXMgc3RpbGwgd2Fz
dGluZyBzcGFjZS4NCg0KSSBjb3VsZCBzdGlsbCBiZSBjb252aW5jZWQgdGhlIG90aGVyIHdheSB0
aG91Z2guIEdsaWJjIHN0aWxsIGhhcyB0aW1lDQp0byAoYW5kIHNob3VsZCkgY2hhbmdlLiBCdXQg
eWVhLCB0aGF0IHdhcyBhY3R1YWxseSB0aGUgaW50ZW50aW9uLg0KDQo+IA0KPiA+ICsNCj4gPiAr
CXJldHVybiBhbGxvY19zaHN0ayhhZGRyLCBhbGlnbmVkX3NpemUsIHNpemUsIGZsYWdzICYNCj4g
PiBTSEFET1dfU1RBQ0tfU0VUX1RPS0VOKTsNCj4gPiArfQ0KPiANCj4gDQo=
