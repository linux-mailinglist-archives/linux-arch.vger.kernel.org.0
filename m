Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE751C6C
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 22:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfFXUeC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 16:34:02 -0400
Received: from mail-eopbgr730105.outbound.protection.outlook.com ([40.107.73.105]:59557
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbfFXUeC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 16:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hpj2ln9PdF2iw8CTNKfMyvckw7/rfWmo7YDhUidEPTU=;
 b=CKlrlyGmhJ/QCyiCLX8NQhhVLKb9sH2j/eupCg474rMbmvTDeCr7AGHihTiJuz2GzMGdwvAfc3ovxv2uyeRMyCVj0tNtAPsBb31uv1OwnJNGzQ7YW+2gk5MlVJ1+ufcKyvCgj9DcHy2yEAfXvDPAWPE8Xp88uLXquvXCcLan3Rg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1054.namprd22.prod.outlook.com (10.174.169.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 20:33:58 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40%2]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 20:33:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] asm-generic: remove ptrace.h
Thread-Topic: [PATCH 5/5] asm-generic: remove ptrace.h
Thread-Index: AQHVKlBfN/z+ea/vT02hAZbwmFNTNqarQ6qA
Date:   Mon, 24 Jun 2019 20:33:58 +0000
Message-ID: <20190624203357.cgybfqklcflll2ti@pburton-laptop>
References: <20190624054728.30966-1-hch@lst.de>
 <20190624054728.30966-6-hch@lst.de>
In-Reply-To: <20190624054728.30966-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00576424-0e94-4dec-ebb0-08d6f8e348bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1054;
x-ms-traffictypediagnostic: MWHPR2201MB1054:
x-microsoft-antispam-prvs: <MWHPR2201MB10547E2A5FAB871CBCBC78F0C1E00@MWHPR2201MB1054.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(366004)(136003)(39840400004)(396003)(199004)(189003)(4326008)(54906003)(8936002)(14454004)(58126008)(316002)(1076003)(7416002)(25786009)(6916009)(8676002)(73956011)(81166006)(81156014)(2906002)(66066001)(6436002)(66946007)(66446008)(3846002)(42882007)(64756008)(66556008)(6246003)(66476007)(6486002)(44832011)(6116002)(33716001)(9686003)(6512007)(486006)(26005)(11346002)(446003)(186003)(7736002)(68736007)(305945005)(476003)(229853002)(256004)(14444005)(478600001)(5660300002)(52116002)(76176011)(99286004)(53936002)(71190400001)(71200400001)(6506007)(386003)(102836004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1054;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1o+p+e7S28HMuolVpWY64pfIILQb2dMbrDbcOGciaGoS1LXGJlr7ehnAHp9Ycl6pInnLSSHXLBrmjxD2nhzpvkx6BWCBDK9u52gqwDxJ5Fout54XxI2fy+MGo6qyttipUcv2XOOVnWqxCl/ILzLFSqGZVq5nKzK3lWtjeoHACRyLrV5zsqIYrfBupUjTEw33WanaTTvWYlcv+0mdWFX+DJsZ9kfHAoys2DAzHpb5kk5eWZEkcDMiY+t5uSNUS++2Xf7n8d+IVDrGCH1Z44Y9KNM2QJChm0zMIH8OPuwH6fU3+G65lSIQw1+O3zqWFgusIEIGrLtLxE+CapTrztWLmtxSFCG6D1aRDewri+FvG89kUg5pLHWFmexREBv+wmbnkWGGSSOGcbkW5TPEgJLSUdQnZhZaAx0W6d62WAPHBg8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B945272A94CC124191D61CF8D0443342@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00576424-0e94-4dec-ebb0-08d6f8e348bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 20:33:58.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1054
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 24, 2019 at 07:47:28AM +0200, Christoph Hellwig wrote:
> No one is using this header anymore.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  MAINTAINERS                    |  1 -
>  arch/mips/include/asm/ptrace.h |  5 ---
>  include/asm-generic/ptrace.h   | 73 ----------------------------------
>  3 files changed, 79 deletions(-)
>  delete mode 100644 include/asm-generic/ptrace.h

FWIW:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrac=
e.h
> index b6578611dddb..1e76774b36dd 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -56,11 +56,6 @@ static inline unsigned long kernel_stack_pointer(struc=
t pt_regs *regs)
>  	return regs->regs[31];
>  }
> =20
> -/*
> - * Don't use asm-generic/ptrace.h it defines FP accessors that don't mak=
e
> - * sense on MIPS.  We rather want an error if they get invoked.
> - */
> -
>  static inline void instruction_pointer_set(struct pt_regs *regs,
>                                             unsigned long val)
>  {
