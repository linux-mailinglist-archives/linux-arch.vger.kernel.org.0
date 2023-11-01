Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAB7DDF5A
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 11:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjKAK26 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 06:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjKAK26 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 06:28:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A1E8;
        Wed,  1 Nov 2023 03:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YqI36cfidBvfcbWCHZIi34My4LBUITxzF3CxYYDCZq0=; b=Zh633f4wCAI8EWWmxguZFS/+Vs
        CqlawvSqXSb4Wg9fybZ4tY/5LQoH9sTD/VbVXY6KnTNzy6KOdLqyxwb+Ug9hZ1KJDBsJRCVi8LgpB
        XLtQVNt9EDS9EuDNgaiAAzm0ZvV0HXl1PoKMb2kNrp48bn28Aj79yntf/pVQCWj/V/JNVZuyUbqeo
        nmcSnXL1t+aMwwNLMAfwCSYxFLTxgoJhvQviljAvy+TOAHlEcyoNUjZjFGT1Wac91UvR3SG/YsUWP
        CHKG7DOPxsGqJQwqoZz0fV3/QbYB+evcOuh17Fi4tQq0lxcQWVlmnM3CzjzilQB2ysmVqIRzWaeea
        UhqTUsjQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qy8Sq-005dgg-19;
        Wed, 01 Nov 2023 10:28:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 093B43002AF; Wed,  1 Nov 2023 11:28:44 +0100 (CET)
Date:   Wed, 1 Nov 2023 11:28:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: Overhead of io{read,write}{8,16,32,64} on x86
Message-ID: <20231101102843.GJ15024@noisy.programming.kicks-ass.net>
References: <82076999-9346-473d-8841-1480cd70b527@app.fastmail.com>
 <f548e9e7-e499-4e26-87d9-c45ce69236a1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f548e9e7-e499-4e26-87d9-c45ce69236a1@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 01, 2023 at 10:08:42AM +0100, Arnd Bergmann wrote:
> On Tue, Oct 31, 2023, at 22:41, Jiaxun Yang wrote:
> > Hi all,
> >
> > I'm trying to improve Kernel's support of devices that have ioports
> > mapped into MMIO, that involves converting existing driver which is
> > using {in,out}{l,w,b} to use io{read,write}{8,16,32,64}, so they can
> > benefit from ioport_map and pci_iomap.
> >
> > However, the problem is io{read,write}{8,16,32,64} will incur penalty
> > on x86 by introducing extra function calls (they are not inlined) and
> > having extra condition judgment on MMIO vs PIO.
> >
> > x86 folks, do you think this kind of overhead is acceptable? I do think
> > most of PCI/ISA drivers will need to be converted.
> >
> > linux-arch folks, do you think it will be better if we introduce a
> > variant of io{read,write}{8,16,32,64} that direct to PIO on x86 but
> > remains the same functionality on other architectures?
> 
> I think in general there is not much of a problem here since
> the inb()/outb() operations themselves are extremely slow already,
> in particular the outb() writes are non-posted unlike writeb().
> 
> My feeling is that converting to ioread/iowrite is generally a win
> for any driver that already needs to support both cases (e.g.
> serial-8250) since this can unify the two code paths.

And here I looked at iowrite8 and find it includes tracing and all
sorts, which means it is unsuitable for things like early-serial and the
shiny new atomic write functionality of said serial-8250.


