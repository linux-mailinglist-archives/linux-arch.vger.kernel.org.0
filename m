Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07982EEC02
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 04:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbhAHDt1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 22:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAHDt0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 22:49:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B50C0612F4;
        Thu,  7 Jan 2021 19:48:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id t6so4992871plq.1;
        Thu, 07 Jan 2021 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pvFJBy06CLz3+t4PqJc62iFp4e7lY1y9gXn28qJswE4=;
        b=H4e7W7/jBppjt29pWS9EOOptTbmFaGg3EJpqr1ISOxtqkA5hrOj5eWjS6Y9b8Uzv0a
         PljjkLdumX6b3D5+oLzvdS1CAzmDevN2bvVJfp6w9f8EHFhwvR7Ra6cL5NydOoNJdle9
         YS2J2qPYZerQjJ0vPlZziA0zwa/iEP8GPuglhZUaR7nKP13ieai9Kr803MhIYHhPCsVU
         vz6oUGjVQ/yFYKmHCUCJxZd+gINoWyaB9vSihX6A013YOZ7VElpIiPiqYfgurZcl60HZ
         MVX7fSVDmovetAG5yKQ45fRkbbvUvnwoU0aBe0lUv+j4KqAIZmrlchKMKksyJ1tQgd2Y
         QGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvFJBy06CLz3+t4PqJc62iFp4e7lY1y9gXn28qJswE4=;
        b=WML/h3WqQiHr5ud0//5+2y0VWN7MZzbq9x0qjM8mN4pSKCVI8wmu097Wz9gQVcJQ/L
         YOXmOa1fL6hN6934OF2XL9RVXWm23nFQTpkXB2XrQdldsAXch8qf/Erv6XahdyX2uLjC
         l4rh19gqgnK9bnj14wytVsUNVHvCAOJDkvlyxHAAJUKGG4YKkGdLLycP7CawX+N0Q66d
         1PvZMNOkGzeCKP/AH4VBfNw+b9WEOv0j6YS5IWxB7QQh4C0BX4gAYxIBDekIxPUxXudA
         p7zfjFRL686yCbf31wuoTaLyUUrvfY4qXc99nDc/S1r1slH/vSweiM6o5lBJ4H03SKhL
         kHdw==
X-Gm-Message-State: AOAM532st6hmd9CmUOamCDb+REXAgwOLLELnyTccIJXyx7n8GtUg+3k6
        ig7orLWLpl4dunCxeC8F1xI=
X-Google-Smtp-Source: ABdhPJzamCNlkOjHaM4E4P/X1nySTrEpI7Nd5nS7fK80jAWW++uws3uB1b+uFqI4FDVD7Y+3hqMDRg==
X-Received: by 2002:a17:90a:6f01:: with SMTP id d1mr1668731pjk.155.1610077726066;
        Thu, 07 Jan 2021 19:48:46 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id v10sm3253257pjr.47.2021.01.07.19.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:48:44 -0800 (PST)
Date:   Fri, 8 Jan 2021 12:48:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
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
Message-ID: <X/fWGjYI5LapMdGW@jagdpanzerIV.localdomain>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
 <8735zdm86m.fsf@jogness.linutronix.de>
 <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com>
 <X/c/ONCYz2QQdvOP@alley>
 <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (21/01/07 09:58), Vineet Gupta wrote:
> On 1/7/21 9:04 AM, Petr Mladek wrote:
> > On Thu 2021-01-07 08:43:16, Vineet Gupta wrote:
> > > Hi John,
> > > 
> > > On 1/7/21 1:02 AM, John Ogness wrote:
> > > > Hi Vineet,
> > > > 
> > > > On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
> > > > > This breaks ARC booting (no output on console).
> > > > 
> > > > Could you provide the kernel boot arguments that you use? This series is
> > > > partly about addressing users that have used boot arguments that are
> > > > technically incorrect (even if had worked). Seeing the boot arguments of
> > > > users that are not experiencing problems may help to reveal some of the
> > > > unusual console usages until now.
> > > 
> > > 
> > > Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8
> > > console=ttyS0,115200n8 debug print-fatal-signals=1
> > 
> > This is strange, the problematic patch should use ttynull
> > only as a fallback. It should not be used when a particular console
> > is defined on the command line.
> 
> What happens in my case is console_on_rootfs() doesn't find /dev/console and
> switching to ttynull. /dev is not present because devtmpfs doesn't automount
> for initramfs.

I wonder if we'll move the nulltty fallback logic into printk code [1]
will it fix the problem?

[1] https://lore.kernel.org/lkml/X6x%2FAxD1qanC6evJ@jagdpanzerIV.localdomain/

	-ss
