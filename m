Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A435D31A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 00:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhDLWax (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 18:30:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:9484 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242505AbhDLWau (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Apr 2021 18:30:50 -0400
IronPort-SDR: N6D21jWil7Yr+TvJevWLGYdxgd6/4MSyEEwvlCKjM0RpmZ90NKRF9pa09yK5wIfh+Mu2kXOFR6
 yQBzcCeMrgog==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194321861"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194321861"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 15:30:28 -0700
IronPort-SDR: 2rbDJDW0oEw3ofV9BmXcdOJHvioLhH1jy5K5tYpcC3JjAjJdc/4Bt823mwA8blxgzoRZqRmLId
 GvRG5KSpAdQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="614717573"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2021 15:30:26 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 15:30:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 15:30:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 15:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSVYEYPJXSCzaToH+l9qa9t42FKi0IyzF01u0+N6z73hRKV+zsiBwcZrvQaY0RH1GW4glHuN+mXz8rlx+KcB6Rpk8RsFXiylE8cdLze2e95ymOVEldvF6yEr4iUhvmPX9EF+bc3Z5Qom0ocpVHLAL2wMewWshdZ2itW8WC7bHqCN/rLg+WBXz+VjY/AbStb5OmE3d0uP4SoqOLY0fU7oMCW7Ax89/YkvN/FSMFHNAwQC9yOaUOxIczo6cehUQBlY5vy6ZZ9HmKTs7tTqOgCbeRpJjYE62Ou4CiS3z1f95pw1LC1TPulUszlHRQLSXL9lV1SY3U+B35AKpBJREuFYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKA7N2a4iKfFWv5qWLrG19vcNE+m1oF4+cnvTdt28bM=;
 b=ncVwRoPGyCqcOjGBK16WOJxwrYlx2XOxj5A7qxHWrYRglLs6grPpW3m2TCPTImg5IMiRPUTpVBzmEkgRvindUyvHYmI/6Osy2wHULEw1qVgSYmii6gSSE0qRLr6YWyiiUMqwOE0UpdlWGndStULWHif7xsLi0oUjsZ3hTNFZVltR3vThNYfehtsQTogDGApoLQUEzvoJemAhfVTU5/ENkh5+8PtXqFSVFmdZAfK9a/NTr5TYg4tBQsyvYV7CGkSA8/4N4fl1jcLDzecby1yhkPd8ni44JD/Qlr5mxnqR7HfY9590cna/Qdl6oC3Cp1sOjmW80dClXBx2A+0GAJcoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKA7N2a4iKfFWv5qWLrG19vcNE+m1oF4+cnvTdt28bM=;
 b=rmW6MlBHzq6vBjPwn0Ou2sQlSPfIUdHXQfvXE0rSjOSKH6APTZQ4jxPcX0Be+EYye3/tpsvzau5KqtD1bKpaUL7ANobhObs6mwcbFKtjCdrCEMOrv4cU1bc3+ubpXFwZ5mxj4UiF8l5MntyTD9dljnscIZEpdAine4zYC6RkvEc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 22:30:24 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 22:30:24 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Carlos O'Donell <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXGjGh/SWJiX8oekyfIlNJ9KylvKqVEKUAgAALkICAAKhIgIAAXUOAgBuAt4A=
Date:   Mon, 12 Apr 2021 22:30:23 +0000
Message-ID: <DB68C825-25F9-48F9-AFAD-4F6C7DCA11F8@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
 <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
 <20210326103041.GB25229@zn.tnic>
In-Reply-To: <20210326103041.GB25229@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44fff02e-88ae-4231-3226-08d8fe029093
x-ms-traffictypediagnostic: PH0PR11MB4872:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48725F9B684A1BEFB4DD2208D8709@PH0PR11MB4872.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Lr7IuWKZhGQX7sMo2x3x6WI8wMSfyc3p6rdxhdAFdhP0OJwL4VGpnwk+1wYyXCJCb+UA88W3mnwIucEutY8BZVC2+4IQNCZa7oRlOGrYnenUFaISvHdt5ed5pz05TXbjNvA1X1+xj4sfPcNHLG4X3NAG8AKO6l+mt/ik68fv6NdOt/uoePPWD3jFb/JkZ9qu2/QJIeaIMWslU7S0qZoe5vt7cqhKq2CLARB80aqc5iwBIctr1ZHeI9vKCMKHxg67N1K08KYxuAgyev9xdMJp/kUFW4XnWWlzrfs9JtyWGzX/zBMea2LazUXkjK8CuKzJKvyYsol2fszE46l+tAABj+OoqNxHyIW/sJgeGYmJ8TZQdVAWaK5xuJJXlGWnMW4yQo0LQzfGw2AdrOaE9CXhsEF5GrYUqpntqy0hH/45DqHvs8r7IKUDw5rc1EhY8Lz9uDt/+Lf0SnLcPYyR9xZ+cPka6slCX3Sjff8pBBKrXtpmsMokv1UwYK4i5c8pHyGFHTXcPAg5zpWhZ1cfr3wNyK0nxWy35nrY3GKqB5m2HEpqUTe/2E08ML5yXDgQldrv0+eiJNR5oTAT/057UYfPnmVnhrnZYMTMxjC84X98GbUc+ZrAMh+3cGCxbgLxc4k8ZrIk6Pt61mlQA9zKNQYnsyzA9urkdQ3KhPgmRKruBc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(136003)(346002)(36756003)(66476007)(6512007)(66556008)(64756008)(4326008)(6486002)(2906002)(186003)(2616005)(5660300002)(86362001)(71200400001)(38100700002)(66446008)(4744005)(33656002)(6916009)(8936002)(76116006)(8676002)(316002)(54906003)(53546011)(7416002)(26005)(66946007)(6506007)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/uIL5p9iSn7F3/WMsmaMn7Qr/tOGutrk1cnN6Bfg1S5WAhvdauL4HpgjVQi0?=
 =?us-ascii?Q?oZMzHJxrcO6tKE6z5H06avdofY3MZghZ8DhBG/wrYlnxUH6Ky5eQm2zIZi4A?=
 =?us-ascii?Q?p3P77vudTeQxSYiTnKekS3GmqPQG2wSCEyGnSU6k7zFWkKVgz2/h67v+JS4D?=
 =?us-ascii?Q?GMEwJolHfKQs5M6HOoSrPYTeNR8a084b5O9v/OV/jpq5R07MjQk+8AsD9i9P?=
 =?us-ascii?Q?fXmVQi1ziIKwMi+LPYhI9wLd80WiBvClBw+CZkFbTxTp+UOyy9GG0Jd1YC+e?=
 =?us-ascii?Q?YdYLA9JUlZUTkDc+QlGrRUxZiTbVlt/iO6iOUzLnl2ut3CzfTQc6d1IWl4h5?=
 =?us-ascii?Q?B7ypuD21yzCVYDaphR4ICKRlJv3YnvF+Z10AAOa62jFOul+qWQYNIT2+FFic?=
 =?us-ascii?Q?xJdnvpu3iXsO4fMCBIhN+RLYeB9KfY3XrQ3QBG4ZiO6/EoCDrI/iyYZexj8M?=
 =?us-ascii?Q?SNRGYWT9W/2jtnBZZhKyeosG6PF0tok5OSHWNZ7wtGXtntbkK69BdT3MYQo0?=
 =?us-ascii?Q?B+Fren0RoTdoyumQenFEordP6EXMZCsfuNz0D9pkALwWj7VKC9RCRF4J7kJ5?=
 =?us-ascii?Q?48AHKvqxKdA3OtdWdpHl7M2j4+0/IRASMFkS/stbifmru0W+ldo01dBsDr7n?=
 =?us-ascii?Q?UfSuXgPwke3cKBd09JMEOaILROy620EXvYYAzHPsAYN0rpER9QCki/aJtess?=
 =?us-ascii?Q?Q8sGBTYzKkpXnYhCcSYPlomOjuoZPNMvcmsj/mO06XHb6BSDKHAkqo/b1Xdb?=
 =?us-ascii?Q?s0xM0hNfoF0arcTWB6uv6t5cuO2M4Ykcl4/6Ekh2A9kyqY45iSMi8j3EdeCP?=
 =?us-ascii?Q?PTPG6JnUgiBFZIfxeltt1s5bnba4fXmJ6xOgFCQ9dzUgKaAtT+vxBJnZQ3wx?=
 =?us-ascii?Q?UUteKLYhGJAQHazdOOrl/B6GETuN4wR2tdQ9nRx3g4d06cqs+TvxNE7nojv7?=
 =?us-ascii?Q?ebyjdsNIRoCSpyXoj44+0raIO8SPO4+oMmL8SyQok1BzjwQkXLVNS3mU3cVX?=
 =?us-ascii?Q?1TaO5Ftue9TxyTG0qMnf0WsTCmwPyTaJ8Fswi4/ivnbknM3epAXF0O8xaPjB?=
 =?us-ascii?Q?X7/W+v36z1+xhMlPzOKZapISen4vj9Xu4L7vpHGDpJDFJLvJmYLhohfHolAX?=
 =?us-ascii?Q?ZDjAfzxS/E3Qb6Xkp/3fwAIWejOuVy0mjU878fnLEI9J87bmkOcWuWFPq+bN?=
 =?us-ascii?Q?8YYlIVVLz5oxUVhN4VvAHHjF75aUKszFQHOeCSnvLZBDL9e8n02KZ+oU5NAh?=
 =?us-ascii?Q?AAjX4T0I9NKOZ3AopTvSGKEL84+SxmHgJ6m9L3tPyhfVCKMOoTYdjIZO8mD0?=
 =?us-ascii?Q?MMnA0N2DuyVRgCxtJiFLxuB9?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0386E1260B472B48B679A4DFE8DA25E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fff02e-88ae-4231-3226-08d8fe029093
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 22:30:24.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QCVppgaFrOUJhlrqLIWOK33ZV8yr0VfOF6sqEh6YHMw5IsRSwJ5J4/y/8Ov+M/PCKtlGFBHyt6yIea/wgW1Yn/LP+EbeCZXkRMvYR6OyUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mar 26, 2021, at 03:30, Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Mar 25, 2021 at 09:56:53PM -0700, Andy Lutomirski wrote:
>> We really ought to have a SIGSIGFAIL signal that's sent, double-fault
>> style, when we fail to send a signal.
>=20
> Yeap, we should be able to tell userspace that we couldn't send a
> signal, hohumm.

Hi Boris,

Let me clarify some details as preparing to include this in a revision.

So, IIUC, a number needs to be assigned for this new SIGFAIL. At a glance, =
not
sure which one to pick there in signal.h -- 1-31 fully occupied and the res=
t
for 33 different real-time signals.

Also, perhaps, force_sig(SIGFAIL) here, instead of return -1 -- to die with
SIGSEGV.

Thanks,
Chang

