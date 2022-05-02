Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D8516FD0
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiEBM5c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiEBM5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 08:57:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8120E02D;
        Mon,  2 May 2022 05:54:00 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242B0c2g029862;
        Mon, 2 May 2022 12:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vKlO1J51R/DR71p+466ESr0BxJukdjzhrBAJVcjEHmk=;
 b=aggi8Rou+TG54GUltFDkFKBwMbmJb3Rgd3G3SSdpADLyZENm2YKsFKS2JHxqUc0zK9bA
 Nqc2cDv2+n7KRNOsDZkKR8PjDzC4fNPK17OegFgqwX4dV0x8OV7CIy+z4g8d1VHXfU5+
 XPo7s2ajIAlkZzuZlZUFe6S6ndlgO+ER6TAEdg+PQ0oQXr1kV5G4HpAAgt/JD0JjAmDs
 MLq3OPNU+BVGxqak1vZGN/ccY5YW8Y0HhQDz26sNQ+xrOz+0piew2dVZBFwEDaYgvEzQ
 S9Lc4gks6MRzxqDqHlZGFwpZuLkj+d24B3/AA5QvpNvJMA6KidngftLxl3ZSuaUV+ToN tA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fte23t81k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 12:53:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 242CmkVJ008345;
        Mon, 2 May 2022 12:53:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3frvcj2qdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 12:53:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 242Crqpd24576298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 12:53:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3ED35204F;
        Mon,  2 May 2022 12:53:50 +0000 (GMT)
Received: from sig-9-145-11-74.uk.ibm.com (unknown [9.145.11.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 70B4A5204E;
        Mon,  2 May 2022 12:53:50 +0000 (GMT)
Message-ID: <1eeb5cdd40ccff8e27e55c230ff2cf04fe693fec.camel@linux.ibm.com>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Date:   Mon, 02 May 2022 14:53:50 +0200
In-Reply-To: <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-19-schnelle@linux.ibm.com>
         <Ymv3DnS1vPMY8QIg@fedora>
         <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
         <YmwGLrh4U+pVJo0m@fedora>
         <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hbIu12gf1MoLLQOICR1vgTsPxjeMW6ja
X-Proofpoint-ORIG-GUID: hbIu12gf1MoLLQOICR1vgTsPxjeMW6ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_04,2022-05-02_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=617 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 2022-05-01 at 23:55 +0200, Linus Walleij wrote:
> On Fri, Apr 29, 2022 at 5:37 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> > On Fri, Apr 29, 2022 at 04:46:00PM +0200, Niklas Schnelle wrote:
> > > Good question. As far as I can see most (all?) of these have "select
> > > ISA_BUS_API" which is "def_bool ISA". Now "config ISA" seems to
> > > currently be repeated in architectures and doesn't have an explicit
> > > HAS_IOPORT dependency (it maybe should have one). But it does only make
> > > sense on architectures with HAS_IOPORT set.
> > 
> > There is such a thing as ISA DMA, but you'll still need to initialize
> > the device via the IO Port bus first, so perhaps setting HAS_IOPORT for
> > "config ISA" is the right thing to do: all ISA devices are expected to
> > communicate in some way via ioport.
> 
> Adding that dependency seems like the right solution to me.
> 
> Yours,
> Linus Walleij

One thing I forgot to mention, config HAS_IOPORT does have a "def_bool
ISA" but yes I agree an explicit "depends on HAS_IOPORT" for ISA seems
more logical. I also haven't found issues trying this out locally so
far.

