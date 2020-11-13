Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97B2B1D05
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 15:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKMOSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 09:18:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33634 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKMOSb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 09:18:31 -0500
Received: by mail-lf1-f68.google.com with SMTP id l11so1951830lfg.0;
        Fri, 13 Nov 2020 06:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDgCLMJoZmxmDlgC6UusTiNF2DjvUhEUsSy7j2c2oEo=;
        b=VshIdoRFf2LUCo56z5Yk8yQVrbo3+sTLT3eljfHGJy55/REBaq197s9dKHvU8fyymk
         ySXe68q37YvfqGlu4u87RvDtmj2zaABSu3OSoylDx3v4IaH3ELvQYyOFGD6Lt/1ySwZf
         ic4U0JpgmxLiVFPk9JmkmQd4tEkPmvOEbShe4+yR+Re/3IqGfP+AhZ+nRdaxleNI3QPf
         WNa0PJfnoeNSmXTmDOG/iu88tozBXSVQjT/A/ygRW1X65kUvXeTetSDQTq9T2ilQmyg/
         Fe7VtG0K8zN4/QwiCj1MItjH/3w3uMaX4oQOzVtEKSkB+ZuUAp/jDQ+o/sQLHm4ibRZi
         cJEg==
X-Gm-Message-State: AOAM532Xb/NLSXqu8wN0wMbNz0LvYDevDEuNWODxp1YFy1qewLDXW2y+
        Qsa6WrfXrHVje15gFaWxli8=
X-Google-Smtp-Source: ABdhPJxdfb818xmmOyNVGqR7psD/mq9eAAqChsuRhQu4aj8NV0L1pYsMjOklC1ct+Rq/A4X/wrdSUg==
X-Received: by 2002:ac2:5503:: with SMTP id j3mr1103706lfk.94.1605277109708;
        Fri, 13 Nov 2020 06:18:29 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v12sm1448452lji.3.2020.11.13.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:18:28 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kdZuO-00021E-VC; Fri, 13 Nov 2020 15:18:37 +0100
Date:   Fri, 13 Nov 2020 15:18:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <X66VvI/M4GRDbiWM@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
 <20201111154716.GB5304@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111154716.GB5304@linux-8ccs>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 11, 2020 at 04:47:16PM +0100, Jessica Yu wrote:

> Thanks for providing the links and references. Your explanation and
> this reply from Jakub [1] clarified things for me. I was not aware of
> the distinction gcc made between aligned attributes on types vs. on
> variables. So from what I understand now, gcc suppresses the
> optimization when the alignment is specified in the variable
> declaration, but not necessarily when the aligned attribute is just on
> the type.
> 
> Even though it's been in use for a long time, I think it would be
> really helpful if this gcc quirk was explained just a bit more in the
> patch changelogs, especially since this is undocumented behavior.
> I found the explanation in [1] (as well as in your cover letter) to be
> sufficient. Maybe something like "GCC suppresses any optimizations
> increasing alignment when the alignment is specified in the variable
> declaration, as opposed to just on the type definition. Therefore,
> explicitly specify type alignment when declaring entries to prevent
> gcc from increasing alignment."

Sure, I can try to expand the commit messages a bit.

> In any case, I can take the module and moduleparam.h patches through
> my tree, but I will wait a few days in case there are any objections.

Sounds good, thanks. I'll send a v2 next week then.

Johan

> [1] https://lore.kernel.org/lkml/20201021131806.GA2176@tucnak/
