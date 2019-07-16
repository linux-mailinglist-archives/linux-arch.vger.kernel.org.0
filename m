Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60596AF4F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbfGPS4A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 14:56:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbfGPSz7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 14:55:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so22050012wru.13
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2019 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HII1jGmOqJ+ZHDKFI1WGLRVkv6rLuJXcbXOQGuTO2qs=;
        b=fLx81Axc7fZXcKYyn4FdWmT0VEDGlHROQXan6kCDS1lBwXYOSOZICuwNpupEPxZ1KA
         wYSXFaoVOjGfUCkS+d8cHlAhu3M2pxovWkqnQFOwALA9QBVmnRkxZxo8H9luuiBMYElW
         teY5CswjSiHPAphop6UNge3b8FVvFOdl6ZPhV/lGeX4EdVgwNRrnGQgmpMB8qwN4h6Vz
         CUQTMLSjShRSEkdrxPF+i2v0KnEMWmD2NuZDGJaVq93w9O/93sXEJ13J+BUqFv+mqIR0
         a2nSPFa0W7ZgTdiFK5BAgfXI4EwftEfi8ScyprvmIm71SEiMx2Gq30N3zYyTNzblFVBj
         IDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HII1jGmOqJ+ZHDKFI1WGLRVkv6rLuJXcbXOQGuTO2qs=;
        b=Xj+LN6myY1DWeLoJwvr6tzv8plLYO8qtSbnL6iFkdcipf9KaXdPBnzCRs88NITdHy+
         NJvM2ULYOfIl9JFzenocooKHgOg+A5P755+w+Ym+ptPs42V8WCSLKh/iqMu1QCtnG5fw
         vj26TtO4JNpzx+2qSdFMtKLI86CyCJ/TcfIFKRSXLjZ23zGaBlTk7M+PjRLMMlgQ+X6c
         mZFW3K788EaUt+la/c8KizmJ01x889aXatdnt+j+EfvJ7Z5q6gvAXj1+vTiuxE4NDag/
         //U2Yw3GAEfw2DVt61NNik/MvgivpeunVPWgJ8sQeCiyEXgSRfvvQTfRe5Pdj0tE/fOB
         qxGw==
X-Gm-Message-State: APjAAAU5RB2loCTw6osogrTnhKB/WQLi1JRopKb+miwWo2hlKWMvokeH
        JW4rkou2+Viv11+IbL1+sRM=
X-Google-Smtp-Source: APXvYqxjOiZ+/ZmqnAl0iYfzzo4MAVdDizISydYdFT08PVtYYgV0sowV+fqLU0s1PX6fcTCrkIj0Fw==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr36779432wrq.333.1563303357931;
        Tue, 16 Jul 2019 11:55:57 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id j33sm48044545wre.42.2019.07.16.11.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:55:57 -0700 (PDT)
Date:   Tue, 16 Jul 2019 20:55:55 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190716185554.gwpppirvmxgvnkgb@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
 <20190716185310.GA12537@t470p.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716185310.GA12537@t470p.stackframe.org>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 08:53:10PM +0200, Sven Schnelle wrote:
> Hi,
> 
> [Adding Helge to CC list]
> 
> On Tue, Jul 16, 2019 at 03:06:33PM +0200, Christian Brauner wrote:
> > On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> > > I think Vasily already has a clone3 patch for s390x with 435. 
> > 
> > A quick follow-up on this. Helge and Michael have asked whether there
> > are any tests for clone3. Yes, there will be and I try to have them
> > ready by the end of the this or next week for review. In the meantime I
> > hope the following minimalistic test program that just verifies very
> > very basic functionality (It's not pretty.) will help you test:
> > [..]
> 
> On PA-RISC this seems to work fine with Helge's patch to wire up the
> clone3 syscall.

I think I already responded to Helge before and yes, I think that parisc
doesn't do anything special for fork, vfork, clone, and by extension
also probably doesn't need to for clone3.
It should only be a problem for arches that require mucking explicitly
with arguments of clone-like syscalls.
In any case, I saw Helge's patch and I think I might've missed to add an
Acked-by but feel free to add it.

Thanks for testing it and sorry that I couldn't test!
Christian
