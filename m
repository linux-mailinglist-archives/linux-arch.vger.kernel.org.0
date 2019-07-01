Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8C5C078
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGAPlP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 11:41:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39331 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGAPlO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 11:41:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so15100671qta.6;
        Mon, 01 Jul 2019 08:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX/9XC0DeimGVTmEjV3E87RMFjV7Hn7tB/e6eJ8Xuyo=;
        b=ejjtpGiH8/is5Db3IZRvRC/GCThiuYRbhxrnux/OsudS/Lq5eoufZRL8Ui/0xCR5ip
         GI0yYXoyxEBipEFfgnO+IQAAnFedM1spbpCyUh5GTJCJ5kQOlvzbYZJJQafRqWNSxTU4
         mh4yaVuQsrFexf5waUC2LzkZOkKrupYOliNq+4IPuNiS3bA28FDnoPTFe3vzvmQwq5dJ
         3bF/51inZa/2rvNkw6svo7XyhrvqMXZ2FwGo2RjI7XVnrFNBy81p1zT2U5Q2lXDW4LNL
         2IZYRqP7V+6wNMQsLm8dAyJOeQNWnR1b3s/PkMPWMQL1RNAwv5t3jPAxMQypXAQ6cS4Z
         c3Hg==
X-Gm-Message-State: APjAAAWFLipdafpmkC6gkAOXxaq5uyG28oGBqRXpJ1h+dPdafsE+ZCpQ
        3zf/DxICUAqkz2U0sJ17B6Bk/ytYBawomgUBDcA=
X-Google-Smtp-Source: APXvYqxGHBFa8P5vpjbVLPEama12INy2Pt2H83NHNiep+1vxl9TlwguBVZ4KnSLAGXloUkCXunz2yug6gKdinLc2iX0=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr20305367qtb.142.1561995673724;
 Mon, 01 Jul 2019 08:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190624054728.30966-1-hch@lst.de> <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 17:40:57 +0200
Message-ID: <CAK8P3a3YHstHAs9OsWNHTtXjHnWtQfqr=WUZTpK+bONLTWLj+w@mail.gmail.com>
Subject: Re: remove asm-generic/ptrace.h v3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 24, 2019 at 9:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 24 Jun 2019, Christoph Hellwig wrote:
> >
> > asm-generic/ptrace.h is a little weird in that it doesn't actually
> > implement any functionality, but it provided multiple layers of macros
> > that just implement trivial inline functions.  We implement those
> > directly in the few architectures and be off with a much simpler
> > design.
> >
> > I'm not sure which tree is the right place, but may this can go through
> > the asm-generic tree since it removes an asm-generic header?
>
> Makes sense.

Applied and pushed to asm-generic.git/master now, sorry for the delay.

     Arnd
