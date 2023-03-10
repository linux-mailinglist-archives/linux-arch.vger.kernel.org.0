Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AA6B3299
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 01:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCJAOL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCJAOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 19:14:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81373F16B1;
        Thu,  9 Mar 2023 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678407247; x=1709943247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KFY/IOAZs/TEsyyM/y9UbFOqHf2eLskvllwPZHEStY4=;
  b=fh8Dhw1dGuUuf+qmJo1kQUvFFaZiNpNREf57dYRV+eIRcb/Qh7IND9j+
   X065thCKG3IG8zu+2pOxf42U3wwIUt+Ch2ONN+Dp9/SiHWobLPKgWp2QB
   herY2AeZSdVB4Ax9fgJpxcomvAWVmd2FyitJI6A5vrlAJJY0TqOKxT/TS
   uHo4J5XDJmNRL9SMuYM7ORdEfjafQb6IUpzKam5E2FpKlDB4jkaP4y3OY
   U8OLGon3/AwpFwN1OAZCCp7po9W9n3mt4ktqROXqvOTtF1uR5DSGBQ+WJ
   xbM3NyTGnb3C4jWGklz1FXI3C2DLtUDo0QF3KdhwBL8csftpBgfCGYVnm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316261256"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="316261256"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 16:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="787801014"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="787801014"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 16:14:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 16:14:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 16:14:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 16:14:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 16:14:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIF0eJ+p+d28zjtGJD+wM7WLigfvHrHASg6ahIinFkg56Fe/vo8YW52QKWt9Tk61U8enfn1OEHnQilguNmVB73+S8t+nydcf3AtaxUvbk/RhV9/EPQ6XeKkecsdPC8zTEOMklqjiRIyiPACs053qQ4RuR/1Y9kzWDRerOmV3iZqjh9l7/KDaEfsyF2WqecLjiHiXjhK6UskcFxt9S3mgvhCfNOdoLzJuDlKNGEDzYMNE+Nq9IxO1v9OYOyxFPW4S9qP5cOX1JkL+Zj9HR8kVb4GDqrDABapdUOsRBZQ8VOuTRRRLjkgzwEXPIEfgSNc5a3VuiW/fvwsOEoACFo0k+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFY/IOAZs/TEsyyM/y9UbFOqHf2eLskvllwPZHEStY4=;
 b=QrGU6BLGp+5iOyvP6zmiMXgg5uCy/SAxpMH3XYK4Xf1PEZCJPXVkpkTVqj9eyd4bAeAkpG3ILQ21m3Mnie/Qw6LIyrLM+Xk6feho1qwnFD5584+B3lIaBoBD85aUNo6yRjdi/OhIR7BNToi+mKyarZV3gU2Hq747QadN558J69x7gHZ2+7tKjq1OWn4DfNsiHuySQjD7lawWujLgwiNZfCSqSAYpyAH1Gpp/uHdYDe6qlxLT2HZJC8BVhdJiKzmNZAkC4S38QXx+R+n4g5JglVI2ZoOQl2HHMvyU92vWGP6H/oC7LeQY8q151ZB2LZF7bhDCbw8ThXg18xTRSNNn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 00:14:01 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 00:14:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "al.grant@arm.com" <al.grant@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>, "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZSvtF2ujwSwjQQE2i7wvNH++zdK7nwRCAgAsaUoCAAAxuAIAAGMOAgAAz4oA=
Date:   Fri, 10 Mar 2023 00:14:01 +0000
Message-ID: <a3c951fee51cc05e291d3a570ed485eaec1963cf.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-34-rick.p.edgecombe@intel.com>
         <ZADbP7HvyPHuwUY9@arm.com> <20230309185511.GA1964069@debug.ba.rivosinc.com>
         <aaf918de8585204fb0785ac1fc0f686a8fd88bb0.camel@intel.com>
         <20230309210817.GB1964069@debug.ba.rivosinc.com>
In-Reply-To: <20230309210817.GB1964069@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB8227:EE_
x-ms-office365-filtering-correlation-id: 78ea2b79-9196-43a1-681d-08db20fc59a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUS9ZQkDwkut7QpPO4q7XkDA+zRYnE9r5RGuS5NXJRKaaBvcrucjZ0Xi0oicB0eaS1I1wsidEmVP18J/GcIw2K5PUesXhQYY/pIH3rh8UJCO8l5ktQOGOEsb9bmNE87cXmSfGqrCjTP1S6md3LTtFF6mbsDjrdc2SuAVyimswRpf+HmsAuJcFO8ZWpzv+STRooLDO6PqBZFSNTVjtZf1pQT74IUohe4Mg/C7DSk9Lb5nSuVCI3JAjKDMdnMqbmI/02Q9PcnIyFxYrtlnAa6DpcXOgVMQWz4iX9+1gaGxSzEQK4vK2Er9FNnYJOJ7s/+j8ungjzk/AJP99EJg9REJ9MnqF6qRYyvmYU9SWQHJZdFbfy/y1uWg2NVnBR9lf0HuWNJB3a1ceY4NsDMlLPZNt/aLbjCJcAUxXSolY3MQ+X1HbfyuuHOrfhburKpZIGSsibD+KSFVXE2MJQGBlePEdEw7Ij6nULOGN0ane/X6nxY5YSAMW+2r/gHIa3XSJaHRHXRK2ejHhYqEg2/WZhTJItiiYa+PdO1ix0rXdaym2hjjRhOhfWwKguXdsaa9se/bGXalvnSYKAec2/601XDHXK+ECJZ9jwVzOx4Ky2+F1RYfdLifYi0d7va+TKjPwx4zD6mSBDXcbAiVii4R2NyUG5DH8+RzSjCAMWwD2E9C4Ag67vwmlMqia1aHXr5yR964KmlMoV1sbyg3r629po/cQTFB8lkqgcM8r2nYeWgPOLPGruRo+yftvIiCbM3NJCBi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199018)(66899018)(54906003)(36756003)(38070700005)(82960400001)(86362001)(26005)(122000001)(38100700002)(6512007)(6506007)(83380400001)(186003)(2616005)(316002)(7416002)(5660300002)(7406005)(6486002)(71200400001)(478600001)(66556008)(6916009)(4326008)(966005)(8936002)(2906002)(41300700001)(30864003)(66446008)(64756008)(66946007)(91956017)(8676002)(76116006)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0NRV2Y4ZEN6V1pjK1Z1bVdNaTlYWmh6Q3krQ01HVWpwWXhCMmdFeTlwV1Fx?=
 =?utf-8?B?alE4Q1JpS2JKZWl3UjBjL2RtVFJPWHc5dVdqSW9TZSs2TzVORTJvZGliak9G?=
 =?utf-8?B?WWVlY0JBTGxLWXlWRG9ac28yVytydFhCWWR5Z2drVWJZZy9JT1dJNFZwajEy?=
 =?utf-8?B?Qk5qYkJ5TjBva2dVVC9BbW56cm4yYWU4SkFiNC9zMFhScm85U0tDcHp4V2Ev?=
 =?utf-8?B?bTl4WjgrSCtycTY3dlRweWt6bEcyT050NDdJbE1qVFlPa1RzMzdzekZRb0ZU?=
 =?utf-8?B?anpQZ05mazlOZE1TSmd2YmRZSHRqNE40ZUR6Tm4zc09oNmFYUXppaUJTemN2?=
 =?utf-8?B?enNlemhPTVlXaWhUUU5MRWtIRTcvUVRwcXBicmtLT3lWMlFOSVpnd2ZpYklB?=
 =?utf-8?B?MjZGWmU1MWlNQTcyOEVma21GenovcUdsNUxYSk92MythQmVhbElLZEtyWHJW?=
 =?utf-8?B?TGZna3JhQXZET2ZRRzhkbFJEUWJvMEduVS9OZkhzSnRqRHJja01CRWZMN0JV?=
 =?utf-8?B?a2FKd0J3MVNQMWd1UE96OWJXNUx1emw2MnhDdWEwSGt4WlZKOUt0NkFQOXVH?=
 =?utf-8?B?Nkl5OFpiUTFYZUl0Rkl0VzdQbEhybWRnbTBtSFJJaFFFc2MzQTU4VnF2SWNm?=
 =?utf-8?B?ZHRINUpIYzM0L2J6RTBLOXRDUnhRMkcrZW5IWlk4V2c2Uzh3WnMyUU9yNFdT?=
 =?utf-8?B?eEtYSGMxbTVmWDNDQ1dhVUZranZKWmZBaUVPODdXaHdaY3NtRGpITnV3dEQ1?=
 =?utf-8?B?N3QwdmpRMmRoV3l5ZnQ0YnBIR0Y2SzFIRm1keTJTeDFTbzNyMjdqRER4Z3JW?=
 =?utf-8?B?OXN3eVBIU2ZRdnI1a29keDlCUzZSVlNJZlVOVkY1a1lGcTRnb0Z2WjNNT0hJ?=
 =?utf-8?B?UzdZUnJnaysvbEF0MmlpRHljbXJ4SVEzZXdRTnN2YjljR0h5eXVCUXdJU2xk?=
 =?utf-8?B?dStyMW9KWmZNVlhqdzBuTk1zcU5HamtFOU5VaTErMHZndFpseXRGU3dEMjRW?=
 =?utf-8?B?b3ZQS0F4V3VCbnh4ODYxNWI2d2hidFFLZUlNdG85VHpDOU1hSWJMbmJHaFU2?=
 =?utf-8?B?TkNhNC9tcTNHYkxTcy9RNkcyc1I5SUF2VDd6cEZ6QnZSZ25IeHNROEpyYUJ3?=
 =?utf-8?B?ZlRoMWgwdllnY09tZSs5WjlTcGNmcUFXV3lTWWU0T1hXcVRqenlXWEtGWGI5?=
 =?utf-8?B?V1lDaGNGbGZDS2NzNjFVdTlWZlR1QnNVNktjc1l1Z2hQbk9jUHZ3bVlzdmJY?=
 =?utf-8?B?MVhUUFFhb0VJK0IyR1ZmQ2taV2tuQjdVNGhsSU4yMWVYaGdZckFpVE9hbGN0?=
 =?utf-8?B?ZUYwRnlnSFFBWG1SNC9rbk5uSmVBb0lkNlhXYjVDOXVlUm1CZUR3R0V4RUIr?=
 =?utf-8?B?TTR1eUNvVngrcWZCa0xLeTBTRC9hWEZQWkhsMVZyQVNZb0RkVk5tR2RIeEhl?=
 =?utf-8?B?emlFS3hhemZpUFpCV1J2bEg5c0JzSm9yaXpEMzVzM1JCNFRVYUxPUW9rTDRV?=
 =?utf-8?B?T1pISDEyRW9NeUJxQUttZTM3OUpNSzZHMWlOM25IUFhIUzIwZXkvWVdhdTZJ?=
 =?utf-8?B?VmNiUk54RHF0K2NUVjhiRURtMUhCcFplUUhwSDUwVnNWS01SR0t5MHlONmNU?=
 =?utf-8?B?SmJhSEtjeEt3V0FxbHo1TkNPS0IwUjhHUUxCRXV0dS9DNlp4N0wySXkzQXl2?=
 =?utf-8?B?MDNBaGhQczdiUUZPTHhFL09FUDRIdVloMHZRNnUvZ2Y2TnZTUzZRWnNoQlQv?=
 =?utf-8?B?YU41dFpRTW5tL21TU3JHVGxqL0VlUStYOThhQXpVVEl2MFpHZU9hSDVRbDgr?=
 =?utf-8?B?Qm9ha09kaWpwemovUTJjNDlTV2tCL2pLMzNzSW5RU3ZWaTBLeXE3L2NHVWpn?=
 =?utf-8?B?UVFFRTMyNTdDdWlCSWFNQ2IyMHcyVkYyZ0JuUFg4Z3ZIRkVpUjdseGtRUVBQ?=
 =?utf-8?B?dnZPTTlzZi8zbXNrK3NWVFhMYjRsN3grUDJ3UFRseWhYcG9KSVN4ZlJBVVN1?=
 =?utf-8?B?SElMbm0wQnZ6elYrSVRHTE9KWUlVSm9oSHF3aUZMWFJDayswS2R0Z0hhbHZL?=
 =?utf-8?B?Y25uYmlUSjExQXNRRDl6RnhOK3VKSEZXbmRqSmkzVy9rZXZEMWpUY2VNWjNj?=
 =?utf-8?B?L3QyTjIwT21ydXlITGJ3M1hxdjFLMDk1N2ZPdTlxdzVNY2VKN0p0QUp3emlF?=
 =?utf-8?Q?ulTa/OabjCqVqRgVDUXy0f0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB2BC986B558774FBEE089108C5447CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea2b79-9196-43a1-681d-08db20fc59a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 00:14:01.0760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwhjTAB1wntl3TmpaVsyi5dW8JF1Xz2qR/CNLfFk6hlPwgYWT+3d7KdIL/ziFXMdH41XR/IxplzPUk9Da/Cv+DGdA0Z4sCcG0wt6YaBJ0bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDEzOjA4IC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIFRodSwgTWFyIDA5LCAyMDIzIGF0IDA3OjM5OjQxUE0gKzAwMDAsIEVkZ2Vjb21iZSwgUmlj
ayBQIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wMy0wOSBhdCAxMDo1NSAtMDgwMCwgRGVlcGFr
IEd1cHRhIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBNYXIgMDIsIDIwMjMgYXQgMDU6MjI6MDdQTSAr
MDAwMCwgU3phYm9sY3MgTmFneSB3cm90ZToNCj4gPiA+ID4gVGhlIDAyLzI3LzIwMjMgMTQ6Mjks
IFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+ID4gPiA+IFByZXZpb3VzbHksIGEgbmV3IFBST1Rf
U0hBRE9XX1NUQUNLIHdhcyBhdHRlbXB0ZWQsDQo+ID4gPiA+IA0KPiA+ID4gPiAuLi4NCj4gPiA+
ID4gPiBTbyByYXRoZXIgdGhhbiByZXB1cnBvc2UgdHdvIGV4aXN0aW5nIHN5c2NhbGxzIChtbWFw
LA0KPiA+ID4gPiA+IG1hZHZpc2UpDQo+ID4gPiA+ID4gdGhhdCBkb24ndA0KPiA+ID4gPiA+IHF1
aXRlIGZpdCwganVzdCBpbXBsZW1lbnQgYSBuZXcgbWFwX3NoYWRvd19zdGFjayBzeXNjYWxsIHRv
DQo+ID4gPiA+ID4gYWxsb3cNCj4gPiA+ID4gPiB1c2Vyc3BhY2UgdG8gbWFwIGFuZCBzZXR1cCBu
ZXcgc2hhZG93IHN0YWNrcyBpbiBvbmUgc3RlcC4NCj4gPiA+ID4gPiBXaGlsZQ0KPiA+ID4gPiA+
IHVjb250ZXh0DQo+ID4gPiA+ID4gaXMgdGhlIHByaW1hcnkgbW90aXZhdG9yLCB1c2Vyc3BhY2Ug
bWF5IGhhdmUgb3RoZXIgdW5mb3Jlc2Vlbg0KPiA+ID4gPiA+IHJlYXNvbnMgdG8NCj4gPiA+ID4g
PiBzZXR1cCBpdCdzIG93biBzaGFkb3cgc3RhY2tzIHVzaW5nIHRoZSBXUlNTIGluc3RydWN0aW9u
Lg0KPiA+ID4gPiA+IFRvd2FyZHMNCj4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gcHJvdmlkZSBh
IGZsYWcgc28gdGhhdCBzdGFja3MgY2FuIGJlIG9wdGlvbmFsbHkgc2V0dXANCj4gPiA+ID4gPiBz
ZWN1cmVseQ0KPiA+ID4gPiA+IGZvciB0aGUNCj4gPiA+ID4gPiBjb21tb24gY2FzZSBvZiB1Y29u
dGV4dCB3aXRob3V0IGVuYWJsaW5nIFdSU1MuIE9yIHBvdGVudGlhbGx5DQo+ID4gPiA+ID4gaGF2
ZSB0aGUNCj4gPiA+ID4gPiBrZXJuZWwgc2V0IHVwIHRoZSBzaGFkb3cgc3RhY2sgaW4gc29tZSBu
ZXcgd2F5Lg0KPiA+ID4gPiANCj4gPiA+ID4gLi4uDQo+ID4gPiA+ID4gVGhlIGZvbGxvd2luZyBl
eGFtcGxlIGRlbW9uc3RyYXRlcyBob3cgdG8gY3JlYXRlIGEgbmV3IHNoYWRvdw0KPiA+ID4gPiA+
IHN0YWNrIHdpdGgNCj4gPiA+ID4gPiBtYXBfc2hhZG93X3N0YWNrOg0KPiA+ID4gPiA+IHZvaWQg
KnNoc3RrID0gbWFwX3NoYWRvd19zdGFjayhhZGRyLCBzdGFja19zaXplLA0KPiA+ID4gPiA+IFNI
QURPV19TVEFDS19TRVRfVE9LRU4pOw0KPiA+ID4gPiANCj4gPiA+ID4gaSB0aGluaw0KPiA+ID4g
PiANCj4gPiA+ID4gbW1hcChhZGRyLCBzaXplLCBQUk9UX1JFQUQsIE1BUF9BTk9OfE1BUF9TSEFE
T1dfU1RBQ0ssIC0xLCAwKTsNCj4gPiA+ID4gDQo+ID4gPiA+IGNvdWxkIGRvIHRoZSBzYW1lIHdp
dGggbGVzcyBkaXNydXB0aW9uIHRvIHVzZXJzIChuZXcgc3lzY2FsbHMNCj4gPiA+ID4gYXJlIGhh
cmRlciB0byBkZWFsIHdpdGggdGhhbiBuZXcgZmxhZ3MpLiBpdCB3b3VsZCBkbyB0aGUNCj4gPiA+
ID4gZ3VhcmQgcGFnZSBhbmQgaW5pdGlhbCB0b2tlbiBzZXR1cCB0b28gKHRoZXJlIGlzIG5vIGZs
YWcgZm9yDQo+ID4gPiA+IGl0IGJ1dCBjb3VsZCBiZSBzcXVlZXplZCBpbikuDQo+ID4gPiANCj4g
PiA+IERpc2N1c3Npb24gb24gdGhpcyB0b3BpYyBpbiB2Ng0KPiA+ID4gDQo+ID4gDQo+ID4gDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMjMwMDAzNDAuR0I5NDU5NjZAZGVidWcu
YmEucml2b3NpbmMuY29tLw0KPiA+ID4gDQo+ID4gPiBBZ2FpbiBJIGtub3cgZWFybGllciBDRVQg
cGF0Y2hlcyBoYWQgcHJvdGVjdGlvbiBmbGFnIGFuZCBzb21laG93DQo+ID4gPiBkdWUNCj4gPiA+
IHRvIHB1c2hiYWNrDQo+ID4gPiBvbiBtYWlsaW5nIGxpc3QsDQo+ID4gPiAgaXQgd2FzIGFkb3B0
ZWQgdG8gZ28gZm9yIHNwZWNpYWwgc3lzY2FsbCBiZWNhdXNlIG5vIG9uZSBlbHNlDQo+ID4gPiBo
YWQgc2hhZG93IHN0YWNrLg0KPiA+ID4gDQo+ID4gPiBTZWVpbmcgYSByZXNwb25zZSBmcm9tIFN6
YWJvbGNzLCBJIGFtIGFzc3VtaW5nIGFybTQgd291bGQgYWxzbw0KPiA+ID4gd2FudA0KPiA+ID4g
dG8gZm9sbG93DQo+ID4gPiB1c2luZyBtbWFwIHRvIG1hbnVmYWN0dXJlIHNoYWRvdyBzdGFjay4g
Rm9yIHJlZmVyZW5jZSBSRkMgcGF0Y2hlcw0KPiA+ID4gZm9yDQo+ID4gPiByaXNjLXYgc2hhZG93
IHN0YWNrLA0KPiA+ID4gdXNlIGEgbmV3IHByb3RlY3Rpb24gZmxhZyA9IFBST1RfU0hBRE9XU1RB
Q0suDQo+ID4gPiANCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MzAyMTMwNDUzNTEuMzk0NTgyNC0xLWRlYnVnQHJpdm9zaW5jLmNvbS8NCj4gPiA+IA0KPiA+ID4g
SSBrbm93IGVhcmxpZXIgZGlzY3Vzc2lvbiBoYWQgYmVlbiB0aGF0IHdlIGxldCB0aGlzIGdvIGFu
ZCBkbyBhDQo+ID4gPiByZS0NCj4gPiA+IGZhY3RvciBsYXRlciBhcyBvdGhlcg0KPiA+ID4gYXJj
aCBzdXBwb3J0IHRyaWNrbGUgaW4uIEJ1dCBhcyBJIHRob3VnaHQgbW9yZSBvbiB0aGlzIGFuZCBJ
DQo+ID4gPiB0aGluayBpdA0KPiA+ID4gbWF5IGp1c3QgYmUNCj4gPiA+IG1lc3N5IGZyb20gdXNl
ciBtb2RlIHBvaW50IG9mIHZpZXcgYXMgd2VsbCB0byBoYXZlIGNvZ25pdGlvbiBvZg0KPiA+ID4g
dHdvDQo+ID4gPiBkaWZmZXJlbnQgd2F5cyBvZg0KPiA+ID4gY3JlYXRpbmcgc2hhZG93IHN0YWNr
LiBPbmUgd291bGQgYmUgc3BlY2lhbCBzeXNjYWxsIChpbiBjdXJyZW50DQo+ID4gPiBsaWJjKQ0K
PiA+ID4gYW5kIGFub3RoZXIgYG1tYXBgDQo+ID4gPiAod2hlbmV2ZXIgZnV0dXJlIHJlLWZhY3Rv
ciBoYXBwZW5zKQ0KPiA+ID4gDQo+ID4gPiBJZiBpdCdzIG5vdCB0b28gbGF0ZSwgaXQgd291bGQg
YmUgbW9yZSB3aXNlIHRvIHRha2UgYG1tYXBgDQo+ID4gPiBhcHByb2FjaCByYXRoZXIgdGhhbiBz
cGVjaWFsIGBzeXNjYWxsYCBhcHByb2FjaC4NCj4gPiANCj4gPiBUaGVyZSBpcyBzb3J0IG9mIHR3
byB0aGluZ3MgaW50ZXJtaXhlZCBoZXJlIHdoZW4gd2UgdGFsayBhYm91dCBhDQo+ID4gUFJPVF9T
SEFET1dfU1RBQ0suDQo+ID4gDQo+ID4gT25lIGlzOiB3aGF0IGlzIHRoZSBpbnRlcmZhY2UgZm9y
IHNwZWNpZnlpbmcgaG93IHRoZSBzaGFkb3cgc3RhY2sNCj4gPiBzaG91bGQgYmUgcHJvdmlzaW9u
ZWQgd2l0aCBkYXRhPyBSaWdodCBub3cgdGhlcmUgYXJlIHR3byB3YXlzDQo+ID4gc3VwcG9ydGVk
LCBhbGwgemVybyBvciB3aXRoIGFuIFg4NiBzaGFkb3cgc3RhY2sgcmVzdG9yZSB0b2tlbiBhdA0K
PiA+IHRoZQ0KPiA+IGVuZC4gVGhlbiB0aGVyZSB3YXMgYWxyZWFkeSBzb21lIGNvbnZlcnNhdGlv
biBhYm91dCBhIHRoaXJkIHR5cGUuDQo+ID4gSW4NCj4gPiB3aGljaCBjYXNlIHRoZSBxdWVzdGlv
biB3b3VsZCBiZSBpcyB1c2luZyBtbWFwIE1BUF8gZmxhZ3MgdGhlIHJpZ2h0DQo+ID4gcGxhY2Ug
Zm9yIHRoaXM/IEhvdyBtYW55IHR5cGVzIG9mIGluaXRpYWxpemF0aW9uIHdpbGwgYmUgbmVlZGVk
IGluDQo+ID4gdGhlDQo+ID4gZW5kIGFuZCB3aGF0IGlzIHRoZSBvdmVybGFwIGJldHdlZW4gdGhl
IGFyY2hpdGVjdHVyZXM/DQo+IA0KPiBGaXJzdCBvZiBhbGwsIGFyY2hlcyBjYW4gY2hvb3NlIHRv
IGhhdmUgdG9rZW4gYXQgdGhlIGJvdHRvbSBvciBub3QuDQo+IA0KPiBUb2tlbiBzZXJ2ZSBmb2xs
b3dpbmcgcHVycG9zZXMNCj4gICAtIEl0IGFsbG93cyBvbmUgdG8gcHV0IGRlc2lyZWQgdmFsdWUg
aW4gc2hhZG93IHN0YWNrIHBvaW50ZXIgaW4NCj4gc2FmZS9zZWN1cmUgbWFubmVyLg0KPiAgICAg
Tm90ZTogeDg2IGRvZXNuJ3QgcHJvdmlkZSBhbnkgb3Bjb2RlIGVuY29kaW5nIHRvIHZhbHVlIGlu
IFNTUA0KPiByZWdpc3Rlci4gU28gaGF2aW5nDQo+ICAgICBhIHRva2VuIGlzIGtpbmQgb2YgYSBu
ZWNlc3NpdHkgYmVjYXVzZSB4ODYgZG9lc24ndCBlYXNpbHkgYWxsb3cNCj4gd3JpdGluZyBzaGFk
b3cgc3RhY2suDQo+IA0KPiAgIC0gQSB0b2tlbiBhdCB0aGUgYm90dG9tIGFjdHMgbWFya2VyIC8g
YmFycmllciBhbmQgY2FuIGJlIHVzZWZ1bCBpbg0KPiBkZWJ1Z2dpbmcNCj4gDQo+ICAgLSBJZiAo
YW5kIGEgYmlnICppZiopIHdlIGV2ZXIgcmVhY2ggYSBwb2ludCBpbiBmdXR1cmUgd2hlcmUgcmV0
dXJuDQo+IGFkZHJlc3MgaXMgb25seSBwdXNoZWQNCj4gICAgIG9uIHNoYWRvdyBzdGFjayAoeDg2
IHNob3VsZCBoYXZlIG1vdGl2YXRpb24gdG8gZG8gdGhpcyBiZWNhdXNlDQo+IGxlc3MgdW9wcyBv
biBjYWxsL3JldCksDQo+ICAgICBhIHRva2VuIGF0IHRoZSBib3R0b20gKGJvdHRvbSBtZWFucyBs
b3dlciBhZGRyZXNzKSBpcyBlbnN1cmluZw0KPiBzdXJlIHNob3Qgd2F5IG9mIGdldHRpbmcNCj4g
ICAgIGEgZmF1bHQgd2hlbiBleGhhdXN0ZWQuDQo+IA0KPiBDdXJyZW50IFJJU0NWIHppc3NscGNm
aSBwcm9wb3NhbCBkb2Vzbid0IGRlZmluZSBDUFUgYmFzZWQgdG9rZW5zDQo+IGJlY2F1c2UgaXQn
cyBSSVNDLg0KPiBJdCBhbGxvd3MgbWVjaGFuaXNtcyB1c2luZyB3aGljaCBzb2Z0d2FyZSBjYW4g
ZGVmaW5lIGZvcm1hdHRpbmcgb2YNCj4gdG9rZW4gZm9yIGl0c2VsZi4NCj4gTm90IHN1cmUgb2Yg
d2hhdCBBUk0gaXMgZG9pbmcuDQoNCk9rLCBzbyByaXNjdiBkb2Vzbid0IG5lZWQgdG8gaGF2ZSB0
aGUga2VybmVsIHdyaXRlIHRoZSB0b2tlbiwgYnV0IHg4Ng0KZG9lcy4NCg0KPiANCj4gTm93IGNv
bWluZyB0byB0aGUgcG9pbnQgb2YgYWxsIHplcm8gdi9zIHNoYWRvdyBzdGFjayB0b2tlbi4NCj4g
V2h5IG5vdCBhbHdheXMgaGF2ZSB0b2tlbiBhdCB0aGUgYm90dG9tPw0KDQpXaXRoIFdSU1MgeW91
IGNhbiBzZXR1cCB0aGUgc2hhZG93IHN0YWNrIGhvd2V2ZXIgeW91IHdhbnQuIFNvIHRoZSB1c2Vy
DQp3b3VsZCB0aGVuIGhhdmUgdG8gdGFrZSBjYXJlIHRvIGVyYXNlIHRoZSB0b2tlbiBpZiB0aGV5
IGRpZG4ndCB3YW50IGl0Lg0KTm90IHRoZSBlbmQgb2YgdGhlIHdvcmxkLCBidXQga2luZCBvZiBj
bHVua3kgaWYgdGhlcmUgaXMgbm8gcmVhc29uIGZvcg0KaXQuDQoNCj4gDQo+IEluIGNhc2Ugb2Yg
eDg2LCBXaHkgbmVlZCBmb3IgdHdvIHdheXMgYW5kIHdoeSBub3QgYWx3YXlzIGhhdmUgYSB0b2tl
bg0KPiBhdCB0aGUgYm90dG9tLg0KPiBUaGUgd2F5IHg4NiBpcyBnb2luZywgdXNlciBtb2RlIGlz
IHJlc3BvbnNpYmxlIGZvciBlc3RhYmxpc2hpbmcNCj4gc2hhZG93IHN0YWNrIGFuZCB0aHVzDQo+
IHdoZW5ldmVyIHNoYWRvdyBzdGFjayBpcyBjcmVhdGVkIHRoZW4gaWYgeDg2IGtlcm5lbCBpbXBs
ZW1lbnRhdGlvbg0KPiBhbHdheXMgcGxhY2UgYSB0b2tlbg0KPiBhdCB0aGUgYmFzZS9ib3R0b20u
DQoNClRoZXJlIHdhcyBhbHNvIHNvbWUgZGlzY3Vzc2lvbiByZWNlbnRseSBvZiBhZGRpbmcgYSB0
b2tlbiBBTkQgYW4gZW5kIG9mDQpzdGFjayBtYXJrZXIsIGFzIGEgcG90ZW50aWFsIHNvbHV0aW9u
IGZvciBiYWNrdHJhY2luZyBpbiB1Y29udGV4dA0Kc3RhY2tzLiBJbiB0aGlzIGNhc2UgaXQgY291
bGQgY2F1c2UgYW4gQUJJIGJyZWFrIHRvIGp1c3Qgc3RhcnQgYWRkaW5nDQp0aGUgZW5kIG9mIHN0
YWNrIG1hcmtlciB3aGVyZSB0aGUgdG9rZW4gd2FzLCBhbmQgc28gd291bGQgcmVxdWlyZSBhIG5l
dw0KbWFwX3NoYWRvd19zdGFjayBmbGFnLg0KDQo+IA0KPiBOb3cgdXNlciBtb2RlIGNhbiBkbyBm
b2xsb3dpbmc6LS0NCj4gICAtIElmIGl0IGhhcyBhY2Nlc3MgdG8gV1JTUywgaXQgY2FuIHN1cmUg
Z28gYWhlYWQgYW5kIGNyZWF0ZSBhIHRva2VuDQo+IG9mIGl0cyBjaG9vc2luZyBhbmQNCj4gICAg
IG92ZXJ3cml0ZSBrZXJuZWwgY3JlYXRlZCB0b2tlbi4gYW5kIHRoZW4gZG8gUlNUT1JTU1Agb24g
aXQncyBvd24NCj4gY3JlYXRlZCB0b2tlbi4NCj4gDQo+ICAgLSBJZiBpdCBkb2Vzbid0IGhhdmUg
YWNjZXNzIHRvIFdSU1MgKGFuZCBkb250IG5lZWQgdG8gY3JlYXRlIGl0cw0KPiBvd24gdG9rZW4p
LCBpdCBjYW4gZG8NCj4gICAgIFJTVE9SU1NQIG9uIHRoaXMuIEFzIHNvb24gYXMgaXQgZG9lcywg
bm8gb3RoZXIgdGhyZWFkIGluIHByb2Nlc3MNCj4gY2FuIHJlc3RvcmUgdG8gaXQuDQo+ICAgICBP
biBgZm9ya2AsIHlvdSBnZXQgdGhlIHNhbWUgdW4tcmVzdG9yYWJsZSB0b2tlbi4NCj4gDQo+IFNv
IHdoeSBub3QgYWx3YXlzIGhhdmUgYSB0b2tlbiBhdCB0aGUgYm90dG9tLg0KPiBUaGlzIGlzIG15
IHBsYW4gZm9yIHJpc2N2IGltcGxlbWVudGF0aW9uIGFzIHdlbGwgKHRvIGhhdmUgYSB0b2tlbiBh
dA0KPiB0aGUgYm90dG9tKQ0KPiANCj4gPiANCj4gPiBUaGUgb3RoZXIgdGhpbmcgaXM6IHNob3Vs
ZCBzaGFkb3cgc3RhY2sgbWVtb3J5IGNyZWF0aW9uIGJlIHRpZ2h0bHkNCj4gPiBjb250cm9sbGVk
PyBGb3IgZXhhbXBsZSBpbiB4ODYgd2UgbGltaXQgdGhpcyB0byBhbm9ueW1vdXMgbWVtb3J5LA0K
PiA+IGV0Yy4NCj4gPiBTb21lIHJlYXNvbnMgZm9yIHRoaXMgYXJlIHg4NiBzcGVjaWZpYywgYnV0
IHNvbWUgYXJlIG5vdC4gU28gaWYgd2UNCj4gPiBkaXNhbGxvdyBtb3N0IG9mIHRoZSBvcHRpb25z
IHdoeSBhbGxvdyB0aGUgaW50ZXJmYWNlIHRvIHRha2UgdGhlbT8NCj4gPiBBbmQNCj4gPiB0aGVu
IHlvdSBhcmUgaW4gdGhlIHBvc2l0aW9uIG9mIGNhcmVmdWxseSBtYWludGFpbmluZyBhIGxpc3Qg
b2YNCj4gPiBub3QtDQo+ID4gYWxsb3dlZCBvcHRpb25zIGluc3RlYWQgbGV0dGluZyBhIGxpc3Qg
b2YgYWxsb3dlZCBvcHRpb25zIHNpdA0KPiA+IHRoZXJlLg0KPiANCj4gSSBhbSBuZXcgdG8gbGlu
dXgga2VybmVsIGFuZCB0aHVzIG1heSBiZSBub3QgYWJsZSB0byBmb2xsb3cgdGhlDQo+IGFyZ3Vt
ZW50IG9mDQo+IGxpbWl0aW5nIHRvIGFub255bW91cyBtZW1vcnkuDQo+IA0KPiBXaHkgaXMgbGlt
aXRpbmcgaXQgdG8gYW5vbnltb3VzIG1lbW9yeSBhIHByb2JsZW0uIElJUkMsIEFSTSdzDQo+IFBS
T1RfTVRFIGlzIGFwcGxpY2FibGUNCj4gb25seSB0byBhbm9ueW1vdXMgbWVtb3J5LiBJIGNhbiBw
cm9iYWJseSBmaW5kIGZldyBtb3JlIGV4YW1wbGVzLiANCg0KT2ggSSBzZWUsIHRoZXkgaGF2ZSBh
IHNwZWNpYWwgYXJjaCBWTUEgZmxhZyBWTV9NVEVfQUxMT1dFRCB0aGF0IG9ubHkNCmdldHMgc2V0
IGlmIGFsbCB0aGUgcnVsZXMgYXJlIGZvbGxvd2VkLiBUaGVuIFBST1RfTVRFIGNhbiBvbmx5IGJl
IHNldA0Kb24gdGhhdCB0byBzZXQgVk1fTVRFLiBUaGF0IGlzIGtpbmQgb2YgbmljZSBiZWNhdXNl
IGNlcnRhaW4gb3RoZXINCnNwZWNpYWwgc2l0dWF0aW9ucyBjYW4gY2hvb3NlIHRvIHN1cHBvcnQg
aXQuDQoNCkl0IGRvZXMgdGFrZSBhbm90aGVyIGFyY2ggdm1hIGZsYWcgdGhvdWdoLiBGb3IgeDg2
IEkgZ3Vlc3MgSSB3b3VsZCBuZWVkDQp0byBmaWd1cmUgb3V0IGhvdyB0byBzcXVlZXplIFZNX1NI
QURPV19TVEFDSyBpbnRvIG90aGVyIGZsYWdzIHRvIGhhdmUgYQ0KZnJlZSBmbGFnIHRvIHVzZSB0
aGUgc2FtZSBtZXRob2QuIEl0IGFsc28gb25seSBzdXBwb3J0cyBtcHJvdGVjdCgpIGFuZA0Kc2hh
ZG93IHN0YWNrIHdvdWxkIG9ubHkgd2FudCB0byBzdXBwb3J0IG1tYXAoKS4gQW5kIHlvdSBzdGls
bCBoYXZlIHRoZQ0KaW5pdGlhbGl6YXRpb24gc3R1ZmYgdG8gcGx1bWIgdGhyb3VnaC4gWWVhLCBJ
IHRoaW5rIHRoZSBQUk9UX01URSBpcyBhDQpnb29kIHRoaW5nIHRvIGNvbnNpZGVyLCBidXQgaXQn
cyBub3Qgc3VwZXIgb2J2aW91cyB0byBtZSBob3cgc2ltaWxhcg0KdGhlIGxvZ2ljIHdvdWxkIGJl
IGZvciBzaGFkb3cgc3RhY2suDQoNClRoZSBxdWVzdGlvbiBJJ20gYXNraW5nIHRob3VnaCBpcywg
bm90ICJjYW4gbW1hcCBjb2RlIGFuZCBydWxlcyBiZQ0KY2hhbmdlZCB0byBlbmZvcmNlIHRoZSBy
ZXF1aXJlZCBsaW1pdGF0aW9ucz8iLiBJIHRoaW5rIGl0IGlzIHllcy4gQnV0DQp0aGUgcXVlc3Rp
b24gaXMgIndoeSBpcyB0aGF0IHBsdW1iaW5nIGJldHRlciB0aGFuIGEgbmV3IHN5c2NhbGw/Ii4g
SQ0KZ3Vlc3MgdG8gZ2V0IGEgYmV0dGVyIGlkZWEsIHRoZSBtbWFwIHNvbHV0aW9uIHdvdWxkIG5l
ZWQgdG8gZ2V0IFBPQ2VkLg0KSSBoYWQgaGFsZiBkb25lIHRoaXMgYXQgb25lIHBvaW50LCBidXQg
YWJhbmRvbmVkIHRoZSBhcHByb2FjaC4NCg0KRm9yIHlvdXIgcXVlc3Rpb24gYWJvdXQgd2h5IGxp
bWl0IGl0LCB0aGUgc3BlY2lhbCB4ODYgY2FzZSBpcyB0aGUNCkRpcnR5PTEsV3JpdGU9MCBQVEUg
Yml0IGNvbWJpbmF0aW9uIGZvciBzaGFkb3cgc3RhY2tzLiBTbyBmb3Igc2hhZG93DQpzdGFjayB5
b3UgY291bGQgaGF2ZSBzb21lIGNvbmZ1c2lvbiBhYm91dCB3aGV0aGVyIGEgUFRFIGlzIGFjdHVh
bGx5DQpkaXJ0eSBmb3Igd3JpdGViYWNrLCBldGMuIEkgd291bGRuJ3Qgc2F5IGl0J3Mga25vd24g
dG8gYmUgaW1wb3NzaWJsZSB0bw0KZG8gTUFQX1NIQVJFRCwgYnV0IGl0IGhhcyBub3QgYmVlbiBm
dWxseSBhbmFseXplZCBlbm91Z2ggdG8ga25vdyB3aGF0DQp0aGUgY2hhbmdlcyB3b3VsZCBiZS4g
VGhlcmUgd2VyZSBzb21lIHNvbHZhYmxlIGNvbmNyZXRlIGlzc3VlcyB0aGF0DQp0aXBwZWQgdGhl
IHNjYWxlIGFzIHdlbGwuIEl0IHdhcyBhbHNvIG5vdCBleHBlY3RlZCB0byBiZSBhIGNvbW1vbg0K
dXNhZ2UsIGlmIGF0IGFsbC4NCg0KVGhlIG5vbi14ODYsIGdlbmVyYWwgcmVhc29ucyBmb3IgaXQs
IGFyZSBmb3IgYSBzbWFsbGVyIGJlbmVmaXQuIEl0DQpibG9ja3MgYSBsb3Qgb2Ygd2F5cyBzaGFk
b3cgc3RhY2sgbWVtb3J5IGNvdWxkIGJlIHdyaXR0ZW4gdG8uIExpa2Ugc2F5DQp5b3UgaGF2ZSBh
IG1lbW9yeSBtYXBwZWQgd3JpdGFibGUgZmlsZSwgYW5kIHlvdSBhbHNvIG1hcCBpdCBzaGFkb3cN
CnN0YWNrLiBTbyBpdCBoYXMgYmV0dGVyIHNlY3VyaXR5IHByb3BlcnRpZXMgZGVwZW5kaW5nIG9u
IHdoYXQgeW91cg0KdGhyZWF0IG1vZGVsIGlzLg0KDQo+IA0KPiBFdmVudHVhbGx5IHN5c2NhbGwg
d2lsbCBhbHNvIGdvIGFoZWFkIGFuZCB1c2UgbWVtb3J5IG1hbmFnZW1lbnQgY29kZQ0KPiB0bw0K
PiBwZXJmb3JtIG1hcHBpbmcuIFNvIEkgZGlkbid0IHVuZGVyc3RhbmQgdGhlIHJlYXNvbmluZyBo
ZXJlLiBUaGUgd2F5DQo+IHN5c2NhbGwNCj4gY2FuIGxpbWl0IGl0IHRvIGFub255bW91cyBtZW1v
cnksIHdoeSBtbWFwIGNhbid0IGRvIHRoZSBzYW1lIGlmIGl0DQo+IHNlZXMNCj4gUFJPVF9TSEFE
T1dTVEFDSy4NCj4gDQo+ID4gDQo+ID4gVGhlIG9ubHkgYmVuZWZpdCBJJ3ZlIGhlYXJkIGlzIHRo
YXQgaXQgc2F2ZXMgY3JlYXRpbmcgYSBuZXcNCj4gPiBzeXNjYWxsLA0KPiA+IGJ1dCBpdCBhbHNv
IHNhdmVzIHNldmVyYWwgTUFQXyBmbGFncy4gVGhhdCwgYW5kIHRoYXQgdGhlIFJGQyBmb3INCj4g
PiByaXNjdg0KPiA+IGRpZCBhIFBST1RfU0hBRE9XX1NUQUNLIHRvIHN0YXJ0LiBTbywgeWVzLCB0
d28gcGVvcGxlIGFza2VkIHRoZQ0KPiA+IHNhbWUNCj4gPiBxdWVzdGlvbiwgYnV0IEknbSBzdGls
bCBub3Qgc2VlaW5nIGFueSBiZW5lZml0cy4gQ2FuIHlvdSBnaXZlIHRoZQ0KPiA+IHByb3MNCj4g
PiBhbmQgY29ucyBwbGVhc2U/DQo+IA0KPiBBZ2FpbiB0aGUgd2F5IHN5c2NhbGwgd2lsbCBsaW1p
dCBpdCB0byBhbm9ueW1vdXMgbWVtb3J5LCBXaHkgbW1hcA0KPiBjYW4ndCBkbyBzYW1lPw0KPiBU
aGVyZSBpcyBwcmVjZWRlbmNlIGZvciBpdCAobGlrZSBQUk9UX01URSBpcyBhcHBsaWNhYmxlIG9u
bHkgdG8NCj4gYW5vbnltb3VzIG1lbW9yeSkNCj4gDQo+IFNvIGlmIGl0IGNhbiBiZSBkb25lLCB0
aGVuIHdoeSBpbnRyb2R1Y2UgYSBuZXcgc3lzY2FsbD8NCj4gDQo+ID4gDQo+ID4gQlRXLCBpbiBn
bGliYyBtYXBfc2hhZG93X3N0YWNrIGlzIGNhbGxlZCBmcm9tIGFyY2ggY29kZS4gU28gSSB0aGlu
aw0KPiA+IHVzZXJzcGFjZSB3aXNlLCBmb3IgdGhpcyB0byBhZmZlY3Qgb3RoZXIgYXJjaGl0ZWN0
dXJlcyB0aGVyZSB3b3VsZA0KPiA+IG5lZWQNCj4gPiB0byBiZSBzb21lIGNvZGUgdGhhdCBjb3Vs
ZCBkbyB0aGluZ3MgZ2VuZXJpY2FsbHksIHdpdGggc29tZWhvdyB0aGUNCj4gPiBzaGFkb3cgc3Rh
Y2sgcGl2b3QgYWJzdHJhY3RlZCBidXQgdGhlIHNoYWRvdyBzdGFjayBhbGxvY2F0aW9uIG5vdC4N
Cj4gDQo+IEFncmVlZCwgeWVzIGl0IGNhbiBiZSBkb25lIGluIGEgd2F5IHdoZXJlIGl0IHdvbid0
IHB1dCB0YXggb24gb3RoZXINCj4gYXJjaGl0ZWN0dXJlcy4NCj4gDQo+IEJ1dCB3aGF0IGFib3V0
IGZyYWdtZW50YXRpb24gd2l0aGluIHg4Ni4gV2lsbCB4ODYgYWx3YXlzIGNob29zZSB0bw0KPiB1
c2Ugc3lzdGVtIGNhbGwNCj4gbWV0aG9kIG1hcCBzaGFkb3cgc3RhY2suIElmIGZ1dHVyZSByZS1m
YWN0b3IgcmVzdWx0cyBpbiB4ODYgYWxzbyB1c2UNCj4gYG1tYXBgIG1ldGhvZC4NCj4gSXNuJ3Qg
aXQgYSBtZXNzIGZvciB4ODYgZ2xpYmMgdG8gZmlndXJlIG91dCB3aGF0IHRvIGRvOyB3aGV0aGVy
IHRvDQo+IHVzZSBzeXN0ZW0gY2FsbA0KPiBvciBgbW1hcGA/DQo+IA0KDQpPaywgc28gdGhpcyBp
cyB0aGUgZG93bnNpZGUgSSBndWVzcy4gV2hhdCBoYXBwZW5zIGlmIHdlIHdhbnQgdG8gc3VwcG9y
dA0KdGhlIG90aGVyIHR5cGVzIG9mIG1lbW9yeSBpbiB0aGUgZnV0dXJlIGFuZCBlbmQgdXAgdXNp
bmcgbW1hcCBmb3IgdGhpcz8NClRoZW4gd2UgaGF2ZSAxNS0yMCBsaW5lcyBvZiBleHRyYSBzeXNj
YWxsIHdyYXBwaW5nIGNvZGUgdG8gbWFpbnRhaW4gdG8NCnN1cHBvcnQgbGVnYWN5Lg0KDQpGb3Ig
dGhlIG1tYXAgc29sdXRpb24sIHdlIGhhdmUgdGhlIGRvd25zaWRlIG9mIHVzaW5nIGV4dHJhIE1B
UF8gZmxhZ3MsDQphbmQgKnNvbWUqIGFtb3VudCBvZiBjdXJyZW50bHkgdW5rbm93biB2bV9mbGFn
IGFuZCBhZGRyZXNzIHJhbmdlIGxvZ2ljLA0KcGx1cyBtbWFwIGFyY2ggYnJlYWtvdXRzIHRvIGFk
ZCB0byBjb3JlIE1NLiBMaWtlIEkgc2FpZCBlYXJsaWVyLCB5b3UNCndvdWxkIG5lZWQgdG8gUE9D
IGl0IG91dCB0byBzZWUgaG93IGJhZCB0aGF0IGxvb2tzIGFuZCBnZXQgc29tZSBjb3JlIE1NDQpm
ZWVkYmFjayBvbiB0aGUgbmV3IHR5cGUgb2YgTUFQIGZsYWcgdXNhZ2UuIEJ1dCwgc3lzY2FsbHMg
YmVpbmcgcHJldHR5DQpzdHJhaWdodGZvcndhcmQsIGl0IHdvdWxkIHByb2JhYmx5IGJlICpzb21l
KiBhbW91bnQgb2YgYWRkZWQgY29tcGxleGl0eQ0KX25vd18gdG8gc3VwcG9ydCBzb21ldGhpbmcg
dGhhdCBtaWdodCBoYXBwZW4gaW4gdGhlIGZ1dHVyZS4gSSdtIG5vdA0Kc2VlaW5nIGVpdGhlciBv
bmUgYXMgYSBsYW5kc2xpZGUgd2luLg0KDQpJdCdzIGtpbmQgb2YgYW4gZXRlcm5hbCBzb2Z0d2Fy
ZSBkZXNpZ24gcGhpbG9zb3BoaWNhbCBxdWVzdGlvbiwgaXNuJ3QNCml0PyBIb3cgbXVjaCB3b3Jr
IHNob3VsZCB5b3UgZG8gdG8gcHJlcGFyZSBmb3IgdGhpbmdzIHRoYXQgbWlnaHQgYmUNCm5lZWRl
ZCBpbiB0aGUgZnV0dXJlPyBGcm9tIHdoYXQgSSd2ZSBzZWVuIHRoZSBiYWxhbmNlIGluIHRoZSBr
ZXJuZWwNCnNlZW1zIHRvIGJlIHRvIHRyeSBub3QgdG8gcGFpbnQgeW91cnNlbGYgaW4gdG8gYW4g
QUJJIGNvcm5lciwgYnV0DQpvdGhlcndpc2UgbGV0IHRoZSBrZXJuZWwgZXZvbHZlIG5hdHVyYWxs
eSBpbiByZXNwb25zZSB0byByZWFsIHVzYWdlcy4NCklmIGFueW9uZSB3YW50cyB0byBjb3JyZWN0
IHRoaXMsIHBsZWFzZSBkby4gQnV0IG90aGVyd2lzZSBJIHRoaW5rIHRoZQ0KbmV3IHN5c2NhbGwg
aXMgYWxpZ25lZCB3aXRoIHRoYXQuDQoNClRCSCwgeW91IGFyZSBtYWtpbmcgbWUgd29uZGVyIGlm
IEknbSBtaXNzaW5nIHNvbWV0aGluZy4gSXQgc2VlbXMgeW91DQpzdHJvbmdseSBkb24ndCBwcmVm
ZXIgdGhpcyBhcHByb2FjaCwgYnV0IEknbSBub3QgaGVhcmluZyBhbnkgaHVnZQ0KcG90ZW50aWFs
IG5lZ2F0aXZlIGltcGFjdHMuIEFuZCB5b3UgYWxzbyBzYXkgaXQgd29uJ3QgdGF4IHRoZSByaXNj
dg0KaW1wbGVtZW50YXRpb24uIElzIHRoaXMganVzdCBzb21ldGhpbmcganVzdCBzbWVsbHMgYmFk
IGhlcmU/IE9yIGl0DQp3b3VsZCBzaHJpbmsgdGhlIHJpc2N2IHNlcmllcz8NCg==
