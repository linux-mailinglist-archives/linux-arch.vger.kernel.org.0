Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD52A0E55
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfH1Xlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 19:41:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33867 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfH1Xlu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 19:41:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so556255pgc.1;
        Wed, 28 Aug 2019 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEwbl1nqNHBHcJacD9dfeICHgcsBE/f/ceNiyU0uO2c=;
        b=kWxS12FOGo7kRO8bUZisQdbdPaD7m90liBO1DJILGgor5och3M3Y8ixQUrLiOlvUAQ
         KSCAKzPOIhK4qh4mkp723yecDQTzrNvHfSo5O2PLFMUzPr9tFIvttGdACmQk3GcLv9I5
         cjYvi8Gr7ER3JMRMI2IeaYoSEzfDVilJaC9VvUum/aPr5t4C5xA5idz5lFsS5zANKFcg
         337AY91x4TvIwnn1y9efIs3f4w9SNmURv9K2dvAIcHu0ypgbd+SQV2CIW7BfJIlZApXq
         u8dQIG+K1EEA2/INmvvXiOQePA1oy0eoOgbrzRogC4V4vLfCANYJbRnPt4/hj/mnM9HJ
         IDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEwbl1nqNHBHcJacD9dfeICHgcsBE/f/ceNiyU0uO2c=;
        b=Dm6bK6YON5/uJ6yGcjawkadlawzzNOu4QZ/dxM4e/ZS6ZOM3weqTqSHAvvlNt+4cL7
         bfMuHglY8fX44F7wMu5Uf+A2h+OmwcsvFW2+nAo0QTUypU2F05WBVXbfmfG12cdnTxLE
         YxzDQVlpF3VYifP8YunGgnh/0FC5P4ztnlFbuVoVeoC8PBmvCF6NJhcEO/VLuKRH3jad
         lW9WvNVzgtm1BzUDWfto0zH+/2zs7qlDbjLdIRqSGrZUaJcfUkoypEApUU3MDT7PmzEg
         70pt2B7Lsp7vPBaA40BcYnebuANLTbT8ggelkPlPmEwP+BR2lzk7ji4HI2uDK82fopA3
         MxXA==
X-Gm-Message-State: APjAAAUYMvbDkleLX03ySndy5ert+il4kq9FkW6y9/LZBMEyqWPezMyX
        nhDQRuq3AquMzIHDlmudKKjAzF9up37YUg==
X-Google-Smtp-Source: APXvYqyltBUmIDPff9MzOKVsnLKdLLLDhQKStB24jbwVvtjezQpxtP9BLXnDENuon3HqazilZSGjqw==
X-Received: by 2002:a17:90a:32a3:: with SMTP id l32mr7061863pjb.14.1567035708956;
        Wed, 28 Aug 2019 16:41:48 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id g1sm270497pgg.27.2019.08.28.16.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 16:41:48 -0700 (PDT)
Date:   Wed, 28 Aug 2019 23:41:34 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        "John F . Reiser" <jreiser@BitWagon.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: Re: [PATCH 01/11] ftrace: move recordmcount tools to scripts/ftrace
Message-ID: <20190828234133.quir3ptl4kidnxud@mail.google.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-2-changbin.du@gmail.com>
 <20190826184444.09334ae9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826184444.09334ae9@gandalf.local.home>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 26, 2019 at 06:44:44PM -0400, Steven Rostedt wrote:
> On Sun, 25 Aug 2019 21:23:20 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Move ftrace tools to its own directory. We will add another tool later.
> > 
> > Cc: John F. Reiser <jreiser@BitWagon.com>
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  scripts/.gitignore                   |  1 -
> >  scripts/Makefile                     |  2 +-
> >  scripts/Makefile.build               | 10 +++++-----
> >  scripts/ftrace/.gitignore            |  4 ++++
> >  scripts/ftrace/Makefile              |  4 ++++
> >  scripts/{ => ftrace}/recordmcount.c  |  0
> >  scripts/{ => ftrace}/recordmcount.h  |  0
> >  scripts/{ => ftrace}/recordmcount.pl |  0
> >  8 files changed, 14 insertions(+), 7 deletions(-)
> >  create mode 100644 scripts/ftrace/.gitignore
> >  create mode 100644 scripts/ftrace/Makefile
> >  rename scripts/{ => ftrace}/recordmcount.c (100%)
> >  rename scripts/{ => ftrace}/recordmcount.h (100%)
> >  rename scripts/{ => ftrace}/recordmcount.pl (100%)
> >  mode change 100755 => 100644
> 
> Note, we are in the process of merging recordmcount with objtool. It
> would be better to continue from that work.
> 
>  http://lkml.kernel.org/r/2767f55f4a5fbf30ba0635aed7a9c5ee92ac07dd.1563992889.git.mhelsley@vmware.com
> 
> -- Steve
Thanks for reminding. Let me check if prototype tool can merge into
objtool easily after above work.

-- 
Cheers,
Changbin Du
