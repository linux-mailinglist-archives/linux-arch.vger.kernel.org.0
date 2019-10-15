Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE0D7CDA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfJOREF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 13:04:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfJOREE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 13:04:04 -0400
Received: from zn.tnic (p200300EC2F157800C5C9C957E5FD72EA.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7800:c5c9:c957:e5fd:72ea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2DDD1EC0C9F;
        Tue, 15 Oct 2019 19:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571159043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qR2t1iMXW4bUkgiQHzxnZJRfCBt9ULeZhd361Oh91pM=;
        b=keQCmIX4iS+qq8uKycuIVqAST76xg3kWFU4/8cCFLfflrjthTRHzcbl9pfV2yUY3Z+g+me
        2dqXPBoTwBHVrtlH8YYs2M0+UuiweCN6CoRMXkOZBL/9A7TaZgFfNaRJKqF4udkGSRC0IC
        4tmbiZB6VrAtSi09rCTx5wQd17tivWI=
Date:   Tue, 15 Oct 2019 19:03:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 15/28] x86/asm/purgatory: Start using annotations
Message-ID: <20191015170358.GE596@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-16-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-16-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:55PM +0200, Jiri Slaby wrote:
> Purgatory used no annotations at all. So include linux/linkage.h and
> annotate everything:
> * code by SYM_CODE_*
> * data by SYM_DATA_*
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/purgatory/entry64.S      | 21 ++++++++++++---------
>  arch/x86/purgatory/setup-x86_64.S | 14 ++++++++------
>  arch/x86/purgatory/stack.S        |  7 ++++---
>  3 files changed, 24 insertions(+), 18 deletions(-)

...

> @@ -75,12 +76,12 @@ r13:	.quad 0x0
>  r14:	.quad 0x0
>  r15:	.quad 0x0
>  rip:	.quad 0x0
> -	.size entry64_regs, . - entry64_regs
> +SYM_DATA_END(entry64_regs)
>  
>  	/* GDT */
>  	.section ".rodata"
>  	.balign 16
> -gdt:
> +SYM_DATA_START_LOCAL(gdt)
>  	/* 0x00 unusable segment

Note for the applier: Fixup that comment:

	/*
	 * 0x00 ...
	 * ...

>  	 * 0x08 unused
>  	 * so use them as gdt ptr

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
