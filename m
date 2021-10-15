Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E789342E730
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 05:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhJODZe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 23:25:34 -0400
Received: from mail-oln040093003010.outbound.protection.outlook.com ([40.93.3.10]:20990
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233893AbhJODZd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 23:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqEyxudXYUZApGzmQo8nt5hPWf/oyP5V0pdLq2dQaNu1c2lXLBVqOr2vwAdw0eXOHAxzJC3IAo5QDrFXb2X+nJ1NpQJnzNeNn8a3tmBILj3zqHK4sPLPYpN6i+jhoRyPJllBes1sPIGGkuxQFRIC2BoNXPukJteBepmQT833NSIjcx+idmPTUMcL43AMHIk4s2/aT0vsTGYJ0oISrcQ7rXxKnUJ38ahA3wv6+bqak3E9PyjTrHFtGiwIUeNT8cZTszpU6zlv0zAKvUiE32un6WdM49VyGA5EhP33DTwsn68GEqN5gj9KmKtDqVBIA82Fr46ytw6wSApq+xo5isnOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7nut9HyzwIoHdElj+7Jt5Wc3F6zk5BqWBSKJnGaJc0=;
 b=NBBgLQK9DJJ4G2UnC4YZFCHfsvJ3pWBAcq5YeJLB2l4NLj9jmDuAKJNWXbCWHNgpbYF1KSMu7AMti4nV3elveF2VU2KqT0Jj0LPCfinF9H0wks/gSM9XP0DlyVy561ZXP46ij5REuFh7usyZfEUGaO2IDlQm5jSRqgEQJgAn9j5BJJ0CqKj7UiBzDEeDCV3V31mWpHaJMKO195xn3DJNmAbaicyxu2mYSNHXz1g+lBOYMD+wN7WkBc0EiMXoS+rK0SIExNFfT8ZdfcoyNJLyDgDSCjsDfMtZnkCKEn4XsCDU1XbbmzYWMnEB6gqgdnLldBmpQH5C6fbvwM6SzEQtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7nut9HyzwIoHdElj+7Jt5Wc3F6zk5BqWBSKJnGaJc0=;
 b=HJmiFVnsMAeAcpn/aZ44GVjIRMJgLAld/7s+FdLtC3g/0kaFsSSJltWln+UWbMt0oVo1J9gNaLdPF3cRefjOeMTNXz/8heFCapjteL7NhMMUWemiTW33EnKw8DN10T9X2cD3awYD25kGNcCEzWwKhOG5Enr1RPrKQI8dNcS98Fc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1770.namprd21.prod.outlook.com (2603:10b6:302:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.5; Fri, 15 Oct
 2021 03:23:21 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::69df:9264:65fa:5415]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::69df:9264:65fa:5415%6]) with mapi id 15.20.4628.010; Fri, 15 Oct 2021
 03:23:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [PATCH v3 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Topic: [PATCH v3 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Index: AQHXwRPFtsmvzYjWyU60QghbJrqU5KvTX2Uw
Date:   Fri, 15 Oct 2021 03:23:21 +0000
Message-ID: <MWHPR21MB1593DB0B2A35C3C6759E24DDD7B99@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8e169db-070b-44af-a0a4-022ffc2e7eec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-15T03:00:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d680a608-f265-458b-670e-08d98f8b23ec
x-ms-traffictypediagnostic: MW2PR2101MB1770:
x-microsoft-antispam-prvs: <MW2PR2101MB177087BEEB13F382AE930973D7B99@MW2PR2101MB1770.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdwMs282I6+Z9S+4NRdQNJ3a6oafSkqP+CDVdzbUH3QYhweIZqrrKb12DP2Si0LWS5mF6JN0+cZG5eoZMRwfZDnSHMKGVN14CrFmD9DnR2SRV76PM+6mE7XDfJ+ELJ5jniNDVCDBRT2QvZgHCB50ls/wN7jYF+tSZH9HyelpABJyUWMtfDQ5FpCAWUl1EhkV250g2cZLfniUyBktDMnOyioaqxKPcvUvavFa1V5LSLG0IjQlCSdspRRNGVfju2lxH7dFQHu1Bzrnt3yES6CUKa83hgASzX23seaVbJvws1nWHHcD1pQVO74I/19LjEBXQB6d/NVziTGlO0awAHEDklxg2oGJDsAwWurXPbShnVqx9mZuAEgtKbUrY8/pvY6LyjveRa3qpFX+0UENP19gMFHhA9qsLE3eXQXPgN0FClDpccZiqtliWj9RYrcH1jTFyWWKp/d/XEj9GGf7iS9OD8930A/a1+w4fjqh3RZN6Q3+TKJb0Uit77o04MzcUMOrVdZtaYXP6SKumfgmntjsRCCHwfMgKuL0TqVJFgeQ8IgLGbXxzcR0WDNj7CFWz4NiNzS7IWKjHlVbWw+Ly0jLzyydLiAfuRobkLfTPSndsIM/lzOUsqIGiNxF+sU2ZfNnVY31M2mFmlQy9c3uMvU85lgiKHkaTE/sdFbor0uTVOo3f1dLLrsPI1RKWpWUB7rrQimqBKYxoksJiOFY9Egs0SAZmQFrD8o26odVa4iTcG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(921005)(86362001)(26005)(4326008)(55016002)(52536014)(9686003)(508600001)(7416002)(83380400001)(33656002)(5660300002)(8936002)(122000001)(38100700002)(6506007)(71200400001)(76116006)(82950400001)(10290500003)(107886003)(54906003)(110136005)(8676002)(8990500004)(66556008)(66446008)(7696005)(82960400001)(2906002)(38070700005)(66476007)(66946007)(316002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eQ27Vvq+s5SmKspaDtaQs2EPwclas1MQbNzCKX7hJZBf3JZC/1u7lkXccGx7?=
 =?us-ascii?Q?2t2wa0hF+IAVN8vbrv4H58pTBa8eRspFig4uh1Zep0bu8FUkBGuob/s0KoKW?=
 =?us-ascii?Q?y2gmRsgpMfR16IGEiqySxuni+AlYI6ShMQzqwgSXPB9rFdQDcYgIO0QTEMko?=
 =?us-ascii?Q?+zX199gLthpsE9ewU4kAGs0+mgdpTD+hXCMe6IUZL955j0N/7K8eZNX6+wJl?=
 =?us-ascii?Q?8fJ7O+1gKohBLWkhMqkgUk34TPVwI8qjTqgSVwHJV5guhGERb9LhC/NNnYho?=
 =?us-ascii?Q?yEPTjnAEYi7jF/1oTAcJ08ROt6EwBfGTImcD4P5ZtXvkeQ753cprrmWAlWe2?=
 =?us-ascii?Q?LNBf1QMI/eA/mtSZLRqU3TUMRPhKITA0h5BqP3Tl8pPOuVwV6+anJjGC2K/4?=
 =?us-ascii?Q?gDQWiSgnR7qcSBUgjHsI1MjIH46xlPETOJA5297yCVbEKSYrqHSY05Zq08/M?=
 =?us-ascii?Q?Nz4PfCmxCk1KRWKR20ylpgWSTAX2HQsrf7QE1gKFsDG17WEjsccI7nPoOwa+?=
 =?us-ascii?Q?gFFFNP9fk6g85gJFFAhXeFLElmFh6xbSMNt6lyi0Drd0f88ioOaqGbACNPVj?=
 =?us-ascii?Q?OZXGrM4FfcVPAIfLPv6XgXTisGutDDb2b2qxxNT3LB5rEAVhrwgTFcO4zEj3?=
 =?us-ascii?Q?UoyGcR6f+opC5BegAxmUdsWOLz98NmIOLStSY/H0cD01+wWsTLHMFjc8CAXp?=
 =?us-ascii?Q?nYCZonosfVlXqJZNykD490Wt/m2oj7UoN5QMNDtCVxhoWWcwThgBR3Ts6aYl?=
 =?us-ascii?Q?jFhInteVNiAHLYf6vymY3BIVhe4vA1PiSWUAcOiX7aYpHML9OZjYMiEvYsN1?=
 =?us-ascii?Q?MNXg3ojtAcj+CxAVFnmTHmMkGFgLx6YInNMbbiT3VHbqK17rjq+rEEJ7ejLj?=
 =?us-ascii?Q?x5qpZxJpBRm8fOtUtb+jtCWTXGEs4tuUf4kp96S/dCALs1UZFnJkEntHEnMi?=
 =?us-ascii?Q?oc4s5aaHM+xCxoGfxZoRAhh4YA9npzSnjbsabGbwKmZZjsXOJqwlfgoixHho?=
 =?us-ascii?Q?lcKDTOKRdYhac/g2uBS3WpBwpBHw7PB25RbUxsMiViGElIPzQsw+iaswm7bV?=
 =?us-ascii?Q?TkkW4dVwM6AlAwX03rQj1VcejJ06A0iFw9+qfmbQ6O5PPlEbLPwDHrHntGNl?=
 =?us-ascii?Q?/yerQd3U0V1qvjgzrt2xeYwRMb9LkJVGKBclrtNM8VBX+7MdlI+Dc1xZMcDr?=
 =?us-ascii?Q?4hRB4BConUAd0uWDwX0c4WdANWf6fNb+Nk6pqQEPtivJF4MO5Bqmt76zkxQg?=
 =?us-ascii?Q?IBXefqV8QgIagcQhtPHKYt54iSPUK7RRyMy6EPXH3IAQp612eKP8XPckOH3G?=
 =?us-ascii?Q?34W51dEfmqUjPHyOdyIdlY6QIs/XQokiuEMuFc/adyCvqCEsl5+UO4wATJ/E?=
 =?us-ascii?Q?fZcr4KKbsemNMae3aFVNvbNLh9Vc2g+J31yolnUjRNDsP4JotlwBRobx2BQs?=
 =?us-ascii?Q?rjqOvLhgqFHRfdk6Y4/ElbzONnKqT+45Fu4NQPHrjGOOWSTFGg+PBrDPIa4N?=
 =?us-ascii?Q?PzJFztJhsL6SDS2hnEZWUp2rjTse2UquD8xG4TYQirOc8wqiqxm/dDBLXhUg?=
 =?us-ascii?Q?ezFaUBm+d6uzep0GRTEx6kYFXwIe6PrA/mjE6aVPlJQpAX9ZpxkeYOTgW7tr?=
 =?us-ascii?Q?f9kI40fxSg6rfHAjkYIcaISDD8xnlEfG1KvLJqYPJyHnL6VuiZc1oBsCT/ym?=
 =?us-ascii?Q?a+Sm1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d680a608-f265-458b-670e-08d98f8b23ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 03:23:21.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3mgD9CC9d/psEDLhknmvg65jWXAFamuUSq89LjBpRGXVQXnfFZN+I0RWqR0+5T+eDWBkFq6CQ6pDfgGX+eueOaM1jlqQ/vLOBWNoZC5R+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1770
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Thursday, Octob=
er 14, 2021 8:53 AM
>=20
> Current Hyper-V vPCI code only compiles and works for x64. There are some
> hardcoded assumptions about the architectural IRQ chip and other arch
> defines.
>=20
> Add support for Hyper-V vPCI for ARM64 by first breaking the current hard
> coded dependency using a set of new interfaces and implementing those for
> X64 first. That is in the first patch. The second patch adds support for
> Hyper-V vPCI for ARM64 by implementing the above mentioned interfaces. Th=
at
> is done by introducing a Hyper-V vPCI specific MSI IRQ domain & chip for
> allocating SPI vectors.
>=20
> changes in v1 -> v2:
>  - Moved the irqchip implementation to drivers/pci as suggested
>    by Marc Zyngier
>  - Addressed Multi-MSI handling issues identified by Marc Zyngier
>  - Addressed lock/synchronization primitive as suggested by Marc
>    Zyngier
>  - Addressed other code feedback from Marc Zyngier
>=20
> changes in v2 -> v3:
>  - Addressed comments from Bjorn Helgaas about patch formatting and
>    verbiage
>  - Using 'git send-email' to ensure that the patch series is correctly
>    threaded. Feedback by Bjorn Helgaas
>  - Fixed Hyper-V vPCI build break for module build, reported by Boqun Fen=
g
>=20
> Sunil Muthuswamy (2):
>   PCI: hv: Make the code arch neutral by adding arch specific interfaces
>   arm64: PCI: hv: Add support for Hyper-V vPCI
>=20
>  MAINTAINERS                                 |   2 +
>  arch/arm64/include/asm/hyperv-tlfs.h        |   9 +
>  arch/x86/include/asm/hyperv-tlfs.h          |  33 +++
>  arch/x86/include/asm/mshyperv.h             |   7 -
>  drivers/pci/Kconfig                         |   2 +-
>  drivers/pci/controller/Kconfig              |   2 +-
>  drivers/pci/controller/Makefile             |   2 +-
>  drivers/pci/controller/pci-hyperv-irqchip.c | 267 ++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv-irqchip.h |  20 ++
>  drivers/pci/controller/pci-hyperv.c         |  58 +++--
>  include/asm-generic/hyperv-tlfs.h           |  33 ---
>  11 files changed, 373 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
>  create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h
>=20
>=20
> base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
> --
> 2.25.1

At a micro-level, I've reviewed the patch set and could give my
Reviewed-By, though someone more expert on IRQ domains
than I am should definitely review as well.

But I've been thinking about the macro-level organization of
the code, and the handling of the x86 and ARM64 differences.
Short of creating two new .c files, one x86 specific and one
ARM64 specific (which seems like overkill), there's no getting
away from a few #ifdef's, and indeed pci-hyperv.c already
has a couple.  The problem space is just messy.

So if that's the case, then I'm not seeing much value in having
the code in pci-hyperv-irqchip.c broken out into a separate
source code file.  I did some playing around with organizing
the new functionality into the existing pci-hyperv.c with the
needed #ifdef's, and it seems a bit cleaner to me.   The new
.h file is also eliminated, and there are other small simplifications
that can be made by having everything in pci-hyperv.c.   With
this reorg, there are 50+ fewer lines added (though some of
the savings is admittedly just source code file headers).   I
can send you a .diff of the reorg'ed code if you want it.

Also, a good bit of the code under #ifdef ARM64 will compile
just fine on x86, though it wouldn't be used.  It's actually the
ARM64 side that more naturally fits the Linux IRQ domain model,
with the x86 side being the special case because of the quirks of
the x86 interrupt architecture.  When thinking about the code
from that standpoint, it's another reason to put the code all
into pci-hyperv.c.

The best overall structure to use is a judgment call because
there are tradeoffs for any of the choices.  There's no clear
"right" answer.  As such, my preference to combine all the
code into pci-hyperv.c is just a suggestion.  I won't try to hold
up accepting the code if you decide you want to keep the
current structure with separate pci-hyperv-irqchip.[ch] files.

Michael
