Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD93255E7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 19:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhBYS4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 13:56:54 -0500
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:4320
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229522AbhBYS4t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Feb 2021 13:56:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3HlWzqGIKoNqdHEHUz2dvBnmiZDFLLIeRUVe7i57xLQMHK2kUqtiNkTdb6mXTMQg5NeDnC2qxe85B0n0/25fc8dYxkPSxL+J1ca8HRsAzkpjsixu16r+TxjZuDshee/uEV7qokgJAfFsgTXT7vfi47gYWWv3IkUup/U/1Ftnnm0H+uKGKzz0z1gtjelj11YBUqgVQQST8iwJwHfzZZL5RHCU60RMeFIfXoLRFu0kpyuGb/ihWrNI5gRg4X1KCH/YeLzWNb0ZyJeIhdrYhLbHmZbbzsE4mq4uqDHFGNPQ5nwGinJRdJMmyg+Htf6cEkbAIiwri1EGTky2ZnClEdTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CWGhs3P0nfSTyUl+wDYtLk5E31UeWKghTxwTmbPHSA=;
 b=V50uqysOk6lISlHx8NOjiHmP4fbt6p3NNQ8cKX4PiJSINvGfIkI0eFsqbC5iTmwuHFV2Gvq59dihAKoGH1nR/zVSwQY2Ql/XKOteHorOJtJw3uxjinRcy1HKnOH2GAOvHHIz+z222qDEbV1s3x4PGvyYxzrOtMvzTGxrEDgSH6r77M8Vo/Se7tVp/y85wIKnsPLQVlF4KJzMA2Tnij2CmxeOjUNECytCwQFZjvBffUORawmwaJHSHF+fyEgDZ9+uA5N6BlsTLkHsU39VrH4X99XQXAPOSAwu8pStwi/bVUZuEPCQ+TcKpL1mhCRt9oZXq+OYUG3WyFauCGbzaq4Y4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CWGhs3P0nfSTyUl+wDYtLk5E31UeWKghTxwTmbPHSA=;
 b=WygWkoRgRMyzvfM9q1qCUcEAzb1uJVt8/N3NT+shYiteiDgwHmRAlyBzPrP27mNlrf0TN88xhDkym8vDMkhPVcAGl7cfUzX39vHZqYAsJXUBrVosj62kG6LeCQGLkhc3AYCZywr4ZUptb4j92PlX6bFuzXRoO/uKGGug3+trLao=
Received: from (2603:10b6:910:90::10) by
 CY4PR21MB0758.namprd21.prod.outlook.com (2603:10b6:903:b8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.1; Thu, 25 Feb 2021 18:56:00 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3937:fced:99af:ea01]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3937:fced:99af:ea01%5]) with mapi id 15.20.3912.011; Thu, 25 Feb 2021
 18:56:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Thread-Topic: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Thread-Index: AQHW9Ops9ZR2U7oM7UKPy+5kj6GCqKpldZYAgAPvzjA=
Date:   Thu, 25 Feb 2021 18:56:00 +0000
Message-ID: <CY4PR21MB15860DF0600EDE5A5F199B63D79E9@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
 <YDSk7scPgUZdwyMd@boqun-archlinux>
In-Reply-To: <YDSk7scPgUZdwyMd@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-25T18:55:58Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b56053f1-3264-41a5-b616-8e17d0c3ab46;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a5cb27c-1f1f-47cf-b553-08d8d9befe65
x-ms-traffictypediagnostic: CY4PR21MB0758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB07589A891C147511584919ADD79E9@CY4PR21MB0758.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vSVZVhJR2i/gFAbp8SR8jGWBMP9TfdYzPSzg9JKT+3SJBGfdfaRm7LUUNVLHoHs82Gd9sSNJ0UFFlwOoszaUOifh7Aac+uXVa7uweyAmVZqihAMkDp/9w6DJhAJAUbbIseMltnzrzA+ckkgVOHHebb/8q379M8feiNPVzDCphmyutknKg1oevtXWZ/a2RDrsu05ZcuQ7J/kUlexjWd2dmjgCoLPFed9cuQCb5BPrVulDPMIcaHaLTd2iKX7/BsupJxqRl/q5HvfzeOpD+VRvMaHAWH454Ng+fQ4YCU1UZik6AC/4ttau7w6hrcKZkHRotpDTCVGt/0L0c61URyJg8VeHvh5VWSgy6igFh+sdD2wj/wwj0awNZNL715EmpzPJkryAge4+pliaIIrMtUl0uFrj7QpdFCwWvdxPcoxMx5X0wQO7iGMfJyH4cIzgl9xpjLUpcJRn5SkXw/ATSpF6OMWZebYHR6FnImxRyZVD8jFDSUYyYHvaY8GzO4p4UEqs7YtYFIkgDay3AUuIQJLzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(54906003)(55016002)(8936002)(76116006)(5660300002)(64756008)(66946007)(7696005)(6916009)(8990500004)(316002)(86362001)(82950400001)(10290500003)(8676002)(26005)(82960400001)(2906002)(9686003)(52536014)(66446008)(33656002)(186003)(478600001)(71200400001)(66556008)(6506007)(83380400001)(66476007)(4326008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?q3YFl1bcRn6hf9coH3Qh16iDvncc8Ydum890StZXzsmb4CRji9q2TzzdRWvc?=
 =?us-ascii?Q?sjPgkYE9pE2Lhx+nhmBlEPIVonzQ/QkmLF5V62iBG1aa/9NGqhbgWHsKxhDo?=
 =?us-ascii?Q?E9RyQk6/e/0ZORbnwxkaoM1rKd6MEtoFVguhhkLThb6LlfQr9Zhy9LurBnx+?=
 =?us-ascii?Q?vwZ2D2Jx5DV4mmtu0bsf75VubmILuxO46Xnhu7IkyMdT9hk7LxxPa/GDJXXK?=
 =?us-ascii?Q?pTJDufTpOmxTJg7XH6CMyU89CCxr0pwNqTN5EXASl9AIj+RNqYLBRftJsr3e?=
 =?us-ascii?Q?fN0Wj+2ZFaneydANrFpT9sruq3MjNpET8uPrGBrws7eveppOe1oR9Yq1wNTG?=
 =?us-ascii?Q?PWb4MJDjflY82+gzAHuNrt4Hi250lgatBjSoBbsRu0MOU4HyRDUXYJqR4D6s?=
 =?us-ascii?Q?P4/GbqL7rXueX+Lv/MQWg95hmI/tgO9i9UcguEhLuWcSZXhKh3B4xq+Et0Aw?=
 =?us-ascii?Q?vZXs1L+etUt7OmuIhhIbaBG1qYJ24nHqLJC+YQqJLpQhf668U75Bjck50axo?=
 =?us-ascii?Q?OiyHa5w9xZBCztYz96HyXQvIJ4J829RbM7qrin2b5vsFSS0d/ZSaxyhldXo/?=
 =?us-ascii?Q?jH9x+NwHOE+Lo9KAzktybJGtPgjTpURN7sJiKubdwDfmWhL8zw3hGbR8nM99?=
 =?us-ascii?Q?wQ8jgJCRTgUoPkk9rOpP+e+BXXJQd0koH080bPaKwvSrwl/DhgXWTbgXaaG5?=
 =?us-ascii?Q?ykTGMOWzmCp71J5lYHMaBBD+eZB5u4TmdEVwL2YKTRAh0Op8DDavNRO4HyIX?=
 =?us-ascii?Q?rdeEHHAXtSLJXeYiJHdFRC75Az/IQ3sCO1VnkxaIafzO+mjNHGBv9u4lbBzc?=
 =?us-ascii?Q?RX9pZ5qqFJDMutgHqtZuzRod0zD6VND20ODJ2/wkDBqxtC4dKsgBiZcibQ6e?=
 =?us-ascii?Q?Z+3FClkZX//tvYmQ+fpF0DBzxTZZd15mh1ZSL5M9kt89vYF2TkkR5xdb3hze?=
 =?us-ascii?Q?HbNVfdh/I/+L18nm9KMUdmETq4HquTvsedY7di7YWbkHXbE1mY3/3rMcfkaD?=
 =?us-ascii?Q?cOWpUQsWm+DUJeLXaWfsM8n5YhKY9gaQ9ofBo99QeVzBjyxfzvLOLuxgQyRG?=
 =?us-ascii?Q?SV+Be1K5ptz9RCFHK+/McJSoTC/x1uuFjts4phr0NyojejOWTRiB6p2fJSZl?=
 =?us-ascii?Q?nxGA1CaRIJaxSpOHaNYcWpzYWpEr5NtKh3qyIHtKY6YIq1ghops2+IT6u8KF?=
 =?us-ascii?Q?OZhITLPgxaJM7rJxVmIgzMSsGe/nNI7oyiv4OCDs3LFy1S3S9a/Z62IsFcq6?=
 =?us-ascii?Q?eXpiP2XaWQAlVcSwDSHmWroUISzUEA1hP7lxvTu0RUmC/KJ0zOd1slJI4OZP?=
 =?us-ascii?Q?6+nNUAw4TRvGRdepmzS15fMn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5cb27c-1f1f-47cf-b553-08d8d9befe65
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 18:56:00.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nfttu5oFnDT9HvF3NaTTHqyv07qzBOJkh2a3td3ecPZFKSgeaFhYWiHTKjDlGbB0+TXskZtP5E8+J1G610ee1g9e5iOOtyVRNPj51NbZCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0758
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Monday, February 22, 2021 10:=
47 PM
>=20
> On Wed, Jan 27, 2021 at 12:23:45PM -0800, Michael Kelley wrote:
> > STIMER0 interrupts are most naturally modeled as per-cpu IRQs. But
> > because x86/x64 doesn't have per-cpu IRQs, the core STIMER0 interrupt
> > handling machinery is done in code under arch/x86 and Linux IRQs are
> > not used. Adding support for ARM64 means adding equivalent code
> > using per-cpu IRQs under arch/arm64.
> >
> > A better model is to treat per-cpu IRQs as the normal path (which it is
> > for modern architectures), and the x86/x64 path as the exception. Do th=
is
> > by incorporating standard Linux per-cpu IRQ allocation into the main
> > SITMER0 driver code, and bypass it in the x86/x64 exception case. For
> > x86/x64, special case code is retained under arch/x86, but no STIMER0
> > interrupt handling code is needed under arch/arm64.
> >
> > No functional change.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c          |   2 +-
> >  arch/x86/include/asm/mshyperv.h    |   4 -
> >  arch/x86/kernel/cpu/mshyperv.c     |  10 +--
> >  drivers/clocksource/hyperv_timer.c | 170 +++++++++++++++++++++++++----=
--------
> >  include/asm-generic/mshyperv.h     |   5 --
> >  include/clocksource/hyperv_timer.h |   3 +-
> >  6 files changed, 123 insertions(+), 71 deletions(-)
> >

[snip]

> > +static void hv_remove_stimer0_irq(void)
> > +{
> > +	if (stimer0_irq !=3D -1) {
> > +		free_percpu_irq(stimer0_irq, stimer0_evt);
> > +		free_percpu(stimer0_evt);
> > +		acpi_unregister_gsi(stimer0_irq);
> > +		stimer0_irq =3D -1;
> > +	}
>=20
> I think we need:
>=20
> 	else {
> 		hv_remove_stimer0_handler();
> 	}
>=20
> here?
>=20
> Because previously, on x86 we set hv_stimer0_handler to NULL in
> hv_remove_stimer0_irq(), however, this patch doesn't keep this behavior
> any more.
>=20
> Thoughts?
>=20
> Regards,
> Boqun

Yes, agreed.  Will fix this in v2.

Michael
