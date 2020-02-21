Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDA168761
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 20:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBUTWr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 14:22:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgBUTWr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 14:22:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E95FC141C8A41;
        Fri, 21 Feb 2020 11:22:46 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:22:44 -0800 (PST)
Message-Id: <20200221.112244.1426580944977593272.davem@davemloft.net>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [RFC] regset ->get() API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200221185903.GA3929948@ZenIV.linux.org.uk>
References: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
        <20200221033016.GV23230@ZenIV.linux.org.uk>
        <20200221185903.GA3929948@ZenIV.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Feb 2020 11:22:47 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 21 Feb 2020 18:59:03 +0000

> Again, a couple of copy_regset_to_user(), but there's an additional
> twist - GETREGSET of 32bit task on sparc64 will use access_process_vm()
> when trying to fetch L0..L7/I0..I7 of other task, using copy_from_user()
> only when the target is equal to current.  For sparc32 this is not
> true - it's always copy_from_user() there, so the values it reports
> for those registers have nothing to do with the target process.  That
> part smells like a bug; by the time GETREGSET had been introduced
> sparc32 was not getting much attention, GETREGS worked just fine
> (not reporting L*/I* anyway) and for coredump it was accessing the
> caller's memory.  Not sure if anyone cares at that point...

That's definitely a bug and sparc64 is doing it correctly.
