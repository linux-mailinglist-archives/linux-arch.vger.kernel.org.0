Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D253B68D6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhF1TLy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhF1TLy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 15:11:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A09C061574;
        Mon, 28 Jun 2021 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gb8FkkfiAI/E5kFp62oWoJRN3P7rxKjZgqkGxjBVBqI=; b=W6VOkGRKcqRzZZICet4Vi1GmE8
        EnY7Q8NV4pBmx7kyAK2KB+gCbFFBWAkBYLAG0SUjTWSqTPBYc7eBBEpUyt/O1pFJNrdNZLtpEMPRr
        gwwbjHuuvqGLZTkfjCJN99+zvacXp1mYbMSEeAFANSgEP2tbzerpV2qRqlGSJycZCijozXlG0Xah7
        LfEW5HKabdlSn61Se3uLQhw9SghmI9WQUyzlBAdOj+5S/ZqPEhaVKU8brOKB5m9W6WEt57njuDGMm
        8UTpEdP5Ju5y7XDS8aYreGcBNLyvziR80eE3kCqvJJvkn8oio+l7i36F+gvXBm8n2KmJ4IC7ywcWO
        sUTRgtRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxwcF-003MZY-Gw; Mon, 28 Jun 2021 19:08:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37DD8982D9E; Mon, 28 Jun 2021 21:08:17 +0200 (CEST)
Date:   Mon, 28 Jun 2021 21:08:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     fweimer@redhat.com,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
Message-ID: <20210628190816.GC13401@worktop.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <2094802.S4rhTtsRBG@tjmaciei-mobl1>
 <20210628171115.GA13401@worktop.programming.kicks-ass.net>
 <7968759.t5oPhm3B3B@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7968759.t5oPhm3B3B@tjmaciei-mobl1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 28, 2021 at 10:23:47AM -0700, Thiago Macieira wrote:
> On Monday, 28 June 2021 10:11:16 PDT Peter Zijlstra wrote:
> > > Consequence: CPU feature checking is done *very* early, often before
> > > main().
> > For the linker based ones, yes. IIRC the ifunc() attribute is
> > particularly useful here.
> 
> Exactly. ifunc was designed for this exact purpose. And hence the fact that 
> CPUID initialisation will be done very, very early.
> 
> Anyway, if the AMX state is a sticky "set once per process", it's likely going 
> to get set early for every process that *may* use AMX. And this is assuming we 
> do the library right and only set it if has AMX code at all, instead of all 
> the time.

This, AFAIU. If the ifunc() resolver finds we haz AMX it can do the
prctl() and on success pick the AMX routine.

Assuming of course, that if a program links with a library that supports
AMX, it will actually end up using it.
