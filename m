Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EEB710B99
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbjEYMB7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 08:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjEYMB6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 08:01:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841039C;
        Thu, 25 May 2023 05:01:54 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBE7gv009110;
        Thu, 25 May 2023 12:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=N74mf/q4dLNgAVVmA6FO42kwVM2DzKnj6y8VFxGHQZk=;
 b=HK2a/Uoh4JJZCox4kTNgU1C/Ydx7Xo1pHn+IzHj8XzaybhrvuTFVm6685/WOzDzso9sy
 XsShlbz2WtwXSvZb73tjRookdntOg77tQ6RucQJiogdCYQFwB8htbiST0s9aOGmmzucL
 D+rSc8nJPOadA9SoosDN5/o7xBOVyC6uJGWCjOzsgyUijxQxRZOhGAP5mkx3ug88v4TR
 xLZhJ3LMt4d6HSzfrYW+z6yqcaVewTK08lLMZIKs/L2GV243VQYnwAt8lV/xu0qOeWCz
 9b4i45yUkkUpeeaKtgd5ugs1udW5QH4vTIWEDi1pU2CJjSOV4oMAMIZPslORLOGFXZEp Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6m6s430-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:01:35 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBFOIG012156;
        Thu, 25 May 2023 12:01:34 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6m6s41q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:01:34 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P8FB11030209;
        Thu, 25 May 2023 12:01:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qppcf2119-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:01:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PC1TdJ53543422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 12:01:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F69820049;
        Thu, 25 May 2023 12:01:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23DFA20043;
        Thu, 25 May 2023 12:01:28 +0000 (GMT)
Received: from [9.171.55.66] (unknown [9.171.55.66])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 12:01:28 +0000 (GMT)
Message-ID: <74c45bdac7398632db844c6794c9a59cd87e0ecf.camel@linux.ibm.com>
Subject: Re: [PATCH v5 43/44] wireless: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jouni Malinen <j@w1.fi>,
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
        linux-wireless@vger.kernel.org
Date:   Thu, 25 May 2023 14:01:27 +0200
In-Reply-To: <168491387892.8984.13248048073287184221.kvalo@kernel.org>
References: <20230522105049.1467313-44-schnelle@linux.ibm.com>
         <168491387892.8984.13248048073287184221.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BSsJlYkbBpMOVnlpEFZDK8l22-q1R0eB
X-Proofpoint-GUID: hWIuyBXOqODGhJ8iDxYhpmgSB2vnsEoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=534 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2023-05-24 at 07:38 +0000, Kalle Valo wrote:
> Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>=20
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Acked-by: Kalle Valo <kvalo@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Now that the dependencies are in v6.4-rc1 my plan is to take this to
> wireless-next, is that ok for everyone?
>=20

Yes okay by me. Thank you.
