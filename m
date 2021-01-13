Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4682F57FA
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 04:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbhANCMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 21:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbhAMWIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 17:08:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A1C061575;
        Wed, 13 Jan 2021 14:07:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so3610363edt.7;
        Wed, 13 Jan 2021 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fjx4x9CJD2wWjKON/wheiuq+1EzL46Iryc22xTN24oY=;
        b=va4GwRxtMiYIKSA/SqIIQIDY1vPL/tulMkOywZckEhLZbkhHpEMpYvfhLrH13087EN
         kXM2l8Jf61kJJXZttzxj3aSr3wdcXQ3NiOK/1XYg5lwTvXKffuuaxQKICLn8mwRhoiez
         7KNyrcUunR+dYvmVagw8isyRG7MvR5ZtxwcoZgoSZ5lKIx5/3EejSzfQlYdS0zYagmev
         cPIsk0AJvOACpUU+da4NawTYTwixhknA+O6n4rxx5TmITa1OIsGTEg86Y9Xol9aSUYWP
         tJMSk0r8RKd98RiFQc/HOsUK2zSr4NVbZSraJ+tgb4CMpTMF87CAs02UeyIbmSdq3xqG
         KXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fjx4x9CJD2wWjKON/wheiuq+1EzL46Iryc22xTN24oY=;
        b=CgL744oy/hNzjwT+pI2yPFgx/+Puvk6q77KeUomTOp+295yPR3OOx7vLkfZDSDy5oG
         jfJTWcfyp3zh8SsKCSWyNNmwsg1AQF8ncUghoH+HvlMkLDkuDwKSR1GkCa1tB8KqpyAW
         gREANaDlXFZf9vlGc4dmWxedLRnmi/8k+P8xbw5UoFfD3qcg4/rIM69BJPY/lj8UDKTt
         5m/C3yRFMD2soCxlNj64mN4pEUtXNN/0uPUHeC+7kkmmMfNL52XhA2BLs6vYiDiUrUgS
         72G3T5OKsN3A8+oDIUifpyd3rBOdi4kZ0EWnwZVuTAY80OgWfR/j6zwZhRMtpeONnMij
         1Uuw==
X-Gm-Message-State: AOAM5306Qnw2RRvtxbXM6S1qy5591Xvo7x83IA2xWh90bsgA2M3CDA4R
        Mo0akocU3CxF5CQewKt0ojPok9SlO30=
X-Google-Smtp-Source: ABdhPJxUKBGh3JepPbB6R+MrqeDdFx9YTBcgjZ4Pvjh9UD5YwM/YStAH0Z8jRgQKOwNMRp6Mt1XMwQ==
X-Received: by 2002:a50:c34b:: with SMTP id q11mr449809edb.214.1610575667713;
        Wed, 13 Jan 2021 14:07:47 -0800 (PST)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id b14sm1403781edu.3.2021.01.13.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:07:46 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1kzoIr-0004d2-QY; Wed, 13 Jan 2021 23:07:45 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-arch@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        buildroot@busybox.net, arcml <linux-snps-arc@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there is no console)
References: <20201111135450.11214-1-pmladek@suse.com>
        <20201111135450.11214-2-pmladek@suse.com>
        <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
        <8735zdm86m.fsf@jogness.linutronix.de>
        <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com>
        <X/c/ONCYz2QQdvOP@alley>
        <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com>
Date:   Wed, 13 Jan 2021 23:07:45 +0100
In-Reply-To: <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com> (Vineet
        Gupta's message of "Thu, 7 Jan 2021 09:58:05 -0800")
Message-ID: <87turkfq32.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>>>> "Vineet" == Vineet Gupta <vgupta@synopsys.com> writes:

 > On 1/7/21 9:04 AM, Petr Mladek wrote:
 >> On Thu 2021-01-07 08:43:16, Vineet Gupta wrote:
 >>> Hi John,
 >>> 
 >>> On 1/7/21 1:02 AM, John Ogness wrote:
 >>>> Hi Vineet,
 >>>> 
 >>>> On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
 >>>>> This breaks ARC booting (no output on console).
 >>>> 
 >>>> Could you provide the kernel boot arguments that you use? This series is
 >>>> partly about addressing users that have used boot arguments that are
 >>>> technically incorrect (even if had worked). Seeing the boot arguments of
 >>>> users that are not experiencing problems may help to reveal some of the
 >>>> unusual console usages until now.
 >>> 
 >>> 
 >>> Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8
 >>> console=ttyS0,115200n8 debug print-fatal-signals=1
 >> 
 >> This is strange, the problematic patch should use ttynull
 >> only as a fallback. It should not be used when a particular console
 >> is defined on the command line.

 > What happens in my case is console_on_rootfs() doesn't find
 > /dev/console and switching to ttynull. /dev is not present because
 > devtmpfs doesn't automount for initramfs.

But our initramfs/cpio logic ensures that the initramfs has a static
/dev/console device node, so how can that be?

https://git.buildroot.net/buildroot/tree/fs/cpio/cpio.mk#n25

-- 
Bye, Peter Korsgaard
