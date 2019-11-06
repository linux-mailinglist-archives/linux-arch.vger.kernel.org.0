Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B26F0B7E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 02:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfKFBNN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 20:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729614AbfKFBNM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 20:13:12 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB1721A49;
        Wed,  6 Nov 2019 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573002791;
        bh=F8oZBAZiUgNBGiV+WdUohtNWYyfzETDe01QBSwwnbUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LnltnbcoEvw0zudUzaix987ZKsj6MqDuFqsZC0+IjmxZ0XpTcoy82THWXKyrYQ0Ye
         mv5Z8zeYgtccYtyRipnP9TZaP3/JrnK54F4aJa9wN2ypZkOFNbFlBBd661zaIpobQL
         OZchQhXSAp1sAaj7ISlI/bn8Ev4MXWgPMnouR5wE=
Date:   Tue, 5 Nov 2019 17:13:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and
 include/asm-generic/4level-fixup.h
Message-Id: <20191105171309.9a5ccf9cf14d7288f7adf198@linux-foundation.org>
In-Reply-To: <1572938135-31886-14-git-send-email-rppt@kernel.org>
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
        <1572938135-31886-14-git-send-email-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  5 Nov 2019 09:15:35 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> There are no architectures that use include/asm-generic/4level-fixup.h
> therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.

Conflicts a bit with Vineet's "asm-generic/tlb: stub out pud_free_tlb()
if nopud ...", from
http://lkml.kernel.org/r/20191016162400.14796-2-vgupta@synopsys.com

I fixed it up by removing include/asm-generic/4level-fixup.h anyway and
removing the removal of "#ifndef __ARCH_HAS_4LEVEL_HAC" from
include/asm-generic/tlb.h.
