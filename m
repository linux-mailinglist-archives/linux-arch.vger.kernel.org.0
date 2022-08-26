Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93C5A29FA
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiHZOs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbiHZOsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 10:48:17 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 07:48:14 PDT
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED79D8E08
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=pzSEnzVb4PRuwPohD2SDHsa5KY0tRkBlHuhkY0oHs0w=;
        b=NCRe3O/xZCHJ8hDEpD57d6zrmZ/D/l0pxGva3S+GafoGTaEBI8V+8dRJcau2lXRHDYLk3R1tpxP1j
         3KhToFhOZVyitlnJ0xRfBBHfLRdUC92ngLyYi8++VZngl+6FIPMMSswvmOKlwmrA48SEArDfjlrrZp
         aLUYNtoPbfHie2QZuWN/5gmc96n89BeYnrY4HhmXJ0VYbMK/Nwimvglfg4ZslyKY8HJv9B0kGS+jUd
         iAj6qBZTfiE8K/3fT3d5xnIszRsKWAcgiOTrubWRizGAPwPa3VkkroaVH+3Yp57Mf7SsdGZtyGg98g
         yEaoCAI90mioch8sotzXt8Sz2DOGFiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=pzSEnzVb4PRuwPohD2SDHsa5KY0tRkBlHuhkY0oHs0w=;
        b=czLkABglyklPhRImctvsIg7tPPnc0HaIPVvkP1cQzOjoIxLxHBn86D/l7MTIWNazZ6K+XJ8mOPOkH
         5qB81ZOBw==
X-HalOne-Cookie: f226e6ab43f82fd861952f49718ba8a608aa1fbd
X-HalOne-ID: f6029a30-254d-11ed-a920-d0431ea8a290
Received: from mailproxy3.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id f6029a30-254d-11ed-a920-d0431ea8a290;
        Fri, 26 Aug 2022 14:47:09 +0000 (UTC)
Date:   Fri, 26 Aug 2022 16:47:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Michal Simek <monstr@monstr.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc: use the asm-generic version of cpuinfo_op
Message-ID: <Ywjc67hcBwOkMtI/@ravnborg.org>
References: <20220821113512.2056409-1-mail@conchuod.ie>
 <20220821113512.2056409-6-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821113512.2056409-6-mail@conchuod.ie>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Conor.

Thanks for this nice simplification, but I think you can make it even
better.

On Sun, Aug 21, 2022 at 12:35:12PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> There's little point in duplicating the declaration of cpuinfo_op now
> that there's a shared version of it, so drop it & include the generic
> header.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/sparc/include/asm/cpudata.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
> index d213165ee713..af6ef3c028a9 100644
> --- a/arch/sparc/include/asm/cpudata.h
> +++ b/arch/sparc/include/asm/cpudata.h
> @@ -6,8 +6,7 @@
>  
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
> -
> -extern const struct seq_operations cpuinfo_op;
> +#include <asm-generic/processor.h>

Since the header file did not need <asm-generic/processor.h> then it
should not need it now after deleting stuff.
The better fix is to add the missing include to arch/sparc/kernel/cpu.c,
where we have the user of it.

A header file should include what it needs, and no more.

I looked only at this patch, this comment may also be relevant for the
other patches.

	Sam
