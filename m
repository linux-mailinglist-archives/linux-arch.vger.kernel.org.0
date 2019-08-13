Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3F8BD0C
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfHMP1R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 11:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfHMP1R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 11:27:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A59920663;
        Tue, 13 Aug 2019 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565710036;
        bh=HKhJdQ9xC644Yyxr4Mc48vaFAU0qEox8cqu8XFFdUAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9wRRvwg4CR0ZqATaS40VxceJXh+XAOEDYDVGMbuXihVxvIUQkOS08JVRAP6YHPxs
         A60yBGejcNuFmn8CkV42ZGdG1mqrkf0dRFpXdsxC/TzSQwKAYgmXAuzsoA8n9D7t+N
         9OZC8T3G5xnbzlqoLfgZRrVbg+EbQJmI3PlIRXe8=
Date:   Tue, 13 Aug 2019 17:27:14 +0200
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
Subject: Re: [PATCH v2 04/10] modpost: add support for symbol namespaces
Message-ID: <20190813152714.GC26138@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-5-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-5-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:17:01PM +0100, Matthias Maennich wrote:
> Add support for symbols that are exported into namespaces. For that,
> extract any namespace suffix from the symbol name. In addition, emit a
> warning whenever a module refers to an exported symbol without
> explicitly importing the namespace that it is defined in. This patch
> consistently adds the namespace suffix to symbol names exported into
> Module.symvers.
> 
> Example warning emitted by modpost in case of the above violation:
> 
>  WARNING: module ums-usbat uses symbol usb_stor_resume from namespace
>  USB_STORAGE, but does not import it.
> 
> Co-developed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  scripts/mod/modpost.c | 91 +++++++++++++++++++++++++++++++++++++------
>  scripts/mod/modpost.h |  7 ++++
>  2 files changed, 87 insertions(+), 11 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
