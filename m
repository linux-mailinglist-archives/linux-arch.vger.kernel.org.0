Return-Path: <linux-arch+bounces-8519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74B9AE0D6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF211F246CA
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F651B395D;
	Thu, 24 Oct 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JSoqJntJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BED1B394E;
	Thu, 24 Oct 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762291; cv=none; b=eOo2Tuc9X/+RCSWUNlyJuObD1uwchxo12JxOHZu24IGq8z9IV5soBvBilIb/G6a1fsjSC5Bg3dvVJvdoH6wUIDmSZOULKczoEDCd/066Xet/wNJEO99DTnVOhGPE7ASDcjSisxNBR1vZLHHlf4AHKYUjslsMnUZXVLYz//tt6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762291; c=relaxed/simple;
	bh=iJgps4A6Dt6TDZzBkBksjB0r8OfSsAkmp6iYgjJBW4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbdnQtBu7UdoFv5Zp9AkKY1PVsdev+13DuhzA7LzNDiAGHt+YTOFqnVUi0TMvel9KEpMFRUjHQIKudb5nElNpIPWuBuk6R7USPDu9uwlVthWxpqIoC9JIjVSYieREn2+BbkS6z/TmBOsKZS19Jm3YHLlluFJ1ijPNJAPg/ar0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JSoqJntJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O7X44G026963;
	Thu, 24 Oct 2024 09:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ad3G7t
	gT1LngrbCIX5zxplfREJhzCNpOY81vO9NiHaw=; b=JSoqJntJJMYj6dZwqdaVVU
	020F4AtcQvGN330K1KOAPMVgEeu+nDHuiJh5VgYMiIyIWfYxydU5vejx4VeEhicx
	ywEHKuPTrN/VxW9AsAlrfnkw+I8BJVgWo9qdLOykjrNhWK7BdewaDaVNTu+5zEzv
	/OUATsvFRaMqVDccpfSYGmSfhtCdcV0gQEnoWKJV6rRx7DSsShbCPprVX5U7Q7kC
	K60ljMe4HsbX69v7Hf5jvRo2tFHMK6sKJgEjtYQJEe3UP9LiNGRLFBQOnv/unHUS
	Sap4hmsjcpSkjGbE+LIaaFaZggd2kHmA4m3ZR+5XiQg8Y1EBqjHSQOMH30i385yg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnrjmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 09:30:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49O9UqU1015425;
	Thu, 24 Oct 2024 09:30:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnrjmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 09:30:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O6otaq014287;
	Thu, 24 Oct 2024 09:30:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfqptj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 09:30:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O9UmIP12452224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 09:30:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D14C2004B;
	Thu, 24 Oct 2024 09:30:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C3E20043;
	Thu, 24 Oct 2024 09:30:48 +0000 (GMT)
Received: from oc-fedora.boeblingen.de.ibm.com (unknown [9.152.212.119])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Oct 2024 09:30:48 +0000 (GMT)
Date: Thu, 24 Oct 2024 11:30:40 +0200
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v8 3/5] drm: handle HAS_IOPORT dependencies
Message-ID: <eptfarsehuuiulqz5523xu7h26jvb365rd3u5mx3mmubw74uld@53ebnpkpq6sc>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
 <20241008-b4-has_ioport-v8-3-793e68aeadda@linux.ibm.com>
 <64cc9c8f-fff3-4845-bb32-d7f1046ef619@suse.de>
 <a25086c4-e2fc-4ffc-bc20-afa50e560d96@app.fastmail.com>
 <aa679655-290e-4d19-9195-1a581431b9e6@suse.de>
 <892ba1e2f94a278813621a4872e841d66456e2f7.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <892ba1e2f94a278813621a4872e841d66456e2f7.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wJpB2cynEZVL7E3mkIzZ2ArKfrNnIlDQ
X-Proofpoint-GUID: Fwu-J5BH5WGsugJjHbEIa2RHlaLwjr2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240073

On Mon, Oct 21, 2024 at 01:18:20PM +0200, Niklas Schnelle wrote:
> On Mon, 2024-10-21 at 12:58 +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 21.10.24 um 12:08 schrieb Arnd Bergmann:
> > > On Mon, Oct 21, 2024, at 07:52, Thomas Zimmermann wrote:
> > > > Am 08.10.24 um 14:39 schrieb Niklas Schnelle:
> > > d 100644
> > > > > --- a/drivers/gpu/drm/qxl/Kconfig
> > > > > +++ b/drivers/gpu/drm/qxl/Kconfig
> > > > > @@ -2,6 +2,7 @@
> > > > >    config DRM_QXL
> > > > >    	tristate "QXL virtual GPU"
> > > > >    	depends on DRM && PCI && MMU
> > > > > +	depends on HAS_IOPORT
> > > > Is there a difference between this style (multiple 'depends on') and the
> > > > one used for gma500 (&& && &&)?
> > > No, it's the same. Doing it in one line is mainly useful
> > > if you have some '||' as well.
> > > 
> > > > > @@ -105,7 +106,9 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
> > > > >    
> > > > >    		writeb(val, bochs->mmio + offset);
> > > > >    	} else {
> > > > > +#ifdef CONFIG_HAS_IOPORT
> > > > >    		outb(val, ioport);
> > > > > +#endif
> > > > Could you provide empty defines for the out() interfaces at the top of
> > > > the file?
> > > That no longer works since there are now __compiletime_error()
> > > versions of these funcitons. However we can do it more nicely like:
> > > 
> > > diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> > > index 9b337f948434..034af6e32200 100644
> > > --- a/drivers/gpu/drm/tiny/bochs.c
> > > +++ b/drivers/gpu/drm/tiny/bochs.c
> > > @@ -112,14 +112,12 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
> > >   	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
> > >   		return;
> > >   
> > > -	if (bochs->mmio) {
> > > +	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
> > >   		int offset = ioport - 0x3c0 + 0x400;
> > >   
> > >   		writeb(val, bochs->mmio + offset);
> > >   	} else {
> > > -#ifdef CONFIG_HAS_IOPORT
> > >   		outb(val, ioport);
> > > -#endif
> > >   	}
> > 
> > For all functions with such a pattern, could we use:
> > 
> > bool bochs_uses_mmio(bochs)
> > {
> >      return !IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio
> > }
> > 
> > void writeb_func()
> > {
> >      if (bochs_uses_mmio()) {
> >        writeb()
> > #if CONFIG_HAS_IOPORT
> >      } else {
> >        outb()
> > #endif
> >      }
> > }
> > 
> 
> I think if the helper were __always_inline we could still take
> advantage of the dead code elimination and combine this with Arnd's
> approach. Though I feel like it is a bit odd to try to do the MMIO
> approach despite bochs->mmio being false on !HAS_IOPORT systems.
> Is that what you wanted to correct by keeping the #ifdef
> CONFIG_HAS_IOPORT around the else? And yes the warning makes sense to
> me too.

Working on this now, I think we don't need a warning in the bochs_uses_mmio()
helper because we should never get here with !IS_ENABLED(CONFIG_HAS_IOPORT)
at runtime thanks to the check added in bochs_hw_init(). This also takes
care of my original worry that we might try writeb()/readb() with an invalid
bochs->mmio value. I'll sent a v9 with the helper added and #ifdefs's removed.

Thanks,
Niklas

