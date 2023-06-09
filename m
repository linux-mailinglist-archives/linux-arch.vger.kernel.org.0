Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1E729D92
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjFIO6U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjFIO6T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 10:58:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87AA3A82;
        Fri,  9 Jun 2023 07:57:55 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359EqpFj032000;
        Fri, 9 Jun 2023 14:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mQ32Hj2rOLiDXWb7kXaNohNFO/t643oP8mOO5J5x8IE=;
 b=qILm1AxEoZ/W+uLtIkUyETlZgGLsCl1tID6wa63/lfI4+67XBpli63h/xulpOXZ+emSt
 +EFzDAGSwCqs8rvLR4go6ZEKBY9NxZyul3wmcFicxwsI1D5aCg0v1Gv4KGrWPjipjSva
 XFCTBWKOMoHiz8k3vfGrSWbAWylesmzFOhtfMXn7tXM/BWjaVta99nhkEmXkb7HnXypL
 4B57Kae4jyT25SrSEKD025zsgfr8Iv5E1tP7zL9JJwvRfUdEqfTcgW/NRVDUa8zgbuzS
 3wqoTI3evnlpP8ZJ7kshaPstAzRDOHjSoRQ+ad5YE6hlswK0rDZXxh28fWdG4IDPv2Fq kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r467yr398-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 14:57:35 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359ErMmh002656;
        Fri, 9 Jun 2023 14:57:35 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r467yr37v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 14:57:34 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3593e50V009566;
        Fri, 9 Jun 2023 14:57:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r2a7a9eds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 14:57:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359EvSFp44433852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 14:57:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6474920040;
        Fri,  9 Jun 2023 14:57:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 578A020043;
        Fri,  9 Jun 2023 14:57:27 +0000 (GMT)
Received: from [9.171.40.189] (unknown [9.171.40.189])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jun 2023 14:57:27 +0000 (GMT)
Message-ID: <f858c964f2fbe2fa5a92652c7d5022af7e3b76f1.camel@linux.ibm.com>
Subject: Re: [PATCH v5 07/44] counter: add HAS_IOPORT_MAP dependency
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-iio@vger.kernel.org
Date:   Fri, 09 Jun 2023 16:57:27 +0200
In-Reply-To: <ZIHs55tweGZTIiYk@ishi>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
         <20230522105049.1467313-8-schnelle@linux.ibm.com> <ZIHs55tweGZTIiYk@ishi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KHm5w9z_zuFS2xI7NoUPzgiEzAz0qS0i
X-Proofpoint-ORIG-GUID: UtlFUumJPzZISw0sVTmb6j2eGl6-g7UC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=833 bulkscore=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-06-08 at 10:59 -0400, William Breathitt Gray wrote:
> On Mon, May 22, 2023 at 12:50:12PM +0200, Niklas Schnelle wrote:
> > The 104_QUAD_8 counter driver uses devm_ioport_map() without depending
> > on HAS_IOPORT_MAP. This means the driver is not usable on platforms such
> > as s390 which do not support I/O port mapping. Add the missing
> > HAS_IOPORT_MAP dependency to make this explicit.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/counter/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 4228be917038..e65a2bf178b8 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -15,6 +15,7 @@ if COUNTER
> >  config 104_QUAD_8
> >  	tristate "ACCES 104-QUAD-8 driver"
> >  	depends on (PC104 && X86) || COMPILE_TEST
> > +	depends on HAS_IOPORT_MAP
> >  	select ISA_BUS_API
> >  	help
> >  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
> > --=20
> > 2.39.2
> >=20
>=20
> This has a minor merge conflict with the current Kconfig in the Counter
> tree. Would you rebase on the counter-next branch and resubmit?
>=20
> Thanks,
>=20
> William Breathitt Gray

Sure can do. That said, using a three way merge as below doe handle the
conflict correctly:

% git checkout counter/counter-next
% b4 am -P _ 'https://lore.kernel.org/all/20230522105049.1467313-8-schnelle=
@linux.ibm.com/'
% git am -3 v5_20230522_schnelle_counter_add_has_ioport_map_dependency.mbx
