Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4122899C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgGUUFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:05:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03FC061794;
        Tue, 21 Jul 2020 13:05:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595361906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Tab+FNZiwwNP0EHguZfXpFsbFXiXvqfpdyN14o3Ujn8=;
        b=thsjb4B5bSS4NhKXt5vkHwGTf4GQi2O155pY3qlvPhfGr2cGUmUunylXN9BAQ+hFirIcyM
        D01Zn+PGoC56T1tZSUv8pyBMawrd0Lrr8nIgYgH3utoyPrUJnPgANM95FNZi2ZnJ7cqTRg
        VJTrgs08foJx6D2/OyyvBjl6Eg0Xu4EzmwUAFmeDb15OAuJjy2fTqkGE7px3lLDWCjR8sv
        Tzpe/fDZjAO9l9xuvGuNc9oA82vy3qoOXKO29ZM8stiTUE6mwHqWKauvj8o9jMgavwwYo4
        /VaXhe6tQozYDAyn+myZPy8YPiwRDW9AOvzXHIliA+fr5P+1a7x27JcPqQU6uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595361906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Tab+FNZiwwNP0EHguZfXpFsbFXiXvqfpdyN14o3Ujn8=;
        b=TPXu8+kDoC1npp9uDCVnk9DsF08rejx4fGRtl/K2RW6ycPurrwJkgzkF+VrXRKEH/gZkHa
        KpCzq8tZ7qHIskDw==
To:     Kees Cook <keescook@chromium.org>, Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned sections
In-Reply-To: <202007211143.AC36D096@keescook>
Date:   Tue, 21 Jul 2020 22:05:05 +0200
Message-ID: <87r1t43a8e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees,

Kees Cook <keescook@chromium.org> writes:
> On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>> 
>> Align the end of the .bss..page_aligned and .data..page_aligned section
>> on page-size too. Otherwise the linker might place other objects on the
>> page of the last ..page_aligned object. This is inconsistent with other
>> objects in those sections, which all have their own page.
>
> What problem was actually encountered? (i.e. why is it a problem for the
> other data to be in the page of the page-aligned data? shouldn't those
> data have their own, separate, alignment hint?)

See: lore.kernel.org/r/87sgdmm8u4.fsf@nanos.tec.linutronix.de

Thanks,

        tglx
