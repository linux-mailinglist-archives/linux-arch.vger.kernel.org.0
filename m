Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF65597994
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfHUMhW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 08:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHUMhW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 08:37:22 -0400
Received: from localhost (unknown [12.166.174.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3C22089E;
        Wed, 21 Aug 2019 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566391041;
        bh=sQtc99n9rRVj8D9SFfy24t3qFQlV+7rKUNuVbRXs2Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zvQJ/1pwLq4AnhKEGIvvGaPF0Li5LSZSjzUGFx0viyRSwCik522s2wjgIHXBXKcr
         hHqFRhr8K+C5+X9suJ4rd2Ea62nBiQCc861xei+lorhE/g8U8TlxVfBCBYd9MDkQXh
         tWaU7R/YY8+3fEgL5goOhw2WcLaeTXsglmjMb2Lk=
Date:   Wed, 21 Aug 2019 05:37:20 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 09/11] usb-storage: remove single-use define for
 debugging
Message-ID: <20190821123720.GA4059@kroah.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-10-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821114955.12788-10-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 21, 2019 at 12:49:24PM +0100, Matthias Maennich wrote:
> USB_STORAGE was defined as "usb-storage: " and used in a single location
> as argument to printk. In order to be able to use the name
> 'USB_STORAGE', drop the definition and use the string directly for the
> printk call.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>

As you know, this patch is already in the usb-next tree, and will be in
the 5.4-rc1 merge.

But, as this series will end up going through a different tree than the
usb tree, here's my reviewed-by so that it can be included with the rest
of these patches:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
