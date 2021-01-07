Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996832ED072
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbhAGNPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 08:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbhAGNPK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jan 2021 08:15:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CE4B22285;
        Thu,  7 Jan 2021 13:14:25 +0000 (UTC)
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use
 ttynull as a fallback when there is no console)
To:     John Ogness <john.ogness@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, buildroot@busybox.net,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arch@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
 <8735zdm86m.fsf@jogness.linutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <ac2aaa56-deca-8644-2a42-ca8ee8a77883@linux-m68k.org>
Date:   Thu, 7 Jan 2021 23:14:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8735zdm86m.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On 7/1/21 7:02 pm, John Ogness wrote:
> On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
>> This breaks ARC booting (no output on console).
> 
> Could you provide the kernel boot arguments that you use? This series is
> partly about addressing users that have used boot arguments that are
> technically incorrect (even if had worked). Seeing the boot arguments of
> users that are not experiencing problems may help to reveal some of the
> unusual console usages until now.

I can show an example for m68knommu which this change breaks too
(with no console output on boot).

All the ColdFire dev board targets (arch/m68k/configs/m5*) have a 
compiled in boot argument which is "root=/dev/mtdblock0". They have no
real mechanism to pass boot arguments from their boot loader, so it is
compiled in.

The default mcf serial driver is the console on these and no 
"console=ttyS0" argument was required in the past.

Regards
Greg


