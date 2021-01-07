Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A602ED502
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhAGRFo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 12:05:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:46894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbhAGRFo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jan 2021 12:05:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610039097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMfq/PKouT6ktPEQMdn1ZCdmFrDqGcaa8I0x2b98/NQ=;
        b=l8DMIk0AM0Lx8ZD6OSuzfMbW4nKMZ6WKVw4MmA4GAuTcv53Hdenl9On+h9HXtdA+/xAPXr
        cUe6J95cuctNrrZP/mnhnUDsoh5ySn3oqhO7saQZKtELu73+m19Bk2rkzJscpvzBePRNTR
        6UYUcPdDBWuo/CrWCbGlTwdwN74UYKg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 626DDAD57;
        Thu,  7 Jan 2021 17:04:57 +0000 (UTC)
Date:   Thu, 7 Jan 2021 18:04:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
Message-ID: <X/c/ONCYz2QQdvOP@alley>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
 <8735zdm86m.fsf@jogness.linutronix.de>
 <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu 2021-01-07 08:43:16, Vineet Gupta wrote:
> Hi John,
> 
> On 1/7/21 1:02 AM, John Ogness wrote:
> > Hi Vineet,
> > 
> > On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
> > > This breaks ARC booting (no output on console).
> > 
> > Could you provide the kernel boot arguments that you use? This series is
> > partly about addressing users that have used boot arguments that are
> > technically incorrect (even if had worked). Seeing the boot arguments of
> > users that are not experiencing problems may help to reveal some of the
> > unusual console usages until now.
> 
> 
> Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8
> console=ttyS0,115200n8 debug print-fatal-signals=1

This is strange, the problematic patch should use ttynull
only as a fallback. It should not be used when a particular console
is defined on the command line.

The only explanation would be that ttyS0 gets registered too late
and ttynull is added as a fallback in the meantime.

Anyway, I propose the revert the problematic patch for 5.11-rc3,
see
https://lore.kernel.org/lkml/20210107164400.17904-2-pmladek@suse.com/
This mystery is a good reason to avoid bigger changes at this stage.

Best Regards,
Petr
