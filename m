Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AF3146DB
	for <lists+linux-arch@lfdr.de>; Tue,  9 Feb 2021 04:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBIDNR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 22:13:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:8955 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhBIDMv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 22:12:51 -0500
IronPort-SDR: est6+2rRzW7/ftEToPNNJ6MEpXHNZMZQB3RoC0mW6OKne5ymxi/j4OM4C217O3+GhcCAf8RPos
 YasyRsOdzLdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="178310696"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="178310696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 19:12:04 -0800
IronPort-SDR: nzyN4BP/seT6DeNWSuwh0Sgm2MNlH5QkVLlgZpoQlaT+kRQ0zY4c4Rt1ush7Tr46qGlbFLL2FZ
 ih5XTfPd3ieA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="361688887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2021 19:12:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 19:12:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 19:12:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Feb 2021 19:12:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 8 Feb 2021 19:12:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8gAHAzuoXo94PzekPVT0fMqyx2pDLHs2F3CD8Nb5hZCQCj82HVWcsm/BTsnJtTM7i/asdH/P5TfX9RsuTFV0Qw/TEtNbCUNQ3o3V6SfSC+OGGC7bYCogNiW2QnmBx1VoovnTWiw88eMGd7RHSNGTDiSujgcJczspW4Y/loLggNmLZX/Nn3jjUzwHCS4HOxGBdveqPCMl3myJfSy38Kjut1AnuJQfBquHaTGLeMyFDjsD+joGofWKqgAyVXbbraOOUegg0oa5a/Xio2vBBrencIfOtzrehvqTvjDGuwkEqRupdG91hAjdevjBrCgzGeIO3ylOsgpb7bgq3rXgNoapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Q7OwEkRX0BpY+TZ/+8l2GJcc99of3NdyxwYL7rTbo=;
 b=QsGmRz5iIP5YND/m8PsCjlsMTLSJMIgkqQlqmsDeqjHDJxWn59vpEFxnofZA7blCIj3dlRHwBsemkNKX8swHu6Z2sfDHH2d7Q+qCj8qQwPqInEIc5Dr7uRbdLEjMvKXoElKV0BwauhmH7DL0SXXRDpoyox3wYmbNw5RoyDvpqIsF/g6XJz7Ftpc2K5IWzTrWCO1yw0+5MOt9gXkVOt3g+nqohLOzJnnVEGJkzNf6luwyRgkZXaaJ3txdiCuKOEnBLGmG63B2rU5Tb7z72FJKxCMv03/kCYLBQ2+UHbzo+ZoNHJT2HSx7QvDkXPAlQA1HzEzrllLkCkSpc8vLvU1Xag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Q7OwEkRX0BpY+TZ/+8l2GJcc99of3NdyxwYL7rTbo=;
 b=X6li1B/YEc/QJv7xftTirA/5g0yvmEWeuUjpPnCO+4T+CpjW8nBMC/77WiIEuqhpYgjHW2MWyLu0aGsE24f3PkyoqEbkaPxfuDvPjC+KYmBbe21Rgr5cf3c15neD2omxAR6Zc6DPDZ/pOoaQPapxGJOCMXSlHIzzXkGPXuq6o90=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 03:11:57 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 03:11:57 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
CC:     lkp <lkp@intel.com>, Jann Horn <jannh@google.com>,
        "Brown, Len" <len.brown@intel.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [x86/signal]  dc8df6e85d: kernel-selftests.sigaltstack.sas.fail
Thread-Topic: [x86/signal]  dc8df6e85d: kernel-selftests.sigaltstack.sas.fail
Thread-Index: AQHW/owyRCwKddBWB02TNKMvt4NmOapPJYwA
Date:   Tue, 9 Feb 2021 03:11:57 +0000
Message-ID: <9C40F926-C765-4897-9F9D-A2460D03FB2B@intel.com>
References: <20210209025021.GA13872@xsang-OptiPlex-9020>
In-Reply-To: <20210209025021.GA13872@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b04996b-cfc2-4893-7887-08d8cca87593
x-ms-traffictypediagnostic: PH0PR11MB4853:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4853261C713B7C44C7ED711AD88E9@PH0PR11MB4853.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KqhtMejH3P9q2DQutOSqAS4W2Y3V7L80zuNAwdKjf1LXMIqEsYvcI8BiCIM2aod3eclxnK8UwP3lH9GD/plaYtDEzPm1EOW+BGcoUGAIywOCT3T/oLepiFSO3z18X40EyhFjtUup8Uq0zhnfzt+Uaxvk+XdBXDNkjGekWHmKshjdNdRLaX5GhfyXz4w1bmV7y5Y7MDeyMXDj68e+hM3MgmHa/w8fhdxMhk4/xUswcgZHLbt9ko/hGwEYZOtyu7bQrIAlBAq64kXRGKd5rUEm0j8ytWp8eUxrUwjGXMHfoG+s1HzZCI69evQAt9nZqzT+nkAfDSRqnkfEwRWWzwI7bqx53KlGLIu51UCeyszmHEUR77uh06ezz5LTmP9E/24BRI6/d2gZf6/URApovgDeLKEHnspw5Z+Mkj5W3gZzaNnwokCnHINSMPoz9417f1+uqaQvgViynWtZeDzJemgh4GdcOwQlKkyZkeVUVg0DhQHe9NzlKGD6ecGBY9kMAHF9V/qm+xE1/YCGQx7lhRrOAqkmgICebQ+OY9/onZ/euPy+3RyyJNJPHVNaX042TmcD3+K/8031iAtsaBH3sHZ4Ul+1c0BvVACDYQpQLgYJw3lku3JGlqQAUMw+nFWW0BbevoLonwm/GF+bzFPugZn7kUWertd5HDdEHKX1L5YLnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(346002)(366004)(4326008)(64756008)(6506007)(2906002)(478600001)(71200400001)(966005)(66446008)(86362001)(66556008)(33656002)(26005)(8936002)(36756003)(186003)(66946007)(66476007)(316002)(54906003)(5660300002)(6486002)(37006003)(558084003)(8676002)(6862004)(6636002)(2616005)(7416002)(76116006)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pahwg4A35drlELAsC38ZVMEUBgpIP/TMr61jyyt5CPyuhvN1x17hSGgZ9vz+?=
 =?us-ascii?Q?oQd+uJMEXEN1W/ei1mN0cznBmI6r5Vmevjxjng0jVYECjPYqiF1jbDL+dyvX?=
 =?us-ascii?Q?1tL2Lq6uhvXD2z/vv1qb+pSXVU+RXXV2RgiLYbUOMvnqhAsBsMSVIadHlFAv?=
 =?us-ascii?Q?rrH9LPdXI8m1iXSGsEiHyiLkw7a86oskM6scAhh+Ic55gk0ZkbLovrHg9Asj?=
 =?us-ascii?Q?JnE7yZDW1opsHa18nc7sd78dXXZkzbXeyCJxZeUZDuKasMkal8AJ5+hxEb2V?=
 =?us-ascii?Q?wuV4P/MRaYJ0MLYTzXi3afREQKItPl7su+n9Z0O5sIe2PMYUEc+8AMUYYeH/?=
 =?us-ascii?Q?iSIf2b0erJT2FoiDskJWbiEcoLDB21U3kKdb6u+ufsqrFNJ3xSbfeYMW5yvb?=
 =?us-ascii?Q?dC+G+nTT69CfhPbKrQhGllbuiMvqrpAiztkNhKkQNBQ8rw0YgRkZ0eAX7xKG?=
 =?us-ascii?Q?pmxxM6PwEDok3DWhXy8IDzbEcTe6XcUsYOZRrYIw8Xse2d2uDYzoMck3iJoW?=
 =?us-ascii?Q?JP5XuKX9K5cuS6sRnYQw16jmzB3/8i7Ksrzgztx7gOJcUA87oLjzN93pUSEC?=
 =?us-ascii?Q?JlGwInDaNGIFwaTQogxoa6kixjnr1Kl/yow7AAR35pb8JB4VWY9LpPIeesrq?=
 =?us-ascii?Q?Axsu8s1x1GhckxlKBOm4TfZirMNVQpObUsaHl7h6WqAPotGD1rpQznwjStUO?=
 =?us-ascii?Q?gPE2lC6HPxpawy9XXzwXisacfoLxeYvOnwbKDw9cob7i8v/IIaOHWSTO4l4t?=
 =?us-ascii?Q?xwMFvJRDn231lsoKsR+GP52lQaycs9Nz2LV75Rrpctuf8lW9plNJPTvkV04R?=
 =?us-ascii?Q?wo+Fch/RWnI/a5xVohlDmDq6e4CWrPYXcGGOtwg7v0NEA7hhYhmBs7E9b/Cs?=
 =?us-ascii?Q?USL5RsUPvucFgSMOnRavsJW6/AzGMgROJdsn3RFWevpSwA9MQyaz77ADznTu?=
 =?us-ascii?Q?c3l0ATzDBA7FzzeqHPhvGPfvPjs597/yHidHhUCEmYuNB5TBguJXS0y0IsII?=
 =?us-ascii?Q?qe7BIAi2WnqtIBKi/ndJ98BG19bqj/P0bwdB8VexKCyQhXLfx1GiWDyiFaBE?=
 =?us-ascii?Q?ONIsL/D1dV9J5rG3W3LbhJmtY+PDtzQX7kjNLoK1bmuQFvCj+Fni0j3gRfhJ?=
 =?us-ascii?Q?1nEYnKqW1le2WkCUkAg3A2+dCgssVBo+KwJnSMAdP3QGzRtWhDvLBivsZkXG?=
 =?us-ascii?Q?7EPOqlmmyt4r7DzUSfoFtdF+Ac4Ew1F7Kxd2eNHIqUTlk2NYjuowFWez8sFm?=
 =?us-ascii?Q?EQAtirmoLUhBEdWcLAY3MCm8tn/2wxMGVFrADMLanzznrs/69pQdF9IaP79c?=
 =?us-ascii?Q?tjdObO+a1rAmMCyYh2yO7DA9?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9353580218DFAC49BE9A071511A9D0B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b04996b-cfc2-4893-7887-08d8cca87593
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 03:11:57.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rydvVwNd9fepszVI8RNp5J5ZcxRdVjO8flqSPS4HZyzD5KuJ0/ztCG6jPPEVQiEEgVZ6R8CuBLZtD7ogNFh1j2j8Pv9qJge+s7U5Ylk6FUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is related to the SS_AUTODISARM flag [1]:

I will include the fix in v6.

Thanks,
Chang

https://lore.kernel.org/lkml/81DF502F-9327-4365-AD17-21CFAE94ED0B@intel.com=
/
