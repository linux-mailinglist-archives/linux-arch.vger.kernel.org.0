Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCBF2CEF50
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 15:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgLDOEB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 09:04:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32836 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgLDOEA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 09:04:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22so6775664ljk.0;
        Fri, 04 Dec 2020 06:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gtn8MsRe3DMgMj91x+Smnp8eMKhG03Wope+aIlxxQKc=;
        b=B91VVU4A3KpJL9fLSSmOfV1L0wYc+SSiBbOa+OHF6qWPFem8RDzTBqqzAsCvrJ9eTr
         NZzgwmJk7UmJJBTapLvWHSamxMaqVXhwDM1lmL42m9HVU7YJsZ3CcUkqGEDGiEbnG8zj
         nZIqa8fvE7T2LY6bspbQxPc2JEpy40/22kzky36BdzRL1m0RDqgVdE6A+6lK0DspOhcL
         qEcCtkSLbYeZYJIa8nYrRMMi2dl8uyFY0RfnsBXf3bLxC+8WLTMTB5zA7cqRqVtYo+UE
         oPZuhGitrL+7tWDyFNpf1CHFsMPf02wGcBCoHesaULbQ8B0qL30y2erbXp4Pmeyrrp0o
         oIWg==
X-Gm-Message-State: AOAM533FA4IMFITXBJsEjMBDIulqJS4NBLwSFkcR8taSqKBdIkEhekv7
        GodnF37Avy+CU50Ko6vBcJo=
X-Google-Smtp-Source: ABdhPJyVfVQdGoJLMZW3wLfqHywZjFX2O6JRGNqsqocxYouT0vH7fJrP+ILfGOn67a6g1kiOs0AAYg==
X-Received: by 2002:a2e:593:: with SMTP id 141mr225913ljf.86.1607090592510;
        Fri, 04 Dec 2020 06:03:12 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id b12sm1729780ljj.133.2020.12.04.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:03:11 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1klBgX-0004KF-A2; Fri, 04 Dec 2020 15:03:45 +0100
Date:   Fri, 4 Dec 2020 15:03:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/8] earlycon: simplify earlycon-table implementation
Message-ID: <X8pBwTl7nZoOQ18m@localhost>
References: <20201123102319.8090-1-johan@kernel.org>
 <20201123102319.8090-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123102319.8090-3-johan@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Greg,

On Mon, Nov 23, 2020 at 11:23:13AM +0100, Johan Hovold wrote:
> Instead of using the array-of-pointers trick to avoid having gcc mess up
> the earlycon array stride, specify type alignment when declaring entries
> to prevent gcc from increasing alignment.
> 
> This is essentially an alternative (one-line) fix to the problem
> addressed by commit dd709e72cb93 ("earlycon: Use a pointer table to fix
> __earlycon_table stride").
> 
> gcc can increase the alignment of larger objects with static extent as
> an optimisation, but this can be suppressed by using the aligned
> attribute when declaring variables.
> 
> Note that we have been relying on this behaviour for kernel parameters
> for 16 years and it indeed hasn't changed since the introduction of the
> aligned attribute in gcc-3.1.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Could you pick this one up for 5.11?

Johan
