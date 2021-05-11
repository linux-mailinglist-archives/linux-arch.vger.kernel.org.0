Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8823637A667
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEKMS2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 08:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhEKMS1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 08:18:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572EC061574;
        Tue, 11 May 2021 05:17:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s22so15606795pgk.6;
        Tue, 11 May 2021 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oop2Ovp8EWOv+egH128OBsTcETSDonZFH/twdK2VyXQ=;
        b=CEz0RXbjwosGhH8hdR9o1C73Do4+xBRNtm/XvgetWpHK68FX2KTg+3wIg7/4SQR/L+
         7tdHgPWm5xG7gDh/iwRfrTZQdkDg4akoHewRUxXLhDzgG6vxiaY5Qo/89g9Pd9zEIwKu
         KCXXWabShDlt64TYCyGgQaMNImmytPy0uC6r242U3Ak9w7oR8iuvlhzqhP90BwdBmK2L
         lLrfLTLR2iCLAfAPQE2JmseVHupO/rmfGDWh/FjRLSMEzjtDsO3gtDDTz7o75v9uAoc9
         C9A8/mcK3UxZIgpR2/cW9B9f/OVj4A9LeNDzrTP4cQd/VH7t84+J7+9PzZi51rRVID+U
         Qhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oop2Ovp8EWOv+egH128OBsTcETSDonZFH/twdK2VyXQ=;
        b=T7hsGHPoOZ4nMmNmppkANYh2hbKGPE2PAp4PWiKi8tnwbf/Qb1h4dBGRacfKVlFXhT
         zk/+NjwqC9eknjhKMdwyfl6iFpqBwoPRBKkSSd8Ltos1eYM10lXsgs3elC7vtI0/jnmG
         DnRs9HY+sM3OEIIo7eRgiRKK1hxDnsimn9Tr3DyFKmz+0OCIsmWK2jnVRp6utJs3JDmH
         jW9HQGOhih1UEhsa0t2cAXSb7VUdtSUuAXES/wgqp4jUXilhQL+GvQRKTj1U/WNcoCIl
         jyzQR4ep1GbSDVygNeGC6JlwKNTRINbhPpGUiq89WsjaR6H1W0Gi0Ro/2pye80cIy6qe
         3ACg==
X-Gm-Message-State: AOAM530rb/61wmSxNc0SHn6mEtK6r/TwWpC7P1z5k+tel4i+1UHXus64
        F3yYVzRE+nGiuLkwt5ed6HIiUudKp4nCJ1O/sm8=
X-Google-Smtp-Source: ABdhPJyVcbgqCaK23waa0/SMpPauuLaNO44XEidyEsBXv9sGVkGIp3uAGlSgcIvjQbj0U3XNk2TS5nfqmHHxZMXWIzg=
X-Received: by 2002:a63:4145:: with SMTP id o66mr7680949pga.4.1620735437892;
 Tue, 11 May 2021 05:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
 <YJm5Dpo+RspbAtye@rikard> <YJoyMrqRtB3GSAny@smile.fi.intel.com> <YJpePAHS3EDw6PK1@rikard>
In-Reply-To: <YJpePAHS3EDw6PK1@rikard>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 15:17:01 +0300
Message-ID: <CAHp75VdVubL-_kLV80Z9cVDpjYb_HT4ivw3t-QUj0594whL=wQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 11, 2021 at 1:36 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 10:28:50AM +0300, Andy Shevchenko wrote:
> > On Tue, May 11, 2021 at 12:51:58AM +0200, Rikard Falkeborn wrote:
> > > On Mon, May 10, 2021 at 06:44:44PM +0300, Andy Shevchenko wrote:
> >
> > ...
> >
> > > Does the following work for you? For simplicity, I copied__is_constexpr from
> > > include/linux/minmax.h (which isn't available in tools/). A proper patch
> > > would reuse __is_constexpr (possibly refactoring it to a separate
> > > header since bits.h including minmax.h for that only seems smelly)
> >
> > I think we need to have it in something like compiler.h (top level). Under
> > 'top level' I meant something with the function as of compiler.h but with
> > Linuxisms rather than compiler attributes or so.
>
> Right. Will you send a patch, or do you want me to?

Please, go ahead!
I'm in a vacation mood (tomorrow it will start)

> It would be good to get confirmation that __is_constexpr solves the
> build failure.

-- 
With Best Regards,
Andy Shevchenko
