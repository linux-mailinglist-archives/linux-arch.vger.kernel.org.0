Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3BE48C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfD2OUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 10:20:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OUx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 10:20:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck18so855838plb.1;
        Mon, 29 Apr 2019 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TO2quwiNR5yJblHIcZgxLZbgOYDCm0fx9p5rJ0zvPqM=;
        b=ft8P4O83KzFQvD8ubncSKWF2nbgiB3n/zTSGEm90HoxLKvrLSmOzTMyAal6sslq974
         e/RikpOTnTFYfnGU9r2DUB97U41GWmg6+83w/oYIioXaP72rY9wTf4++qulVX0gfNQbE
         xZkKOfxyrqXWTf3mqaDRjt57y+Lx/fAWtQjW1x5QVieTlerl6r3VCd2xyQbWQ79mh84N
         zUs3DQ5wYh4irTUABN1Uxf05iE+lbLZlJ9QVm52bt8Cza/dQob7UJ+F2VD2L1UHy/TlX
         GgSYNxyek47krautLrsCLiPUg2TXaUSGhtiwMlscJx5PFTP1O0EssJxg53wyCwu35s6C
         iISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TO2quwiNR5yJblHIcZgxLZbgOYDCm0fx9p5rJ0zvPqM=;
        b=RvWLAyE8YfYlnTVrBN6oi10GNGkcZGH+TDQnP/mACrHs//avfkJXcKzEZ+9YQ0LMLA
         iZwqKOoWL68KVa+MMdSwtjfQw9cP7s2XsyOlL74TRIYI397tiJAxIYHf5qcjsTxdx5dz
         iQGKp1c+gE9O2quYd8MhmuKWVUlSbF544+S5r8cX+etm9aDvoQElnAOMUOyyjol1zzHH
         nqvnfowKwtTVuO8nUWocvbKjGGY/EXa3oBjowJvQfjNopRSVz5St/qQ0n5eimrwJYl6H
         CkmIarImVhoK7MqpEiHbEVENMScfbN7hcgMeDjkbIXGzjCFmeMrgBthEnBfqMhMiPrPM
         YqfA==
X-Gm-Message-State: APjAAAVMqBx7etT6Aa3cjOl321PdcO7t/bsIEDOhyHZVVW5tPtfn0E4o
        +PkmHp7zEzOAmUVIvRjYubh2T2M5RJ7PKw==
X-Google-Smtp-Source: APXvYqxhNAE4WrtTIHV/HhgiCDI91aTl3p/Pi2/ecloRq5bRRQn+vE4G9yQCBV/IqAJb96mzBGYcIQ==
X-Received: by 2002:a17:902:2ba9:: with SMTP id l38mr210415plb.220.1556547652685;
        Mon, 29 Apr 2019 07:20:52 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id h65sm110564714pfd.108.2019.04.29.07.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 07:20:52 -0700 (PDT)
Date:   Mon, 29 Apr 2019 19:50:36 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/5] nds32: Use the correct style for SPDX License
 Identifier
Message-ID: <20190429142013.GA12127@nishad>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
 <f6a7c31f4e8b743a2877875ac3fc49ecb8b9eb0c.1555427419.git.nishadkamdar@gmail.com>
 <alpine.DEB.2.21.1904162034260.1780@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904162034260.1780@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 16, 2019 at 08:35:38PM +0200, Thomas Gleixner wrote:
> On Tue, 16 Apr 2019, Nishad Kamdar wrote:
> 
> > This patch corrects the SPDX License Identifier style
> > in the nds32 Hardware Architecture related files.
> > 
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> Actually instead of doing that we should fix the documentation. The
> requirement came from older binutils because they barfed on // style
> comments in ASM files. That's history as we upped the minimal binutil
> requirement.
> 
> Thanks,
> 
> 	tglx

Ok.

So according to license-rules.rst,
which says

"This has been fixed by now, but there are still older assembler
tools which cannot handle C++ style comments."

Now there are no assembler tools which cannot handle C++ comments ?
and the document should be changed accordingly ?

Thanks for the review.

Regards,
Nishad


