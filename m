Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BAB5F13AF
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiI3UbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiI3UbH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 16:31:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DB169E7F;
        Fri, 30 Sep 2022 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664569860; x=1696105860;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NvsIfHUKiGd8o45nHrUaurhjqs8b1bqeN5ML2tpA6tY=;
  b=NpWEK/e7u4xt4wsoEUwFUkOgUP3G5z2ELfVc9wSwbrHuMcvpzhCh9v33
   ez+mDj+0FUOAEVEiUoaPbrN+KYARHJ9GxXuzyqbRIL8+K1SvvJlWW8SPB
   bHWkTzlR3zGlcOYfN8rS7NkF5Qew/9nXZli8efLAn8wPrzO4oA0gO7szR
   U6FVX8biL5vkYGTTVEMyVW52Qd7bnOdLpyk/zlEENOBNOHdJ7tiG+8+jK
   OtBmt5Z/xiHLn7gqJOt4EuuBTYYFYnADphKQEIY2BO+YwBFDefdtZbb51
   N8IRQlkQhVn75kl5yI+CsQWuVphKT3M/yP5U3yhWzk1GLO5eSbwHsg+b6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="285419755"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="285419755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 13:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="685417045"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="685417045"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2022 13:30:57 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 13:30:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 13:30:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 13:30:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 13:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUhmLQ1QcNPjlhnLBcIHwWkzPJloAlnbZF/oN445wxKOU4GyhFrTgzXp+fKWua+zrctrSzr6f1mqtV2OB52wGbGyUGRXagF2xiMi9jC34XTobr2sJ7tlGNNaPaKsUzpU9D4OvbqpmFkJLnrqxbAy872coZPSms+tu0t7wjVEiviUa5iXsQuN9vI0nYxJrFmwlVSQr5BsV+ZVFnz1YAKXIEhTwIV/M3aaZQxmbCPwXoMff5ZOuslanguYvzOYaZosBRyF7HzeSxxO2s9pRafX2DLfAm3MCaGzf282FT0cyZvJVEZnri0R2+vu5fiUkGg5JNXaogAgZRO/JB2LCr5ezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvsIfHUKiGd8o45nHrUaurhjqs8b1bqeN5ML2tpA6tY=;
 b=lRVw0f4yXRUi/1C0JsWApHwNM7POqliBTKSr0YEHbR0mHUHnF0BfWuEEgelr1DJ5PRmD7faaSa9wykDEdEua4jNpnIiXXf5qJcVRewhUHorJ99kiWQ3xQ961fhd0G6m7C8/ZQ7LrOILd2aj0MQ46osgb2ShmYj3rCKn37wBXLyzc0wbSDMCOeeCBotPN7lan3PVpzy+nUR5l2gFJtRUzHPN+WYSas32AFHzEJ+GohR44KZlhIfE9nC1LyAurQ+O3B0JD8+dTgKDdZRAm1SIt9aUn5aTRQoua1I9YnNXxnAGGrlo4e5Hcbjq6GUT3rwaru2zx/mTaE0torvIOtMp5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 30 Sep
 2022 20:30:48 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 20:30:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHY1FMhyDNj1/XJr0mpEcU+bucxPK34WbiAgAAUrIA=
Date:   Fri, 30 Sep 2022 20:30:47 +0000
Message-ID: <44314145f644ab822ac36cc8c78520d5f34d5bd8.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-23-rick.p.edgecombe@intel.com>
         <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
In-Reply-To: <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB5942:EE_
x-ms-office365-filtering-correlation-id: 76030d69-28af-47d5-45fe-08daa322a8a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyp79SPdMPfSLTCDeNbAWzfv2NYOPp2hMp+aqW32ayX2WCHLQac92Pwmjkac+TeXz6yOiVyQINkJI4dGz4YqMgAncmyN1FcwFaoOBZyOELxiWG9gLF3gNB/CDx9PqvXcxNpKseQKBn2j+76ekmL5SNKlp6Cxmlj90qHj9utC9isGv2qLwbf+082RweVJZTGfWYcIe3pi/6zd15jS8fj4cjLvC5XMlbM5j466eDDnZ0/VUkryLM4axWWWRyTH7V7mwQXJmriKlIn29KuBPfyC7D6uowBuZ+KcKekYMd75gndAVlNl+47HGEWlEF9FCJO+AJ6G3yiwl1BZ2oFCzjEpXvIEqHFphbgUhS32OBL2CeYp62Z96UQvv9E/BqGQeLbgR157dTj6aJXmqWzl25HB+qZQnVvpE2cs6IQokLzoBz2FxE27dU9K0Ab+kzwJmmZQ8gEj7XyyVI5FEaMNbnR/XjM54Sf+WJrUhorovC25L94xRW80Uht4xeW4YfR6SGpM9eKVP/RncI+JDUbfRTb0VBAeqCkvcupswYveSQJyDd0oefP1tibP4bX3OdSGPbHEX8wLuKrX9tETNs0EsvGbbfL1eJX14YEF4mhsECYi/xQWlIT53/5KOIAKxRkKW5HU+9rJX/Si1bxfpTsGvDyokSlVZLx3mRoK9Ay4tqpjIZ2jYD5EvCXCyKz5WoOeUoax2Wg3ir6q3qNFx1sEDsAFJazKtHoR7HQ8DA4BosfswZvGt2NjotjpBN+4V8qYOvvpyO+UiD4jgMyNet8xdsns44CImjg2VADJJX994YLJ0dD+3H+vjhCUVla/cLMkvfGT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(2906002)(41300700001)(6506007)(53546011)(4744005)(26005)(7406005)(7416002)(6512007)(921005)(82960400001)(122000001)(5660300002)(8676002)(66476007)(66556008)(76116006)(66446008)(186003)(83380400001)(38100700002)(38070700005)(36756003)(8936002)(64756008)(2616005)(66946007)(86362001)(71200400001)(110136005)(6486002)(478600001)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVBxbkhCbHp6b2ROTGNSTDUycld1d2cveUUvcjdJWkFtWTR4NnhHWTFRc0R1?=
 =?utf-8?B?MG83TE5FaW5kbzg1WGhSbUJMTk5xdkdqNlZ2NFFqUmJJK0liVWJuUytSOEps?=
 =?utf-8?B?aWdvemowYjNUdXdpdlpTVHUzbncwQTYvTk13RlFxNHAxemh0Y3JLMHFrbGVz?=
 =?utf-8?B?Z1c2UjRlZHpJQ2YrdzdBcUNaZEpjTmt4eWNzekZEYWNMblNJUmdwTEFHRmVN?=
 =?utf-8?B?Z3AwSUxBY0lzSGtlVnNwVlhnQnJ1elhBTzNtQ3dVY3VWcWpiUjd4VW1DQTAz?=
 =?utf-8?B?eU1zdzl4WUliaXZrM2dvVmM3dXdyVFdDbXd3Z3doaFFBUXVtd3J4TE1NbDJx?=
 =?utf-8?B?ZVFJdHljOEdKWDVkTUNkRkxaNkt1ZElJL3FPbGcreWZvRnNnZitlWjVtMkg3?=
 =?utf-8?B?SnZ0dUJtbjZZVjBRQmhmL3huaVFFUERoR00xcXZpM05kQzErU3F1V0xqMCtB?=
 =?utf-8?B?VjlnVjVaNU1sbkk5WE1qWFJkcjhyYnFkRnkrQ0ZZOVJuK1FkT0I0TGlrMlJC?=
 =?utf-8?B?SDd6S2xvejZONnMyaUhOTGM3eHM2TmR6UjNaS2l2S2EvQ1FscjhwSCtpV0NE?=
 =?utf-8?B?YjNoMHM0UEhiYjkzZmlNNGNUWWJ2eDZZSVNnKzIxV1l4b1VYUThEaVNGYjNr?=
 =?utf-8?B?Qyt5cHZvQTIxTjdqdzhyZ25Fb0NtN3p4bER0NDhDN2NXUUpGYlFpZ2txL1FJ?=
 =?utf-8?B?WkJkc3lhd0tNN2FnNnFGU0Z2cXFXYTVxVzlNUnJDSjNFZXdKWmxJcVFURFRQ?=
 =?utf-8?B?cG9nM29MMXBMQXFRNjhCRVRBaDBqZVRSQVNZMlZQbEpnTEFmSURGTXdMUnFo?=
 =?utf-8?B?akMvdTZwWnQ5MFVRMEpwUTVYcEtXRndJWWFLbjc5bVpXbVFDMzdjZEFKSS9B?=
 =?utf-8?B?REV5dUYzeFUySDRYV2hDK25wVjc4U1V1TEFGUFM1TUtGZGpWc1BPZWNKdDla?=
 =?utf-8?B?b0VuTDZQTDBuakhOSUFBZzhjL0NQL2c5d2U1WmRibWNPNDVlNHdYeXREQ2pJ?=
 =?utf-8?B?QkFTK0ZpQ1lSV2wrZFJVZUwyK0hLZXRUa2hiUE9FRU5JVDMxWGpHY0FSbkMx?=
 =?utf-8?B?VmJQVVpNWUZmam53bWQvRzVSVHdSRTY4TVJGczVIMVRNL0FnNW1sbkgrUC9G?=
 =?utf-8?B?NWRINFR3elJlYURMc2FRYWZUUWdXbW1XZlFXTUR5WThlNUY4MnV4Y3BER1Fm?=
 =?utf-8?B?K1pOVzUraFJHMkRwZm5BclNseWZ4TjRGUDQzZVd4aklkeFNEbTkzMko0ejN4?=
 =?utf-8?B?K25JcWFaV2R0TmJnbHdub041cFh6S0xwSWdGMHpqQTFvKy9IVG5PKysrLzJa?=
 =?utf-8?B?Zzd5SDJHdzdrenRTaE0rYUk4aXlVRUNVYXB5NVdaZjBKdkJNeEZDeFhoaFl1?=
 =?utf-8?B?TURxNnZyTC9XTWlmbEMrZGhqVzBVTk5USmoxR2d6V3BNTWJ1UGUxZXpGL2F2?=
 =?utf-8?B?V2ErTXQvV0xXb0ZHeWs3VnMzZ0ZQYXJiRnFUNXhCSnRMaGFZYldqb0JFbkEx?=
 =?utf-8?B?a1MzK2ljcGhWT0RTSU9PdkhEVWx5RHhKc2VrcU1ONmtWeXErUThkUUpzNkx5?=
 =?utf-8?B?WkpFdEhRaSt3YzEydUpVay9obVQ2V0FrNkZyZFNHanRmbEkvWVJobTE2TGN6?=
 =?utf-8?B?T3hNMlNJeGNxeGkra0k4YnhrZnl5Qk4xNVQ4Qm83bEJSYUQ5eUdCUjRneGNM?=
 =?utf-8?B?NEpGUDhwNTFJeFdDTnJacDYxeDJtRjhXdW83eWRxVkNjaVNQSDRpS1pQRWhv?=
 =?utf-8?B?L0pYS2lvUTJWa1VQZFJkRlVGSHNqMXpyTllVK2duRXJpZlhSaEQ3Y1VGYXBO?=
 =?utf-8?B?Q2F6V2xiNHJtTlBIV0NmdEszSnJKWG5wRFJlOW9KZHhZTUwwdkpRKzRWVHdH?=
 =?utf-8?B?NUhiamdINktkVVFUYVdBUlpPWkJzM01FRHFCeUVYTHlYOG9EV1BkZTJnUjND?=
 =?utf-8?B?OVprMXdIZXNWOWgwWTA0UTRLbUkyWGk0RFM0V1ZzTFRZdk5rT3pReG95a2xn?=
 =?utf-8?B?V0NKWm5TUFRoYTNoaVN6YmFDVTBPWHlJbUdqUm9uRUt5NzZXY2Z5akE4Nllw?=
 =?utf-8?B?QzUrVmdtQ1l0WWVDaWxtT3Z5SjlLOStiWGxRR3BSSVpvSS9nRXVKdzhzeXFX?=
 =?utf-8?B?MGFJcU9QZjNqUU8rV3NRU3BQZENTeC9uWTdINWF3akpUYXdYcGdhMW90SENU?=
 =?utf-8?Q?xjbEYbo7HRMySYUXhEScpuw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <590CF8DEB7688949863BBE3B315E6B5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76030d69-28af-47d5-45fe-08daa322a8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 20:30:47.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ti8gU+4jS9qDtgQ0SMZiErnT+gZ9w5pocrnxsh02XAYiaN9M+ec9Ig3EI6g0a/VnnXFIJFGbHKD4qTyZ6Xz+zL8PFc5CQGq9rFSp+I+es4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTMwIGF0IDEyOjE2IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8yOS8yMiAxNToyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gQEAgLTE2MzMsNiAr
MTYzMyw5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbA0KPiA+IF9fcHRlX2FjY2Vzc19wZXJtaXR0ZWQo
dW5zaWduZWQgbG9uZyBwdGV2YWwsIGJvb2wgd3JpdGUpDQo+ID4gICB7DQo+ID4gICAgICAgIHVu
c2lnbmVkIGxvbmcgbmVlZF9wdGVfYml0cyA9IF9QQUdFX1BSRVNFTlR8X1BBR0VfVVNFUjsNCj4g
PiAgIA0KPiA+ICsgICAgIGlmICh3cml0ZSAmJiAocHRldmFsICYgKF9QQUdFX1JXIHwgX1BBR0Vf
RElSVFkpKSA9PQ0KPiA+IF9QQUdFX0RJUlRZKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+IA0KPiBEbyB3ZSBub3QgaGF2ZSBhIGhlbHBlciBmb3IgdGhpcz8gIFNlZW1zIGEgYml0IG1l
c3N5IHRvIG9wZW4tY29kZQ0KPiB0aGVzZQ0KPiBzaGFkb3ctc3RhY2sgcGVybWlzc2lvbnMuICBE
ZWZpbml0ZWx5IGF0IGxlYXN0IG5lZWRzIGEgY29tbWVudC4NCg0KSXQncyBiZWNhdXNlIHB0ZXZh
bCBpcyBhbiB1bnNpZ25lZCBsb25nLiBXZSBjb3VsZCBjcmVhdGUgYSBwdGVfdCwgYW5kDQp1c2Ug
dGhlIGhlbHBlcnMsIGJ1dCB0aGVuIHdlIHdvdWxkIGJlIHVzaW5nIHB0ZV9mb28oKSBvbiBwbWQn
cywgZXRjLiBTbw0KcHJvYmFibHkgY29tbWVudCBpcyB0aGUgYmV0dGVyIG9wdGlvbj8NCg==
