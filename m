Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C845FF1C5
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiJNPww (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJNPwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 11:52:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94D1C7D70;
        Fri, 14 Oct 2022 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665762769; x=1697298769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5ndq2J7Re2vQ6eyybi5tRYjXJVIOQJ/Oqe/qMoJA15E=;
  b=FGoQ7D0QMnCrDCLiESegGN9S147n9+xUrKBx4SDJb63Xva3x5IZyB9zs
   m2g98F0nnaEJLsqphMEiSl0etwEzzR7mXHDDoBtm9gIDbRH6nbVIPCyi8
   CzM+RoqYAuBIoQIFaBhMjsqQZo8yz2V1gj+rq6VUB3mQxcswPdKe+PvMx
   Mz258p1A0guL+MNUzSdpLpMeQ88Yt8oMSmdOmM6+45heW/isYOclUNtuc
   OSNrVLm3TZXbX1CFZ8vVUFU1KyWEw0x2z4CCWTJm+d/GX/vta/KWVtSQw
   rW3EesHqoR520aFZdfyO/myYpBitcntLtMJqS3VSiISt7P8eDbV4qqg62
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285132865"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="285132865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="578669011"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="578669011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2022 08:52:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 08:52:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 08:52:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 08:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXolq0TPi4K3ghMgqvcc9dKT10KxoUERV7ojua9qd0/A49mbU485rpvsbNVwh1BLIA5LwMJkQWiHetBFkgj5Ewp0CftyLoL+VwlpdLK/TEc4xNNnR7N2Z3fY/KW671kJbl66A44NCTACAIxfHhfPHHzSF8TRpvMIDfE2qxiiRUF3aNKnXNTtG/OMbmM/yoitNmS24BCx+uYp576bk/fQKYnXxYw98DUh3FnGT62L9ez4vaQpwr6IAMoTRq46c9p+2qJFGUfZifgU5UvF4bhdT7KvjblX/IzNuqqWZaf7Fb/JrI18Hf0I+IcafeAqYCfuz+bVyhtBk8zdIoDZZkZUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ndq2J7Re2vQ6eyybi5tRYjXJVIOQJ/Oqe/qMoJA15E=;
 b=aZxRiv9ZMGZuSe44lAIy6PiQ92AIayqZ9jhIyhvrlA9hiL/JKgqw0XbC7O73xHQeqVVlya5G+G+wHW2FgyCtIiqVH2NHezlzM3Xp/zFVkYbQAjyih+XIeoXXEdZYsUgDtN4l81L9cr0gimbT+uZPh8g2kRuorQbM4E3zyH3Zfosk3PIWHDgVY8cS51+bPcBRklCrFZkePe29u8RA+un6nHCXELLIYTiUaJj+jZM4j7tktng/98NezK1yfg6YjFjA3OHPCyA8nI0OvH+oVMD6UPg92tPPfLTtruVQ7OBsaSKXtv/TifxPfm5c95B6nZcupJQZZ2sQ9yVU4BT1VZ+23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 15:52:27 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 15:52:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO64NuYMAgABnwAA=
Date:   Fri, 14 Oct 2022 15:52:26 +0000
Message-ID: <9a19debd718942923fdd0a28914ecab8e1ce2808.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <Y0kusvhDIRQxB2+h@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0kusvhDIRQxB2+h@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB7007:EE_
x-ms-office365-filtering-correlation-id: be0a509f-7257-494b-95e8-08daadfc17c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lj5Kit5Rc5cDL5VGzd5AIzClSIo0kNiiFT2WwVX2uhKlwCvi5G2SEeFWgKFI/J5zXV7049dRqAMsxaUiS9GVttNqJUuH/rS1Vp7WuGkEGeH46oWQf35FhxkOQiVm6WbLE2ZaqCNawTLsCPMo2kdmjR1s/UmQ7gS3BmK0rRuLqHMgzSnXT6gB222a1Ch8mYbAN1Aqjbnq//3ZP2IXbR9y6ldAMQxD2x7o4HN+jT3nEVlPidtEQiyf5Fzmtg4RZ+CH+GnWuN5SPrQYE9mbzBw5CsARSg32YCMcmhWpOXqBA74zXNl3Hg5RMVDuE4aBWP1XhhzSjGgjIFjf+leaVglk8U0kqg9Gw+ltYMt+Q+0cNb2bH/aRcBSzU0IKjzKiUw3mzDrkBJXnFzDB6F7hQsRGhFNvyqzWzBkINuMALMgggq+mWkdJjONV7c60eAIVjj6PoWjjdbf8R+zw+6XhXywFpGjr3kIVemWGvrKR+VCQdIXwfkBpBEbCdChI6IKS6SzspP6rVtyeYZKZ+OYSDUTGHFAVi3o91h1Ohd1HpQIctgmDSwDIVbkF8VCxYakJ3TZXcdy0+1BhEqe58NOr7Z6dwP0xvVp9ZouwmgRpPBjg7LcMufrdokUWfPQ8/0W48ZormbsKYCT+YQE9CtRw6hshwHtR5GBvc1v/TTe9AzWO0+J1SV+ARv/HLuRv/3VRAl7KmNcrMHfxSlza9XCuIskbqQxTa50YYXBoD5b4iqUHfMynCAAV1LSu10zyIaHd5eIUqOXNMyOciSWg2Xe+IGkI3qc00FouWjnq+DglsLF/pSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(4001150100001)(7406005)(7416002)(2906002)(2616005)(186003)(5660300002)(6506007)(41300700001)(6512007)(8936002)(26005)(38100700002)(82960400001)(86362001)(38070700005)(83380400001)(36756003)(122000001)(54906003)(6916009)(316002)(478600001)(6486002)(66946007)(76116006)(91956017)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1JkdVNIdmZzS0NGZEFmaGZ1THZlM0FoUlVmby8yMjB2RDJsMjRkUHpnV0gy?=
 =?utf-8?B?QkZsaW5UTmV6SGxsNlZRQjIxTUEzYWpTWm4rVzBGTzRoVjg1SGVQM0NnU0Vj?=
 =?utf-8?B?aUErMTlIeUVoT21DRThSMExoR2dydklWbzE4T3lCNGdXOXFsMFhNcnNvZ1Js?=
 =?utf-8?B?WUF3czRnZ1lKckJEQys4NSsvL2pCS0IyZCt5U1lOU294cnpqTlF4OHVINzgw?=
 =?utf-8?B?VmFNRmU2ZHJqY3MzVkRmb0daQVVUdERHYlpqYXVLU3ExdXc5VFhHZEVURjdj?=
 =?utf-8?B?VDFYNWkrZEVtclJwaDR3UE1iWDVrVFZ5eFNzZzFodTNENzBiYVdLQklNNDFY?=
 =?utf-8?B?RCtqUjk0b2Y0RklQYkxuWE9IaS9YRzRYeWloelVwb1ZZU0I1RjF5eHJERnAv?=
 =?utf-8?B?ZkE4WkVzZUZOaEV0b3NWZXY1bURXWGs5SFNRU01tVUlPRWtYYXVPaEgyQmtj?=
 =?utf-8?B?eVJ3TnRFS3NsOEZIOVVkSHZ5YzlNcHVCVEo0TkhZVGdoUk1oMHYvakdMQVV4?=
 =?utf-8?B?djNPQkJqVkRscTJrRDlZNU84ZmxwUGNCc0pIRUJUQ3ZEcFBGNU9KbHJuUWZE?=
 =?utf-8?B?YXJqNTdCd2d3Z3BFQlQwVW1MeWpzMFY3blpMczRxVTRSWGhRRlhaVi9EQzI0?=
 =?utf-8?B?MzVCWGNZQk1namlOaElITEdqdVZZYXNHTXV5Q0ROUU9OTXF3QkFDQ3RKVk00?=
 =?utf-8?B?ZGFqbnA0WDZObFpOZWdWdFcxWlYwdjhiY0pWMkw5dUpTblNhaFF3ZmUyaHV0?=
 =?utf-8?B?RW9qZnJiTHM0WkpLaTNsUlVPYm9yYzlETTB6SXNOeUYxWmVzMlY0VHQwYWVC?=
 =?utf-8?B?K0NlWmRaaUR1THVPVXJRYjdlWE4zL2lrY01kNkFOUTZMcDJ1RUF2NDY2cXBu?=
 =?utf-8?B?dkdWanY1SHJFNy9ld1JIM2Q1S1ZMSUcwbG9YVC95L09Qa1pTTUgzU0dHRkQ5?=
 =?utf-8?B?M0gvWlh4NnVDRUVERVRtcXhMOGVRa05HaHI0ck9Fa1lHQUFYZUpNUURHcVlH?=
 =?utf-8?B?ZlpJcXpCVGNwNlEzVEo2UHBTc2lUd0ZGTmRCRUxEYjN2RW03bmd3YVNXdHdt?=
 =?utf-8?B?MVRxR1A0K1VKUzViaXFXSVl0SWU3azE4bytYVkFXc3pVQmw0SmJrZStpdVY4?=
 =?utf-8?B?R0ZucXZxcENPRi85MkUvSVd0SHhlYWozcVE5bDZ0aDk2U1RnTkloaTBaSER6?=
 =?utf-8?B?NE1Edk1XMDdhQmtZRDl2Z1pNVDVoS0ppclNlc0loMHFST0IwNlc5c3BhdWR6?=
 =?utf-8?B?TTcrSG8rMG1EbzRkcWVRT0FlVXFvZ0JSSTluY1ZkUjZtTVMvUG10OEYvOFhL?=
 =?utf-8?B?cVdQcWd3SFQrYWpzYUFTbzQ0RlZ1MnE0eGM3c1BDTU11UVp0clE0NDRiS1Z4?=
 =?utf-8?B?d05MZzhDVUNiek82UFhIM0IremtTeFBMendvOWhqaVhtRnR5WkhRVjcweGhn?=
 =?utf-8?B?SXo1Nzl3UDREWXptbXhqOVB4MUM2UmF4RExkVkl1WTF0Vy94ZmpsY0UyZW41?=
 =?utf-8?B?OXJVWFk0MmFTaFM4bGZYcnJYRmtDeHc0S0xqMVp0d0R5SzR6Y250VXRaMFlY?=
 =?utf-8?B?K3VNWXVkem5UT1d6ekF2bUZmVWgreDF6YkMzWkc3aGJmY2NReXRzS3NWWUhz?=
 =?utf-8?B?dldBUGJHRnNmcXJQYkdna2psRFZmQVNYSytOZ2FMOEtqYkc2V1FjVmc2K2hl?=
 =?utf-8?B?S2kzd0lFVXppQ1pkSkFNRUdNSzFJZVhTQXptQkFPS2daWmZNNzVQZDlPYXR5?=
 =?utf-8?B?YWR0T0pkZWV1TmpmUDB6S3phTlNHSUZtUjNoWEhnUmt6Q2I4Z0I0K0JoU01q?=
 =?utf-8?B?aTdHMWtRa1hoMjhSa1JUNlYrQUwrUkxnMnU3Q1lkbWpPRm1aUzkyVzcvMHlV?=
 =?utf-8?B?dnVNSEdEcTlXcktvVGI0MlJ3OXV4UnlLZm5tYzhNaEJuL3J5NExEOVFxbTFu?=
 =?utf-8?B?ZWRFeUFWd3JzUG5YYVh1K2h1WmxpTy91UnRzcDU0WC8wQjNselEyeldmVGJs?=
 =?utf-8?B?RW95QXpwT0hBUzRCZ1QzUC9pZTlaOWRTVXg5a3dHeEc3OXBYTXBNalRxd1lK?=
 =?utf-8?B?ZTN4SEVaSjhhVzBEYzZpS2Q1ZFlPempkL3RFMzZCK2c1K2ZGUzZodFIvRmoz?=
 =?utf-8?B?bWVnQnR1cmJ5TTBWd0FZd3htWkM2ZmcrT1FmUnJsMi9sMGtCUUZac3ZzQ3A3?=
 =?utf-8?Q?xE7Utw3ojquXmURF7nTBB6s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFFE035DC4D1DE499F5C5BB5F5426761@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a509f-7257-494b-95e8-08daadfc17c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 15:52:26.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3xvkXg2B2D+7XyTCX0JuXC1Wrcl7odD5kGIrd2FpcypnLpFFeVvEU3KzTjgC6OT4W+gJYZTUMW+p3AkmStNNoWX2U5FKMP01uu64VrOyiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDExOjQxICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6Mjk6MDdQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gRnJvbTogWXUtY2hlbmcgWXUgPHl1LWNoZW5nLnl1QGludGVsLmNvbT4N
Cj4gPiANCj4gPiBUaGVyZSBpcyBlc3NlbnRpYWxseSBubyByb29tIGxlZnQgaW4gdGhlIHg4NiBo
YXJkd2FyZSBQVEVzIG9uIHNvbWUNCj4gPiBPU2VzDQo+ID4gKG5vdCBMaW51eCkuIFRoYXQgbGVm
dCB0aGUgaGFyZHdhcmUgYXJjaGl0ZWN0cyBsb29raW5nIGZvciBhIHdheSB0bw0KPiA+IHJlcHJl
c2VudCBhIG5ldyBtZW1vcnkgdHlwZSAoc2hhZG93IHN0YWNrKSB3aXRoaW4gdGhlIGV4aXN0aW5n
DQo+ID4gYml0cy4NCj4gPiBUaGV5IGNob3NlIHRvIHJlcHVycG9zZSBhIGxpZ2h0bHktdXNlZCBz
dGF0ZTogV3JpdGU9MCxEaXJ0eT0xLg0KPiA+IA0KPiA+IFRoZSByZWFzb24gaXQncyBsaWdodGx5
IHVzZWQgaXMgdGhhdCBEaXJ0eT0xIGlzIG5vcm1hbGx5IHNldA0KPiA+IF9iZWZvcmVfIGENCj4g
PiB3cml0ZS4gQSB3cml0ZSB3aXRoIGEgV3JpdGU9MCBQVEUgd291bGQgdHlwaWNhbGx5IG9ubHkg
Z2VuZXJhdGUgYQ0KPiA+IGZhdWx0LA0KPiA+IG5vdCBzZXQgRGlydHk9MS4gSGFyZHdhcmUgY2Fu
IChyYXJlbHkpIGJvdGggc2V0IFdyaXRlPTEgKmFuZCoNCj4gPiBnZW5lcmF0ZSB0aGUNCj4gDQo+
IHMvV3JpdGUvRGlydHkvDQoNCk9vcHMsIHllcy4NCg0KPiANCj4gPiBmYXVsdCwgcmVzdWx0aW5n
IGluIGEgRGlydHk9MCxXcml0ZT0xIFBURS4gSGFyZHdhcmUgd2hpY2ggc3VwcG9ydHMNCj4gPiBz
aGFkb3cNCj4gDQo+IHMvRGlydHk9MCxXcml0ZT0xL1dyaXRlPTAsRGlydHk9MS8NCg0KT2ssIEkn
bGwgc2NydWIgdGhlIHNlcmllcyBmb3IgdGhlIG9yZGVyLg0KDQo+IA0KPiA+IHN0YWNrcyB3aWxs
IG5vIGxvbmdlciBleGhpYml0IHRoaXMgb2RkaXR5Lg0KPiA+IA0KPiA+IFRoZSBrZXJuZWwgc2hv
dWxkIGF2b2lkIGluYWR2ZXJ0ZW50bHkgY3JlYXRpbmcgc2hhZG93IHN0YWNrIG1lbW9yeQ0KPiA+
IGJlY2F1c2UNCj4gPiBpdCBpcyBzZWN1cml0eSBzZW5zaXRpdmUuIFNvIGdpdmVuIHRoZSBhYm92
ZSwgYWxsIGl0IG5lZWRzIHRvIGRvIGlzDQo+ID4gYXZvaWQNCj4gPiBtYW51YWxseSBjcmF0aW5n
IFdyaXRlPTAsRGlydHk9MSBQVEVzIGluIHNvZnR3YXJlLg0KPiANCj4gV2hpY2hldmVyIHdheSBh
cm91bmQgeW91IGNob29zZSwgcGxlYXNlIGJlIGNvbnNpc3RlbnQuDQo+IA0KPiA+IEluIHBsYWNl
cyB3aGVyZSBMaW51eCBub3JtYWxseSBjcmVhdGVzIFdyaXRlPTAsRGlydHk9MSwgaXQgY2FuIHVz
ZQ0KPiA+IHRoZQ0KPiA+IHNvZnR3YXJlLWRlZmluZWQgX1BBR0VfQ09XIGluIHBsYWNlIG9mIHRo
ZSBoYXJkd2FyZSBfUEFHRV9ESVJUWS4gSW4NCj4gPiBvdGhlcg0KPiA+IHdvcmRzLCB3aGVuZXZl
ciBMaW51eCBuZWVkcyB0byBjcmVhdGUgV3JpdGU9MCxEaXJ0eT0xLCBpdCBpbnN0ZWFkDQo+ID4g
Y3JlYXRlcw0KPiA+IFdyaXRlPTAsQ293PTEgZXhjZXB0IGZvciBzaGFkb3cgc3RhY2ssIHdoaWNo
IGlzIFdyaXRlPTAsRGlydHk9MS4NCj4gPiBUaGlzDQo+ID4gY2xlYXJseSBzZXBhcmF0ZXMgc2hh
ZG93IHN0YWNrIGZyb20gb3RoZXIgZGF0YSwgYW5kIHJlc3VsdHMgaW4gdGhlDQo+ID4gZm9sbG93
aW5nOg0KPiA+IA0KPiA+IChhKSAoV3JpdGU9MCxDb3c9MSxEaXJ0eT0wKSBBIG1vZGlmaWVkLCBj
b3B5LW9uLXdyaXRlIChDT1cpIHBhZ2UuDQo+ID4gICAgICBQcmV2aW91c2x5IHdoZW4gYSB0eXBp
Y2FsIGFub255bW91cyB3cml0YWJsZSBtYXBwaW5nIHdhcyBtYWRlDQo+ID4gQ09XIHZpYQ0KPiA+
ICAgICAgZm9yaygpLCB0aGUga2VybmVsIHdvdWxkIG1hcmsgaXQgV3JpdGU9MCxEaXJ0eT0xLiBO
b3cgaXQgd2lsbA0KPiA+IGluc3RlYWQNCj4gPiAgICAgIHVzZSB0aGUgQ293IGJpdC4NCj4gPiAo
YikgKFdyaXRlPTAsQ293PTEsRGlydHk9MCkgQSBSL08gcGFnZSB0aGF0IGhhcyBiZWVuIENPVydl
ZC4gVGhlDQo+ID4gdXNlciBwYWdlDQo+ID4gICAgICBpcyBpbiBhIFIvTyBWTUEsIGFuZCBnZXRf
dXNlcl9wYWdlcygpIG5lZWRzIGEgd3JpdGFibGUgY29weS4NCj4gPiBUaGUgcGFnZQ0KPiA+ICAg
ICAgZmF1bHQgaGFuZGxlciBjcmVhdGVzIGEgY29weSBvZiB0aGUgcGFnZSBhbmQgc2V0cyB0aGUg
bmV3DQo+ID4gY29weSdzIFBURQ0KPiA+ICAgICAgYXMgV3JpdGU9MCBhbmQgQ293PTEuDQo+ID4g
KGMpIChXcml0ZT0wLENvdz0wLERpcnR5PTEpIEEgc2hhZG93IHN0YWNrIFBURS4NCj4gPiAoZCkg
KFdyaXRlPTAsQ293PTEsRGlydHk9MCkgQSBzaGFyZWQgc2hhZG93IHN0YWNrIFBURS4gV2hlbiBh
DQo+ID4gc2hhZG93IHN0YWNrDQo+ID4gICAgICBwYWdlIGlzIGJlaW5nIHNoYXJlZCBhbW9uZyBw
cm9jZXNzZXMgKHRoaXMgaGFwcGVucyBhdCBmb3JrKCkpLA0KPiA+IGl0cyBQVEUNCj4gPiAgICAg
IGlzIG1hZGUgRGlydHk9MCwgc28gdGhlIG5leHQgc2hhZG93IHN0YWNrIGFjY2VzcyBjYXVzZXMg
YQ0KPiA+IGZhdWx0LCBhbmQNCj4gPiAgICAgIHRoZSBwYWdlIGlzIGR1cGxpY2F0ZWQgYW5kIERp
cnR5PTEgaXMgc2V0IGFnYWluLiBUaGlzIGlzIHRoZQ0KPiA+IENPVw0KPiA+ICAgICAgZXF1aXZh
bGVudCBmb3Igc2hhZG93IHN0YWNrIHBhZ2VzLCBldmVuIHRob3VnaCBpdCdzIGNvcHktb24tDQo+
ID4gYWNjZXNzDQo+ID4gICAgICByYXRoZXIgdGhhbiBjb3B5LW9uLXdyaXRlLg0KPiA+IChlKSAo
V3JpdGU9MCxDb3c9MCxEaXJ0eT0xKSBBIENvdyBQVEUgY3JlYXRlZCB3aGVuIGEgcHJvY2Vzc29y
DQo+ID4gd2l0aG91dA0KPiA+ICAgICAgc2hhZG93IHN0YWNrIHN1cHBvcnQgc2V0IERpcnR5PTEu
DQo+IA0KPiBQbGVhc2UgcmVzdHVyZXR1cmUgdGhpcyAoYW5kIHRoZSBjb21tZW50KSBzb21ldGhp
bmcgbGlrZToNCj4gDQo+IA0KPiAgIChXcml0ZT0wLERpcnR5PTAsQ293PTEpOg0KPiANCj4gICAg
ICAgICAtIGNvcHlfcHJlc2VudF9wdGUoKTogQSBtb2RpZmllZCBjb3B5LW9uLXdyaXRlIHBhZ2Uu
DQo+ICAgICAgICAgLSAuLi4NCj4gDQo+IA0KPiAgIChXcml0ZT0wLERpcnR5PTEsQ293PTApOg0K
PiANCj4gICAgICAgICAtIEZFQVRVUkVfQ0VUOiAgU2hhZG93IFN0YWNrIGVudHJ5DQo+ICAgICAg
ICAgLSAhRkVBVFVSRV9DRVQ6IHNlZSB0aGUgYWJvdmUgQ293PTEgY2FzZXMNCg0KWWVzLCBJIGlu
Y29ycG9yYXRlZCBmZWVkYmFjayBmcm9tIHlvdXIgZWFybGllciBjb21tZW50LiBTb3JyeSBmb3Ig
YmFkDQpjb21tdW5pY2F0aW9uLg0K
