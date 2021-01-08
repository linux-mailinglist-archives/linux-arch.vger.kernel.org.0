Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02E2EEFB2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbhAHJbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 04:31:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:57788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbhAHJbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jan 2021 04:31:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610098234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfgKJpMAHp8Rvytw3TE0W+1mkInelAxdQ/ewwANtj8Q=;
        b=C9zvaA4tcvVEzY61cFjTG0aG6Xs3pGfGgZ5ltAWj6AwsAN6jEzLoYT3Zg2GfiX/PFAd6YK
        HKCLR0e1Pc5yHesrNNe0VMKDO301cl1S9ade8FWeJ/vZ5mosclvvuDUlbsUCH/6GUaG90W
        09bOjXnMVIoHJUmT5ugwEX1JSE7kEZs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3887AACAF;
        Fri,  8 Jan 2021 09:30:34 +0000 (UTC)
Date:   Fri, 8 Jan 2021 10:30:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <X/gmOSvgzrPxBdIk@alley>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
 <8735zdm86m.fsf@jogness.linutronix.de>
 <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com>
 <X/c/ONCYz2QQdvOP@alley>
 <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com>
 <X/fWGjYI5LapMdGW@jagdpanzerIV.localdomain>
 <d7db7948-4831-8dac-0d16-7933bcd9d995@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7db7948-4831-8dac-0d16-7933bcd9d995@synopsys.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu 2021-01-07 21:18:20, Vineet Gupta wrote:
> On 1/7/21 7:48 PM, Sergey Senozhatsky wrote:
> > On (21/01/07 09:58), Vineet Gupta wrote:
> > > On 1/7/21 9:04 AM, Petr Mladek wrote:
> > > > On Thu 2021-01-07 08:43:16, Vineet Gupta wrote:
> > > > > Hi John,
> > > > > 
> > > > > On 1/7/21 1:02 AM, John Ogness wrote:
> > > > > > Hi Vineet,
> > > > > > 
> > > > > > On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
> > > > > > > This breaks ARC booting (no output on console).
> > > > > > 
> > > > > > Could you provide the kernel boot arguments that you use? This series is
> > > > > > partly about addressing users that have used boot arguments that are
> > > > > > technically incorrect (even if had worked). Seeing the boot arguments of
> > > > > > users that are not experiencing problems may help to reveal some of the
> > > > > > unusual console usages until now.
> > > > > 
> > > > > 
> > > > > Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8
> > > > > console=ttyS0,115200n8 debug print-fatal-signals=1
> > > > 
> > > > This is strange, the problematic patch should use ttynull
> > > > only as a fallback. It should not be used when a particular console
> > > > is defined on the command line.
> > > 
> > > What happens in my case is console_on_rootfs() doesn't find /dev/console and
> > > switching to ttynull. /dev is not present because devtmpfs doesn't automount
> > > for initramfs.

I see. I did not though about a possibility that /dev/console could
not be opened from other reasons.

> > I wonder if we'll move the nulltty fallback logic into printk code [1]
> > will it fix the problem?
> > 
> > [1] https://lore.kernel.org/lkml/X6x%2FAxD1qanC6evJ@jagdpanzerIV.localdomain/
> 
> Your reasoning in the post above makes total sense.
> 
> I tired the patch: adding register_ttynull_console() call in
> console_device(), removing from console_on_rootfs() band that works too.

IMHO, this worked because you removed the change in console_on_rootfs().

I guess that the change in console_device() did not make any
difference. It was likely not called because
filp_open("/dev/console", O_RDWR, 0) failed earlier because
/dev/ did not exists.

Anyway, the proposed change in console_device() has some
more problems that I realized this week:

   + It does not check whether console_drivers really contains
     any console with tty binding.

   + register_ttynull_console() calls
    add_preferred_console(ttynull_console.name, 0, NULL).
    The ttynull console stays preferred even when any better
    console gets registered later. As a result, it would
    stay associated with /dev/console.

The right solution would be to enable ttynull console and
do _not_ modify the list of preferred consoles. And it makes
sense to add the console only there is no console with
tty binding at the moment.

I still have to think whether console_device() is a better or
worse location for adding tyynull as a fallback.

Anyway, it has to wait. The proper solution can't be done easily
with the existing register_console() code. We need to clean
it up first.

Best Regards,
Petr
