Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF01E836
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 08:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfEOGVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 02:21:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfEOGVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 02:21:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so820478plz.1;
        Tue, 14 May 2019 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpr9qeWej7/xdaLzfL7kzDfFrVNMEMZWeQ2yDGuvcWA=;
        b=o375KU68c6cq1L9rhDvFqMLy/36KzkumU5eyglTJpzMIPwAslM+THguYtGV24yszrB
         AfYo9WtSVI4YPeApa2se9off1OySDBkrKN7buQLJmfCNI/aUK7RfjMnE/bGxwyACd7HW
         g43h4W/w7cF1ebM7p3GlKDoMC/No0MM/60V7FFaBW4jE3VheGcBQfsSDliKPbh80RMYI
         dOTUBqDXrX4eE2LtTtSOQAHYRUCrNB5AZxKgRYAE1MmJfuYWQBqZx6l5sqSUhtrZ1gg1
         924TKUokkcN8xRTqUfEE68pHktdBzMgi/pqoWUNqh/12ErYeobF1s95PpggCN9DKAtsk
         f1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpr9qeWej7/xdaLzfL7kzDfFrVNMEMZWeQ2yDGuvcWA=;
        b=f8nL02xSEYVSbcj6sJKVmwUBPhGsE4ITx1ly+NWa0OYFUyFGyYGRWfoL5YNj46+0hT
         qRCZeAFD2MHkWsLxZ2I1gEVzKQ7fqPfopCQTAai3Nqib5FzIBrzfCxg6G/bF1dhbykPU
         bZweLAuWJcjxVg64qxDgTt/TvGYD+yjRycN3FzffI3chGVYwd0ZqNyIj+/OIIUQnF+mP
         gt3e0y1+9uF4SQdgeSYK2E7HOXm/OD/4b1UKfo7nhC5hCZIu9hfmZhmC3U/t5iCjwZjd
         c60dyfnbzfONgwCXTrzS7zz+3CnEdGQ9x2kb8/E1VS/eKEsJFHVvw8m4La8dJrReiMA2
         IZyQ==
X-Gm-Message-State: APjAAAUoi/Lg/x/VT3FgLL1CnuH/RZJSrZcEWbYnKKJSmVCM3DJOnyO4
        mPzG4XMVCNU2/diw0kZFz3I=
X-Google-Smtp-Source: APXvYqzRJKRDGGgSFBUw3D9wrq2bEKNWyL8HrksRCPNPrE+2T1MlywAkkHnSpqiXENFfwknkCI68dQ==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr41177371plt.227.1557901275995;
        Tue, 14 May 2019 23:21:15 -0700 (PDT)
Received: from localhost ([110.70.52.120])
        by smtp.gmail.com with ESMTPSA id f4sm1300687pfn.118.2019.05.14.23.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 23:21:14 -0700 (PDT)
Date:   Wed, 15 May 2019 15:21:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190515062111.GA30030@jagdpanzerIV>
References: <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
 <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home>
 <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/14/19 21:13), Geert Uytterhoeven wrote:
> I would immediately understand there's a missing IS_ERR() check in a
> function that can return  -EINVAL, without having to add a new printk()
> to find out what kind of bogus value has been received, and without
> having to reboot, and trying to reproduce...

But chances are that missing IS_ERR() will crash the kernel sooner
or later (in general case), if not in sprintf() then somewhere else.

	-ss
