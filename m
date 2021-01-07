Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4612ED038
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 13:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAGMtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 07:49:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:57650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbhAGMtQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jan 2021 07:49:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610023708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3fsgJ4y1qrIo5WUjYDZW5qHVTbkdAXEHQARuQrTSQA=;
        b=l12sFVAYH+BxrN7h9cAZo1z18t+ytiRNq8XfT1CuTlVXqSX39LNptAduSG/4POUTvSWBUR
        ybQxpwK4KmW3/8V/qu3dmgAchq/w5TY2kfDWOk2ESOJxqkQrQgMN2vJbbbOR1/1i4XaDMl
        oHsTa71UqqoZ753ZAIIy9TiQzI/3E6M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D231ACAF;
        Thu,  7 Jan 2021 12:48:28 +0000 (UTC)
Date:   Thu, 7 Jan 2021 13:48:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, buildroot@busybox.net,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arch@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use
 ttynull as a fallback when there is no console)
Message-ID: <X/cDG/xCCzSWW2cd@alley>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed 2021-01-06 15:36:36, Vineet Gupta wrote:
> +CC Buildroot folks
> 
> Hi Petr,
> 
> On 11/11/20 5:54 AM, Petr Mladek wrote:
> > stdin, stdout, and stderr standard I/O stream are created for the init
> > process. They are not available when there is no console registered
> > for /dev/console. It might lead to a crash when the init process
> > tries to use them, see the commit 48021f98130880dd742 ("printk: handle
> > blank console arguments passed in.").
> > 
> > Normally, ttySX and ttyX consoles are used as a fallback when no consoles
> > are defined via the command line, device tree, or SPCR. But there
> > will be no console registered when an invalid console name is configured
> > or when the configured consoles do not exist on the system.
> > 
> > Users even try to avoid the console intentionally, for example,
> > by using console="" or console=null. It is used on production
> > systems where the serial port or terminal are not visible to
> > users. Pushing messages to these consoles would just unnecessary
> > slowdown the system.
> > 
> > Make sure that stdin, stdout, stderr, and /dev/console are always
> > available by a fallback to the existing ttynull driver. It has
> > been implemented for exactly this purpose but it was used only
> > when explicitly configured.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
> >   	struct file *file = filp_open("/dev/console", O_RDWR, 0);
> >   	if (IS_ERR(file)) {
> > -		pr_err("Warning: unable to open an initial console.\n");
> > -		return;
> > +		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> > +		register_ttynull_console();
> > +
> > +		file = filp_open("/dev/console", O_RDWR, 0);
> > +		if (IS_ERR(file)) {
> > +			pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
> > +			return;
> > +		}
> 
> 
> This breaks ARC booting (no output on console).

This is likely the same problem as with kunit and um kernels.
It is being discussed at
https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/#t

We have several workarounds. I am still squashing my head about the
right solution. The console registration code is like a vasps' nest.
It is always a pain when we touch it.

I hope that I will send a patchset for review later today.
In the worst case, we will revert the patch in the mainline.

> Our Buildroot based setup has dynamic /dev where /dev/console doesn't exist
> statically and there's a primoridla /init shell script which does following
> 
> /bin/mount -t devtmpfs devtmpfs /dev
> exec 0</dev/console
> exec 1>/dev/console
> exec 2>/dev/console
> exec /sbin/init "$@"
> 
> Buildroot has had this way of handling missing /dev/console since 2011 [1]
> and [2].

Good to know.

> Please advise what needs to be done to unbork boot. Otherwise this seems
> like a kernel change which breaks user-space and needs to be backed-out (or
> perhaps conditionalize on CONFIG_NULL_TTY. I'm surprised it hasn't been
> reported by any other  embedded folks

Two workarounds can be fount at
https://lore.kernel.org/linux-kselftest/X%2FSYhBZyudfnKY1u@alley/
https://lore.kernel.org/linux-kselftest/X%2FW2sl7RMvfaV4Ru@alley/

But I still see them as only a partial solutiuon. I still another sources
of potential problems.

Best Regards,
Petr
