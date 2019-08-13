Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6B8B903
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfHMMrM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfHMMrM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 08:47:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834E920578;
        Tue, 13 Aug 2019 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565700431;
        bh=BiEA9fjKc3dKtMJNhv4RcmljM8dSb5LNtQ4cws/6LXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vHS1eayY4MYBdvrsWrCmrF1BYhN4EqmL8NrDPkmiJwtjC9B8pj1EFBRk3aYNxQYW
         8LKA/4SCESx9XxS5V53BB14XeilVF/857yTsLI0bzZ6gSPMfRM1o9okBbzxADRmGuR
         +kw8tqTbwsw8kzB0Amwee4BILkyJtLdZDkeRvtwI=
Date:   Tue, 13 Aug 2019 14:47:08 +0200
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
Subject: Re: [PATCH v2 10/10] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190813124708.GC12475@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-11-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-11-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:17:07PM +0100, Matthias Maennich wrote:
> Modules using these symbols are required to explicitly import the
> namespace. This patch was generated with the following steps and serves
> as a reference to use the symbol namespace feature:
> 
>  1) Define DDEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>  2) make  (see warnings during modpost about missing imports)
>  3) make nsdeps
> 
> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
> variants can be used to explicitly specify the namespace. The advantage
> of the method used here is that newly added symbols are automatically
> exported and existing ones are exported without touching their
> respective EXPORT_SYMBOL macro expansion.

Ok, I can't read text, this answers my previous question.

But, as an example, shouldn't we also have some code here that uses the
EXPORT_SYMBOL_NS() macro to ensure that it actually works?

thanks,

greg k-h
