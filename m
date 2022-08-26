Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012395A2DB5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiHZRlc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbiHZRl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 13:41:29 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FF39C8C4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=5eX+7pFMy/DNEfDigZ6pNrp5YJzwtCFfct4ucHBv7/Q=;
        b=YEFzIcBVkGAVR+IhfGTs5RHnLKs0Z2bDrwL/NOaHnQwC12VjTLKZDdxzaUtW5Q+xAMsPziduQfOn0
         2jIg3FJBUn4DTDYfTPEKvl5/aGwsLofHc0eIMmdEcmBkf6YmWUfGZaUvR4Cm1aMeeQRpDzwc194yi0
         y9EcnoBfw5oCllM0TOjAtMzPPNQbjvoGdQDhnjV69Z4KaNFrOgYNgmGVXRhm0CrVeqN7sAVw/8dEt7
         JoErsfDHYNmSEHRUZ0MFo/B65TtRydKXhwbPexk99gt9+l5PlIELd90OnBwa0DeC08sZvRDBm4TM5g
         0d53uCf3qMOHoyhVGka3FRvQH/jXcmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=5eX+7pFMy/DNEfDigZ6pNrp5YJzwtCFfct4ucHBv7/Q=;
        b=8U1A9E3ty0om1/X6z0TcJwJl59j9ZMAjBa/XjgG9RtLpW6ZDBfzjU6BEJv4VGJ5AS7fRXrPT/J03R
         nXX1xCHCQ==
X-HalOne-Cookie: f32858e757181299f57d1acbda1c1fad1b331eb2
X-HalOne-ID: 4a1c93ad-2566-11ed-a920-d0431ea8a290
Received: from mailproxy4.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4a1c93ad-2566-11ed-a920-d0431ea8a290;
        Fri, 26 Aug 2022 17:41:18 +0000 (UTC)
Date:   Fri, 26 Aug 2022 19:41:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Conor.Dooley@microchip.com
Cc:     mail@conchuod.ie, monstr@monstr.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, geert@linux-m68k.org, keescook@chromium.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc: use the asm-generic version of cpuinfo_op
Message-ID: <YwkFvFiTdCccdSV8@ravnborg.org>
References: <20220821113512.2056409-1-mail@conchuod.ie>
 <20220821113512.2056409-6-mail@conchuod.ie>
 <Ywjc67hcBwOkMtI/@ravnborg.org>
 <87c83d38-18bc-7dfc-be6f-d906ed713450@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c83d38-18bc-7dfc-be6f-d906ed713450@microchip.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 03:37:40PM +0000, Conor.Dooley@microchip.com wrote:
> On 26/08/2022 15:47, Sam Ravnborg wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Conor.
> > 
> > Thanks for this nice simplification, but I think you can make it even
> > better.
> > 
> > On Sun, Aug 21, 2022 at 12:35:12PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> There's little point in duplicating the declaration of cpuinfo_op now
> >> that there's a shared version of it, so drop it & include the generic
> >> header.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  arch/sparc/include/asm/cpudata.h | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
> >> index d213165ee713..af6ef3c028a9 100644
> >> --- a/arch/sparc/include/asm/cpudata.h
> >> +++ b/arch/sparc/include/asm/cpudata.h
> >> @@ -6,8 +6,7 @@
> >>
> >>  #include <linux/threads.h>
> >>  #include <linux/percpu.h>
> >> -
> >> -extern const struct seq_operations cpuinfo_op;
> >> +#include <asm-generic/processor.h>
> > 
> > Since the header file did not need <asm-generic/processor.h> then it
> > should not need it now after deleting stuff.
> > The better fix is to add the missing include to arch/sparc/kernel/cpu.c,
> > where we have the user of it.
> > 
> > A header file should include what it needs, and no more.
> > 
> > I looked only at this patch, this comment may also be relevant for the
> > other patches.
> 
> Hey Sam, thanks for your feedback.
> As per Geert's suggestion, submitted a v2:
> https://lore.kernel.org/linux-riscv/20220825205942.1713914-1-mail@conchuod.ie/T/#u
> 
> In v2, I included linux/processor.h instead of an asm-generic header.
> The diff for sparc became:
> 
> diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
> index d213165ee713..f7e690a7860b 100644
> --- a/arch/sparc/include/asm/cpudata.h
> +++ b/arch/sparc/include/asm/cpudata.h
> @@ -7,8 +7,6 @@
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
>  
> -extern const struct seq_operations cpuinfo_op;
> -
>  #endif /* !(__ASSEMBLY__) */
>  
>  #if defined(__sparc__) && defined(__arch64__)
> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
> index 79cd6ccfeac0..ffdc7a825b80 100644
> --- a/arch/sparc/kernel/cpu.c
> +++ b/arch/sparc/kernel/cpu.c
> @@ -12,6 +12,7 @@
>  #include <linux/smp.h>
>  #include <linux/threads.h>
>  #include <linux/pgtable.h>
> +#include <linux/processor.h>
>  
>  #include <asm/spitfire.h>
>  #include <asm/oplib.h>
> 
> Hopefully that is more appealing to you!
> Thanks,
> Conor.

Hi Conor - much better. Thanks.

	Sam
