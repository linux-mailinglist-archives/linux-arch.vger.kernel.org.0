Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB55F1676
	for <lists+linux-arch@lfdr.de>; Sat,  1 Oct 2022 01:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiI3XE3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3XE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 19:04:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137F1D8F17;
        Fri, 30 Sep 2022 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664579065; x=1696115065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vLw3GKgU8I1tsNXyROLZWrBnpZh3tsm+4/KB3wrE12g=;
  b=gV7ruJWEEMoRTOBjp2sCyWCClJpqnsfFFByOEhTP6qgxVIDdj2mBfuuF
   sU/AYD8aRdMiXMwDI7+uBoGXvlxaodQEv05HWfU/OE3f/3EGtz2sMXPX5
   Uav7L2azv4NKzuDKxBhr3oltbkk1yzpo2kGuufrn6cXsO2dXxxWv1t/h/
   LdSHuxOSUzIqF+lw9neiVTjw0oyRRVZW7jc0P1EYbRmo/N9kYMwhUAT7F
   GIxITRUjBAmj6mX9YZlTLp/99MSsaDwfGfIP4gnGFuP53Ya84H+grPEsX
   HXM6AcBC5B0SWsY+rgDDenlWZ1X5AOi718NcZucWNNcdAHiLPOFY8Fm/a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="302287684"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="302287684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 16:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="765291711"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="765291711"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2022 16:04:25 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 16:04:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 16:04:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 16:04:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 16:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaxamF4QyAxiQVmyk/w4moUnkFb1H6ppfE0gWivUjFQO1MzsFUI/MAMW5NNJ3WjS38hSqNOHWa/w7qAumKDw2N+VTohFKuczIegRNjzwSGmPq8FW8LFH+j2D4wWT/eHw8+eONrgEniBJrUTfnO3lweKTNLvTj05d7a08M4eY1Z5cT0fDNfn/GzRtVF7wB5vC03Rjb90pvHSZxyV1yZlgG8/gqwS4uF4njQ6x3rlMUfF8ZeAsUZFyJvUHIcIenohWpLW9OwFxWznWNvfoWPIMV4U3dBnSpgk7Uxn6XdpR/T6Doo373dgPlxxEH6ZM6Dl+lKNCm6/ZMPzy0nK0O8+XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLw3GKgU8I1tsNXyROLZWrBnpZh3tsm+4/KB3wrE12g=;
 b=ahFvWEeJPS2tacAYCkNR5dmidtva/76yy8jtj6ZKuyKYqWhALjC4UXADgvI/LfA+QVYgpOhrafe2Xi6AeGyJjURhdQuhfnmYQMzdoe4EQabpD05Wkzyh8NSBfcVWu80NZUaSPZBb0tTKF1zo3TqgOvwOJlx23e818Muyve5zTnCcjhpkqLekzfBxtoPDD8HBSW7Cw1nhe0TRMZxJ+2o9xpsmIpTbuG2WsjJoA8gqH210FdGv4D3aN+/ngiWOrmh7ZQNbZ0BbftfIPZRTxSBogR4kfXqdhY4vSWiGB/sVvL8se8jEv6TjlINe0Hyk6RGj0uh7zBOail1MAJRrZ0zXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 23:04:16 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 23:04:16 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
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
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHY1FMhyDNj1/XJr0mpEcU+bucxPK34WbiAgAA+lgCAAAD3gA==
Date:   Fri, 30 Sep 2022 23:04:16 +0000
Message-ID: <bf4ffda00542b05f7e19073847835464e8227aa5.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-23-rick.p.edgecombe@intel.com>
         <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
         <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
In-Reply-To: <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY5PR11MB6437:EE_
x-ms-office365-filtering-correlation-id: 8b357d74-b523-479b-46ff-08daa338196f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFKqBMmUAJ1c/BeQUDBefIJvQ5ARyGlle9r8p8VYEVBUGiV83a3Fu15koHEkVFy/KTeGoYpmWHYBOI+9tNAniZAty99GrErp34bHnd/piA491f3Gr4ot6IlTMcD/qX1g0oBoPJJfe7nfixP+903LdxH+cDtHglwKWJCc1hlfnkO0YNwXBmwMtAn6Mp67eZC3y2vrCGUJII7hc3p2pEnpmD/Kiv9FNdheQetunm3dvZK11EjDqc5gBlJztEkZ/UEEfkMuhIOx7W8QKZKbzg0NQnjM5Isaga3EZZ5E6Gr6/qMDwJ9gdoXJV2gKbKxiAi6PA86vwKGTMbGjXVIxd1es0nPQFwzX+EdxX6/hkJTTENT/5+qRckuCQE3NCszS/QZKfMgnfdblQvfYtiqcvoj4lI1FS4T0xRM2BGdRTVlFPbZBKSaN5m5J1DrxWtOjnfWuYL/HMbxisf71NcM6dYAJtKbq4W86+GS+Hg7Ti/nbcuWhUyE8aZwQOCWGzwbuydZGMIeicCR7KsdSRjNxY+7fyVALENCC5NZeUqp8kHZXboh22TTw0f+JierKWW9WlLZUxNiDQzq35H9HTdP29Ne0llQ3lrbXlaPS2L07RTqg8cvBBTJHVt50v1hmCMRGlgwUBvaG+OYRi/v9Ig1FURKYL09uC6t6G7wwodGlTg3+b5MT84ptahMWJkpRsTGaqz44lpt3le7yzCZguFcY28+5EO4XXUjTrGYH7Fh01v3Nd0F+ooDo6LkAYENugZff+QWyjeF4lGlRUbQrDED8Kn3RwUsbZ+vaZC0PG0NTZoTvUc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(36756003)(110136005)(54906003)(86362001)(38070700005)(122000001)(7416002)(7406005)(6636002)(83380400001)(186003)(2616005)(66556008)(66476007)(38100700002)(82960400001)(26005)(53546011)(71200400001)(316002)(478600001)(76116006)(66946007)(66446008)(8676002)(64756008)(4326008)(6486002)(6506007)(6512007)(2906002)(41300700001)(8936002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnlXdkVESjJmTXFFdlFGZER6ZW1oK0hTNnA3OUtUN0dVcjN0UHE2V2VBbmUy?=
 =?utf-8?B?UjNhaGxpN01kTXFFNUpMM3o4ZVBXdFRSR29aR3B3OXhua0FSY1VzOUR1ZWFk?=
 =?utf-8?B?VXVKMGtaczdjNDhQYXlyTmxRRHRNOTVxZjVMczhTdWtMVjd5Z0h1UHdqZnVB?=
 =?utf-8?B?L2t6TlIwTFd6MnNpUm9mWjhNWXNZUFN6MGxqTExCRzJ0WkFYblRXUnlRdHZ1?=
 =?utf-8?B?M0Zac1NsUjd5NGhOSE5CUDYrU0MxU2lDalR1UDdybWxCeFFkOS9qd3RRWmFP?=
 =?utf-8?B?WTJUTUFFQzAwOUF5aCthLzVQMHdvOHJZb1Y4RUVTSFRaMitMazJ5N1JFM1VL?=
 =?utf-8?B?dTFtUGRUSVU4V0NXZGJwZi9OSzdVbWI5dWF3a1hpaWR3eHIwMmdJcndkNnVu?=
 =?utf-8?B?VmZVbVlOaU9Od21jamRIUjNUZlkzZ1NYOTllRVI3Skh0N0tqMm5XMTltR2p2?=
 =?utf-8?B?b3YxK0o0Y1RMMkMzOFlBdXozZXpTTHVsZnY1ZHhINU81RVh5S0FsREM1Wkpa?=
 =?utf-8?B?TFlvUy84Q0RWNk5ub0JKSHVZVkRTemxLZ2JjVkZSN255aUxLRk4xWThUbVVY?=
 =?utf-8?B?VU1MS2ZZV0w3WVd0bjdvWWh4aWc0aGdPTHEvbmhGS1dpZVlObWRQdEtJc255?=
 =?utf-8?B?RzdQcnVMcDJFRWNUT0kzWUxOSndVYktMa0FtdkY1R2lOSWZ4aFU3Zzg4TDBN?=
 =?utf-8?B?cU1sMXBIdzJJa3BxRUllamRDdlpYVmNuUjVEdkJIYkV1TkN2bDVZcFBZNHYv?=
 =?utf-8?B?NHF0cFlJakZSV1RrcElQVFREM2pNdUVybHlGYWtTb2JOckRwUy9YbGJNY3E4?=
 =?utf-8?B?bVBja1FITzNvMDhmSTJ4NFJ5NXlvU3BaVnZOaWhuWDVWcG1pREYxZi90eVpB?=
 =?utf-8?B?WXR3YXA1eFpwRHQ0dFBiUFNNeGtobjNhdEw2cSt2SjdJZ20rN1daTEdoZGZ3?=
 =?utf-8?B?RGlZRTdKYVJFNE8yZGNUVysrUm5wWnQ4UWNwaWNrL2xBd3lPd2M1TWwvNlQz?=
 =?utf-8?B?R3Q3WDBzL1lxU0NsYW9PanVSZWZ3SHlGNGdsQ29LVEpmQzRXTmFRUUl1dFhy?=
 =?utf-8?B?SWRaandPMCtFeUlSc242Y2x1UlRDb0d2eFREdEpKRk43VVhBL2Z1TlFkampw?=
 =?utf-8?B?NndUZEZjUDhwZHJYaHBVYStxVEtYRVBGWkQvVGRmM2RyakxvMG5BcVIvdFlL?=
 =?utf-8?B?MmFwbCt2UEV6VVRhbWx5YTJJYzBSSjUwK0l0bnBIb1Z0ZlZWV01rNEIzTmlD?=
 =?utf-8?B?QTMxM1J6TlhEM201c3NVR25aaGJuN1FiSk9QRjRlVHBlaEZIa1NzWEErR0xF?=
 =?utf-8?B?R0RZS2FkT0lXeWdQVmRvK0NCWHhIVFIwYVIvQVg0dTBhWHJnSzgva2pPZkR3?=
 =?utf-8?B?ZDNkd2UrN1doL1hiQitFWWxxb2l1b2tKMXBaaHFMSnpockRrR29qT2tsWjR2?=
 =?utf-8?B?ZGI4ZUJpcDNGUXhaVTg3eWRlNHJVOXJuYnVvOGdXSW9tRWRRalNKZElPbmFD?=
 =?utf-8?B?MmxOdk45SlpSenVvMnBTZ1ZWZ250UWJaYUx0VkI2M2w5UHo0dm1VcTNPaGo0?=
 =?utf-8?B?d3hYbjAyRnMyYlArdmFkSnJSeXF0c29wN29SMWcwWmNsNnBIZjJVTXpPczZ0?=
 =?utf-8?B?WnN1QldoVzJueVZuUmdFdTJ5enAzcG8wVDFCZFVoMXhEclp6MW1NVXp3Njh3?=
 =?utf-8?B?Wi9nQlo5ajJ5Y0l0bjRMYWxQbTYrRFpJampyM25XYU9PMjVtKy9FT3d0enFP?=
 =?utf-8?B?WG83bmdiZ09mbzIxVTBCZHNCRUR6akR0THpwc1o3V1Q3alNuNHZOTXMrTlRm?=
 =?utf-8?B?Vkd1bklXRTh0bGJ6enRNSGRoRXhpY2ppUzJYMXBTWktXbjREZlZqZTM5bU0z?=
 =?utf-8?B?VzFJNm9tbXI2cXhwbjNvdTlySXAvTk5kU2Z2YVhUVDZQem1yclRnNUsyZnJ6?=
 =?utf-8?B?aUYyU3BqQjB4aDhHc2sxTmZZSWN0YkZqRjQ3MVNyaU1sVmR3WjlOS1RFclRs?=
 =?utf-8?B?M25LREIvQ0I2SGhhMmZSV1BnZ3pXNTFGMVFYVE93UmI1MzlZNVI2My84UGhY?=
 =?utf-8?B?WW90KzZoOEszV0JMTXV2bDI4b3RCdS9zQk1RYUxuV1RHZFNTMHM4ekJaTUx0?=
 =?utf-8?B?ZkVlVG1GdzRQR2Z2YlhRV2xScy9NdzF1ak1QdTRqQUdJY2VFajhqeTZua1VZ?=
 =?utf-8?Q?iKNNTHTyEFePUTRLDSTqYM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C0FFB9B60523D4A9A8CFB9AA3CC8E08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b357d74-b523-479b-46ff-08daa338196f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 23:04:16.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpeulMne3a3bHU6BQQstqKz5/DiIdRT07NM6njBg713z1XMXcNCzZmU/Rv8p6LTH7ddPO8X5Fwy12j1JTTbIhWYuml5rodlhcIrSC/k1QnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIyLTEwLTAxIGF0IDAxOjAwICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IE9u
IEZyaSwgU2VwIDMwLCAyMDIyIGF0IDk6MTYgUE0gRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGlu
dGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gT24gOS8yOS8yMiAxNToyOSwgUmljayBFZGdlY29tYmUg
d3JvdGU6DQo+ID4gPiBAQCAtMTYzMyw2ICsxNjMzLDkgQEAgc3RhdGljIGlubGluZSBib29sDQo+
ID4gPiBfX3B0ZV9hY2Nlc3NfcGVybWl0dGVkKHVuc2lnbmVkIGxvbmcgcHRldmFsLCBib29sIHdy
aXRlKQ0KPiA+ID4gICB7DQo+ID4gPiAgICAgICAgdW5zaWduZWQgbG9uZyBuZWVkX3B0ZV9iaXRz
ID0gX1BBR0VfUFJFU0VOVHxfUEFHRV9VU0VSOw0KPiA+ID4gDQo+ID4gPiArICAgICBpZiAod3Jp
dGUgJiYgKHB0ZXZhbCAmIChfUEFHRV9SVyB8IF9QQUdFX0RJUlRZKSkgPT0NCj4gPiA+IF9QQUdF
X0RJUlRZKQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiANCj4gPiBEbyB3ZSBu
b3QgaGF2ZSBhIGhlbHBlciBmb3IgdGhpcz8gIFNlZW1zIGEgYml0IG1lc3N5IHRvIG9wZW4tY29k
ZQ0KPiA+IHRoZXNlDQo+ID4gc2hhZG93LXN0YWNrIHBlcm1pc3Npb25zLiAgRGVmaW5pdGVseSBh
dCBsZWFzdCBuZWVkcyBhIGNvbW1lbnQuDQo+IA0KPiBGV0lXLCBpZiB5b3UgbG9vayBhdCBtb3Jl
IGNvbnRleHQgYXJvdW5kIHRoaXMgZGlmZiwgdGhlIGZ1bmN0aW9uDQo+IGxvb2tzDQo+IGxpa2Ug
dGhpczoNCj4gDQo+ICBzdGF0aWMgaW5saW5lIGJvb2wgX19wdGVfYWNjZXNzX3Blcm1pdHRlZCh1
bnNpZ25lZCBsb25nIHB0ZXZhbCwgYm9vbA0KPiB3cml0ZSkNCj4gIHsNCj4gICAgICAgICB1bnNp
Z25lZCBsb25nIG5lZWRfcHRlX2JpdHMgPSBfUEFHRV9QUkVTRU5UfF9QQUdFX1VTRVI7DQo+IA0K
PiArICAgICAgIGlmICh3cml0ZSAmJiAocHRldmFsICYgKF9QQUdFX1JXIHwgX1BBR0VfRElSVFkp
KSA9PQ0KPiBfUEFHRV9ESVJUWSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQo+
ICAgICAgICAgaWYgKHdyaXRlKQ0KPiAgICAgICAgICAgICAgICAgbmVlZF9wdGVfYml0cyB8PSBf
UEFHRV9SVzsNCj4gDQo+ICAgICAgICAgaWYgKChwdGV2YWwgJiBuZWVkX3B0ZV9iaXRzKSAhPSBu
ZWVkX3B0ZV9iaXRzKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiAgICAgICAg
IHJldHVybiBfX3BrcnVfYWxsb3dzX3BrZXkocHRlX2ZsYWdzX3BrZXkocHRldmFsKSwgd3JpdGUp
Ow0KPiAgfQ0KPiANCj4gU28gSSB0aGluayB0aGlzIGNoYW5nZSBpcyBhY3R1YWxseSBhIG5vLW9w
IC0gdGhlIG9ubHkgdGhpbmcgaXQgZG9lcw0KPiBpcw0KPiB0byByZXR1cm4gMCBpZiB3cml0ZT09
MSwgIV9QQUdFX1JXLCBhbmQgX1BBR0VfRElSVFkuIEJ1dCB0aGUgY2hlY2sNCj4gYmVsb3cgd2ls
bCBhbHdheXMgcmV0dXJuIDAgaWYgIV9QQUdFX1JXLCB1bmxlc3MgSSdtIG1pc3JlYWRpbmcgaXQ/
DQo+IEFuZA0KPiB0aGlzIGlzIHRoZSBvbmx5IHBhdGNoIGluIHRoZSBzZXJpZXMgdGhhdCB0b3Vj
aGVzIHRoaXMgZnVuY3Rpb24sIHNvDQo+IGl0J3Mgbm90IGxpa2UgdGhpcyBiZWNvbWVzIG5lY2Vz
c2FyeSB3aXRoIGEgbGF0ZXIgcGF0Y2ggaW4gdGhlIHNlcmllcw0KPiBlaXRoZXIuDQo+IA0KPiBT
aG91bGQgdGhpcyBjaGVjayBnbyBpbiBhbnl3YXkgZm9yIGNsYXJpdHkgcmVhc29ucywgb3Igc2hv
dWxkIHRoaXMNCj4gaW5zdGVhZCBiZSBhIGNvbW1lbnQgZXhwbGFpbmluZyB0aGF0IF9fcHRlX2Fj
Y2Vzc19wZXJtaXR0ZWQoKSBiZWhhdmVzDQo+IGp1c3QgbGlrZSB0aGUgaGFyZHdhcmUgYWNjZXNz
IGNoZWNrLCB3aGljaCBtZWFucyBzaGFkb3cgcGFnZXMgYXJlDQo+IHRyZWF0ZWQgYXMgcmVhZG9u
bHk/DQoNClRoYW5rcyBKYW5uLCBJIHdhcyBqdXN0IHJlYWxpemluZyB0aGUgc2FtZSB0aGluZy4g
WWVzLCBJIHRoaW5rIGl0DQpkb2Vzbid0IGRvIGFueXRoaW5nLiBJIGNhbiBhZGQgYSBjb21tZW50
IG9mIHdoeSB0aGVyZSBpcyBubyBjaGVjaywgYnV0DQpvdGhlcndpc2UgdGhlIGNoZWNrIHNlZW1z
IGxpa2UgdW5uZWNlc3Nhcnkgd29yay4NCg==
