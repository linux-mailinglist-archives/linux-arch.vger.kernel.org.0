Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59E2C9E67
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 10:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgLAJ4f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 04:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgLAJ4f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 04:56:35 -0500
Received: from linux-8ccs (p57a232c3.dip0.t-ipconnect.de [87.162.50.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE6820657;
        Tue,  1 Dec 2020 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606816554;
        bh=6kpZqmqH8xua3fMlvH5v7aR2iYhj3V3XHB8sPP9GwtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaKC+wOGCkaFDrokRs8vG8T9PyHnxjZewI0Q4wUOl8ZG1bedSsewuxTUWHg1g0Xga
         g/qOMTN06J1M9yi62pQ/0janvXuvmXgbHFgl+gWFYJlyHsmlnf3/e1Cy2+EE14B3pQ
         o/gp5LAXkM8m/KaEOGWeTPQwL8vV2/UmbPytjHQ0=
Date:   Tue, 1 Dec 2020 10:55:47 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20201201095544.GA9394@linux-8ccs>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
 <20201111154716.GB5304@linux-8ccs>
 <X66VvI/M4GRDbiWM@localhost>
 <X7uRZUY+2L9Yg9wt@localhost>
 <20201125145118.GA32446@linux-8ccs>
 <X8DN7b03/U2XDORg@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X8DN7b03/U2XDORg@localhost>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Johan Hovold [27/11/20 10:59 +0100]:
>On Wed, Nov 25, 2020 at 03:51:20PM +0100, Jessica Yu wrote:
>
>> I've queued up patches 3, 4, 6, 7, 8 for testing before pushing them
>> out to modules-next.
>
>Thanks, Jessica.
>
>Perhaps you can consider taking also the one for setup parameters (patch
>5/8) through your tree since its related to the module-parameter one.
>
>Johan

Sure, done.

Thanks,

Jessica
