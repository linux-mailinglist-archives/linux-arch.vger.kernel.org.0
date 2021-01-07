Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC47B2ED383
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbhAGP2q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 10:28:46 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:22304 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbhAGP2q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jan 2021 10:28:46 -0500
Received: from ymorin.is-a-geek.org (unknown [IPv6:2a01:cb19:8b51:cb00:e49b:7e99:8172:6888])
        (Authenticated sender: yann.morin.1998)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 32EE5B005A4;
        Thu,  7 Jan 2021 16:27:25 +0100 (CET)
Received: by ymorin.is-a-geek.org (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:27:24 +0100
Date:   Thu, 7 Jan 2021 16:27:24 +0100
From:   "Yann E. MORIN" <yann.morin.1998@free.fr>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-arch@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        buildroot@busybox.net, arcml <linux-snps-arc@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Buildroot] ARC no console output (was Re: [PATCH 1/2]
 init/console: Use ttynull as a fallback when there is no console)
Message-ID: <20210107152724.GL1485369@scaer>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Vineet, All,

On 2021-01-06 15:36 -0800, Vineet Gupta spake thusly:
> On 11/11/20 5:54 AM, Petr Mladek wrote:
[--SNIP--]
> >Make sure that stdin, stdout, stderr, and /dev/console are always
> >available by a fallback to the existing ttynull driver. It has
> >been implemented for exactly this purpose but it was used only
> >when explicitly configured.
> >
> >Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> >--- a/init/main.c
> >+++ b/init/main.c
> >@@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
> >  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
> >  	if (IS_ERR(file)) {
> >-		pr_err("Warning: unable to open an initial console.\n");
> >-		return;
> >+		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> >+		register_ttynull_console();
> >+
> >+		file = filp_open("/dev/console", O_RDWR, 0);
> >+		if (IS_ERR(file)) {
> >+			pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
> >+			return;
> >+		}
> 
> This breaks ARC booting (no output on console).
> 
> Our Buildroot based setup has dynamic /dev where /dev/console doesn't exist
> statically and there's a primoridla /init shell script which does following
> 
> /bin/mount -t devtmpfs devtmpfs /dev
> exec 0</dev/console
> exec 1>/dev/console
> exec 2>/dev/console
> exec /sbin/init "$@"

I guess you are speaking about the initramfs (cpio) case, right?

We've changed that code last August:

    https://git.buildroot.org/buildroot/commit/fs/cpio/init?id=b9026e83f

I.e. if we can't do the redirection, then we don't redirect anything.
The change was done for people who explicitly pass an empty console= on
their kernel command line.

Now, I haven't looked at nulltty yet, and I have (so far) no idea on how
it works. Thanks for the hint, I'll have a look.

> Buildroot has had this way of handling missing /dev/console since 2011 [1]
> and [2].

See also more archaelogy on that topic, referenced in that commit:
    https://git.buildroot.org/buildroot/commit/fs/cpio/?id=98a6f1fc02e41

> Please advise what needs to be done to unbork boot.

This has been present since the 2020.08 release, and has been backported
to the maintenance branches:
    2020.02.x (LTS) -> f1a83afe2df2a
    2020.05.x       -> 797f9e40224c9

> Otherwise this seems
> like a kernel change which breaks user-space and needs to be backed-out (or
> perhaps conditionalize on CONFIG_NULL_TTY. I'm surprised it hasn't been
> reported by any other  embedded folks

I won't speak about whether this is a kernel regression or not, not my
call.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 561 099 427 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
