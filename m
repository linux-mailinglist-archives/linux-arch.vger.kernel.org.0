Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9073D30D
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jun 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjFYSsr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYSsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 14:48:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C2CE44;
        Sun, 25 Jun 2023 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687718923; x=1719254923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Th/ZOiagYkWJ/fpBKLdB/ETfJgCb846fZRDEpkFQaH0=;
  b=VBgoo+1TY2os2y+ivPr2FZiYVnaVlCiSyg+ff2MkU0vapvliUdVIVDJT
   jdnY4dpWPJ+YnXQqMpsFAJ2gSbVKVNXMimY8ge7RMuzOZ+SS8d9tLbG1f
   2sfGWiUCvDXvdoZo7GYBREK9Eb5r5OAoYSM11netk46yUa1n8qs7o455d
   FBDQIb/zb4Br63gjlAm4EhaCnD3FcnY0PH/fdALVlA3xLkPX73x1e0t8J
   cMsbb27zE3ozr0pwQcWvstslDSofFwTDeBwXBmpjVN1niHhG9r75dTy8w
   Heigoz+aU57nIUDz52SEgmFIXNe3QN6n5/8lEEJXHYuvKRZooa6gA0Ym0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="358597254"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="358597254"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 11:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="781168683"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="781168683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2023 11:48:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 11:48:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 11:48:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 11:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/DnsjOCaCTyv7DpIe93uTfxVhb30l0wNReCl3AuRlncTUeO418uAITCLQ64GH0co/Oy3xTEMFIRp6zYzEjLLgpWUFWZjq8b8wwcPvK8H9z27Urw6+aKrbhfOq3FApvRlqWHkVjZpW70/vvgbgziLhAEFxbuZzwvzmQH5CLQ6sFqcN7IQ8aBlcWLIe6EP7NzlrRpaH+VkzLoIk6cNdgCAoBpw9RzFZvXh3iNxMztj06Ua1iK5UAb394/Ik+nj2dx7t63AOMKFY9NoOgD2yETjnx5Q3ourizwy8C3adnhoWpqJShNEMBO8HuPrRcXqxIEAFaEFE2RaIADVDP6EUm3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th/ZOiagYkWJ/fpBKLdB/ETfJgCb846fZRDEpkFQaH0=;
 b=kGjizQU6VjChr5kDEZ2VOKgAEb2XRqHEI1pvGRE2vJ5Mm397K47P8pKsUGFX1gvUHiBuWjU8HHF60IXpG217MVH1yyVj8QW2VuOVrxV/ahS3+hSCgsWeFtKWOWzbAS3k2bsfwe4X3EBCQKrEcg1vSMXrTxa3fMyeL+Evyhc/oIUl+1LxehQ5wSjGH9VFTkF0GnpVfmR6xn6xyTRMA3pM3wW+ADIh3mS25rVfVN6/HmIGtYPXgCYvRhQakT9bjFYe7aJP2TaoFr3LFd7+TSEj2i5pMVv6JaY+1Vhl7YJciw96S7z2EH/31iIvQ+YkmvSOIa0b6faJnAscaIm5K4VrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 18:48:36 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 18:48:36 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAADpMAIAAqOGAgACLyYCAAYwCgIADTMSA
Date:   Sun, 25 Jun 2023 18:48:36 +0000
Message-ID: <7177ec9e61b6d24d65419df746a09be70c6c32a2.camel@intel.com>
References: <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
         <ZJQF636p80oywgqZ@arm.com>
         <46a5ffc762bfd6ccb60c9568b7fb564d40c04c45.camel@intel.com>
         <ZJXHX0rmj/fMKagR@arm.com>
In-Reply-To: <ZJXHX0rmj/fMKagR@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB5909:EE_
x-ms-office365-filtering-correlation-id: 6b3f761e-7946-4a12-ef89-08db75acc89f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkfB7i6ZSvj49EWVoNjrrIahxdid6Zp9eONghLwNOXgVOfB3kd3nyOqL5wDgRIfyxVXsRBq6AZdPHnknUHfIOHk1rLGNNJD+o8hAw1ik1gRQnGKTP+LPxUkeFFcyz5r5gSkQSwZwAO5pxT7T4l2AltHucKbea1hT7DegYTZIEGZyyZawSffIMdny96MkO+TZljh0v5MDaXqDurRFJ/oQFGUuakBIHh9IJQzXwYVi2qs32NPNQfRy12Df04mlCIscn/Bx2d5yEAURJkNJ2BZz1XpgTHQnyCQ+dVVYCMmqJrUZH52m5ro2y3KVWb96jsPjogON9EOI4HwX+Drik70Sd2PYZVqMLT28qigGlOy6PfL7So2Zp76pfO1lPRIJi9AaFqRLH0epRGFUH0sHNPKcQ8kY7spw/kzu/gyZaGtm2gDOQDteV5L//G4Vhkv6BAsNWkNwwYTR+h2KKpB78J909HmQchB5m/2fV8UdPUVSw8cDZ6xL8d3YPGcF0TB5lveMMv12y3TBItXd6qxD5+03V49L5Ya+dQVv/Lrr+bsYvDYyol1iHyXnU3/gzGvTjfNbtSGt866NbTHvNlWQZSoN4Dt0ikczhlbH5Z58aYTpPC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(82960400001)(38100700002)(122000001)(38070700005)(83380400001)(36756003)(86362001)(478600001)(54906003)(110136005)(2616005)(966005)(6486002)(71200400001)(41300700001)(66476007)(66556008)(66946007)(66446008)(316002)(8676002)(76116006)(8936002)(64756008)(26005)(6512007)(4326008)(6506007)(186003)(2906002)(91956017)(7406005)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTd0RHh0b3BRK0RUaGMrZ1BNNFRYSlIzd1pWNzFGeDBHV3h4VE8yVHJZTkhG?=
 =?utf-8?B?Si9uVnRJazJRdlpHTEhhWjYwT0ltQ0pJV2VqUXJvd2JsMXVmSmhDTmV1dUtL?=
 =?utf-8?B?eGJjUm5iRDFtNlVxRGEyK3d2VFVDemZ1ZHBseDloMmh5N1RtR3dhWFFEajR6?=
 =?utf-8?B?djh6aW1Ra3RJcXRBek1raEJ0cUhZSyttU2V5blpUUi83Vkh1UzUySXRWSXlm?=
 =?utf-8?B?dkJaQTdPdkhqcEo2RjQzQTM3TTJ5bGtPWHZuejlHdTFIQ09GRy9BTUw0bVdB?=
 =?utf-8?B?RFU5dE1PdEV6M1lOZE16T3orYk1IVk5WVUFzaGNwUGhkQ2tFRGZnV2JBbDFX?=
 =?utf-8?B?b2ZyLzFBVmM4VFdrOWRoVTRUNFFNWU9pWjBqQUwrakFqZDh4RkFBaHg5T3Mz?=
 =?utf-8?B?M250a3hZSjVlK2dwV3hHY1YwNGNiblVzS1BwRVhLSkl5OXVzWUJNOVp2UjZn?=
 =?utf-8?B?ZVh3Q0R6dVJEQXlKZ0U4bnhXeFFrRUVVTDRkd2hpOVB3WEFNWi9LNHVWYU5o?=
 =?utf-8?B?VzNvQVh6YnV0bU81VG1HYjZmYlovd0pCa1dWcWUyWTY2RzkyeFBlcU1zKzhh?=
 =?utf-8?B?VFhlYUdDeUs2UHE4eUw2ZGlRalJyUU8ySG1nb0J1UHZISEFCQnJKS084OWNx?=
 =?utf-8?B?OHROS0R1b1Z4aWRnTzd1M1dORm5aV0ZpOU1CbWZUbWx0blFjUDZOaldwQTNO?=
 =?utf-8?B?dDNrMEJHUC9UVEhycFA2eVhOZmIyNVFOL2xuVmI1WUJyLzJzbXJaREZZNDlF?=
 =?utf-8?B?Y2wvTmN4b1VrTFI0cnN4b2R6eGZEUXFpT1V4bmtBVVU0MExTekdKTU5vd1dk?=
 =?utf-8?B?NXNUNFY3L3ZDYmg4ZGllVVEwc1FFamFsVndER1I0eFFzcFFMcVo2KzJmNk9I?=
 =?utf-8?B?eDdmSXdDcHRhOWdrcWUwRzgwN1N1TWgveVFadmRVdmNBUmhWNDlZUHVIN3VI?=
 =?utf-8?B?OVd6dENWM3FrS3Z0WEdJUDVhdDc4T0M5QXJ0VDJFZTVXb29Hb2ZpbmltdlNE?=
 =?utf-8?B?NnQ1elFQblk1ZG5GZ0xlMG96TExlbHNFcVUzM01DZEVZaWZwL2tjaEErVUFq?=
 =?utf-8?B?d0x2Wi9OWG1VWnFHYlpxcnpxMGszOW16RzhqLzBRcU9hQmRIUTgyQnl6LytF?=
 =?utf-8?B?YVExQnRwQzZSOGZxS0JMcC9JRDliTGhGMnlGRjlJUUtXUkM3WXJyNldiRS9v?=
 =?utf-8?B?dkZuUmtLdWs2OGJjTXBPbjNrRnJuY2hmQUlGYVd1MW5yaklKWWFZWlgzVEQv?=
 =?utf-8?B?c0ZYWGZqOVhicmJvM1lLaFZxZUVlRVppK3l2M0JHZVROTUNsSjlaNTcvMmdu?=
 =?utf-8?B?bVpGNlI2QVJvd3dlRDA3MURYaTB2Q2MyL05qQ2lRTU5YOXo3Z0cxUVZYbjBI?=
 =?utf-8?B?MkhEZFZLWGJEY24xZU5nNFJlWHRIQzE0Ryt1M0RoMDlqeG9BcWtWQldkalNl?=
 =?utf-8?B?UlN0N2RuM1oxYldybkZiQldweG03MnhzODI4YzhwVGhsWldHL3dWYlVCbWdP?=
 =?utf-8?B?NloyTGVZbWhGSXNOcDFyM0RzN2JsQWk0V2NKRmVoNDNzbkUxWUVHRFJFbzFq?=
 =?utf-8?B?Q2hROGxwMVZ4N1RZNlBZd2thSmNqVkY4MFFRR0JlWHBKVTh1TjY0aml0Y1Q4?=
 =?utf-8?B?NGdDN2pKS2VSTHpDVDFOQUN6U3BYZEZ4VnpaKzIzREVRTDlmM0JmL2I2Z256?=
 =?utf-8?B?NitSbmFFNEpzUVdCZWR1bEtLbUFOcUd1Wlo4YUhKZExBazhma21ncmtKMWhr?=
 =?utf-8?B?a1VqaklNRzFGTks5TkRRSXZRYUpIb01FTmMzS0FteVV3UmVOMDZKRjZMZDNI?=
 =?utf-8?B?MVVVTHBPSU1xNHI0a1NKUU1rTzkyQWN0NjZoSmJPWU9XdlRXTlhqNUxXQlI3?=
 =?utf-8?B?RkxtM0d0akpITHY0RjN5NjYwVUlRUjB2QjZhUjVCYm8vY0lXanBGVWhSd1dp?=
 =?utf-8?B?SzFUN0NBaWtKT2dUMUtRem54LytzMFFQckdiVEovU29WOUNJa3kvb0p3eUtK?=
 =?utf-8?B?dW1CS2NSYlZRc2NEVHovOUxuVXhYZWF6eFJEQ3lBY0t0RExEQ3BNbDZCVURw?=
 =?utf-8?B?aFdiblM1dlZCMmpRV05Ec2V2N1R0QmEyMEg2TGRjUmVIdHRwT2lUNE9pOHJZ?=
 =?utf-8?B?OS9zNGdMa0xMc2RQWFFMZGRhay9jSkJGaGtjVllKNFRTK2prVW1uS0RMelRv?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <297538DFA9D9424393C632D7376A9025@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3f761e-7946-4a12-ef89-08db75acc89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 18:48:36.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2hHftdzQ0AsPeOAoQElOsiiLNK9OZzT4oY4lSWX5v9vRatX4zuD0ishfLE4jJ3G/PDaVVj96reAMzPdIKWlHo/+gc2IfA4pZNfSCeQ1vSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTIzIGF0IDE3OjI1ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IHdoeT8NCj4gDQo+IGEgc3RhY2sgY2FuIGJlIGFjdGl2ZSBvciBpbmFjdGl2ZSAo
dGFzayBleGVjdXRpbmcgb24gaXQgb3Igbm90KSwNCj4gYW5kIGlmIGluYWN0aXZlIGl0IGNhbiBi
ZSBsaXZlIG9yIGRlYWQgKGhhcyBzdGFjayBmcmFtZXMgdGhhdCBjYW4NCj4gYmUganVtcGVkIHRv
IG9yIG5vdCkuDQo+IA0KPiB0aGlzIGlzIGluZGVwZW5kZW50IG9mIHNoYWRvdyBzdGFja3M6IGxv
bmdqbXAgaXMgb25seSB2YWxpZCBpZiB0aGUNCj4gdGFyZ2V0IGlzIGVpdGhlciB0aGUgc2FtZSBh
Y3RpdmUgc3RhY2sgb3IgYW4gaW5hY3RpdmUgbGl2ZSBzdGFjay4NCj4gKHRoZXJlIGFyZSBjYXNl
cyB0aGF0IG1heSBzZWVtIHRvIHdvcmssIGJ1dCBmdW5kYW1lbnRhbGx5IGJyb2tlbg0KPiBhbmQg
bm90IHN1cHBvcnRhYmxlOiBlLmcuIHR3byB0YXNrcyBleGVjdXRpbmcgb24gdGhlIHNhbWUgc3Rh
Y2sNCj4gd2hlcmUgdGhlIG9uZSBhYm92ZSBoYXBwZW5zIHRvIG5vdCBjbG9iYmVyIGZyYW1lcyBk
ZWVwIGVub3VnaCB0bw0KPiBjb2xsaWRlIHdpdGggdGhlIHRhc2sgYmVsb3cuKQ0KPiANCj4gdGhl
IHByb3Bvc2VkIGxvbmdqbXAgZGVzaWduIHdvcmtzIGZvciBib3RoIGNhc2VzLiBubyBhc3N1bXB0
aW9uIGlzDQo+IG1hZGUgYWJvdXQgdWNvbnRleHQgb3Igc2lnbmFscyBvdGhlciB0aGFuIHRoZSBz
aGFkb3cgc3RhY2sgZm9yIGFuDQo+IGluYWN0aXZlIGxpdmUgc3RhY2sgZW5kcyBpbiBhIHJlc3Rv
cmUgdG9rZW4swqANCg0KT25lIG9mIHRoZSBwcm9ibGVtcyBmb3IgdGhlIGNhc2Ugb2YgbG9uZ2pt
cCgpIGZyb20gYW5vdGhlciBhbm90aGVyDQpzdGFjaywgaXMgaG93IHRvIGZpbmQgdGhlIG9sZCBz
dGFjaydzIHRva2VuLiBISiBhbmQgSSBoYWQgcHJldmlvdXNseQ0KZGlzY3Vzc2VkIHNlYXJjaGlu
ZyBmb3IgdGhlIHRva2VuIGZyb20gdGhlIHRhcmdldCBTU1AgZm9yd2FyZCwgYnV0IHRoZQ0KcHJv
YmxlbXMgYXJlIGl0IGlzIDEsIG5vdCBnYXVyYW50ZWVkIHRvIGJlIHRoZXJlIGFuZCAyLCBwcmV0
dHkgYXdrd2FyZA0KYW5kIHBvdGVudGlhbGx5IHNsb3cuDQoNCj4gd2hpY2ggaXMgZ3VhcmFudGVl
ZCBieQ0KPiB0aGUgaXNhIHNvIHdlIG9ubHkgbmVlZCB0aGUga2VybmVsIHRvIGRvIHRoZSBzYW1l
IHdoZW4gaXQgc3dpdGNoZXMNCj4gc2hhZG93IHN0YWNrcy4gdGhlbiBsb25nam1wIHdvcmtzIGJ5
IGNvbnN0cnVjdGlvbi4NCg0KTm8gaXQncyBub3QuDQoNCj4gDQo+IHRoZSBvbmx5IHdhcnQgaXMg
dGhhdCBhbiBvdmVyZmxvd2VkIHNoYWRvdyBzdGFjayBpcyBpbmFjdGl2ZSBkZWFkDQo+IGluc3Rl
YWQgb2YgaW5hY3RpdmUgbGl2ZSBiZWNhdXNlIHRoZSB0b2tlbiBjYW5ub3QgYmUgYWRkZWQuIChu
b3RlDQo+IHRoYXQgaGFuZGxpbmcgc2hzdGsgb3ZlcmZsb3cgYW5kIGF2b2lkaW5nIHNoc3RrIG92
ZXJmbG93IGR1cmluZw0KPiBzaWduYWwgaGFuZGxpbmcgc3RpbGwgd29ya3Mgd2l0aCBhbHQgc2hz
dGshKQ0KDQpJIHRob3VnaHQgd2Ugd2VyZSBvbiB0aGUgc2FtZSBwYWdlIGFzIGZhciBhc8KgcHVz
aGluZyBhIHJlc3RvcmUgdG9rZW4gb24NCnNpZ25hbCBub3QgYmVpbmcgcm9idXN0IGFnYWluc3Qg
c2hhZG93IHN0YWNrIG92ZXJmbG93LCBzbyBpcyB0aGlzIGEgbmV3DQppZGVhPyBVc3VhbGx5IHBl
b3BsZSBhcm91bmQgaGVyZSBzYXkgImNvZGUgdGFsa3MiLCBidXQgYWxsIEknbSBhc2tpbmcNCmZv
ciBpcyBhIGZ1bGwgZXhwbGFuYXRpb24gb2Ygd2hhdCB5b3UgYXJlIHRyeWluZyB0byBhY2NvbXBs
aXNoIGFuZCB3aGF0DQp0aGUgaWRlYSBpcy4gT3RoZXJ3aXNlIHRoaXMgaXMgYXNraW5nIHRvIGhv
bGQgdXAgdGhpcyBmZWF0dXJlIGJhc2VkIG9uDQpoYW5kIHdhdmluZy4NCg0KQ291bGQgeW91IGFu
c3dlciB0aGUgcXVlc3Rpb25zIGhlcmUsIGFsb25nIHdpdGggYSBmdWxsIGRlc2NyaXB0aW9uIG9m
DQp5b3VyIHByb3Bvc2FsOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzFjZDY3YWU0NWZj
Mzc5ZmQ4MmQyNzQ1MTkwZTRjYWY3NGU2NzQ5OWUuY2FtZWxAaW50ZWwuY29tLw0KDQpJdCB3ZSBh
cmUgdGFsa2luZyBwYXN0IGVhY2ggb3RoZXIsIGl0IGNvdWxkIGhlbHAgdG8gZG8gYSBsZXZlbHNl
dCBhdA0KdGhpcyBwb2ludC4NCg0KPiANCj4gYW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgdG8g
YWxsb3cganVtcCB0byBpbmFjdGl2ZSBkZWFkIHN0YWNrDQo+IGlmIHRoYXQncyBjcmVhdGVkIGJ5
IGEgc2lnbmFsIGludGVycnVwdC4gZm9yIHRoYXQgYSBzeXNjYWxsIGlzDQo+IG5lZWRlZCBhbmQg
bG9uZ2ptcCBoYXMgdG8gZGV0ZWN0IGlmIHRoZSB0YXJnZXQgc3RhY2sgaXMgZGVhZCBvcg0KPiBs
aXZlLiAodGhlIGtlcm5lbCBhbHNvIGhhcyB0byBiZSBhYmxlIHRvIHRlbGwgaWYgc3dpdGNoaW5n
IHRvIHRoZQ0KPiBkZWFkIHN0YWNrIGlzIHZhbGlkIGZvciBzZWN1cml0eSByZWFzb25zLikgaSBk
b24ndCBrbm93IGlmIHRoaXMNCj4gaXMgZG9hYmxlIChpZiB3ZSBhbGxvdyBzb21lIGhhY2tzIGl0
J3MgZG9hYmxlKS4NCj4gDQo+IHVud2luZGluZyBhY3Jvc3Mgc2lnbmFsIGhhbmRsZXJzIGlzIGp1
c3QgYSBtYXR0ZXIgb2YgaGF2aW5nDQo+IGVub3VnaCBpbmZvcm1hdGlvbiBhdCB0aGUgc2lnbmFs
IGZyYW1lIHRvIGNvbnRpbnVlLCBpdCBkb2VzDQo+IG5vdCBoYXZlIHRvIGZvbGxvdyBjcmF6eSBq
dW1wcyBvciB3ZWlyZCBjb3JvdXRpbmUgdGhpbmdzOg0KPiB0aGF0IGRvZXMgbm90IHdvcmsgd2l0
aG91dCBzaGFkb3cgc3RhY2tzIGVpdGhlci4gYnV0IHVud2luZA0KPiBhY3Jvc3MgYWx0IHN0YWNr
IGZyYW1lIHNob3VsZCB3b3JrLg0KDQpFdmVuIGlmIHRoZXJlIGlzIHNvbWUgd29ya2FibGUgaWRl
YSwgdGhlcmUgaXMgYWxyZWFkeSBhIGJ1bmNoIG9mIA0KdXNlcnNwYWNlIGJ1aWx0IGFyb3VuZCB0
aGUgZXhpc3Rpbmcgc29sdXRpb24sIGFuZCB1c2VycyB3YWl0aW5nIGZvciBpdC4NCg0KSW4gYWRk
aXRpb24gdGhlIHdob2xlIGRpc2N1c3Npb24gYXJvdW5kIGFsdCBzaGFkb3cgc3RhY2sgY2FzZXMg
d2lsbA0KcmVxdWlyZSBhbHQgc2hhZG93IHN0YWNrcyB0byBiZSBpbXBsZW1lbnRlZCBhbmQgd2Ug
bWlnaHQgYmUgY29uc3RyYWluZWQNCnRoZXJlIGFueXdheS4NCg0KSWYgd2Ugd2FudCB0byB0YWtl
IGxlYXJuaW5ncyBhbmQgZG8gc29tZXRoaW5nIG5ldywgbGV0J3MgYnVpbGQgaXQNCmFyb3VuZCBh
IG5ldyBlbGYgYml0LiBUaGlzIGN1cnJlbnQga2VybmVsIEFCSSBpcyB0byBzdXBwb3J0IHRoZSBv
bGQgZWxmDQpiaXQgdXNlcnNwYWNlIHN0YWNrLCB3aGljaCBoYXMgYmVlbiBzb2xpZGlmaWVkIGJ5
IHRoZSBleGlzdGluZyB1cHN0cmVhbQ0KdXNlcnNwYWNlLg0KDQpJIGhhZCB0aG91Z2h0IHdlIHNo
b3VsZCBzdGFydCBmcm9tIHNjcmF0Y2ggbm93IGFuZCBwcm9wb3NlZCBhIHBhdGNoIHRvDQpibG9j
ayB0aGUgb2xkIGVsZiBiaXQgdG8gZm9yY2UgdGhpcywgYnV0IGxvc3QgdGhhdCBiYXR0bGUgd2l0
aCBvdGhlcg0KZ2xpYmMgZGV2ZWxvcGVycy4NCg0KU3BlYWtpbmcgb2Ygd2hpY2gsIEkgZG9uJ3Qg
c2VlIGFueSBlbnRodXNpYXNtIGZyb20gYW55IG90aGVyIGdsaWJjDQpkZXZlbG9wZXJzIHRoYXQg
aGF2ZSBiZWVuIGludm9sdmVkIGluIHRoaXMgcHJldmlvdXNseS4gV2hvIHdlcmUgeW91DQp0aGlu
a2luZyB3YXMgZ29pbmcgdG8gaW1wbGVtZW50IGFueSBvZiB0aGlzIG9uIHRoZSBnbGliYyBzaWRl
PyBIYXZlIHlvdQ0KbWFkZSBhbnkgcHJvZ3Jlc3MgaW4gZ2V0dGluZyBhbnkgb2YgdGhlbSBvbmJv
YXJkIHdpdGggdGhpcyBvcmRlciBvZg0Kb3BlcmF0aW9ucyBpbiB0aGUgbW9udGhzIHNpbmNlIHlv
dSBmaXJzdCBicm91Z2h0IHVwIGNoYW5naW5nIHRoZQ0KZGVzaWduPw0K
