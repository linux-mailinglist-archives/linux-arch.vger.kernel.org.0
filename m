Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A391997D2D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfHUOhG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 10:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfHUOhG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 10:37:06 -0400
Received: from linux-8ccs (ip5f5ade6e.dynamic.kabel-deutschland.de [95.90.222.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C2C206BA;
        Wed, 21 Aug 2019 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566398225;
        bh=LLHM3HLNnSTk9CIZqdIrW76ESIQASTQvj9y7JVMhEwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tX0ldqZERDP4xQ8nTag6pfFnc82CxILalGtaetxbHG8xXXzAIW0JIHVE3CJGb/4E/
         EMjrjUGonCrYNoOy6eDoS609WwM0Ddr/MJYcXij1vlsZAS6fj2xJ0YB3fwrJmrZor9
         QEX8ufh6sVHXovTET4evmeAPBDKEozvv0a7cSA5A=
Date:   Wed, 21 Aug 2019 16:36:55 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com,
        joel@joelfernandes.org, kstewart@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        lucas.de.marchi@gmail.com, maco@android.com, maco@google.com,
        michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com,
        pombredanne@nexb.com, sam@ravnborg.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 10/11] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190821143655.GA13637@linux-8ccs>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-11-maennich@google.com>
 <20190821123827.GB4059@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821123827.GB4059@kroah.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Greg KH [21/08/19 05:38 -0700]:
>On Wed, Aug 21, 2019 at 12:49:25PM +0100, Matthias Maennich wrote:
>> Modules using these symbols are required to explicitly import the
>> namespace. This patch was generated with the following steps and serves
>> as a reference to use the symbol namespace feature:
>>
>>  1) Define DEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>>  2) make  (see warnings during modpost about missing imports)
>>  3) make nsdeps
>>
>> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
>> variants can be used to explicitly specify the namespace. The advantage
>> of the method used here is that newly added symbols are automatically
>> exported and existing ones are exported without touching their
>> respective EXPORT_SYMBOL macro expansion.
>>
>> Signed-off-by: Matthias Maennich <maennich@google.com>
>
>This looks good to me.  This can be included with the rest of this
>series when/if it goes through the kbuild or module tree:
>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>Actually, which tree will this be going through?

I would be happy to take the patchset through the modules tree once it
collects the appropriate ack/reviewed-by's and once I get a chance to
sit down and review/test it next week :)

Thanks!

Jessica
