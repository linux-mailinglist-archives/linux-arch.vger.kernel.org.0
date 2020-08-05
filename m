Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA93123CD67
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgHER1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 13:27:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36570 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgHER0j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2020 13:26:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4A4291C0BD2; Wed,  5 Aug 2020 19:26:31 +0200 (CEST)
Date:   Wed, 5 Aug 2020 19:26:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TECH TOPIC] Planning code obsolescence
Message-ID: <20200805172629.GA1040@bug>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

> I have submitted the below as a topic for the linux/arch/* MC that Mike
> and I run, but I suppose it also makes sense to discuss it on the
> ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> even if we don't discuss it at the main ksummit track.

> * Latest kernel in which it was known to have worked

For some old hardware, I started collecting kernel version, .config and dmesg from
successful boots. github.com/pavelmachek, click on "missy".

Best regards,
									Pavel


(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
