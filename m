Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568415171A8
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380007AbiEBOiI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378194AbiEBOiH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 10:38:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3C5F81;
        Mon,  2 May 2022 07:34:39 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242EVH50020019;
        Mon, 2 May 2022 14:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WdExTye17olTIg6QT8mBBfdfn+P/Stz7q1ekNoAttpE=;
 b=dxJ6fZaDeSA4ihga6rpilVdEGfjabtwwsf0ZJVuk3WBq2lc6XY5E8vJ90pFhHIwnS7ic
 s9M+aPW0IRYqIe7FV1Bf/NuQ3Ixo9S85C9EqHjVF9GDZQHywaoMvjvp2K2uEOktqV7RW
 n36HAaX1wbRZrSrd9ZPPFtVmk09yEOfP3RlqCuaqCzAPpXgnPkfjezg7XwWeU3Cif8dq
 cLEfIwW6QLsy4sKI4+v0l+JMQgbi5oYpI/hr6OGAL7UVnFMg9MsftDd5bzXxC3eHu0fQ
 xKPlBebfDEEmMesP30yAmbZz/kk5tQbbaJXiSdNN2mHxcpjpEhuDFb1CKrET1LGX8KFO 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fth4tg18m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 14:34:16 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 242EYG7c031072;
        Mon, 2 May 2022 14:34:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fth4tg186-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 14:34:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 242EWbT2032085;
        Mon, 2 May 2022 14:34:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3fscdk1nuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 14:34:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 242EKu3q23462322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 14:20:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82282AE055;
        Mon,  2 May 2022 14:34:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6E6AE045;
        Mon,  2 May 2022 14:34:11 +0000 (GMT)
Received: from sig-9-145-11-74.uk.ibm.com (unknown [9.145.11.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 14:34:11 +0000 (GMT)
Message-ID: <438c88e740f674ad334cdc88004fcec5b9ec57f4.camel@linux.ibm.com>
Subject: Re: [RFC v2 04/39] char: impi, tpm: depend on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Date:   Mon, 02 May 2022 16:34:10 +0200
In-Reply-To: <ff7605de-fe12-3bbf-cce9-aec18be9d54e@pengutronix.de>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-7-schnelle@linux.ibm.com>
         <07c39877d9e940a96be41e21e22fe45dbb73d949.camel@linux.ibm.com>
         <ff7605de-fe12-3bbf-cce9-aec18be9d54e@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fm4gl_CCV9IRrCnZDVRyK0djotDq9YcN
X-Proofpoint-ORIG-GUID: eIPjDVk3Gk_Wv_RNZGcDg89tcb5gRnjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_04,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxlogscore=920 spamscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 16:33 +0200, Ahmad Fatoum wrote:
> Hello Niklas,
> 
> On 29.04.22 16:23, Niklas Schnelle wrote:
> > > Hello Niklas,
> > > 
> > > On 29.04.22 15:50, Niklas Schnelle wrote:
> > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > not being declared. We thus need to add this dependency and ifdef
> > > > sections of code using inb()/outb() as alternative access methods.
> > > > 
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > 
> > > [snip]
> > > 
> > > > diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> > > > index 9c924a1440a9..2d2ae37153ba 100644
> > > > --- a/drivers/char/tpm/tpm_infineon.c
> > > > +++ b/drivers/char/tpm/tpm_infineon.c
> > > > @@ -51,34 +51,40 @@ static struct tpm_inf_dev tpm_dev;
> > > >  
> > > >  static inline void tpm_data_out(unsigned char data, unsigned char offset)
> > > >  {
> > > > +#ifdef CONFIG_HAS_IOPORT
> > > >       if (tpm_dev.iotype == TPM_INF_IO_PORT)
> > > >               outb(data, tpm_dev.data_regs + offset);
> > > >       else
> > > > +#endif
> > > 
> > > This looks ugly. Can't you declare inb/outb anyway and skip the definition,
> > > so you can use IS_ENABLED() here instead?
> > > 
> > > You can mark the declarations with __compiletime_error("some message"), so
> > > if an IS_ENABLED() reference is not removed at compile time, you get some
> > > readable error message instead of a link error.
> > > 
> > > Cheers,
> > > Ahmad
> > 
> > I didn't know about __compiletime_error() that certainly sounds
> > interesting even when using a normal #ifdef.
> > 
> > That said either with the function not being declared or this
> > __compiletime_error() mechanism I would think that using IS_ENABLED()
> > relies on compiler optimizations not to compile in the missing/error
> > function call, right? I'm not sure if that is something we should do.
> 
> Yes, it assumes your compiler is able to discard the body of an if (0),
> which we already assume, otherwise it wouldn't make sense for any existing
> code to use __compiletime_error().
> 
> To me this sounds much cleaner than #ifdefs in the midst of functions,
> which are a detriment to maintainability.
> 
> Cheers,
> Ahmad
> 

Ok, makes sense. I'll look into using __compiletime_error() and
IS_ENABLED().


