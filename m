Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C211097AEE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfHUNcr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 09:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfHUNcr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 09:32:47 -0400
Received: from localhost (unknown [12.166.174.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474082339F;
        Wed, 21 Aug 2019 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566394366;
        bh=gS9+Zgp02i/oPq20iw9CL1Rdtek7gUjyf68nwL7gH7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcNleWB00iIOV0x4il3pTwc83WqdjKhl3vUhDb/khQodLyep/4Ec2/W/N11QBlAqA
         jjqkPfioDTq0OzxRGn2QY7pEHvx0RuDmff8U9ERR/YmAA740FrTraYC7UAbLOKgx85
         oBtCuXpBL3hieVc5uvQNFHKKxm1Mv2VtYOKU2Rk4=
Date:   Wed, 21 Aug 2019 06:32:45 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 09/11] usb-storage: remove single-use define for
 debugging
Message-ID: <20190821133245.GA4624@kroah.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-10-maennich@google.com>
 <alpine.DEB.2.21.1908211520360.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908211520360.2223@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 21, 2019 at 03:21:22PM +0200, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Matthias Maennich wrote:
> 
> > USB_STORAGE was defined as "usb-storage: " and used in a single location
> > as argument to printk. In order to be able to use the name
> > 'USB_STORAGE', drop the definition and use the string directly for the
> > printk call.
> > 
> > Signed-off-by: Matthias Maennich <maennich@google.com>
> > ---
> >  drivers/usb/storage/debug.h    | 2 --
> >  drivers/usb/storage/scsiglue.c | 2 +-
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/storage/debug.h b/drivers/usb/storage/debug.h
> > index 6d64f342f587..16ce06039a4d 100644
> > --- a/drivers/usb/storage/debug.h
> > +++ b/drivers/usb/storage/debug.h
> > @@ -29,8 +29,6 @@
> >  
> >  #include <linux/kernel.h>
> >  
> > -#define USB_STORAGE "usb-storage: "
> > -
> >  #ifdef CONFIG_USB_STORAGE_DEBUG
> >  void usb_stor_show_command(const struct us_data *us, struct scsi_cmnd *srb);
> >  void usb_stor_show_sense(const struct us_data *us, unsigned char key,
> > diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> > index 05b80211290d..df4de8323eff 100644
> > --- a/drivers/usb/storage/scsiglue.c
> > +++ b/drivers/usb/storage/scsiglue.c
> > @@ -379,7 +379,7 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
> >  
> >  	/* check for state-transition errors */
> >  	if (us->srb != NULL) {
> > -		printk(KERN_ERR USB_STORAGE "Error in %s: us->srb = %p\n",
> > +		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
> >  			__func__, us->srb);
> 
> The proper fix for this is to use pr_fmt and convert the printk to pr_err().

Yeah, that's the correct long-term fix, I think someone already sent
that in for the usb tree, where I have taken this patch already.

thanks,

greg k-h
