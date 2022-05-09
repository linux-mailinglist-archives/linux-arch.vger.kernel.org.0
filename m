Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6551FB8B
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiEILra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 07:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiEILrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 07:47:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396A1ECBBB;
        Mon,  9 May 2022 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652096591; x=1683632591;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZTyA1HS8jeWS2uplJonrsTVm9m3xk+zuXOASyRBer64=;
  b=k79c/UL7bS5xE6bgFELpDjZw91MSdmyf2SNf4MUHE8y9gFAvXrj6TNe/
   gw82oy0tpfd3nMQSyeN8wgKdAMXP0foCg7exBi8roBxStp4Hiv2Gtbjn6
   0+XmMS/4hzbAo2pr38kpXZjIFl0gWzEFfeJdAT858lW9PGVUNMPrSY15p
   1eBeZ2T4lFjzmIRaYPaeTfdI+Cjw62EHLHOfxWsMwm5dYSoLkvpQQvupQ
   FDaIvWbSJHnnDH1CFS6MqFc7NeFAuQAln4KsDeAiLB/FA6D0klQxn6+oS
   N/HGnp+vBkZfPX6vTdsCicERTN+YoSQxtdFGW2Rt5VmdMfuUr8bk4UydT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="251069137"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="251069137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:43:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="591991357"
Received: from mfuent2x-mobl1.amr.corp.intel.com ([10.251.220.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:43:05 -0700
Date:   Mon, 9 May 2022 14:42:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Helge Deller <deller@gmx.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] termbits.h: create termbits-common.h for identical
 bits
In-Reply-To: <97b0e932-1309-edfd-3886-fee1498bff7d@gmx.de>
Message-ID: <8b407358-294-74ee-5659-f51d4598998@linux.intel.com>
References: <20220509093446.6677-1-ilpo.jarvinen@linux.intel.com> <20220509093446.6677-2-ilpo.jarvinen@linux.intel.com> <97b0e932-1309-edfd-3886-fee1498bff7d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1244401664-1652096590=:1620"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1244401664-1652096590=:1620
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 9 May 2022, Helge Deller wrote:

> Hello Ilpo,
> 
> On 5/9/22 11:34, Ilpo Järvinen wrote:
> > Some defines are the same across all archs. Move the most obvious
> > intersection to termbits-common.h.
> 
> I like your cleanup patches, but in this specific one, does it makes sense
> to split up together-belonging constants, e.g.
> 
> > diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
> > index 6017ee08f099..7f74a822b7ea 100644
> > --- a/arch/parisc/include/uapi/asm/termbits.h
> > +++ b/arch/parisc/include/uapi/asm/termbits.h
> > @@ -61,31 +61,15 @@ struct ktermios {
> >
> >
> >  /* c_iflag bits */
> > -#define IGNBRK	0x00001
> > -#define BRKINT	0x00002
> > -#define IGNPAR	0x00004
> > -#define PARMRK	0x00008
> > -#define INPCK	0x00010
> > -#define ISTRIP	0x00020
> > -#define INLCR	0x00040
> > -#define IGNCR	0x00080
> > -#define ICRNL	0x00100
> >  #define IUCLC	0x00200
> >  #define IXON	0x00400
> > -#define IXANY	0x00800
> >  #define IXOFF	0x01000
> >  #define IMAXBEL	0x04000
> >  #define IUTF8	0x08000
> 
> In the hunk above you leave IUCLC, IXON, IXOFF... because they seem unique to parisc.
> The other defines are then taken from generic header.
> Although this is correct, it leaves single values alone, which make it hard to verify
> because you don't see the full list of values in one place.

While I too am fine either way, I don't think these are as strongly 
grouped as you seem to imply. There's no big advantage in having as much 
as possible within the same file. If somebody is looking for the meaning 
of these, these headers are no match when compared e.g. with stty manpage.

For c_iflag, the break, parity and cr related "groups" within c_iflag are 
moving completely to common header.

IXANY is probably only one close to borderline whether it kind of belongs 
to the same group as IXON/IXOFF (which both by chance both remained on the 
same side in the split). I don't think it does strongly enough to warrant 
keeping them next to each other but I'm open what opinions others have on 
it.

The rest in c_iflag don't seem to be strongly tied/grouped to the other 
defines within c_iflag. They're just bits that appear next/close to each 
other but are not tied by any significant meaning-based connection.

C_oflag is more messy. I exercised grouping based judgement with c_oflag 
where only the defines with all bits as zero would have moved to the 
common header breaking the groups very badly. That is, only CR0 would have 
moved and CR1-3 remained in arch headers, etc. which made no sense to do. 
One could argue, that since ONLCR (and perhaps CRDLY) are not moving, no 
other cr related defines should move either.

> > @@ -112,24 +96,6 @@ struct ktermios {
> >
> >  /* c_cflag bit meaning */
> >  #define CBAUD		0x0000100f
> > -#define  B0		0x00000000	/* hang up */
> > -#define  B50		0x00000001
> > -#define  B75		0x00000002
> > -#define  B110		0x00000003
> > -#define  B134		0x00000004
> > -#define  B150		0x00000005
> > -#define  B200		0x00000006
> > -#define  B300		0x00000007
> > -#define  B600		0x00000008
> > -#define  B1200		0x00000009
> > -#define  B1800		0x0000000a
> > -#define  B2400		0x0000000b
> > -#define  B4800		0x0000000c
> > -#define  B9600		0x0000000d
> > -#define  B19200		0x0000000e
> > -#define  B38400		0x0000000f
> > -#define EXTA B19200
> > -#define EXTB B38400
> 
> Here all baud values are dropped and will be taken from generic header, 
> which is good. 
> 
> That said, I think it's good to move away the second hunk,
> but maybe we should keep the first as is?
> 
> It's just a thought. Either way, I'm fine your patch if that's the
> way which is decided to go for all platforms.

Yes, lets wait and see what the others think.

Thanks for taking a look!

-- 
 i.

--8323329-1244401664-1652096590=:1620--
