Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8981BB5E5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 07:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgD1Fbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 01:31:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9824 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgD1Fbt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 01:31:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49B9Hj705jz9txnl;
        Tue, 28 Apr 2020 07:31:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=p1+bx80w; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ksRWT-6LYTV5; Tue, 28 Apr 2020 07:31:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49B9Hj5L7cz9txmQ;
        Tue, 28 Apr 2020 07:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588051905; bh=L/I6FeppBWpytvPm4oLmvPFKe0s8OVyCqzSRbHYYSwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p1+bx80wcRg8QTc6C/G0PB6UfZDDwQGE+E9ltF+Gz7R7CZqDcbQz3HdXV5QLHk1Zw
         cVwbahXd2lQqVPNIpwx1ag1juZEY/QbIZwAB0i113g+NZ7ygK9wze7riYxxrc6AzWI
         KOSGOsxnVKoIClMQny4CDgGezzrgtXeynjxMT2RE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A189D8B7C5;
        Tue, 28 Apr 2020 07:31:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hZ80UDZ0lPgq; Tue, 28 Apr 2020 07:31:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6D078B75F;
        Tue, 28 Apr 2020 07:31:45 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc: Discard .rela* sections if
 CONFIG_RELOCATABLE is undefined
To:     "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Mackerras <paulus@samba.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>, linuxppc-dev@lists.ozlabs.org
References: <20200428014900.407098-1-hjl.tools@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <55518443-1ab4-1961-beb5-43e9e41e3227@c-s.fr>
Date:   Tue, 28 Apr 2020 07:31:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428014900.407098-1-hjl.tools@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Le 28/04/2020 à 03:48, H.J. Lu a écrit :
> arch/powerpc/kernel/vmlinux.lds.S has
> 
>          DISCARDS
>          /DISCARD/ : {
>                  *(*.EMB.apuinfo)
>                  *(.glink .iplt .plt .rela* .comment)
>                  *(.gnu.version*)
>                  *(.gnu.attributes)
>                  *(.eh_frame)
>          }
> 
> Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
> change to discard .rela* sections if CONFIG_RELOCATABLE is undefined.

Your explanation and especially the subject are unclear.

 From the subject you understand that you are adding a discard of the 
.rela* sections if CONFIG_RELOCATABLE is undefined.

But when reading the patch, you see that it is the contrary: you are 
removing a discard of the .rela* sections if CONFIG_RELOCATABLE is defined.


So I think the subject could instead be:

	Only discard .rela* sections when CONFIG_RELOCATABLE is undefined

Or maybe better:

	Keep .rela* sections when CONFIG_RELOCATABLE is defined

And the explanation could be:

	Since .rela* sections are needed when CONFIG_RELOCATABLE
	is defined, don't discard .rela* sections if
	CONFIG_RELOCATABLE is defined.

> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> ---
>   arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 31a0f201fb6f..4ba07734a210 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -366,9 +366,12 @@ SECTIONS
>   	DISCARDS
>   	/DISCARD/ : {
>   		*(*.EMB.apuinfo)
> -		*(.glink .iplt .plt .rela* .comment)
> +		*(.glink .iplt .plt .comment)
>   		*(.gnu.version*)
>   		*(.gnu.attributes)
>   		*(.eh_frame)
> +#ifndef CONFIG_RELOCATABLE
> +		*(.rela*)
> +#endif
>   	}
>   }
> 

Christophe
