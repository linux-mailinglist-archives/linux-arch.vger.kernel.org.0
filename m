Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72E5F39A5
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJCXL7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJCXL6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:11:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82842E99;
        Mon,  3 Oct 2022 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664838717; x=1696374717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CkFh/Y+HZSRLLvVbYTenXcFMf7jvcRGZfCm5PK+WE/E=;
  b=BpFsAVvWOawv4aJdSuHv/YzqMFlTmJnhUc6QNHz2BN2sgvxx5ZEg88Ev
   zjiBmHF4Db5nRsRFqlvN+NWV/1ZXG/mlpMd9La8Zqr9LilWkTk+m6g86k
   xgdbKS/JoAC+L8SKeROPzd9J521Tl1DiKIS39e5vV0AB078sL+J/3YQwr
   XxvSwjm64Q9NxktbjnaSEtlrakzZ2OtxeVvCnCjgoVIXVnT+A6d8XnMad
   ssmx+ejqI8qbcJ9xx3zUp1gzBLYjDNjngD6sJoTR01OlkAuFDOrUP2O3X
   H5xJOOB7XvBrqQUpbAIs15KB29m1Zli6vA0uA7Jsb3TB/e01ODQDGNRXh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283147184"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="283147184"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="618917076"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="618917076"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2022 16:11:56 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:11:56 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:11:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 16:11:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 16:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVieriVVWngzhNbbXIEn/WgVZ/C3cSSkxqyKKVPEYgqWNKAsXYinrl3mi/JoKoq9ZgBumx98T6ZBukr7xtNRCB6wPeXvcgUGuwtoV8mTgtUpPRQuECvfoocBat85oczJrWhhKQdn102Hxc59n2pSd+2HN+R5J0NKFQoznbke83fZUP5BT+kqb25xB2ZlrhuIei/jVZej4q2Lx6BE0WLCxFG0vudBKYZPahvSUa2k9jl8KWI2YSIM3dT0u8Dko/17Ax4HGcUXuHimdEEuOjxU7ceXibI4cGzItQvgo+Z+qfKdb10AEu09BbS47H23+9nimO5rrz4Jk4TvWhYkm7UWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkFh/Y+HZSRLLvVbYTenXcFMf7jvcRGZfCm5PK+WE/E=;
 b=VolIqPOLzPj+5V09O/vJLc7z4hwdW9CZ8npTvucBOAI0kNmcHCSdxzZVA2/7nVqocaxbfQajIEHHEEiZY75j6xKRwrdY2pTLbkWZenU3pC79BQTs3a4y38ID082PmVOf45qGiMMCCWkMLIMFH/ggKoNyS/l5HD3dSWElFXz5auSjPYK2fZCSEFWtm2YQJ/BqhNeiWNKZ28Mqsk0B1P0Edun6ZSJDkHv39dg+Hm2FYx0Wb7kUe+0bjthaGLZfeja5cXvVW+JBXhBTeWWye1E01IEwWCYveydVg08/7W+E9iodIMQfyBCSk9+nKraSFiutTwkU2HHvtb0+7v10/Vn0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB7142.namprd11.prod.outlook.com (2603:10b6:510:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 23:11:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 23:11:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Topic: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Index: AQHY1FMIU7BZJQMEy0SHUZZeq6SSP639TNeAgAAFcoA=
Date:   Mon, 3 Oct 2022 23:11:30 +0000
Message-ID: <d5a295a57c3c9a18441e03e608900441ae4dc657.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-8-rick.p.edgecombe@intel.com>
         <4e145653-a62c-e4ea-dfa7-f18c0282c315@kernel.org>
In-Reply-To: <4e145653-a62c-e4ea-dfa7-f18c0282c315@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB7142:EE_
x-ms-office365-filtering-correlation-id: 6274fca7-59e9-4b77-946a-08daa5949b64
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpwBOT3XKzWOU+tpRYPegDxV/dLVGmAl+MPB2vSJ8haVEV2YoToNDZVqb6gWOJ49oSRQ7GwiGAnzytFTBaaQQ8uikksOmQ0OjYNOY1/SW/taxUvcvvUp0CtFLZV9Lss44gJLzDADtehjS0mu+9TVy0s5VKfiwI6j8OjEOiQmx/pXY8YlE/42giIh4Rcr9nlaPjBDdKv9zRVz0erb6Bdl3grYJU3UEITkEwFfUGc66/CGKH8H8brir9t5/extJGUPN39r3XsaNEbD56A4fs9RmezRkL88G2Ccb/2xKvPOtiKhBtSclM4P5sm6SFa2/NswqUedPmOx9KcYXT8c5Pzm7OCFEk/4tYRtgR+HxkY9iRNZYnVlF4cwbRnRUypj1SrDuDLhqJWWbr/VTrXfKgqTun9zzrjJxKFsK3MNgvQ6RH2J1HdMyi34bDyffnITJLkVEEUnskePepW6KY87MSRhiHBqc/cvmOcd7PsQ4x3Vic40o7fXkLCrZxqQ/8raT6kxJPH+mRVfuJfY7aCf1LTTc7mPp7Or9WBWAzzqfDayVmLKixZ4tsVsECr1JHqcXhPhGXwIE10ZLuf5KYbEP9DOS5IfLJD/4tigWk5d7tfZG9nicVSdJhl6Olv8sF5iolxToEuRuLnMdHrJaI2FcmCujO2kV8p8xmExedRuTgny0sLYxczGKNRRqt7tWLTzaGNz6RDec3SEDLDZFkQem2kmT8AKuI7HpE0oVRApAP6vCebSf2C0hFrB4D2o+7MCTPNNbbVTNEn+YyejJp8+pZR4MHgKaX+siu7I/a9jHMzLxa/6nEBkm4wh8vVdtTlfbJ0X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(7416002)(5660300002)(8936002)(26005)(36756003)(41300700001)(6512007)(82960400001)(6486002)(76116006)(66946007)(91956017)(64756008)(66446008)(66476007)(66556008)(186003)(83380400001)(2906002)(4326008)(8676002)(2616005)(54906003)(122000001)(110136005)(6506007)(7406005)(316002)(53546011)(71200400001)(921005)(38100700002)(478600001)(38070700005)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpjckVrQ25acENvNmxKamRDTmVyL0IvWXl2ejhGR3REKzJ2ZXFSMFJrQWNi?=
 =?utf-8?B?MVpuaWdOVmJQM3BqYllWanVWY3BKN0k0UlMrZzdUcWJHOHhRNTdsbjNzQ005?=
 =?utf-8?B?eWpobk1lRWhyOHpERGFYOUpRd293Zll2K3liUnhvQlhlU0d1R3JQbGRuN0F6?=
 =?utf-8?B?REcwdlp1NnVaWGpxd3N0eVVHdnJXNTRtbnowdTMzYzQvamEvdVhWTTl3V1Bj?=
 =?utf-8?B?Qkt6Y2ttSGhMNUE2eWo0UjBCZkpFV3NaYzlkTUlmcEZ0L0lvZXBwemdCbTFZ?=
 =?utf-8?B?UURxOXZPLzJ1ZUVuWE0xeCt6YWdoTHNNUFRoV1pSNW1QTXZNeC9NajNuZHhN?=
 =?utf-8?B?Ujhtbm5oYjByNmJleGRmNVovZnN6LzdLd2lsUUc0eVRoY1pONDVHOUV0TU8r?=
 =?utf-8?B?d0VLVXhBZ2JsYWpUUVFxdlhjcjUyMjVzTlIxZTlSazM4K0o3bWJuRmFqS2tZ?=
 =?utf-8?B?SGVvbDRJUEdTVHorN0ZsTkprNUNzUnJOeVM3QVdEQWxacmRIMTlSeEVIOVRx?=
 =?utf-8?B?YnJmQk1TeTd0WCtIRWlkMXQwUFVTcTUxQ05jblhzM2Y0NUt2b3FxTmJpbnBs?=
 =?utf-8?B?d3duV3JQSGFIclJadnJka0ZaMDJLbnQzOUZNS0xXeENXOUU0WnZZa1dZUzBv?=
 =?utf-8?B?cmxJNHJOSnpIMU5taTM1VkNwa1NMYXBMU0grS0RlQWZHNlFVMGY5M0VXdmVG?=
 =?utf-8?B?ZnVTNVVrOFB4QmZKa2Jza0RqU0k0Q2Q5bzF6aGd4OHZCNjZsbEZvYStRZkx6?=
 =?utf-8?B?ZnZzUHFFcjgyd1ZLY1VNVkFNekh4Nnd6WlJZSTdXL2RUY0hqL0JzUk0zMmxJ?=
 =?utf-8?B?KzZXSWhMQ01lMmREblRBSWxJSnpwd0owSnZoN3FUUXR3VEJSNjFyaDRIR0lZ?=
 =?utf-8?B?MU9IMU1wSDRzTElqNERoV1F6cmh6RmVpOUhEbGRkNnc5SzVaTGM4OFJhREVj?=
 =?utf-8?B?b3A1L3hEQzd2UzhvUGNLWVN3a0RjS1FWV1V6Q0RBY0ZPZ0NpdGFuZklteFFi?=
 =?utf-8?B?Uy91TTF0UXNUMy9lajJPenR5MFpLeEtsRDhJeEFFK2NIcHNEa25LSVRnVTRn?=
 =?utf-8?B?Y05vVDdXRG9oR0wzSHJpL2lYOGd5N2QrQnZsU3dPa0g1TWVVWHVMMHpPbHNC?=
 =?utf-8?B?bWkxaVpWR1E1aW1EWERzOUM1R1ZmS2w3cVpUZVArM1ZZREZMb0NWblJMNWxq?=
 =?utf-8?B?ZWRmVkZoYndvc1VIR0JsRWhMcHhzbTVlUkxsZTl6VldYdTVVRkI1c2pwMjFO?=
 =?utf-8?B?VkY3S2ttN3lqRHJjR3BiYkZHM0FrUnRwQnRVQzVGUnVNNTB0VmRueFgraXYz?=
 =?utf-8?B?MzZNZ3d1UEJHK2RUTWJEQlhVNmN0SEtrZ3ZPcmNKUXhmRUZvRUgrRmF5L0Nr?=
 =?utf-8?B?dlp5TWpHNUtybEl2YWkxLzN2RVU0UGZlblA0VkM2SDNuQjlmT1B1dUtJZHhj?=
 =?utf-8?B?aVhUUVE4YUxNam9rS255RGJqZDltWlUrNFJ1V2FCbGNVTE9XSlh0N3ZiOGxL?=
 =?utf-8?B?cG51VUFKdUxsT01mcHQ3UkJKRkYxWHA0V0VsZDczajhlYVA5NXRUNmJITTNM?=
 =?utf-8?B?MGtqN0hsNWtmNW45eTVYUUpBdy96OEV5NEhudS9IQTE1dWlkUHo0UExBQnRE?=
 =?utf-8?B?OERYN3dJbUJ4K2k1OTlkNStCcm1LQVk4dDI3SmxScnhBWUg5Y2R1VlR3Tnph?=
 =?utf-8?B?ZXdZUkpvTWhBVHdDSmZWYlpYaFBCUDFrTm9XdmN4RXN2VkR1cW45TStMOWd6?=
 =?utf-8?B?OHl6OTlYNzJRYldPWEE3RXUwS0Z6bGtPTkl0dTNZaDYrUkxsSEp6NFIzOVJS?=
 =?utf-8?B?Q3U1VmlOLzZOWG9iQmtlOXB2NGdaYTBiV3EwMG5COVk5eXp4aGdVL3dZQVhO?=
 =?utf-8?B?MktkUWtVTVB5VlQ2K3ozVWZGeTlpeFZyTWI0WkVVN2VFV2xIQ1Q0VjgvdjNJ?=
 =?utf-8?B?RE1oUHd1VW1Hb3RmRmZhOE9mN2N0VFdGMVdkYTlocDNDcVV4STF3ZzFBOWtF?=
 =?utf-8?B?bmdsVTI0TStqUm5FU1pXZjlmeDdUeUhQL2NVYTJYR0Q3WVNOaW9mNXlBNGd1?=
 =?utf-8?B?aWpodXFwT0NUTDJPK2R3cVAxQ2MzZHNSRXEzWWdXZEozejNYTUcxY3BGR2lx?=
 =?utf-8?B?UmoxS1NPVm9Wa3ZObGU1dVhjU0Q3RXBBVEFBSmF0TmNuYjhYUkkyWExBT29V?=
 =?utf-8?Q?LFiee3YO4/Le0oSVejMD9P0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1146B30920C6F4F83DACEFBDA734258@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6274fca7-59e9-4b77-946a-08daa5949b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 23:11:30.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hky5hrW+2y2vdq3G5P/oCUyXIo63UMJaUVajg6FLArEQfGYPOGTgnWbi6mO/q7lslQp2qvf5Zdkbz0ZHxMUbFv2py00RB0kyVlvOwZAkZ1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7142
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE1OjUxIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIDkvMjkvMjIgMTU6MjksIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206IFl1
LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gK3N0YXRpYyB2b2lk
IGRvX3VzZXJfY29udHJvbF9wcm90ZWN0aW9uX2ZhdWx0KHN0cnVjdCBwdF9yZWdzICpyZWdzLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nDQo+ID4gZXJyb3JfY29kZSkNCj4gPiAgICB7DQo+ID4gLSAgICAgaWYgKCFjcHVfZmVhdHVy
ZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpIHsNCj4gPiAtICAgICAgICAgICAgIHByX2Vycigi
VW5leHBlY3RlZCAjQ1BcbiIpOw0KPiA+IC0gICAgICAgICAgICAgQlVHKCk7DQo+ID4gKyAgICAg
c3RydWN0IHRhc2tfc3RydWN0ICp0c2s7DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBzc3A7DQo+
ID4gKw0KPiA+ICsgICAgIC8qIFJlYWQgU1NQIGJlZm9yZSBlbmFibGluZyBpbnRlcnJ1cHRzLiAq
Lw0KPiA+ICsgICAgIHJkbXNybChNU1JfSUEzMl9QTDNfU1NQLCBzc3ApOyA+ICsNCj4gPiArICAg
ICBjb25kX2xvY2FsX2lycV9lbmFibGUocmVncyk7DQo+IA0KPiBJIGZlZWwgbGlrZSBJJ20gbWlz
c2luZyBzb21ldGhpbmcuICBFaXRoZXIgUEwzX1NTTCBpcyBjb250ZXh0DQo+IHN3aXRjaGVkIA0K
PiBjb3JyZWN0bHkgYW5kIHJlYWRpbmcgaXQgd2l0aCBJUlFzIG9mZiBpcyB1c2VsZXNzLCBvciBp
dCdzIG5vdA0KPiBjb250ZXh0IA0KPiBzd2l0Y2hlZCwgYW5kIEknbSB2ZXJ5IGNvbmZ1c2VkLg0K
PiANCj4gUGxlYXNlIGVpdGhlciBpbXByb3ZlIHRoZSBjb21tZW50IG9yIG1vdmUgaXQgYWZ0ZXIg
dGhlIA0KPiBjb25kX2xvY2FsX2lycV9lbmFibGUoKS4NCg0KVGhlIHRoaW5raW5nIHdhcywgd2Ug
d2VyZSBqdXN0IGluIHVzZXJzcGFjZSBhbmQgd2UgdG9vayBhICNDUC4gU2luY2Ugd2UNCndlcmUg
aW4gdXNlcnNwYWNlLCB3ZSBoYWQgYSBsaXZlIFNTUC4gQWZ0ZXIgd2UgcmUtZW5hYmxlIGludGVy
cnVwdHMgd2UNCmNvdWxkIGdldCBzY2hlZHVsZWQgYW5kIGl0IHdvdWxkIGJlIGluIHRoZSB4c2F2
ZSBidWZmZXIuIFNvIHdlIGNhbiBncmFiDQppdCBmb3IgZnJlZSBub3csIG90aGVyd2lzZSB3ZSB3
b3VsZCBoYXZlIHRvIGZvcmNlIHJlc3RvcmUgaXQgYW5kIHJlYWQNCml0IGFmdGVyIHdlIHJlLWVu
YWJsZSBpbnRlcnJ1cHRzLg0KDQpJIGNhbiBjbGFyaWZ5IHRoZSBjb21tZW50cywgdW5sZXNzIHRo
ZXJlIGlzIHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoYXQNCnJlYXNvbmluZy4NCg==
