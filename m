Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7D634E55
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 04:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiKWD1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 22:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKWD1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 22:27:34 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020016.outbound.protection.outlook.com [52.101.46.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5ED114;
        Tue, 22 Nov 2022 19:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfZlX0dWjhBXuc+FwqLWAwYS9CjR12xC6M/9y8+ioMUZxvbbg7tzhkdtGqpLkkcZYoBhbaGmzFnxQLuoUho1IRG8a9mWe8PqEdzAUr8dNjQ/n0yacAqT654gmo25amx/LhWe0MGuhbgQ/5KjhnmQW8GaMxJteHSiK2+ZAh+Wkxns7YJhiwaFjhXU5/1jwxD8DKyqEmn8WMnDYgGg4hMVCxjGK1JF3AN3PxYbdX7hiKRNTSXPzcb5584d6AOdikynlFCNRsaJeWFTwEmlaxmjAfpHG0Tl4AXc+qnwmy2VKozv62WYIb0JgPEK/vDA0GSVfLzn+Avqm0V+dqcW/xSLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXmJDP7wdgwTH5w/Q+U5OwyOJBepbYP+d2VVlEgGLHA=;
 b=WZ/e8TZfckbSMSh5dhxshef8sJXtPypU1HmcR0pp8eHpiFPaqB+YFKB/xQtiD4lG6qBzNRsY3oVESVEqvY1AH4/y+orKzdpzUyTlTDVGc5pQfMnr5zsYL6r0z91U2Gpx/KCMWYgbOmb3qg3t3JVp8ujnU9aZt9bFV+jM1A32aPfAEuJKMEfmye782ud21OM0d5XQMDo6ZJLxM9M97H2qhivelON5kzHVrYvUK16VhVft6oDQhZXrm85hZnBdXq0PnLXk8oLmdikWogDgJX0nbOUf+tXBmXly13mMf0gWOTbQHF6Kazmfl2ZHVZr0t6zAXCD8w0HzeY81LXPQbAQHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXmJDP7wdgwTH5w/Q+U5OwyOJBepbYP+d2VVlEgGLHA=;
 b=BNC3uBHx3MMDo9HxmiktZq0GSzbIrhwhMRvLV+yu6Bo+xHyKNrNSlLob7Z6ubxr/MX8cR2OYxIcXUgE76tv2cl3+LSGOyzuDJ6JrN4/bZz6dMC7OQAwdj/9NOgG2/FSofvMo/AejAZ1lImbHzOh0ILVV9Hs2TEwwBOJCQQzxH+Q=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1536.namprd21.prod.outlook.com (2603:10b6:208:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Wed, 23 Nov
 2022 03:27:25 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 03:27:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHY/uuA5M0FGuMnSkmqWvcQ39Wr/g==
Date:   Wed, 23 Nov 2022 03:27:25 +0000
Message-ID: <SA1PR21MB133596B911C6A45142B83B52BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-3-decui@microsoft.com>
 <20221122000100.bizske6iltfgdwcu@box.shutemov.name>
In-Reply-To: <20221122000100.bizske6iltfgdwcu@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14cc37f2-9a35-4b1e-9c6b-34c156199a7b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T02:56:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1536:EE_
x-ms-office365-filtering-correlation-id: 1b6bf54b-aa94-4013-eb1e-08dacd02a437
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMW4dSA/a18g0gmpPas+WjAywAv0a1wzvzPmJhJM62xl+G9ZUmpCC3b1a4yYSxBVVjOG1JNrP6tuhFDlM0INS6ErpQmF1oEXt13OH4QZUADayjEEM9JO3txRQz+QPGBm3yN8jwGzv+A6PYZjsodyGcML/qOOtUA89AttnUKmRfsENTMy5zSQQSJKA1kIdHOSCZH9PxxbU4VpZRcgKC2c0cIuVAi0DUneq0iFFiKbfsYKi5gKSvqtFsTxTeECs0YZru7MBzGCALSjwNav7xTWbePzPmpvc1BmWfhi4yfuJNKho6pDz7hME+nYyZbwWSO6GkXzHIRqEOY48nUv7Db7hhzqVOUYp744V0owYdroTgldalPUIsCQK0xB3ZVLHQ4avtOuGlW2FtOX2jMA2cEra+ZBo950rp57pjhd7WduTMRNfEUnnwe3+jXmSxHMJ1h2X65YypIJu0FY6L1YqyB+cYGnZKR5QP/tRHKkOceVVSSRAgMHFkM03+SHKaAlcgCgtYdvLQyDexhgetkeTZ0FubUJ8tjlhr6zKLEXw8d2YvIi/T7g30rT+0HD2ESn3m/r4fAiSFfJtceuI7nmNTNA99LkLps+lY+IszQnwD3Oye/6+tpWL1zhaPV/nRP2JQumeYAd79CanNCXlwHb0LwKAnv+9l1i1DzsIWIsR/bb6ecFp2RukM19R9o7NECYuMuG1Mvr7zmia9822PNBk4ne14FgowFxZiZFaLDM+9cFzZkD40m1ZvfLcfrEiQzGOD0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(5660300002)(7416002)(55016003)(33656002)(66446008)(9686003)(26005)(64756008)(66946007)(66556008)(76116006)(66476007)(54906003)(6916009)(316002)(7696005)(6506007)(186003)(52536014)(4326008)(8676002)(8936002)(41300700001)(122000001)(82950400001)(38100700002)(38070700005)(82960400001)(83380400001)(2906002)(86362001)(8990500004)(10290500003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AMPY75C70CXy6zYy2r8UQzZRIwSBoQcSGFIAfipoxRiuwHZgvdvoFYxOp528?=
 =?us-ascii?Q?AGZLIXFa28BkNZKBnrNdqBMmDsfXkFj/hlK55XYfo9m0gXCJJ9eZEZiBsqeR?=
 =?us-ascii?Q?qg7eThttxj2O7n46+b/O0v0r2JYYIklEDYXxosyBOxkQowwiqR1d9Gv3Qb2a?=
 =?us-ascii?Q?0Xcqkj0oY74CICCABKMeMJrA+EB5yNqAN+PFt5oTFbtVR+lHxkLG7w8u3cj2?=
 =?us-ascii?Q?jtzDZ4obNANKyV49atcYgpYdbywq2jlVestdCEjwNpgAlZi2wm5bHZR/MvUh?=
 =?us-ascii?Q?+M2e8yjyDJpev2+PVh6eXc7blzNgFiFldeaAwNae3ygyAJEjhm+X18vrO6ms?=
 =?us-ascii?Q?gpJAxOEqnH8m2GOlpu4J9AtIfIzt81hG4rV5Mq9m+vGiGbRntH3srmSUPn1H?=
 =?us-ascii?Q?mzzLFkA6oew1r07WbOAm4f+CDRspgaAy8YJrF0K9r3e6z0V40ef6oW4Mjb4F?=
 =?us-ascii?Q?3aKan7tZrWe94MeFO595hzu8ciYjtwbmfzzhcbd7DxylrSxRpnSCkUiyBAKA?=
 =?us-ascii?Q?cYPD1P35+0s/ytAKTLmIhuIl2h4WaZpvvK3c9IQ0VAfyh53oFg4J4DVAoSrd?=
 =?us-ascii?Q?t1kPASUt/8vrWDwH/fMBhNQoMnyuOR3D4BccHuKPvGK0v99zFT41+/lujCCt?=
 =?us-ascii?Q?Y+6CLO0KWoYL+fBxH8RthkXuo07o37iz2eIrr+P4Jz5ouF9hQnBDkCxCAoyo?=
 =?us-ascii?Q?LIHd+93Y+v+OEUYbIFtqkYf/H+tZJX2kpJBP4piIgi9QPORkEPH8q7XZfuNN?=
 =?us-ascii?Q?Qsrlwp9LcMpic6G/PCQDXYIrZiFA2vZqYSEm+7MfvAc1dNe/kDZZtzAwyY/H?=
 =?us-ascii?Q?lk3ROjjC90NXNDEzkUZ0p1IjSiCdW51JEDQhnlCx2FRQD100Pv9cx2fVNYuW?=
 =?us-ascii?Q?v9fywgFGO5GzocfnyoXHUvVFaM5g1z81/aMAZifLfQfFaFW9wmh6XBrBX8Vb?=
 =?us-ascii?Q?1wkJqnPL97dOx4PhevHh6nce0u3Pw8sypOr8F0cXgYqYAkLjWC1m3cjFoGs/?=
 =?us-ascii?Q?TuQKPpA61xRPt5CQ2lAnMK1K/tNqxTNJilwRkCQ6rXb3UrPYkI8TXpoPT/Xh?=
 =?us-ascii?Q?B/riOXdqyXzcacZ9ZnHHwNF4WtHn8X1FmLhrhwqI4BRl5OoOQayQiKUrUJ2L?=
 =?us-ascii?Q?1Fqo7POy9VBo0TeolTvzeZzkeCG26aA2YD5Z+nduZV9s3yuJYVaKEwvonHXQ?=
 =?us-ascii?Q?jq9h9Szi9Izv04Ms4/4zFjwZj9iUe61QSnoWankwykzyraRVeXcl/J5vAyyT?=
 =?us-ascii?Q?kBsRTqSCXXWVwtj70RVBLawJoCB+VpososvbGwXw/qWwaHog7WAzRnPM+UPl?=
 =?us-ascii?Q?4o+GFdn8P2JUyT1AEYh/9Gl7rUgALeHXn+FicRO8ETr8tROY7aYNkFFBUkvJ?=
 =?us-ascii?Q?Sz7zUfD9mibTTx+UqSObC3qQhpHLMNhhrBwSpSWF7sL8uTJkk2O7VOhUkZ7X?=
 =?us-ascii?Q?Spman821NUMYgpKh/OrwWakcdJz6GWydHSvIwjBefbYBYrR512xVoknXVuSc?=
 =?us-ascii?Q?xJ2HZETVNB3+AS8NJcGh5R/qd4vDgspwcMEIQXdDGmtSFAVtl0+74Q819pFM?=
 =?us-ascii?Q?TUd9dLAxP8qWpoU00fcWIjun0f28EtHLSSUxVLXX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6bf54b-aa94-4013-eb1e-08dacd02a437
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 03:27:25.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9C9Gqey8K+K+rRuITWKbV6sQROQc3KZ5BC0MissIFGReVt9Wcsi6gsM4TT3zG4P/DO1tbsxki8KfxnoN5RCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Monday, November 21, 2022 4:01 PM
> [...]
> On Mon, Nov 21, 2022 at 11:51:47AM -0800, Dexuan Cui wrote:
> [...]
> I'm not convinced it deserves a separate helper for one user.
> Does it look that ugly if tdx_map_gpa() uses __tdx_hypercall() directly?

Will use __tdx_hypercall() directly.
=20
> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  void __tdx_hypercall_failed(void)
> >  {
> > @@ -691,6 +712,43 @@ static bool try_accept_one(phys_addr_t *start,
> unsigned long len,
> >  	return true;
> >  }
> >
> > +/*
> > + * Notify the VMM about page mapping conversion. More info about ABI
> > + * can be found in TDX Guest-Host-Communication Interface (GHCI),
> > + * section "TDG.VP.VMCALL<MapGPA>"
> > + */
> > +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> > +{
> > +	u64 ret, r11;
> > +
> > +	while (1) {
>=20
> Endless? Maybe an upper limit if no progress?

I'll add a max count of 1000, which should be far more than enough.

> > +		ret =3D _tdx_hypercall_output_r11(TDVMCALL_MAP_GPA, start,
> > +						end - start, 0, 0, &r11);
> > +		if (!ret)
> > +			break;
> > +
> > +		if (ret !=3D TDVMCALL_STATUS_RETRY)
> > +			break;
> > +
> > +		/*
> > +		 * The guest must retry the operation for the pages in the
> > +		 * region starting at the GPA specified in R11. Make sure R11
> > +		 * contains a sane value.
> > +		 */
> > +		if ((r11 & ~cc_mkdec(0)) < (start & ~cc_mkdec(0)) ||
> > +		    (r11 & ~cc_mkdec(0)) >=3D (end  & ~cc_mkdec(0)))
> > +			return false;
>=20
> Emm. All of them suppose to have shared bit set, why not compare directly
> without cc_mkdec() dance?

The above code is unnecessary and will be removed.

So, I'll use the below in v2:

/*
 * Notify the VMM about page mapping conversion. More info about ABI
 * can be found in TDX Guest-Host-Communication Interface (GHCI),
 * section "TDG.VP.VMCALL<MapGPA>"
 */
static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
{
        int max_retry_cnt =3D 1000, retry_cnt =3D 0;
        struct tdx_hypercall_args args;
        u64 map_fail_paddr, ret;

        while (1) {
                args.r10 =3D TDX_HYPERCALL_STANDARD;
                args.r11 =3D TDVMCALL_MAP_GPA;
                args.r12 =3D start;
                args.r13 =3D end - start;
                args.r14 =3D 0;
                args.r15 =3D 0;

                ret =3D __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
                if (!ret)
                        break;

                if (ret !=3D TDVMCALL_STATUS_RETRY)
                        break;
                /*
                 * The guest must retry the operation for the pages in the
                 * region starting at the GPA specified in R11. Make sure R=
11
                 * contains a sane value.
                 */
                map_fail_paddr =3D args.r11 ;
                if (map_fail_paddr < start || map_fail_paddr >=3D end)
                        return false;

                if (map_fail_paddr =3D=3D start) {
                        retry_cnt++;
                        if (retry_cnt > max_retry_cnt)
                                return false;
                } else {
                        retry_cnt =3D 0;;
                        start =3D map_fail_paddr;
                }
        }

        return !ret;
}
