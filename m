Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19BB4834C3
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiACQ3H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiACQ3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 11:29:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1142C061761;
        Mon,  3 Jan 2022 08:29:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z29so137850803edl.7;
        Mon, 03 Jan 2022 08:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+15VyunbMlyaslrB+G8c1bgxGtdlzGF50WLMZAMqweY=;
        b=oZwRZaQk/icUv7eZEupXNnwVaJDyU/RA48r+Lbll1AXDx9l6ZP15EXDvrn7A8nfbre
         HwkpqMtO6Xltq9G55Y+6BCKql23SXPZTu8AK385cU73SLsSstHko51voGu/lbmxtnpSh
         jV7qtr/bRDnz3SQWkzZjBN+FkuD9xZqOjbTTunal7hKIb2pBEJYlBPcnk04dPAWCV5/t
         a8Mkn1yjIuMdSMLyJer8rmLaGkYcip5N5JXXNFvNQMIgu4tFDzVqNT3hbTxSfkU1NbLm
         i/VxTsMpa2ogxEteE+jED/+fgv+KbGBQWU2wJn5EPOQoUYyxIIUWrFKb+s04cw6T7P9t
         2lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+15VyunbMlyaslrB+G8c1bgxGtdlzGF50WLMZAMqweY=;
        b=Ku5IICJXSw4YVeDWmsW4F3Kzb5Nk3x2hbRnZPFJ5j6BwqFnmbWoENZg4lCf08uoD5E
         AjWVBNNZyrm/qGL4j7fjxMCyoIa5RWWsBjPKkBrVhQGiCDWXH9qmyiO3UoWtp/Oot0+y
         cZMMoO5LRkkWAkAg1wyzTCI685HqO0nrJxYToAtzYjDD2htGpJnezsIFDjyx94d16Y8/
         kCV//l3GDV1eDohjxaaooZ2kacFjLELEwNnwz7lz04vLauaCZZsUvAOF4dybskxiEfcu
         G36j9EbaxLR6ZPCQonKMPa+34hI4wcAn1UFMQrTEzp1niEOHlHtF29ZPG+QqJ7N+OhhA
         +p5g==
X-Gm-Message-State: AOAM531fgQA4baxopRsBU5En0Lw64nugO1Huv1jOe+uyw75zi0IBCW2G
        7SxRAw4WeEutg2UhrI0hkqZIgUAYLGM=
X-Google-Smtp-Source: ABdhPJyenq5OezECrB1ZC6EXStvbObATBBKVMKDSQJyVgbT+MDwJ3wTARhSoB3AS96p1ml4ZUk6YlQ==
X-Received: by 2002:a17:907:3f14:: with SMTP id hq20mr38809900ejc.314.1641227344436;
        Mon, 03 Jan 2022 08:29:04 -0800 (PST)
Received: from gmail.com (0526F103.dsl.pool.telekom.hu. [5.38.241.3])
        by smtp.gmail.com with ESMTPSA id hq29sm10982893ejc.141.2022.01.03.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:29:04 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 3 Jan 2022 17:29:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdMkTjGSQFLEV5VB@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
 <YdL+IwQGTLFQyVz2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdL+IwQGTLFQyVz2@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > The overall policy to extend task_struct, going forward, would be to:
> > 
> >  - Either make simple-type or struct-pointer additions to task_struct, that 
> >    don't couple <linux/sched.h> to other subsystems.
> > 
> >  - Or, if you absolutely must - and we don't want to forbid this - use the 
> >    per_task() machinery to create a simple accessor to a complex embedded 
> >    type.
> 
> I'll leave all of this up to the scheduler developers, but it still looks 
> odd to me.  The mess we create trying to work around issues in C :)

Yeah, so I *did* find this somewhat suboptimal too, and developed an 
earlier version that used linker section tricks to gain the field offsets 
more automatically.

It was an unmitigated disaster: was fragile on x86 already (which has a zoo 
of linking quirks with no precedent of doing this before bounds.c 
processing), but on ARM64 and probably on most of the other RISC-ish 
architectures there was also a real runtime code generation cost of using 
linker tricks: 2-3 extra instructions per per_task() use - clearly 
unacceptable.

Found this out the hard way after making it boot & work on ARM64 and 
looking at the assembly output, trying to figure out why the generated code 
size increased. :-/

Anyway, the current method has the big advantage of being obviously 
invariant wrt. code generation compared to the previous code, on every 
architecture.

> > Do these plans sound good to you?
> 
> Yes, taking the majority through the maintainer trees and then doing the 
> remaining bits in a single tree seems sane, that one tree will be easier 
> to review as well.

Ok. Will definitely offer it up piecemail-wise, in reviewable chunks, via 
existing processes & flows.

Thanks,

	Ingo
