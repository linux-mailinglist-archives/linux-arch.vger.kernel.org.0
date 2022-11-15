Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2362A387
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiKOUzo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiKOUzh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:55:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CDE19;
        Tue, 15 Nov 2022 12:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668545736; x=1700081736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kg/4UTiAtvUQ8J99d79+UYP6kFDpAmcdsp91+JBb8zc=;
  b=PO5gGyRXvPuPxZFCKicfbKkAbMNnVxAwp+6Yhd6T8HhDslPqOpnqurVp
   fjSBgFn8+6qFY5HlcH3XDHHL/lpc2o8XWxH25iFEV5Ht6CfwTouXScxCV
   Y1iIOV4qezsT/W1kmg6urHYpKcVpqjdykU69cKePOTDgPG3p5M40g/e1X
   dSQ7CcwpTrUUDMhG97obKi13kBVXnvxdYxQy49pM7Y52S/ZIoUiNobyRg
   f+zKdD82TwOVGjJ5AZKYq2ZMjTLy24BLgSFCw/qBygkRxx1g1Me8UG/vR
   AhiseF71jfzXWfA8K1gfCzmo0JW6CoF01urRI5PB7qTkyC/NnXxwqFnSg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339171197"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339171197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744748383"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744748383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 12:55:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:55:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:55:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:55:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoOXzLnoJ67pcOd4bCn3uyRw65hzUcUFmX4p6cxcFMQBmx9yVEXv1JpmxolEdqKeAy7gYZTBNVGO0T9Sj5nvKRCX8Of6Huvj51aH7Rj60TBYWK88kzu6uMg+aAPSbmZEARv7IADowna0Syl5okbl5GA8TJVuyRETwm6gCXsUyH5H0pHEhKFOGej/DyNXPcLaw0WbZ2EFxzbvoI48aNIy0wXzLzXR/ZaZnXtMW99sodUXZP/G0RK/VtkCIiH84UkoxRKqLkQrR164lBBUQiW8TLLgee87biUuEwuk26IkvTlWSlZ6cizNPtKHms08/vq8bpN7+V4mOfUapf30A/KK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg/4UTiAtvUQ8J99d79+UYP6kFDpAmcdsp91+JBb8zc=;
 b=clHLy1puJ4BBmgUxNogYbDMMcQBwSHp1DY5XqoJErvb1oPXX8BfY4JRlXvkzBkZ3N+ByGbBNtmoj+mFbqe8VZq0rVnY4fFUvXTcZgr7v0Oo4Q+gXbmhCIwHDoUxZjZvnrIGvJq9cZ86ggE7FY9EpwoNnAWISoKdC73GZkTL0YMClpYVoIBx3k4drlMeeveYeJHoDwT+pYcZx697AeUtDXdOO7BCRRpp3IE52jYNVl6r9areZsKgxEa63AwPfni13k08t7sZVqa2jO9NiiD+7wD7oZQXQO+FrgKBqqgJK2Q/QdygM6XYKyH6YoiiqB4fVIvTBJblAjPNrq6OnZNBPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 20:55:23 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:55:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 24/37] x86: Introduce userspace API for CET enabling
Thread-Topic: [PATCH v3 24/37] x86: Introduce userspace API for CET enabling
Thread-Index: AQHY8J5YHr+v2xwnHECK23R1RZ+v4a5AGxGAgABs2QA=
Date:   Tue, 15 Nov 2022 20:55:23 +0000
Message-ID: <557a06744fa59e2be3f01c5714a0daa2525c14e1.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-25-rick.p.edgecombe@intel.com>
         <Y3Oha6lAIlwypktM@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3Oha6lAIlwypktM@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 156067ff-9595-4cc7-9718-08dac74bb71d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqp997O/W9k8etlN6F01TcvIVZ31sfk590RCKxBTMHryAHFRKJBBcRz2FmjwEgxoxhdEnq5z3czFnRRD0ibdf0CylzXSdo0kJdfdEHrTFiLbE5iWNJDnWhs/qjOE58oV8El8HnmJRNJbdAQnsN9s8cY1PSlkxgJW5myzuE8Ftj/zDoMMtX/r7uhfskUI0vaOaG/Ve3vjTZBNLwD54zqyhNVPkhXs2VKfh/3tHzL5T+oRt1BFTJRcx4c0jo6wu7OHCqqaODggdBk6Zfr5B/ZBRKan0ThzNccRNPZ99/ZeWXevelezmF5usSVr2PemYFm3OO7vYDjJhhET+9oYs8R7RBWfq65xW9UsUPIwgT+ClFNKCrl4aB7LtGK2hF71q/+W7yF7L4ccf5h4we/I7aV+DDh+VBs5+RsWdqPtCFYUnestTnvaU83lSaFfEVY2DrFjX8kjpEvr3Zzk3FVxu57eNbnPebZFzUSerCzblEMY3Msc0ULWTkyJzPbMExp8fisZ3vZOYSGSKFVnNvw8nlwrgGWjHJlPxSZ9w7X4BDyfEPkiPmkasrlgww0qbTmYumzMqtWAF0InQ5W4t+lqC3w1ELdbn11ISFc46R+iEgXxfmDjxG8bB+7XTdj80gGteWYPcXoTx48K+ad+XE444ezBDJGb9do4Xet+WTL6sRu0KI711rJINCOnvzyuEQT13YMYyxTrcZ8v8amA9EOOWkTfLtYPgheR96C1pxcsj37W4j7a4dGkmjhB5x+GuhWnOKKuY8+AFu3nsU+xWxsJRLpRG1XO4HNZfaCzJBoJGqsdivI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(36756003)(316002)(7406005)(2906002)(66556008)(86362001)(38070700005)(4001150100001)(38100700002)(4326008)(122000001)(2616005)(66946007)(66476007)(91956017)(4744005)(66446008)(8936002)(5660300002)(54906003)(76116006)(7416002)(64756008)(6916009)(6506007)(6486002)(8676002)(186003)(71200400001)(26005)(478600001)(82960400001)(6512007)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1I2T2haeFZ6ZDU2dTRpQWZoZm1ia25KT0lWTUtDd0hRVS91K0NrOXluMkRi?=
 =?utf-8?B?UStPb3NOcWRzMU04NEFVdkNVcFNhOHlpZmllRGw3RXRqTWg2Z0w1cVZEYWdZ?=
 =?utf-8?B?TFpoYmZmbmcwS2d4UFFOZ0MxNlp0SWxIZ2t6dEd5aERJWlplOHoyQk1VRWsv?=
 =?utf-8?B?RlRTejcwQ3ZmREtJZ0xJT1J3U25mV3ZlY1N3c0puWkd5eHYvZFhJeFdjTVpr?=
 =?utf-8?B?WHZ1Y0dIZS90RlAybGVBdCtQMnZXaTdiajA5em9iQnRjcDV0dTUxWFdoUXZw?=
 =?utf-8?B?Y0dWWVhPL3pwRWFoNkpmWXhUS0RVR3ZIc290eE1tYSt1eWdlN0Y2dTM0NkRV?=
 =?utf-8?B?ZngwUzkrbVBXcnlSeXRwS2FCTDZscTEzVmdwbzZwem02OVJoSnlYaFBKZlpW?=
 =?utf-8?B?OWdhMEpuNTVIek8vK2RMNThVRDZTS1hDczIyS2RqenlOTlVjTXk0RlZUVnpD?=
 =?utf-8?B?blBEeDNnclJuWlFJL0tNR1hSWDFGZFMydWZJcGhvUDhLdW1sZUVtd0ZnTlJ6?=
 =?utf-8?B?UzNiUnhnb1QzL05JWVA5TnFSVzBEMVh2MXdiblB5Z0RaZ1B0bDVhclFtWFM2?=
 =?utf-8?B?aEIyTWVXQldON2ZkVWtYSU5oZldZOU9PeWZJOUY5VGtNYWZ4cFVSMC8xMHVH?=
 =?utf-8?B?Q1FZR3lPRW8xK3hjdWtMSHRadzQ3ZGNVTFU5bWNiQU9Ma0xBWjlUd1JIa1hL?=
 =?utf-8?B?eGlGWlA1Nk9laWt1SXQ1RitXRjFhQ2tscDZaSjdnZjdGSXJwWWF6ZTdNTzBu?=
 =?utf-8?B?YnhuZ2treVRzKzFtdUhIQ3M4MklVditkNHBwTUhjMnBkMFY0SW93eW9LQm41?=
 =?utf-8?B?UFZtUzBLTHBjck9pa2FvYXJlQkhqV0pJWjdhekE0dVpIVHQyOVBCMEFibTIy?=
 =?utf-8?B?VXVXaDlBeGdBdlNQZEFtZy9ScS85MkZXT0lUbC96QXlEZkQzd2VHWTdLRXFZ?=
 =?utf-8?B?MFlVQVlpdTE1MkdOSVhLRmt2dzVPRkNiK0t4a09tWEZvc3B3UTM4N2NVaEw4?=
 =?utf-8?B?WmVpMDlEOGhmT2NZdDd6NnBvb1NsWDZqUTJ2d3hZWTh4aklwbnpKcWxlaWpQ?=
 =?utf-8?B?K2VoUXB4Q20yNHhNWWRJV2hUQ28zQ3RHRE1KTE5QTEQvZWFYdmZFKzRZYi9w?=
 =?utf-8?B?dkl3NWtRcnQyTG5rY1Q2RXdjNFEyM0RmVkpnUnRGTXd4VG1qVnJ5MmFtcUhV?=
 =?utf-8?B?UjlUaVBBNEozaVJOclpvaXpHaFJ0bHh6SURzdFlyZ1JjZkthUGlHMjgyV3lD?=
 =?utf-8?B?R1lPdXNvQzN3NklYSDVRZlpJMjdWV01Ga2dpZVNNdDI0cTV6UE9ma1UxZ2lC?=
 =?utf-8?B?b3IwSXJzek1JOHY4RXNHZUY5Y0Z0YUFTdjFTQXVZMVN1WjhVK0hiQkZ1OFp3?=
 =?utf-8?B?MWg0ZUZYVkQzSWRaUEo1TXlCWWdLZ2FLSDNEQ2hFRUtvSGFQQmNOZDNYN1Bm?=
 =?utf-8?B?V0tSUHhWaDNjeXphNU80NElMeUpsOVh4QTJFbU5PYmNvcG5LNGFuK2E0YTVu?=
 =?utf-8?B?cFcvMmtVVFQzemNYSy9xdWhuUXRCTGxLNzIyTHVONklIMVRDSHExY0JnYVNy?=
 =?utf-8?B?SU1OUXhHYkdZK2FDNVJ0L0pHYllsNnZaT2hsU2NNVnRZY2JqUUVaTWpDbmpR?=
 =?utf-8?B?Z3ZHV1U3Y2pjTXpXaFhnZ2lDbnpjT3BsRmRTandtREpXUkp0U1ZqQUZaeWpL?=
 =?utf-8?B?M1Y1SzE5QmI5SHJ0dEh5NEhyUDAvZkQ3anVxb3NuVUVVR1gvcDV2cjNXakYw?=
 =?utf-8?B?TytKZFRJNmFIOUJDMkZranJHVGo0Mk10aUtUOWRxbXpYQVVFeHovdHFRYlgv?=
 =?utf-8?B?UHc4QThJV2RqUGhSamFaeHErT0hlNVdEenM2L0hZQk5mY2VKejVwUlVTV2px?=
 =?utf-8?B?aElZZ1V5WWt2MnJra1ZaRHlaV2dHQm83b01NbExleVZvMzlvQ0lMYzVrYjQz?=
 =?utf-8?B?TTlOQkJsRk92MWVDVDlUYmgwR21QMHlXb2YyODM5UXdXVkJ6MjRzVkp3ako1?=
 =?utf-8?B?R2RnMnFidGJtbTVOK1lEek5pdWpGM2RETE1zNVdpWWNiM1VtZzlOYzR6MkpH?=
 =?utf-8?B?YU1HYklZK3NCbFg3aTNraEEwV2tycytEcTd3NFNQd0tBWHBKL3Y3V3R2ZkV4?=
 =?utf-8?B?NlRIRzZOWTkwUGVTTC9nOWYvNW1kMjVCS0g2Wjkrb0RaY3pIeC9NY2s5Z1dS?=
 =?utf-8?Q?V41UaY8nNHpUjekTDa4wPMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CC29B130BA51A44AB0D92D5926167EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156067ff-9595-4cc7-9718-08dac74bb71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:55:23.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +re/DSu/ca+usdkKTiiQkwF9HZbsFMFcuMYTBWc95TgkxYrAbNAtqQsjmHDhsB6Ju8cqB4bcJMnTgvauMhVmH2BqrPEfI5Kg9oN+oclnozM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDE1OjI1ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NTFQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+IA0KPiA+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vY2V0LmggICAgICAgIHwg
MjEgKysrKysrKysrKysrKysrDQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyAgICAgICAg
ICAgfCA0NA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gDQo+IFlvdSBz
ZWUgd2hhdCdzIGdvaW5nIHdyb25nIHRoZXJlPyBFcmFkaWNhdGUgdGhlIENFVC4uLg0KDQpZZXAs
IHdpbGwgZG8uIFRoYW5rcy4NCg==
