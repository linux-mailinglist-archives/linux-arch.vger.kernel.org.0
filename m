Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FD1B4616
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDVNRe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 09:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVNRe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 09:17:34 -0400
Received: from linux-8ccs (p5B281662.dip0.t-ipconnect.de [91.40.22.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913B82084D;
        Wed, 22 Apr 2020 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587561453;
        bh=Qf1qqVQztfXcBNzGDIudLfhiiqlMgOrtdH1LSy4VbT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2UDQ43qhVG9ki82R10qKkY/DShwR7zJyvfvuAfLakBiNyCpvM+GIZTqeMW4U0ZlY
         1S5nBp19p+F1owu9tioMq7jQe48Je2o/AtZX8kRTS9g9BsTtR5cra6DUOcApRBe09x
         dtOZvjlcN/t8XN+WSdUhqNbZXDyOulfuq4JGcsPQ=
Date:   Wed, 22 Apr 2020 15:17:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] arch: split MODULE_ARCH_VERMAGIC definitions out to
 <asm/vermagic.h>
Message-ID: <20200422131729.GB20103@linux-8ccs>
References: <20200421161355.1357112-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200421161355.1357112-1-masahiroy@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Masahiro Yamada [22/04/20 01:13 +0900]:
[snip]
>diff --git a/arch/xtensa/include/asm/module.h b/arch/xtensa/include/asm/vermagic.h
>similarity index 72%
>rename from arch/xtensa/include/asm/module.h
>rename to arch/xtensa/include/asm/vermagic.h
>index 488b40c6f9b9..6f9e359a54ac 100644
>--- a/arch/xtensa/include/asm/module.h
>+++ b/arch/xtensa/include/asm/vermagic.h
>@@ -1,6 +1,4 @@
> /*
>- * include/asm-xtensa/module.h
>- *
>  * This file contains the module code specific to the Xtensa architecture.

Maybe we can remove this comment too? Since it's now asm/vermagic.h and
not asm/module.h anymore.

Thanks for the cleanup. I agree that <linux/vermagic.h> shouldn't have
any ordering dependency on <linux/module.h>.

I just double checked to see if there were any other users of
MODULE_ARCH_VERMAGIC that needed it through module.h, and there are
none. It was literally just being defined in asm/module.h to be used
in linux/vermagic.h. So there was no reason really to confine the
MODULE_ARCH_VERMAGIC definition to asm/module.h.

Acked-by: Jessica Yu <jeyu@kernel.org>
