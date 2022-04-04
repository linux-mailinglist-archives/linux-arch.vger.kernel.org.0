Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6574F11B1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348453AbiDDJMa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiDDJM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 05:12:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF202F382;
        Mon,  4 Apr 2022 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649063433; x=1680599433;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QqiEMALvxm0dsFsEQM+G8iM/nNOxk00l7kVM6nD9bW8=;
  b=ip4IK/Kz65GPYbS7B3tQML9YRAaTlXoahr+V5AZIYhkWW9/9bgZOzq4p
   40j04R1qFEMdckxTwxoLJZ8U2itWze56LHrq2BDWjUSnyXjxnc+1ke9w0
   DEjmKIhvMXKz3q/2ZoTfVjpvXfnYJ52JKocJoYuna+mqAt89zPKfolORo
   s5eImJyff5Oga1xNg0Q8mxAnDvOEoDUeEpt0DLejpFbL5ZbmBW9cVTH4r
   Fhwstbx3Hahw6CexOHXvj53Vb+iKCpH8M30wv0YsmuFhXrwZKWTMaBbeP
   awgM103wDaRf2/7G9PyTRCYoG+ZXYA0+LmQAtBT+tgVIBO4Y85p+GcR5j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323646112"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="323646112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 02:10:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569307128"
Received: from rhamza-mobl.ger.corp.intel.com ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 02:10:25 -0700
Date:   Mon, 4 Apr 2022 12:10:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 07/12] serial: termbits: ADDRB to indicate 9th bit
 addressing mode
In-Reply-To: <CAK8P3a0iP79RQWr6-YDf=xQZvonZchYN-Rn7HN2pkNihZ=anAw@mail.gmail.com>
Message-ID: <a05978b6-ed73-4ee-c688-e383b47c35d5@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com> <20220404082912.6885-8-ilpo.jarvinen@linux.intel.com> <CAK8P3a0iP79RQWr6-YDf=xQZvonZchYN-Rn7HN2pkNihZ=anAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1630404425-1649063432=:1675"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1630404425-1649063432=:1675
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 4 Apr 2022, Arnd Bergmann wrote:

> On Mon, Apr 4, 2022 at 10:29 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> 
> >
> >  #define CLOCAL 00100000
> > +#define ADDRB  010000000               /* address bit */
> >  #define CMSPAR   010000000000          /* mark or space (stick) parity */
> >  #define CRTSCTS          020000000000          /* flow control */
> >
> > diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
> > index dfeffba729b7..e7ea31cfec78 100644
> > --- a/arch/mips/include/uapi/asm/termbits.h
> > +++ b/arch/mips/include/uapi/asm/termbits.h
> > @@ -181,6 +181,7 @@ struct ktermios {
> >  #define         B3000000 0010015
> >  #define         B3500000 0010016
> >  #define         B4000000 0010017
> > +#define ADDRB    0020000       /* address bit */
> >  #define CIBAUD   002003600000  /* input baud rate */
> >  #define CMSPAR   010000000000  /* mark or space (stick) parity */
> >  #define CRTSCTS          020000000000  /* flow control */
> 
> It looks like the top bits are used the same way on all architectures
> already, while the bottom bits of the flag differ. Could you pick
> the next free bit from the top to use the same value 04000000000
> everywhere?

04000000000 isn't the top of the use:

diff --git a/arch/alpha/include/uapi/asm/termbits.h 
b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a0ea..285169c794ec 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -178,10 +178,11 @@ struct ktermios {
 #define PARENB 00010000
 #define PARODD 00020000
 #define HUPCL  00040000
 
 #define CLOCAL 00100000
+#define ADDRB  010000000               /* address bit */
 #define CMSPAR   010000000000          /* mark or space (stick) parity */
 #define CRTSCTS          020000000000          /* flow control */
 
 #define CIBAUD 07600000
 #define IBSHIFT        16
diff --git a/arch/sparc/include/uapi/asm/termbits.h 
b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..4ad60c4acf65 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -198,10 +198,11 @@ struct ktermios {
    adjust CBAUD constant and drivers accordingly.
 #define B4000000  0x00001013  */
+#define ADDRB    0x00002000  /* address bit */
 #define CIBAUD   0x100f0000  /* input baud rate (not used) */
 #define CMSPAR   0x40000000  /* mark or space (stick) parity */
 #define CRTSCTS          0x80000000  /* flow control */


Somehow I managed to convince myself earlier there isn't a bit available 
that would be consistent across archs but now that I recheck the 
04000000000 bit (0x20000000) you propose, it seems to be that nothing is 
using it.

It's not suprising I didn't get the magnitude of those long octal numbers 
right. ...They are such a pain to interpret correctly.


-- 
 i.

--8323329-1630404425-1649063432=:1675--
