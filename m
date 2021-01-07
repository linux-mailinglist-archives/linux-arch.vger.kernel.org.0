Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF42ECC2D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbhAGJCx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 04:02:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAGJCw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 04:02:52 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610010130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVXm8eLyu9SHQUOj7PCWR7viWOvxmFLsGxPEqO5tchs=;
        b=3zIkgnQwiutgllhJI+dulqEta0vLyVMkxev2q/+IXrilO8QScqYYax2H2yC+nvJwL3jjV/
        ijDlRfGHGoZi27ASPmsTx8WXgMYbnvBoNBNwGXIi0W/4KRzd8NYRuTCddJiC0cXBG/vU78
        mz0mz6hcTNz4TIPQ6FarKMNBz4hPcz4/Q7kmNMC+l6tKUMCEcLePEM2qC059PtweUQGa8U
        KepyyS7qpgPBDxv3gaM8uZltA6KzcIs0L8FFid7gdk33h3PVnxhP2p5NgBjaE8V5dr6coC
        oKdKhZR6MUOFNY1G/O2gyY/kHt2J1MGBIEmD3QA8VNlEnT/bAe2ZRMasKcXfsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610010130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVXm8eLyu9SHQUOj7PCWR7viWOvxmFLsGxPEqO5tchs=;
        b=IjGPX0bES31qEuYvRNFDP+4I9ii3bzJW7f8Bpm+h8+jlNt0FLo1NoLXETUkdDWbNFjRg1q
        P7PrGQzl3vW4LuCg==
To:     Vineet Gupta <vgupta@synopsys.com>, Petr Mladek <pmladek@suse.com>,
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
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there is no console)
In-Reply-To: <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
References: <20201111135450.11214-1-pmladek@suse.com> <20201111135450.11214-2-pmladek@suse.com> <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
Date:   Thu, 07 Jan 2021 10:08:09 +0106
Message-ID: <8735zdm86m.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vineet,

On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
> This breaks ARC booting (no output on console).

Could you provide the kernel boot arguments that you use? This series is
partly about addressing users that have used boot arguments that are
technically incorrect (even if had worked). Seeing the boot arguments of
users that are not experiencing problems may help to reveal some of the
unusual console usages until now.

John Ogness
