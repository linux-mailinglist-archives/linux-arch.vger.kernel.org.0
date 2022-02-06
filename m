Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623834AB0D4
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiBFRJr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 12:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiBFRJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 12:09:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1056C06173B;
        Sun,  6 Feb 2022 09:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46609CE0DAF;
        Sun,  6 Feb 2022 17:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B199BC340E9;
        Sun,  6 Feb 2022 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644167382;
        bh=PPbNG5fmfqWCiX5JD0R+wVYBnW27nFjoMGlmUI9GqcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1Vq0bswugrIIVt1NcP4G0M3SzYsegwJ+hGStHbC8sx8+/rayHkVmg9ehCGPWEojy
         +ZBI/c2VKn5o83yWzyBlgIzD9cF3yIb0hojVC4StZ96Muse6a7zGVQ1V80daR6Bdnm
         gSTdwnOQP+jcGvxucliytsQWfQDFfumxPJBfG4/s=
Date:   Sun, 6 Feb 2022 18:09:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Walt Drummond <walt@drummond.us>
Cc:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, chris@zankel.net, davem@davemloft.net,
        hca@linux.ibm.com, deller@gmx.de, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jirislaby@kernel.org,
        mattst88@gmail.com, jcmvbkbc@gmail.com, mpe@ellerman.id.au,
        paulus@samba.org, rth@twiddle.net, dalias@libc.org,
        tsbogend@alpha.franken.de, gor@linux.ibm.com, ysato@users.osdn.me,
        linux-kernel@vger.kernel.org, ar@cs.msu.ru,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 2/3] status: Add user space API definitions for
 VSTATUS, NOKERNINFO and TIOCSTAT
Message-ID: <YgAAx3OQPAC1+fws@kroah.com>
References: <20220206154856.2355838-1-walt@drummond.us>
 <20220206154856.2355838-3-walt@drummond.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206154856.2355838-3-walt@drummond.us>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 06, 2022 at 07:48:53AM -0800, Walt Drummond wrote:
> Add definitions for the VSTATUS control character, and the NOKERNINFO
> local control flag in the termios struct, and add an ioctl number for
> the ioctl TIOCSTAT.  Also add a default VSTATUS character (Ctrl-T)
> default valuses in termios.c_cc.  Do this for all architectures.
> 
> Signed-off-by: Walt Drummond <walt@drummond.us>
> ---
>  arch/alpha/include/asm/termios.h         | 4 ++--
>  arch/alpha/include/uapi/asm/ioctls.h     | 1 +
>  arch/alpha/include/uapi/asm/termbits.h   | 2 ++
>  arch/ia64/include/asm/termios.h          | 4 ++--
>  arch/ia64/include/uapi/asm/termbits.h    | 2 ++
>  arch/mips/include/asm/termios.h          | 4 ++--
>  arch/mips/include/uapi/asm/ioctls.h      | 1 +
>  arch/mips/include/uapi/asm/termbits.h    | 2 ++
>  arch/parisc/include/asm/termios.h        | 4 ++--
>  arch/parisc/include/uapi/asm/ioctls.h    | 1 +
>  arch/parisc/include/uapi/asm/termbits.h  | 2 ++
>  arch/powerpc/include/asm/termios.h       | 4 ++--
>  arch/powerpc/include/uapi/asm/ioctls.h   | 2 ++
>  arch/powerpc/include/uapi/asm/termbits.h | 2 ++
>  arch/s390/include/asm/termios.h          | 4 ++--
>  arch/sh/include/uapi/asm/ioctls.h        | 1 +
>  arch/sparc/include/uapi/asm/ioctls.h     | 1 +
>  arch/sparc/include/uapi/asm/termbits.h   | 2 ++
>  arch/xtensa/include/uapi/asm/ioctls.h    | 1 +
>  include/asm-generic/termios.h            | 4 ++--
>  include/uapi/asm-generic/ioctls.h        | 1 +
>  include/uapi/asm-generic/termbits.h      | 2 ++
>  22 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
> index b7c77bb1bfd2..d28ddc649286 100644
> --- a/arch/alpha/include/asm/termios.h
> +++ b/arch/alpha/include/asm/termios.h
> @@ -8,9 +8,9 @@
>  	werase=^W	kill=^U		reprint=^R	sxtc=\0
>  	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
>  	start=^Q	stop=^S		lnext=^V	discard=^U
> -	vmin=\1		vtime=\0
> +	vmin=\1		vtime=\0        status=^T
>  */
> -#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
> +#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000\024"
>  
>  /*
>   * Translate a "termio" structure into a "termios". Ugh.
> diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
> index 971311605288..70fdeab2b5f2 100644
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -124,5 +124,6 @@
>  
>  #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
>  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> +#define TIOCSTAT	_IO('T', 0x5E)	/* display process group stats on tty */
>  
>  #endif /* _ASM_ALPHA_IOCTLS_H */
> diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
> index 4575ba34a0ea..9a1b9aa92d29 100644
> --- a/arch/alpha/include/uapi/asm/termbits.h
> +++ b/arch/alpha/include/uapi/asm/termbits.h
> @@ -70,6 +70,7 @@ struct ktermios {
>  #define VDISCARD 15
>  #define VMIN 16
>  #define VTIME 17
> +#define VSTATUS 18
>  
>  /* c_iflag bits */
>  #define IGNBRK	0000001
> @@ -203,6 +204,7 @@ struct ktermios {
>  #define PENDIN	0x20000000
>  #define IEXTEN	0x00000400
>  #define EXTPROC	0x10000000
> +#define NOKERNINFO 0x40000000

Here, and elsewhere, you seem to mix tabs and spaces.  Please use what
is in the original file (tabs here.)

>  /* Values for the ACTION argument to `tcflow'.  */
>  #define	TCOOFF		0
> diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
> index 589c026444cc..40e83f9b6ead 100644
> --- a/arch/ia64/include/asm/termios.h
> +++ b/arch/ia64/include/asm/termios.h
> @@ -15,9 +15,9 @@
>  	eof=^D		vtime=\0	vmin=\1		sxtc=\0
>  	start=^Q	stop=^S		susp=^Z		eol=\0
>  	reprint=^R	discard=^U	werase=^W	lnext=^V
> -	eol2=\0
> +	eol2=\0         status=^T

Same here.  And for the other files in this patch.  Let's keep them
unified please.

thanks,

greg k-h
