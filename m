Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB724DC64
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgHURAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 13:00:39 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33600 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728584AbgHUQ6l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 12:58:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LGor8E030690;
        Fri, 21 Aug 2020 09:58:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=tTEsus8IuNh3NLjop9JSx8lG9JFQcPbzslk79SnWgBU=;
 b=jrBRdxAx1Ie11hBqbyygeAtMvaCc7OjsGxBIK6Q5wD9tSCssIaoAsHvUwY9Hh/rz0VOx
 wTWAbZCgfXOawZbf4vbA8d9rUaSPPQZfb1+X+fcoH8uZbst9exG3Lj32EfDr9KVvOEdn
 QamPX7SNweyY2cvcpW+u7GKEuXVAJZ1sKngccRqJ7DRticM3pdpid0B+xiQHp2lDpc7L
 uZhKVRxunvs2o8j12NsS3c7pMgfH35TPEr2Jp5ak+H8ndxNtr7FigKNysPK2yvxEQqC5
 nYQrZTijh95ubPwqMBZY3iTR83ZZBufvg56UCSsBUQCTRGkQcXiVcwV1yPHSGp5ajpp/ Eg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 3304hj3ayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 09:58:31 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 Aug
 2020 09:58:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 21 Aug 2020 09:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apw6kYWvp7bXKGQ6VL84qozf6yqta5gaPl7BEzFsvMHNLeffXvd6yBpeB83F59npGQkmbds/Sr4idf+rezGub+dBi2Q94lTMjIeGwSKq4EMNnen7zG7fURK7/rehZeTxpq8A/0ka6E4vpKd7eLYgX0B18h8l5B7r5JmaxMigYNCEWS83dcXNX3HE0QMdoUuc7lYmQwNhnVTGN2qxenOR1woHd4vqcTdm523+4lqF7f97sSqdeNKZuCSV2u1aZLCm2vKPH8zbd0fRuTX3rVSIJNrLSyrPc2qRoh/pr/AGWjga3W9umAFECsuMnjJQFqbsdYysLhr3StgLAFrakDFmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTEsus8IuNh3NLjop9JSx8lG9JFQcPbzslk79SnWgBU=;
 b=muIlyvqk3mZxJSX7DJUvuy+8HqFj3O2TmdptyFufOB6FWqRwsoFMGGlQT2uq+7bF1x0xR3aNSGZKkzMYyBr6oQDHjZl5YQMTkrywpJedxQ7E6C/FIUexlrM80RqrKZSqPG02yic7fNp0rxsSJnFqa5XHo2YdUtmgKtaG1C1z9oA8Mhnpposd4hDTbz8dYJtq5NiCkyBFjbc0UgqinwPlrPHFF51MwgXng8uZIlON0Mi8D6NAf4F08Af1q/eNsuFXuJy95SGRSeNBCpRwMFyz8N8TUs4lJDq9Qels4aJtbvLTfZSizsb4/K/AHyZXYLtFmGSbh8Vh1jRTe59PFMBB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTEsus8IuNh3NLjop9JSx8lG9JFQcPbzslk79SnWgBU=;
 b=k+D7sLFoDUsmONyilIohgLepX+PFed2XinzPeXNqIXp2vrjN5vEbOLnV53wQ78dwEyWUd/uQXhY6AE11uz9IoLeKaRgQdSqkFZxwiDwBNSsIMuOcWM0hsL51ureaP9D9kRQTL3wV4ZKbNJ1s0/uAGYeC+RgcYKP4CmIwqSyXGw0=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by BYAPR18MB3079.namprd18.prod.outlook.com (2603:10b6:a03:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 16:58:28 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e%4]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 16:58:28 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2] PCI: Add pci_iounmap
Thread-Topic: [PATCHv2] PCI: Add pci_iounmap
Thread-Index: AdZ31ptDeVUM7kZoTZaYMMrSGjrSJA==
Date:   Fri, 21 Aug 2020 16:58:28 +0000
Message-ID: <BYAPR18MB2679042318DAC1EA29FFDF0AC55B0@BYAPR18MB2679.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [49.207.202.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3034900-5db4-43a3-588f-08d845f36d72
x-ms-traffictypediagnostic: BYAPR18MB3079:
x-microsoft-antispam-prvs: <BYAPR18MB307935CA4B466FCCC15060BEC55B0@BYAPR18MB3079.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eELDubYJAVYdZWnNFdUIa8i8LtqMil700uRVvV6IPKFMWH6G43RAJsW+3XxUzVLEIv25KzCMQrC6rgtZ5BIloX8J4NkjiK61QimhSdcVILgn+mV7wyBPuYK0YwmyiFzLuZvUKUZcPRpkXNhvt9nY1UyF9PMunzI7tjb45CCJEpmUN+/MWsqEKB7Bkv/VENovYS31Muj50AMuYprEqpDM0QbtAoL0MnJKmNr+6UFEvpj25SZq6BvWnDeBEAfNBY8lMAfwWFpJOv5d3z7/70mRnclKZGcKhblXOcHSDSGQFCqLcuMftdo5hQZf33OgThxT2NIWvdq9ixEdIY2N9RA9Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(186003)(4326008)(83380400001)(71200400001)(6916009)(54906003)(7696005)(64756008)(76116006)(478600001)(8936002)(9686003)(66946007)(86362001)(8676002)(55236004)(26005)(5660300002)(53546011)(6506007)(66446008)(66476007)(66556008)(55016002)(33656002)(2906002)(52536014)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Xk6eOgZ3H4ENdR6YBh+0Ppdgb3Qe+Gfc2wD4/d9XRUS+MwH1SoZpjzhqF11Eyhp2jzB8rAJvRgbQE6KVmuVvk9D9/bwLFroSHMz3ehstJp7iSxFNOuZ6dZ/oQ8nknLAkj8n1kozABDa7D4THahNuZXcvx1ya6953WoHyoK9M+sqyvXVgIHLptVGpaq0+p1u88WYLy1goCkQxZ8UtbO/n5+k3Pz9Xjub4SyicpHl8B6nWE90bgrBud/TJ9Z3+IKo6ou+60hiBVPVg1cdVxz/bU/RgB3IS4cjoKbSKEyfLID0xzlA4Hlzsj0SXHasHNEMb6daSzk65MWnCLwhQps13wKi8oy2Ve4BkVwzzFV1L7ynVmw/NR6xlt/bQK7j74U3f/nmFITuIRSgpk7kP9Kvi69FyIJoTpqNXLzDGLJ15j4XrdeJevfIVv6m9S0oTTRaU7ByTh3vbYVVxEolmiZcxrnnf8Sn8GfOu8oxTM+paLJsrqlhnMGqnTfNy2YTyk7yyfaZ57dwowYVzQp/GvL7G+OZ4Q9XaCJCa87r6l01E9uBnFZ9nnyhOXtllkauBodjMlj9p9Xer9ZKmNhvprtr7hijCDzxJ7XUuZaUJYfQNRSedfCeQHupcDFwVJhbfGmyb/kQximMNieMri/sOOcBcKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3034900-5db4-43a3-588f-08d845f36d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 16:58:28.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YasS26zJNge6i7EI01E9jMjZHEM/BHtU3U5dJXsm5vJaEmUKvc+jeY9Yw0LPH33hW070qrdagDvoEPB36uPxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB3079
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, August 21, 2020 3:26 AM
> To: George Cherian <gcherian@marvell.com>
> Cc: linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> pci@vger.kernel.org; bhelgaas@google.com; arnd@arndb.de; Michael S.
> Tsirkin <mst@redhat.com>
> Subject: [EXT] Re: [PATCHv2] PCI: Add pci_iounmap
>=20
> [+cc Michael, author of 66eab4df288a ("lib: add GENERIC_PCI_IOMAP")]
>=20
> On Thu, Aug 20, 2020 at 10:33:06AM +0530, George Cherian wrote:
> > In case if any architecture selects CONFIG_GENERIC_PCI_IOMAP and not
> > CONFIG_GENERIC_IOMAP, then the pci_iounmap function is reduced to a
> > NULL function. Due to this the managed release variants or even the
> > explicit pci_iounmap calls doesn't really remove the mappings.
> >
> > This issue is seen on an arm64 based system. arm64 by default selects
> > only CONFIG_GENERIC_PCI_IOMAP and not CONFIG_GENERIC_IOMAP
> from this
> > 'commit cb61f6769b88 ("ARM64: use GENERIC_PCI_IOMAP")'
> >
> > Simple bind/unbind test of any pci driver using pcim_iomap/pci_iomap,
> > would lead to the following error message after long hour tests
> >
> > "allocation failed: out of vmalloc space - use vmalloc=3D<size> to
> > increase size."
> >
> > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > ---
> > * Changes from v1
> > 	- Fix the 0-day compilation error.
> > 	- Mark the lib/iomap pci_iounmap call as weak incase
> > 	  if any architecture have there own implementation.
> >
> >  include/asm-generic/io.h |  4 ++++
> >  lib/pci_iomap.c          | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h index
> > dabf8cb7203b..5986b37226b7 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -915,12 +915,16 @@ static inline void iowrite64_rep(volatile void
> > __iomem *addr,  struct pci_dev;  extern void __iomem *pci_iomap(struct
> > pci_dev *dev, int bar, unsigned long max);
> >
> > +#ifdef CONFIG_GENERIC_PCI_IOMAP
> > +extern void pci_iounmap(struct pci_dev *dev, void __iomem *p); #else
> >  #ifndef pci_iounmap
> >  #define pci_iounmap pci_iounmap
> >  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> > {  }  #endif
> > +#endif /* CONFIG_GENERIC_PCI_IOMAP */
> >  #endif /* CONFIG_GENERIC_IOMAP */
> >
> >  /*
> > diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c index
> > 2d3eb1cb73b8..ecd1eb3f6c25 100644
> > --- a/lib/pci_iomap.c
> > +++ b/lib/pci_iomap.c
> > @@ -134,4 +134,14 @@ void __iomem *pci_iomap_wc(struct pci_dev
> *dev, int bar, unsigned long maxlen)
> >  	return pci_iomap_wc_range(dev, bar, 0, maxlen);  }
> > EXPORT_SYMBOL_GPL(pci_iomap_wc);
> > +
> > +#ifndef CONFIG_GENERIC_IOMAP
> > +#define pci_iounmap pci_iounmap
> > +void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr);
> > +void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr) {
> > +	iounmap(addr);
> > +}
> > +EXPORT_SYMBOL(pci_iounmap);
> > +#endif
>=20
> I completely agree that this looks like a leak that needs to be fixed.
>=20
> But my head hurts after trying to understand pci_iomap() and
> pci_iounmap().  I hate to add even more #ifdefs here.  Can't we somehow
> rationalize this and put pci_iounmap() next to pci_iomap()?

Yes,  that makes more sense than having #ifdefs here.
I will re-spin and send out another version.
>=20
> 66eab4df288a ("lib: add GENERIC_PCI_IOMAP") moved pci_iomap() from
> lib/iomap.c to lib/pci_iomap.c, but left pci_iounmap() in lib/iomap.c.
> There must be some good reason why they're separated, but I don't know
> what it is.
>=20
> >  #endif /* CONFIG_PCI */
> > --
> > 2.25.1
> >
