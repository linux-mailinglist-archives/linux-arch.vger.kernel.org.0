Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4B2A6061
	for <lists+linux-arch@lfdr.de>; Wed,  4 Nov 2020 10:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDJQ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Nov 2020 04:16:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39662 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKDJQZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2020 04:16:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id 184so26156390lfd.6;
        Wed, 04 Nov 2020 01:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vHa0L9hPqIKNAA8VZg6vgJc8/SLe3NLGnVvTvkVfkVk=;
        b=emPlNl4PXYWZuPLDlVflH6rmh0Wimswi29hzRmuDGyWLxzpfqaBGrhQB1AyuAwQHxt
         rbqj9uMZlRZd4gOu5t9HCd/F5gwZ9xsPeK2ieGvERtTynLOMfsHvnZCIGoMMvHYmM2mz
         w43KX6iXXzZF9V1hqzlSian58sjNokxmTpshwuQXQAUglXKtN1NlbHiWlzcV1v3pr7Iu
         ZB1oDz1QrXA4i6VtxFAs/awGFLvxWtZ9t3VvmHyxN4052ctQuqBUHBu2J0pX0vmQs45P
         E787o/NrJkCClWojMhR+9Pdac9iSWttLl+JdYUEAlHT29kgd19XWJnscem2LHHvFYOdA
         SVMQ==
X-Gm-Message-State: AOAM532Rhzvx0E2yBJ8AB4RQ7CeMr1L6S4jslcZt0PEhQEaKcLyHs6lb
        J2s1vsi4C802I81H9p/AF6iLfqTcFeFmzQ==
X-Google-Smtp-Source: ABdhPJyu4jVC2hNfwNvwHRHvA7YNIxF/+i0Bqm82VLSdvNlk5MP4CQ76Sg9I3zwWhGKTSZOnvPOHhg==
X-Received: by 2002:ac2:5cb2:: with SMTP id e18mr8763204lfq.155.1604481382664;
        Wed, 04 Nov 2020 01:16:22 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q4sm345432lfn.44.2020.11.04.01.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:16:21 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kaEu1-0005oY-AD; Wed, 04 Nov 2020 10:16:25 +0100
Date:   Wed, 4 Nov 2020 10:16:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Johan Hovold <johan@kernel.org>
Subject: get_maintainer.pl bug? (was: Re: [PATCH 0/8] linker-section array
 fix and clean ups)
Message-ID: <20201104091625.GP4085@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Joe,

Running scrips/get_maintainer.pl on this series [1] gave the wrong
address for Nick Desaulniers:

	Nick Desaulniers <ndesaulniers@gooogle.com> (commit_signer:1/2=50%,commit_signer:1/8=12%)

It seems he recently misspelled his address in a reviewed-by tag to
commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
to __section("foo")") and that is now being picked up by the script.

I guess that's to be considered a bug?

> Johan Hovold (8):
>   of: fix linker-section match-table corruption
>   earlycon: simplify earlycon-table implementation
>   module: drop version-attribute alignment
>   module: simplify version-attribute handling
>   init: use type alignment for kernel parameters
>   params: drop redundant "unused" attributes
>   params: use type alignment for kernel parameters
>   params: clean up module-param macros

[1] https://lore.kernel.org/lkml/20201103175711.10731-1-johan@kernel.org/

Johan
