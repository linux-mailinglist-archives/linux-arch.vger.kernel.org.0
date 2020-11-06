Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA92A9A53
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKFRC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 12:02:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45203 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRC1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 12:02:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id z21so1595417lfe.12;
        Fri, 06 Nov 2020 09:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IxgRn+NDQHTCeHwfBgvEL75Ff6LWDGq3sU/W0ROdACs=;
        b=IAJ8iU1BvxrdM2I3e2LNcRjjFUrkrBxAwYcNiFTuBg/CYbdJfpufGOYzvgoXAaWD9z
         Dc6SI7wOPMOq7BoOZkBCxoysFFkdlXy+0Ab7Gr+w/sR2E2yM7ec8AyrcnGl9AEhg3MQ/
         05asFOY06KdF+NMAIGP5V0UJnKLOcLxXucJ3x2ao5EhYUbxEQk+84UhXUtaui9jzPDBx
         GEiZ4vmlmzExey3qgTXdUodCDUaMNR2LihtppR0gsOkyjL+EOwyPBhMNrj5gEJi795MQ
         ihLB42WEWaNgNXNpdMweqqR/o8LWTtZOFqWbznr2qRcGyoAFTd8V1GakpWOusG7UZzRz
         RTzw==
X-Gm-Message-State: AOAM530aI9QXCkcga9Kg0kz8kY0EsPg9hhVk2aQjxUPFJLAjNrJ+JP8W
        OTra2+jfbXlSHJD3+iTpp5IRQOMjttOuqA==
X-Google-Smtp-Source: ABdhPJw79cVvhd1vcIuu4XPui96mAP4xDKV9ArN/Fggzk4GDVD5ecQaYCGh110VzE2qKOVR/aU9B5Q==
X-Received: by 2002:a05:6512:104e:: with SMTP id c14mr1305423lfb.345.1604682144693;
        Fri, 06 Nov 2020 09:02:24 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r23sm225149lfe.228.2020.11.06.09.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:02:23 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kb587-0000G4-23; Fri, 06 Nov 2020 18:02:27 +0100
Date:   Fri, 6 Nov 2020 18:02:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org,
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
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <20201106170227.GE4085@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
 <20201106115523.41f7e2ed@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106115523.41f7e2ed@gandalf.local.home>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 11:55:23AM -0500, Steven Rostedt wrote:
> On Fri, 6 Nov 2020 17:45:37 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > It's simply specifying alignment when declaring the variable that
> > prevents this optimisation. The relevant code is in the function
> > align_variable() in [1] where DATA_ALIGNMENT() is never called in case
> > an alignment has been specified (!DECL_USER_ALIGN(decl)).
> > 
> > There's no mention in the documentation of this that I'm aware of, but
> > this is the way the aligned attribute has worked since its introduction
> > judging from the commit history.
> > 
> > As mentioned above, we've been relying on this for kernel parameters and
> > other structures since 2003-2004 so if it ever were to change we'd find
> > out soon enough.
> > 
> > It's about to be used for scheduler classes as well. [2]
> 
> Is this something that gcc folks are aware of? Yes, we appear to be relying
> on undocumented implementations, but that hasn't caused gcc to break the
> kernel in the past.

The scheduler change was suggested by Jakub so at least some of them
are.

Johan
