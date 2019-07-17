Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13696B7BF
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfGQH5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 03:57:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQH5J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 03:57:09 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hneoB-0007hY-7j; Wed, 17 Jul 2019 09:57:03 +0200
Date:   Wed, 17 Jul 2019 09:57:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mike Lothian <mike@fireburn.co.uk>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
In-Reply-To: <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de> <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 17 Jul 2019, Masahiro Yamada wrote:
> On Wed, Jul 17, 2019 at 4:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > So instead of dealing with attempts to duct tape gold support without
> > understanding the root cause and without support from the gold folks, fail
> > the build when gold is detected.
> >
> 
> The code looks OK in the build system point of view.
> 
> Please let me confirm this, just in case:
> For now, we give up all architectures, not only x86, right?

Well, that's the logical consequence of a statement which says: don't use
gold for the kernel.

> I have not not heard much from other arch maintainers.

Cc'ed linux-arch for that matter.

Thanks,

	tglx
