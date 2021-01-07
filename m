Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664262ECC5B
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 10:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhAGJKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 04:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAGJKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 04:10:49 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262FC0612F4;
        Thu,  7 Jan 2021 01:10:08 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id l14so2479294qvh.2;
        Thu, 07 Jan 2021 01:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Up4Ntbnm2tP6xhuwNTf6jt4BMxiwenQSJFbALrVSgbw=;
        b=pJR3veNo3lZ3KZnRKIw+Cmk7JHB8WP0ijaTxMGz7wlMZZTrhxn8sgMU7/TDyBjpgmD
         /rrEPrp2CSoxb/QyWNdiHrcytrroWriHUxfjqXe/ULNUGmCC+9n5gTs3O+uiMx9cPxgz
         mfEwFmEJDBgFPz46bFbpXjx3pZM62G01MHRyipP+6qiSstlwKJfZlulg3zb6eKB/dRc0
         7lhG6DjBlwQaP88IIdhyoD1lW+/QLMRsxPJksdAmLtbADmsZYgg2eSZ36raeQCM5JxxT
         IJ2+m4+UG81nn6C8aLYo4TFVl+IiQxKa/z9IOeARU2UTvNqzOV4aZVIVCutR+S2hfZ/a
         Bj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Up4Ntbnm2tP6xhuwNTf6jt4BMxiwenQSJFbALrVSgbw=;
        b=B19p92Rq9OBfdDewLdaBaMCwJm4pZkkYdRtcGe+sVtGAwe6MqrTnjrRYn/uhh2ZBhl
         KeklVRCKSe34gxM+CUMaKCwm55H38Cbdzey+4pj8Xo7PVJWXTFy03oMy99P4cgTVYePo
         To6B3byn3m2so8SsA+2Z+/vPgmXBi0vNEJxpjdAAa8ZBjpTeNqbYSJZwhMdVvmNssY3D
         D0QOfrnkAjuqq6SGvtB3lhWYuYQ3Tt5W8u3Txdeksak1BMjWn3UD1a8dDH5AA8ucDXTB
         b2nn7yQsxdbY/jkAqSVLiBYYZgQADIlr8oFcQVjXKYUN6LMLSNr12yIrpYEKDjVdxPVv
         2eHw==
X-Gm-Message-State: AOAM532qV6GYzynf8Xu/b8BNOjIe4fWjsrm0fkxD32nhXO0homoNG1l1
        M7fTQg3Fpu9EGK9QLPmGDmQoSoyzY8JMcR4DxW0=
X-Google-Smtp-Source: ABdhPJyv2vjMXd5QQiayCiX4F/wULYWEZQdbYLZILnd10SKrAJd4SHv4m7ukUAU0F1t47B7hJTYSkbnFfTI6/7pqWhw=
X-Received: by 2002:a05:6214:a03:: with SMTP id dw3mr7888692qvb.24.1610010607854;
 Thu, 07 Jan 2021 01:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20201111135450.11214-1-pmladek@suse.com> <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
In-Reply-To: <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 7 Jan 2021 10:09:56 +0100
Message-ID: <CAFLxGvw=Qy9UHoa3N015hZvT9zj6YF_AiwE2ZHq3SU3cjjVDOA@mail.gmail.com>
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use
 ttynull as a fallback when there is no console)
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, buildroot@busybox.net,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Thomas Meyer <thomas@m3y3r.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[CC'in linux-um since there is a similar issue]




On Thu, Jan 7, 2021 at 12:38 AM Vineet Gupta <vgupta@synopsys.com> wrote:
>
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
> >       struct file *file = filp_open("/dev/console", O_RDWR, 0);
> >
> >       if (IS_ERR(file)) {
> > -             pr_err("Warning: unable to open an initial console.\n");
> > -             return;
> > +             pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> > +             register_ttynull_console();
> > +
> > +             file = filp_open("/dev/console", O_RDWR, 0);
> > +             if (IS_ERR(file)) {
> > +                     pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
> > +                     return;
> > +             }
>
>
> This breaks ARC booting (no output on console).
>
> Our Buildroot based setup has dynamic /dev where /dev/console doesn't
> exist statically and there's a primoridla /init shell script which does
> following
>
> /bin/mount -t devtmpfs devtmpfs /dev
> exec 0</dev/console
> exec 1>/dev/console
> exec 2>/dev/console
> exec /sbin/init "$@"
>
> Buildroot has had this way of handling missing /dev/console since 2011
> [1] and [2].
>
> Please advise what needs to be done to unbork boot. Otherwise this seems
> like a kernel change which breaks user-space and needs to be backed-out
> (or perhaps conditionalize on CONFIG_NULL_TTY. I'm surprised it hasn't
> been reported by any other  embedded folks
>
> Thx,
> -Vineet
>
> [1] http://lists.busybox.net/pipermail/buildroot/2011-July/044505.html
> [2] http://lists.busybox.net/pipermail/buildroot/2011-August/044832.html



--
Thanks,
//richard
