Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CB3D24FD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhGVNSg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhGVNSg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2021 09:18:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82173C061575;
        Thu, 22 Jul 2021 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NNcV9llPrdlEYkKe7+LBF3xFYLJpZdKYVGYe+A5Q+4I=;
        t=1626962351; x=1628171951; b=S42X4+0j590vY4yyWmE9Z6M2vfPMqU6ZVMC2NpDqG24s75X
        p0VZ8+yPU7I8uMB2QbDCZIQ7OJA8yoYCNeFdQ5UqXC/Idybgz5gps27YZ+QR3rh+AMb1OWtUbbZQm
        2ssk/Dr1IEv1rXw45C4ldEf+xi0ArjFqXXHtP9O1VtD32/0BbUZzOwRxxPBwQxOCzBnlNDCypoDZv
        9x0cWOUr/h0K/snr4No81FkSnb+J5iULPldNGBxi8glSLKV6+9yYyASglCaRxtYXNoa0fYMTjenpS
        JIUvnJ/0MIX77P07mRDjzRwlrE6v/Zn86xf+2RgfyG+F3i5gjtghrRspjZ3Pk4Cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6ZAW-0007sj-NN; Thu, 22 Jul 2021 15:57:59 +0200
Message-ID: <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        uclinux-h8-devel@lists.sourceforge.jp
Date:   Thu, 22 Jul 2021 15:57:56 +0200
In-Reply-To: <20210722124814.778059-10-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
         <20210722124814.778059-10-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> 
> The remaining architectures at the moment are: ia64, mips, parisc,
> s390, um and xtensa. We should probably convert these as well, but

I'm not sure it makes sense to convert um, the implementation uses
strncpy(), and that should use the libc implementation, which is tuned
for the actual hardware that the binary is running on, so performance
wise that might be better.

OTOH, maybe this is all in the noise given the huge syscall overhead in
um, so maybe unifying it would make more sense.

johannes

