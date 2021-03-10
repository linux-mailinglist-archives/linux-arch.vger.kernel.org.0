Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E68334636
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 19:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhCJSCA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 13:02:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:54172 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhCJSBp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 13:01:45 -0500
IronPort-SDR: wm2XxZrLO59P2sYIiUfj4EhNNHbrLLfAqvZQBEV887U5sbBQQsmINh3LP7RU9zOSQaGIxD0ZKS
 hMlnAN4yZX4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175631964"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="175631964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 10:01:44 -0800
IronPort-SDR: L7wS6697ZOjTvH+z3GzA/JBZ6tzx9PJ3xNqJWz7ncrdEZP5DadxFAzqOFIgxsGpOtA1lJuV/8g
 4LNWGMIxfBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="588920601"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 10:01:44 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 10:01:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Mar 2021 10:01:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Mar 2021 10:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHvDvBC83uFqtW6HO8OZyJnvq5M3BWBbzzR/v6rlTeCEpeXeE9ZH8GCXF+zADEw40+6b4L6YWDY0LEq8A/Bgc2zufVBQsh2dqpvpvovqDmBuXvgbNVqEN0QKDZUJqbHXqeXTsQiVVk02UIt+9NySklQqJ55QAeKE+NgIq+ild7MGe5N0Sg9/KyY8Eiy0lorXRTPLEMfHmrFPa3W/sgp6D58+djOPTRhCZKiwByNcIJzGNDBDy26SuRlPATQtebcHYXm4QK07E8z53qVq23u6S2dL1BiEUGuGvsYhoLIjberdUK5smNCy8i5yNGOoSXhpbSoiGdmiphJIjhzTmM8Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8HSfDnrmzvbXQGsofEp9xpTOCq5HnRKeDvgn6vkmGU=;
 b=jgxdVaYCef7BzCmQLFxPtQiIqLeBbZsREhY0E/P/nYLEICP1oyyju1QcILWrjfmWqfpGZ64wan7uYRlS7WYGJ1JpJ3UOc58oYclcFJle2muzT6e7fFkKnGbguhu7RGeqkAGGDTPbRlDnYsvyl/AEAwUoXdwbDhcEymH/l/whgQV6yX65owTRdihsBb8xJLpFQPjEsy+hkeAhhkb4Con0RWBmdJUlTQTvschYnZ1Vrr3GHhXTyA+dXFKtJzhlqoIhcZPHLP8X2W6ZX07EJCC0IbY9urNxaB4Hkbd5nM0lFhRTK6EO2/1MntbwWN7GARHTU0DdwcrZey8ziSiIyzxP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8HSfDnrmzvbXQGsofEp9xpTOCq5HnRKeDvgn6vkmGU=;
 b=ztacy2T9VHBbx+WjPDGmk4V+DL6FQ6M6WGAAAWrZWsJytgmDQ4xbMyf6WrHgVtA7/4SQaujRzTD218qaAnP5Y7bHBFdnpIMlPcqJ2fbKjhRqwa34yB5K6xyQQsVe1FT09tTnhWe7actBVrCrpeklbdVCrfUKlcLOv8Re/ZQXlo8=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 18:01:42 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 18:01:42 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Thread-Topic: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Thread-Index: AQHXDSqN2pJXnno8/EOtP238eFt3R6p1PmiAgAg9ywCAABMkAIAABSyA
Date:   Wed, 10 Mar 2021 18:01:41 +0000
Message-ID: <720ED24E-2BF9-46F1-84E1-788CDA4E7BD4@intel.com>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
 <20210227165911.32757-4-chang.seok.bae@intel.com>
 <20210305104325.GA2896@zn.tnic>
 <F637CCE0-1744-478C-B2ED-65EA14B07938@intel.com>
 <20210310174310.GB25403@zn.tnic>
In-Reply-To: <20210310174310.GB25403@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4702163-fbb6-4a29-d574-08d8e3ee8f9b
x-ms-traffictypediagnostic: PH0PR11MB4968:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4968444ADE3B1338F908879BD8919@PH0PR11MB4968.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdmkiTkxrVYzwftZs/Pdhh4EwEZubLeP+2rIJKcw1hj9MSSwJaAYIrDnCd0eIe0Z1NHmFMG6sl3cOoADnhJ9381zHGKxkuEaCu/ZOsh103PUSxC5oDpH76CKAcwT0AXJWJsO3C59oAb0QmoRwqG3I7FVuriqGF5necKymDe1OlhnQCDiwZUPeljdHs5mNYmtIMQm2riDkdndXwMqBoZrGoda6HJW8DIqxXqo4GUNi5jIZcqgMqq93P+F1sxBe7t7N+clV3pJwQ9bP8EXIbJV/oQ07RWD4jJlP0pASWvJ45G071aJ7oW0Ju6iiG6RokxHIcMBdhmvc43ca92fDWhrcMo2A0wEnZJD1Fzm9VpaCEdXy/xT+hIGDJzAeb2uQwQP78IsYGhlE9BDBDQFPo5S5CxToWyOGKcpqGwXMqFnWnC7PwBmNoNS4dzJRH+/4AYYxtbQ1nGIp4Y9qcmZIndIn8x7nW9+LG7hG5ICvOSiSVzS93OuLIef8WTwiSzflmrXum6Pl3Km6n8ixSS9F8ohMMFMrdtsPYemfept3+bf4tAR/buRIHPDS2XM686sWTG8PkCj6VDrfP7ufH89V6NiAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(396003)(136003)(36756003)(6512007)(86362001)(54906003)(4326008)(76116006)(316002)(6506007)(66446008)(6486002)(8676002)(5660300002)(186003)(7416002)(6916009)(8936002)(478600001)(71200400001)(53546011)(2906002)(2616005)(66556008)(4744005)(33656002)(66946007)(26005)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ds+eJkzUmNikdfYS43cJVlMYkX5ZdYjTZvlFfxIOs22n/NtAJ9VgwhNb40Rj?=
 =?us-ascii?Q?KNF06PmEOxECE4q7OIAlrThP/1Egf74cHGHDW1Sbyp05PhftdHACFG+pN9W8?=
 =?us-ascii?Q?gH7VzGw5yYkSI0G5TMr1SFat/ROce7Qekyv3fC+k8wHYWT/UxbmF6Fo8ySG1?=
 =?us-ascii?Q?V+RqAZ4X5iULJZIeZkkvCJ/1pIBd4qhZT25isw5W0NqkhsDskbSZRQaxxNfg?=
 =?us-ascii?Q?Ye0faiC0itB/iI4XrB+M1TNxwMiuLjGE7MDBaff7ApaLkKzTVaKOai9xRy+N?=
 =?us-ascii?Q?o4MoaY1YJhUJsT9snZ+Ty2NAnh8sDlAdRbRWG86gisu68WRey4LJb2xJsxGe?=
 =?us-ascii?Q?WHii9hs7V6ssbpPghCK+z4fdFc6Tpz62zdadjMVASVYc9j4Ke/QgLdkL1BHD?=
 =?us-ascii?Q?f3QW0mnTcS/yzqv7MMJ6IZqlOweISzfWPHi13jkXV1Fr9uP+0nJF3oTAFOXh?=
 =?us-ascii?Q?+wiHKQoR6JgwBJJJExcDr9q1k8yCGAofLibbla5v4o7cueWHcLko/dZ3vjrk?=
 =?us-ascii?Q?aKL7/tQT8tka/K47LxeBZKs0UzcOhWUSEpdh9QgN8dTICMJZ3NEERYbEck+q?=
 =?us-ascii?Q?9V4HujiSNu4B1T68w3aqdR/JQ6UTqfyuVAMBNCUiqFe2w3xJgSEHmeagbq7w?=
 =?us-ascii?Q?S0x+xnkoJF/nV9G2sXHkxsTa4mRLvQ4CbeidcoK7J2Z8c0L/xoCNwCe7gK3h?=
 =?us-ascii?Q?nfT+bOgkPXz0MlMDrvFiYcTACN79AYmV5GaSxIG2cFOC+d37Cpqmr3PCx0eb?=
 =?us-ascii?Q?kVsyTe9oH9AYb4KB5do6hva4xtoeQ8hZngbr1N5R/Y3L2R8cg309YDnKzEEv?=
 =?us-ascii?Q?DJzmT23cHVe0jNjw6o2nQH5IjG4GnmjrXBbbQ+g7qM+DGAX+Egwslo0JOTjo?=
 =?us-ascii?Q?W0Q4z1NgXdOiheMp3W9RvE1vdp4EKl0bVcL3KdwIcS/wiFRbcqEjby+xG5QX?=
 =?us-ascii?Q?i8oVzBP+UU0guAk+P6Y987Gm7MfmHgX8dARjP1T1pBiybLiMEqy+R+yJHV1u?=
 =?us-ascii?Q?ygd4LEl0fIDplnBU+703JHqYQSX8oQcC11lrSyzRPviz0I2LZ5/8stuTstnU?=
 =?us-ascii?Q?qJxFkGOd77wRw/b6Z/xCvhGHqhAv7CCtBw5Nht99RpHlHmO287/bzzDELZHy?=
 =?us-ascii?Q?QJZwoHReglpHkaoCOccHm4yPcuEolApQXT2H8zAx/0IEyi7V97whHqixDoCv?=
 =?us-ascii?Q?KmT1dw2teOEnm7D1v/E7uol9cM7voiqs4JQkDlWiQr7Uu8r3Z4r+qY0BGARA?=
 =?us-ascii?Q?+iuJM3EfVTI92mjCpTzGNDQIES7B0fi9DqGRgIGwrBkcSVV5LISMo1z19yOF?=
 =?us-ascii?Q?L6Q1KiEZ+tLPMz7Jkt2C3Cgc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AAE777E87910D47AE6A0F7D455D62F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4702163-fbb6-4a29-d574-08d8e3ee8f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 18:01:41.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2BQaEbAk6tYQuvGS4WckSB8MgKVfx+qSBZFjdFDdg5jbw1LQhKpvdYReCi08LvZzq9KwvUwlPBF6DjPbK/U5Pw5qck8zkhZg9dW71ckAic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mar 10, 2021, at 09:43, Borislav Petkov <bp@suse.de> wrote:
>=20
> No, build the docs by doing
>=20
> make htmldocs
>=20
> and look at the result.
>=20
> Btw, you should always look at the result before sending it out.

Ah, now I get that. Sorry for my ignorance. I will fix and make sure not
missing this check.

Thanks,
Chang
