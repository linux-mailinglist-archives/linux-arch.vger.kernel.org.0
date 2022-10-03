Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22EE5F3559
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJCSM2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJCSMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:12:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0BA3FA0D;
        Mon,  3 Oct 2022 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664820742; x=1696356742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=alkPRuChantdmtVBVaMOuyJUgdJAWLs2MuMwxCXS5Ig=;
  b=gUx9Au32BXvwFAEzmaDJubto6BBSM503dkyaQnRL4Wwto50tTCVteqEp
   OFeLNv77MUBMuYqneFOYbZXE363VBceH2m1Gi6fczXCKDfSn0qucKvdyh
   zW8UZY2iH7OpGxjp4cpf9rlY5Nlwr0XiKUwYol03ztKKakRt/V+734FxV
   5ocvHj+KfbbnKts2vdVBUJh646L3xk/CVRQ6WRbcZANWk8bu7c7atLNj+
   4yhZ/EnzuVqVMUu+v4KNxadkjIBYsa0oGTMZUVExeCbJZIQFjBCUbrxkz
   4nIF3R2dovLpCLKP7ov2l9D+KQcBtEdBkXBLBCwbxEW+3IDR1yJ8aP2Nx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="389009676"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="389009676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 11:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="798834205"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="798834205"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 03 Oct 2022 11:12:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 11:12:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 11:12:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 11:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InZW2Q4mQ4WAVIhXyTjvT5wbcDtDJEBfC3Y0K2P84QResPGMhX17hwE+Kn6q77Jrp3sh4Jd7g+7+95iQt3PTQ5DG4GKYHtLPKoPiWDdtHbzhkGZU8h6pjR1bbn/IznodRgMKkGw2fdub21dPLmSVipN7ygVISIpZjn8B0DVPJlV1ucmnmO7ELq9V5mviN8Ui3MsqU2tMwJDaJQVG9VsP7AF9GQyjYlmFw8Fh0mTRAK4NMWPztHNBa/9YF8kjCMeRVxBT7beK+MuOFn3GR8B1yrlkO3eAXGZvKMqLwarCifFBEzsqIvnVarj51P/AU6cJqC1wZ9opWaWSbYX5sUfMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alkPRuChantdmtVBVaMOuyJUgdJAWLs2MuMwxCXS5Ig=;
 b=daG4/RQZntJHBwCkczdPEOnaR+x3YPDFJc7XR/yKODxFzPlOsfIUUl/7wvLGoB2fQYjzy/aUFxr1rnf0jsERwJ0D9fEWwrdQZ4Y21O1O7FQaJdy83l7QgopmLmciM2lbYhS3OYeYYKajpWbeM3oZf/cCE8av87vcwk8z32aTkH3+J3iHMkFuPF3aYjqQWj6C6vEOgQDR1zGsbj7ERieu0ULvC8jtXOt5MefG3SAmk0j5LWHTK0fJM204uQmjs0iBVfPzOzENOppEaHnTONNttHaHSsWnss400JHiwy4J4e2zb10MA3XD50dG6nwV2BqqVY2mTna6iXnVDpjbEJXfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 18:12:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 18:12:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Topic: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Index: AQHY1FMIU7BZJQMEy0SHUZZeq6SSP638uIaAgABGJoA=
Date:   Mon, 3 Oct 2022 18:12:13 +0000
Message-ID: <405e6b57ea18f200403f0c9044120ff92a47431a.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-8-rick.p.edgecombe@intel.com>
         <20221003140109.jgn3per7vbthifn5@box.shutemov.name>
In-Reply-To: <20221003140109.jgn3per7vbthifn5@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB5100:EE_
x-ms-office365-filtering-correlation-id: 9bcf1f00-554a-4944-23c6-08daa56acc2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7TeyP/Azi5MseADMuel8mEyUNbrmDEDoszyP5FvIG7/o0HIWvdw9t4t1EBa+OSvKCR6Ru3xlQ/CW2UQxDUWrA14UKaQaQAf/tWMkCCBKv2sY7AQhmui0dwNcmHgXLEuG4iQn8tbLXoJ0REaWuqMckjtxpuBIJ0UIohS/z3D2pVDtcoEoLbO5dxrTr9E6oD5eGUR7ye6h6I6hfujmlUk9DS/uyuoKVioY4C/p8BJNQSwJPb/0+xcpgt7Klai0bAMqOAPojP8IkH1Me7KGhMrSkYhfV+PVDDmCKk7xKD76yuH4ngMSvAKhkelKzgDG9ZzzI/8qqH8eJfSJNC+LwUgcFJFuUkKSYhFZso3YoWHIU5kemuuYl9LyglMMC8WmR/gWpHRFYdf6aCtkEifbRcEmGpLcxl08x60fGy5JdukxCxLlkkxPZH8a6LNCT4g5tOoaGybJM4sybW7tcWwtvWukRnKtjZl5TWR3yXk/0Xu4ODFqTLozy7LQbXKnsEwFd5NuCvGccMDV/V/foyRXXtoOIOH8U4W9j8c4LgIFzY6rxsATfFAvMFbWJM52aV32jgr2xTtNUo8qqNteL/n2ccokKObcNX8OVBrLe4jeQL38Q6fYnzaUBpEsfMwHhHXjAxBJ35tD5cOv0Vu/Tr8VuN8oLDTvN04rve2R3s6M8x308WFVyu0a28fMXdw0PEq1WUvYT8JgdrJuj1SfOEu/7XSYqKoxoRez+JlJQGrJI1FJj0ihIvi2OCKVUbwiYpZTV9VRoKCAI5PFUKKw48iZhhFEtElRo/PU36aMhmQYWAp3Sm80QuK9ntVzA7a6wZ9o7ae
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(6916009)(54906003)(966005)(316002)(478600001)(66476007)(71200400001)(76116006)(66946007)(4326008)(8676002)(5660300002)(6486002)(66446008)(64756008)(66556008)(26005)(4744005)(86362001)(7406005)(38100700002)(2616005)(6506007)(8936002)(36756003)(82960400001)(41300700001)(2906002)(38070700005)(186003)(6512007)(7416002)(83380400001)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTIvV051Nm9JSmRoQzVDVG1qZXZ1Mzloc1F2SFZPZm53cFBCam5CUnRNTlBO?=
 =?utf-8?B?QUNlQVRIR0FpOGYwTUJYb3JSVU9XaG9EcVhFSFErZWJxZEdOeGZTamd4NGVj?=
 =?utf-8?B?OUFHOUFYTDU1NzViNUFUV1VNUk85dXZZblpleVJPMUlnLy9IWnEwMkRHNnVo?=
 =?utf-8?B?NkFRZXJpdEVPUGs2ejRTQzVueDhjOVp6SC8rL3gxQjBoU3dTaitLOVRxV0xh?=
 =?utf-8?B?aDFLb29XenZLeWNldUhBOWVzSFNkaVVob3ZpSC9SYjRIM2J6Z0U3R3hFcHkv?=
 =?utf-8?B?YllWWmFJOVdXTUNQdHgvcmxYUDRRNlRReVo5KzVydGZzaTA4Mk81N2dZZVBE?=
 =?utf-8?B?VDB4azF6bCs2NUFOQWw2YVUyY2JnVlV5cVZHZVJyTUR2NUFTRUkxbVR6d0o5?=
 =?utf-8?B?WG9ISHpxYnJtWWRUaTZaSERLMmtpZGFEaXJKOTRjNnphTmdTSFM4YlVvREh4?=
 =?utf-8?B?WkVPd04zWFoyNjlYK3ZQcHUxdXljUWxMRGloZHliRXRDUDIzcGVQVEJ5MzNv?=
 =?utf-8?B?WHBSbFNFNi96SXRBQmlxeHV5NzVBSkRrbmNZUzQ2azFQV3JsM2IvZElTMjhr?=
 =?utf-8?B?cS9sTU5wQm9OS0FoTnFwdkVDak53SjBoOFdzR0d3cUlNU0grUGdCM0dkczRQ?=
 =?utf-8?B?emZJekRDMWttYXpNVVkxaEZMNmZlUW5QQXNPSHhteERPa2Zpc0VJN3hHOWIv?=
 =?utf-8?B?bHhBcGRBRzVacHU1b1lyMXo2N2VIQklGbVpJYmNkeFNNeFRDNnR0ZVRhMnhr?=
 =?utf-8?B?WE1mSGRDZ29yV2NwTHFBNzBkcGVKSmhJMTdmeWRaUHFsMVAxc2pCS041VkJ6?=
 =?utf-8?B?Ykp0UWhSanV5cXBxNWhnajg1Y045ejlwY3IwZ2xYWC9tQWpHamJ4Z0NZOHVy?=
 =?utf-8?B?dUZLQkptQ2wxOG1WRlNEYjYyVTl6S0ZnS05IS1pRTmNWSXNTMUhmOTA3VmlI?=
 =?utf-8?B?OVhxdTVSUzh2Vm9hTkFJQ1F4ZEJFbU1MSUoyWVFvZ0Q1eW4zMHJhVU1SSmdk?=
 =?utf-8?B?aEF1SkdtVDRkVWl6RldsaXVFOGYrTHN3c2MvMmFBazI3YlBkeXpjdlhkcmxN?=
 =?utf-8?B?NmNJREFER2xnRWRhYklwSVFHN2xoN0prNjhaTmFGbEJsczNsSUJhN1hlQVZz?=
 =?utf-8?B?MXl6czFGUVdWUlkvdWo3Z2R5T0JwQ0RZdXdKdElRMkFYVnBXTjFQK3dqcGNM?=
 =?utf-8?B?MTRZWmVKMXlwazExKzc3MDVHbmIyMjRGTU40bnhEdUxRamQ3Y1B2LzFKS3Bp?=
 =?utf-8?B?M2Fybld5QWY3RzI5clBULzNnK3ZsSjRjSU9UZ1E2YlIxMi82TnNrcUx4eC9U?=
 =?utf-8?B?NVZSeXlRelU4WHcwUDdOdDdDNWNmcGlrZTBuclV1aUJOWUxCVDk3WFN5YXVx?=
 =?utf-8?B?bUNJTk9MQ2JReWVKYVZQVFVSYjZpNnVYR1BKUU0yTTlDZytkOFNVOFJTS1My?=
 =?utf-8?B?MS9rTDZHbUZCV0xOVVdqUTY4blAyLzhWZ2w3SjdURW4rZ2JXSjJSRTJ2cEVL?=
 =?utf-8?B?VkpQS1UzbFk2R2ttWHdjQmpFMW5uTTloRC9mMmdHRFFrZlcxeEUrb0VWN1lo?=
 =?utf-8?B?UGtPT1pYNUtBWjJBYUxLTm5OSlJibmVZaDNsbHcrNXN4dFhXait2Yy90UHcy?=
 =?utf-8?B?RVNMalNsSVdBbWpzbERaTXVxQ3RMOUdwT3NQRkdVcXlRaitLMEQ3K2d0c3ps?=
 =?utf-8?B?RXRtK3llQ0VVMjY3QXVMZ0RPSDR5RXVWdm5wZ0M4TzlhVkxpOGZmdlErSlVu?=
 =?utf-8?B?OFBRZU1heGtnUUpnU0xCUWw2WmtUY250M0Q4WnFkbzFQZVNhdGxEY1paK1o5?=
 =?utf-8?B?TXNtZ2ZVb2crQVpSZGpleXJhSmc4ZE9rcEJjZHhsSFIwQVVyUGpQMXh0cVFt?=
 =?utf-8?B?YTB4a2VVNmp5WTV1NjlpcFZ5VWdoamRNa2dBZDZGTXVKZUxwS00xQmdwTWpx?=
 =?utf-8?B?aW9BbEtvdm5PbC81a3VYWk5GYmhzdUxZVFRNd2V1bGtTTUpia29ndEhRdUNI?=
 =?utf-8?B?dzdXZ1N6NmM5S1JHWXJndTNld1ZuNWxnMTBnejhjV1JicEwwUmZtMkorRkE0?=
 =?utf-8?B?VUZjYjFoTnFwNCtpN2dkcUtOOEpTWGtPNTM4L0lVRjRVY0pWQ0ZaWWFxc3Iy?=
 =?utf-8?B?RThJWVBpU3EzS0pBZHVVL1BaMGJrQ2pRckRaRWlRQ0Nwb0Zua3F5MnFtcERF?=
 =?utf-8?Q?PNOrIBWssGMabxd6KWJgM9o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463338174DB2F7459D15C6D7BA69B280@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf1f00-554a-4944-23c6-08daa56acc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 18:12:13.6948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeYuebFME7EJQ7xsY3+1tFDPKpdD5ekQbm4gI2Rb5axMHB+BrQuc5GMlPfG2FtP0ZHdYUJ/avYwyJtl2kHFx7cz99bOfZfuaWD4DC/IkeXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE3OjAxICswMzAwLCBLaXJpbGwgQSAuIFNodXRlbW92IHdy
b3RlOg0KPiBPbiBUaHUsIFNlcCAyOSwgMjAyMiBhdCAwMzoyOTowNFBNIC0wNzAwLCBSaWNrIEVk
Z2Vjb21iZSB3cm90ZToNCj4gPiArI2Vsc2UNCj4gPiArc3RhdGljIHZvaWQgZG9fdXNlcl9jb250
cm9sX3Byb3RlY3Rpb25fZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcNCj4gPiBlcnJv
cl9jb2RlKQ0KPiA+ICt7DQo+ID4gKyAgICAgV0FSTl9PTkNFKDEsICJVc2VyLW1vZGUgY29udHJv
bCBwcm90ZWN0aW9uIGZhdWx0IHdpdGggc2hhZG93DQo+ID4gc3VwcG9ydCBkaXNhYmxlZFxuIik7
DQo+IA0KPiBXaHkgaXMgdGhpcyBhIHdhcm5pbmcsIGJ1dCBydW50aW1lIGNoZWNrIGZvciAhWDg2
X0ZFQVRVUkVfSUJUIGFuZA0KPiAhWDg2X0ZFQVRVUkVfU0hTVEsgYmVsb3cgaXMgZmF0YWw/DQoN
Ckl0IHdhcyBhIEJVRygpIGluIHRoZSBvcmlnaW5hbCBLRVJORUxfSUJUIGZvY3VzZWQgaGFuZGxl
ciBJSVJDLiBUaGVyZQ0Kc2VlbXMgdG8gYmUgc29tZSByZW5ld2VkIGVmZm9ydCB0byBzdG9wIGRv
aW5nIHRob3NlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA5MjMxMTM0MjYu
NTI4NzEtMi1kYXZpZEByZWRoYXQuY29tL1QvI3UNCg0KLi4uc28gSSdsbCBjaGFuZ2UgaXQgdG8g
YSBXQVJOIGZvciB0aGlzLiBJbiB0aGUga2VybmVsIHNwZWNpZmljIHBvcnRpb24NCm9mIHRoZSBo
YW5kbGVyLCBpdCBhbHNvIGRvZXMgYSBCVUcgb24gZW5kYnJhbmNoIHZpb2xhdGlvbi4gSSdsbCBs
ZWF2ZQ0KdGhhdCBvbmUgZm9yIHRoaXMgY2hhbmdlLg0KDQoNCg==
