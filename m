Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409CA2C037E
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgKWKj2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:39:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38210 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgKWKj2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:39:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id s27so3071007lfp.5;
        Mon, 23 Nov 2020 02:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zu6OfJ95y/pN6IwPuUeH5utOpyu4tZOqYK7qDx71Ni8=;
        b=k9JqMwa01H/TlQXgxHuXxiJo/wUA1VsRNt3AxNiDnjURaGSfwSG+QEH43PMQ/Rw1yY
         jI0xFRSXAQYJo6c9tZyoSmxZKkpl0/SPZVInxv12CnjZSbi9CbCfe7JsoESPfnrPYxcL
         /wdnvFU12+j7+AiUVRfO3Z/xZljrjdTmRU+U6oWeioBukaiqLgHK7Qg2EseYZFj77X3g
         u0xkug4Er8VAo6rNgd+IHkwi6U6pEtKYAMYh1oA7k8a83ajT6qc/pvdgxwZm5aNwLm5S
         9KipbC5NH5+C8dqx073LE1hbCWvEFbrAaxVHZcoPzf126t2IGpe2BqsfrCR6j7DWieQx
         W/jw==
X-Gm-Message-State: AOAM5315nVHeLZzfG5vjv0Rr2yYdullCmpn9zwwYRaIfZFX49akRVQ94
        tF/QIM8NvrHlm8dvXmZAnLfT8v76LDstGQ==
X-Google-Smtp-Source: ABdhPJzUGZ0YqN/vl49P9feH1vlK2oj73FKY6pxWrO7X1b7knH1ZqrDuJBa3qsxmQarxIFKwpMFjqQ==
X-Received: by 2002:a19:1d0:: with SMTP id 199mr12243126lfb.151.1606127965943;
        Mon, 23 Nov 2020 02:39:25 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s20sm493368ljg.15.2020.11.23.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:39:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kh9Ft-0002BT-Sm; Mon, 23 Nov 2020 11:39:34 +0100
Date:   Mon, 23 Nov 2020 11:39:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <X7uRZUY+2L9Yg9wt@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
 <20201111154716.GB5304@linux-8ccs>
 <X66VvI/M4GRDbiWM@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X66VvI/M4GRDbiWM@localhost>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 03:18:36PM +0100, Johan Hovold wrote:
> On Wed, Nov 11, 2020 at 04:47:16PM +0100, Jessica Yu wrote:
> 
> > Thanks for providing the links and references. Your explanation and
> > this reply from Jakub [1] clarified things for me. I was not aware of
> > the distinction gcc made between aligned attributes on types vs. on
> > variables. So from what I understand now, gcc suppresses the
> > optimization when the alignment is specified in the variable
> > declaration, but not necessarily when the aligned attribute is just on
> > the type.
> > 
> > Even though it's been in use for a long time, I think it would be
> > really helpful if this gcc quirk was explained just a bit more in the
> > patch changelogs, especially since this is undocumented behavior.
> > I found the explanation in [1] (as well as in your cover letter) to be
> > sufficient. Maybe something like "GCC suppresses any optimizations
> > increasing alignment when the alignment is specified in the variable
> > declaration, as opposed to just on the type definition. Therefore,
> > explicitly specify type alignment when declaring entries to prevent
> > gcc from increasing alignment."
> 
> Sure, I can try to expand the commit messages a bit.

I've amended the commit messages of the relevant patches to make it more
clear that the optimisation can be suppressed by specifying alignment
when declaring variables, but without making additional claims about the
type attribute. I hope the result is acceptable to you.

Perhaps you can include a lore link to the patches when applying so that
this thread can be found easily if needed.

Johan
