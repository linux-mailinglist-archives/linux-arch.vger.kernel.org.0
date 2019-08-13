Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74E8B8BB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfHMMlB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfHMMlB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 08:41:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C82A20578;
        Tue, 13 Aug 2019 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565700060;
        bh=4k7N09FoQBbpkYUEeWsjRJWSOm77Guc4jfbrqH/pxHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8LZIj8Av9JLAkSr1LW6vj56zCTVtSzC3Z6bjx9Lb+ozorlC7bPGyHFqNzVQ0xj+m
         IKzAZax6AqqhPECqlrUlXgkCeruOmr09VeAxx6zuVvD8dChLo8HxzX8YYTbh/rdLRx
         KzfV77fMgsAapcsqGoNWtO9i1ObkQxvV/LleGZQE=
Date:   Tue, 13 Aug 2019 14:40:57 +0200
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
Subject: Re: [PATCH v2 01/10] module: support reading multiple values per
 modinfo tag
Message-ID: <20190813124057.GA14284@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-2-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-2-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:16:58PM +0100, Matthias Maennich wrote:
> Similar to modpost's get_next_modinfo(), introduce get_next_modinfo() in
> kernel/module.c to acquire any further values associated with the same
> modinfo tag name. That is useful for any tags that have multiple
> occurrences (such as 'alias'), but is in particular introduced here as
> part of the symbol namespaces patch series to read the (potentially)
> multiple namespaces a module is importing.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
