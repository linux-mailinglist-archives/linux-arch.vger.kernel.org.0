Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98966C68F6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 13:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjCWM4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWM4N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 08:56:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47902CFD7;
        Thu, 23 Mar 2023 05:56:12 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NBKSXK022815;
        Thu, 23 Mar 2023 12:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WGvt1tA3Zdk26SSxIzJUKoKuqvx3KwswYKcjn4Jb9Fc=;
 b=jzUlyZ4ozowNa1iwb3IUhj06Kbwh25fZs9qfyi4AfHJmQx44pwFBuZHKt95nFhu19q1U
 GTIJ6BVuBHmdJSQusFTpIAHLBZfhZggk29QCblYNYDsCs/yZgr8WzL7TnmVj6radzth6
 IDWkFQi80yr94v0r74lzeAPjH3QGXj0JLOQZE8zRvfvwEZlWJUqXo3lQAKIlM7JvqTPU
 QI2OjED50v3BVENpYqrQ6eZ8iWtXKKoqKyNUKL677VFfiABImwuqN3lXGVLBLuLKl4p8
 uvjn+n33ihWRbUfzX9u+ICKkqbQ3pVtiSj2cHR/DZsCEQi5jh9PY4E/7sVfFRfUSkgk/ 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77mu2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:55:44 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NBS1O5026870;
        Thu, 23 Mar 2023 12:55:43 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77mu10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:55:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4XRlf018070;
        Thu, 23 Mar 2023 12:55:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6e7u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:55:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NCtbLw32244458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 12:55:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B963B20043;
        Thu, 23 Mar 2023 12:55:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81F3C20049;
        Thu, 23 Mar 2023 12:55:36 +0000 (GMT)
Received: from [9.171.87.16] (unknown [9.171.87.16])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 12:55:36 +0000 (GMT)
Message-ID: <2bcabfceab658ae62bf854e5fdaf5bc916481359.camel@linux.ibm.com>
Subject: Re: [PATCH v3 26/38] pnp: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-acpi@vger.kernel.org
Date:   Thu, 23 Mar 2023 13:55:36 +0100
In-Reply-To: <CAJZ5v0gHFA_BgLuCx=Eb3J5D7f7j8kV3Pthqy3jAfpavY6UMuQ@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-27-schnelle@linux.ibm.com>
         <CAJZ5v0gYGkbUk4uFXgidMaRBniwiXpizZWwMGixeNNejeZjPzg@mail.gmail.com>
         <CAJZ5v0gHFA_BgLuCx=Eb3J5D7f7j8kV3Pthqy3jAfpavY6UMuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AodznXdTibR-B5qDAN4iAweHV8OlJvjO
X-Proofpoint-ORIG-GUID: VqiraoOxe_Uj9DZ687OluBDOrMzSML3q
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxlogscore=851
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230094
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-03-21 at 14:56 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 20, 2023 at 6:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >=20
> > On Tue, Mar 14, 2023 at 1:13=E2=80=AFPM Niklas Schnelle <schnelle@linux=
.ibm.com> wrote:
> > >=20
> > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and frie=
nds
> > > not being declared. We thus need to depend on HAS_IOPORT even when
> > > compile testing only.
> > >=20
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >  drivers/pnp/isapnp/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
> > > index d0479a563123..79bd48f1dd94 100644
> > > --- a/drivers/pnp/isapnp/Kconfig
> > > +++ b/drivers/pnp/isapnp/Kconfig
> > > @@ -4,7 +4,7 @@
> > >  #
> > >  config ISAPNP
> > >         bool "ISA Plug and Play support"
> > > -       depends on ISA || COMPILE_TEST
> > > +       depends on ISA || (HAS_IOPORT && COMPILE_TEST)
>=20
> This breaks code selecting ISAPNP and not depending on it.  See
> https://lore.kernel.org/linux-acpi/202303211932.5gtCVHCz-lkp@intel.com/T/=
#u
> for example.
>=20
> I'm dropping the patch now, please fix and resend.
>=20
> >=20

Sorry if this wasn't super clear but all patches in this series depend
on patch 1 which introduces the HAS_IOPORT Kconfig option. There's
really two options, either the whole series goes via e.g. Arnd's tree
at once or we first only merge patch 1 and then add the rest per
subsystem until finally the last patch can remove inb()/outb() when
HAS_IOPORT is unset.

That said I'm a little unsure about the linked error if that is just
due to missing HAS_IOPORT or something else. I'll still have to try
with the instructions in that mail and will report back if it is
something else.

Thanks,
Niklas
