Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9131B2C6263
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgK0J6x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 04:58:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35678 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgK0J6w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 04:58:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id a9so6259787lfh.2;
        Fri, 27 Nov 2020 01:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QFxWyGCwEG9dHTknWSJyal1SV6Bt5K2yI0VJthmQFnw=;
        b=pXtwcYc+3CEzPbS+dwY1Fi4fgjPmm9edgxWWAaRCl4i3QswBMx37MqUOM0RmrzVihR
         YQy1iGVMTiqmCCeLRib7j0kvJchYQjJwJSd6OiRZCo3Pydye6rQl0YmNNHmyWDAkDXml
         Wm6NmSTYrsPj6dSwsX21FOn7aQlsFbxk4qYstQHaURoRaZbD8SWMZKIkESDYW7iDwn2u
         aDwtHLVPPkaa9hNz/XBI9J0rVHEzjsuAvR1qP+ohfsKigexbBwGlMqVqQnB0xExTp7UF
         eTyyo6mpsPRNWerTVviMLoGmXh12ZD+jblcZSqDbHJI4HSCnRXk9yq+XkhK3Qf0wIJHz
         984g==
X-Gm-Message-State: AOAM532VNAE/YZMdoJTzLrdEDV8UBs0mRkc6sK/uzopQbLHBTyLQbZyG
        T6tWTlYbX1saJDZ+4rRD6lw=
X-Google-Smtp-Source: ABdhPJwgTnVwwoTuZSvkK78CGSk4DXl6rgEsNNpexBOWzrdAyWlW88qOFs7rVjd5q8hT+i5EakbIzQ==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr3370330lff.204.1606471130416;
        Fri, 27 Nov 2020 01:58:50 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v17sm630932lfp.169.2020.11.27.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:58:49 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kiaWz-0003Cz-Fi; Fri, 27 Nov 2020 10:59:10 +0100
Date:   Fri, 27 Nov 2020 10:59:09 +0100
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
Message-ID: <X8DN7b03/U2XDORg@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
 <20201111154716.GB5304@linux-8ccs>
 <X66VvI/M4GRDbiWM@localhost>
 <X7uRZUY+2L9Yg9wt@localhost>
 <20201125145118.GA32446@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125145118.GA32446@linux-8ccs>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 25, 2020 at 03:51:20PM +0100, Jessica Yu wrote:

> I've queued up patches 3, 4, 6, 7, 8 for testing before pushing them
> out to modules-next.

Thanks, Jessica.

Perhaps you can consider taking also the one for setup parameters (patch
5/8) through your tree since its related to the module-parameter one.

Johan
