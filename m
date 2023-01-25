Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4167B60E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 16:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAYPgc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 10:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYPgb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 10:36:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3BFCDE7;
        Wed, 25 Jan 2023 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674660990; x=1706196990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=DbTFFghHnQdsa5Yo0DVJn3TjMnSj/p9geOWjEPvZ8uI=;
  b=izrd4rLqtlYwWdPsR0wuOCYPlQ/LPq2QpXZgs0Dku1a5FbI1JdktcRwP
   cxwzuJQJQbEiMwXDvFEl8qJqPCR497ou3ScFGTwP4fsM89jrmhO5rPZ9E
   12oJCIrPtPSTl5OavlM/nAZfauNfwQvXqZa6Ey4+37Xb/ghy1/nCNLPlX
   nF5gvmGjAUTM2YJVC5H0ZYyln4A1Aawtu6g2hIMi86BTcC78o0JJJ9KTb
   HZBazRiCgsIJ/URZLfpCTTiBN/F+rVhRRt1Vm5l7sbwlwRMhcwM93Nhkd
   wEz2g1Gy8ptSACt5volc3B/9QsOKAoZMsj/Y8Ggdtpwt2+1nza7lkINCB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="391091061"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="391091061"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="692991172"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="692991172"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2023 07:36:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 07:36:05 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 07:36:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 07:36:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 07:36:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqZGuJw9Dehlan+BNHShcNOk+wPeBfg5AJ4aIgmECVYN7JNnjeRAHWD6WZf10bvwKEPH8/KrtWZOeIFgbGY9i1FvLi2DKmOq4VLNPnfVtpOi0iv5v4ozeH6ghzowu7JRUWaH5R7F7gxvXumjQ2/c9ZjifdrybTgSIe+VXOR4uuf2CjRcQiTAVn19KXlRymuPmIV1LDkSQx1Bh8pkhqZ/rMD3D8s211Kq8GltDmWEcRSWhUWXRE+teWmiD/vA9x10Iaqn9V5CmmX9MnI738JvUJaMH5duTRaVoEUlCJ93v+PxrkK/yXMCb8tsozqcPymRHxdtWblkZrFkeVjsH1lcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRLaCAuRhnK1oJ2J8kT+piuzicNVhnJTu5AshZD+2DQ=;
 b=acgRLBr5t4P7HhJVKG6nSA1khYnP7OikyAqrUsqrz/Nm4+BeXK/QpMtOYBqhViE9e09PRNvcKUG/mQP2fFHKJsdP28xxuKHHHmcqdomcM7D0HVRbLXyf6/wZ2AvYCQBkrYWEpWkcSyr9wxw3neIQ3OAaExCNoGI+3bfOYxpGdbisIeWyZf6qMqhK5k7rDE0qu/o1p8ZsKzyt1DE8/CBs25lfiweyGSScR9g6gDdctjAvvileksI3NPIZWvLpdQRforwsFOYJz6kDKxNTV8nfYo8aFQ91KrReFUqhe0OyoezHPHPT20v015HT2kLXtnB2Btv4Af09BxOuP5++qONmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18)
 by DS7PR11MB7834.namprd11.prod.outlook.com (2603:10b6:8:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 15:36:02 +0000
Received: from CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::cec1:7ea4:6952:337a]) by CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::cec1:7ea4:6952:337a%4]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 15:36:02 +0000
From:   "Schimpe, Christina" <christina.schimpe@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZLExdUTaobfYwNkOWzEcXowdKDq6rvFwAgAAas2GAAKfZAIABScmAgAAl7QCAAV4I0A==
Date:   Wed, 25 Jan 2023 15:36:02 +0000
Message-ID: <CY4PR11MB2005CA3050147893EAC10B9EF9CE9@CY4PR11MB2005.namprd11.prod.outlook.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-24-rick.p.edgecombe@intel.com>
         <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
         <87fsc1il73.fsf@oldenburg.str.redhat.com>
         <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
         <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
 <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
In-Reply-To: <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB2005:EE_|DS7PR11MB7834:EE_
x-ms-office365-filtering-correlation-id: 976eb020-8b0f-4a1d-6a29-08dafee9dd5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRi3siqJ9RXBYHIeS7UB57OZFV7g1cAEOyD7VFvmKAnWngKZxMH9hTcE+ckv8t/rYcNZN8kNsm7etE2fXlCilsuZD3aH3s6RDgvpLZUxRz1tvhX2nWz0SUOK0ovFhfTiAsXRz2xPdO93HqqdAcAajOyViQ7Wuer4SOQYVgyU/ZpwwhAroClibvPtUlswho0xHFK0c39mZVCZTYogD01dOhY7q7tjocTCSf59adaGOgXdiBNn7lmQ6hTHbLix9dXLQJfldZcStTc/7wNYkIPsQYoFb8vkd/o/o03EGOac4ImtjqoxqC0+uFKLckWcRULCPqIr7O/df0f5P2NwUMvqGhDs5h8y1/Ft74u7NM/rV25pyeq+b+XtdMLJ+dz6o9QMrPiLD8TT9emk3O/Ti0vObZv/XfbZ5tmdf8l9SPGUD3ySAwsp+ZW+osRg+y7FA6o+NzX9bDb5mKz7hdUlOCodOVT236qxlNeNnfgVh+6x/oYQWW+jpb4GndMsodtZ1krafYN78SNsNmFFiowMHjx9gnRQ+3WBuoBs3m0gJ4dpqBJ7nSywH02SfeG1ZBXdYzNotyeCtWkNhR6c6BzHEcQ3uyisH2LYsgWMhgm3+rtkbZPZt3kC3fztV/EeSWrGTWo7r7b6D0DhDgHHkijTd7k5qNzGMOgc6MzNhg4r5OrnAedgMeBPXJUUsGrj3gX1u2HYphnvr6w5Ofttd+SbukhZXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(66476007)(316002)(41300700001)(110136005)(4326008)(66446008)(54906003)(76116006)(8676002)(64756008)(66946007)(86362001)(66556008)(478600001)(186003)(9686003)(26005)(71200400001)(55016003)(7696005)(33656002)(38070700005)(52536014)(7416002)(5660300002)(7406005)(82960400001)(6506007)(2906002)(38100700002)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm5ETjdoL3M0ZUlrREtZSjFuSVViUnhFeWxTRmFTdmdjMVM1ZXNGRitQT2xF?=
 =?utf-8?B?cTJrRFhBT25XNWFnK2NrMG1Hc1h6MUVzVzQvT3hGdldBVm9DUlJLU2hhVWFS?=
 =?utf-8?B?cWtxN2piUHUwd3puUS9uSnBlTE1QS29jVUFXdEF4UGZPS0lScjVtYTNadEhr?=
 =?utf-8?B?WFBwckkrTjJ4S0tLNVM0WjIzeFEvaVBEZFZhbU9ObHRaVDk3WENlS0hOWjBi?=
 =?utf-8?B?cnRjUU5lZUllTHBlcWZjcDZLUnluRVpSanc5WVdFTGFDT0x4TkNCQnRWSHBu?=
 =?utf-8?B?L1RxdFhaMHV6RlJVdUtjRHpjc2d1ckt5bFdkOUkrNVVXMFNDK3YwcDEyUndF?=
 =?utf-8?B?MmZlVmhQa1hXUGtPeENYU3hhNWNyVnB6bjZXVTlFWmdDMkZneFFCNDlJeFNM?=
 =?utf-8?B?bWRQcVpTSGwxYjlDcVZUL1VWU05PcTF2dHZkbnRyZ25mREI3TmVrQUhMRmRi?=
 =?utf-8?B?MWFVMjNMa1V5Ujdsdi93bW9HNnFFV0RhQzZTUzZQSUI5emxFTmJKeXQ5U0cz?=
 =?utf-8?B?M1ZWeStzcVdVcjVMNDhqVXlSZGx5cThNK0YyQ0Z1SVJIYWJnaGthQVNKZzhT?=
 =?utf-8?B?c25RSWFPbUdvQTd1NUVLdk9GRkgyalNiWndKUzcxcEd0b2tUM1Q0MytTUVdj?=
 =?utf-8?B?eWo0clI3aUtwdGJ5RnlReHkvR1FTZDZNOXBtVFovMFZyTEZkcGxockZDUmpu?=
 =?utf-8?B?dWprbVp2U1pBU3hZd2FzdnFKZ01zVERDVXU5ZVhlczk2a2VnY1B4Nk1ZaWlZ?=
 =?utf-8?B?VkY5Rk51WEE1Ny9kK3VEL0UrajJ6TlFNckRtNUQ2WGVLRzNGRXVNdjZ2cnYx?=
 =?utf-8?B?bFFCZ25sWVlTWU5JMk5FdGNsaHAvUzFDZEtpN3F4azVONUc3SjV5bkJCdGdn?=
 =?utf-8?B?Q3NNMjJ1RFlRQXdrV3VWRlVZUWE3bzRVcGhHQXJBLzJuOTJZTTNzSkh5bDJF?=
 =?utf-8?B?eVBXMVFwaHR4clJGZzRYR3UydUsvZzRxdkY5T1hSSzN0anVlbDJ3T1BKTExB?=
 =?utf-8?B?cTg0OUdCcXNLMis5a1E5Y0xLL2p4MFZ1aUVLaExqYXVPVThuSUxkaFdrWFNn?=
 =?utf-8?B?ZTh3djkvbjhocjZ3MmxLaVFzVUxkMjBWTDJKY0dlTjUrbmsvWTJxTzQvSjZw?=
 =?utf-8?B?bGZXcmpnbVJkYlN6K1FxbTc4amVXSy9qUnRTY2NsTHpMZEFFY1Q0bTZWZEQ2?=
 =?utf-8?B?aWw2QjhBTFJ4S2hDbXRmRTZsb0JYZzNGODlGS1M1Nk1KN2VKZWxHdm5vME4r?=
 =?utf-8?B?QTYvcGtuL1J5TmNXUmM1U1JnaWdCbmZ3NzVXVW5jZ2Q0WmpobzJPYTJWYm54?=
 =?utf-8?B?TTdpb1llUEFHeUp6NXFNQ2hQdmRDdnZjWlkyZ2FjbmpUZDI0Q0hYcm5TeGQw?=
 =?utf-8?B?TW5SNVpIcmdCeTIzQnFWalowVUk3UDBpQVdKT2xkbUFwYzlnU1JRSDZSb2ZP?=
 =?utf-8?B?SHNhazd0d3RUL3duZlN0V0ZQMFVjcFp5OTNxVSsyTXp2QndZeGtRSkJ1bk9u?=
 =?utf-8?B?S2lUVzNrWEdsTWQxSWtXd3V3bEpjV3NmY3FUdkpPWnEvN0JKS0hKMkUzQmEz?=
 =?utf-8?B?ayt3UCtiV3orWFhoU21pcCtKUlpPVi8yUmFkT01DcVh5WWRTdENLdWFmV3hs?=
 =?utf-8?B?UGZuQ2RLVngyNjkwVGxFVHFQNEs2Z0YrNmNPZ3ZjOGZRWTgwK1dCM1QxRXoy?=
 =?utf-8?B?eU5EL1pFc2t1OUo1c205SjJxTDlPSEMxUFNjckt3dWQ2VXlDMWlja3Vpbm1P?=
 =?utf-8?B?eG9saE5FdzRsWXpOcGJWd2Iyd1A5bTZkOWRnUE04ZnZZaml0NjRwcTd6Zkpa?=
 =?utf-8?B?bVJDcFV1STB3U090TUlSQXYwMVFOdzV1YUdCU1g0dmNSVFRSQ24wbWJlR1Fp?=
 =?utf-8?B?cGJwd1hlMkw5WkdoNTd6d1JYUlBNeWZPM29MU29URmxCeHExbTRwVkNJbjdL?=
 =?utf-8?B?MlFKUk05RkVYWWd1QTBlTG1kN2FhdE1iRWtRY3liRlBuR1dwc3I4MVoxOHdo?=
 =?utf-8?B?OXd0NDF5cEp0NG82dGk5ODdYb3ZsM2p4VGNMYXlmLzN5WEpQSWdFTFNVVlpz?=
 =?utf-8?B?dzdzak9zZTlmRzBVRjFwbzdUeXc5bmZuRU0wVTdLU0pPTVhvWGlDNHFBajZV?=
 =?utf-8?B?dWhZbkwzZUNxVitwamdreklMeHJQbDNSU25LR0VwaTVqVllGQjZycm50TEdP?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976eb020-8b0f-4a1d-6a29-08dafee9dd5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 15:36:02.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PiCfGAiCOp5BxuglNotDCbPs1rMsC+IvvkxjaNJzL8GOJNboDdEsmtIp+K1NGfNNz2ouLY05/YFmUfb50SySdtDJ+Bl1M03YVR2lXphzRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7834
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBPbiBUdWUsIDIwMjMtMDEtMjQgYXQgMTc6MjYgKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdy
b3RlOg0KPiA+ID4gPiBJc24ndCBpdCBwb3NzaWJsZSB0byBvdmVyd3JpdGUgR09UIHBvaW50ZXJz
IHVzaW5nIHRoZSBzYW1lIHZlY3Rvcj8NCj4gPiA+ID4gU28gSSB0aGluayBpdCdzIG1lcmVseSBy
ZWZsZWN0aW5nIHRoZSBzdGF0dXMgcXVvLg0KPiA+ID4NCj4gPiA+IFRoZXJlIHdhcyBzb21lIGRl
YmF0ZSBvbiB0aGlzLiAvcHJvYy9zZWxmL21lbSBjYW4gY3VycmVudGx5IHdyaXRlDQo+ID4gPiB0
aHJvdWdoIHJlYWQtb25seSBtZW1vcnkgd2hpY2ggcHJvdGVjdHMgZXhlY3V0YWJsZSBjb2RlLiBT
byBzaG91bGQNCj4gPiA+IHNoYWRvdyBzdGFjayBnZXQgc2VwYXJhdGUgcnVsZXM/IElzIFJPUCBh
IHdvcnJ5IHdoZW4geW91IGNhbg0KPiA+ID4gb3ZlcndyaXRlIGV4ZWN1dGFibGUgY29kZT8NCj4g
PiA+DQo+ID4NCj4gPiBUaGUgcXVlc3Rpb24gaXMsIGlmIHRoZXJlIGlzIHJlYXNvbmFibGUgZGVi
dWdnaW5nIHJlYXNvbiB0byBrZWVwIGl0Lg0KPiA+IEkNCj4gPiBhc3N1bWUgaWYgYSBkZWJ1Z2dl
ciB3b3VsZCBhZGp1c3QgdGhlIG9yZGluYXJ5IHN0YWNrLCBpdCB3b3VsZCBoYXZlIHRvDQo+ID4g
YWRqdXN0IHRoZSBzaGFkb3cgc3RhY2sgYXMgd2VsbCAob2ggbXkgLi4uKS4gU28gaXQgc291bmRz
IHJlYXNvbmFibGUNCj4gPiB0byBoYXZlIGl0IGluIHRoZW9yeSBhdCBsZWFzdCAuLi4gbm90IHN1
cmUgd2hlbiBkZWJ1Z2dlciB3b3VsZCBzdXBwb3J0DQo+ID4gdGhhdCwgYnV0IG1heWJlIHRoZXkg
YWxyZWFkeSBkby4NCj4gDQo+IEdEQiBzdXBwb3J0IGZvciBzaGFkb3cgc3RhY2sgaXMgcXVldWVk
IHVwIGZvciB3aGVuZXZlciB0aGUga2VybmVsDQo+IGludGVyZmFjZSBzZXR0bGVzLiBJIGJlbGll
dmUgaXQganVzdCB1c2VzIHB0cmFjZSwgYW5kIG5vdCB0aGlzIHByb2MuDQo+IEJ1dCB5ZWEgcHRy
YWNlIHBva2Ugd2lsbCBzdGlsbCBuZWVkIHRvIHVzZSBGT0xMX0ZPUkNFIGFuZCBiZSBhYmxlIHRv
IHdyaXRlDQo+IHRocm91Z2ggc2hhZG93IHN0YWNrcy4NCg0KT3VyIHBhdGNoZXMgZm9yIEdEQiB1
c2UgL3Byb2MvUElEL21lbSB0byByZWFkL3dyaXRlIHNoYWRvdyBzdGFjayBtZW1vcnkuICANCkhv
d2V2ZXIsIEkgdGhpbmsgaXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIGNoYW5nZSB0aGlzIHRvIHB0
cmFjZSBidXQgR0RCIG5vcm1hbGx5IHVzZXMNCi9wcm9jL1BJRC9tZW0gdG8gcmVhZC93cml0ZSB0
YXJnZXQgbWVtb3J5Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aW5hDQpJbnRlbCBEZXV0c2NobGFuZCBH
bWJIClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBH
ZXJtYW55ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlIDxodHRwOi8vd3d3Lmlu
dGVsLmRlPgpNYW5hZ2luZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlkLCBTaGFyb24g
SGVjaywgVGlmZmFueSBEb29uIFNpbHZhICAKQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5
IEJvYXJkOiBOaWNvbGUgTGF1ClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gKQ29tbWVyY2lhbCBS
ZWdpc3RlcjogQW10c2dlcmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=

