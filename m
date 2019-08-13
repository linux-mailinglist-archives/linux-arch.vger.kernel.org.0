Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B518B9BA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfHMNMw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 09:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfHMNMw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 09:12:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6292067D;
        Tue, 13 Aug 2019 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565701970;
        bh=L4V4NnUCcPwkaHDuIEzj1wBMHu2rN4+F8P2KbW0qMcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTiK1YkN0iFfcQd4shHsoKiVF/OhIISMCpuTLiTGe9E+xQeltJ7AcCGIfbp2WCogB
         u2DT4EcrhjTFu7WQYB/giay3KFFnIEK8gsgpgM9Pk3RknQpfAigaK//w01ZKYXM+go
         lyAlKlFL1ZemHIDcOh1IKMUykV5UOO/cFoLKMG1o=
Date:   Tue, 13 Aug 2019 15:12:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org,
        hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 09/10] usb-storage: remove single-use define for
 debugging
Message-ID: <20190813131248.GB16399@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-10-maennich@google.com>
 <20190813124259.GC14284@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813124259.GC14284@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 02:42:59PM +0200, Greg KH wrote:
> On Tue, Aug 13, 2019 at 01:17:06PM +0100, Matthias Maennich wrote:
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
> 
> I'll go take this today.  The module really should just be using
> dev_err() there.  It needs to be cleaned up :(

Now applied to the usb git tree, thanks.

greg k-h
