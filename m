Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A886CD79EC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfJOPhm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 15 Oct 2019 11:37:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52252 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfJOPhm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 11:37:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5B76460632FF;
        Tue, 15 Oct 2019 17:37:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RSIHUIs5bPXs; Tue, 15 Oct 2019 17:37:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C21F960632EE;
        Tue, 15 Oct 2019 17:37:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T3wxvxa3rLp7; Tue, 15 Oct 2019 17:37:37 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7EAF260632C6;
        Tue, 15 Oct 2019 17:37:37 +0200 (CEST)
Date:   Tue, 15 Oct 2019 17:37:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Message-ID: <879392618.23509.1571153857379.JavaMail.zimbra@nod.at>
In-Reply-To: <20191011115108.12392-14-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz> <20191011115108.12392-14-jslaby@suse.cz>
Subject: Re: [PATCH v9 13/28] um: Annotate data appropriately
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Annotate data appropriately
Thread-Index: gRNjB6YSPJT4xz32OxsfGpK8VELjCQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Jiri Slaby" <jslaby@suse.cz>
> An: bp@alien8.de
> CC: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Jiri Slaby" <jslaby@suse.cz>, "Jeff Dike" <jdike@addtoit.com>, "richard"
> <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
> Gesendet: Freitag, 11. Oktober 2019 13:50:53
> Betreff: [PATCH v9 13/28] um: Annotate data appropriately

> Use the new SYM_DATA_START and SYM_DATA_END_LABEL macros for vdso_start.
> 
> We get:
>  0000  2376 OBJECT  GLOBAL DEFAULT    4 vdso_start
>  0948     0 OBJECT  GLOBAL DEFAULT    4 vdso_end
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: user-mode-linux-user@lists.sourceforge.net
> ---
> arch/x86/um/vdso/vdso.S | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
> index a4a3870dc059..a6eaf293a73b 100644
> --- a/arch/x86/um/vdso/vdso.S
> +++ b/arch/x86/um/vdso/vdso.S
> @@ -1,11 +1,11 @@
> /* SPDX-License-Identifier: GPL-2.0 */
> #include <linux/init.h>
> +#include <linux/linkage.h>
> 
> __INITDATA
> 
> -	.globl vdso_start, vdso_end
> -vdso_start:
> +SYM_DATA_START(vdso_start)
> 	.incbin "arch/x86/um/vdso/vdso.so"
> -vdso_end:
> +SYM_DATA_END_LABEL(vdso_start, SYM_L_GLOBAL, vdso_end)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
