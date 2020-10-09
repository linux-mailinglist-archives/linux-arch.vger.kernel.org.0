Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A764288D8D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgJIP7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 11:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbgJIP7p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 11:59:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D7C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 08:59:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQunu-002MfL-9X; Fri, 09 Oct 2020 17:59:34 +0200
Message-ID: <d2b67bdfa5e1b48d5faf60387904aa254b3ae8da.camel@sipsolutions.net>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Date:   Fri, 09 Oct 2020 17:59:33 +0200
In-Reply-To: <CAMoF9u2Fc2s1uitk3D3osgq1XByebxUTirq4SROcMZg9kJ_Gfw@mail.gmail.com> (sfid-20201008_225343_681111_E8A35813)
References: <cover.1601960644.git.thehajime@gmail.com>
         <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
         <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
         <CAMoF9u1XX6gJpPfUh-6hmh1RNosn+=GUf75FQsMoxacrP=f7jg@mail.gmail.com>
         <1b271e1bca9852bebc2d67c6aada25f7ce1a7240.camel@sipsolutions.net>
         <CAMoF9u2Fc2s1uitk3D3osgq1XByebxUTirq4SROcMZg9kJ_Gfw@mail.gmail.com>
         (sfid-20201008_225343_681111_E8A35813)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-10-08 at 23:53 +0300, Octavian Purdila wrote:

> Leaving the library/standalone build itself aside for a while, do you
> agree that the various tools we are building with library mode should
> be placed in tools? Things like lklfuse - mounting Linux filesystems
> with fuse, or lklhijack.so - a preload library that intercept
> network/file system calls and routes them through the library mode.

Yeah, I guess that makes sense. I realize the line gets blurry ...

OTOH, should these even live in the kernel tree? Almost seems like if
the base lkl library is there, the other stuff might not really need to
be, it's supposed to use the (stable) syscall API?

Dunno. Not sure "doesn't need to be" really is an argument for
"shouldn't be" anyway.

> > You're looking at it the other way around I think - it seems that you're
> > thinking the kernel binary is the vmlinux.a, and that's what the
> > kernel's build system worries about; then the "vmlinux.so" (library
> > mode) or "linux" (standalone mode - perhaps that's a good name?) is the
> > eventual 'tool' that we build, using the previously built vmlinux.a.
> > 
> 
> Correct, this is my perspective.
> 
> > But that really isn't how standalone mode works, and IMHO it also
> > doesn't match what tools are today.
> > 
> 
> What if we could use standalone mode for other purposes that would
> require creating a new binary in addition to the current linux binary?

Anything specific you have in mind?

But I still think that "UML standalone 'linux' binary" is something that
seems like the kernel build system should be able do? If only to avoid
regressions from what we have now ...

johannes

