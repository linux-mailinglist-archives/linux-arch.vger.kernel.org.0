Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4738C07D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfHMSVz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 14:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbfHMSVz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 14:21:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D1620578;
        Tue, 13 Aug 2019 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565720513;
        bh=Dl34f7AwP7olgqWclvkI5Nt8ce/2dgPR8Fqz5ci/QjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgmMjKHQ5IxNR5ueegGGB4JR79SBhElL0fzwmVq83V92rDggRVL6Krswzw6GlYtgW
         Y8ChjTRBhadSgEAdb2Pz8sDDyz1AfLe04PIF/F3ccWIhoCdQlbHwrI3fswdXPPMSom
         1XmlYPAW73VsWZ8kEw7P5FfFyuTeAfuSu5/MYRio=
Date:   Tue, 13 Aug 2019 20:21:51 +0200
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
Subject: Re: [PATCH v2 07/10] modpost: add support for generating namespace
 dependencies
Message-ID: <20190813182151.GF2378@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-8-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-8-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:17:04PM +0100, Matthias Maennich wrote:
> This patch adds an option to modpost to generate a <module>.ns_deps file
> per module, containing the namespace dependencies for that module.
> 
> E.g. if the linked module my-module.ko would depend on the symbol
> myfunc.MY_NS in the namespace MY_NS, the my-module.ns_deps file created
> by modpost would contain the entry MY_NS to express the namespace
> dependency of my-module imposed by using the symbol myfunc.
> 
> These files can subsequently be used by static analysis tools (like
> coccinelle scripts) to address issues with missing namespace imports. A
> later patch of this series will introduce such a script 'nsdeps' and a
> corresponding make target to automatically add missing
> MODULE_IMPORT_NS() definitions to the module's sources. For that it uses
> the information provided in the generated .ns_deps files.
> 
> Co-developed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  scripts/mod/modpost.c | 61 +++++++++++++++++++++++++++++++++++++++----
>  scripts/mod/modpost.h |  2 ++
>  2 files changed, 58 insertions(+), 5 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
