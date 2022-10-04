Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58655F3AA0
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 02:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJDA33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 20:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDA31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 20:29:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A415700;
        Mon,  3 Oct 2022 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664843366; x=1696379366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYtaBTXghCFcpsyqnBc4Ee+NYng79lhW/9xeHQPw0uU=;
  b=OzStYuQdA3IqBHUA5vJvJkZW+t+jGKi8JQNddYhN78QqlkuzNnGEG66S
   EEMU2rbbAv8jd9ENkox4AnUaSd0gOCKtb0tNg9n31hZnzjPCPiMkmtRva
   5aW9DWwenWq3pGIIUL5vA/clE8a3T7lv1/Vr+sdcPuJOuZA1igflNAdsM
   N5+53TUaMOHf9qHT7tOFI+G4tllFWtKchs3DoQTHEPtWzk/b1fLi2GUjg
   XifDVlzYRUSNr8iM10vDCGqv3v6W4WYv8euQiFlox9Kdhi6WAdqBorOsy
   Yo7vfza66poWpWGhJYBKYv63y58lyU0HQMXDcvDhXr0f1FPBKqRplmU7M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302773329"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302773329"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="798938521"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="798938521"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 03 Oct 2022 17:29:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:29:25 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:29:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 17:29:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 17:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJAlqpgWkOa3pDwVNXule1+GQ8cg9tDlWqRVZE8muDay0LlTjow8S9PvSABXj0DN4ySvuhzXQpTfkVGMJbp6lhL8okMHnSpyOsmoCjG4JkxfsVBjh4en4v+Rsnwr4nbhqiWWafUxbtRf21iHpdkeKHj92FI6qFbeEsk+en8zeMweCKlqmA4mI4KuXd82LuaOd6FH0VV6D0y7M+syVAg8U6Jn4fyZq1j87HVd7qW9daRLTtuJNK3EUsPym7CEWrrSKjmyGggp0jA5+sAb2qgQJDiMpQTjFQI8rTjDyc7A74yszBg5ulAJ8gtSOrYxrFN+QE9Yxoa3i7SbWn2LehknVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYtaBTXghCFcpsyqnBc4Ee+NYng79lhW/9xeHQPw0uU=;
 b=luFSMbOVgpG6KFr9v3BPNK9fxSX72Di2VSfje6aiZWmOl8+D+cGMq3lUGzTzzwZpwM7vEg6JsQdmERso6OcCU6M8Lvu9u4ZCDJv3nkq3CkoZkrSlh3yhVHvAjR5RZnzIbvPT6WXb1uf7d2MqxauBE7IglAGxPevMEa966VbPHcieKXrXwZaKEbRdjvo5keJO3lw1FAZEwfUIg1+zJfwL0VMCYftuJXVOLNRbUPYKQu+/ITqGhiJL3V8H2XAyyQiWCw5r+nplBy2+1X2LZSkPlv91hZZr/GOr6C6l+w9TxsoAwfnnOY+qDpkrofoVk48V4AyIMUe5SL9sEV0KnLL/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 00:29:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 00:29:21 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v2 14/39] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Thread-Topic: [PATCH v2 14/39] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Thread-Index: AQHY1FMbbqaAdie2YkOM3C+pk0yIUK3898CAgABwSQA=
Date:   Tue, 4 Oct 2022 00:29:21 +0000
Message-ID: <d09e952d8ae696f687f0787dfeb7be7699c02913.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-15-rick.p.edgecombe@intel.com>
         <20221003174727.vvposwdd4fmmi3hw@box.shutemov.name>
In-Reply-To: <20221003174727.vvposwdd4fmmi3hw@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB6574:EE_
x-ms-office365-filtering-correlation-id: 94737637-854b-4d68-4a7e-08daa59f7b46
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQ2RVsSmDxWMFYr8epR6DNbMqPkkNVYLYgjBXcCb/HISDRtYhy0gPIS1mJYg6jzBkiyM2oqpPNvmpPvUhyq0lCjYeGv8hh50QwivE3dNtH+vbzqx4+dEXph7IsckrPoqOKj6rV57O7lI3nX/7F2HeJlA6QlsHVqmuJQJGoWdk2OzjMoM9lH5PKIUfS1B/J0Lj7u/L/Ys1TAd6EUrkE7DuubZ/2YCIIRck2kOubQWL1VmzprpxDgwqtSNwssfoMpq0MRt4c/yJ2O5aB6VJtDJ16pBtdQAuZWErIapHyoS+LCFneVfHo54QCHevgXGmGItUVh+XJ1tbyHZuaJ++qHLsFKO4T3YkjNqTAyPErJP+03R3IRAekeDu9zevCEdTGkk5PQHrtWyf8bqEWyyTFFLeZSfi4jQd4bO57rimg+97Uo5roz9Ffk5pyJfk72qYnJKrqKfqBoPa1Pg7KKL1O2GwSxP1Ez6TxJDyQcrhH/ySaxJ1rkfaRx1D1QJhf0k0/iJQKI9jPqBkn6r5H0LrzE0rJ18Of6j2tSiYFZz9DG1jdedOsgeM/kwtR1cTR7ZE0JJNC4lRofAO68at7XNLSf/k7I/Ss8DTWsB1HJ93/50V2dpflEXAq5ua5eQmhTVM7En4/0UROvqKBoDLe+PP6LuCmS+L836Ls+p7xD7VabdJVtVgc20Cqf1vNB3q+McNif15mbynnJZKjQf343qh8ljzch+HpJegZfhqm4kKr9o3/z7OiXBXBEVC6rvCu0RTTJVTgJgcKhUnUxRN0ePOU6NCSsjLSYrSpEkMn8qbVPMtew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(38070700005)(6916009)(6486002)(316002)(478600001)(82960400001)(71200400001)(54906003)(122000001)(38100700002)(186003)(4326008)(66446008)(7406005)(41300700001)(66946007)(66556008)(76116006)(8676002)(91956017)(64756008)(66476007)(6506007)(6512007)(4744005)(5660300002)(26005)(8936002)(86362001)(7416002)(36756003)(2906002)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGVCOHkrVUs5clpoVVA2TmQ0RHlCWHZxc0R3L3lLbVNmTmZ3bVM5NVUzUkxK?=
 =?utf-8?B?dkErZnlPeEc5STF2SzBjdUo2djNuVXRXSEZJNU92UFlHYTJac29VREx0VXpP?=
 =?utf-8?B?UnV5eklwTXFhVWJubVliNGJKdk01VUd2ekVlVjdFekNJa0lZazBUZEFKK1lR?=
 =?utf-8?B?N0I2TUFnNkRUbm9mY3RmNFZQTy9BQmRsamRhYWpmek0zM29qeVFnNzNzZUZR?=
 =?utf-8?B?MHU1QnJKaUdYRFIxYTBIU3JjR2lkdVZ5dm4wTTRMNkVEdG5tYmhPRjRxUkVO?=
 =?utf-8?B?d0hFN2ZSa2Z1SEJLK2dxZmZRZlEzUVlxcklrV3MyQWVyOWdKdzRWREFtRGpJ?=
 =?utf-8?B?aldTUjNGeWtBOVlTempBZytJMXdSc0F3cENBcERsWS94WU9OMmJWWUNDMUNy?=
 =?utf-8?B?NnNjRUljMlJ1bGs4UjBoUkswbHlTUHBvSzBmdzUyQjRMVXBPQ0ZXYWZKVkNE?=
 =?utf-8?B?L3pEL084UTJldk5mOEswdFM2ZStIeGtUUTNkQXJDOWdta0lXZnJMMlBBdXk1?=
 =?utf-8?B?bmduWUxVMlJMWk1MZTQrTTJMUStQVkxpOUNjQjFmc2ozK0VDMlN5TFVFQVRn?=
 =?utf-8?B?QzlWRTR5TThxMG5vWGRtWUlZNDdGWmpTKzJidWZkYld2WUhHWDkzdkVTSlll?=
 =?utf-8?B?Uzk5Y3VkUXpobDYranZmcWRyd2M5V0QrKzAyQjMxSTMrQVRJMlo4RWs1a0JR?=
 =?utf-8?B?ZHMvcmNUdDhoTi9oTUo4R0JjRFV0QTErOGk1dkFiQlBhTGJWT2J4VUtCYkxs?=
 =?utf-8?B?S0xzSW5Jdk11ZkY4dEREV0RZS2JWUWtiMTZrR0YwQ1ByK2JIY3U2b0N0bEZV?=
 =?utf-8?B?RDB3RkNlbEVLOUpyZFF6OWhZK1VtalliTlJEbzZ6VGRBNEQ2OUZsSGdNL0dj?=
 =?utf-8?B?eGlUZ0lyUFptZXZYK2VsdUgvWTNUS3E2dElmWWdNdzR5MkFBejQrQVRlcUdy?=
 =?utf-8?B?YktBcTFTckYra3BTSzNwYXBlOU03TDlISXJtd1ZGUGdSZHZSZFRGSEd2VVdy?=
 =?utf-8?B?dUo2OXFGRittTXkrckNNY2FCdVFQenk3QWtWUGtidGYxU3dGZVFCd2lsM3Vs?=
 =?utf-8?B?SmN6OUVSR1U4VW8xOWJrYkxhOWpBWFJxY0VFb3VLZ2Y0dDY3amhMNHRFd0dN?=
 =?utf-8?B?cW5jVGFSb1Y0OGUyekd6eE04VXBvTlpGb0wvcXp2c0ExZk5iWnF0T1k1aytp?=
 =?utf-8?B?YUxpdGhnZ0d0WXpuUnZCNmE0bHB2SHpKMU1oMGl0RW9kRm9BSG1VMFpmY1hQ?=
 =?utf-8?B?WUxSWUFVNTNUMk9oMzc3d2lYS1pkZzUyek1uY3JGMDFWRTBJMDBFeWtwWEtU?=
 =?utf-8?B?Vno3c2F5TWVXZVBKdTNJZFBVUTBwTnBQTzFqUTJxa2c0UmFLa3JCOUp5S3hP?=
 =?utf-8?B?dStJbnJjVTd0ZVhtdm0wb3FjRU5ZOTMrTUliLzRJNTd3b2Jtd0FKVHorNlQ3?=
 =?utf-8?B?WmxlaGNEYWpqeWlhRkM2d3hSVklPdlFmcFhlWkJMdkNHWmh4ZEs2S25KZ2h5?=
 =?utf-8?B?Nnl4M29rdTBDWWo4Zk55cVgwOXc2TngvR3RpRSs2YzBkRG5kRnR0dHF1MnlM?=
 =?utf-8?B?SjgyZUZZS2JiRzZ6Ymg2RXc0d2lHbmwzRm1rekRhSnBySXVmSVlJdDgxWDhP?=
 =?utf-8?B?MzhrSmp0ME5neFZkUFlsclhBbHhWZnIxWTB0cG9yaUIvMDVLOWQ5eUVhTXlp?=
 =?utf-8?B?a0VZQWY5ZnpyT1JMU3EybHRieVRRL05YeTZ4MzB6KzBTTy9vRUE3eDNTY2Fa?=
 =?utf-8?B?b0MrNU54aDR5LzdmNlF3ditsNnhjbVgyL3BkSjliUWNNMGtuZ0tKMnkwTVdB?=
 =?utf-8?B?NGtFTTVkb3B6elR4ZnQzYXNxUHBRWGN6NUxUeEJPVlE4ekpUci9jcFU2QU8r?=
 =?utf-8?B?d21PdmMwNWhmLyt6SFMyWUYxOXQ3dTUrT3N6SXQ0dTVjUFh6a1pNeXB0ZFoy?=
 =?utf-8?B?bllyZG9HRzR3dCtiMjJZYnNPNFdvbEt2UG5uN0JvMS9Cbm81aGh3MG5TTEVJ?=
 =?utf-8?B?aWx1bTR2N0dSTllpcUsvWURKNG5Eb0Y5NHF1YW5ZaDVXUGY0cjFIZmhmK2Fu?=
 =?utf-8?B?T25sVkkvRHkvbDFuNEpSSFNpT2hqaXNFWERVTHVmNXppTURNTCsxYzdhQkZs?=
 =?utf-8?B?a2F6TGhKWHo2dXNwSXRqS21QQkJPL3JKQWNiSjE0Tzh0Z2hPUjFpTFA2VHlF?=
 =?utf-8?Q?e/Vuc2+5pgCVkZpX2JmJdNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE133222299FB4E87A11F939B3EE146@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94737637-854b-4d68-4a7e-08daa59f7b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 00:29:21.2777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STeqmTcUBzl0PAiX6kxVkdrmShT/Q5Yf98DWE/cyLQ5I7N37uI7GEtdHt2ffSKN23T1DTkPXlpfEwzkwcD5VkAJg3uWGHEccYIKOKQl+lr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDIwOjQ3ICswMzAwLCBLaXJpbGwgQSAuIFNodXRlbW92IHdy
b3RlOg0KPiA+IEBAIC0xNjUsNiArMTY1LDggQEAgdW5zaWduZWQgbG9uZyBnZXRfbW1hcF9iYXNl
KGludCBpc19sZWdhY3kpDQo+ID4gICANCj4gPiAgIGNvbnN0IGNoYXIgKmFyY2hfdm1hX25hbWUo
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+ID4gICB7DQo+ID4gKyAgICAgaWYgKHZtYS0+
dm1fZmxhZ3MgJiBWTV9TSEFET1dfU1RBQ0spDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gIltz
aGFkb3cgc3RhY2tdIjsNCj4gPiAgICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gICB9DQo+ID4gICAN
Cj4gDQo+IEJ1dCB3aHkgaGVyZT8NCj4gDQo+IENPTkZJR19BUkNIX0hBU19TSEFET1dfU1RBQ0sg
aW1wbGllcyB0aGF0IHRoZXJlIHdpbGwgYmUgbW9yZSB0aGFuIG9uZQ0KPiBhcmNoDQo+IHRoYXQg
c3VwcG9ydHMgc2hhZG93IHN0YWNrLiBUaGUgbmFtZSBoYXMgdG8gY29tZSBmcm9tIGdlbmVyaWMg
Y29kZQ0KPiB0b28sIG5vPw0KDQpJJ20gbm90IGF3YXJlIG9mIGFueSBvdGhlciBhcmNoIHRoYXQg
d2lsbCwgc28gSSB3b25kZXIgaWYgSSBzaG91bGQganVzdA0KcmVtb3ZlIEFSQ0hfSEFTX1NIQURP
V19TVEFDSyBhY3R1YWxseS4NCg==
