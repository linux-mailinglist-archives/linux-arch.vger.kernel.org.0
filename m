Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65925F3AAE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 02:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJDAc0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 20:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJDAcZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 20:32:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC91C137;
        Mon,  3 Oct 2022 17:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664843542; x=1696379542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JBpKRj35ePwFmkzXurTU0BmO+CNO1qe6wyDsdtEcqjQ=;
  b=WQpgU2jFP0iBgXMFrzQWffMy6ah6zc8rR62aQupvoA9cZSP9TkjrMD1Z
   JfoPAqFz0uU5qGOvAucnx0IFJ4/KdSSKgMvYAQ+9d0JIwYEAsddOYAgPB
   CyTPWxlrC586SxQ5X1Q7MxoA+PUsRujGpczpM6gVqADpieM56VMkCzcPU
   NomH3wDUwD+jPuna7ADysS0DHDTu2m5n610gKPbZ8yfcBVoEl/UxhMg8C
   1c9I7EMFXSiQ6aaBnE8TRqMNw+MVuOfQTaPJ6kMOlZR68bNBn6gtOCIKI
   9Hj5jeKEVIYAVgy0GoifCUwKqwmYmcyTaPCT/losaAm82qCIm0AhFvQki
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="282507125"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="282507125"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="868819767"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="868819767"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2022 17:32:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:32:21 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:32:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 17:32:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 17:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAEuY5lPzAmyyt7H5ozR/J//0GGnkyUHN1ejAQD4Q0xPa1COByI+fb7Dgt2uahAnSXeZxgjHGDzQYW0bmCZJ/hKJFdT30UKVvNjEMmK66fuYgNgGp3ZbfPdITbL2E4VSyPYaiNStsh9Boo8LLmYgyzEMHntBrl1I811UNXuHEzl0POnK6vLXq9VuiKolGXmnVW5839AcJaoumOBls90vwaoMjyAPdiijiXX7KhDaEnHLubc19kygqdfrQgKkEo/h7SkQpx3XZvMJvVgEo7+WR/WnZQKVUAIS4iCmS5IhGMQMvZVkk7+i/hxdczk8huIbuq40cbieaIR9jKD6B5NtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBpKRj35ePwFmkzXurTU0BmO+CNO1qe6wyDsdtEcqjQ=;
 b=bDqjWeamKVJgaI36FBmDzx1BW6JOPtiHNGmnq1QOr6WW80zXWobydD44xZzW7KWnVC8ylsUXwlk2405HL8kYAr4zO1u71a98//J6CDlR6OgYKTMWmA5kcocWnsJ1NNGPQnLQAVpeht1dmIQvt0FlCTII6efsaTPeCL9jyNOSFSTW+y5boqZVz3rK1FaiiNAw5hOzMAPtqpsS8/tiMKNMYz4YbRqwsqHs1nPqXxBlCZFHPV6JVt/rMxfG8QEdHs62N/4m89I9Kla6W4zhQrAJCgvALWn8oqJGCmZ9ZVw3jWj7T8t6asVgbFCkakZWcjwd7DugQrWzAGGP5iB1JUiWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 00:32:15 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 00:32:15 +0000
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
Subject: Re: [PATCH v2 19/39] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Topic: [PATCH v2 19/39] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Index: AQHY1FMcoeNw9CQ3v0e1Mo/Kb8xeoa39YNkAgAAIAAA=
Date:   Tue, 4 Oct 2022 00:32:15 +0000
Message-ID: <9616951fd9440cdef57c8703cfd5f41eafda0442.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-20-rick.p.edgecombe@intel.com>
         <20221004000336.cpuats6iamw5ob3h@box.shutemov.name>
In-Reply-To: <20221004000336.cpuats6iamw5ob3h@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB6574:EE_
x-ms-office365-filtering-correlation-id: bf56e053-519e-4754-b247-08daa59fe30d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prugILMkZnoVUMCBhaHtjwCW2+1RrzOyCMr9zoVX3MhJ0cakQuZTSzkE+/mxQXSVZZMCCwueN6aRfmBh/2ksTOm4Fa+9Y7BipoK8LhvxJJ3ZX18wmpKLcEBhuHFQuJ3kKRfM1bVd5DTb+3h7P5izE/+PIFkC523W0oCoL/eQ/p+x42lYORoKf4VjdJitrrmA7HZeQVSLafX8QZzFoka7V5YqlQnveGShlmpXY4XNJKy/Q87ZaIVnfZ6Mqfdm5PkBbdMDT/ByMAuNEAC3iQ5m15O3QbhwJ6FQI09tehBBaeiFrjxe6Ys57CJFYH2H8qD4fcQ4yZ9nydLxbb5RdBl252YohxhQ0Hv4s2sB3E0K4iW/FGCvXereE9cnQhxO+MFy3bLDct7zyT+JIMJ0gxBuD12pUH8Xc27Qpa8ev+67IAAPX42Lu8nLD5hmB9DIe7TDxMOcOKWC1Vw6y3PM+huw40RZ/lfg+3RanZwJZW4V21ajOAeKoYCQA4oT/bg8dss87cKf0hXcU2f7r1uGkHbS8C99M7ZwCNUL+i5VC4J52E+COjAChSF2pxRmnlf502Qy9w6uPhBS7eSwFyVXwFFRnn++lrgFskByXqEsaao5v8CXY+fAHl6JCvJIFgEZd7bvlK0WZHGmdNZmW8LGo0fH8bm+7mkNmYfU2t/BIPEwYEKaTHV7gPHFhovlXgzBqoMbIcfsCJLxvJ7ec/cen2jR5bLSKk9y72g0MP7yuVdaNNEVTgTEtBVgjhkdEaT0BkC3cNrAaMjUfCjDCdNPfHCu4pxcTMpX5NOIMZpgM3G4w0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(38070700005)(6916009)(6486002)(316002)(478600001)(82960400001)(71200400001)(54906003)(122000001)(38100700002)(15650500001)(186003)(4326008)(66446008)(7406005)(41300700001)(66946007)(66556008)(76116006)(8676002)(91956017)(64756008)(66476007)(6506007)(6512007)(4744005)(5660300002)(26005)(8936002)(86362001)(7416002)(36756003)(2906002)(2616005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0crZk1BS0ViYUhjSTI0dmhRT0pHclJ1UVBRdVZheHUxNTBrN3RZNHFGOCtT?=
 =?utf-8?B?Q0JlcENwNWpVMjhDYlpNS0czZ1gySlo2K1hScGhZWmNOMUZmeVlmRGtjYWRM?=
 =?utf-8?B?N1RUQmFVSmIxSWZXa1NhUzBvcjkrRG83QlV0eC8zc1ZBVVNZdTJFQ0QwZ2Zo?=
 =?utf-8?B?MXQySVErK0JoL1hBalhMWU1nR0hsQjRsbHg2emQxdkRzcEZTMUlYSjBobE9U?=
 =?utf-8?B?UHVqQmdmNERNREQwaTFtOFlSSnZ4aGpTdGExUjQrdjRPYkluTldCUkJWNU1x?=
 =?utf-8?B?Mjd3L0hsSHIrU3BFQUpGNlFwTWYvWENpWXowclV5SWpWQW1naGhuMTlDZGpm?=
 =?utf-8?B?d2laaCtzTXQxamgvNGNjSURGNjNPNEoyYTMvZnNJK0tYMEtmL1ljN2RWSXhD?=
 =?utf-8?B?UEpYVklpcUNkaVZzNzB6N3gxWms2a0J0dzRlV2FQTlJHMW1JeU5OcGMzd3lI?=
 =?utf-8?B?RWVieWpYK3YyOE1yYU5jK3FwcmQyYk5sYmlBWDBBTWVhZUVtQkVtQkVjMER5?=
 =?utf-8?B?ZStDVCtsd2VlMVRnVGo3WTloOFNIUXVpMjR1bVJwUmJRY1lHUlRocVh1MnFa?=
 =?utf-8?B?YTBZQ1NmblhBSlVOZkY5eXZGcHpMaWZuM29zZ2hyUW5ZbmZ2WGpWem9hY2JS?=
 =?utf-8?B?M0F0bkdGMExnUE9XMkxibTIxc3JZdFNlV3FxcUp3c2kvMmtrRjdzN2J0N2pS?=
 =?utf-8?B?OTBORWpTSXA4ZDRvK0hYZHZ5VUdYejdyMXlsUXdTdHVFWUUrODZsS2Y1NkhK?=
 =?utf-8?B?RmFVZ2JxcVdZK3VWZ3ZBL1RYQ3cydkYvREZhQWlqZ1RXeDlzL2hYWXhIemZ6?=
 =?utf-8?B?VU9BcmxSQUZxYW5kTnlCRmtuRlNCaU1jd0JYbG0rTi9JSDNETnprcU1WSG1v?=
 =?utf-8?B?NVROQTRxYlRPU3dyVVl0cHQ1MnNvdXllNEFTSDRhUCswMXVnelFtQXhRMGVY?=
 =?utf-8?B?R2VUMTFNK3NIUklpM3Y2NFRITmZRK1NSM05EQ3MyQWwxdStuVnF0NElqSVNz?=
 =?utf-8?B?QlpXanpwYjIwSGNjZkxtR2pBQmdTSjJUYzJSd3dqTGtlR0Z5eEloNjBDYjBC?=
 =?utf-8?B?eDRrY1Y0Z3NKSW1PQklJMkhMS1JIY2lDaFQybTJWcGswZ0ZmYUcxWFo1UHV5?=
 =?utf-8?B?d3dUS3ozcVp6UHJpcVVBTGVudW91T0owMmR1RVM5OFd2M3RWNmZUcmFURHhP?=
 =?utf-8?B?YjZyK29rTzlDcElJU1JmOHp3RFMyb2VsZEVQTlM3YUFjZzBOUjB0Y2Y5VVNZ?=
 =?utf-8?B?TU8xQ2x4Ty9YZUV1U3JsclFhU0tuUkxvd2VXVzQzVWxJYVY0aStGTUlJWXQz?=
 =?utf-8?B?V0t6dDYxZ1RiY3B3OWpDeENJUEFORHpvUTR2cTJtTjdSdmJySUFmWGlSc2FH?=
 =?utf-8?B?VkFpYlM1VnNGM05EZFA0UHp2bzJHcEJhTlB2cThwVU5yTitNcUJaRnhBa1cy?=
 =?utf-8?B?Z3QwTlpsdnNXUjk1TzE3WEZyL0N6OG5ZMURwOEFoNHJUK1N6NzhzNkExamgx?=
 =?utf-8?B?SVJNZ1RJWUp4cWtGbGxCNTRVd01RVkVUSzBMVTNmSWRvNHRpOFI3U092cEgy?=
 =?utf-8?B?UGNHNEJOVEE0QkpjUG5VdDVNUVFPd1Jic3NWSzMwMGo2cGVOSkhiQnJCN0Fl?=
 =?utf-8?B?RHFKQ0ExZmxHc2xRVktOQVY2NWZmM25Ma2dPcGlMMTMwOXpnRWNFVkNuR1dC?=
 =?utf-8?B?alQzYVdTRFRmVXc2WkJ3SnlXYzRNazliSzcxN01jNUtpVFo3dWhwbjZwejhi?=
 =?utf-8?B?MlBvYUFNVnFXTHI4VzZnSXBMekRQNFA5OWRnVkhTS3pxY2RZWktkUkhuNHBz?=
 =?utf-8?B?ZjhVdER5RjJvdWs0SlBzeUFaczlZTzgxNktiNkdXWm4xQVRwSTcxVEhaUk0y?=
 =?utf-8?B?ZDFDYmwyTFJaV0ZCWEZOczVOSXR6VTl0Y090blJSemZjd2RFUWhETmlGdDZG?=
 =?utf-8?B?c1I1RmtnaFhsU2xOQVhVeEpvV2d6QlV6N0VsZFdsN0QrMjhWZ24xYUhwaE5j?=
 =?utf-8?B?YXBsWFEvUkxFV0FUd3VLQmRvanNNMFdYQ0xOMXdINk95bnl1NU5qSXFBYitX?=
 =?utf-8?B?c1krcy8xYWxyS09YaFc5L3Q5UmlPYWlJOUNUQnVYU3NEZURscUhYQy90T0FY?=
 =?utf-8?B?VDlwdUhha1RqdldNUnZ6NytyalE4M0ZTdGRFOWdhc3VBVlA3dHF4Zjl3RnRv?=
 =?utf-8?Q?nZ2z0o4XYoTwsbvGlVUFK+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F6F1D9E59E3B74BB56D020B7F7DCA6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf56e053-519e-4754-b247-08daa59fe30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 00:32:15.3430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ja1X6DmCcEyYmzYSyk3V5Ft+bkiEby/t+144gfURBz1ozRgd4rfkbCq6wlE+60H6kJ4pMFIv67UkTqlX583A3NTXySt1RlCR87AeIA6d5vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDAzOjAzICswMzAwLCBLaXJpbGwgQSAuIFNodXRlbW92IHdy
b3RlOg0KPiA+ICsgICAgIGlmICh2bV9mbGFncyAmIFZNX1NIQURPV19TVEFDSykNCj4gPiArICAg
ICAgICAgICAgIHJldHVybiAxOw0KPiA+ICsNCj4gPiAgICAgICAgcmV0dXJuICh2bV9mbGFncyAm
IChWTV9OT1JFU0VSVkUgfCBWTV9TSEFSRUQgfCBWTV9XUklURSkpID09DQo+ID4gVk1fV1JJVEU7
DQo+IA0KPiBIbS4gSXNuJ3QgdGhlIGxhc3QgY2hlY2sgdHJ1ZSBmb3Igc2hhZG93IHN0YWNrIHRv
bz8gSUlVQywgc2hhZG93DQo+IHN0YWNrIGhhcw0KPiBWTV9XUklURSBzZXQsIHNvIGFjY291bnRh
YmxlX21hcHBpbmcoKSBzaG91bGQgd29yayBjb3JyZWN0bHkgYXMgaXMuDQoNClRoZXkgYXJlIG5v
dCBhbHdheXMgVk1fV1JJVEUsIHRoYXQgY2FuIGhhdmUgaXQgcmVtb3ZlZCB2aWEgbXByb3RlY3Qo
KS4NCkJ1dCBpbiB0aGF0IGNhc2UgaXQgaXMganVzdCBzcGVjaWFsbHkgdGFnZ2VkIHJlYWQgb25s
eSBtZW1vcnksIHNvDQpwcm9iYWJseSBpc24ndCBhY2NvdW50YWJsZS4gU28sIHllYSwgSSdsbCBy
ZW1vdmUgaXQuIFRoYW5rcy4NCg==
